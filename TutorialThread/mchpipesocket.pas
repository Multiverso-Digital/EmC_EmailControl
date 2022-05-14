{ 10-05-1999 10:36:51 PM > [martin on MARTIN] checked out /Reformatting
   according to Delphi guidelines. }
{ 14-04-1999 11:59:10 PM > [martin on MARTIN] update: Changing dynamic
   methods to virtual. (0.2) /  }
{ 14-04-1999 11:53:03 PM > [martin on MARTIN] checked out /Changing dynamic
   methods to virtual. }
{ 06-04-1999 7:49:29 PM > [martin on MARTIN] checked out /Modifying Class
   Names }
unit MCHPipeSocket;

{$OVERFLOWCHECKS OFF}

{Martin Harvey 7/11/1998

  This unit does the required interfacing from the socket paradigm to the
  pipe paradigm. It does the required interfacing between the pipe threads, which may
  block, and the pipe transaction manager, which treats all events as aynchronous.

  Main points to consider are:

  DLL Loading will be handled by the session.

  We will regularly have to check the state of the reader and writer threads.
  If either of them terminates, then we need to find out why, and signal that
  as a disconnection event or error event.

  We also need to check for success during connection.

  Note that writer thread will not terminate unless it fails to write data.
  Reader thread may terminate at any time after it has stopped waiting for the
  peer to connect.

  The connection status variable tells us whether we
  are disconnected, fully connected, or waiting for the peer.
  If we are waiting for the peer, ONCP code should not attempt to send anything,
  but signal an error.

  Although we signal a connection, this will probably not be used by the ONCP
  Session. It will just check whether we are connected every time something has
  to be sent, and signal an error if we aren't.

Design modification: 15/12/98

  An additional "issue" has cropped up. It is entirely possible for an immediate
  reconnection attempt after a disconnection to mean that unhandled messages from
  the previous connection get applied to the current connection. *NOT* what we want!

  We get around this by having a "Session Number" integer, which starts at 0,
  and always increments. We only allow messages given by the current connection
  any notice.

  It is not protected, because it's only read when the reader/writer threads
  do call our callbacks, and written when the threads do not exist.

}

interface

uses Classes,MCHPipeThreads,MCHPipeTypes,MCHTransactions,
  Messages,Windows,Controls;

const
  WM_ASYNC_LAZY_READ = WM_USER + 2878;
  WM_ASYNC_TERMINATE = WM_USER + 2879;
  WM_ASYNC_CONNECT = WM_USER + 2880;

type
  psServerType = (psServer,psClient,psPeer);

  TMCHPipeConnectionStatus = (pcsNotConnected,pcsConnecting,pcsConnected);

  TMCHPipeSocket = class(TComponent)
  private
    FSockHandle:TMCHHandle;
    FHWnd:THandle;
    FReaderThread:TMCHPipeReaderThread;
    FWriterThread:TMCHPipeWriterThread;
    FOnDisconnect,FOnConnect:TNotifyEvent;
    FOnSockError:TNotifyEvent;
    FOnRead:TNotifyEvent;
    FConnected:TMCHPipeConnectionStatus;
    FManager:TMCHCustomTransactionManager;
    FServer:psServerType;
    FSessionNumber:Word;
  protected
    procedure HandleDataRecieved(Sender:TObject); {Handle data, Called in separate thread}
    procedure HandleTerminate(Sender:TObject); {Handle termination, Called in Separate Thread}
    procedure HandleConnect(Sender:TObject); {Handle peer connection, Called in separate thread}
    procedure MessageHandler(var Msg:TMessage); {Message handling loop for bridging thread gap}
    procedure DoAsyncHandleTerminate(var Msg:TMessage); {asynchronous handler}
    procedure DoAsyncHandleDataRecieved(var Msg:TMessage); {asynchronous handler}
    procedure DoAsyncHandleConnect(var Msg:TMessage); {asynchronous handler}
    procedure DoDisconnect;virtual; {Event trigger}
    procedure DoSockError;virtual; {Event trigger}
    procedure DoRead;virtual; {Event trigger}
    procedure DoConnect;virtual; {Event trigger}
    procedure StartThreads; {Sets up handles and resumes threads}
  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;
    function Connect:boolean; {Signals whether connection successful pending remote connection}
    procedure Disconnect; {Closes handles, and Frees threads}
    function ReadData(Stream:TStream):integer; {Appends new data to stream. Returns how many bytes read}
    procedure WriteData(Stream:TStream); {Writes stream data.}
  published
   {On Disconnect is to be treated by the higher layers like a dWinsock
    disconnection was in the original DOP/ONCP stuff.}
    property OnDisconnect:TNotifyEvent read FOnDisconnect write FOnDisconnect;
   {OnPipeError will normally just be handled by the transaction manager,
    which will signal OnFatalError, However, you can assign a handler if you
    want.}
    property OnSockError:TNotifyEvent read FOnSockError write FOnSockError;
    property OnRead:TNotifyEvent read FOnRead write FOnRead;
    property OnConnect:TNotifyEvent read FOnConnect write FOnConnect;
    property Connected:TMCHPipeConnectionStatus read FConnected;
    property Manager:TMCHCustomTransactionManager read FManager write FManager;
    property Server:psServerType read FServer write FServer;
  end;

implementation

uses MCHPipeInterface2,Forms,MCHPipeTransactions;

constructor TMCHPipeSocket.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FHWnd := AllocateHWnd(MessageHandler);
  FManager := TMCHPipeTransactionManager.Create;
  (FManager as TMCHPipeTransactionManager).Socket := Self;
  FSessionNumber := 0;
end;

destructor TMCHPipeSocket.Destroy;
begin
  if Assigned(FManager) then
  begin
    FManager.Free;
    FManager := nil;
  end;
  Disconnect;
  DeallocateHWnd(FHWnd);
  inherited Destroy;
end;

procedure TMCHPipeSocket.HandleDataRecieved(Sender:TObject);
begin
  PostMessage(FHwnd,WM_ASYNC_LAZY_READ,FSessionNumber,0);
end;

procedure TMCHPipeSocket.HandleTerminate(Sender:TObject);
begin
  PostMessage(FHwnd,WM_ASYNC_TERMINATE,FSessionNumber,Longint(Sender));
end;

procedure TMCHPipeSocket.HandleConnect(Sender:TObject);
begin
  PostMessage(FHwnd,WM_ASYNC_CONNECT,FSessionNumber,0);
end;

procedure TMCHPipeSocket.MessageHandler(var Msg:TMessage);
begin
{The session number check gets rid of a multitude of problems.}
{In particular, it means that we only handle the first termination
 message from the two threads... all later messages are discarded}
  if Msg.WParam = FSessionNumber then
  begin
    case Msg.Msg of
      WM_ASYNC_LAZY_READ:DoAsyncHandleDataRecieved(Msg);
      WM_ASYNC_TERMINATE:DoAsyncHandleTerminate(Msg);
      WM_ASYNC_CONNECT:DoAsyncHandleConnect(Msg);
    end;
  end;
end;

procedure TMCHPipeSocket.DoAsyncHandleTerminate(var Msg:TMessage);

var
  Sender:TObject;
  Error:TMCHError;
  OrigConnected:TMCHPipeConnectionStatus;

begin
  Sender := TObject(Msg.LParam);
{Find out termination reason}
  Error := (Sender as TMCHPipeThread).TermReason;
{Call disconnect, to disconnect everything & free both threads}
  OrigConnected := FConnected;
  Disconnect;
  if not ((Error = meClientNotConnected) or (Error = meServerNotConnected)) then
  begin
    {Serious algorithm failure}
    DoSockError;
  end
  else
  begin
    {Normal disconnection by peer}
    {Don't signal this if it's as a result of us disconnecting}
    if OrigConnected <> pcsNotConnected then DoDisconnect;
  end;
end;

procedure TMCHPipeSocket.DoAsyncHandleDataRecieved(var Msg:TMessage);
begin
{Check that we are connected and that we have a thread to read from!}
  if (FConnected = pcsConnected) and Assigned(FReaderThread) then
    DoRead;
end;

procedure TMCHPipeSocket.DoAsyncHandleConnect(var Msg:TMessage);
begin
  if FConnected = pcsConnecting then
  begin
    FConnected := pcsConnected;
    DoConnect;
  end
  else
    {Serious algorithm failure}
    DoSockError;
end;

procedure TMCHPipeSocket.DoDisconnect;
begin
  (Manager as TMCHPipeTransactionManager).HandleDisconnect;
  if Assigned(FOnDisconnect) then FOnDisconnect(Self);
end;

procedure TMCHPipeSocket.DoConnect;
begin
  (Manager as TMCHPipeTransactionManager).HandleConnect;
  if Assigned(FOnConnect) then FOnConnect(Self);
end;

procedure TMCHPipeSocket.DoSockError;
begin
  (Manager as TMCHPipeTransactionManager).HandleSockError;
  if Assigned(FOnSockError) then FOnSockError(Self);
end;

procedure TMCHPipeSocket.DoRead;
begin
  (Manager as TMCHPipeTransactionManager).HandleSockRead;
  if Assigned(FOnRead) then FOnRead(Self);
end;

function TMCHPipeSocket.Connect:boolean;
{Assumes DLL already loaded.}
begin
  if (FConnected = pcsNotConnected) then
  begin
    if Server = psServer then
      result := MCHPipeInterface2.ConnectServer(FSockHandle) = meOK
    else if Server = psClient then
      result := MCHPipeInterface2.ConnectClient(FSockHandle) = meOK
    else {Server=psPeer}
    begin
      result := MCHPipeInterface2.ConnectServer(FSockHandle) = meOK;
      if (not result) then
        result := MCHPipeInterface2.ConnectClient(FSockHandle) = meOK;
    end;
    if result then
    begin
      FConnected := pcsConnecting;
      StartThreads;
    end;
  end
  else
    result := FConnected <> pcsNotConnected;
end;

procedure TMCHPipeSocket.StartThreads;
begin
{Sets both reader and writer threads into a known state.
 This state is where all info is flushed from buffers,
 and they have just made their first read/write request
 or are waiting for the peer. }
{OVERFLOWCHECKS ARE OFF}
  Inc(FSessionNumber);
{Set session number to make socket ignore queued messages from all previous
 connections}
  FReaderThread := TMCHPipeReaderThread.Create(true);
  FWriterThread := TMCHPipeWriterThread.Create(true);
  FReaderThread.PipeReadHandle := FSockHandle;
  FWriterThread.PipeWriteHandle := FSockHandle;
  FReaderThread.OnDataRecieved := HandleDataRecieved;
  FReaderThread.OnConnect := HandleConnect;
  FReaderThread.Resume;
  FReaderThread.OnTerminate := HandleTerminate;
  FWriterThread.OnTerminate := HandleTerminate;
  FWriterThread.Resume;
end;

procedure TMCHPipeSocket.Disconnect;
begin
{Close handles}
  if MCHPipeInterface2.DisconnectClient(FSockHandle) <> meOK then
    MCHPipeInterface2.DisconnectServer(FSockHandle);
{Free threads}
{Reader thread is already unblocked}
{Writer thread may only unblock when it's destructor is called}
  if Assigned(FReaderThread) then
  begin
    with FReaderThread do
    begin
      Terminate; {Don't need to wait. Destructor calls WaitFor}
      Free;
    end;
    FReaderThread := nil;
  end;
  if Assigned(FWriterThread) then
  begin
    with FWriterThread do
    begin
      Terminate; {Don't need to wait. Destructor calls WaitFor}
      Free;
    end;
    FWriterThread := nil;
  end;
  FConnected := pcsNotConnected;
{OVERFLOWCHECKS ARE OFF}
  Inc(FSessionNumber);
end;

function TMCHPipeSocket.ReadData(Stream:TStream):integer;
begin
  if FConnected = pcsConnected then {FReader should be assigned}
    result := FReaderThread.ReadData(Stream)
  else
    result := 0;
end;

procedure TMCHPipeSocket.WriteData(Stream:TStream);
begin
  if FConnected = pcsConnected then
    FWriterThread.WriteData(Stream);
end;


end.


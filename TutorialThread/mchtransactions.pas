{ 10-05-1999 10:38:00 PM > [martin on MARTIN] checked out /Reformatting
   according to Delphi guidelines. }
{ 10-05-1999 1:31:20 AM > [martin on MARTIN] update: Including winsock
   message in fatal error (0.4) /  }
{ 08-05-1999 7:04:00 PM > [martin on MARTIN] checked out /Including winsock
   message in fatal error }
{ 14-04-1999 11:59:23 PM > [martin on MARTIN] update: Changing dynamic
   methods to virtual. (0.3) /  }
{ 14-04-1999 11:54:16 PM > [martin on MARTIN] checked out /Changing dynamic
   methods to virtual. }
{ 14-04-1999 11:19:53 PM > [martin on MARTIN] update: Modifying code that
   checks whether OK to send, so that structures can be sent to the transaction
   manager whilst the associated socket is connecting. This means that the ONCP does not require a cache. (0.2) /  }
{ 06-04-1999 9:14:07 PM > [martin on MARTIN] checked out /Modifying code
   that checks whether OK to send, so that structures can be sent to the transaction
   manager whilst the associated socket is connecting. This means that the ONCP does not require a cache. }
{ 06-04-1999 7:44:46 PM > [martin on MARTIN] checked out /Modifying class
   names }
{ 06-04-1999 1:46:40 AM > [martin on MARTIN] check in: (0.0) Initial Version
   / None }
unit MCHTransactions;

{Martin Harvey 20/10/1997

This unit implements a socket suitable for connection to
a transaction manager, and it also defines the transaction
manager.
The transaction manager is an intermediary between the socket
and the Data Object Protocol Manager

The basic structure is as follows:

TTransStreamSock<--->TMCHTransactionManager<---->TMCHDopManager
The TMCHDopManager will be left to a separate unit.
}

{
 This unit has been slightly modified. 7/11/97
 Whereas previously, the Transaction manager was created upon connection
 establishment, it is now created and destroyed at the same time as the socket
 object. However, the transaction manager now resets itself when a connection
 on the socket is created or destroyed.

 In addition, the stream socket now allows for the creation of derived classes from
 TMCHTransactionManager
 }

{ Yet more modifications, Martin Harvey 30/8/98

  Due to various requirements, like having transaction managers that save to disks
  and to pipes, I'm creating a custom ancestor class that connects to a DOP,
  and then subclasses that work with sockets, files, pipes etc etc}

interface

uses MCHMemoryStream,Classes,DWinsock,SysUtils,WSAPI;

type

  TFatalErrorEvent = procedure(Sender:TObject;Msg:string) of object;

  TMCHCustomTransactionManager = class
  private
    FOnReset:TNotifyEvent;
    FOnFatalError:TFatalErrorEvent;
    FOnDestroy:TNotifyEvent;
    FOnTransactionRecieved:TNotifyEvent;
    FDOPManager:TObject;
  protected
    procedure DoTransactionRecieved;virtual;
    procedure DoFatalError(Msg:string);virtual;
    procedure DoDestroy;virtual;
    function GetActive:boolean;virtual;abstract;
  public
    destructor Destroy;override;
    property DOPManager:TObject
      read FDOPManager
      write FDOPManager;
    property OnTransactionRecieved:TNotifyEvent
      read FOnTransactionRecieved
      write FOnTransactionRecieved;
 {informs user when it is about to be destroyed}
    property OnDestroy:TNotifyEvent
      read FOnDestroy
      write FOnDestroy;
 {informs user when a reset event is about to occur}
    property OnReset:TNotifyEvent
      read FOnReset
      write FOnReset;
    property OnFatalError:TFatalErrorEvent
      read FOnFatalError
      write FOnFatalError;
    property Active:boolean
      read GetActive;
    constructor Create;
    procedure WriteTransactionFromStream(ExternalIn:TStream);virtual;abstract;
    procedure ReadTransactionToStream(ExternalOut:TStream);virtual;abstract;
    procedure Reset;virtual;
  published
  end;

  TMCHTransactionManager = class; {forward declaration}

  TCustomManagerClass = class of TMCHCustomTransactionManager;

  TTransStreamSock = class(TStreamSocket)
  private
    FManager:TMCHCustomTransactionManager;
  protected
    {these methods normally call the parent component
    and allow delegation through the parent component to the form
    doing the delegation.
    I am overriding them to provide a direct way of letting the transaction
    manager get to the data first.}
    procedure DoAccept;override;
    procedure DoConnect;override;
    procedure DoDisconnect;override;
    procedure DoReject;override;
    procedure DoTimeout;override;
    procedure DoWrite;override;
    procedure DoRead;override;
  public
    property Manager:TMCHCustomTransactionManager read FManager write FManager;
    {connection to the manager object to allow direct access to it}
    constructor Create(AParent:TSockCtrl);override;
          {note that set manager class should only be called immediately
          after the socket is created}
    destructor Destroy;override;
  published
  end;

  TMCHTransactionManager = class(TMCHCustomTransactionManager)
  private
    FTransSock:TTransStreamSock;
    FInputStream,
      FOutputStream:
      TMCHMemoryStream;
    FReadingTransaction:boolean;
    FSocketReady:boolean;
    FReadTransactionStart,
      FReadTransactionEnd:integer;
    FWriteSocketOffset:integer;
  protected
    {offset of current transaction in read stream}
    property ReadTransactionStart:integer
      read FReadTransactionStart
      write FReadTransactionStart;
    {projected end of current transaction}
    property ReadTransactionEnd:integer
      read FReadTransactionEnd
      write FReadTransactionEnd;
    {position of writing data to socket}
    property WriteSocketOffset:integer
      read FWriteSocketOffset
      write FWriteSocketOffset;
    {stream properties}
    property InputStream:TMCHMemoryStream
      read FInputStream
      write FInputStream;
    property OutputStream:TMCHMemoryStream
      read FOutputStream
      write FOutputStream;
    {internal procedures}
    procedure TrimReadStream;
    procedure TrimWriteStream;
    {write to socket puts as many bytes as possible from ouput stream to socket,
    and returns number put}
    function WriteToSocket(Sock:TStreamSocket;Stream:TStream;pos,size:integer):integer;
    { read from socket reads as many bytes as possible to the end of the input
    stream, and returns how many bytes read}
    function ReadFromSocket(Sock:TStreamSocket;Stream:TStream):integer;
    function GetSocketReady:boolean;
    procedure ExtractTransactionsFromStream;
    function GetActive:boolean;override;
  public
    {user accessible properties}
    {owning socket}
    property TransSock:TTransStreamSock read FTransSock write FTransSock;
    {Reading side of things}
    {user event notifying that a transaction is ready}
    {note: this is the only chance that external code
    has of picking up the transaction, pointers are automatically incremented
    afterwards! (This may be changed later)}
    property OnTransactionRecieved;
    {informs user when it is about to be destroyed}
    property OnDestroy;
    {informs user when a reset event is about to occur}
    property OnReset;
    { an unfinished transaction is in the read stream }
    { This does not preclude a very short transaction
    existing. (ie header is too short to read length}
    { This property doesn't have a write specifier,
      so external objects can't modify it}
    property ReadingTransaction:boolean
      read FReadingTransaction;
    { The socket ready property is used to ensure that
    only one send operation is called for every OnWrite event}
    property SocketReady:boolean
      read GetSocketReady;
    property Active;
    {constructor and destructor.
    These do not need to be called manually, since the
    owning socket will take care of this }
    constructor Create;
    destructor Destroy;override;
    {user methods for writing transactions}
    { The input stream should contain all the data for one transaction}
    { Note that the outside agent owns the external stream}
    procedure WriteTransactionFromStream(ExternalIn:TStream);override;
    {user methods for reading transactions}
    {The output stream contains a copy of the transaction data
     This should be called externally when an OnTransactionRecieved event occurs}
     {Note that the outside agent owns the external stream}
    procedure ReadTransactionToStream(ExternalOut:TStream);override;
    {methods for owning socket to call.
    The user should *not* call these!!}
    {writing side of things}
    procedure WriteDataRemainder;
    {reading side}
    procedure ReadNewData;
    { a reset procedure to be used when the connection underlying the socket has
     been closed}
    procedure Reset;override;
  published
    property OnFatalError;
  end;

implementation

uses MCHDOPManager,Dialogs;

constructor TMCHCustomTransactionManager.Create;
begin
  inherited Create;
  DOPManager := TMCHDopManager.Create;
  (DOPManager as TMCHDopManager).DOPTransactionManager := Self;
end;

destructor TMCHCustomTransactionManager.Destroy;
begin
  DoDestroy;
  DOPManager.Free;
  DOPManager := nil;
  inherited Destroy;
end;

procedure TMCHCustomTransactionManager.DoFatalError(Msg:string);
begin
  if Assigned(FOnFatalError) then FOnFatalError(Self,Msg);
end;

procedure TMCHCustomTransactionManager.Reset;
begin
  if Assigned(DOPManager) then
    (DOPManager as TMCHDopManager).Reset;
  if Assigned(FOnReset) then FOnReset(Self);
end;

procedure TMCHCustomTransactionManager.DoTransactionRecieved;
begin
  if (Assigned(FOnTransactionRecieved)) then
    FOnTransactionRecieved(Self);
  try
    if Assigned(DOPManager) then
      (DOPManager as TMCHDopManager).GetIncomingTransaction(Self);
  except
    on E:ENetworkError do begin
      ShowMessage('Exception raised on remote machine, '
        + E.RemoteExceptionName + ' ' +
        E.Message);
    end;
  end;
end;

procedure TMCHCustomTransactionManager.DoDestroy;
begin
  if (Assigned(FOnDestroy)) then
    FOnDestroy(Self);
end;


procedure TTransStreamSock.DoAccept;
begin
  if LastError = 0 then
  begin
    if Assigned(Manager) then
      Manager.Reset;
  end;
  inherited DoAccept;
end;

procedure TTransStreamSock.DoConnect;
begin
{Note that this has been modified. We now only
 reset the transaction manager if the connection *fails*}
  if LastError <> 0 then
  begin
    if Assigned(Manager) then
      Manager.Reset;
  end;
  inherited DoConnect;
end;

procedure TTransStreamSock.DoDisconnect;
begin
  if Assigned(Manager) then
    Manager.Reset;
  inherited DoDisconnect;
end;

procedure TTransStreamSock.DoReject;
begin
  if Assigned(Manager) then
    Manager.Reset;
  inherited DoReject;
end;

procedure TTransStreamSock.DoTimeOut;
begin
  if Assigned(Manager) then
    Manager.Reset;
  inherited DoTimeOut;
end;

procedure TTransStreamSock.DoWrite;
begin
  if Assigned(Manager) then
    (Manager as TMCHTransactionManager).WriteDataRemainder;
  inherited DoWrite;
end;

procedure TTransStreamSock.DoRead;
begin
  if Assigned(Manager) then
    (Manager as TMCHTransactionManager).ReadNewData;
  inherited DoRead;
end;

destructor TTransStreamSock.Destroy;
begin
  if Assigned(Manager) then
  begin
    Manager.Free;
    Manager := nil;
  end;
  inherited Destroy;
end;

constructor TTransStreamSock.Create(AParent:TSockCtrl);
begin
  inherited Create(AParent);
  Manager := TMCHTransactionManager.Create;
  (Manager as TMCHTransactionManager).TransSock := Self;
end;


function TMCHTransactionManager.GetSocketReady:boolean;
begin
  result := FTransSock.Connected and FSocketReady;
end;

{$WARNINGS OFF}

function TMCHTransactionManager.ReadFromSocket(Sock:TStreamSocket;Stream:TStream):integer;

const
  blocksize = 4096;
var
  databuf:array[0..blocksize - 1] of byte;
  TotalBytesRead,BytesRead:integer;

begin
  Stream.Seek(0,SoFromEnd); {seek to the end of the input stream}
  TotalBytesRead := 0;
  repeat
    try
      BytesRead := Sock.Recv(databuf,blocksize);
    except
      on E:ESockError do begin
        DoFatalError(E.Message);
        BytesRead := 0;
      end;
    end;
    Stream.WriteBuffer(Databuf,BytesRead);
    TotalBytesRead := TotalBytesRead + BytesRead;
  until BytesRead < blocksize;
  result := TotalBytesRead;
end;

{$WARNINGS ON}

constructor TMCHTransactionManager.Create;
begin
  inherited Create;
  FInputStream := TMCHMemoryStream.Create;
  FOutputStream := TMCHMemoryStream.Create;
end;

destructor TMCHTransactionManager.Destroy;
begin
  FInputStream.Free;
  FOutputStream.Free;
  inherited Destroy;
end;

function TMCHTransactionManager.GetActive:boolean;
begin
  result := true;
  if (WriteSocketOffset = OutputStream.Size)
    and (ReadTransactionStart = InputStream.Size)
    and (not ReadingTransaction)
    then result := false;
end;


procedure TMCHTransactionManager.Reset;
{This procedure resets all pointers and clears the stream}
begin
  inherited Reset;
  ReadTransactionStart := 0;
  ReadTransactionEnd := 0;
  WriteSocketOffset := 0;
  FReadingTransaction := false;
  InputStream.SetSize(0);
  OutputStream.SetSize(0);
end;

procedure TMCHTransactionManager.ReadNewData;

var
  TransLength:integer;

begin
  ReadFromSocket(TransSock,InputStream);
  if (not (ReadingTransaction)) then
{ No transactions pending, Read Start & Read End point to same place}
  begin
    if (InputStream.Size >= (ReadTransactionEnd + SizeOf(TransLength))) then
    begin
      InputStream.Seek(ReadTransactionEnd,soFromBeginning);
      InputStream.ReadBuffer(TransLength,SizeOf(TransLength));
      ReadTransactionStart := InputStream.Position;
      ReadTransactionEnd := ReadTransactionStart + TransLength;
      FReadingTransaction := true;
    end;
  end;
  ExtractTransactionsFromStream;
end;

procedure TMCHTransactionManager.ExtractTransactionsFromStream;

var
  TransLength:integer;

begin
{do we have a complete transaction?}
  while ((ReadTransactionEnd <= InputStream.Size) and ReadingTransaction) do
  begin
    {we have a complete pending transaction}
    DoTransactionRecieved; {this will pick the transaction up if the user assigns a handler}
    {now advance pointers to the next transaction}
    ReadTransactionStart := ReadTransactionEnd;
    if (InputStream.Size >= ReadTransactionStart + SizeOf(TransLength)) then
    begin
      {we at least have the integer transaction length}
      InputStream.Seek(ReadTransactionEnd,soFromBeginning);
      InputStream.ReadBuffer(TransLength,SizeOf(TransLength));
      ReadTransactionStart := InputStream.Position;
      ReadTransactionEnd := ReadTransactionStart + TransLength;
      {now we know where the transaction ends and the pointers are valid}
    end
    else
      {we don't have anything to work with}
      FReadingTransaction := false;
  end;
  TrimReadStream;
end;


procedure TMCHTransactionManager.TrimReadStream;

const
  MinStreamSize = 1024;

var
  NewStream:TMCHMemoryStream;

begin
{General policy here:
If more than 4/5 of the stream is not used, then clear it up.
In all cases, all data before ReadTransactionStart can be discarded
if stream less than 1k, then don't bother.
}
  if (((InputStream.Size - ReadTransactionStart) * 5) < InputStream.Size)
    and (InputStream.Size > MinStreamSize) then
  begin
    NewStream := TMCHMemoryStream.Create;
    { do the work}
    {copy data from old to new stream}
    InputStream.Seek(ReadTransactionStart,soFromBeginning);
    if (InputStream.Size - ReadTransactionStart) > 0 then
      NewStream.CopyFrom(InputStream,(InputStream.Size - ReadTransactionStart));
    {Swap stream ownership and destroy old stream}
    InputStream.Free;
    InputStream := NewStream;
    {reset pointers accordingly}
    ReadTransactionEnd := ReadTransactionEnd - ReadTransactionStart;
    ReadTransactionStart := 0;
  end;
end;


procedure TMCHTransactionManager.ReadTransactionToStream(ExternalOut:TStream);
{This will copy the current transaction, but will not modify any pointers}
begin
  InputStream.Seek(ReadTransactionStart,soFromBeginning);
  ExternalOut.CopyFrom(InputStream,ReadTransactionEnd - ReadTransactionStart);
end;

{$WARNINGS OFF}

function TMCHTransactionManager.WriteToSocket(Sock:TStreamSocket;Stream:TStream;pos,size:integer):integer;

const
  blocksize = 4096;

var
  databuf:array[0..blocksize - 1] of byte;
  TotalBytesWritten,BytesWritten,BlockBytesToWrite,BytesToWrite:integer;

{write as much as we can to the socket until it's full}

begin
  Stream.Seek(pos,soFromBeginning);
  BytesToWrite := size;
  TotalBytesWritten := 0;
  repeat
    if BytesToWrite > blocksize then
      BlockBytesToWrite := blocksize
    else
      BlockBytesToWrite := BytesToWrite;
    Stream.ReadBuffer(databuf,BlockBytesToWrite);
    try
      BytesWritten := Sock.Send(databuf,BlockBytesToWrite);
    except
      on E:ESockError do
      begin
        DoFatalError(E.Message);
        BytesWritten := 0;
      end;
    end;
    TotalBytesWritten := TotalBytesWritten + BytesWritten;
    BytesToWrite := BytesToWrite - BytesWritten
  until (BytesToWrite = 0) or (BytesWritten < BlockBytesToWrite);
  result := TotalBytesWritten;
end;

{$WARNINGS ON}

procedure TMCHTransactionManager.WriteDataRemainder;

var
  BytesWritten:integer;
  BytesToWrite:integer;

begin
  FSocketReady := true;
{socket is ready for more data to be written}
  BytesToWrite := OutputStream.Size - WriteSocketOffset;
  if BytesToWrite > 0 then
  begin
     {write as much as we can}
    BytesWritten := WriteToSocket(TransSock,OutputStream,WriteSocketOffset,BytesToWrite);
    WriteSocketOffset := WriteSocketOffset + BytesWritten;
    if BytesWritten < BytesToWrite then
      FSocketReady := false;
      { we'll get a callback ready for more data}
  end;
  TrimWriteStream;
end;


procedure TMCHTransactionManager.TrimWriteStream;

const
  MinStreamSize = 1024;

var
  NewStream:TMCHMemoryStream;

begin
{Same general policy as for trimming the read stream}
  if (((OutputStream.Size - WriteSocketOffset) * 5) < OutputStream.Size) and (OutputStream.Size > MinStreamSize) then
  begin
    NewStream := TMCHMemoryStream.Create;
    try
      {copy}
      OutputStream.Seek(WriteSocketOffset,soFromBeginning);
      if (OutputStream.Size - WriteSocketOffset) > 0 then
        NewStream.CopyFrom(OutputStream,(OutputStream.Size - WriteSocketOffset));
      {Swap ownership & destroy}
      OutputStream.Free;
      OutputStream := TMCHMemoryStream.Create;
      OutputStream.LoadFromStream(NewStream);
      WriteSocketOffset := 0;
    finally
      NewStream.Free;
    end;
  end;
end;


procedure TMCHTransactionManager.WriteTransactionFromStream(ExternalIn:TStream);

var
  Length:integer;

begin
{ write length data to output stream }
  Length := ExternalIn.Size;
  OutputStream.Seek(0,soFromEnd);
  OutputStream.WriteBuffer(Length,SizeOf(Length));
  ExternalIn.Seek(0,soFromBeginning);
  OutputStream.CopyFrom(ExternalIn,ExternalIn.Size);
  if SocketReady then
    WriteDataRemainder;
   {only force a send if the socket is empty and connected}
end;

end.


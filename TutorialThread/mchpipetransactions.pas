{ 27-07-1999 12:46:19 AM > [martin on MARTIN] update: Bugfixing (0.5) /  }
{ 26-07-1999 12:05:12 AM > [martin on MARTIN] checked out /Bugfixing }
{ 10-05-1999 10:37:11 PM > [martin on MARTIN] checked out /Reformatting
   according to Delphi guidelines. }
{ 10-05-1999 1:31:11 AM > [martin on MARTIN] update: Modifying to allow
   for improved error mechanism (0.3) /  }
{ 08-05-1999 8:16:25 PM > [martin on MARTIN] checked out /Modifying to
   allow for improved error mechanism }
{ 14-04-1999 11:59:15 PM > [martin on MARTIN] update: Changing dynamic
   methods to virtual. (0.2) /  }
{ 14-04-1999 11:53:38 PM > [martin on MARTIN] checked out /Changing dynamic
   methods to virtual. }
{ 06-04-1999 7:49:50 PM > [martin on MARTIN] checked out /Modifying Class
   Names }
{ 06-04-1999 1:46:39 AM > [martin on MARTIN] check in: (0.0) Initial Version
   / None }
unit MCHPipeTransactions;

{Martin Harvey 2/12/98}

{A transaction manager suitable for the Pipe socket object.

I'm not toally happy with the original error handling architecture, and since
I have to completely rewrite most of the ONCP stuff anyway, I might as well
temporarily clear the situation up.

Reset will reset the transaction manager and DOPManager. It will not touch the
underlying socket, which will be handled by the PipeONCPSession.

OnDisconnect will be handled by the ONCP and triggered when the socket indicates
disconnection.
OnFatalError will also be handled by the ONCP. However, it will trigger an automatic
call to reset.

}

interface

uses MCHTransactions,Classes,MCHMemoryStream,MCHPipeSocket;

type
  TMCHPipeTransactionManager = class(TMCHCustomTransactionManager)
  private
    FIncomingStream:TMCHMemoryStream;
    FSocket:TMCHPipeSocket;
    FTransactionStart,FTransactionEnd:integer;
  protected
    function GetActive:boolean;override;
    procedure DoFatalError(Msg:string);override;
  public
    constructor Create;
    destructor Destroy;override;
    procedure WriteTransactionFromStream(ExternalIn:TStream);override;
    procedure ReadTransactionToStream(ExternalOut:TStream);override;
    procedure Reset;override;
    {Socket handlers. Note that these are
    automatically called by TMCHPipeSocket}
    procedure HandleConnect;
    procedure HandleDisconnect;
    procedure HandleSockError;
    procedure HandleSockRead;
  published
    property Socket:TMCHPipeSocket read FSocket write FSocket;
    property OnFatalError;
  end;

{NB: Events that I can trigger are:

     procedure DoTransactionRecieved;virtual;
     procedure DoFatalError;virtual;
     procedure DoDestroy;virtual;
}
implementation

constructor TMCHPipeTransactionManager.Create;
begin
  inherited Create; {TMCHCustomTransactionManager.Create creates DOPManager}
  FIncomingStream := TMCHMemoryStream.Create;
end;

function TMCHPipeTransactionManager.GetActive:boolean;
begin
  Result := FIncomingStream.Size > 0;
end;

destructor TMCHPipeTransactionManager.Destroy;
begin
  FIncomingStream.Free;
  inherited Destroy;
end;

procedure TMCHPipeTransactionManager.DoFatalError(Msg:string);
begin
  Reset;
  inherited DoFatalError(Msg);
end;

procedure TMCHPipeTransactionManager.WriteTransactionFromStream(ExternalIn:TStream);

var
  InStream:TMCHMemoryStream;
  Size:integer;

begin
  InStream := TMCHMemoryStream.Create;
  try
    Size := ExternalIn.Size;
    InStream.WriteBuffer(Size,SizeOf(Size));
    ExternalIn.Seek(0,soFromBeginning);
    InStream.CopyFrom(ExternalIn,ExternalIn.Size);
    Socket.WriteData(InStream);
  finally
    InStream.Free;
  end;
end;

procedure TMCHPipeTransactionManager.ReadTransactionToStream(ExternalOut:TStream);

begin
{At this point, just copy the required amount of data}
  FIncomingStream.Seek(FTransactionStart,soFromBeginning);
  ExternalOut.CopyFrom(FIncomingStream,FTransactionEnd - FTransactionStart);
end;

procedure TMCHPipeTransactionManager.Reset;
begin
  FIncomingStream.Clear;
  inherited Reset;
end;

procedure TMCHPipeTransactionManager.HandleConnect;
begin
  Reset;
end;

procedure TMCHPipeTransactionManager.HandleDisconnect;
begin
  Reset;
end;

procedure TMCHPipeTransactionManager.HandleSockError;
begin
  Reset;
end;

procedure TMCHPipeTransactionManager.HandleSockRead;

var
  TempStream:TMCHMemoryStream;
  TrimFrom:integer;

begin
  {Copy as much data as possible onto the end of our internal buffer}
  FSocket.ReadData(FIncomingStream);
  {Now see how many transactions we can extract}
  TrimFrom := 0;
  FTransactionStart := SizeOf(FTransactionEnd); {Start index at end of size field}
  while FIncomingStream.Size >= (FTransactionStart) do
  begin
    FIncomingStream.Seek(FTransactionStart - SizeOf(FTransactionEnd),soFromBeginning);
    FIncomingStream.ReadBuffer(FTransactionEnd,SizeOf(FTransactionEnd)); {read transaction size}
    FTransactionEnd := FTransactionEnd + FTransactionStart; {Transaction end now at correct offset}
    if FIncomingStream.Size >= FTransactionEnd then
    begin
      DoTransactionRecieved; {This will hopefully call ReadTransactionToStream}
      TrimFrom := FTransactionEnd;
    end;
    {Now need to update readtransactionstart}
    FTransactionStart := FTransactionEnd + SizeOf(FTransactionEnd);
  end;
  {At which point we have read all the data we can}
  {Now need to remove all non required data}
  {Now copy all data from TrimFrom onwards into new stream}
  if TrimFrom > 0 then
  begin
    TempStream := TMCHMemoryStream.Create;
    try
      FIncomingStream.Seek(TrimFrom,soFromBeginning);
      if TrimFrom < FIncomingStream.Size then
        TempStream.CopyFrom(FIncomingStream,FIncomingStream.Size - TrimFrom);
    finally
      FIncomingStream.Free;
      FIncomingStream := TempStream;
    end;
  end;
end;

end.


{ 10-05-1999 10:37:03 PM > [martin on MARTIN] checked out /Reformatting
   according to Delphi guidelines. }
{ 06-04-1999 7:49:40 PM > [martin on MARTIN] checked out /Modifying Class
   Names }
unit MCHPipeThreads;

{Martin Harvey 7/11/98}

{This unit gives us a base pipe thread type with some common support for
error tracking}

interface

uses Classes,MCHPipeTypes,Windows,MCHMemoryStream;

type
  TMCHPipeThread = class(TThread)
  private
    FOnTerminate:TNotifyEvent;
  protected
    FTermReason:TMCHError;
  public
    procedure Execute;override;
  published
    property TermReason:TMCHError read FTermReason;
    property OnTerminate:TNotifyEvent read FOnTerminate write FOnTerminate;
  end;

  TMCHPipeWriterThread = class(TMCHPipeThread)
  private
    FDataMutex,FIdleSemaphore:THandle;
    FPipeWriteHandle:TMCHHandle;
    FData:TMCHMemoryStream;
    FWriteIdx:integer;
  protected
  public
    constructor Create(CreateSuspended:boolean);
    procedure Execute;override;
    destructor Destroy;override;
    function WriteData(InStream:TStream):integer; {returns bytes written = InStream.Size}
    property PipeWriteHandle:TMCHHandle read FPipeWriteHandle write FPipeWriteHandle;
  end;

  TMCHPipeReaderThread = class(TMCHPipeThread)
  private
      { Private declarations }
    FDataMutex:THandle;
    FPipeReadHandle:TMCHHandle;
    FData:TMCHMemoryStream;
    FOnDataRecieved:TNotifyEvent;
    FOnConnect:TNotifyEvent;
  protected
  public
    constructor Create(CreateSuspended:boolean);
    procedure Execute;override;
    destructor Destroy;override;
    function ReadData(OutStream:TStream):integer; {returns bytes read}
    property OnDataRecieved:TNotifyEvent read FOnDataRecieved write FOnDataRecieved;
    property PipeReadHandle:TMCHHandle read FPipeReadHandle write FPipeReadHandle;
    property OnConnect:TNotifyEvent read FOnConnect write FOnConnect;
  end;

implementation

uses MCHPipeInterface2;

const
  BufSize = 4096;

type
  DataBuf = array[0..BufSize - 1] of integer;

procedure TMCHPipeThread.Execute;
begin
  if Assigned(FOnTerminate) then FOnTerminate(Self);
end;

constructor TMCHPipeReaderThread.Create(CreateSuspended:boolean);
begin
  inherited Create(CreateSuspended);
  FDataMutex := CreateMutex(nil,false,nil);
  FData := TMCHMemoryStream.Create;
end;

destructor TMCHPipeReaderThread.Destroy;
begin
  Terminate;
  if Suspended then Resume;
  WaitFor;
  FData.Free;
  CloseHandle(FDataMutex);
  inherited Destroy;
end;

function TMCHPipeReaderThread.ReadData(OutStream:TStream):integer;

begin
  WaitForSingleObject(FDataMutex,INFINITE);
  try
    OutStream.Seek(0,soFromEnd);
    FData.Seek(0,soFromBeginning);
    Result := FData.Size;
    OutStream.CopyFrom(FData,FData.Size);
    FData.Clear;
  finally
    ReleaseMutex(FDataMutex);
  end;
end;

procedure TMCHPipeReaderThread.Execute;

var
  Buffer:DataBuf;
  BytesToRead,BytesThisTime:integer;

begin
  FTermReason := WaitForPeer(FPipeReadHandle);
  if FTermReason <> meOK then
    terminate
  else
    if Assigned(FOnConnect) then FOnConnect(Self);
  while not terminated do
  begin
    FTermReason := PeekData(FPipeReadHandle,BytesToRead);
    if FTermReason <> meOK then
      terminate;
    if (not terminated) then
    begin
      if BytesToRead <= 0 then
      begin
        {Callback handler should implement lazy async notification}
        if Assigned(FOnDataRecieved) then FOnDataRecieved(Self);
        BytesToRead := 1;
      end;
      if BytesToRead > BufSize then
        BytesThisTime := BufSize
      else
        BytesThisTime := BytesToRead;
      FTermReason := MCHPipeInterface2.ReadData(FPipeReadHandle,Buffer,BytesThisTime);
      if FTermReason <> meOK then
        terminate
      else
      begin
        WaitForSingleObject(FDataMutex,INFINITE);
        FData.Seek(0,soFromEnd);
        FData.WriteBuffer(Buffer,BytesThisTime);
        ReleaseMutex(FDataMutex);
      end;
    end;
  end;
  inherited Execute;
end;

constructor TMCHPipeWriterThread.Create(CreateSuspended:boolean);
begin
  inherited Create(CreateSuspended);
  FDataMutex := CreateMutex(nil,false,nil);
  FIdleSemaphore := CreateSemaphore(nil,0,High(Integer),nil);
  FData := TMCHMemoryStream.Create;
end;

destructor TMCHPipeWriterThread.Destroy;
begin
  Terminate;
  ReleaseSemaphore(FIdleSemaphore,1,nil);
  if Suspended then Resume;
  WaitFor;
  FData.Free;
  CloseHandle(FDataMutex);
  inherited Destroy;
end;

function TMCHPipeWriterThread.WriteData(InStream:TStream):integer;

begin
  InStream.Seek(0,soFromBeginning);
  WaitForSingleObject(FDataMutex,INFINITE);
  try
    Result := InStream.Size;
    FData.Seek(0,soFromEnd);
    FData.CopyFrom(InStream,InStream.Size);
  finally
    ReleaseMutex(FDataMutex);
  end;
  ReleaseSemaphore(FIdleSemaphore,1,nil);
end;

procedure TMCHPipeWriterThread.Execute;

var
  Buf:DataBuf;
  BytesThisTime,BytesToWrite:integer;

begin
  while not (terminated) do
  begin
    WaitForSingleObject(FDataMutex,INFINITE);
    BytesToWrite := FData.Size - FWriteIdx;
    ReleaseMutex(FDataMutex);
    while (BytesToWrite > 0) and (not terminated) do
    begin
      if BytesToWrite > BufSize then
        BytesThisTime := BufSize
      else
        BytesThisTime := BytesToWrite;
      WaitForSingleObject(FDataMutex,INFINITE);
      FData.Seek(FWriteIdx,soFromBeginning);
      FData.ReadBuffer(Buf,BytesThisTime);
      ReleaseMutex(FDataMutex);
      {Note that we should not block when we have the mutex!}
      FTermReason := MCHPipeInterface2.WriteData(FPipeWriteHandle,Buf,BytesThisTime);
      if (FTermReason = meOK) then
      begin
        BytesToWrite := BytesToWrite - BytesThisTime;
        FWriteIdx := FWriteIdx + BytesThisTime;
      end
      else
        terminate;
    end;
    if (not (terminated)) then
    begin
      WaitForSingleObject(FDataMutex,INFINITE);
      {Cannot be sure that the stream hasn't been written to in the meantime!}
      {When the expression below is false, the wait on the idle semaphore
       will not block, so the stream should not get unnecessarily large}
      if FWriteIdx = FData.Size then
      begin
        FData.Clear;
        FWriteIdx := 0;
      end;
      ReleaseMutex(FDataMutex);
      WaitForSingleObject(FIdleSemaphore,INFINITE);
    end;
  end;
  inherited Execute;
end;

end.


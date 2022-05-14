{ 6/10/00 11:34:50 PM > [martin on PERGOLESI] update:  (0.6) /  }
{ 27-07-1999 2:03:56 AM > [martin on MARTIN] update: Removing unneeded
   "uses" (0.5) /  }
{ 10-05-1999 11:59:56 PM > [martin on MARTIN] update: Reformatting according
   to Delphi guidelines. (0.4) /  }
{ 19-04-1999 8:19:01 PM > [martin on MARTIN] update: Inserting proper
   constant for SEMAPHORE_ALL_ACCESS (0.3) /  }
{ 08-04-1999 11:29:11 PM > [martin on MARTIN] update: Removed debug checks
   (0.2) /  }
{ 08-04-1999 11:10:15 PM > [martin on MARTIN] check in: (0.1) Initial
   Version /  }
library MCHPipe;

{Martin Harvey 23/8/98
 A simple pipe library}

{Note to the casual reader: There are synchronisation subtleties here,
 particularly with respect to blocking status variables. A good texbook on
 operating system theory is a prerequisite.

 The good news is that this code displays a 4 fold symmetry:

 1. The treatment of clients and servers is identical
    (with respect to handle checks). (2)
 2. The treatment of reads and writes is identical
    (with respect to blocking). (2*2=4)

 As a result, I've folded everything up into a set of "generic" procedures.

 The DLL currently only provides one bidirectional pipe. That's because it's all
 I currently need.

 It is expected that a typical use of this DLL will result in
 up to 6 threads being present in the DLL at any one time:

 1. Client reader and writer threads.
 2. Server reader and writer threads.
 3. Client and server set-up and tear-down threads.

 Note that pipes cannot be written to or read from unless both client and server
 are connected.}

{Improvement MCH 7/11/1998.
 In order to eliminate polling, a "WaitForPeer" function has been added.
 This function enables a reader thread to wait for the corresponding writer to
 connect, thus ensuring that the creation and startup of the reader thread does
 not have to be polled}

uses
  Windows,
  MCHPipeTypes in 'MCHPipeTypes.pas';

const
  BufSize = 4096;
  MapName = 'MCHGlobalPipeMap';
  GlobalLockName = 'MCHGlobalPipeLock';
  Cli2ServLockName = 'MCHCli2ServLock';
  Serv2CliLockName = 'MCHServ2CliLock';
  ServPeerWaitSemName = 'MCHServPeerSem';
  CliPeerWaitSemName = 'MCHCliPeerSem';
  Cli2ServReaderSemName = 'MCHCli2ServReaderSem';
  Cli2ServWriterSemName = 'MCHCli2ServWriterSem';
  Serv2CliReaderSemName = 'MCHServ2CliReaderSem';
  Serv2CliWriterSemName = 'MCHServ2CliWriterSem';
  SEMAPHORE_ALL_ACCESS = STANDARD_RIGHTS_REQUIRED or SYNCHRONIZE or 3;
{ From SRC Modula-3 NT header files. The SEMAPHORE_ALL_ACCESS macro is missing
 from windows.pas}

type
  {Misc definitions}
  PByte = ^Byte;

(******************************************************************************)

  {Definition of global data structures which are shared via a memory mapped file
  without a disk image}
  TCycBuf = array[0..BufSize - 1] of byte;
  TDataBuf = record
    ReadPtr: integer;
    WritePtr: integer;
    CycBuf: TCycBuf;
  end;

  TPipe = record
    Buf: TDataBuf;
    ReaderBlocked, WriterBlocked: boolean; {bools to allow for checking before signalling}
  end;
  TBiDirPipe = record
    Cli2ServPipe: TPipe;
    Serv2CliPipe: TPipe;
    ServConnected, CliConnected: boolean; {check connections}
    ServPeerWait, CliPeerWait: boolean; {wait for peer variables}
    ServHandle, CliHandle: TMCHHandle; {handles for reading/writing}
  end;
  PBiDirPipe = ^TBiDirPipe;

(******************************************************************************)

  {definition of local data structures, which consist of synchronisation
   handles initialised by creating or getting handles to named objects}

  TPipeLocks = record
    PipeLock: THandle; {data Mutex}
    ReaderSem, WriterSem: THandle; {semaphores to block operations}
  end;
  PPipeLocks = ^TPipeLocks;
  TBiDirPipeLocks = record
    Cli2ServLocks: TPipeLocks;
    Serv2CliLocks: TPipeLocks;
    ServPeerWaitSem, CliPeerWaitSem: THandle; {wait for peer semaphores}
    BiLock: THandle; {global Mutex}
    MapHandle: THandle;
  end;
  PBiDirPipeLocks = ^TBiDirPipeLocks;

var
  BiDirPipe: PBiDirPipe; {pointer to global shared memory}
  BiDirPipeLocks: TBiDirPipeLocks; {local instance of nested record of synchronisation structures}

{Note on semaphore / mutex ordering:

 1. First global mutex must be aquired.
 2. Then data mutex must be aquired
 3. Releases must occur in the same order
 4. One should not block on the semaphores when holding any mutexes.

 If these rules are not respected, deadlock will occur.
 See a decent O/S theory textbook for more explanation of synchronisation primitives}


{procedures and functions to do with maintaining the cyclic buffers}

procedure InitBuf(var DataBuf: TDataBuf);
begin
  with DataBuf do
  begin
    ReadPtr := 0;
    WritePtr := 0;
  end;
end;

function EntriesUsed(var DataBuf: TDataBuf): integer;
begin
  with DataBuf do
  begin
    if WritePtr >= ReadPtr then
      result := WritePtr - ReadPtr
    else
      result := BufSize - (ReadPtr - WritePtr);
  end;
end;

function EntriesFree(var DataBuf: TDataBuf): integer;

{Note that we have introduced an asymmetry here, to ensure
 that we never completely fill up the buffer}

begin
  with DataBuf do
  begin
    if WritePtr >= ReadPtr then
      result := BufSize - (WritePtr - ReadPtr)
    else
      result := ReadPtr - WritePtr;
  end;
  dec(result);
end;

procedure GetEntries(var DataBuf: TDataBuf; var Dest; Count: integer);

var
  Write: PByte;
  Iter: integer;

begin
  Write := @Dest;
  with DataBuf do
  begin
    if EntriesUsed(DataBuf) >= Count then
    begin
      for iter := 0 to Count - 1 do
      begin
        Write^ := CycBuf[ReadPtr];
        ReadPtr := (ReadPtr + 1) mod BufSize;
        Inc(Write);
      end;
    end;
  end;
end;

procedure AddEntries(var DataBuf: TDataBuf; var Src; Count: integer);

var
  Read: PByte;
  Iter: integer;

begin
  Read := @Src;
  with DataBuf do
  begin
    if EntriesFree(DataBuf) >= Count then
    begin
      for iter := 0 to Count - 1 do
      begin
        CycBuf[WritePtr] := Read^;
        WritePtr := (WritePtr + 1) mod BufSize;
        Inc(Read);
      end;
    end;
  end;
end;

{Connection and disconnection functions. Disconnection should always unblock
 everything}

function GenericConnect(var hHandle: TMCHHandle; Server: boolean): TMCHError;
{Returns error if server already connected}
begin
  result := meOK;
  {Get the global mutex}
  WaitForSingleObject(BiDirPipeLocks.BiLock, INFINITE);
  if Server then
  begin
    if BiDirPipe.ServConnected then
      result := meAlreadyConnected
    else
    begin
      hHandle := BiDirPipe.ServHandle;
      BiDirPipe.ServConnected := true;
      {Now think about peer unblocking functions}
      with BiDirPipe^ do
      begin
        if CliConnected and CliPeerWait then
        begin
          {Unblock client}
          CliPeerWait := FALSE;
          ReleaseSemaphore(BiDirPipeLocks.CliPeerWaitSem, 1, nil);
        end;
      end;
    end;
  end
  else
  begin
    if BiDirPipe.CliConnected then
      result := meAlreadyConnected
    else
    begin
      hHandle := BiDirPipe.CliHandle;
      BiDirPipe.CliConnected := true;
      with BiDirPipe^ do
      begin
        if ServConnected and ServPeerWait then
        begin
          {Unblock server}
          ServPeerWait := FALSE;
          ReleaseSemaphore(BiDirPipeLocks.ServPeerWaitSem, 1, nil);
        end;
      end;
    end;
  end;
  ReleaseMutex(BiDirPipeLocks.BiLock);
end;

function GenericDisconnect(hHandle: TMCHHandle; Server: boolean): TMCHError;
{Returns error if server not connected, or bad handle}

begin
  result := meOK;
  WaitForSingleObject(BiDirPipeLocks.BiLock, INFINITE);
  {Now check handle}
  if Server then
  begin
    if hHandle = BiDirPipe.ServHandle then
      BiDirPipe.ServConnected := false
    else
      result := meServerNotConnected;
  end
  else
  begin
    if hHandle = BiDirPipe.CliHandle then
      BiDirPipe.CliConnected := false
    else
      result := meClientNotConnected;
  end;
  {Now. If quit was successfull, then potentially have to unblock
   all blocked reading and writing threads, so that they can
   return error}
  if Result = meOK then
  begin
    WaitForSingleObject(BiDirPipeLocks.Cli2ServLocks.PipeLock, INFINITE);
    WaitForSingleObject(BiDirPipeLocks.Serv2CliLocks.PipeLock, INFINITE);
    {Now unblock all potentially blocked threads reading/writing on the pipe}
    with BiDirPipeLocks do
    begin
      with Cli2ServLocks do
      begin
        with BiDirPipe.Cli2ServPipe do
        begin
          if ReaderBlocked then
          begin
            ReaderBlocked := false;
            ReleaseSemaphore(ReaderSem, 1, nil);
          end;
          if WriterBlocked then
          begin
            WriterBlocked := false;
            ReleaseSemaphore(WriterSem, 1, nil);
          end;
        end;
      end;
      with Serv2CliLocks do
      begin
        with BiDirPipe.Serv2CliPipe do
        begin
          if ReaderBlocked then
          begin
            ReaderBlocked := false;
            ReleaseSemaphore(ReaderSem, 1, nil);
          end;
          if WriterBlocked then
          begin
            WriterBlocked := false;
            ReleaseSemaphore(WriterSem, 1, nil);
          end;
        end;
      end;
      {Now have to think about functions waiting for peer.}
      {We basically have to unblock all threads blocked waiting for peer on our handle}
      with BiDirPipe^ do
      begin
        if Server then
        begin
          if ServPeerWait then
          begin
            ServPeerWait := false;
            ReleaseSemaphore(ServPeerWaitSem, 1, nil);
          end;
        end
        else
        begin
          if CliPeerWait then
          begin
            CliPeerWait := false;
            ReleaseSemaphore(CLiPeerWaitSem, 1, nil);
          end;
        end;
      end;
    end;
  end;
  {Release mutex before unblocking}
  ReleaseMutex(BiDirPipeLocks.BiLock);
  if Result = meOK then
  begin
    ReleaseMutex(BiDirPipeLocks.Cli2ServLocks.PipeLock);
    ReleaseMutex(BiDirPipeLocks.Serv2CliLocks.PipeLock);
  end;
end;


function ConnectServer(var hHandle: TMCHHandle): TMCHError stdcall;
{Returns error if server already connected}
begin
  SetLastError(0);
  result := GenericConnect(hHandle, true);
end;

function ConnectClient(var hHandle: TMCHHandle): TMCHError stdcall;
{Returns error if client already connected}
begin
  SetLastError(0);
  result := GenericConnect(hHandle, false);
end;

function DisconnectServer(hHandle: TMCHHandle): TMCHError stdcall;
begin
  SetLastError(0);
  result := GenericDisconnect(hHandle, true);
end;

function DisconnectClient(hHandle: TMCHHandle): TMCHError stdcall;
begin
  SetLastError(0);
  result := GenericDisconnect(hHandle, false);
end;

{Generic procedures to prevent duplicity}

{This function is *highly* cunning.
 It simply wraps up both reading and writing by both client and server into one procedure.

 He that writeth less code, debuggeth less at the end of the day.}

function GenericReadWrite(var Buf; Count: integer; var SrcDestPipe: TPipe; var Locks: TPipeLocks; Read: boolean): TMCHError;

var
  BlockSelf, UnblockPeer: boolean;
  DoThisTime: integer;
  SrcDestPtr: PByte;
  Avail: integer;


begin
  {Game plan.
  Check that neither client or server disconnected.
  Read/Write as much as possible and block if required.
  upon unblock, recheck connection status before proceeding.
  Once any data has been read/written, unblock the peer on the buffer.
  Nested mutex aquisition also required here. Respect ordering.}
  result := meOK;
  SrcDestPtr := @Buf;
  repeat
    {connection data critical section}
    WaitForSingleObject(BiDirPipeLocks.BiLock, INFINITE);
    WaitForSingleObject(Locks.PipeLock, INFINITE);
    {Now check connection status}
    if not BiDirPipe.ServConnected then result := meServerNotConnected;
    if not BiDirPipe.CliConnected then result := meClientNotConnected;
    if result <> meOK then
    begin
      {bomb out if not all connected}
      ReleaseMutex(BiDirPipeLocks.BiLock);
      ReleaseMutex(Locks.PipeLock);
      Exit;
    end;
    {So far, it's okay to read/write}
    {Read/write as much as we can this time.}
    if Read then
      Avail := EntriesUsed(SrcDestPipe.Buf)
    else
      Avail := EntriesFree(SrcDestPipe.Buf);
    if Count > Avail then
    begin
      DoThisTime := Avail;
      BlockSelf := true;
    end
    else
    begin
      DoThisTime := Count;
      BlockSelf := false;
    end;
    {work out whether to unblock any peer threads blocked on the converse
     read/write. Local vars are used so we can perform blocking / unblocking
     actions without holding any mutexes}
    if Read then
      UnblockPeer := (DoThisTime > 0) and SrcDestPipe.WriterBlocked
    else
      UnblockPeer := (DoThisTime > 0) and SrcDestPipe.ReaderBlocked;
    {Now do the read/write}
    if Read then
      GetEntries(SrcDestPipe.Buf, SrcDestPtr^, DoThisTime)
    else
      AddEntries(SrcDestPipe.Buf, SrcDestPtr^, DoThisTime);
    {update local vars}
    Count := Count - DoThisTime;
    Inc(SrcDestPtr, DoThisTime);
    {update blocking status variables}
    if Read then
    begin
      SrcDestPipe.WriterBlocked := SrcDestPipe.WriterBlocked and (not UnblockPeer);
      SrcDestPipe.ReaderBlocked := BlockSelf; {it is evident that we currently aren't blocked!}
    end
    else
    begin
      SrcDestPipe.ReaderBlocked := SrcDestPipe.ReaderBlocked and (not UnblockPeer);
      SrcDestPipe.WriterBlocked := BlockSelf; {it is evident that we currently aren't blocked!}
    end;
    {Release data mutexes and perform blocking / unblocking actions}
    ReleaseMutex(BiDirPipeLocks.BiLock);
    ReleaseMutex(Locks.PipeLock);
    if Read then
    begin
      if UnblockPeer then
        ReleaseSemaphore(Locks.WriterSem, 1, nil);
      if BlockSelf then
        WaitForSingleObject(Locks.ReaderSem, INFINITE);
    end
    else
    begin
      if UnblockPeer then
        ReleaseSemaphore(Locks.ReaderSem, 1, nil);
      if BlockSelf then
        WaitForSingleObject(Locks.WriterSem, INFINITE);
    end;
    {All done. If not complete, connection status will be rechecked next iteration}
  until count = 0;
end;


function GenericPeek(var BytesReady: integer; var SrcPipe: TPipe; var Locks: TPipeLocks): TMCHError;
begin
{Nonblocking peek. Fails if not both server and client connected}
  WaitForSingleObject(BiDirPipeLocks.BiLock, INFINITE);
  WaitForSingleObject(Locks.PipeLock, INFINITE);
  if BiDirPipe.CliConnected then
  begin
    if BiDirPipe.ServConnected then
      result := meOK
    else
      result := meServerNotConnected;
  end
  else
    result := meClientNotConnected;
  if result = meOK then BytesReady := EntriesUsed(SrcPipe.Buf);
{Now release in the same order that we aquired}
  ReleaseMutex(BiDirPipeLocks.BiLock);
  ReleaseMutex(Locks.PipeLock);
end;


function ReadWriteData(hHandle: TMCHHandle; var Buf; Count: integer; Read: boolean): TMCHError;
{Returns error if client or server not connected (or disconnects during block)
 Blocks if buffer empty}
begin
  WaitForSingleObject(BiDirPipeLocks.BiLock, INFINITE);
  if hHandle = BiDirPipe.ServHandle then
  begin
    if BiDirPipe.ServConnected then
    begin
      ReleaseMutex(BiDirPipeLocks.BiLock);
      if Read then
        {Server is reading, so read from Cli2Serv buffer}
        result := GenericReadWrite(Buf, Count, BiDirPipe.Cli2ServPipe, BiDirPipeLocks.Cli2ServLocks, Read)
      else
        {Server is writing so write to Serv2Cli buffer}
        result := GenericReadWrite(Buf, Count, BiDirPipe.Serv2CliPipe, BiDirPipeLocks.Serv2CliLocks, Read);
    end
    else
    begin
      ReleaseMutex(BiDirPipeLocks.BiLock);
      result := meServerNotConnected;
    end;
  end
  else
  begin
    if hHandle = BiDirPipe.CliHandle then
    begin
      if BiDirPipe.CliConnected then
      begin
        ReleaseMutex(BiDirPipeLocks.BiLock);
        if Read then
          {Client is reading, so read from Serv2Cli buffer}
          result := GenericReadWrite(Buf, Count, BiDirPipe.Serv2CliPipe, BiDirPipeLocks.Serv2CliLocks, Read)
        else
          {Client is writing, so write from Cli2Serv buffer}
          result := GenericReadWrite(Buf, Count, BiDirPipe.Cli2ServPipe, BiDirPipeLocks.Cli2ServLocks, Read);
      end
      else
      begin
        ReleaseMutex(BiDirPipeLocks.BiLock);
        result := meClientNotConnected;
      end;
    end
    else
    begin
      ReleaseMutex(BiDirPipeLocks.BiLock);
      result := meBadHandle;
    end;
  end;
end;

{Publicly accesible read, write and peek procedures}

function WriteData(hHandle: TMCHHandle; var Buf; Count: integer): TMCHError stdcall;
begin
  SetLastError(0);
  result := ReadWriteData(hHandle, Buf, Count, false);
end;

function ReadData(hHandle: TMCHHandle; var Buf; Count: integer): TMCHError stdcall;
begin
  SetLastError(0);
  result := ReadWriteData(hHandle, Buf, Count, true);
end;

function PeekData(hHandle: TMCHHandle; var BytesReady: integer): TMCHError stdcall;
{Returns error if client or server not connected, never blocks}
begin
  SetLastError(0);
  WaitForSingleObject(BiDirPipeLocks.BiLock, INFINITE);
  if hHandle = BiDirPipe.ServHandle then
  begin
    if BiDirPipe.ServConnected then
    begin
      ReleaseMutex(BiDirPipeLocks.BiLock);
      {Server is peeking, so peek Cli2Srv buffer}
      result := GenericPeek(BytesReady, BiDirPipe.Cli2ServPipe, BiDirPipeLocks.Cli2ServLocks);
    end
    else
    begin
      ReleaseMutex(BiDirPipeLocks.BiLock);
      result := meServerNotConnected;
    end;
  end
  else
  begin
    if hHandle = BiDirPipe.CliHandle then
    begin
      if BiDirPipe.CliConnected then
      begin
        ReleaseMutex(BiDirPipeLocks.BiLock);
        {Client is peeking, so peek Serv2Cli buffer}
        result := GenericPeek(BytesReady, BiDirPipe.Serv2CliPipe, BiDirPipeLocks.Serv2CliLocks);
      end
      else
      begin
        ReleaseMutex(BiDirPipeLocks.BiLock);
        result := meClientNotConnected;
      end;
    end
    else
    begin
      ReleaseMutex(BiDirPipeLocks.BiLock);
      result := meBadHandle;
    end;
  end;
end;

{Wait for peer blocks if self connected and peer not. Returns Okay if both
 connected. Returns error if the state at unblock time is anything other
 than both connected}

 {Compiler is a little bit stupid here, and tells me I might have some uninitialised vars.
  What garbage!}

{$WARNINGS OFF}

function WaitForPeer(hHandle: TMCHHandle): TMCHError; stdcall;

{Note: Only one thread can wait for a peer at any one time.}

var
  Server, Block: boolean;

begin
{Hmmm....
 Game plan.
      1. Get data lock.
      2. Check handles. Determine whether client or server. If error, release lock and quit.
      3. Read connection vars. If self connected and peer disconnected, set var + block (outside crit!)
      4. Upon unblock (or general passthru) determine retcode. If both connected, OK else return appropriate err.
 }
  SetLastError(0);
  WaitForSingleObject(BiDirPipeLocks.BiLock, INFINITE);

  {Check handles}
  result := meOK;
  if hHandle = BiDirPipe.ServHandle then
    Server := true
  else if hHandle = BiDirPipe.CliHandle then
    Server := false
  else result := meBadHandle;
  if Result = meOK then
  begin
    with BiDirPipe^ do
    begin
      if Server then
      begin
        Block := ServConnected and not CliConnected;
        if Block then ServPeerWait := true;
      end
      else
      begin
        Block := CliConnected and not ServConnected;
        if Block then CliPeerWait := true;
      end;
    end;
  end;
  ReleaseMutex(BiDirPipeLocks.BiLock);
  if Result = meOK then
  begin
    if Block then
    begin
      if Server then
        WaitForSingleObject(BiDirPipeLocks.ServPeerWaitSem, INFINITE)
      else
        WaitForSingleObject(BiDirPipeLocks.CliPeerWaitSem, INFINITE);
    end;
    {Regardless of whether we have blocked or not, reaquire global mutex and calculate ret code}
    WaitForSingleObject(BiDirPipeLocks.BiLock, INFINITE);
    if BiDirPipe.CliConnected then
    begin
      if BiDirPipe.ServConnected then
        result := meOK
      else
        result := meServerNotConnected;
    end
    else
      result := meClientNotConnected;
    ReleaseMutex(BiDirPipeLocks.BiLock);
  end;
end;

{$WARNINGS ON}

{
 If we are the process that managed to create the memory mapped file
(rather than opening it), then aquire global and pipe mutexes,
and init the data.

This will prevent multiple initialisations from conflicting.
}

procedure Initialise()stdcall;

var
  SharedMapCreator: boolean;

begin
  SetLastError(0);
  {Create mapping should always succeed}
  {IPC Shared memory creation}
  BiDirPipeLocks.MapHandle := CreateFileMapping($FFFFFFFF, nil, PAGE_READWRITE, 0, SizeOf(TBiDirPipe), MapName);
  SharedMapCreator := not (GetLastError = ERROR_ALREADY_EXISTS);
  {Now set up the file mapping...}
  BiDirPipe := MapViewOfFile(BiDirPipeLocks.MapHandle, FILE_MAP_ALL_ACCESS, 0, 0, SizeOf(TBiDirPipe));
  {Now create synchronisation objects Open all objects without requesting initial ownership}
  with BiDirPipeLocks do
  begin
    BiLock := CreateMutex(nil, false, GlobalLockName); {should always return valid handle}
    CliPeerWaitSem := CreateSemaphore(nil, 0, High(Integer), CliPeerWaitSemName);
    ServPeerWaitSem := CreateSemaphore(nil, 0, High(integer), ServPeerWaitSemName);
    {Now deal with individual pipe locks}
    with Cli2ServLocks do
    begin
      PipeLock := CreateMutex(nil, false, Cli2ServLockName); {should always return valid handle}
      ReaderSem := CreateSemaphore(nil, 0, High(integer), Cli2ServReaderSemName);
      WriterSem := CreateSemaphore(nil, 0, High(integer), Cli2ServWriterSemName);
    end;
    with Serv2CliLocks do
    begin
      PipeLock := CreateMutex(nil, false, Serv2CliLockName);
      ReaderSem := CreateSemaphore(nil, 0, High(integer), Serv2CliReaderSemName);
      WriterSem := CreateSemaphore(nil, 0, High(integer), Serv2CliWriterSemName);
    end;
  end;
  {Okay. Now if we created the memory map, initialise it. Respect mutex ordering}
  if SharedMapCreator then
  begin
    WaitForSingleObject(BiDirPipeLocks.BiLock, INFINITE);
    WaitForSingleObject(BiDirPipeLocks.Cli2ServLocks.PipeLock, INFINITE);
    WaitForSingleObject(BiDirPipeLocks.Serv2CliLocks.PipeLock, INFINITE);
    {Now initialise data structures}
    Randomize;
    with BiDirPipe^ do
    begin
      ServConnected := false;
      CliConnected := false;
      ServPeerWait := false;
      CliPeerWait := false;
      ServHandle := Random(High(integer) - 1);
      CliHandle := ServHandle + 1;
      with Cli2ServPipe do
      begin
        ReaderBlocked := false;
        WriterBlocked := false;
        InitBuf(Buf);
      end;
      with Serv2CliPipe do
      begin
        ReaderBlocked := false;
        WriterBlocked := false;
        InitBuf(Buf);
      end;
    end;
    {Now release locks in the order we aquired them}
    ReleaseMutex(BiDirPipeLocks.BiLock);
    ReleaseMutex(BiDirPipeLocks.Cli2ServLocks.PipeLock);
    ReleaseMutex(BiDirPipeLocks.Serv2CLiLocks.PipeLock);
  end;
  {Finished!}
end;

procedure Finalise()stdcall;
begin
  SetLastError(0);
  {Close just about every handle we have}
  UnMapViewofFile(BiDirPipe);
  with BiDirPipeLocks do
  begin
    CloseHandle(BiLock);
    CloseHandle(ServPeerWaitSem);
    CloseHandle(CliPeerWaitSem);
    CloseHandle(MapHandle);
    with Cli2ServLocks do
    begin
      CloseHandle(PipeLock);
      CloseHandle(ReaderSem);
      CloseHandle(WriterSem);
    end;
    with Serv2CliLocks do
    begin
      CloseHandle(PipeLock);
      CloseHandle(ReaderSem);
      CloseHandle(WriterSem);
    end;
  end;
end;

exports
  ConnectServer,
  ConnectClient,
  WriteData,
  ReadData,
  PeekData,
  WaitForPeer,
  DisconnectServer,
  DisconnectClient,
  Initialise,
  Finalise;

begin
end.


{ 10-05-1999 10:36:02 PM > [martin on MARTIN] checked out /Reformatting
   according to Delphi guidelines. }
{ 06-04-1999 2:42:04 AM > [martin on MARTIN] update: Removed checking
   pragmas Initial Version (0.1) /  }
{ 06-04-1999 1:46:37 AM > [martin on MARTIN] check in: (0.0) Initial Version
   / None }
unit MCHMemoryStream;

{Martin Harvey 18/7/1998

For donkeys years I've had performance problems when reading to
or writing from memory streams in small increments. This unit
intends to fix this problem.

Completely rewritten: Martin Harvey 5/4/1999.

I was unhappy with some performance issues in the original,
and the scheme for calculating size and position was not very logical,
and had special cases. This is now a more consistent and effecient rewrite}

{$RANGECHECKS OFF}
{$STACKCHECKS OFF}
{$IOCHECKS OFF}
{$OVERFLOWCHECKS OFF}

interface

{This stream acts as a memory stream by storing the data in 4k blocks,
 all of which are attached to a TList}

uses Classes;

const
  DataBlockSize = 4096;

type
  TDataBlockOffset = 0..DataBlockSize - 1;

  TDataBlock = array[0..DataBlockSize - 1] of byte;

  PDataBlock = ^TDataBlock;

{New rules for offset values are as follows:

 FPosBlock contains the number of the block which is about to be read or written to,
 given the current position.

 FPosOfs contains the offset of the byte that is about to be read or written to,
 given the current position. Always between 0 and DataBlockSize-1

 The number of blocks in the stream is given by the list count. If we are at the
 end of the stream, and the size of the stream is an exact multiple of the
 block size, then the last block will be empty.

 ie: The last block is never full.

}
  TMCHMemoryStream = class(TStream)
  private
    FBlockList:TList;
    FPosBlock:Longint;
    FPosOfs:TDataBlockOffset;
    FLastOfs:TDataBlockOffset;
    {FLastOfs is the offset of the byte to be read or written just off the end of the stream}
  protected
    function GetSize:longint;
    function GetPosition:longint;
    function ConvertOffsetsToLongint(Blocks:longint;BlockOfs:TDataBlockOffset):longint;
    procedure ConvertLongintToOffsets(Input:longint;var Blocks:longint;var BlockOfs:TDataBlockOffset);
    procedure ResizeBlockList(NewNumBlocks:longint);
  public
    constructor Create;
    destructor Destroy;override;
    {Necessary overrides}
    function Read(var Buffer;Count:longint):longint;override;
    function Write(const Buffer;Count:longint):longint;override;
    function Seek(Offset:Longint;Origin:word):Longint;override;
    {Procedures duplicating TCustomMemoryStream functionality}
    procedure SaveToStream(Stream:TStream);
    procedure SaveToFile(const FileName:string);
    {Procedures Duplicating TMemoryStream functionality}
    procedure Clear;
    procedure LoadFromStream(Stream:TStream);
    procedure LoadFromFile(const FileName:string);
    procedure SetSize(NewSize:longint);override;
  end;


implementation

uses SysUtils,Windows;

procedure TMCHMemoryStream.ResizeBlockList(NewNumBlocks:longint);

var
  iter,CurCount:longint;
  NewBlock:PDataBlock;

begin
  CurCount := FBlockList.Count;
  if NewNumBlocks > CurCount then
  begin
    for iter := CurCount to NewNumBlocks - 1 do
    begin
      New(NewBlock);
      FBlockList.Add(NewBlock);
    end;
  end
  else if NewNumBlocks < CurCount then
  begin
    for iter := NewNumBlocks to CurCount - 1 do
    begin
      Dispose(PDataBlock(FBlockList.Items[FBlockList.Count - 1]));
      FBlockList.Delete(FBlockList.Count - 1);
    end;
  end;
end;

function TMCHMemoryStream.GetSize;
begin
  result := ConvertOffsetsToLongint(FBlockList.Count - 1,FLastOfs);
end;

function TMCHMemoryStream.GetPosition;
begin
  result := ConvertOffsetsToLongint(FPosBlock,FposOfs);
end;

function TMCHMemoryStream.ConvertOffsetsTolongint(Blocks:longint;BlockOfs:TDataBlockOffset):longint;
begin
  Result := Blocks * DataBlockSize;
  Result := Result + BlockOfs;
end;

procedure TMCHMemoryStream.ConvertLongintToOffsets(Input:longint;var Blocks:longint;var BlockOfs:TDataBlockOffset);
begin
  Blocks := Input div DataBlockSize;
  BlockOfs := Input mod DataBlockSize;
end;

procedure TMCHMemoryStream.SetSize(NewSize:longint);

var
  NewNumBlocks:longint;
  CurPosition:longint;

begin
  if NewSize >= 0 then
  begin
    {Calculate current position}
    CurPosition := GetPosition;
    {Calculate end offsets for new size}
    ConvertLongintToOffsets(NewSize,NewNumBlocks,FLastOfs);
    {Now have the number of blocks needed, and the offset in the last block}
    ResizeBlockList(NewNumBlocks + 1);
    {List resized}
    {Now adjust position vars if needed}
    if NewSize < CurPosition then
    begin
      {Set current position to the end of the stream}
      FPosBlock := NewNumBlocks - 1;
      FPosOfs := FLastOfs;
    end;
  end;
end;

procedure TMCHMemoryStream.LoadFromStream(Stream:TStream);

var
  TempBlock:TDataBlock;
  BytesThisIteration:longint;

begin
  Stream.Seek(0,soFromBeginning);
  repeat
    BytesThisIteration := DataBlockSize;
    if BytesThisIteration > (Stream.Size - Stream.Position) then
      BytesThisIteration := Stream.Size - Stream.Position;
    Stream.ReadBuffer(TempBlock,BytesThisIteration);
    WriteBuffer(TempBlock,BytesThisIteration);
  until Stream.Position = Stream.Size;
end;

procedure TMCHMemoryStream.LoadFromFile(const FileName:string);
var
  Stream:TStream;
begin
  Stream := TFileStream.Create(FileName,fmOpenRead);
  try
    LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;


procedure TMCHMemoryStream.SaveToStream(Stream:TStream);

var
  TempBlock:TDataBlock;
  BytesThisIteration:longint;

begin
  Seek(0,soFromBeginning);
  repeat
    BytesThisIteration := DataBlockSize;
    if BytesThisIteration > (Size - Position) then
      BytesThisIteration := Size - Position;
    ReadBuffer(TempBlock,BytesThisIteration);
    Stream.WriteBuffer(TempBlock,BytesThisIteration);
  until Position = Size;
end;

procedure TMCHMemoryStream.SaveToFile(const FileName:string);
var
  Stream:TStream;
begin
  Stream := TFileStream.Create(FileName,fmCreate);
  try
    SaveToStream(Stream);
  finally
    Stream.Free;
  end;
end;

function TMCHMemoryStream.Write(const Buffer;Count:longint):longint;

var
  CurPos,CurSize,BytesWritten,BytesThisBlock:longint;
  Src:Pointer;
  DestBlock:PDataBlock;

begin
  {Returns bytes written}
  if Count < 0 then
  begin
    result := 0;
    exit;
  end;
  result := count;
  CurPos := GetPosition;
  CurSize := GetSize;
  if CurPos + Result > CurSize then
    SetSize(CurPos + Result);
  {Enough blocks allocated, may result in zero sized block at end}
  {Now do the write}
  Src := @Buffer;
  BytesWritten := 0;
  repeat
    DestBlock := PDataBlock(FBlockList.Items[FPosBlock]);
    BytesThisBlock := DataBlockSize - FPosOfs;
    if BytesThisBlock > (Result - BytesWritten) then
      BytesThisBlock := Result - BytesWritten;
    CopyMemory(@DestBlock^[FPosOfs],Src,BytesThisBlock);
    {Now update position vars}
    if BytesThisBlock + FPosOfs = DataBlockSize then
    begin
      FPosOfs := 0;
      Inc(FPosBlock);
    end
    else
      FPosOfs := FPosOfs + BytesThisBlock;
    BytesWritten := BytesWritten + BytesThisBlock;
    Src := Pointer(Integer(Src) + BytesThisBlock);
  until BytesWritten = result;
end;

function TMCHMemoryStream.Read(var Buffer;Count:longint):longint;

var
  CurPos,CurSize,BytesRead,BytesThisBlock:longint;
  SrcBlock:PDataBlock;
  Dest:pointer;


begin
  {Returns bytes read}
  CurPos := GetPosition;
  CurSize := GetSize;
  result := Count;
  if result < 0 then result := 0;
  if result > (CurSize - CurPos) then result := CurSize - CurPos;
  if result > 0 then
  begin
    Dest := @Buffer;
    BytesRead := 0;
    repeat
      SrcBlock := PDataBlock(FBlockList.items[FPosBlock]);
      BytesThisBlock := DataBlockSize;
      if FPosBlock = FBlockList.Count - 1 then {We're on the last block}
        BytesThisBlock := FLastOfs;
      BytesThisBlock := BytesThisBlock - FPosOfs;
      if BytesThisBlock > (result - BytesRead) then
        BytesThisBlock := result - BytesRead;
      {Now copy the required number of bytes}
      CopyMemory(Dest,@SrcBlock^[FPosOfs],BytesThisBlock);
      {Now update position state}
      if BytesThisBlock + FPosOfs = DataBlockSize then
      begin
        FPosOfs := 0;
        Inc(FPosBlock);
      end
      else
        FPosOfs := FPosOfs + BytesThisBlock;
      BytesRead := BytesRead + BytesThisBlock;
      Dest := Pointer(Integer(Dest) + BytesThisBlock);
    until BytesRead = result;
  end;
end;


function TMCHMemoryStream.Seek(Offset:Longint;Origin:word):longint;

var
  CurPos,CurSize:longint;

begin
  {Remember that it returns new position}
  CurPos := GetPosition;
  CurSize := GetSize;
  case Origin of
    soFromBeginning:result := Offset;
    soFromCurrent:result := CurPos + Offset;
    soFromEnd:result := CurSize - Offset;
  else
    result := CurPos;
  end;
  ConvertLongintToOffsets(result,FPosBlock,FPosOfs);
end;

procedure TMCHMemoryStream.Clear;

begin
  SetSize(0);
end;

destructor TMCHMemoryStream.Destroy;

begin
  Clear;
  Dispose(PDataBlock(FBlockList.Items[0]));
  FBlockList.Free;
  inherited Destroy;
end;

constructor TMCHMemoryStream.Create;
begin
  inherited Create;
  FBlockList := TList.Create;
  Clear; {Allocates first block}
end;

end.


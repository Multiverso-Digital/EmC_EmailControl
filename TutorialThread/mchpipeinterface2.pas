{ 10-05-1999 10:36:26 PM > [martin on MARTIN] checked out /Reformatting
   according to Delphi guidelines. }
{ 14-04-1999 11:59:06 PM > [martin on MARTIN] update: Changing dynamic
   methods to virtual. (0.1) /  }
{ 14-04-1999 11:52:47 PM > [martin on MARTIN] checked out /Changing dynamic
   methods to virtual. }
{ 06-04-1999 1:46:38 AM > [martin on MARTIN] check in: (0.0) Initial Version
   / None }
unit MCHPipeInterface2;

{Martin Harvey 23/9/1998}
{Another interface unit, but one that allows for dynamic loading of the DLL}

interface

uses MCHPipeTypes,SysUtils;

function LoadPipeDLL:boolean;
function UnloadPipeDLL:boolean;

{Load and unload functions automatically call initialise and finalise DLL procs}

{All the functions below will also raise EDLLNotLoaded}

function ConnectServer(var hHandle:TMCHHandle):TMCHError;
{Returns error if server already connected}
function ConnectClient(var hHandle:TMCHHandle):TMCHError;
{Returns error if client already connected}
function WriteData(hHandle:TMCHHandle;var Buf;Count:integer):TMCHError;
{Returns error if client or server not connected (or disconnects during block)
 Blocks if buffer full}
function ReadData(hHandle:TMCHHandle;var Buf;Count:integer):TMCHError;
{Returns error if client or server not connected (or disconnects during block)
 Blocks if buffer empty}
function PeekData(hHandle:TMCHHandle;var BytesReady:integer):TMCHError;
{Returns error if client or server not connected, never blocks}
function WaitForPeer(hHandle:TMCHHandle):TMCHError;
{Lets a thread wait for the peer to connect}
function DisconnectServer(hHandle:TMCHHandle):TMCHError;
{Returns error if server not connected, or bad handle}
function DisconnectClient(hHandle:TMCHHandle):TMCHError;
{Returns error if client not connected or bad handle}

function GetDLLLoaded:boolean;

implementation

uses Windows;

type
  ConnectProc = function(var hHandle:TMCHHandle):TMCHError stdcall;
  DisconnectProc = function(hHandle:TMCHHandle):TMCHError;stdcall;
  DataProc = function(hHandle:TMCHHandle;var Buf;Count:integer):TMCHError stdcall;
  PeekProc = function(hHandle:TMCHHandle;var BytesReady:integer):TMCHError stdcall;
  ProcNoParams = procedure stdcall;

var
  InitProc,FinalProc:ProcNoParams;
  ConnectServerProc,ConnectClientProc:ConnectProc;
  DisconnectServerProc,DisconnectClientProc:DisconnectProc;
  WaitForPeerProc:DisconnectProc;
  WriteDataProc,ReadDataProc:DataProc;
  PeekDataProc:PeekProc;
  DLLLoaded:boolean;
  DLLInstanceHandle:THandle;

function GetDLLLoaded:boolean;
begin
  result := DLLLoaded;
end;

function LoadPipeDLL:boolean;
begin
  result := false;
  DLLInstanceHandle := LoadLibrary(PipeDLLName);
  if DLLInstanceHandle <> 0 then
  begin
    InitProc := GetProcAddress(DLLInstanceHandle, 'Initialise');
    FinalProc := GetProcAddress(DLLInstanceHandle, 'Finalise');
    ConnectServerProc := GetProcAddress(DLLInstanceHandle, 'ConnectServer');
    ConnectClientProc := GetProcAddress(DLLInstanceHandle, 'ConnectClient');
    DisconnectServerProc := GetProcAddress(DLLInstanceHandle, 'DisconnectServer');
    DisconnectClientProc := GetProcAddress(DLLInstanceHandle, 'DisconnectClient');
    WaitForPeerProc := GetProcAddress(DLLInstanceHandle, 'WaitForPeer');
    WriteDataProc := GetProcAddress(DLLInstanceHandle, 'WriteData');
    ReadDataProc := GetProcAddress(DLLInstanceHandle, 'ReadData');
    PeekDataProc := GetProcAddress(DLLInstanceHandle, 'PeekData');
    result := true;
    InitProc;
  end;
  DLLLoaded := result;
end;

function UnLoadPipeDLL:boolean;
begin
  result := false;
  if DLLLoaded then
  begin
    FinalProc;
    result := FreeLibrary(DLLInstanceHandle);
    DLLLoaded := false;
  end;
end;

function ConnectServer(var hHandle:TMCHHandle):TMCHError;
{Returns error if server already connected}
begin
  if DLLLoaded then
    result := ConnectServerProc(hHandle)
  else
    result := meDLLNotLoaded;
end;

function ConnectClient(var hHandle:TMCHHandle):TMCHError;
{Returns error if client already connected}
begin
  if DLLLoaded then
    result := ConnectClientProc(hHandle)
  else
    result := meDLLNotLoaded;
end;

function DisconnectServer(hHandle:TMCHHandle):TMCHError;
{Returns error if server not connected, or bad handle}
begin
  if DLLLoaded then
    result := DisconnectServerProc(hHandle)
  else
    result := meDLLNotLoaded;
end;

function DisconnectClient(hHandle:TMCHHandle):TMCHError;
{Returns error if client not connected or bad handle}
begin
  if DLLLoaded then
    result := DisconnectClientProc(hHandle)
  else
    result := meDLLNotLoaded;
end;


function WriteData(hHandle:TMCHHandle;var Buf;Count:integer):TMCHError;
{Returns error if client or server not connected (or disconnects during block)
 Blocks if buffer full}
begin
  if DLLLoaded then
    result := WriteDataProc(hHandle,Buf,Count)
  else
    result := meDLLNotLoaded;
end;

function ReadData(hHandle:TMCHHandle;var Buf;Count:integer):TMCHError;
{Returns error if client or server not connected (or disconnects during block)
 Blocks if buffer empty}
begin
  if DLLLoaded then
    result := ReadDataProc(hHandle,Buf,Count)
  else
    result := meDLLNotLoaded;
end;

function PeekData(hHandle:TMCHHandle;var BytesReady:integer):TMCHError;
{Returns error if client or server not connected, never blocks}
begin
  if DLLLoaded then
    result := PeekDataProc(hHandle,BytesReady)
  else
    result := meDLLNotLoaded;
end;

function WaitForPeer(hHandle:TMCHHandle):TMCHError;
{Lets a thread wait for the peer to connect}
begin
  if DLLLoaded then
    result := WaitForPeerProc(hHandle)
  else
    result := meDLLNotLoaded;
end;

begin
  DLLLoaded := false;
end.


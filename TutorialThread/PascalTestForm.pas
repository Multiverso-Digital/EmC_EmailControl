unit PascalTestForm;

interface

uses
  Windows, Messages, SysUtils, SynchedThreads, SyncObjs,
  Classes, Graphics, Controls, Forms, Dialogs, StdCtrls;

type
  TPascalTest = class(TForm)
    BeepBtn: TButton;
    StopStartMsgWaitBtn: TButton;
    InfiniteWaitBtn: TButton;
    MsgWaitBtn: TButton;
    StopStartWaitBtn: TButton;
    EventWaitBtn: TButton;
    UntilBtn: TButton;
    SpawnBtn: TButton;
    WaitBtn: TButton;
    procedure BeepBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure StopStartMsgWaitBtnClick(Sender: TObject);
    procedure InfiniteWaitBtnClick(Sender: TObject);
    procedure MsgWaitBtnClick(Sender: TObject);
    procedure StopStartWaitBtnClick(Sender: TObject);
    procedure EventWaitBtnClick(Sender: TObject);
    procedure UntilBtnClick(Sender: TObject);
    procedure SpawnBtnClick(Sender: TObject);
    procedure WaitBtnClick(Sender: TObject);
  private
    { Private declarations }
    Thread:     TStopStartThread;
    WaitThread: TWaitThread;
    UntilFlag:  TEvent;

    procedure Beep(Data: pointer);
    procedure Pause(Data: pointer);
    procedure InfinitePause(Data: pointer);
    procedure wmClose(var Msg: TMessage); message WM_Close;
  public
    { Public declarations }
  end;

var
  PascalTest: TPascalTest;

implementation

{$R *.DFM}

// setup/teardown

procedure TPascalTest.FormCreate(Sender: TObject);
begin
  Thread     := TStopStartThread.Create;
  UntilFlag  := TEvent.Create(Nil, True, False, '');
  WaitThread := Nil;
end; // TPascalTest.FormCreate

procedure TPascalTest.FormDestroy(Sender: TObject);
begin
  Thread.Free;
  UntilFlag.Free;
end; // TPascalTest.FormDestroy

// thread procs

procedure TPascalTest.Beep(Data: pointer);
begin
  MessageBeep(0);
end; // TPascalTest.Beep

procedure TPascalTest.Pause(Data: pointer);
begin
  Sleep(7500);
end; // TPascalTest.Pause

procedure TPascalTest.InfinitePause(Data: pointer);
begin
  Sleep(INFINITE);
end; // TPascalTest.InfinitePause

// Event handlers

procedure TPascalTest.BeepBtnClick(Sender: TObject);
begin
  RunInThread(Beep, Nil);
end;

procedure TPascalTest.WaitBtnClick(Sender: TObject);
begin
  WaitBtn.Enabled := False;
  WaitForThread(Pause, Nil);
  WaitBtn.Enabled := True;
end;

procedure TPascalTest.MsgWaitBtnClick(Sender: TObject);
begin
  MsgWaitBtn.Enabled := False;
  MsgWaitForThread(WaitThread, Pause, Nil);
  MsgWaitBtn.Enabled := True;
end;

procedure TPascalTest.StopStartMsgWaitBtnClick(Sender: TObject);
begin
  StopStartMsgWaitBtn.Enabled := False;
  Thread.MsgWaitFor(Pause, Nil);
  StopStartMsgWaitBtn.Enabled := True;
end;

procedure TPascalTest.StopStartWaitBtnClick(Sender: TObject);
begin
  StopStartWaitBtn.Enabled := False;
  Thread.WaitFor(Pause, Nil);
  StopStartWaitBtn.Enabled := True;
end;

procedure TPascalTest.InfiniteWaitBtnClick(Sender: TObject);
begin
  InfiniteWaitBtn.Enabled := False;
  Thread.MsgWaitFor(InfinitePause, Nil);
  InfiniteWaitBtn.Enabled := True;
end;

procedure TPascalTest.EventWaitBtnClick(Sender: TObject);
begin
  EventWaitBtn.Enabled := False;
  UntilBtn.Enabled  := True;

  UntilFlag.ResetEvent;
  MsgWaitForSingleObject(UntilFlag.Handle);

  EventWaitBtn.Enabled := True;
  UntilBtn.Enabled  := False;
end;

procedure TPascalTest.UntilBtnClick(Sender: TObject);
begin
  UntilFlag.SetEvent;
end;

procedure TPascalTest.SpawnBtnClick(Sender: TObject);
begin
  SpawnBtn.Enabled := False;
  MsgWaitForSingleObject(SpawnProcess('test.bat').hProcess);
  SpawnBtn.Enabled := True;
end;

procedure TPascalTest.wmClose(var Msg: TMessage);
begin
  if Assigned(WaitThread) then WaitThread.AbortThread;
  if UntilBtn.Enabled     then UntilFlag.SetEvent;
  if Thread.Waiting       then Thread.AbortThread;
  Close;
end;

end.

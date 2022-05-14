program MsgWaits;

uses
  Forms,
  PascalTestForm in 'PascalTestForm.pas' {PascalTest},
  SynchedThreads in 'SynchedThreads.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Message Waits';
  Application.CreateForm(TPascalTest, PascalTest);
  Application.Run;
end.

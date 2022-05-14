program Speed;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  ParseExpr in '..\ParseExpr.pas',
  OObjects in '..\oObjects.pas',
  ParseClass in '..\ParseClass.pas';

{$R *.RES}

begin
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.

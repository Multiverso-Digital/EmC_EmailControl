program Calculator;
uses
  Forms,
  Calc1 in 'Calc1.pas' {Form1},
  ParseExpr in '..\ParseExpr.pas',
  ParseClass in '..\ParseClass.pas',
  OObjects in '..\oObjects.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.


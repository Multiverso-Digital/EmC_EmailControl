program MultCalc;
uses
  Forms,
  MultCalc1 in 'MultCalc1.pas' {Form1},
  OObjects in '..\oObjects.pas',
  ParseClass in '..\ParseClass.pas',
  ParseExpr in '..\ParseExpr.pas',
  FormExpr in '..\FormExpr.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'MultiExpression Calculator';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.


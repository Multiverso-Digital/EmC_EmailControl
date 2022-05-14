program FormulaEval;
uses
  Forms,
  FormEval1 in 'FormEval1.pas' {Form1},
  OObjects in '..\oObjects.pas',
  ParseClass in '..\ParseClass.pas',
  ParseExpr in '..\ParseExpr.pas',
  FormExpr in '..\FormExpr.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'MultiExpression Calculator / Formula Evaluator';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.


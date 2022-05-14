unit Main;
{Small program to compare the performance of ParseExpr with compiled
Delphi. Code: Arnulf Sortland}
interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons,
  ComCtrls, ParseExpr;

type
  TMainForm = class(TForm)
    Button2: TBitBtn;
    Memo1: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    X: double;
    Y:double;
    ExprParser1: TExpressionParser;
    function TestTimeFunc: double;
  public
    { Public declarations }
  end;

const
  TimesToEvaluate = 200000;

var
  MainForm: TMainForm;

implementation

{$R *.DFM}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  X := 1.2;
  Y:=0.55;
  ExprParser1 := TExpressionParser.Create;
  ExprParser1.ClearExpressions;
  ExprParser1.DefineVariable('x', @X);
  ExprParser1.DefineVariable('y', @Y);
  ExprParser1.AddExpression('sin(2*y)*cos(x)');
  Label1.Caption := 'Function: ' + ExprParser1.Expression[0];
  Label2.Caption := 'Evaluate it ' + IntToStr(TimesToEvaluate) + ' times';
  Button2.Click;
end;

function TMainForm.TestTimeFunc: double;
begin
  result := sin(2*y) * cos(x);
  //must be the same as Expression!!
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  ExprParser1.Free;
end;

procedure TMainForm.Button1Click(Sender: TObject);
var
  tick_now: array[0..2] of Longint;
  time_ms: array[0..1] of Longint;
  E: array[0..1] of double;
  i: Longint;
begin
  tick_now[0] := GetTickCount;
  for i := 1 to TimesToEvaluate do
    E[0] := TestTimeFunc;

  tick_now[1] := GetTickCount;
  for i := 1 to TimesToEvaluate do
    E[1] := ExprParser1.EvaluateCurrent;

  tick_now[2] := GetTickCount;

  time_ms[0] := tick_now[1] - tick_now[0];
  time_ms[1] := tick_now[2] - tick_now[1];

  Memo1.Lines.Add(Format('Compiled Delphi code :%10d ms', [time_ms[0]]));
  Memo1.Lines.Add(Format('ExprParser :%10d ms', [time_ms[1]]));
  Memo1.Lines.Add(Format('ExprParser/Delphi :%10f ', [time_ms[1] /
    time_ms[0]]));
  Memo1.Lines.Add('');
end;

end.


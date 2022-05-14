unit MultiCalc1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  StdCtrls, FormExpr, Menus, ExtCtrls, Dialogs;
const
  Nundo = 41;
type
  TForm1 = class(TForm)
    ResultEdit: TEdit;
    SaveFor: TButton;
    XEdit: TEdit;
    YEdit: TEdit;
    ZEdit: TEdit;
    BX: TButton;
    BY: TButton;
    BZ: TButton;
    Label2: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Helplabel: TLabel;
    FIndex: TLabel;
    FExpr: TMemo;
    EvalByName: TButton;
    FName: TEdit;
    GetFor: TButton;
    RemoveFor: TButton;
    E1: TButton;
    E2: TButton;
    E3: TButton;
    CL: TButton;
    EvalByIndex: TButton;
    Index: TEdit;
    Label1: TLabel;
    RadioGroup1: TRadioGroup;
    Label5: TLabel;
    Label6: TLabel;
    CheckBox1: TCheckBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    Label7: TLabel;
    AbortProcess: TButton;
    Label8: TLabel;
    CheckBox2: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure SaveForClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure XEditChange(Sender: TObject);
    procedure YEditChange(Sender: TObject);
    procedure ZEditChange(Sender: TObject);
    procedure EvalByNameClick(Sender: TObject);
    procedure RemoveForClick(Sender: TObject);
    procedure GetForClick(Sender: TObject);
    procedure E1Click(Sender: TObject);
    procedure E2Click(Sender: TObject);
    procedure E3Click(Sender: TObject);
    procedure CLClick(Sender: TObject);
    procedure EvalByIndexClick(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure AbortProcessClick(Sender: TObject);
  private
    { Private declarations }
    X, Y, Z: Double;
    MyParser: TFormulaParser;
    ArgSeparator: char;
    AssignChar: string;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses Math;
{$R *.DFM}
{ // suported functions
const
  Maxstrings = 35;
  Helpstrings: array[0..Maxstrings - 1] of string = (
    '() = brackets',
    'abs(x) = absolute value',
    'cos(x) = cosine of an angle in rad',
    'arccos(x) = inverse cosine of x in rad',
    'cosh(x) = hyperbolic cosine of an angle in rad',
    'arccosh(x) = inverse hyperbolic cosine in rad',
    'sin(x) = sine of an angle in rad',
    'arcsin(x) = inverse sine of x in rad',
    'sinh(x) = hyperbolic sine of an angle in rad',
    'arcsinh(x) = inverse hyperbolic sine in rad',
    'tan(x) = the tangent of an angle (rad)',
    'arctan(x) = inverse tangent of an angle (rad)',
    'tanh(x) = hyperbolic tangent of an angle (rad)',
    'arctanh(x) = inverse hyperbolic tangent of an angle (rad)',
    'degtorad(x) = conversion from degrees to radians',
    'radtodeg(x) = conversion from degrees to radians',
    'if(x1,x2,x3) = if x1=True(or 1) then x2 else x3',
    'sqr(x) = the square of a number (x*x)',
    'sqrt(x) = the square root of a number',
    'exp(x) = the value of e raised to the power of x',
    'ln(x) = natural logarithm of x',
    'log10(x) = logarithm base 10 of x',
    'logn(x1,x2) = logarithm base x1 of x2',
    '--x = substract 1 to x',
    '++x = add 1 to x',
    'goto(x1) = x1',
    'gotoif(x,x1,x2,x3) = x1 if x<0, x2 if x=0, x3 if x>0',
    'stop = stops executions',
    'pi = 3.1415926535897932385',
    'min(x1,x2) = the minimum of both arguments',
    'max(x1,x2) = the maximum of both arguments',
    'randg(x1,x2) = Draw from normal distrib. (mean=x1, sd =x2',
    'random = random number between 0 and 1',
    'round(x) = round to the nearest integer',
    'trunc(x) = truncates a real number to an integer');
  FunctionStrings: array[0..Maxstrings - 1] of string = (
    '()',
    'abs()',
    'cos()',
    'arccos()',
    'cosh()',
    'arccosh()',
    'sin()',
    'arcsin()',
    'sinh()',
    'arcsinh()',
    'tan()',
    'arctan()',
    'tanh()',
    'arctanh()',
    'degtorad()',
    'radtodeg()',
    'if(,,)',
    'sqr()',
    'sqrt()',
    'exp()',
    'ln()',
    'log10()',
    'logn(,)',
    '--',
    '++',
    'goto()',
    'gotoif(,,,)',
    'stop',
    'pi',
    'min(,)',
    'max(,)',
    'randg(,)',
    'random',
    'round()',
    'trunc()');
}
procedure TForm1.FormCreate(Sender: TObject);
begin
  if DecimalSeparator = ',' then
    ArgSeparator := ';'
  else
    ArgSeparator := ',';
  RadioGroup1Click(Sender);
  MyParser := TFormulaParser.Create;
  MyParser.DefineVariable('x', @X);
  MyParser.DefineVariable('y', @Y);
  MyParser.DefineVariable('z', @Z);
  X := StrToFloat(XEdit.Text);
  Y := StrToFloat(YEdit.Text);
  Z := StrToFloat(ZEdit.Text);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  MyParser.Free;
end;

procedure TForm1.XEditChange(Sender: TObject);
begin
  if Length(XEdit.Text) > 0 then
     X := StrToFloat(XEdit.Text)
  else
     X := 0;
end;

procedure TForm1.YEditChange(Sender: TObject);
begin
  if Length(XEdit.Text) > 0 then
     Y := StrToFloat(yEdit.Text)
  else
     Y := 0;
end;

procedure TForm1.ZEditChange(Sender: TObject);
begin
  if Length(XEdit.Text) > 0 then
     Z := StrToFloat(ZEdit.Text)
  else
     Z := 0;
end;

procedure TForm1.SaveForClick(Sender: TObject);
  procedure SetEditText(Edit: TEdit; X: Double);
  var
    OnCh: TNotifyEvent;
  begin
    OnCh := Edit.OnChange;
    Edit.OnChange := nil;
    Edit.Text := FloatToStr(X);
    Edit.OnChange := OnCh;
  end;
var
  i: integer;
begin
  i := MyParser.Formula(FName.Text, FExpr.Lines.Text);
  if i < 0 then
    FIndex.Caption := '-'
  else
    FIndex.Caption := IntToStr(i);
end;

procedure TForm1.RemoveForClick(Sender: TObject);
begin
  MyParser.Formula(FName.Text, '');
end;

procedure TForm1.GetForClick(Sender: TObject);
begin
  FExpr.Lines.Text := MyParser.Text(FName.Text);
  if FExpr.Lines.Count < 1 then
     FIndex.Caption := '-'
  else
     FIndex.Caption := IntToStr(MyParser.Index(FName.Text));
end;

procedure TForm1.CLClick(Sender: TObject);
begin
   FName.Text := '';
   FExpr.Lines.Clear();
end;

procedure TForm1.E1Click(Sender: TObject);
begin
  FName.Text := 'E1';
  FExpr.Lines.Clear();
  FExpr.Lines.Add('++x');
  FExpr.Lines.Add('goto(1)');
  SaveForClick(Sender);
end;

procedure TForm1.E2Click(Sender: TObject);
begin
  FName.Text := 'E2';
  FExpr.Lines.Clear();
  FExpr.Lines.Add('y'+AssignChar+'x*++z');
  FExpr.Lines.Add('++x*--z');
  FExpr.Lines.Add('z'+AssignChar+'(y-#)/(y+#)');
  SaveForClick(Sender);
end;

procedure TForm1.E3Click(Sender: TObject);
begin
  FName.Text := 'E3';
  FExpr.Lines.Clear();
  FExpr.Lines.Add('y'+AssignChar+'1');
  FExpr.Lines.Add('a'+AssignChar+'1');
  FExpr.Lines.Add('ifgoto(--x'+ArgSeparator+'7'+ArgSeparator+'3)');
  FExpr.Lines.Add('a'+AssignChar+'a*x');
  FExpr.Lines.Add('display(a)');
  FExpr.Lines.Add('goto(2)');
  FExpr.Lines.Add('x'+AssignChar+'a');
  FExpr.Lines.Add('display(y)');
  FExpr.Lines.Add('++y');
  FExpr.Lines.Add('ifgoto(y-10<0'+ArgSeparator+'8'+ArgSeparator+'if(y-10=0'+ArgSeparator+'12'+ArgSeparator+'10))');
  FExpr.Lines.Add('z'+AssignChar+'--y*++x');
  FExpr.Lines.Add('stop');
  FExpr.Lines.Add('z'+AssignChar+'sin(x)*cos(y)');
  FExpr.Lines.Add('goto(10)');
  SaveForClick(Sender);
end;

procedure TForm1.EvalByNameClick(Sender: TObject);
  procedure SetEditText(Edit: TEdit; X: Double);
  var
    OnCh: TNotifyEvent;
  begin
    OnCh := Edit.OnChange;
    Edit.OnChange := nil;
    Edit.Text := FloatToStr(X);
    Edit.OnChange := OnCh;
  end;
begin
  ResultEdit.Text := FloatToStr(MyParser.Eval(FName.Text));
  SetEditText(XEdit, X);
  SetEditText(YEdit, Y);
  SetEditText(ZEdit, Z);
end;

procedure TForm1.EvalByIndexClick(Sender: TObject);
  procedure SetEditText(Edit: TEdit; X: Double);
  var
    OnCh: TNotifyEvent;
  begin
    OnCh := Edit.OnChange;
    Edit.OnChange := nil;
    Edit.Text := FloatToStr(X);
    Edit.OnChange := OnCh;
  end;
var
  i,j: integer;
begin
  Val(Index.Text,i,j);
  if i < 0 then exit;
  AbortProcess.Enabled := false;
  if CheckBox2.Checked or
     RadioButton2.Checked or
     RadioButton3.Checked or
     RadioButton4.Checked then AbortProcess.Enabled := true;
  MyParser.Trace := CheckBox1.Checked;
  MyParser.ProcessMessages := CheckBox2.Checked;
  MyParser.MessXPos := Min(Screen.Width - 190, Form1.Left + Form1.Width + 1);
  MyParser.MessYPos := Min(Screen.Height - 150, Form1.Top + Form1.Height - 122);
  ResultEdit.Text := FloatToStr(MyParser.Eval(i));
  AbortProcess.Enabled := false;
  SetEditText(XEdit, X);
  SetEditText(YEdit, Y);
  SetEditText(ZEdit, Z);
end;

procedure TForm1.RadioGroup1Click(Sender: TObject);
begin
  if RadioGroup1.ItemIndex = 0 then
  begin
    AssignChar := ':='    // delphi format
  end
  else
  begin
    AssignChar := '=';    // C/C++ format
  end;
end;

procedure TForm1.RadioButton1Click(Sender: TObject);
begin
  if RadioButton1.Tag = (Sender as TRadioButton).Tag then
  begin
    RadioButton1.Checked := true;
    RadioButton2.Checked := false;
    RadioButton3.Checked := false;
    RadioButton4.Checked := false;
    MyParser.Progress := nil;
  end
  else
  if RadioButton2.Tag = (Sender as TRadioButton).Tag then
  begin
    RadioButton1.Checked := false;
    RadioButton2.Checked := true;
    RadioButton3.Checked := false;
    RadioButton4.Checked := false;
    MyParser.Progress := XEdit;
  end
  else
  if RadioButton3.Tag = (Sender as TRadioButton).Tag then
  begin
    RadioButton1.Checked := false;
    RadioButton2.Checked := false;
    RadioButton3.Checked := true;
    RadioButton4.Checked := false;
    MyParser.Progress := YEdit;
  end
  else
  if RadioButton4.Tag = (Sender as TRadioButton).Tag then
  begin
    RadioButton1.Checked := false;
    RadioButton2.Checked := false;
    RadioButton3.Checked := false;
    RadioButton4.Checked := true;
    MyParser.Progress := ZEdit;
  end;
end;

procedure TForm1.AbortProcessClick(Sender: TObject);
begin
  MyParser.Abort := true;
end;

end.


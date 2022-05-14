unit FormEval1;
{--------------------------------------------------------------
| TFormulaEval
|  Multi formula support example application
|  Author: Xavier Mor-Mur
|  xmormur@telepolis.com
|  xmormur@teleline.es
|
|---------------------------------------------------------------}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, FormExpr, Menus, ExtCtrls;
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
    PopupMenu1: TPopupMenu;
    Undo1: TMenuItem;
    Redo1: TMenuItem;
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
  private
    { Private declarations }
    X, Y, Z: Double;
    MyParser: TFormulaParser;
//    MyParser: TCStyleParser;
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


procedure TForm1.FormCreate(Sender: TObject);
begin
  if DecimalSeparator = ',' then
    ArgSeparator := ';'
  else
    ArgSeparator := ',';
  RadioGroup1Click(Sender);
  MyParser := TFormulaParser.Create;
//  MyParser := TCStyleParser.Create;
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
  FExpr.Lines.Add('a'+AssignChar+'x*sin(y)+1');
  FExpr.Lines.Add('1/a');
  FExpr.Lines.Add('display(#)');
  FExpr.Lines.Add('(a-#)*cos(x)');
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
  FExpr.Lines.Add('ifgoto(--x'+ArgSeparator+'7'+ArgSeparator+'7'+ArgSeparator+'3)');
  FExpr.Lines.Add('a'+AssignChar+'a*x');
  FExpr.Lines.Add('display(a)');
  FExpr.Lines.Add('goto(2)');
  FExpr.Lines.Add('x'+AssignChar+'a');
  FExpr.Lines.Add('display(y)');
  FExpr.Lines.Add('ifgoto(++y-10'+ArgSeparator+'8'+ArgSeparator+'12'+ArgSeparator+'10)');
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
  MyParser.Trace := CheckBox1.Checked;
  if i < 0 then exit;
  ResultEdit.Text := FloatToStr(MyParser.Eval(i));
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

end.


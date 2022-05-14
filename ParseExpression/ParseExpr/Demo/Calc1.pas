unit Calc1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ParseExpr, Menus;
const
  Nundo = 41;
type
  TForm1 = class(TForm)
    ResultEdit: TEdit;
    Evaluate: TButton;
    XEdit: TEdit;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    PointButton: TButton;
    ExpressionEdit: TEdit;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    neButton: TButton;
    notButton: TButton;
    PercButton: TButton;
    Button11: TButton;
    Button14: TButton;
    Button15: TButton;
    Button16: TButton;
    Button17: TButton;
    orButton: TButton;
    factButton: TButton;
    Button24: TButton;
    Button25: TButton;
    Button26: TButton;
    Button27: TButton;
    Button28: TButton;
    andButton: TButton;
    Button31: TButton;
    Button35: TButton;
    Button38: TButton;
    EqButton: TButton;
    xorButton: TButton;
    modButton: TButton;
    Button13: TButton;
    Button21: TButton;
    divButton: TButton;
    Button23: TButton;
    Button30: TButton;
    Button33: TButton;
    Button34: TButton;
    Label3: TLabel;
    FunctionsCombo: TComboBox;
    Button32: TButton;
    Label1: TLabel;
    yEdit: TEdit;
    ZEdit: TEdit;
    Button1: TButton;
    Button36: TButton;
    Button37: TButton;
    Label4: TLabel;
    AssignButton: TButton;
    Helplabel: TLabel;
    PopupMenu1: TPopupMenu;
    Undo1: TMenuItem;
    Redo1: TMenuItem;
    Label5: TLabel;
    NEvalLabel: TLabel;
    OptimizeCheck: TCheckBox;
    HexCheck: TCheckBox;
    CStyleCheck: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure EvaluateClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure XEditChange(Sender: TObject);
    procedure YEditChange(Sender: TObject);
    procedure ZEditChange(Sender: TObject);
    procedure Button24Click(Sender: TObject);
    procedure Button24KeyPress(Sender: TObject; var Key: Char);
    procedure Button32Click(Sender: TObject);
    procedure FunctionsComboChange(Sender: TObject);
    procedure Undo1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure ExpressionEditChange(Sender: TObject);
    procedure Redo1Click(Sender: TObject);
    procedure OptimizeCheckClick(Sender: TObject);
    procedure CStyleCheckClick(Sender: TObject);
  private
    { Private declarations }
    X, Y, Z: Double;
    PrevText: array[0..Nundo - 1] of string;
    Iprevtext: Integer;
    istartundo: Integer;
    MyParser: TExpressionParser;
    procedure AddToEdit(S: string);
    procedure UpdateUndo;
    procedure SetUndoText;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
  MyParser := TCstyleParser.Create;
  TCStyleParser(MyParser).CStyle:=False;
  //For testing:
  //MyParser.DecimSeparator:=','; //ArgSeparator is changed automatically
  MyParser.DefineVariable('x', @X);
  MyParser.DefineVariable('y', @Y);
  MyParser.DefineVariable('z', @Z);
  X := StrToFloat(XEdit.Text);
  Y := StrToFloat(yEdit.Text);
  Z := StrToFloat(ZEdit.Text);
  FunctionsCombo.ItemIndex := 0;
  Iprevtext := -1;
  istartundo := -1;
  FunctionsCombo.Clear;
  FunctionsCombo.Items.add('()');
  MyParser.GetFunctionNames(FunctionsCombo.Items);
  PointButton.Caption := MyParser.DecimSeparator;
end;



procedure TForm1.EvaluateClick(Sender: TObject);
var
 I: Integer;
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
  MyParser.Optimize := OptimizeCheck.Checked;
  I := MyParser.AddExpression(ExpressionEdit.Text);
  if HexCheck.Checked then
    ResultEdit.Text := MyParser.AsHexadecimal[I]
  else
   ResultEdit.Text := MyParser.AsString[I];
  NEvalLabel.Caption := IntToStr(MyParser.ExpressionSize[I]);
  SetEditText(XEdit, X);
  SetEditText(yEdit, Y);
  SetEditText(ZEdit, Z);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  I: Integer;
begin
  I := MyParser.AddExpression(ExpressionEdit.Text);
  ResultEdit.Text := MyParser.AsString[I];
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  MyParser.Free;
end;

procedure TForm1.XEditChange(Sender: TObject);
begin
  if XEdit.Text <> '' then
  begin
    X := StrToFloat(XEdit.Text);
  end;
end;

procedure TForm1.YEditChange(Sender: TObject);
begin
  Y := StrToFloat(yEdit.Text);
end;

procedure TForm1.ZEditChange(Sender: TObject);
begin
  Z := StrToFloat(ZEdit.Text);
end;

procedure TForm1.Button24Click(Sender: TObject);
begin
  AddToEdit((Sender as TButton).Caption);
end;

procedure TForm1.UpdateUndo;
begin
  istartundo := -1;
  if (Iprevtext <= 0) or (PrevText[Iprevtext - 1] <> ExpressionEdit.Text) then
  begin
    Inc(Iprevtext);
    if Iprevtext >= Nundo then
      Iprevtext := 0;
    PrevText[Iprevtext] := ExpressionEdit.Text;
  end;
end;

procedure TForm1.AddToEdit(S: string);
var
  Len: Integer;
  IsFunction: Boolean;
begin
  if S = '' then S := ' ';
  with ExpressionEdit do
  begin
    IsFunction := Pos('(', S) > 0;
    Len := Sellength;
    if IsFunction and (Len > 0) then
    begin
      Sellength := 0;
      SelText := Copy(S, 1, Pos('(', S));
      SelStart := SelStart + Len;
      SelText := Copy(S, Pos('(', S) + 1, Len); ;
      SelStart := SelStart - 1;
    end
    else
    begin
      SelText := S;
      if IsFunction then SelStart := SelStart - 1;
    end;
  end;
end;

procedure TForm1.Button24KeyPress(Sender: TObject; var Key: Char);
begin
  ActiveControl := ExpressionEdit;
  with ExpressionEdit do
  begin
    SelStart := SelStart + Sellength;
    Sellength := 0;
  end;
end;

procedure TForm1.Button32Click(Sender: TObject);
begin
  AddToEdit(FunctionsCombo.Text);
end;

procedure TForm1.FunctionsComboChange(Sender: TObject);
begin
  if (FunctionsCombo.ItemIndex >= 0) then
    Helplabel.Caption := MyParser.GetFunctionDescription(FunctionsCombo.Text);
end;

procedure TForm1.SetUndoText;
begin
  with ExpressionEdit do
  begin
    OnChange := nil;
    Text := PrevText[Iprevtext];
    SelStart := SelStart + Length(Text);
    Sellength := 0;
    OnChange := ExpressionEditChange;
  end;
end;

procedure TForm1.Undo1Click(Sender: TObject);
begin
  if istartundo = -1 then istartundo := Iprevtext;
  Dec(Iprevtext);
  if Iprevtext < 0 then
    Iprevtext := Nundo - 1;
  SetUndoText;
end;

procedure TForm1.PopupMenu1Popup(Sender: TObject);
begin
  Undo1.Enabled := (Iprevtext <> -1);
  Redo1.Enabled := (istartundo <> -1) and (istartundo <> Iprevtext);
end;

procedure TForm1.ExpressionEditChange(Sender: TObject);
begin
  UpdateUndo;
end;

procedure TForm1.Redo1Click(Sender: TObject);
begin
  if Iprevtext <> istartundo then
  begin
    Inc(Iprevtext);
    if Iprevtext = Nundo then
      Iprevtext := 0;
  end;
  SetUndoText;
end;

procedure TForm1.OptimizeCheckClick(Sender: TObject);
begin
  MyParser.ClearExpressions;
end;

procedure TForm1.CStyleCheckClick(Sender: TObject);
begin
  TCStyleParser(MyParser).CStyle:= CStyleCheck.Checked;
  if CStyleCheck.Checked then
  begin
    factButton.Caption:= 'fact()';
    percButton.Caption:='perc()';
    divButton.Caption:='div()';
    modButton.Caption:='%';
    orButton.Caption:='||';
    andButton.Caption:='&&';
    assignButton.Caption:='=';
    eqButton.Caption:='==';
    neButton.Caption:='!=';
    notButton.Caption:='!';
 end
  else
  begin
    factButton.Caption:= '!';
    percButton.Caption:='%';
    divButton.Caption:='div';
    modButton.Caption:='mod';
    orButton.Caption:='or';
    andButton.Caption:='and';
    assignButton.Caption:=':=';
    eqButton.Caption:='=';
    neButton.Caption:='<>';
    notButton.Caption:='not';
  end
end;

end.


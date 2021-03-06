unit UShowFilterFriends;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, funcoes, ComCtrls, JvExControls, {JvInspector,} Grids,
  {JvgStringGrid, JvgInspectorGrid,} ValEdit, Wwdbigrd, Wwdbgrid, Wwintl, wwriched,
  ExtCtrls, db, shellapi, Buttons, Menus;

type
  TFShowFilterFriends = class(TForm)
    GroupBox1: TGroupBox;
    CBItens: TListBox;
    wwDBGrid1: TwwDBGrid;
    BalloonHint1: TBalloonHint;
    PopupMenu1: TPopupMenu;
    Deleteselectedrule1: TMenuItem;
    DeleteALLrules1: TMenuItem;
    N1: TMenuItem;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox2: TGroupBox;
    Label7: TLabel;
    Eitem: TEdit;
    Button1: TButton;
    CBExists: TCheckBox;
    RBAND: TRadioButton;
    RBOR: TRadioButton;
    Label1: TLabel;
    Ename: TEdit;
    wwDBGrid2: TwwDBGrid;
    GroupBox4: TGroupBox;
    Label4: TLabel;
    SpeedButton1: TSpeedButton;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Etexto: TEdit;
    CBRegExpr: TCheckBox;
    CBAtivo: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure wwDBGrid1FieldChanged(Sender: TObject; Field: TField);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure SpeedButton1Click(Sender: TObject);
    procedure RBANDClick(Sender: TObject);
    procedure RBORClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CBExistsClick(Sender: TObject);
    procedure Deleteselectedrule1Click(Sender: TObject);
    procedure DeleteALLrules1Click(Sender: TObject);
    procedure wwDBGrid2DblClick(Sender: TObject);
    procedure Label5Click(Sender: TObject);
  private

  Procedure MontaFiltro;
  Procedure MontaCondicao;
  Procedure Verifica;
  Procedure PoeMatchType(Tipo:string);
  Procedure Esconde(Tipo:Boolean);
  Procedure Grava;
  Procedure LimpaTudo;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FShowFilterFriends: TFShowFilterFriends;
  erro : Boolean;
  ID : Integer;

implementation

uses udmserver, umain, UTestaExpression;

{$R *.dfm}


procedure TFShowFilterFriends.Label5Click(Sender: TObject);
begin
FtestaExpression := TFtestaExpression.create(self);
FtestaExpression.showmodal;
FtestaExpression.free;

end;

procedure TFShowFilterFriends.LimpaTudo;
begin
Eitem.Clear;
ETexto.Clear;
CBExists.Checked  := false;
CBRegExpr.Checked := false;
groupbox4.Visible := true;
end;



procedure TFShowFilterFriends.MontaCondicao;
begin


end;




procedure TFShowFilterFriends.MontaFiltro;
begin

Eitem.text   := dm_server.cds_CabecTmpItem.AsString;
ETexto.Text  := dm_server.cds_CabecTmpValor.AsString;
if lowercase(Eitem.text) = 'received:' then montaCondicao;



end;



Procedure TFShowFilterFriends.PoeMatchType(Tipo: String);
begin

with dm_server do
begin

cds_Boxes.First;
while not cds_Boxes.eof do
begin
  cds_Boxes.Edit;
  cds_BoxesMatchType.Asstring := Tipo;
  cds_BoxesNameRule.Asstring  := Trim(ename.Text);
  if CBAtivo.Checked then
  cds_BoxesStatus.AsInteger := 0 else cds_BoxesStatus.AsInteger := 1;
  cds_Boxes.post;
//  cds_Boxes.ApplyUpdates(0);
  cds_Boxes.next;
end;

cds_Boxes.First;


end;


end;

procedure TFShowFilterFriends.RBANDClick(Sender: TObject);
begin
PoeMatchType('AND');
end;

procedure TFShowFilterFriends.RBORClick(Sender: TObject);
begin
PoeMatchType('OR');
end;

procedure TFShowFilterFriends.SpeedButton1Click(Sender: TObject);
begin
shellexecute(Handle,'open', 'http://www.regular-expressions.info/tutorial.html',nil, nil, SW_SHOWNORMAL);

end;

procedure TFShowFilterFriends.Verifica;
begin



if trim(Ename.text) = '' then
begin
  erro := true;
  showmessage('Name Rule is missing');
  exit;
end;



if trim(Eitem.text) = '' then
begin
  erro := true;
  showmessage('Selected Header Item is missing');
  exit;
end;


if CBExists.Checked then exit;



if trim(ETexto.text) = '' then
begin
  erro := true;
  showmessage('Text to match is missing');
  exit;
end;


if (Not RBAND.Checked) and (Not RBOR.Checked) then
begin
  erro := true;
  showmessage('You must select a Match Kind');
  exit;

end;



end;




procedure TFShowFilterFriends.Grava;
begin
with dm_server do
begin


cds_BoxesTypeBox.AsInteger     := quem;

cds_BoxesWhereFilter.AsInteger := 1;
cds_BoxesFilterID.AsInteger    := MensID;
cds_BoxesNameRule.AsString     := Trim(Ename.text);
if RBAND.Checked then
cds_BoxesMatchType.Asstring := 'AND' else cds_BoxesMatchType.Asstring := 'OR';
cds_BoxesItem.AsString         := Trim(EItem.Text);
if CBExists.Checked then
begin
cds_BoxesKind.AsInteger        := 1;
ETexto.text := 'Must Exist';
CBRegExpr.Checked := false;
end
else
begin
cds_BoxesKind.AsInteger        := 2;
end;
if CBRegExpr.Checked then
cds_BoxesKind.AsInteger        := 3;
cds_BoxesExpression.AsString := trim(ETexto.text);
if CBAtivo.Checked then
cds_BoxesStatus.AsInteger := 0 else cds_BoxesStatus.AsInteger := 1;
cds_Boxes.Post;
//cds_Boxes.ApplyUpdates(0);
//cds_Boxes.Refresh;
if RBAND.Checked then  PoeMatchType('AND') else PoeMatchType('OR');
//cds_Boxes.Refresh;
end;


end;


procedure TFShowFilterFriends.Button1Click(Sender: TObject);
begin

erro := false;
Verifica;
if erro then exit;

if ID = 0 then  dm_server.cds_Boxes.append else  dm_server.cds_Boxes.edit;
Grava;
Limpatudo;
Pagecontrol1.ActivePageIndex := 1;
dm_server.TemFiltroNovo := true;




end;

procedure TFShowFilterFriends.CBExistsClick(Sender: TObject);
begin

if CBExists.Checked then Esconde(True) else Esconde(False);


end;

procedure TFShowFilterFriends.DeleteALLrules1Click(Sender: TObject);
begin


if dm_server.cds_Boxes.RecordCount = 0 then exit;


 if Dialogs.MessageDlg('ATTENTION: All rules will be deleted. Are you sure?',
    mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrNo then
  begin
  exit;
  end;


with dm_server do
begin

cds_Boxes.first;
while not cds_Boxes.eof do
begin
cds_Boxes.Delete;
//cds_Boxes.ApplyUpdates(0);
//cds_Boxes.Refresh;
TemFiltroNovo := True;
end;

end;
end;

procedure TFShowFilterFriends.Deleteselectedrule1Click(Sender: TObject);
begin

if dm_server.cds_Boxes.RecordCount = 0 then exit;


 if Dialogs.MessageDlg('Are you sure?',
    mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrNo then
  begin
  exit;
  end;


with dm_server do
begin

cds_Boxes.Delete;
//cds_Boxes.ApplyUpdates(0);
//cds_Boxes.Refresh;
TemFiltroNovo := True;

end;


end;

procedure TFShowFilterFriends.Esconde(Tipo: Boolean);
begin

GroupBox4.Visible := Not Tipo;

end;

procedure TFShowFilterFriends.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
dm_server.cds_Boxes.Filtered := false;
end;

procedure TFShowFilterFriends.FormShow(Sender: TObject);
var
I : integer;
Estado : boolean;
Monta : string;
begin


with dm_server do
begin

CbItens.Items.Text := MontaItensCabec(Cds_MensCabec.asstring);


  if cds_Cabectmp.active then cds_cabectmp.Active := false;
  cds_Cabectmp.Filter := 'ID = '+inttostr(MensID);
  cds_Cabectmp.Filtered := true;

//  cds_Cabectmp.Params[0].AsInteger := MensID;
  cds_Cabectmp.Active := true;
  if cds_Cabectmp.RecordCount = 0 then
     begin
      estado := true;
     end
     else
     begin
      estado := false;
     end;


for I := 0 to Cbitens.Items.Count - 1 do
  begin
  if estado then
  begin
  cds_Cabectmp.append;
  cds_CabecTmpID.AsInteger   := MensID;
  cds_CabecTmpItem.AsString  := Cbitens.Items[i];
  cds_CabecTmpValor.AsString := PegaItensCabec(CBItens.Items[I], dm_server.Cds_MensCabec.asstring);
  monta := trim(stringreplace(cds_CabecTmpValor.AsString,CBItens.Items[I],'',[]));
  cds_CabecTmpValor.AsString := monta;
  cds_CabecTmpFiltro.Asinteger := 0;
  cds_CabecTmp.Post;
//  cds_CabecTmp.ApplyUpdates;
//  cds_CabecTmp.Refresh;
  end;
  end;


 if quem = 1 then
     begin
     FiltraBoxes(1,1,MensID);
     FShowFilterFriends.Caption := 'mC-My Friends filters to selected header';
     FShowFilterFriends.Color   := clMoneyGreen;
     GroupBox1.Caption          := 'Friends filters to the selected message';
     end;
 if quem = 2 then
     begin
     FiltraBoxes(2,1,MensID);
     FShowFilterFriends.Caption := 'mC-BlackList filters to selected header';
     FShowFilterFriends.Color   := $00CECEFF;
     GroupBox1.Caption          := 'BlackList filters to the selected message';
     end;
 if quem = 3 then
     begin
     FiltraBoxes(3,1,MensID);
     FShowFilterFriends.Caption := 'mC-Filters to selected header';
     FShowFilterFriends.Color   := $00BFFFFF;
     GroupBox1.Caption          := 'Filters to the selected message';
     end;

 if tipoFil = 1 then
    begin
    wwDBGrid2DblClick(self);
    PageControl1.ActivePageIndex := 1;
    end
    else
    begin
     PageControl1.ActivePageIndex := 0;
    end;

  cds_CabecTmp.first;

end;

end;

procedure TFShowFilterFriends.wwDBGrid1FieldChanged(Sender: TObject;
  Field: TField);
begin

if Field.FieldName = 'Filtro' then
   begin
     if field.NewValue = 1 then
        begin
          LimpaTudo;
          ID := 0;
          MontaFiltro;
          Pagecontrol1.ActivePageIndex := 0;
        end;
   end;



end;

procedure TFShowFilterFriends.wwDBGrid2DblClick(Sender: TObject);
begin

With dm_server do
begin

 if cds_Boxes.RecordCount = 0 then exit;

 cbexists.Checked := false;
 CBRegExpr.Checked := false;

 ID := cds_BoxesID.AsInteger;
 Ename.Text   := cds_BoxesNameRule.AsString;
 Eitem.Text   := cds_BoxesItem.AsString;
 Etexto.Text  := cds_BoxesExpression.asstring;

 if cds_BoxesKind.asinteger = 1 then cbexists.Checked := true;
 if cds_BoxesKind.asinteger = 3 then CBRegExpr.Checked := true;

 if cds_BoxesStatus.asinteger = 0 then CBAtivo.Checked := true else CBAtivo.Checked := false;


 if cds_BoxesMatchType.AsString = 'AND' then RBAND.Checked := true;
 if cds_BoxesMatchType.AsString = 'OR'  then RBOR.Checked := true;

 Pagecontrol1.ActivePageIndex := 0;






end;


end;

end.

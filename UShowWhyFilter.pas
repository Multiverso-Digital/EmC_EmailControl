unit UShowWhyFilter;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, wwriched, Grids, Wwdbigrd, Wwdbgrid, funcoes,
  DBCtrls;

type
  TFShowWhyFilter = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    DBMemo1: TDBMemo;
    wwDBRichEdit1: TDBMemo;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FShowWhyFilter: TFShowWhyFilter;

implementation

uses Udmserver;

{$R *.dfm}

procedure TFShowWhyFilter.FormShow(Sender: TObject);
var
I : integer;
Estado : boolean;
Monta : string;
begin

with dm_server do
begin



{

CbItens.Items.Text := MontaItensCabec(Cds_MensCabec.asstring);


  if cds_Cabectmp.active then cds_cabectmp.Active := false;
  cds_Cabectmp.Params[0].AsInteger := Cds_MensID.AsInteger;
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
  cds_CabecTmpID.AsInteger   := cds_MensID.AsInteger;
  cds_CabecTmpItem.AsString  := Cbitens.Items[i];
  cds_CabecTmpValor.AsString := PegaItensCabec(CBItens.Items[I], dm_server.Cds_MensCabec.asstring);
  monta := trim(stringreplace(cds_CabecTmpValor.AsString,CBItens.Items[I],'',[]));
  cds_CabecTmpValor.AsString := monta;
  cds_CabecTmpFiltro.Asboolean := false;
  cds_CabecTmp.Post;
  cds_CabecTmp.ApplyUpdates;
  cds_CabecTmp.Refresh;
  end;
  end;


 }

if (Cds_MensFavoritos.AsInteger = 0) and (Cds_MensFiltrada.AsInteger <= 0) and
   (Cds_MensListaNegra.AsInteger = 0) then
   begin
    wwDBRichEdit1.DataField := 'FiltroResult';
    wwDBRichEdit1.Color     := ClWhite;
    GroupBox2.Caption       := 'Not Filtered';
    FShowWhyFilter.Color    := ClWhite;
    DBmemo1.Color           := ClWhite;
   end;


if Cds_MensFiltrada.AsInteger > 0 then
   begin
    wwDBRichEdit1.DataField := 'FiltroResult';
    wwDBRichEdit1.Color     := $00BFFFFF;
    GroupBox2.Caption       := 'Filter';
    FShowWhyFilter.Color    := $00BFFFFF;
    DBmemo1.Color           := $00BFFFFF;
   end;

if Cds_MensListaNegra.AsInteger > 0 then
   begin
    wwDBRichEdit1.DataField := 'FiltroResult';
    wwDBRichEdit1.Color     := $00CECEFF;
    GroupBox2.Caption       := 'BlackList Filter';
    FShowWhyFilter.Color    := $00CECEFF;
    DBmemo1.Color           := $00CECEFF;
   end;


if Cds_MensFavoritos.AsInteger > 0 then
   begin
    wwDBRichEdit1.DataField := 'FiltroResult';
    wwDBRichEdit1.Color     := clMoneyGreen;
    GroupBox2.Caption       := 'My Friend Filter';
    FShowWhyFilter.Color    := clMoneyGreen;
    DBmemo1.Color           := clMoneyGreen;
   end;


FShowWhyFilter.Update;


end;
end;

end.

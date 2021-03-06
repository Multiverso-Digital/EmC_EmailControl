unit UDM_FavoNegra;

interface

uses
  SysUtils, Classes, DB, {DBAccess, MemDS,} IdMessage,
  UCriaObjetos,  MidasLib, dbClient, uMain;

type
  TDM_FavoNegra = class(TDataModule)
  private
    { Private declarations }
  public
  Function Filtrar_Favoritos_ListaNegra(Mens:TMSG):TMSG;
    { Public declarations }
  end;

var
  DM_FavoNegra: TDM_FavoNegra;

implementation

uses UDMSERVER;

{$R *.dfm}


Function TDM_FavoNegra.Filtrar_Favoritos_ListaNegra(Mens:TMSG):TMSG;
//Var
//VeriEmailT  : TClientDataset;
begin

Result := Mens;

if Fmain.Fav_Email.IndexOf(Mens.EmailFrom) >= 0 then
   begin
   Mens.FiltroResultado.Add('Email found in My Friends:'+Mens.EmailFrom);
   Mens.Filtrada     := 144;
   Mens.Favorita     := 1;
   Mens.Selecionada  := 0;
   result := Mens;
   exit;
   end;

if Fmain.Fav_Domain.IndexOf(Mens.DominioFrom) >= 0 then
   begin
   Mens.FiltroResultado.Add('Domain found in My Friends List: '+Mens.DominioFrom);
   Mens.Filtrada     := 144;
   Mens.Favorita     := 1;
   Mens.Selecionada  := 0;
   result := Mens;
   exit;
   end;

if dm_server.BlackList = 0 then exit;


if Fmain.Black_Email.IndexOf(Mens.EmailFrom) >= 0 then
   begin
   Mens.FiltroResultado.Add('Email found in BlackList: '+Mens.EmailFrom);
   Mens.Filtrada     := 5;
   Mens.ListaNegra   := 1;
   Mens.Selecionada  := 1;
   result := Mens;
   exit;
   end;

if Fmain.Black_Domain.IndexOf(Mens.DominioFrom) >= 0 then
   begin
   Mens.FiltroResultado.Add('Domain found in BlackList: '+Mens.DominioFrom);
   Mens.Filtrada     := 5;
   Mens.ListaNegra   := 1;
   Mens.Selecionada  := 1;
   result := Mens;
   exit;
   end;

Exit;



{



VeriEmailT := TClientDataset.Create(nil);
VeriEmailT.CloneCursor(dm_server.cds_boxes,false,false);
VeriEmailT.filter := 'TypeBox < 3 and Kind > 3 and Status= 0';
VeriEmailT.Filtered := true;
VeriEmailT.active := true;


if VeriEmailT.Locate('Expression',Mens.EmailFrom,[loCaseInsensitive]) then
begin

 if VeriEmailT.FieldByName('TypeBox').AsInteger = 1 then
   begin
   Mens.FiltroResultado.Add('Email found in My Friends:'+Mens.EmailFrom);
   Mens.Filtrada     := 144;
   Mens.Favorita     := 1;
   Mens.Selecionada  := 0;
   result := Mens;
   VeriEmailT.close;
   VeriEmailT.Free;
   exit;
   end;

  if VeriEmailT.FieldByName('TypeBox').AsInteger = 2 then
   begin
   Mens.FiltroResultado.Add('Email found in BlackList: '+Mens.EmailFrom);
   Mens.Filtrada     := 5;
   Mens.ListaNegra   := 1;
   Mens.Selecionada  := 1;

   VeriEmailT.Edit;
   VeriemailT.FieldByName('countmacths').AsInteger :=  VeriemailT.FieldByName('countmacths').AsInteger + 1;
   VeriemailT.FieldByName('DT').AsDatetime :=  now;
   VeriemailT.post;

   result := Mens;
   VeriEmailT.close;
   VeriEmailT.Free;
   exit;
   end;

end;




if VeriEmailT.Locate('Expression',Mens.DominioFrom,[loCaseInsensitive]) then
begin

  if VeriEmailT.FieldByName('TypeBox').AsInteger = 1 then
   begin
   Mens.FiltroResultado.Add('Domain found in My Friends List: '+Mens.DominioFrom);
   Mens.Filtrada     := 144;
   Mens.Favorita     := 1;
   Mens.Selecionada  := 0;
   result := Mens;
   VeriEmailT.close;
   VeriEmailT.Free;
   exit;
   end;

  if VeriEmailT.FieldByName('TypeBox').AsInteger = 2 then
   begin
   Mens.FiltroResultado.Add('Domain found in BlackList: '+Mens.DominioFrom);
   Mens.Filtrada     := 5;
   Mens.ListaNegra   := 1;
   Mens.Selecionada  := 1;
   VeriEmailT.Edit;
   VeriemailT.FieldByName('countmacths').AsInteger :=  VeriemailT.FieldByName('countmacths').AsInteger + 1;
   VeriemailT.FieldByName('DT').AsDatetime :=  now;
   VeriemailT.post;
   result := Mens;
   VeriEmailT.close;
   VeriEmailT.Free;
   exit;
   end;

end;

VeriEmailT.close;
VeriEmailT.Free;

          }




end;



end.

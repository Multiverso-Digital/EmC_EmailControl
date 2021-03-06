unit UFiltro_Favoritos_ListaNegra;

interface

uses
Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,Dialogs,IdMessage,
UCriaObjetos, UDmServer, DB, Udm_favoNegra;


Function Filtrar_Favoritos_ListaNegra(Mens:TMSG):TMSG;



implementation


Function Filtrar_Favoritos_ListaNegra(Mens:TMSG):TMSG;
Var
DM_Favo : TDM_FavoNegra;
begin

DM_Favo := TDM_FavoNegra.Create(nil);

Result := Mens;


with dm_favo do
begin

if VeriEmail.active then  VeriEmail.active := false;
VeriEmail.params[0].AsString := Mens.EmailFrom;
VeriEmail.active := true;


//if VeriEmail.Locate('Expression',Mens.EmailFrom,[loCaseInsensitive]) then
//begin

 if VeriEmailTypeBox.AsInteger = 1 then
   begin
   Mens.FiltroResultado.Add('Email found in My Friends:'+Mens.EmailFrom);
   Mens.Filtrada     := 144;
   Mens.Favorita     := 1;
   Mens.Selecionada  := 0;
   result := Mens;
   DM_Favo.Free;

   exit;
   end;

  if VeriEmailTypeBox.AsInteger = 2 then
   begin
   Mens.FiltroResultado.Add('Email found in BlackList: '+Mens.EmailFrom);
   Mens.Filtrada     := 5;
   Mens.ListaNegra   := 1;
   Mens.Selecionada  := 1;
   result := Mens;

   DM_Favo.Free;
   exit;
   end;

//end;


if VeriEmail.active then  VeriEmail.active := false;
VeriEmail.params[0].AsString := Mens.DominioFrom;
VeriEmail.active := true;


//if VeriEmail.Locate('Expression',Mens.DominioFrom,[loCaseInsensitive]) then
//begin

  if VeriEmailTypeBox.AsInteger = 1 then
   begin
   Mens.FiltroResultado.Add('Domain found in My Friends List: '+Mens.DominioFrom);
   Mens.Filtrada     := 144;
   Mens.Favorita     := 1;
   Mens.Selecionada  := 0;
   result := Mens;

   DM_Favo.Free;
   exit;
   end;

  if VeriEmailTypeBox.AsInteger = 2 then
   begin
   Mens.FiltroResultado.Add('Domain found in BlackList: '+Mens.DominioFrom);
   Mens.Filtrada     := 5;
   Mens.ListaNegra   := 1;
   Mens.Selecionada  := 1;
   result := Mens;

   DM_Favo.Free;
   exit;
   end;

//end;

DM_Favo.Free;

end;


end;





end.

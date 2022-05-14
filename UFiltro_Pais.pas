unit UFiltro_Pais;

interface
uses
Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,Dialogs,IdMessage,
UCriaObjetos, DB, JvExControls, JvComCtrls, StrUtils, IdHTTP, funcoes,
Myaccess,  Umain, Udm_pais;

Function Filtrar_pais(Mens:TMSG):TMSG;
Function Verificapaisagain(Mens:TMSG):TMSG;


implementation



Function Verificapaisagain(Mens:TMSG):TMSG;
Var
XmLR     : String;
IdHttp1  : TIdHttp;
siglaX   : string;
EIP      : TJvIPAddress;
begin

Result := Mens;

EIP             :=  TJvIPAddress.Create(nil);
Eip.Text        :=  Mens.IPSender;
Eip.Update;


try
IdHttp1 := TIdHttp.Create(nil);
XmLR    := IdHttp1.get('http://ip-lookup.net/?'+Mens.IPSender);
except
end;

sleep(10);
Mens.pais    := PegaValorSite(XmLR,',600,520,true,false);">',2);
siglaX       := '.'+PegaValorSite(XmLR,'country.popup?c=',1);



Result := Mens;
EIP.Free;


  //dm_server.GravaIPSpam(IP,EIPX.Address);
end;


Function Filtrar_pais(Mens:TMSG):TMSG;
var
EIP      : TJvIPAddress;
SiglaDom : string;
Monta    : string;
Achou    : integer;
SiglaX   : string;
DM_pais  : TDM_pais;
begin


DM_pais := TDM_pais.Create(nil);


Result := Mens;

EIP             :=  TJvIPAddress.Create(nil);
Eip.Text        :=  Mens.IPSender;
Eip.Update;

With dm_pais do
begin

if not qsetup.Active  then qsetup.Active := true;
if not cds_pais.Active then cds_pais.Active := true;



sigladom := RightStr(Mens.DominioFrom,3);


fmain.JvMTCountingSection1.enter;
monta := VePais(Eip.Address);
fmain.JvMTCountingSection1.leave;
achou  := pos('_',monta);
if achou > 0 then
   begin
   Mens.pais   := copy(monta,1,achou-1);
   siglaX      := copy(monta,achou+1, length(monta)-achou);
   end
   else
   begin
   Mens.pais  := '';
   siglaX     := '';
   Result     := VerificaPaisAgain(Mens);
   GravaIPSpam(Mens.IPSender,EIP.Address);
   EIP.Free;

   DM_pais.Free;
   exit;
   end;



if qsetupCountries.AsInteger = 0 then
begin
EIP.Free;

DM_pais.Free;
exit;
end;

if cds_pais.locate('sigla',siglaX,[loCaseInsensitive]) then
   begin
     if cds_paisfiltro.asinteger = 1 then
       begin
        Mens.FiltroResultado.Add('Sender Country '+' IP:'+Mens.IPSender+' Country: '+mens.pais+' '+siglaX);
        Mens.Filtrada     := 145;
        Mens.Selecionada  := 1;
        Result := Mens;
        EIP.Free;

        DM_pais.Free;
        exit;
       end
       else
       begin
         if pos('.',sigladom) = 1 then
         begin
          if cds_pais.locate('sigla',sigladom,[loCaseInsensitive]) then
            begin
              if cds_paisfiltro.asinteger = 1 then
                  begin
                  Mens.FiltroResultado.Add('Sender Country '+' IP:'+Mens.IPSender+' Country: '+mens.pais+' '+siglaX+'  and country domain is '+sigladom);
                  Mens.Filtrada := 145;
                  Mens.Selecionada  := 1;
                  Result := Mens;
                  EIP.Free;

                  DM_pais.Free;
                  exit;
                  end;
            end
            else
            begin
            Mens.FiltroResultado.Add('Sender Country not found'+' IP:'+Mens.IPSender);
            Mens.Filtrada := 145;
            Mens.Selecionada  := 1;
            Result := Mens;
            EIP.Free;

            DM_pais.Free;
            Exit;
            end;
         end;
       end;
   end
   else
   begin
            Mens.FiltroResultado.Add('Sender Country not found'+' IP:'+Mens.IPSender);
            Mens.Filtrada     := 145;
            Mens.Selecionada  := 1;
            Result := Mens;
            EIP.Free;

            DM_pais.Free;
            Exit;
   end;


end;



end;



end.

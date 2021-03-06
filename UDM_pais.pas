unit UDM_pais;

interface


//http://geoloc.daiguo.com/?ip=66.94.234.13


uses
  SysUtils, Classes, db, DBClient, Provider, {MemDS, DBAccess,} {MyAccess,} IdMessage,
UCriaObjetos,  JvExControls, JvComCtrls, StrUtils, IdHTTP, funcoes,
Umain , {UdmServer,} {ABSMain,} {JvCsvData, JvComponentBase, JvCSVBaseControls,}
SOAPConn, SoapMidas, activex, midasLib, inifiles;

type
  TDM_pais = class(TDataModule)
  private
    { Private declarations }
  public
//  Function GravaIPSpam(IP:String;IPDec:largeInt):Boolean;
  Function Filtrar_pais(Mens:TMSG):TMSG;
//  Function Verificapaisagain(Mens:TMSG):TMSG;

    { Public declarations }
  end;

var
  DM_pais: TDM_pais;

implementation

uses UDMSERVER;

 {
 Function TDM_pais.GravaIPSpam(IP:String;IPDec:largeInt):Boolean;
 var
 CdsIPSpam : TclientDataset;




 begin


 try
 CdsIPSpam := TclientDataset.Create(nil);
 CdsIPSpam.CloneCursor(dm_server.cds_IPSpam_Local,false,false);
 CdsIPSpam.active := true;
 if CdsIPSpam.locate('IPDecimal',IPDEC,[]) then
    begin
     CdsIPSpam.Edit;
     CdsIPSpam.FieldByName('QTD').AsInteger := CdsIPSpam.FieldByName('QTD').AsInteger + 1;
     CdsIPSpam.Post;
    end
    else
    begin
     CdsIPSpam.append;
     CdsIPSpam.FieldByName('IPDecimal').AsExtended := IPDec;
     CdsIPSpam.FieldByName('IP').AsString := IP;
     CdsIPSpam.FieldByName('QTD').AsInteger := 1;
     CdsIPSpam.post;
    end;
 finally
  CdsIPSpam.Free;
 end;

 end;

  }

{
Function TDM_pais.Verificapaisagain(Mens:TMSG):TMSG;
Var
XmLR     : TstringList;
IdHttp1  : TIdHttp;
siglaX   : string;
EIP      : TJvIPAddress;

begin

Result := Mens;

XmLR := TstringList.Create;
XmLR.Delimiter := ';';

try
IdHttp1 := TIdHttp.Create(nil);
XmLR.DelimitedText    := IdHttp1.get('http://geoloc.daiguo.com/?ip='+Mens.IPSender);
sleep(10);
except
Mens.pais    := '';
siglaX       := '';
Xmlr.Free;
IdHttp1.Free;
exit;
end;

if XmLR.Strings[0] = '1' then
   begin
   Mens.pais    := XmLR.Strings[3];
   siglaX       := '.'+lowercase(XmLR.Strings[1]);
   Result := Mens;
   XmLR.free;
   IdHttp1.Free;
   exit;
   end
   else
   begin
   Mens.pais    := '';
   siglaX       := '';
   Mens.FiltroResultado.Add('Sender Country '+' IP:'+Mens.IPSender+' Country: '+mens.pais+' '+siglaX);
   Mens.Filtrada     := 145;
   Mens.Selecionada  := 1;
   Result := Mens;
   XmLR.free;
   IdHttp1.Free;
   exit;
   end;

end;

 }


Function TDM_pais.Filtrar_pais(Mens:TMSG):TMSG;
var
EIP       : TJvIPAddress;
SiglaDom  : string;
Monta     : string;
Achou     : largeInt;
SiglaX    : string;
DM_pais   : TDM_pais;
Cds_PaisT : TClientDataset;
IdHttp1   : TIdHttp;
XmLR      : TstringList;
CSoap     : TSoapConnection;
Cds       : TClientDataSet;
Teste     : IappServerSoap;
ListaProv, ListaSepara : THashedStringList;
Zeros, I,guarda : integer;
Procura   : string;
IPTO,IPFROM : LargeInt;

begin

Result := Mens;


EIP             :=  TJvIPAddress.Create(nil);
Eip.Text        :=  Mens.IPSender;
Eip.Update;

if trim(Eip.Text) = '' then
begin
Mens.FiltroResultado.Add('Sender Country not found(IP MISSING)'+' IP:'+Mens.IPSender);
Mens.Filtrada     := 145;
Mens.Selecionada  := 1;
Result := Mens;
EIP.Free;
Exit;
end;





{

try
CoInitialize(nil);
CSoap               :=  TSoapConnection.Create(nil);
Csoap.URL           :=  'http://69.64.64.125/EmCService/EmCService.dll/soap/IDM';
Csoap.UseSOAPAdapter:= true;
Csoap.Agent         := 'Borland SOAP 1.2';

with Csoap.GetSOAPServer as IAppServerSOAP do
begin

Csoap.Connected := true;
end;

Cds              := TclientDataset.Create(nil);
cds.RemoteServer := Csoap;
cds.ProviderName := 'prov_spPais';
cds.FetchParams;

if cds.active then cds.Active := false;
cds.Params[0].AsLargeInt :=    Eip.Address;
cds.Active := true;


  if Cds.recordcount > 0 then
     monta := Cds.FieldByName('PAIS').AsString+'_.'+Cds.FieldByName('sigla').AsString
          else
     monta := 'N?o achou '+Mens.IPSender;

finally
Cds.close;
Cds.Free;
Csoap.Free;
end;


 }


{
 siglaX := inttostr(Eip.Address);
 cds := TClientDataset.Create(nil);
 cds.CloneCursor(dm_server.cds_pais,false,false);
 cds.IndexFieldNames := 'IPNUMFROM;IPNUMTO';
 cds.Filter := 'IPNUMFROM <= '+siglax+' and IPNUMTO >= '+ siglax;
 cds.Filtered := true;
 if Cds.recordcount > 0 then
     monta := Cds.FieldByName('mpais').AsString+'_.'+Cds.FieldByName('sigla').AsString
          else
     monta := 'N?o achou '+Mens.IPSender;
 cds.Free;
 }


 tama  := length(inttostr(Eip.Address));
 zeros :=  10 - tama;
 monta := '';
 for I := 1 to zeros do
   begin
    Monta := monta +'0';
   end;
 monta := monta + inttostr(Eip.Address);

ListaProv := ThashedStringList.Create;
ListaSepara := ThashedStringList.Create;
ListaSepara.Delimiter := ';';

 for i := Fmain.ListaPais.Count - 1 downto 0  do
   begin
      if monta >= Fmain.ListaPais[i].Strings[0] then
      begin
        ListaProv.Assign(Fmain.ListaPais[i]);
        guarda := i;
        break;
      end;
   end;





ListaProv.Sorted := true;
//ListaProv.AddStrings(Fmain.ListaPais);






achou := ListaProv.IndexOf(Monta);

if achou = -1 then
   begin
    Listaprov.Add(Monta);
    achou := ListaProv.IndexOf(Monta)-1;
   end;

procura := ListaProv.Strings[achou];

achou := fmain.ListaPaisaOri[guarda].IndexOf(procura);







 {cds := TClientDataset.Create(nil);
 cds.CloneCursor(dm_server.cds_pais,false,false);
 cds.IndexFieldNames := 'IPNUMFROM;IPNUMTO';
 cds.Open; }
//If cds.Locate('IPNUMFROM', procura,[]) then




if achou >= 0 then

   begin
   ListaSepara.DelimitedText := fmain.ListaPaisTudo[guarda].Strings[achou];

  IPFROM := strtoint64(ListaSepara.Strings[0]);
  IPTO := strtoint64(ListaSepara.Strings[1]);
     if (Eip.Address >= IPFROM) and
        (Eip.Address <= IPTO)     then
           begin
           monta := ListaSepara.Strings[3]+'_.'+ListaSepara.Strings[2];

           end
           else
           begin
           monta := 'N?o achou '+Mens.IPSender;
           end;




   end
   else
   begin
   monta := 'N?o achou '+Mens.IPSender;
   end;


//cds.Free;
ListaProv.Free;
ListaSepara.free;



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
   Result     := Mens;//VerificaPaisAgain(Mens);
 //  GravaIPSpam(Mens.IPSender,EIP.Address);
   EIP.Free;
   exit;
   end;


Try
Cds_PaisT := TClientDataset.Create(nil);
Cds_PaisT.CloneCursor(DM_Server.cds_Sigla,false,false);
cds_paisT.Active := true;
except
EIP.Free;
cds_paisT.Close;
Cds_PaisT.Free;
exit;
End;



sigladom := RightStr(Mens.DominioFrom,3);


if cds_paisT.locate('sigla',siglaX,[loCaseInsensitive]) then
   begin
     if cds_paisT.FieldByName('Filtro').asinteger = 1 then
       begin
        Mens.FiltroResultado.Add('Sender Country '+' IP:'+Mens.IPSender+' Country: '+mens.pais+' '+siglaX);
        Mens.Filtrada     := 145;
        Mens.Selecionada  := 1;
        Result := Mens;
        EIP.Free;
        cds_paisT.Close;
        Cds_PaisT.Free;
        exit;
       end
       else
       begin
         if pos('.',sigladom) = 1 then
         begin
          if cds_paisT.locate('sigla',sigladom,[loCaseInsensitive]) then
            begin
              if cds_paisT.FieldByName('Filtro').asinteger = 1 then
                  begin
                  Mens.FiltroResultado.Add('Sender Country '+' IP:'+Mens.IPSender+' Country: '+mens.pais+' '+siglaX+'  and country domain is '+sigladom);
                  Mens.Filtrada := 145;
                  Mens.Selecionada  := 1;
                  Result := Mens;
                  EIP.Free;
                  cds_paisT.Close;
                  Cds_PaisT.Free;
                  exit;
                  end;
            end
            else
            begin
            Mens.FiltroResultado.Add('Sender Country not found'+' IP:'+Mens.IPSender);
            Mens.Filtrada     := 145;
            Mens.Selecionada  := 1;
            Result := Mens;
            EIP.Free;
            cds_paisT.Close;
            Cds_PaisT.Free;
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
            //GravaIPSpam(Mens.IPSender,EIP.Address);
            Result := Mens;
            EIP.Free;
            cds_paisT.Close;
            Cds_PaisT.Free;
            Exit;
   end;


end;


{$R *.dfm}

end.

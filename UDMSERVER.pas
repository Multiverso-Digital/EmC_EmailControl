unit UDMSERVER;

interface

uses
  SysUtils, Classes, Provider, DB, {MemDS,} {DBAccess,} DBClient, funcoes,
  Graphics, Controls, Forms, Dialogs, StdCtrls,  SOAPConn, MidasLib,
  {JvMemoryDataset,} variants, recerror;

type
  TDM_SERVER = class(TDataModule)
    DS_qMens: TDataSource;
    ds_Cabectmp: TDataSource;
    ds_MostraBoxes: TDataSource;
    ds_MostraFG: TDataSource;
    cds_AllM: TClientDataSet;
    DS_AllM: TDataSource;
    cds_AllMDT: TDateTimeField;
    cds_AllMEmail: TWideStringField;
    cds_AllMAssunto: TWideStringField;
    cds_AllMEmitente: TWideStringField;
    cds_AllMTama: TIntegerField;
    cds_AllMCabec: TWideMemoField;
    cds_AllMCorpo: TWideMemoField;
    cds_AllMFiltrada: TIntegerField;
    cds_AllMListaNegra: TIntegerField;
    cds_AllMFavoritos: TIntegerField;
    cds_AllMFiltroResult: TWideMemoField;
    cds_AllMNumeroMens: TIntegerField;
    cds_AllMExcluida: TIntegerField;
    cds_AllMAnexos: TIntegerField;
    cds_AllMselecionada: TIntegerField;
    cds_AllMConta: TWideStringField;
    cds_AllMUID: TWideStringField;
    cds_AllMDataOrig: TWideStringField;
    cds_AllMXmailer: TWideStringField;
    cds_AllMReceivedFrom: TWideStringField;
    cds_AllMEmailFrom: TWideStringField;
    cds_AllMDominioFrom: TWideStringField;
    cds_AllMIPSender: TWideStringField;
    cds_AllMID_Conta: TIntegerField;
    cds_AllMAnexosFiles: TWideMemoField;
    cds_AllMCountry: TWideStringField;
    cds_AllMlida: TIntegerField;
    cds_AllMDatamens: TWideStringField;
    cds_AllMCorpoTexto: TWideMemoField;
    DS_qContas: TDataSource;
    cds_mens: TClientDataSet;
    cds_IPSpam_Local: TClientDataSet;
    cds_IPSpam_LocalIPDecimal: TLargeintField;
    cds_IPSpam_LocalIP: TWideStringField;
    cds_IPSpam_LocalDT: TDateTimeField;
    cds_IPSpam_LocalQTD: TIntegerField;
    cds_IpSpam_Server: TClientDataSet;
    cds_IpSpam_ServerIPDecimal: TLargeintField;
    cds_IpSpam_ServerIP: TStringField;
    cds_IpSpam_ServerQTD: TLargeintField;
    cds_Sigla: TClientDataSet;
    cds_SiglaSigla: TWideStringField;
    cds_SiglaPais: TWideStringField;
    cds_SiglaFiltro: TIntegerField;
    DS_Sigla: TDataSource;
    cds_Dns: TClientDataSet;
    cds_DnsName: TWideStringField;
    cds_Dnsdns: TWideStringField;
    cds_Dnsactive: TIntegerField;
    cds_DnsDT: TDateTimeField;
    ds_cds_dns: TDataSource;
    qsetup: TClientDataSet;
    qsetupID: TIntegerField;
    qsetupBayesian: TIntegerField;
    qsetupMyFriends: TIntegerField;
    qsetupBlackList: TIntegerField;
    qsetupDNS: TIntegerField;
    qsetupCountries: TIntegerField;
    qsetupDT: TDateTimeField;
    qsetupFilter: TIntegerField;
    qsetupminutes: TIntegerField;
    qsetupIPdns: TWideStringField;
    qsetupvalorBaysean: TFloatField;
    qsetupQTDOK: TLargeintField;
    qsetupQTDBad: TLargeintField;
    ds_Qsetup: TDataSource;
    ds_boxes: TDataSource;
    cds_boxes: TClientDataSet;
    cds_boxesTypeBox: TIntegerField;
    cds_boxesWhereFilter: TIntegerField;
    cds_boxesFilterID: TIntegerField;
    cds_boxesMatchType: TWideStringField;
    cds_boxesItem: TWideStringField;
    cds_boxesKind: TIntegerField;
    cds_boxesExpression: TWideStringField;
    cds_boxesDT: TDateTimeField;
    cds_boxesStatus: TIntegerField;
    cds_boxesNameRule: TWideStringField;
    cds_boxescountmacths: TLargeintField;
    cds_CabecTmp: TClientDataSet;
    cds_CabecTmpID: TLargeintField;
    cds_CabecTmpItem: TWideStringField;
    cds_CabecTmpValor: TWideStringField;
    cds_CabecTmpFiltro: TIntegerField;
    cds_CabecTmpDT: TDateTimeField;
    qIdioma: TClientDataSet;
    qIdiomapais: TWideStringField;
    qIdiomaFormNome: TWideStringField;
    qIdiomaComponente: TWideStringField;
    qIdiomaPropiedade: TWideStringField;
    qIdiomaValor: TWideStringField;
    cds_Contas: TClientDataSet;
    cds_ContasNome: TWideStringField;
    cds_ContasPOP: TWideStringField;
    cds_ContasSMTP: TWideStringField;
    cds_ContasPorta: TIntegerField;
    cds_ContasUsuario: TWideStringField;
    cds_ContasSenha: TWideStringField;
    cds_ContasEmail: TWideStringField;
    cds_ContasSMTPautentica: TIntegerField;
    cds_ContasSMTPusuario: TWideStringField;
    cds_ContasSMTPSenha: TWideStringField;
    cds_ContasSMTPPorta: TIntegerField;
    cds_ContasAtivada: TIntegerField;
    cds_ContasExcluida: TIntegerField;
    cds_ContasDTALT: TDateTimeField;
    cds_ContasTipo: TWideStringField;
    cds_ContasSSL: TIntegerField;
    cds_ContasAutentica: TIntegerField;
    cds_ContasLeBody: TIntegerField;
    cds_ContasProxiServer: TWideStringField;
    cds_ContasProxiPorta: TIntegerField;
    cds_ContasHotMailServer: TIntegerField;
    cds_ContasID: TAutoIncField;
    cds_boxesID: TAutoIncField;
    cds_DnsID: TAutoIncField;
    qIdiomaID: TAutoIncField;
    qmostraBoxes: TClientDataSet;
    Qsoap: TSoapConnection;
    cds_pais: TClientDataSet;
    cds_paisIPNUMFROM: TLargeintField;
    cds_paisIPNUMTO: TLargeintField;
    cds_paissigla: TWideStringField;
    cds_paismpais: TWideStringField;
    cds_paisID: TAutoIncField;
    cds_mensID: TAutoIncField;
    cds_mensDT: TDateTimeField;
    cds_mensEmail: TWideStringField;
    cds_mensAssunto: TWideStringField;
    cds_mensEmitente: TWideStringField;
    cds_mensTama: TIntegerField;
    cds_mensDatamens: TWideStringField;
    cds_mensCabec: TWideMemoField;
    cds_mensCorpo: TWideMemoField;
    cds_mensFiltrada: TIntegerField;
    cds_mensListaNegra: TIntegerField;
    cds_mensFavoritos: TIntegerField;
    cds_mensFiltroResult: TWideMemoField;
    cds_mensNumeroMens: TIntegerField;
    cds_mensExcluida: TIntegerField;
    cds_mensAnexos: TIntegerField;
    cds_mensselecionada: TIntegerField;
    cds_mensConta: TWideStringField;
    cds_mensUID: TWideStringField;
    cds_mensDataOrig: TWideStringField;
    cds_mensXmailer: TWideStringField;
    cds_mensReceivedFrom: TWideStringField;
    cds_mensEmailFrom: TWideStringField;
    cds_mensDominioFrom: TWideStringField;
    cds_mensIPSender: TWideStringField;
    cds_mensID_Conta: TIntegerField;
    cds_mensAnexosFiles: TWideMemoField;
    cds_mensCountry: TWideStringField;
    cds_menslida: TIntegerField;
    cds_mensCorpoTexto: TWideMemoField;
    cds_mensMSG_REF: TIntegerField;
    cds_menspalavrasBaysean: TWideMemoField;
    cds_mensaprendeu: TIntegerField;
    cds_AllMMSG_REF: TIntegerField;
    cds_AllMpalavrasBaysean: TWideMemoField;
    cds_AllMaprendeu: TIntegerField;
    cds_AllMID1: TLargeintField;
    qsetupFastDelete: TIntegerField;
    cds_ContasGUID: TWideStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure cds_IpSpam_ServerReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);


  private
    procedure AbreTodasTabelas;
    procedure MontaSetupDefault;



    { Private declarations }
  public


   VerDomain     : widestring;



   EmailRegExp    : string;
   ExtraiIP       : string;
   MensID         : Integer;
   TipoFil        : integer;
   TemFiltroNovo  : Boolean;
   Quem           : Integer; //1=Friends  2=BlackList  3=Filter
   BodyDB         : integer; //1:normal, 2=Geral
   BodyID         : integer;
   BodyHeader     : integer;
   Dire           : string;
   Idioma         : string;
   EstounoMenu    : integer;
   TipoConta      : string;
   QContasCon     : TclientDataset;

   //dados do setup
   Baysean        : integer;
   MyFriends      : integer;
   BlackList      : integer;
   DNS            : integer;
   Countries      : Integer;
   Filter         : Integer;
   MinuSet        : Integer;
   IPDns          : string;
   valorBaysean   : double;
   TotOK          : Largeint;
   TotBad         : Largeint;
   FastDelete     : Integer;

//   Function VeSeConecta:boolean;
   Function PegaIdioma(S:string):boolean;
   Function ExtrairDiretorio:Boolean;
   Function PegaEmCSetup:boolean;
   Function CriarDiretorio(S:string):Boolean;
   Function ExtrairFiltrosFixos:Boolean;


//    Function GravaLog(onde,oque,conteudo:string):boolean;
//    Function AtualizaBoxes(ID:LargeInt):Boolean;
//    Function VePais(NUME:Cardinal):string;
//    Function VeSEExisteMens(Conta:Integer;UIDW:string):Boolean;
    Function FiltraBoxes(TypeBox:Integer;
                        WhereFilter:Integer;
                        Grupado:Integer):Boolean;
    Function GravaBoxes(TypeBox:Integer;
                       WhereFilter:Integer;
                       FilterID:Integer;
                       MatchType: string;
                       Item:string;
                       Kind:integer;
                       Expression:string;
                       Status:Integer;
                       NameRule:string):Boolean;
    Function VeSeExisteBoxes(TypeBox:Integer;
                       WhereFilter:Integer;
                       FilterID:Integer;
                       MatchType: string;
                       Item:string;
                       Kind:integer;
                       Expression:string):Boolean;
   Function MostraBoxes(TypeBox:Integer;
                       WhereFilter:Integer;
                       FilterID:Integer;
                       Kind:integer):Boolean;
  // Function DeletaBoxes(ID:LargeInt):Boolean;

   {
   Function GravaMark(IDMessage:LargeInt;
                       IDFilter:Integer;
                       Status:Integer):Boolean;   }

   Function Grava_AllM(ID:largeint):Boolean;
   Function AbreTabelaMens(Filtro:Integer):Boolean;
   Function PegaContasPOP(IDConta:Integer):Boolean;

//   Function GravaIPSpam(IP:String;IPDec:largeInt):Boolean;
//   Function GravaXMailer(S:string):Boolean;


   Function VeSeExisteNomeConta(Nome:string):Boolean;
   Function VeSeExisteUsuarioConta(XPOP3,XUsuario:string;XPorta:integer):Boolean;

   Function Incluir(Lista:string;Oque:string):boolean;
   Function Excluir(Lista:string;Oque:string):boolean;



  Procedure PoeMarca(tipo, restore:integer);
 // procedure DoSorting(cdsName:TClientDataset; AFieldName: String)override;
//  procedure DoSorting(cdsName:TMyQuery; AFieldName: String);

  Procedure ExcluirPassado;


  Procedure MarcaEmail(Email:string;tipo:integer);
  Procedure MarcaDomain(Domain:string;tipo:integer);
  Procedure MarcaRemoveEmail(Email:string;tipo:integer);


  end;


var
  DM_SERVER: TDM_SERVER;


implementation

uses Umens, Umain;

{$R *.dfm}


Function TDM_SERVER.Incluir(Lista:string;Oque:string):boolean;
begin

result := true;

  if lista = 'FAVEMAIL' then
     begin
      if (Fmain.Fav_Email.IndexOf(OQUE) = -1) and (Fmain.MeusEmails.IndexOf(uppercase(OQUE)) = -1) then
         begin
         Fmain.Fav_Email.add(OQUE);
         end
         else
         begin
         Result := false;
         end;
     end;

  if lista = 'FAVDOMAIN' then
     begin
      if (Fmain.Fav_Domain.IndexOf(OQUE) = -1) and (Fmain.MeusDominios.IndexOf(uppercase(OQUE)) = -1) then
         begin
         Fmain.Fav_Domain.add(OQUE);
         end
         else
         begin
         result := false;
         end;
       end;

  if lista = 'BLACKEMAIL' then
     begin
      if Fmain.Black_Email.IndexOf(OQUE) = -1 then
         begin
         Fmain.Black_Email.add(OQUE);
         end;
       end;

  if lista = 'BLACKDOMAIN' then
     begin
      if Fmain.Black_Domain.IndexOf(OQUE) = -1 then
         begin
         Fmain.Black_Domain.add(OQUE);
         end;
       end;



end;

Function TDM_SERVER.Excluir(Lista:string;Oque:string):boolean;
var
IND : Integer;
begin

result := true;

  if lista = 'FAVEMAIL' then
     begin
      IND:= Fmain.Fav_Email.IndexOf(OQUE);
         If IND >= 0 then
         begin
         Fmain.Fav_Email.delete(IND);
         end;
       end;

  if lista = 'FAVDOMAIN' then
     begin
      IND:= Fmain.Fav_Domain.IndexOf(OQUE);
         If IND >= 0 then
         begin
         Fmain.Fav_Domain.delete(IND);
         end;
       end;

  if lista = 'BLACKEMAIL' then
     begin
      IND:= Fmain.Black_Email.IndexOf(OQUE);
         If IND >= 0 then
         begin
         Fmain.Black_Email.delete(IND);
         end;
       end;

  if lista = 'BLACKDOMAIN' then
     begin
      IND:= Fmain.Black_Domain.IndexOf(OQUE);
         If IND >= 0 then
         begin
         Fmain.Black_Domain.delete(IND);
         end;
       end;

end;




Function  TDM_SERVER.VeSeExisteNomeConta(Nome:string):Boolean;
var
qveconta : TclientDataset;
begin

Result := false;

qveconta := TclientDataset.Create(nil);
qveconta.CloneCursor(cds_Contas,false,false);
qveconta.Active := true;
if qveconta.Locate('Nome', Nome,[loCaseInsensitive]) then
   begin
    Result := true;
   end
   else
   begin
    Result := False;
   end;

qveconta.free;

end;


Function  TDM_SERVER.VeSeExisteUsuarioConta(XPOP3,XUsuario:string;XPorta:integer):Boolean;
var
qvedupli : TclientDataset;
begin

Result := false;


qvedupli := TclientDataset.Create(nil);
qvedupli.CloneCursor(cds_Contas,false,false);
qvedupli.Active := true;

if qvedupli.Locate('POP;Usuario;Porta',VarArrayOf([XPOP3,XUsuario,Xporta]),[loCaseInsensitive]) then
 begin
 Result := true;

 end
 else
 begin
 Result := false;

 end;

 qvedupli.Free;



end;

{
 Function TDM_SERVER.GravaXmailer(S:String):Boolean;
 begin

 if qXmailer.active then qXmailer.Active := false;
 qXmailer.Params[0].AsString := trim(S);
 qXmailer.active := true;
 if qXmailer.RecordCount > 0 then
    begin
      qXmailer.Edit;
      qXmailerQTD.AsInteger :=  qXmailerQTD.AsInteger + 1;
      qXmailer.Post;
      //qXmailer.ApplyUpdates;
    end
    else
    begin
      qXmailer.Append;
      qXmailerID.AsString := Trim(S);
      qXmailerQTD.AsInteger       := 1;
      qXmailer.Post;
      //qXmailer.ApplyUpdates;

    end;



 end;
 }


 {

 Function TDM_SERVER.GravaIPSpam(IP:String;IPDec:largeInt):Boolean;
 begin

 if qipSpam.active then qipSpam.Active := false;
 qipspam.Params[0].AsLargeInt := IPDEc;
 qipSpam.active := true;
 if qipspam.RecordCount > 0 then
    begin
      qipspam.Edit;
      qIPSpamQTD.AsInteger :=  qIPSpamQTD.AsInteger + 1;
      qipSpam.Post;
      qipspam.ApplyUpdates;
    end
    else
    begin
      qipspam.Append;
      qIPSpamIPDecimal.AsLargeInt := IPDec;
      qIPSpamIP.AsString         := IP;
      qIPSpamQTD.AsInteger       := 1;
      qipSpam.Post;
      qipSpam.ApplyUpdates;

    end;



 end;

  }
{
Function TDM_SERVER.VeSeConecta:boolean;
begin
result := true;
 try
 If Not MC.Connected then MC.Connect;
 except
 result := false;
 end;
end;
  }

Function TDM_SERVER.PegaIdioma(S:string):boolean;
begin
  if qidioma.active then qidioma.Active:= false;
  qidioma.Filter  := 'pais = '+S;
  qidioma.Active := true;
end;


Function TDM_SERVER.ExtrairDiretorio:Boolean;
Begin
  dire := ExtractFilePath(Application.ExeName);
End;

Procedure TDM_SERVER.ExcluirPassado;
var
DataS : string;
Datax : Tdatetime;
begin


 if Not cds_AllM.active then  cds_AllM.active := true;

  DataS := datetostr(date);
  Datas := Datas + ' 00:00:00';
  Datax := strtodatetime(Datas);
  cds_ALLM.filter := 'DT < '+quotedstr(datetimetostr(datax));
  cds_ALLM.filtered := true;
  cds_ALLM.First;
  while not cds_ALLM.eof do
  begin
    cds_ALLM.Delete;
  end;


cds_AllM.active := false;


end;


procedure TDM_SERVER.MontaSetupDefault;
begin
   Baysean        := 0;
   MyFriends      := 0;
   BlackList      := 0;
   DNS            := 0;
   Countries      := 0;
   Filter         := 0;
   MinuSet        := 60;
   IPDns          := '156.154.70.1';
   valorBaysean   := 0.56;
   Idioma         := 'ING';
   FastDelete     := 0;
end;


function TDM_SERVER.PegaEmCSetup: boolean;
begin



try
if qsetup.active then qsetup.Active := false;
qsetup.Active := true;
except
MontaSetupDefault;
exit;
end;
   qsetup.First;
   if qsetup.RecordCount > 0  then
   begin
   Baysean        := qsetupBayesian.asinteger;
   MyFriends      := qsetupMyFriends.asinteger;
   BlackList      := qsetupBlackList.asinteger;
   DNS            := qsetupDNS.asinteger;
   Countries      := qsetupCountries.asinteger;
   Filter         := qsetupFilter.asinteger;
   MinuSet        := qsetupminutes.asinteger;
   IPDns          := qsetupIPdns.asstring;
   valorBaysean   := qsetupvalorBaysean.asfloat;
   TotOK          := qsetupQTDOK.AsLargeInt;
   TotBad         := qsetupQTDBad.AsLargeInt;
   FastDelete     := qsetupFastDelete.AsInteger;
   end
   else
   begin
   MontaSetupDefault;
   end;
end;





Function TDM_SERVER.CriarDiretorio(S:string):Boolean;
begin
  if not SysUtils.DirectoryExists(dire+S) then
    if not CreateDir(dire+S) then exit;
end;


Function TDM_SERVER.ExtrairFiltrosFixos:Boolean;
begin

cds_Boxes.Filter := 'TyPeBox = 4';
cds_Boxes.Filtered := true;
cds_Boxes.first;
while not cds_Boxes.Eof do
 begin

 if cds_BoxesItem.AsString = 'VeriDomain' then
   begin
   VerDomain := cds_BoxesExpression.AsString;
   end;



 if cds_BoxesItem.AsString = 'From, To, Return-Path' then
   begin
   EmailRegExp := cds_BoxesExpression.AsString;
   end;

 if cds_BoxesItem.AsString = 'ExtraiIP' then
   begin
   ExtraiIP := cds_BoxesExpression.AsString;
   end;

 cds_Boxes.Next;
 end;

 cds_Boxes.Filtered := false;
cds_Boxes.first;

end;





procedure TDM_SERVER.DataModuleCreate(Sender: TObject);
begin

ExtrairDiretorio;

cds_pais.FileName := dire+'dados\pais.cds';
cds_ALLM.FileName := dire+'dados\all_messages.cds';
cds_contas.FileName := dire+'dados\accounts.cds';
cds_mens.FileName := dire+'dados\messages.cds';
cds_boxes.FileName := dire+'dados\allboxes.cds';
cds_sigla.FileName := dire+'dados\tab_pais.cds';
cds_dns.FileName := dire+'dados\dns.cds';
qsetup.FileName := dire+'dados\setup.cds';
qidioma.FileName := dire+'dados\idioma.cds';
cds_CabecTmp.FileName := dire+'dados\tab_cabec_tmp.cds';
cds_IPSpam_Local.FileName := dire+'dados\ipspam.cds';


PegaEmCSetup;
PegaIdioma(Idioma);
CriarDiretorio('Anexos');
AbreTodasTabelas;
FiltraBoxes(4,0,0);
ExtrairFiltrosFixos;


end;


procedure TDM_SERVER.DataModuleDestroy(Sender: TObject);
begin

QContasCon.Free;
qmostraboxes.free;

end;

{
Function TDM_SERVER.AtualizaBoxes(ID:largeint):Boolean;
begin
  if qupBoxes.active then qupBoxes.active := false;
  qupBoxes.Params[0].AsLargeInt := ID;
  try
  qupboxes.Execute;
  except

  end;
end;
 }

{

Function TDM_SERVER.VePais(NUME:Cardinal):string;
begin


{
  cds_vepais.Filter := 'IPNUMFROM >= '+inttostr(Nume)+' and IPNUMTO <= '+inttostr(Nume);
  cds_vepais.Filtered := true;


    if cds_VePais.recordcount > 0 then
     result := Cds_VePaisPAIS.AsString+'_.'+Cds_VePaissigla.AsString
     else
     result := 'N?o achou '+inttostr(Nume);




  if cds_VePais.active then cds_VePais.close;
  cds_VePais.params[0].AsLongWord := NumE;
//  cds_VePais.params[1].AsLongWord := NumE;
  cds_VePais.open;

  if cds_VePais.recordcount > 0 then
     result := Cds_VePaisPAIS.AsString+'_.'+Cds_VePaissigla.AsString
     else
     result := 'N?o achou '+inttostr(Nume);
  cds_VePais.close;

end;
 }




//Somente LeContas Ativadas
Function TDM_SERVER.PegaContasPOP(IDConta:Integer):Boolean;
 begin

 Result := true;

 try
 QcontasCon.filter := 'ID = '+inttostr(IDConta)+' and ativada = 1' ;
 QcontasCon.Filtered := true;
 QcontasCon.first;
 if QcontasCon.recordcount > 0 then
    result := true else result := false;

 except
 Result := false;
 exit;
 end;



 end;




Function TDM_SERVER.AbreTabelaMens(Filtro:Integer):Boolean;
begin

  result := true;

  if cds_Mens.active then   cds_Mens.Active := false;
//  cds_Mens.Params[0].AsInteger := Filtro;
  try
  cds_Mens.Active := true;
  Except
   Result := false;
   showmessage('Cannot open table mens.');
  end;

  cds_Mens.Filter   := 'Excluida = 0';
  cds_Mens.Filtered := true;

end;




Function TDM_SERVER.Grava_AllM(ID:largeint):Boolean;
var
I : integer;
begin

{

  Result := true;

  If cds_AllM.Active then  cds_AllM.Active := False;
  cds_AllM.Params[0].AsLargeInt := ID;
  cds_AllM.Active := true;

  if cds_AllM.RecordCount > 0 then
  begin
   Result := False;
   exit;
  end;

  cds_AllM.Append;
  for I := 0 to qdelMens.Fields.count - 1 do
    begin
      cds_AllM.Fields[i].Value := qdelMens.Fields[i].Value;
    end;
  try
  cds_AllM.Post;
  cds_AllM.ApplyUpdates(0);
  cds_AllM.Refresh;
  except
  showmessage('ERROR - Saving Messages');
  Result := false;
  end;


 }

end;



{
Function TDM_SERVER.VeSEExisteMens(Conta:Integer;UIDW:string):Boolean;
begin

if QExisteUID.Active then QExisteUID.Active := false;
QExisteUID.Params[0].AsInteger := Conta;
QExisteUID.Params[1].AsString  := UIDW;
QExisteUID.active := true;
if qExisteUID.recordcount > 0  then Result := true else Result := false;


end;
 }



{
Function TDM_SERVER.DeletaBoxes(ID:largeint):Boolean;
begin

 if qdeleteboxes.active  then  qdeleteboxes.active := false;
 qdeleteboxes.params[0].aslargeint := ID;
 qdeleteboxes.execute;
 cds_Boxes.Refresh;



end;
 }



Function TDM_SERVER.MostraBoxes(TypeBox:Integer;
                       WhereFilter:Integer;
                       FilterID:Integer;
                       Kind:integer):Boolean;
begin
qmostraboxes.Filter := 'TypeBox = '+inttostr(TypeBox)+' and WhereFilter = '+inttostr(WhereFilter)+' and FilterID = '+inttostr(FilterID)+' and Kind = '+inttostr(Kind);
qmostraboxes.IndexFieldNames := 'Expression';
qmostraboxes.filtered := true;
qmostraboxes.first;
end;


{
Function TDM_SERVER.GravaMark(IDMessage:LargeInt;
                       IDFilter:Integer;
                       Status:Integer):Boolean;
begin


 if qaddmark.Active then  qaddmark.Active := false;
 qaddmark.params[0].AsLargeInt := IDMessage;
 qaddmark.params[1].AsInteger := IDFilter;
 qaddmark.params[2].AsInteger := Status;
 qaddmark.post;
 qaddmark.ApplyUpdates;
 qaddmark.Refresh;


end;
 }




Function TDM_SERVER.FiltraBoxes(TypeBox:Integer;
                        WhereFilter:Integer;
                        Grupado:Integer):Boolean;
begin

//if cds_Boxes.Active then cds_Boxes.Active := false;
cds_Boxes.IndexFieldNames := 'TypeBox;WhereFilter;FilterID;Kind';
//cds_Boxes.Params[0].AsInteger := TypeBox;
if grupado = 0 then
cds_Boxes.Filter              := 'typebox = '+inttostr(Typebox)+' and WhereFilter = '+inttostr(WhereFilter)+' and '+'FilterID = 0 and kind < 4';
if grupado = -1 then
cds_Boxes.Filter              := 'typebox = '+inttostr(Typebox)+' and WhereFilter = '+inttostr(WhereFilter)+' and FilterID > 0 and kind < 4';
if grupado > 0 then
cds_Boxes.Filter              := 'typebox = '+inttostr(Typebox)+' and WhereFilter = '+inttostr(WhereFilter)+' and FilterID = '+inttostr(Grupado);
cds_Boxes.Filtered := true;
try
//cds_Boxes.active := true;
cds_Boxes.First;
except
Result := False;
exit;
end;

Result := true;

end;

Function TDM_SERVER.VeSeExisteBoxes(TypeBox:Integer;
                       WhereFilter:Integer;
                       FilterID:Integer;
                       MatchType: string;
                       Item:string;
                       Kind:integer;
                       Expression:string):Boolean;
Begin

if Not cds_Boxes.Locate('TypeBox;WhereFilter;FilterID;MatchType;Item;Kind;Expression',VarArrayOf([TypeBox,WhereFilter,FilterID,MatchType,Item,Kind,Expression]),[loCaseInsensitive]) then
begin
  result := false;
end
else
begin
  result := true;
end;

End;



Function TDM_SERVER.GravaBoxes(TypeBox:Integer;
                       WhereFilter:Integer;
                       FilterID:Integer;
                       MatchType: string;
                       Item:string;
                       Kind:integer;
                       Expression:string;
                       Status:Integer;
                       NameRule:String):Boolean;
Begin

if Not cds_Boxes.Locate('TypeBox;WhereFilter;FilterID;MatchType;Item;Kind;Expression',VarArrayOf([TypeBox,WhereFilter,FilterID,MatchType,Item,Kind,Expression]),[loCaseInsensitive]) then
   begin
     cds_Boxes.Append;
     cds_BoxesTypeBox.AsInteger       := TypeBox;
     cds_BoxesWhereFilter.asinteger   := WhereFilter;
     cds_BoxesFilterID.AsInteger      := FilterID;
     cds_BoxesMatchType.AsString      := MatchType;
     cds_BoxesItem.AsString           := Item;
     cds_BoxesKind.AsInteger          := Kind;
     cds_BoxesExpression.AsString     := Expression;
     cds_BoxesStatus.AsInteger        := 0;
     cds_BoxesNameRule.AsString       := NameRule;
     try
     cds_Boxes.Post;
     except
     Result := False;
     exit;
     end;
     Result := true;
   end;
End;






Procedure TDM_SERVER.MarcaRemoveEmail(Email:string;tipo:integer);
begin

with cds_mens do
begin

cds_mens.First;
fmens.JvSpecialProgress1.Maximum := cds_mens.RecordCount;
cds_mens.DisableControls;

cds_mens.Filter := 'EmailFrom = '+quotedstr(Email);
cds_mens.filtered := true;
cds_mens.first;

while not cds_mens.eof do
begin

cds_mens.edit;


if tipo = 2 then
begin
  cds_mensFiltroResult.asstring :=('Email removed from BlackList:'+Email);
  cds_mensFiltrada.asinteger     := 35;
  cds_mensListaNegra.asinteger   := 0;
  cds_mensSelecionada.asinteger  := 0;
  cds_mens.post;
end;

if Tipo = 1 then
begin
  cds_mensFiltroResult.asstring:=('Email removed from My Friends List:'+cds_mensEmailFrom.asstring);
  cds_mensFiltrada.asinteger     := 35;
  cds_mensFavoritos.asinteger    := 0;
  cds_mensListaNegra.asinteger   := 0;
  cds_mensSelecionada.AsInteger  := 0;
  cds_Mens.post;
end;

cds_Mens.next;

end;

cds_mens.filtered := false;
cds_mens.first;
cds_mens.EnableControls;


end;

end;














Procedure TDM_SERVER.MarcaEmail(Email:string;tipo:integer);
begin

with cds_mens do
begin

cds_mens.First;
fmens.JvSpecialProgress1.Maximum := cds_mens.RecordCount;
cds_mens.DisableControls;

cds_mens.Filter := 'EmailFrom = '+quotedstr(Email);
cds_mens.filtered := true;
cds_mens.first;

while not cds_mens.eof do
begin

cds_mens.edit;


if tipo = 2 then
begin
  cds_mensFiltroResult.asstring :=('Email found in BlackList:'+Email);
  cds_mensFiltrada.asinteger     := 5;
  cds_mensListaNegra.asinteger   := 1;
  cds_mensSelecionada.asinteger := 1;
  cds_mens.post;
end;

if Tipo = 1 then
begin
  cds_mensFiltroResult.asstring:=('Email found in My Friends:'+cds_mensEmailFrom.asstring);
  cds_mensFiltrada.asinteger     := 144;
  cds_mensFavoritos.asinteger    := 1;
  cds_mensListaNegra.asinteger   := 0;
  cds_mensSelecionada.AsInteger  := 0;
  cds_Mens.post;
end;

cds_Mens.next;

end;

cds_mens.filtered := false;
cds_mens.first;
cds_mens.EnableControls;


end;

end;


Procedure TDM_SERVER.MarcaDomain(Domain:string;tipo:integer);
begin

with cds_mens do
begin

cds_mens.First;
fmens.JvSpecialProgress1.Maximum := cds_mens.RecordCount;
cds_mens.DisableControls;

cds_mens.Filter := 'DominioFrom = '+quotedstr(Domain);
cds_mens.filtered := true;
cds_mens.first;

while not cds_mens.eof do
begin

cds_mens.edit;

if tipo = 2 then
begin
  cds_mensFiltroResult.asstring:=('Domain found in BlackList:'+cds_mensDominioFrom.asstring);
  cds_mensFiltrada.asinteger       := 5;
  cds_mensListaNegra.asinteger     := 1;
  cds_mensSelecionada.AsInteger    := 1;
  cds_mens.post;
end;


if tipo = 1 then
begin
  cds_mensFiltroResult.asstring:=('Domain found in My Friends:'+cds_mensDominioFrom.asstring);
  cds_mensFiltrada.asinteger     := 144;
  cds_mensFavoritos.asinteger    := 1;
  cds_mensListaNegra.asinteger   := 0;
  cds_mensSelecionada.AsInteger  := 0;
  cds_mens.post;
end;


cds_mens.next;


end;
cds_mens.filtered := false;
cds_mens.first;
cds_mens.EnableControls;


end;

end;









Procedure TDM_SERVER.PoeMarca(tipo,restore:integer);
begin


//select all tipo 1 restore 0


cds_mens.First;
fmens.JvSpecialProgress1.Maximum := cds_mens.RecordCount;
cds_mens.DisableControls;

if Restore = 0 then
begin
cds_mens.Filter := 'favoritos = 0' ;
cds_mens.filtered := true;
end
else
begin
cds_mens.Filter := ' favoritos = 0 and (Filtrada > 0 or ListaNegra > 0)';
cds_mens.filtered := true;
end;


while not cds_mens.eof do
begin
application.ProcessMessages;
fmens.JvSpecialProgress1.Position := cds_mens.RecNo;
cds_mens.Edit;
cds_mensSelecionada.AsInteger := tipo;
cds_mens.Post;
cds_mens.next;
end;

cds_Mens.Filtered := false;
cds_mens.First;
fmens.JvSpecialProgress1.position := 0;
cds_mens.EnableControls;



{if qpoemarca.active then qpoemarca.Active := false;
if Restore = 0 then
qpoemarca.sql.text := 'update messages set selecionada = :SEL where status = 0 and favoritos = 0' else
qpoemarca.sql.text := 'update messages set selecionada = :SEL where status = 0 and favoritos = 0 and (Filtrada > 0 or ListaNegra > 0)';
qpoemarca.Params[0].AsInteger := Tipo;
qpoemarca.Execute;
cds_Mens.Refresh;}



end;




procedure TDM_SERVER.AbreTodasTabelas;


begin




  if not cds_sigla.Active then cds_sigla.Active := true;

  try
   if not cds_Contas.active then  cds_contas.Active := true;

   cds_Contas.First;


   while not cds_Contas.Eof do
   begin
    cds_Contas.Edit;
    if cds_ContasExcluida.asinteger = 2     then
    begin
    cds_ContasSenha.AsString := EnCrypt_Decrypt('D', cds_ContasSenha.AsString, 'laranja');
    cds_ContasExcluida.AsInteger := 1;
    end;
    cds_Contas.Post;
    cds_Contas.Next;
   end;
   cds_Contas.First;
  except
  end;



  if not cds_pais.active then  cds_pais.Active := true;


  QcontasCon := TClientDataset.Create(nil);
  QcontasCon.CloneCursor(cds_Contas,false,false);

  if not cds_Boxes.active then   cds_Boxes.Active := true;

  qmostraboxes.CloneCursor(cds_Boxes,false,false);
  ds_MostraFG.DataSet := qmostraboxes;
  qmostraboxes.Active := true;




  If not AbreTabelaMens(0) then
     begin
       showmessage('ERROR - File Mens not exists.');
     end;
  cds_mens.EmptyDataSet;


  if not cds_dns.Active then cds_dns.Active := true;
  if not qsetup.Active then qsetup.Active := true;
  if not QcontasCon.Active then QcontasCon.Active := true;
  if not cds_IPSpam_Local.Active then cds_IPSpam_Local.Active := true;

  //if not cds_ALLM.Active then cds_ALLM.Active := true;


  ExcluirPassado;




end;




procedure TDM_SERVER.cds_IpSpam_ServerReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin

 Action := HandleReconcileError(DataSet, UpdateKind, E);


end;

end.

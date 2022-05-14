unit UcriaObjetos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  IdMessage,
  IdBaseComponent, IdComponent, IdTCPConnection,IdTCPClient,
  IdExplicitTLSClientServerBase,
  IdMessageClient, IdPOP3, IdIMAP4, IniFiles;

type


TPOP = class(TidPOP3)
   public
   NomeConta : string;
   IDConta : Integer;
   QtdMens : Integer;
   UIDS    : THashedStringList;
   UIDOK    : THashedStringList;
   UIDNum    : THashedStringList;
   Ticket   : Integer;
   Constructor create;
   Destructor Destroy; override;
 end;


TIMAP = class(TidImap4)
   public
   NomeConta : string;
   IDConta : Integer;
   QtdMens : Integer;
   UIDOK    : THashedStringList;
   UIDNum    : THashedStringList;
   Ticket   : Integer;
   Constructor create;
   Destructor Destroy; override;
 end;



TMSG = class(TidMessage)
   public
     Selecionada     : integer;
     Filtrada        : integer;
     Favorita        : integer;
     ListaNegra      : integer;
     Lida            : integer;
     Excluida        : integer;
     Anexos          : Integer;
     IDConta         : Integer;
     NomeConta       : string;
     UIDOK           : String;
     UIDNum          : Integer;
     IPSender        : string;
     EmailFrom       : string;
     DominioFrom     : string;
     ReceivedFrom    : string;
     Tamanho         : Integer;
     IndiceBayesian  : Double;
     Pais            : String;
     IDMens          : Int64;
     FiltroResultado : THashedStringList;
     FrasesBaesyan   : THashedStringList;
     Constructor create;
     Destructor Destroy; override;
     Procedure Getvariaveis();
     Procedure getFrases();
     Procedure CamposObrigatorios();
     Procedure AprendeBayesian;
     Procedure CarregaDoBanco(IDMSG:Integer);
   Private
     Procedure getEmailFrom();
     Procedure getReceivedFrom();


 end;


implementation

uses Funcoes ;

{ TPOP }

constructor TPOP.create();
begin
  Inherited create(nil);
  Self.UIDS  := THashedStringList.Create;
  Self.UIDOK := THashedStringList.create;
  Self.UIDNum:= THashedStringList.create;
end;

destructor TPOP.destroy;
begin
  Self.UIDS.Free;
  Self.UIDOK.Free;
  Self.UIDNum.Free;
  inherited;
end;

{ TMSG }

procedure TMSG.AprendeBayesian;
begin
  if self.Favorita = 1 then
  begin
    DM_Baysean.Aprenderbayesian(self.FrasesBaesyan.text,2);
  end;
  if self.ListaNegra = 1 then
  begin
    DM_Baysean.Aprenderbayesian(self.FrasesBaesyan.text,1);
  end;

end;

procedure TMSG.CamposObrigatorios();
var
Monta : string;
begin


With dm_server do
begin


Monta := Trim(PegaItensCabec('Return-Path:',self.Headers.Text));
if not buscaRegexp(EmailRegExp,Monta,3) then
           begin
           self.FiltroResultado.Add(' Return-Path: does have a valid E-Mail or missing. '+monta);
           self.Filtrada := 145;
           self.Selecionada := 1;
           end;

Monta := Trim(PegaItensCabec('From:',self.Headers.Text));
if not buscaRegexp(EmailRegExp,Monta,3) then
           begin
           self.FiltroResultado.Add(' From: does have a valid E-Mail or missing '+monta);
           self.Filtrada := 145;
           self.Selecionada := 1;
           end;

Monta := Trim(PegaItensCabec('To:',self.Headers.Text));
if not buscaRegexp(EmailRegExp,Monta,3) then
           begin
           self.FiltroResultado.Add(' To: does have a valid E-Mail or missing. '+monta);
           self.Filtrada := 145;
           self.Selecionada := 1;
           end;


Monta := Trim(PegaItensCabec('Message-Id:',self.Headers.Text));
if monta = '' then Monta := Trim(PegaItensCabec('Message-ID:',self.Headers.Text));

if (length(monta) < 18) and (length(monta) > 0) then
           begin
           self.FiltroResultado.Add(' Message-Id: does have a valid ID or missing. '+monta);
           self.Filtrada := 145;
           self.Selecionada := 1;
           end;



end;
end;

procedure TMSG.CarregaDoBanco(IDMSG: Integer);
begin
  with dm_server do
  begin
    if qMSG.Active then qMSG.close;
    qMSG.params[0].asInteger := IDMSG;
    qMSG.Open;
    if qMSG.RecordCount > 0 then
    begin

      self.NomeConta := qMSGConta.Asstring;
      self.IdConta := qMSGID_Conta.AsInteger;
      self.UIDNum := qMSGNumeromens.AsInteger;
      self.UIDOK := qMSGUID.AsString;

      self.IPSender := qMSGIPSender.AsString;


     // self.Subject := qMSGAssunto.AsString;
     // self.From.Address := qMSGEmitente.AsString;



      self.EmailFrom := qMSGEmailFrom.AsString;

      //self.EmailFrom := qMSGEmitente.AsString;

      self.DominioFrom := qMSGDominioFrom.AsString;

      self.Tamanho := qMSGTama.AsInteger;

      //self.Date := strtodate(qMSGDaTaMens.asstring);



     //self.Organization := qMSGOrganization.asstring;
     self.pais := qMSGCountry.asstring;
     //self.FiltroResultado.Text := qMSGFiltroResult.AsString;
     self.FrasesBaesyan.Text := qMSGFriendResult.AsString;

     self.Headers.Text := qMSGCabec.AsString;
     self.ProcessHeaders;

      {
     qMSGReturnPath.asstring              :=  self.Headers.Values['Return-Path'];
     qMSGReplayTO.asstring                :=  self.Headers.Values['Reply-To'];
     qMSGDataOrig.asstring                :=  self.Headers.Values['Date'];
     qMSGXmailer.asstring                 :=  self.Headers.Values['X-Mailer'];
     qMSGFromOrig.asstring                :=  self.Headers.Values['From'];
     qMSGToOrig.asstring                  :=  self.Headers.Values['To'];
     qMSGCCOrig.asstring                  :=  self.Headers.Values['Cc'];
     qMSGBCCOrig.asstring                 :=  self.Headers.Values['BCC'];
     qMSGReceivedFrom.asstring            :=  self.Headers.Values['Received'];



      self.MsgId := qMSGMsgId.asstring;
      self.IsBodyEmpty := qMSGIsBodyEmpty.asboolean;

     qMSGIsMsgSinglePartMime.asboolean    :=  self.IsMsgSinglePartMime;
     qMSGAttachmentEncoding.asstring      :=  self.AttachmentEncoding;
     qMSGCharSet.asstring                 :=  self.CharSet;
     qMSGContentType.asstring             :=  self.ContentType;
     qMSGContentTransferEncoding.asstring :=  self.ContentTransferEncoding;
     qMSGContentDisposition.asstring      :=  self.ContentDisposition;
     qMSGNoEncode.asboolean               :=  self.NoEncode;
     qMSGNoDecode.asboolean               :=  self.NoDecode;



      qMSGselecionada.AsInteger  := self.Selecionada;
      qMSGExcluida.AsInteger     := self.Excluida;
      qMSGFiltrada.AsInteger     := self.Filtrada;
      qMSGListaNegra.AsInteger   := self.ListaNegra;
      qMSGFavoritos.AsInteger    := self.Favorita;  }
    end;
  end;
end;

constructor TMSG.create;
begin
  Inherited create(nil);
  Self.FiltroResultado  := THashedStringList.Create;
  Self.FrasesBaesyan   := THashedStringList.create;
end;

destructor TMSG.destroy;
begin
  self.FiltroResultado.Free;
  Self.FrasesBaesyan.Free;
  inherited;
end;


procedure TMSG.getEmailFrom;
var
  S:TStringList;
begin
  self.Filtrada := -1;
  s:=TStringList.Create();
  self.Headers.Extract('From',S);
  if S.Count > 0 then
  begin
    self.EmailFrom   :=  ExtrairRegexp(dm_server.EmailRegExp,S[0]);
    self.DominioFrom :=  pegaDominio(self.EmailFrom);
  end;





  s.Free;

end;

procedure TMSG.getReceivedFrom;
Var
  S:String;
  achou:integer;
begin
  s:=PegaItensCabec('Received: from ', self.Headers.Text);
  achou := pos('(',s);
  if achou > 0 then
  begin
    self.ReceivedFrom := copy(s,achou+1,length(s)-achou);
    Self.IPSender := ExtrairRegexp(dm_server.ExtraiIP, self.ReceivedFrom);
  end;
end;

procedure TMSG.Getvariaveis;
begin
  getEmailFrom();
  getReceivedFrom();
end;

procedure TMSG.getFrases;
var
  s:TstringList;
  achou, achou1, achou2:Integer;
  monta:String;
begin



  self.FrasesBaesyan.clear;
  self.FrasesBaesyan.add(self.Subject);
  self.FrasesBaesyan.add(self.EmailFrom);
  self.FrasesBaesyan.add(self.CharSet);
  self.FrasesBaesyan.add(self.Organization);
  self.FrasesBaesyan.add(self.Headers.Values['Reply-To']);
  self.FrasesBaesyan.add(self.Headers.Values['Return-Path']);
  self.FrasesBaesyan.add(StringReplace(self.Headers.Values['X-Mailer'], ' ', '' , [rfReplaceAll]));
  self.FrasesBaesyan.add(Self.IPSender);
  self.FrasesBaesyan.add(self.Pais);

  S:=tstringlist.Create;
  self.Headers.Extract('Message-ID', S);
  if s.Count>0 then
  begin
    achou := pos('@', S[0]);
    if achou > 0 then
    begin
      self.FrasesBaesyan.add(copy(S[0], achou,length(s[0])-achou));
    end;
  end;
  s.Free;




  monta := self.ReceivedFrom;
  achou1 := pos('by ', monta);
  achou2 := pos('with', monta);
  if (achou1 = 1) and (achou2 > 0) then
     begin
     self.FrasesBaesyan.Add(stringreplace(copy(monta,1,achou2-1),' ','',[]));
     end;
  achou1 := pos('from ', monta);
  achou2 := pos('by ', monta);
  if (achou1 = 1) and (achou2 > 0) then
     begin
     self.FrasesBaesyan.Add(stringreplace(copy(monta,1,achou2-1),' ','',[]));
     end;


  monta := PegaItensCabec('DKIM-Signature:', self.Headers.Text);
  if monta <> ''  then self.FrasesBaesyan.Add(monta);

  monta := PegaItensCabec('DomainKey-Signature:', self.Headers.Text);
  if monta <> ''  then self.FrasesBaesyan.Add(monta);

  monta := PegaItensCabec('Sender:', self.Headers.Text);
  if monta <> ''  then self.FrasesBaesyan.Add(monta);


  monta := PegaItensCabec('User-Agent:', self.Headers.Text);
  if monta <> ''  then
  begin
    self.FrasesBaesyan.Add(stringreplace(monta,' ','',[rfReplaceAll]));
  end;

end;

{ TIMAP }

constructor TIMAP.create;
begin
  Inherited create(nil);
  Self.UIDOK := THashedStringList.create;
  Self.UIDNum:= THashedStringList.create;
end;

destructor TIMAP.destroy;
begin
  Self.UIDOK.Free;
  Self.UIDNum.Free;
  inherited;
end;

end.

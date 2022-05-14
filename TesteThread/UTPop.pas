unit UTPop;

interface

uses Classes, MyAccess, IdSchedulerOfThreadDefault, IdScheduler, IdSchedulerOfThread,
  IdSchedulerOfThreadPool, IdThreadComponent, IdPOP3,IdMessage, SysUtils,
  IdCoderHeader, ComCtrls , Generics.Collections,MyEmbConnection;

type

TNuid = class(Tobject)
  public
    Num:Integer;
    UID:String;
    Tamanho : Integer;
end;


TPop = class(TThread)
  private
    Fuser               : string;
    Fsenha              : string;
    FServer             : string;
    FPorta              : integer;
    FPOP                : TIdPop3;
    FMsg                : TIdMessage;
    FUID                : TstringList;
    FConta              : Integer;
    FCon                : TMyEmBconnection;
    queryGrava, queryLe : TMyquery;
    ListaUid            : TList<TNuid>;
    MSGLog              : TStringList;
  protected

    procedure Execute;override;
    procedure GravaMens(UDI:TNuid);
    procedure atualiza;
    function buscaUid(UID:String):Boolean;
  public
    destructor  Destroy; override;
    constructor Create(CreateSuspended: Boolean;server,senha,user:string;
            porta,conta:integer;conexao:TMyEmbConnection);
    procedure Suspend;
    procedure Resume;
end;

Const
  tabela : String = 'messages_thread';

implementation

uses funcoes, udm ,Unit1;



procedure TPop.atualiza;
begin
  system.TMonitor.Enter(dm.Tmem);
  try
    dm.Tmem.Refresh;
    dm.Tmem.Last;
  finally
    System.TMonitor.Exit(dm.Tmem);
  end;
end;

constructor TPop.Create(CreateSuspended: Boolean;server,senha,user:string;porta,conta:integer;conexao:TMyEmbConnection);
begin
inherited Create(CreateSuspended);
self.FreeOnTerminate := false;
Priority := tplower;
Fuser    := user;
Fsenha   := senha;
FServer  := server;
FPorta   := porta;
Fconta   := conta;
FPOP     := TIdPop3.Create(nil);
FMsg     := TidMessage.Create(nil);
FUid     := TstringList.Create;
MSGLog   := TstringList.Create;
ListaUid := TList<TNuid>.Create;
Fmsg.NoEncode := false;
Fmsg.NoDecode := false;
Fpop.Username := Fuser;
Fpop.Password := Fsenha;
Fpop.Host     := Fserver;
Fpop.Port     := FPorta;

//Fpop.Connect;



FCon := conexao;

queryGrava := Tmyquery.Create(nil);
queryGrava.Connection := conexao;

queryGrava.SQL.add('INSERT INTO '+ tabela);
queryGrava.SQL.add('(ID,  DT,  Email,  Assunto,  Emitente,  Tama,');
queryGrava.SQL.add(' Datamens,  Cabec,  Corpo,  `Status`,  Filtrada,');
queryGrava.SQL.add(' ListaNegra,  Favoritos,  FiltroResult,');
queryGrava.SQL.add(' ListaNegraResult,  NumeroMens,  Excluida,  Anexos,');
queryGrava.SQL.add(' selecionada,  Conta,  MsgId,  IsBodyEmpty,  UID,');
queryGrava.SQL.add(' IsMsgSinglePartMime,  AttachmentEncoding,');
queryGrava.SQL.add(' `CharSet` ,  ContentType,  ContentTransferEncoding,');
queryGrava.SQL.add(' ContentDisposition,  NoEncode,  NoDecode,');
queryGrava.SQL.add(' Organization,  DataOrig,  Xmailer,  ReplayTO,');
queryGrava.SQL.add(' ReturnPath,  FromOrig,  ToOrig,  CCOrig,  BCCOrig,');
queryGrava.SQL.add(' ReceivedFrom,  FriendResult,  EmailFrom,  DominioFrom,');
queryGrava.SQL.add(' IPSender,  ID_Conta,  AnexosFiles,  Country,  lida)');
queryGrava.SQL.add('VALUES');
queryGrava.SQL.add('(:ID, :DT, :Email, :Assunto, :Emitente, :Tama,');
queryGrava.SQL.add(' :Datamens, :Cabec, :Corpo, :Status, :Filtrada,');
queryGrava.SQL.add(' :ListaNegra, :Favoritos, :FiltroResult,');
queryGrava.SQL.add(' :ListaNegraResult, :NumeroMens, :Excluida, :Anexos,');
queryGrava.SQL.add(' :selecionada, :Conta, :MsgId, :IsBodyEmpty, :UID,');
queryGrava.SQL.add(' :IsMsgSinglePartMime, :AttachmentEncoding,');
queryGrava.SQL.add(' :CharSet , :ContentType, :ContentTransferEncoding,');
queryGrava.SQL.add(' :ContentDisposition, :NoEncode, :NoDecode,');
queryGrava.SQL.add(' :Organization, :DataOrig, :Xmailer, :ReplayTO,');
queryGrava.SQL.add(' :ReturnPath, :FromOrig, :ToOrig, :CCOrig, :BCCOrig,');
queryGrava.SQL.add(' :ReceivedFrom, :FriendResult, :EmailFrom, :DominioFrom,');
queryGrava.SQL.add(' :IPSender, :ID_Conta, :AnexosFiles, :Country, :lida)');



queryLe := Tmyquery.Create(nil);
queryLe.Connection := conexao;
queryLe.SQL.Add('Select * from '+tabela+' where UID = :UID');


Synchronize(
        Procedure
        Begin
          Form1.memo1.lines.add('Thread: '+inttostr(self.FConta)+' Criada');
        end
    );
//resume;
end;





destructor TPop.Destroy;
begin
  Fpop.Disconnect;
  Fpop.Free;
  FUID.Free;
  FMSG.Free;
  queryGrava.Free;
  queryLe.Free;
  ListaUid.Free;
  inherited;
  Synchronize(
        Procedure
        Begin
          Form1.memo1.lines.add('Thread: '+inttostr(self.FConta)+' Destruida');
        end
    );
    Synchronize(
          procedure
          begin
            system.TMonitor.Enter(form1.PB);
            try
              form1.PB.Max := self.ListaUid.Count;
              form1.PB.Position := 0;
            finally
              system.TMonitor.Exit(form1.PB);
            end;
          end
        );
end;



procedure TPop.GravaMens(UDI:TNuid);
var
I, achou : integer;
Datax      : string;
MontaFrom  : string;
MontaRec   : string;
MontaSub   : ansistring;
begin
  if self.queryLe.Active then self.queryLe.Close;
  self.queryLe.ParamByName('UID').AsString := UDI.UID;
  self.queryLe.open;
  if self.queryLe.RecordCount = 0 then
  begin



   //self.queryGrava.append;



    self.queryGrava.ParamByName('Filtrada').AsInteger := -1;
    self.queryGrava.ParamByName('Anexos').AsInteger   := -1;

    self.queryGrava.ParamByName('Email').AsString       := self.Fuser;
    self.queryGrava.ParamByName('Conta').Asstring       := self.FServer;
    self.queryGrava.ParamByName('ID_Conta').AsInteger   := self.FConta;
    self.queryGrava.ParamByName('NumeroMens').AsInteger := UDI.Num;
    self.queryGrava.ParamByName('UID').AsString         := UDI.UID;
    self.queryGrava.ParamByName('Tama').AsInteger       := UDI.Tamanho;

    try
    montaFrom :=  PegaItensCabec('From:',FMsg.Headers.Text);
    montaRec  :=  PegaItensCabec('Received: from ',FMsg.Headers.Text);
    achou :=  pos('(',montarec);
    if achou > 0 then montarec := copy(montarec,achou+1,length(montarec)-achou);


    except
    end;


    try
//    self.queryGrava.ParamByName('IPSender').AsString := ExtrairRegexp(ExtraiIP,montaRec);
    except
    //showmessage('Pau no extrai IP ');
    end;

    self.queryGrava.ParamByName('Assunto').AsString     := FMsg.Subject;
    self.queryGrava.ParamByName('Emitente').AsString    := FMsg.From.Address;




    {
    edit1.text := PegaItensCabec('Subject:',FMsg.Headers.Text);
    edit2.text := DecodeHeader(edit1.text);
    self.queryGrava.ParamByName('Assunto.AsString := edit2.Text;
    }



    try
    //self.queryGrava.ParamByName('EmailFrom').AsString   := ExtrairRegexp(EmailRegExp,montaFrom);
    except
    end;

    self.queryGrava.ParamByName('Emitente').AsString    := self.queryGrava.ParamByName('EmailFrom').AsString;

    self.queryGrava.ParamByName('DominioFrom').AsString := pegaDominio(self.queryGrava.ParamByName('EmailFrom').AsString);


    try
    //self.queryGrava.ParamByName('Tama').AsInteger    := round(Tama/1024);
    except
    end;



    try
    self.queryGrava.ParamByName('DaTaMens').AsDateTime             := FMsg.Date;
    except
    self.queryGrava.ParamByName('DaTaMens').AsDateTime             := Now;
    end;




    self.queryGrava.ParamByName('Cabec').AsString                   := DecodeHeader(FMsg.Headers.Text);

    {
    IdDateTimeStamp1.SetFromISO8601(FMsg.Headers.Values['Date']);


    showmessage( IdDateTimeStamp1.GetAsRFC822);

    IdMessageDecoderYenc1.SourceStream
    }


    self.queryGrava.ParamByName('Status').AsInteger                 := 0;
    self.queryGrava.ParamByName('ReturnPath').asstring              :=  FMsg.Headers.Values['Return-Path'];
    self.queryGrava.ParamByName('ReplayTO').asstring                :=  FMsg.Headers.Values['Reply-To'];
    self.queryGrava.ParamByName('DataOrig').asstring                :=  FMsg.Headers.Values['Date'];
    self.queryGrava.ParamByName('Xmailer').asstring                 :=  FMsg.Headers.Values['X-Mailer'];
    //GravaXmailer(self.queryGrava.ParamByName('Xmailer').asstring);
    self.queryGrava.ParamByName('FromOrig').asstring                :=  FMsg.Headers.Values['From'];
    self.queryGrava.ParamByName('ToOrig').asstring                  :=  FMsg.Headers.Values['To'];
    self.queryGrava.ParamByName('CCOrig').asstring                  :=  FMsg.Headers.Values['Cc'];
    self.queryGrava.ParamByName('BCCOrig').asstring                 :=  FMsg.Headers.Values['BCC'];
    self.queryGrava.ParamByName('ReceivedFrom').asstring            :=  FMsg.Headers.Values['Received'];
    self.queryGrava.ParamByName('MsgId').asstring                   :=  FMsg.MsgId;
    self.queryGrava.ParamByName('IsBodyEmpty').asboolean            :=  FMsg.IsBodyEmpty;
    self.queryGrava.ParamByName('IsMsgSinglePartMime').asboolean    :=  FMsg.IsMsgSinglePartMime;
    self.queryGrava.ParamByName('AttachmentEncoding').asstring      :=  FMsg.AttachmentEncoding;
    self.queryGrava.ParamByName('CharSet').asstring                 :=  FMsg.CharSet;
    self.queryGrava.ParamByName('ContentType').asstring             :=  FMsg.ContentType;
    self.queryGrava.ParamByName('ContentTransferEncoding').asstring :=  FMsg.ContentTransferEncoding;
    self.queryGrava.ParamByName('ContentDisposition').asstring      :=  FMsg.ContentDisposition;
    self.queryGrava.ParamByName('NoEncode').asboolean               :=  FMsg.NoEncode;
    self.queryGrava.ParamByName('NoDecode').asboolean               :=  FMsg.NoDecode;
    self.queryGrava.ParamByName('Organization').asstring            :=  FMsg.Organization;


    // VerificaFiltros;

    //self.queryGrava.ParamByName('Country').asstring            :=  CaixaMista(pais);
    //pais := '';


    self.queryGrava.ParamByName('Lida').asinteger              := 0;


    //dm_server.TemFiltroNovo := True;


    try
      self.queryGrava.Execute;
    except
      self.Suspend;
      //showmessage('N�o gravou mens '+inttostr(num)+' '+FMsg.Subject+' '+FMsg.Headers.Text);
    end;
  end;
end;


procedure TPop.Resume;
begin
  {Synchronize(
        Procedure
        Begin
          Form1.memo1.lines.add('Thread: '+inttostr(self.FConta)+' Iniciada');

        end
    );

    try
      if not self.FPOP.Connected then self.FPOP.Connect;
    Finally
      inherited;
    end; }
    if not self.FPOP.Connected then self.FPOP.Connect;
    inherited;

end;

procedure TPop.Suspend;
begin

  {//try
    if self.FPOP.connected then self.FPOP.Disconnect;
    self.queryGrava.Close;
    self.queryLe.Close;
    Synchronize(
        Procedure
        Begin
          Form1.memo1.lines.add('Thread: '+inttostr(self.FConta)+' Parou');
        end
    );
  //Finally
    inherited;
  //end; }
  if self.FPOP.connected then self.FPOP.Disconnect;
  inherited;
end;


function TPop.buscaUid(UID: String): Boolean;
var
query : TMyquery;
res :Boolean;
begin
query := TMyquery.Create(nil);
query.Connection := self.FCon;
query.SQL.Add('Select * from '+tabela+' where UID = :UID');


if query.Active then query.Close;
query.Params[0].AsString := UID;
query.Open;

if query.RecordCount = 0 then
begin
  res := false;
end
else
begin
  res := true;
end;

query.Free;
Result := res;




end;



procedure TPop.Execute;
var
  NUid : TNuid;
  I, achou : integer;
  Monta, Num, UIDT    : string;
begin

  while ((not self.terminated) and (self.fpop.Connected)) do
  begin
    Fpop.UIDL(self.FUID);
    for I := 0 to self.FUID.Count - 1 do
    begin
     monta :=  stringreplace(self.FUID[i],#13#10,'',[]);
     achou := pos(' ',monta);
     Num   := copy(monta,1,achou-1);
     UIDT  := copy(monta,achou+1,length(monta)-(achou));
     Nuid := TNuid.Create;
     Nuid.Num := strtoint(Num);
     Nuid.UID := UIDT;
     ListaUid.Add(Nuid);
    end;

    for I := 0 to self.ListaUid.Count - 1 do
    begin
      if not buscaUid(ListaUid.Items[i].UID) then
      begin
        try
          ListaUid.Items[i].Tamanho := Fpop.RetrieveMsgSize(ListaUid.Items[i].Num);
          Fpop.RetrieveHeader(ListaUid.Items[i].Num,FMsg);
          GravaMens(ListaUid.Items[i]);
        except
          self.suspend;
        end;
        Synchronize(atualiza);
        Synchronize(
          procedure
          begin
            system.TMonitor.Enter(form1.PB);
            try
              form1.PB.Max := self.ListaUid.Count;
              form1.PB.Position := i;
            finally
              system.TMonitor.Exit(form1.PB);
            end;
          end
        );
      end;
    end;
    //self.suspend;
  end;
end;


end.
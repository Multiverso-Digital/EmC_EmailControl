﻿

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Grids, JvExGrids, JvStringGrid, Wwdbigrd,
  Wwdbgrid, DB, JvMemoryDataset, Spin, IdMessage,
  IdBaseComponent, IdComponent, IdTCPConnection,IdTCPClient,
  IdExplicitTLSClientServerBase,  IdMessageClient, IdPOP3,
  IdMessageCoderMIME, IdMessageCoder, IdMessageCoderYenc, IdThreadComponent,
  MemDS, DBAccess, MyAccess,  IdAntiFreezeBase, IdAntiFreeze, ExtCtrls,
  Menus, JvComponentBase, JvTrayIcon, JvBalloonHint, IdText,IdAttachment, IdHTTP,
  memdata, JvComCtrls, StrUtils, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
  IdSSLOpenSSL, IdDNSResolver, IdDateTimeStamp,  IdCoder, IdCoder3to4,
  IdCoderMIME,IdCoderBinHex4, IdCoderHeader, IdIMAP4, idMailBox, funcoes,
  IdScheduler, IdSchedulerOfThread, IdSchedulerOfThreadPool, Generics.Collections,
  JvMTComponents, JvThread, JvThreadDialog, JvMTConsts, JvMTThreading,
  JvExControls, wwSpeedButton, wwDBNavigator, wwclearpanel, IdLogEvent, IdException,
  IdGlobal;

type

TMSG = class(TidMessage)
  public
    filtro1 :Integer;
    filtro2 : integer;
    fitlro3 : Integer;
    IP:String;
    Filtro  :TStringList;
    pais    : String;
    Constructor create;
    Destructor Destroy; override;
end;



TpopAbreu = class(tIdPop3)
  Public
    idConta : Integer;
    qtdMens : Integer;
    UIDS    : TStringList;
    constructor create;
    destructor Destroy; override;
end;

  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    PB: TProgressBar;
    wwDBGrid1: TwwDBGrid;
    seTimeToWork: TSpinEdit;
    btnCreate: TButton;
    btnTerminate: TButton;
    Button2: TButton;
    JvMTManager1: TJvMTManager;
    ThreadPegaEmail: TJvMTThread;
    Buffer: TJvMTThreadToVCL;
    Button3: TButton;
    Section: TJvMTCountingSection;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Label1: TLabel;
    JvMTThreadToThread1: TJvMTThreadToThread;
    ThreadFiltraMSG: TJvMTThread;
    JvMTManager2: TJvMTManager;
    SpeedBar: TTrackBar;
    Button7: TButton;
    EIP: TJvIPAddress;
    Memo2: TMemo;
    Label2: TLabel;
    Label3: TLabel;
    JvMTThreadToVCL1: TJvMTThreadToVCL;
    JvMTMonitorSection1: TJvMTMonitorSection;
    IdThreadComponent1: TIdThreadComponent;
    Button8: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCreateClick(Sender: TObject);
    procedure btnTerminateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button2Click(Sender: TObject);
    procedure ThreadPegaEmailExecute(Sender: TJvMTThread;
      MTThread: TJvMTSingleThread);
    procedure Button3Click(Sender: TObject);
    procedure BufferCanRead(Sender: TObject);
    procedure ThreadPegaEmailFinished(Sender: TJvMTThread;
      MTThread: TJvMTSingleThread);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure wwDBGrid1CalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure ThreadFiltraMSGExecute(Sender: TJvMTThread;
      MTThread: TJvMTSingleThread);
    procedure ThreadFiltraMSGFinished(Sender: TJvMTThread;
      MTThread: TJvMTSingleThread);
    procedure SpeedBarChange(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure JvMTThreadToVCL1CanRead(Sender: TObject);
    procedure IdThreadComponent1Run(Sender: TIdThreadComponent);
    procedure Button8Click(Sender: TObject);



  private

FThread:TThread;
Flista: TObjectList<TThread>;
FListaPop: TObjectList<TpopAbreu>;
FSpeed :Integer;
procedure EnableButtons;
procedure OnTerminate(Sender:TObject);


procedure PegaMSG();
function criaPop(Ticket: TMTTicket;Fserver,Fuser,Fsenha:String;Fporta,Fconta:Integer):Boolean;
function buscaPop(Ticket: TMTTicket):TidPop3;
procedure RemovePop(Ticket: TMTTicket);


procedure filtrar();
procedure WaitRandom;
function verifica(IP: String; work : TMSG): Integer;
    function verifica2(IP: String; work: TMSG): Integer;
    procedure POPStatus(ASender: TObject; const AStatus: TIdStatus;
      const AStatusText: string);
    procedure idlogReceived(ASender: TComponent; const AText, AData: string);
    procedure IdLogEvent1Status(ASender: TComponent; const AText: string);
    procedure gravaFimFiltro;
    procedure MyExceptionHandler(Sender: TObject; E: Exception);

//Function VerificaSpamAlf(IP:String; MSG:TMSG):Integer;




    { Private declarations }
  public



    { Public declarations }
end;

TMemo1MSG = class(TObject)
  MSG : String;
end;


TMyThread=class(TThread)
private
Fuser    : string;
Fsenha   : string;
FServer  : string;
FPorta   : integer;
FPOP     : TIdPop3;
FMsg     : TIdMessage;
Ftama    : integer;
Fnum     : Integer;
FUID     : TstringList;
FConta   : Integer;
protected

procedure Execute;override;

public

destructor  Destroy; override;
procedure   GravaMens;
constructor Create(CreateSuspended: Boolean;server,senha,user:string;porta,conta:integer);
end;

TMythread2=class(TThread)
  Private
    FMSg2  : Tidmessage;
  procedure Execute;override;
  public
   constructor Create(CreateSuspended: Boolean;MSG:Tidmessage);
   Destructor Destroy; override;
end;





var
  Form1: TForm1;
  FPOPX : Tidpop3;
  FMSGX : TIdmessage;
implementation

uses udm, UTpop;

{$R *.dfm}






Destructor TMythread2.Destroy;
begin
end;

procedure TMythread2.Execute;
var
  ListaNegra:Integer;
  Amigos:Integer;
  Filtrada:Integer;
begin




end;

constructor TMythread2.Create(CreateSuspended: Boolean;MSG:Tidmessage);
begin
inherited Create(CreateSuspended);
self.freeonterminate := true;
FMSG2 := MSG;
resume;

end;



destructor  TMyThread.destroy;
begin

Fpop.Disconnect;
Fpop.Free;
FUID.Free;
FMSG.Free;
inherited;


end;

constructor TMyThread.Create(CreateSuspended: Boolean;server,senha,user:string;porta,conta:integer);
begin
inherited Create(CreateSuspended);
self.freeonterminate := true;

Priority := tplower;
Fuser    := user;
Fsenha   := senha;
FServer  := server;
FPorta   := porta;
Fconta   := conta;
FPOP     := TIdPop3.Create(nil);
FMsg     := TidMessage.Create(nil);
FUid     := TstringList.Create;
Fmsg.NoEncode := false;
Fmsg.NoDecode := false;
Fpop.Username := Fuser;
Fpop.Password := Fsenha;
Fpop.Host     := Fserver;
Fpop.Port     := FPorta;
Fpop.Connect;
resume;
end;









procedure TMyThread.GravaMens;
begin
 with dm do
 begin
   Tmem.Append;
   TmemNumeroMens.asinteger  := Fnum;
   Tmemselecionada.AsInteger := 0;
   TmemEmitente.Asstring     := FMSG.From.Address;
   TmemAssunto.Asstring      := FMSG.subject;
   TmemTama.Asinteger        := FTama;
   TmemCabec.asstring        := FMSG.Headers.Text;
   TmemUID.asstring          := FUID.Strings[0];
   TmemID_Conta.asinteger    := FConta;
   try
   TmemDataOrig.Asstring     := datetimetostr(FMSG.Date);

   except

   end;
   Tmem.Post;
   sleep(1000);
   //Tmem.ApplyUpdates;
 end;



end;


procedure TMyThread.Execute;
var
Mens, I : Integer;
begin




while not self.terminated do
begin

//application.ProcessMessages;

Mens := Fpop.CheckMessages;
for I := 1 to mens do
  begin
    Ftama := Fpop.RetrieveMsgSize(I);
    Fpop.RetrieveHeader(I,FMsg);
    Fpop.UIDL(Fuid,I);
    FNum  := I;
    //filtrar(UID.strings[0]);
    Synchronize(GravaMens);
  end;

self.suspend;

end;

end;



procedure TForm1.MyExceptionHandler(Sender : TObject; E : Exception );
var
  wRetVal : Word;
begin
  //wRetVal := MessageDlg('EmC-WARNING: ' + E.Message,mtError,mbAbortRetryIgnore, 0);

  case wRetVal of
    mrAbort:
    begin
      //termina;
    end;


    mrRetry:
    begin
      //termina;
    end;

    mrIgnore:
    begin
      //termina;
    end;

    else
    begin

    //termina;

      {
       handle "other" action here...
       for example, if user choose to
       close the message box without
       clicking on any buttons
      }
    end;
  end;

  {
   you could also call the default
   exception handler:

     Application.ShowException( E );
  }
end;



procedure TForm1.OnTerminate(Sender: TObject);
begin

end;



procedure TForm1.EnableButtons;
begin
btnCreate.Enabled:=not Assigned(FThread);
btnTerminate.Enabled:= Assigned(FThread);
end;



procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
dm.Tmem.close;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
dm.MyScript1.Execute;
dm.Tmem.Open;
Flista := TObjectList<TThread>.Create;
FListaPop := TObjectList<TpopAbreu>.Create;
Application.OnException := MyExceptionHandler;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
FSpeed := SpeedBar.Position;
Button7Click(self);
dm.qdns.Open;
//EnableButtons;
end;


procedure TForm1.btnCreateClick(Sender: TObject);
begin


//FThread:=TMyThread.Create(true,'abreuretto.com','aw112233','abreu@abreu retto informatica',110,1);
//FThread:=TMyThread.Create(true,'abreuretto.com','110852','info@abreu retto informatica',110,2);
//FThread:=TMyThread.Create(true,'abreuretto.com','110852','suporte@abreu retto informatica',110,76);
PB.Max := 0;


//Flista.Add(Tpop.Create(true,'abreuretto.com','aw112233','abreu@abreu retto informatica',110,1,dm.MC));
//Flista.Add(TPop.Create(true,'abreuretto.com','110852','suporte@abreu retto informatica',110,76,dm.MC));

//FThread.OnTerminate:=OnTerminate;
//EnableButtons;
//FThread.Resume;

end;

procedure TForm1.btnTerminateClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to Flista.Count - 1 do
  begin
    if Assigned(Flista.Items[i]) then
    begin
      Tpop(Flista.Items[i]).suspend;
    end;
  end;
end;



procedure TForm1.Button1Click(Sender: TObject);
var
Testa : TstringList;
messa, I : integer;
begin




Testa := TstringList.Create;
dm.POP.Connect;
messa := dm.POP.CheckMessages;
PB.Max := messa;
PB.Position := 0;

{
JvStringGrid1.Cells[0,0] := 'ID';
JvStringGrid1.Cells[1,0] := 'From';
JvStringGrid1.Cells[2,0] := 'Subject';
JvStringGrid1.Cells[3,0] := 'KB';
JvStringGrid1.Cells[4,0] := 'Date';
 }



for I:= 1 to messa do
  begin
   PB.Position := i;
   dm.POP.RetrieveHeader(I,dm.MSG);
   with dm do
   begin
   Tmem.Append;
   TmemNumeroMens.asinteger  := I;
   Tmemselecionada.AsInteger := 0;
   TmemEmitente.AsWideString := dm.MSG.From.Address;
   TmemAssunto.AsWideString  := dm.MSG.subject;
   TmemTama.Asinteger        := dm.POP.RetrieveMsgSize(I);
   TmemDataOrig.AsWideString := datetimetostr(dm.MSG.Date);
   Tmem.Post;
   //Tmem.ApplyUpdates;

   end;

  end;

dm.POP.Disconnect;
Testa.free;
PB.Position := 0;
showmessage('Terminou');
end;


procedure TForm1.Button2Click(Sender: TObject);
var
  i: Integer;
begin
for i := 0 to Flista.Count - 1 do
begin
  if Tpop(Flista.Items[i]).Suspended then
  begin
    tpop(Flista.Items[i]).Resume;
  end;

end;
end;


 procedure TForm1.IdLogEvent1Status(ASender: TComponent; const AText: string);
begin
memo2.Lines.Add(AText);
end;


procedure TForm1.POPStatus(ASender: TObject; const AStatus: TIdStatus;
  const AStatusText: string);
begin
  memo2.Lines.Add(AStatusText);
end;



procedure TForm1.idlogReceived(ASender: TComponent; const AText,
  AData: string);
begin
  memo2.Lines.Add(AData);
end;



procedure TForm1.IdThreadComponent1Run(Sender: TIdThreadComponent);
begin
  while not sender.Terminated do
  begin
      WaitRandom;
      memo2.Lines.Add('Esperando....');
      sender.Terminate;
  end;
end;

procedure TForm1.JvMTThreadToVCL1CanRead(Sender: TObject);
var
  m:TMemo1MSG;
begin
  try
    m := JvMTThreadToVCL1.Read as TMemo1MSG;
    memo1.Lines.Add(m.MSG)

  finally
    m.Free;
  end;

end;

function TForm1.criaPop(Ticket: TMTTicket;Fserver,Fuser,Fsenha:String;Fporta,Fconta:Integer):Boolean;
var
  Pop:TpopAbreu;

begin

  POP     := TpopAbreu.Create();

  pop.Username := Fuser;
  pop.Password := Fsenha;
  pop.Host     := Fserver;
  pop.Port     := FPorta;
  Pop.Tag := Ticket;
  Pop.OnStatus := POPStatus;
  Pop.ReadTimeout := 1000;
  try
    Pop.Connect;
    FListaPop.Add(Pop);
    result:=true;
  Except
    Result:=false;
  end;



end;




procedure TForm1.Button3Click(Sender: TObject);
begin
  pb.Style := pbstMarquee;
  ThreadPegaEmail.RunCopy;
  if criaPop(ThreadPegaEmail.Ticket,'abreuretto.com','abreu@abreu retto informatica','aw112233',110,1) then
  begin
    Memo1.Lines.Add('Iniciando Pop com ticket '+IntToStr(ThreadPegaEmail.Ticket));
  end
  else
  begin
    ThreadPegaEmail.Terminate;
  end;



  ThreadPegaEmail.RunCopy;
  if criaPop(ThreadPegaEmail.Ticket,'abreuretto.com','info@abreu retto informatica','110852',110,76) then
  begin
    Memo1.Lines.Add('Iniciando Pop com ticket '+IntToStr(ThreadPegaEmail.Ticket));
  end
  else
  begin
    ThreadPegaEmail.Terminate;
  end;


  ThreadPegaEmail.RunCopy;
  if criaPop(ThreadPegaEmail.Ticket,'pop3.uol.com.br','abreuretto@uol.com.br','kxf700',110,76) then
  begin
    Memo1.Lines.Add('Iniciando Pop com ticket '+IntToStr(ThreadPegaEmail.Ticket));
  end
  else
  begin
    ThreadPegaEmail.Terminate;
  end;






end;

procedure TForm1.Button4Click(Sender: TObject);
var
  I: Integer;
begin
  JvMTManager1.TerminateThreads;
  JvMTManager2.TerminateThreads;
end;


procedure TForm1.Button5Click(Sender: TObject);
var
  i: Integer;
begin
  memo1.Lines.Add(inttostr(Form1.ComponentCount));
  for i := 0 to 1000 do
  begin
    criaPop(ThreadPegaEmail.Ticket,'','','',0,0);
  end;
  memo1.Lines.Add(inttostr(Form1.ComponentCount));
  showmessage('Terminou');
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  I: Integer;
begin
  memo1.Lines.Add(inttostr(Form1.ComponentCount));
  while FListaPop.Count - 1 >= 0 do
  begin
    FListaPop.Delete(0);
  end;
  memo1.Lines.Add(inttostr(Form1.ComponentCount));

end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  //ThreadFiltraMSG.RunCopy;
  //Memo1.Lines.Add('Iniciando Filtro com ticket '+IntToStr(ThreadFiltraMSG.Ticket));
  ThreadFiltraMSG.RunCopy;
  Memo1.Lines.Add('Iniciando Filtro com ticket '+IntToStr(ThreadFiltraMSG.Ticket));
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  IdThreadComponent1.Start;
end;

function TForm1.buscaPop(Ticket: TMTTicket):TidPop3;
var
  I: Integer;
begin
  result := nil;
  for I := 0 to FListaPop.Count - 1 do
  begin
    if FListaPop.Items[i].Tag = Ticket then
    begin
      result:= FListaPop.Items[i];
    end
    else
    begin
      result := nil;
    end;
  end;

end;



procedure TForm1.filtrar;
begin
  with dm do
  begin
    if TmemEmitente.Asstring = 'info@abreuretto.com' then
    begin
      TmemFavoritos.asInteger := 1;
    end
    else if Pos('@gmail.com', TmemEmitente.Asstring)>0 then
    begin
      TmemListaNegra.asInteger := 1;
    end;



  end;
end;


procedure TForm1.BufferCanRead(Sender: TObject);
var
  MSG1 : TMSG;
begin
  MSG1 := Buffer.Read as TMSG;
 try
 with dm do
 begin
   //memo1.Lines.Add(MSG1.From.Address);
   Tmem.Append;
   Tmemselecionada.AsInteger := 0;
   TmemEmitente.Asstring     := MSG1.From.Address;
   TmemAssunto.Asstring      := MSG1.subject;
   TmemCabec.asstring        := MSG1.Headers.Text;
   Tmemid_conta.AsInteger    := MSG1.Tag;
   try
     TmemDataOrig.Asstring     := datetimetostr(MSG1.Date);
   except

   end;

   TmemFavoritos.asInteger := MSG1.filtro1;
   TmemListaNegra.asInteger := MSG1.filtro2;
   TmemFiltroResult.AsString := MSG1.Filtro.Text;
    TmemIPSender.AsString := MSG1.IP;
    TmemEmail.AsString := MSG1.pais;
   //filtrar;
   Tmem.Post;
   //TMem.ApplyUpdates;
    //showmessage(inttostr(TmemID.AsLargeInt));
 end;
 finally
  MSG1.Free;
 end;
end;




















procedure TForm1.ThreadFiltraMSGExecute(Sender: TJvMTThread;
  MTThread: TJvMTSingleThread);
var
  MSG : TMSG;
  montaFrom,montaRec:String;
  achou:Integer;
  ExtraiIP:string;
begin
  try
    while true do
    begin
      CurrentMTThread.CheckTerminate;
      try
        MSG := JvMTThreadToThread1.Read as TMSG;
      Except
        memo1.Lines.Add('PAU no read');
        CurrentMTThread.Terminate;
        //MSG.Free;
      end;
      if MSG.From.Address = 'info@abreuretto.com' then
      begin
         MSG.filtro1 := 1;
      end
      else if Pos('@gmail.com', MSG.From.Address)>0 then
      begin
        MSG.filtro2 := 1;
      end;
      //WaitRandom;


      try
        montaFrom :=  PegaItensCabec('From:',Msg.Headers.Text);
        montaRec  :=  PegaItensCabec('Received: from ',Msg.Headers.Text);
        achou :=  pos('(',montarec);
        if achou > 0 then montarec := copy(montarec,achou+1,length(montarec)-achou);


      except
      end;


      //try
        MSG.IP := ExtrairRegexp('\d{1,3}(\.\d{1,3}){3}',montaRec);
      //except
      //showmessage('Pau no extrai IP ');
      //end;



      //MSG.filtro2 := verifica(MSG.IP, msg);
      //MSG.filtro1 := verifica2(MSG.IP, msg);
      //section.Enter;
      //eip.Text := MSG.IP;
      //eip.Update;
      //MSG.Pais := dm.VePais(eip.Address);
      //section.Leave;
      buffer.Write(MSG);
    end;
  finally
    CurrentMTThread.Terminate;
  end;
end;




procedure TForm1.gravaFimFiltro;
begin

end;


procedure TForm1.ThreadFiltraMSGFinished(Sender: TJvMTThread;
  MTThread: TJvMTSingleThread);
var
  m : TMemo1MSG;
begin
//try
section.Create(memo1);
Memo1.Lines.Add('Terminando Filtro com Ticket '+IntToStr(MTThread.Ticket));
//except

//end;


end;







procedure TForm1.PegaMSG;
var
  MSG:TMSG;
  Pop:TidPop3;
  Mens,I:Integer;
begin
  try
    while true do
    begin
      CurrentMTThread.CheckTerminate;
      Pop := buscaPop(CurrentMTThread.Ticket);
      if pop <> nil then
      begin
        Mens := Pop.CheckMessages;
        for I := 1 to mens do
        begin
            MSG := TMSG.Create();
            msg.NoEncode := false;
            msg.NoDecode := false;


            if pop.RetrieveHeader(I,Msg) then
            begin
              MSG.Tag := CurrentMTThread.Ticket;
              JvMTThreadToThread1.Write(msg);
            end
            else
            begin
              memo2.Lines.Add('Não consegui ler');
            end;
        end;
        CurrentMTThread.Terminate;
      end;
    end;
  finally
    CurrentMTThread.Terminate;
  end;
end;






procedure TForm1.ThreadPegaEmailExecute(Sender: TJvMTThread;
  MTThread: TJvMTSingleThread);
begin
  PegaMSG();
end;



procedure TForm1.RemovePop(Ticket: TMTTicket);
var
  pop: TpopAbreu;
  I,achou,teste:Integer;

begin
  achou := -1;
  for I := 0 to FListaPop.Count - 1 do
    begin
      if FListaPop.Items[i].Tag = Ticket then
      begin
        pop := FListaPop.Items[i];
        achou := i;
        break;
      end;
    end;
  try

    try
      if (achou >= 0) and (Pop.Connected) then
        Pop.Disconnect;
    except
      memo1.Lines.Add('Erro aqui');
    end;
  finally
    if achou >= 0 then
      FListaPop.Delete(achou);
  end;
  Memo1.Lines.Add(IntToStr(FListaPop.Count));
end;


procedure TForm1.SpeedBarChange(Sender: TObject);
begin
FSpeed := SpeedBar.Position;
end;

procedure TForm1.wwDBGrid1CalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
  if dm.tmemFavoritos.asInteger = 1 then
  begin
    ABrush.Color := clMoneyGreen;
    afont.Color := clBlack;
  end;
  if dm.tmemListanegra.asInteger = 1 then
  begin
    ABrush.Color := $00CECEFF;
    afont.Color := clBlack;
  end;
  if Highlight then
  begin
    afont.Color := clwhite;
    ABrush.Color := clGray;
  end;

end;

procedure TForm1.ThreadPegaEmailFinished(Sender: TJvMTThread;
  MTThread: TJvMTSingleThread);
begin

  Memo1.Lines.Add('Terminando Pop com Ticket '+IntToStr(MTThread.Ticket));
  RemovePop(MTThread.Ticket);

    if not JvMTManager1.ActiveThreads then
    begin
      pb.Style := pbstNormal;
    end
    else
    begin
      label1.Caption := 'Continua';
    end;


end;

function TForm1.verifica2(IP:String;work:TMSG):Integer;
var
EIPX:TJVIpaddress;
IdHttp1:TidHTTP;
procura,Xmlr:String;

begin
EIPX := TJVIpaddress.Create(form1);
IdHttp1:=TidHTTP.Create(form1);
 result := -1;
procura := '<p>'+IP+' listed in';

try
XmLR    := IdHttp1.get('http://www.spamcop.net/w3m?action=checkblock&ip='+IP);
except

end;

sleep(100);

  if pos(procura, Xmlr) > 0 then
  begin
     result := 145;
     work.Filtro.Add('Spam IP:'+IP);
     EIPX.ClearAddress;
     EIPX.Text := IP;
     EIPX.Update;
  end;


 idhttp1.Free;
 eipx.Free;
end;







function TForm1.verifica(IP: String; work : TMSG): Integer;
var
XmLR, procura, monta, ipwork: String;
I,J : integer;
errodns : boolean;
EIPX:TJVIpaddress;
IdDNSResolver1 :TidDNSResolver;
IdHttp1:TidHTTP;

begin

Result := -1;

EIPX := TJVIpaddress.Create(form1);
IdDNSResolver1 := TidDNSResolver.Create(Form1);
IdDNSResolver1.QueryType := [qTA];




EIPX.ClearAddress;
EIPX.Text := IP;
EIPX.Update;


monta := inttostr(EIPX.AddressValues.Value4)+'.'+inttostr(EIPX.AddressValues.Value3)+'.'+inttostr(EIPX.AddressValues.Value2)+'.'+inttostr(EIPX.AddressValues.Value1);




IdDNSResolver1.Host := '208.67.220.220';

dm.qdns.First;
while (not DM.qdns.Eof) and (result <> 145)do
begin


errodns := false;

if DM.qdnsactive.AsInteger = 1 then
begin

try
IdDNSResolver1.Resolve(monta+'.'+DM.qdnsdns.asstring);//'relays.ordb.org');
except
errodns:= true;
end;

if not errodns then
begin
  For I:=0 to IdDNSResolver1.QueryResult.Count - 1 do
  begin
    if IdDNSResolver1.QueryResult.Items[i] is TARecord then
       begin
         ipwork := TARecord(IdDNSResolver1.QueryResult.Items[i]).IPAddress;
             if (ipwork = '127.0.0.2') or (ipwork = '127.0.0.4') or
             (ipwork = '127.0.0.5') or (ipwork = '127.0.0.6') or (ipwork = '127.0.0.7') or
             (ipwork = '127.0.0.8') or (ipwork = '127.0.0.10') or (ipwork = '127.0.0.11')
              then
                  begin
                        result := 145;
                        work.Filtro.Add('SPAM IP:'+IP+' found in '+DM.qdnsName.AsString);
                        //DM.GravaIPSpam(IP,EIPX.Address);
                        //break;
                   end
                   else
                   begin
                    work.Filtro.Add('Não achei em: '+DM.qdnsName.AsString);
                   end;
    end;
  end;

end
else
begin
  work.Filtro.Add('IP:'+IP+' not found in '+DM.qdnsName.AsString);
end;
end;

DM.qdns.Next;
end;

    try
IdDNSResolver1.Disconnect;
except
end;

 IdDNSResolver1.Free;

 eipx.Free;
end;

procedure TForm1.WaitRandom;
var
  I: Integer;
begin
  for I := 0 to 5+Random(15) do
  begin
    Sleep(FSpeed);
    //CurrentMTThread.CheckTerminate;
  end;
end;



{ TpopAbreu }

constructor TpopAbreu.create;
begin
  inherited Create(Form1);
  self.UIDS := TstringList.Create;
end;

destructor TpopAbreu.Destroy;
begin
  self.UIDS.Free;
  inherited;
end;






{ TMSG }

constructor TMSG.create;
begin
  inherited Create(Form1);
  self.Filtro := TStringList.create;
end;

destructor TMSG.Destroy;
begin
  self.Filtro.Free;
  inherited;
end;

end.

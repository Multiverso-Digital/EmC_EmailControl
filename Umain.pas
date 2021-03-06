unit Umain;

interface

//Email valido: /^[- \ w. ]+@([ A-Z0-9] [-A-Z0-9] + \.) + [AZ] ($ 2,4 }$/

 //IdIOHandlerStack1.DefStringEncoding  (IDGlobal)

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Ribbon, RibbonLunaStyleActnCtrls, ToolWin, ActnMan, ActnCtrls,
  ImgList, ScreenTips, StdActns, ExtActns, ActnList, ActnMenus, RibbonActnMenus,
  StdCtrls, RibbonActnCtrls, JvExControls, JvEmbeddedForms, IdMessage,
  IdBaseComponent, IdComponent, IdTCPConnection,IdTCPClient,
  IdExplicitTLSClientServerBase,   IdMessageClient, IdPOP3,  IdMessageCoderMIME,
  IdMessageCoder, IdMessageCoderYenc, IdThreadComponent, DB,
  {MemDS, DBAccess,}  funcoes, IdAntiFreezeBase, IdAntiFreeze, ExtCtrls,
  Menus, JvComponentBase, JvTrayIcon, JvBalloonHint, IdText,IdAttachment, IdHTTP,
  {memdata,} JvComCtrls, StrUtils, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack,
  IdSSL,  IdSSLOpenSSL, {IdDNSResolver,} IdDateTimeStamp, Ubayesian, IdCoder,
  IdCoder3to4,  IdCoderMIME,IdCoderBinHex4, IdCoderHeader, IdIMAP4, {idMailBox,}
  IniFiles, JvMTComponents, generics.collections, JvMTConsts, JvMtThreading,
  {IdUserPassProvider, IdSASL, IdSASLUserPass, IdSASL_CRAMBase, IdSASL_CRAM_MD5,}
  UcriaObjetos, UconectaPOP, UconectaIMAP, UDM_DNS, UDM_Avancado, UDM_Baysean,
  shellapi, URefiltrar, MsgHdrCoders, IdHeaderCoder2022JP;

type


  TFmain = class(TForm)
    Ribbon1: TRibbon;
    RibbonPage2: TRibbonPage;
    ilGFX16: TImageList;
    ilGFX16_d: TImageList;
    ilBulletNumberGallery: TImageList;
    ilGFX32: TImageList;
    ilGFX32_d: TImageList;
    RibbonApplicationMenuBar1: TRibbonApplicationMenuBar;
    RibbonGroup1: TRibbonGroup;
    JvEmbeddedFormPanel1: TJvEmbeddedFormPanel;
    POP: TIdPOP3;
    Msg: TIdMessage;
    ActionManager1: TActionManager;
    LunaStyleActn: TAction;
    ObsidianStyleActn: TAction;
    SilverStyleActn: TAction;
    ContasMostrar: TAction;
    MensagensLer: TAction;
    MensagensInterromper: TAction;
    Action8: TAction;
    Action10: TAction;
    Action12: TAction;
    ExcluirSelecionadas: TAction;
    RibbonGroup7: TRibbonGroup;
    IdAntiFreeze1: TIdAntiFreeze;
    ImageList1: TImageList;
    PopupMenu1: TPopupMenu;
    ShowMain1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    JvTrayIcon1: TJvTrayIcon;
    RestoreTimer: TTimer;
    RibbonGroup3: TRibbonGroup;
    IdHTTP1: TIdHTTP;
    EIP: TJvIPAddress;
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    Action4: TAction;
    Action5: TAction;
    Action6: TAction;
    RibbonGroup2: TRibbonGroup;
    Action9: TAction;
    Action13: TAction;
    EIPX: TJvIPAddress;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    Action14: TAction;
    PopupMenu2: TPopupMenu;
    Savetofile1: TMenuItem;
    SaveDialog1: TSaveDialog;
    RibbonGroup4: TRibbonGroup;
    ListBox1: TListBox;
    IMAP4: TIdIMAP4;
    ThreadPOP: TJvMTThread;
    ManagerPegaMSG: TJvMTManager;
    Buffer: TJvMTThreadToVCL;
    ThreadIMAP: TJvMTThread;
    ThreadFiltro1: TJvMTThread;
    ManagerFiltros: TJvMTManager;
    JvMTCountingSection1: TJvMTCountingSection;
    email_Filtro1: TJvMTThreadToThread;
    Filtro1_Filtro2: TJvMTThreadToThread;
    ThreadFiltro2: TJvMTThread;
    Action7: TAction;
    Action11: TAction;
    RibbonQuickAccessToolbar1: TRibbonQuickAccessToolbar;
    procedure Action1Execute(Sender: TObject);
    procedure MensagensLerExecute(Sender: TObject);
    procedure MensagensInterromperExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ExcluirSelecionadasExecute(Sender: TObject);
    procedure ContasMostrarExecute(Sender: TObject);
    procedure Action10Execute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Action12Execute(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure ShowMain1Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure JvTrayIcon1DblClick(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RestoreTimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure Action8Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure Action4Execute(Sender: TObject);
    procedure Action5Execute(Sender: TObject);
    procedure Action6Execute(Sender: TObject);
    procedure Action7Execute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Savetofile1Click(Sender: TObject);
    procedure ThreadPOPExecute(Sender: TJvMTThread;
      MTThread: TJvMTSingleThread);
    procedure ThreadIMAPExecute(Sender: TJvMTThread;
      MTThread: TJvMTSingleThread);
    procedure ThreadFiltro1Execute(Sender: TJvMTThread;
      MTThread: TJvMTSingleThread);
    procedure BufferCanRead(Sender: TObject);
    procedure ThreadPOPFinished(Sender: TJvMTThread;
      MTThread: TJvMTSingleThread);
    procedure ThreadFiltro1Finished(Sender: TJvMTThread;
      MTThread: TJvMTSingleThread);
    procedure ThreadFiltro2Finished(Sender: TJvMTThread;
      MTThread: TJvMTSingleThread);
    procedure ThreadFiltro2Execute(Sender: TJvMTThread;
      MTThread: TJvMTSingleThread);
    procedure ThreadIMAPFinished(Sender: TJvMTThread;
      MTThread: TJvMTSingleThread);
    procedure JvMTThread1Execute(Sender: TJvMTThread;
      MTThread: TJvMTSingleThread);
    procedure Action9Execute(Sender: TObject);
    procedure Action13Execute(Sender: TObject);
    procedure Action11Execute(Sender: TObject);
    procedure Action15Execute(Sender: TObject);

  private

    procedure Termina;
    Procedure DisplayHint(Sender: TObject);
    procedure CriarTstrings;
    procedure DestruirTstrings;
    Procedure CriaFormMens;
    Procedure DestroiFormMens;

    Procedure AbreTodasTabelas;
    Procedure FechaTodasTabelas;
    Procedure LeMensagem;
    Procedure LeContas;
    Procedure ProcessaConta(Conta:Integer);
    Procedure GravaMens(Mens:TMSG);
    Procedure IniciarExcluirMensagens;
    Procedure TransfereExcluidos;
    Procedure Avisa(tipo:integer);
    Procedure SeparaUID;
    Procedure verificaThreadsFiltros();
    procedure CriaThreadFiltro;
//    procedure filtraMSGAntigas;
    procedure abrendeTodos;
    procedure removerTodosPopIMAP(reset:Boolean);


    Function ExcluirMensagens(Conta:Integer;Num:Integer;UIDY:string):Boolean;
    Function ConectaPOP(conta:integer):Boolean;
    function buscaIMAP(Ticket: TMTTicket): TImap;
    function buscaPop(Ticket: TMTTicket): tPop;
    function RemovePOP(Ticket:TmTticket):String;
    function RemoveIMAP(Ticket:TmTticket):String;
    function buscaMSGBodyIMAP(UIDR: string; ID_Conta: Integer): TMSG;
    procedure Terminando;
    procedure MontaEmCFiltro(Mens:TMSG);
    procedure CriaFiltroFriend(Mens: TMSG);



    { Private declarations }
  public

  Cor  : Tcolor;
  Parar   : Boolean;
  Threads_em_execucao : integer;
  entrou              : Boolean;

  UID, UIDOK, UIDNUM : THashedStringList;
  Palavras, PalavrasComple: THashedStringList;
  Fav_Email, Fav_Domain, Black_Email, Black_Domain, MeusEmails, MeusDominios : THashedStringList;
  ListaIMAP : TList<TIMAP>;
  ListaPOP  : TList<TPOP>;
  ListaPais: TList<THashedStringList>;
  ListaPaisaOri: TList<THashedStringList>;
  ListaPaisTudo: TList<THashedStringList>;


  Procedure PiscaLeds;
  Procedure ParaLeds;

  procedure MyExceptionHandler(Sender : TObject; E : Exception );
  procedure GravaIPnoWebService;

  Function EstadoDosBotoesMensagens(Bget,BStop,BDeleted:Boolean):Boolean;

  Function  PoeStatusBar(P0,P1,P2,P3:string):Boolean;
  Function  LeoCorpo(UIDR:string;ID_Conta:Integer):boolean;
  Function  BuscaMSGBodyPOP(UIDR:string;ID_Conta:Integer):TMSG;

  procedure WMSysCommand(var Msg: TWMSysCommand);
  message   WM_SYSCOMMAND;



    { Public declarations }
  end;





var
  Fmain: TFmain;
  TotMens, UIDNumMen, Inicio, Fim , TotAvisa: Integer;
  ErroPOP : Boolean;
  Tama    : Integer;
  S       : WideString;
  S1      : RawByteString;
  Total   : Integer;
  Lida    : integer;

  PopS, senha, usuario, email, conta : string;
  Porta, TotDel               : integer;
  Pais, SiglaX : string;
 // Palavras    : Tbayesian;
  CabecPrefix : array of string;
  PopCapabili : boolean;



implementation

uses UDMSERVER, Umens, UContas, UFavoritos, UFilters, UBlackList, USetUp,
     UDM_FavoNegra, UDM_Pais, UComu, Uabout, UBackup, UdelMsg, Uespera;

{$R *.dfm}


procedure TFmain.WMSysCommand;
begin
   if (Msg.CmdType = SC_MINIMIZE) then
   begin
     Fmain.Hide
   end
   else
   begin
     DefaultHandler(Msg);
   end;
end;


Function TFmain.PoeStatusBar(P0,P1,P2,P3:string):Boolean;
begin
 with Fmens do
 begin
   SB.Panels[0].Text := P0;
   SB.Panels[1].Text := P1;
   SB.Panels[2].Text := P2;
   SB.Panels[3].Text := P2;
 end;
end;





procedure TFmain.MyExceptionHandler(Sender : TObject; E : Exception );
var
  wRetVal : Word;
begin
  wRetVal := MessageDlg('EmC-WARNING or Account disconnected: ' + E.Message,mtError,mbAbortRetryIgnore, 0);

  case wRetVal of
    mrAbort:
    begin
      termina;
    end;


    mrRetry:
    begin
      //termina;
    end;

    mrIgnore:
    begin
     // termina;
    end;

    else
    begin

    termina;

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




procedure TFmain.CriaThreadFiltro;
begin
  ThreadFiltro1.RunCopy;
  ThreadFiltro1.RunCopy;
  ThreadFiltro1.RunCopy;
  ThreadFiltro2.RunCopy;
  ThreadFiltro2.RunCopy;
  ThreadFiltro2.RunCopy;
end;






Procedure Tfmain.DisplayHint(Sender: TObject);
begin
Ribbon1.DocumentName := Application.hint;
end;





Procedure TFmain.PiscaLeds;
begin
fmens.JvLED1.coloroff := clwhite;
fmens.JvLED1.coloron  := clRed;
fmens.JvLED1.active   := true;
fmens.JvLED1.Update;
end;


Procedure TFmain.ParaLeds;
begin
fmens.JvLED1.coloroff := clgreen;
fmens.JvLED1.coloron  := clgreen;
fmens.JvLED1.active   := false;
fmens.JvLED1.Update;
end;





procedure TFmain.Savetofile1Click(Sender: TObject);
begin
if SaveDialog1.Execute then
   begin
   ListBox1.Items.SaveToFile(SaveDialog1.FileName);
   end;
end;




Procedure TFmain.SeparaUID;
var
I, achou : integer;
Monta, Num, UIDT    : string;
begin

UIDOK.Clear;
UIDNUM.Clear;

for I := 0 to UID.Count - 1 do
   begin
     monta :=  stringreplace(UID.Strings[i],#13#10,'',[]);
     achou := pos(' ',monta);
     Num   := copy(monta,1,achou-1);
     UIDT  := copy(monta,achou+1,length(monta)-(achou));
     UIDOK.Add(UIDT);
     UIDNUM.Add(Num);
   end;
end;






Function  TFmain.ConectaPOP(Conta:integer):Boolean;
var
POP:TPOP;
IMAP:TIMAP;
begin

Result := true;

if DM_Server.PegaContasPOP(Conta) then
begin
   if dm_server.QContasCon.FieldByName('Tipo').AsString = 'IMAP' then
      begin
        IMAP := inicializaIMAP(Conta);
        if IMAP <> nil then
        begin
          ThreadIMAP.RunCopy;
          if CriaIMAP(IMAP,ThreadIMAP.Ticket) = nil then
          begin
            ManagerPegaMSG.ReleaseThread(ThreadIMAP.Ticket);
            Fmain.ListBox1.Items.add('('+inttostr(ThreadIMAP.Ticket)+')ERROR: CANNOT CONNECT TO '+dm_server.QContasCon.FieldByName('Nome').AsString);
            Fmain.ListBox1.itemindex := Fmain.ListBox1.items.Count-1;
            Result := false;
            paraleds;
            exit;
          end
          else
          begin
            piscaleds;
            Result := true;
          end;
        end;
      end
      else
      begin
       POP := inicializaPOP(Conta);
       if POP <> nil then
       begin
         ThreadPOP.RunCopy;
         If  CriaPOP(POP,ThreadPOP.Ticket) = nil then
         begin
           ManagerPegaMSG.ReleaseThread(ThreadPOP.Ticket);
           Fmain.ListBox1.Items.add('('+inttostr(ThreadPOP.Ticket)+')ERROR: CANNOT CONNECT TO '+dm_server.QContasCon.FieldByName('Nome').AsString);
           Fmain.ListBox1.itemindex := Fmain.ListBox1.items.Count-1;
           Result := false;
           paraleds;
           exit;
         end
         else
         begin
            Result := true;
         end;
        end;
      end;
end;

end;











Function TFmain.BuscaMSGBodyPOP(UIDR:string;ID_Conta:Integer):TMSG;
var
POPwork:TPOP;
MSGWork:TMSG;
achou : Integer;
RAW:TStringList;
Anexos:TStringlist;
begin

  result:=nil;
  POPwork := inicializaPop(ID_Conta);
  if Popwork <> nil then
  begin
    POPwork := CriaPOP(POPwork,-1);
  end
  else
  begin
    exit;
  end;

  if POP <> nil then
  begin
    achou :=  POPwork.UIDOKLida.IndexOf(UIDR);
    if achou >= 0 then
    begin
      MSGwork := TMSG.create;
      MSGWork.Noencode := false;
      MSGWork.NoDecode := false;
      RAW     := TstringList.Create;
      Anexos  := TstringList.Create;
      try
        POPwork.RetrieveRaw(strtoint(POPwork.UIDNumLida.strings[achou]),RAW);
      except
        showmessage('Cannot read body '+POPwork.UIDNumLida.strings[achou]);
        listbox1.Items.Add('ERROR: Disconnected from server');
        listbox1.ItemIndex := listbox1.items.count -1;
        Result := nil;
        RAW.Free;
        Anexos.Free;
        MSGwork.free;
        removerTodosPopIMAP(false);
        screen.Cursor := crDefault;
        exit;
      end;  //end Try
      try
        RAW.SaveToFile(dm_server.dire+'Anexos\R_'+inttostr(dm_server.cds_mensID.AsVariant)+'.txt');
      except
        showmessage('Cannot read body '+POPwork.UIDNumLida.strings[achou]);
        listbox1.Items.Add('ERROR: File not saved');
        listbox1.ItemIndex := listbox1.items.count -1;
        Result := nil;
        RAW.Free;
        Anexos.Free;
        MSGwork.free;
        removerTodosPopIMAP(false);
        screen.Cursor := crDefault;
        exit;
      end;
      try
        MSGwork.LoadFromFile(dm_server.dire+'Anexos\R_'+inttostr(dm_server.cds_mensID.AsVariant)+'.txt',false);
      Except
        showmessage('Cannot read body '+POPwork.UIDNumLida.strings[achou]);
        listbox1.Items.Add('ERROR: File not found');
        listbox1.ItemIndex := listbox1.items.count -1;
        Result := nil;
        RAW.Free;
        Anexos.Free;
        MSGwork.free;
        removerTodosPopIMAP(false);
        screen.Cursor := crDefault;
        exit;
      end;
      MSGwork.ProcessHeaders;
      MSGwork.UIDNum := strtoint(POPwork.UIDNumLida.strings[achou]);
      listbox1.Items.Add('Get Body Msg '+POPwork.UIDNumLida.strings[achou]+' '+datetimetostr(now));
      listbox1.ItemIndex := listbox1.Items.Count-1;
      result:=MSGWork;
      removerTodosPopIMAP(false);
    end;
  end //end if POP <> nil
  else
  begin
    Result := nil;
    removerTodosPopIMAP(false);
    exit;
  end; // end else POP<>nil



end;

function TFmain.buscaMSGBodyIMAP(UIDR:string;ID_Conta:Integer):TMSG;
var
IMAPWork:TIMAP;
MSGWork:TMSG;
achou : Integer;
Testa : string;
RAW : TstringList;
begin


  result:=nil;

  Raw := TstringList.Create;




  IMAPwork := inicializaIMAP(ID_Conta);
  if IMAPwork <> nil then
  begin
    IMAPwork := CriaIMAP(IMAPwork,-1);
  end
  else
  begin
    exit;
  end;


  if IMAPwork <> nil then
  begin
    achou :=  IMAPwork.UIDOKLida.IndexOf(UIDR);
    if achou >= 0 then
      MSGwork := TMSG.create;
      MSGWork.Noencode := false;
      MSGWork.NoDecode := false;
      try
        IMAPwork.UIDRetrievePeek(IMAPwork.UIDOKLida.strings[achou],MSGwork);
        IMAPwork.UIDRetrieveTextPeek(IMAPwork.UIDOKLida.strings[achou],Testa);
      except
        showmessage('Cannot read body '+IMAPwork.UIDOKLida.strings[achou]);
        listbox1.Items.Add('ERROR: Disconnected from server');
        listbox1.ItemIndex := listbox1.items.count -1;
        Result := nil;
        MSGwork.free;
        removerTodosPopIMAP(false);
        screen.Cursor := crDefault;
        exit;
      end;
      Raw.Add(MSGwork.Headers.text);
      Raw.Add(Testa);
      try
        RAW.SaveToFile(dm_server.dire+'Anexos\R_'+inttostr(dm_server.cds_mensID.AsVariant)+'.txt');
      Except
        showmessage('Cannot read body '+IMAPwork.UIDOKLida.strings[achou]);
        listbox1.Items.Add('ERROR: File not saved');
        listbox1.ItemIndex := listbox1.items.count -1;
        Result := nil;
        MSGwork.free;
        removerTodosPopIMAP(false);
        screen.Cursor := crDefault;
        exit;
      end;
      RAW.Free;
      MSGwork.UIDNum := strtoint(IMAPwork.UIDNumLida.strings[achou]);
      listbox1.Items.Add('Get Body Msg '+IMAPwork.UIDNumLida.strings[achou]+' '+datetimetostr(now));
      listbox1.ItemIndex := listbox1.Items.Count-1;
      result:=MSGWork;
      removerTodosPopIMAP(false);
    end
  else
  begin
    Result := nil;
    removerTodosPopIMAP(false);
    exit;
  end; // end else IMAP<>nil
end;





Function TFmain.LeoCorpo(UIDR:string;ID_Conta:Integer):boolean;
var
achou, I : integer;
RAW, anexos   : TstringList;
Arquivo, SHTML, STEXTO : string;
//Testa : RawByteString;
POPwork   : TPOP;
IMAPwork  : TIMAP;
MSGWork:TMSG;

begin

  Result := True;

 Anexos := TstringList.Create;

  with dm_server do
  begin

    if PegaContasPOP(ID_Conta) then
    begin


      if dm_server.QContasCon.FieldByName('Tipo').AsString <> 'IMAP' then
      begin

        MSGWork := BuscaMSGBodyPOP(UIDR,ID_Conta);


      end //end if tipo <> IMAP
      else
      begin

        MSGWork := BuscaMSGBodyIMAP(UIDR,ID_Conta);

      end; //end else if tipo <> IMAP


      if Msgwork <> nil then
      begin


        Cds_Mens.Edit;
        Cds_MensLida.AsInteger := 1;
        cds_mensNumeroMens.AsInteger := MSGwork.UIDNum;
        SHTML :='';
        STEXTO := '';



        if Msgwork.MessageParts.Count > 0 then
        begin
          for I := 0 to Msgwork.MessageParts.Count-1 do
          begin
            if Msgwork.MessageParts[I] is TIdText then
            begin
                  if TIdText(Msgwork.MessageParts[I]).ContentType = 'text/html' then
                  begin
                    SHTML := TIdText(Msgwork.MessageParts[I]).Body.text;
                  end
                  else
                  begin
                    STEXTO := TIdText(Msgwork.MessageParts[I]).Body.text;
                  end;

            end; //end Msg.MessageParts[I] is TIdText
            if Msgwork.MessageParts.Items[I] is TIDAttachment then
            begin
              Arquivo := (Msgwork.MessageParts.Items[I] as TIDAttachment).Filename;
              anexos.add(Arquivo);
              (Msgwork.MessageParts.Items[I] as TIDAttachment).SaveToFile(dire+'Anexos\A_'+inttostr(cds_mensID.AsVariant)+'_'+arquivo);
            end; // end MSG.MessageParts.Items[I] is TIDAttachment
          end; //end for

          if SHTML <> '' then
          begin
            Cds_MensCorpoTexto.AsString  := SHTML;
            Cds_MensCorpo.AsString  := STEXTO;
          end
          else
          begin
            Cds_MensCorpoTexto.AsString  := STEXTO;
            Cds_MensCorpo.AsString  := STEXTO;
          end;

          if Anexos.count > 0 then
          begin
            Cds_MensAnexosfiles.asstring   := Anexos.Text;
            Cds_MensAnexos.AsInteger       := 146;
          end;
        end
        else
        begin
          if buscaRegexp('<(/|)(table|html|div)>',Msgwork.Body.text,3) then
             begin
             Cds_MensCorpo.AsString      :=  '';
             Cds_MensCorpoTexto.AsString :=  Msgwork.Body.text;
             end
             else
             begin
             Cds_MensCorpo.AsString      :=  Msgwork.Body.text;
             Cds_MensCorpoTexto.AsString :=  Msgwork.Body.text;
             end;


        end; //end MSG.Messageparts.count > 0

        //desconectapop;

        //Cds_MensCorpoTexto.AsString := STEXTO;
        Cds_Mens.Post;
          //CDS_Mens.ApplyUpdates;
          //CDS_Mens.RefreshRecord;
          //RAW.Free;
        MSG.Free;
        Anexos.Free;
          //Anexos.Free;







      end // fim MSG <> nil
      else
      begin
        result:=false;
      end;


    end; // fim pegaContapop


  end;  //fim with


end;  //fim function



procedure TFmain.Close1Click(Sender: TObject);
begin
Fmain.Hide;
end;









Function  TFmain.EstadoDosBotoesMensagens(Bget,BStop,BDeleted:Boolean):Boolean;
begin
MensagensLer.Enabled          := Bget;
MensagensInterromper.Enabled  := Bstop;
ExcluirSelecionadas.Enabled   := BDeleted;
Result := true;
end;







procedure TFmain.AbreTodasTabelas;
var
zeros,I,achou : integer;
monta         : string;

ListaPaisWork, ListaPaisaOriwork, ListaPaisTudoWork:THashedStringList;
divisao,total:Integer;

begin

  divisao := trunc(dm_server.Cds_pais.RecordCount / 10);




  palavras.LoadFromFile(dm_server.dire+'conf/palavras.dat', TEncoding.Unicode);
  palavrasComple.LoadFromFile(dm_server.dire+'conf/palavrasComple.dat',TEncoding.Unicode);

  RestoreTimer.interval := Round(dm_server.qsetupminutes.asinteger * 60000);
total := 0;



with dm_server do
begin
  Cds_pais.First;
while not Cds_pais.eof do
begin


  if total = 0 then
  begin
    ListaPaisWork:=THashedStringList.create;
    ListaPaisaOriwork:=THashedStringList.create;
    ListaPaisTudoWork:=THashedStringList.create;
  end;

  total := total + 1;

 tama  := length(inttostr(Cds_paisIPNUMFROM.aslargeint));
 zeros :=  10 - tama;
 monta := '';
 for I := 1 to zeros do
   begin
    Monta := monta +'0';
   end;
 monta := monta + inttostr(Cds_paisIPNUMFROM.aslargeint);


 ListaPaisWork.Add(monta);
 ListaPaisaOriwork.add(monta);
 monta := inttostr(Cds_paisIPNUMFROM.aslargeint)+';';
 monta := monta+inttostr(Cds_paisIPNUMTO.aslargeint)+';';
 monta := monta+cds_paissigla.asString+';';
 monta := monta+cds_paismpais.asString;
 ListaPaisTudoWork.add(monta);
 Cds_pais.Next;

  if (total >= divisao) or (Cds_pais.eof) then
  begin

    ListaPais.add(ListaPaisWork);
    ListaPaisaOri.Add(ListaPaisaOriwork);
    ListaPaisTudo.Add(ListaPaisTudoWork);
    total := 0;
  end;


end;

 Cds_pais.first;

 Cds_contas.first;
 while not cds_contas.eof do
 begin
 MeusEmails.add(uppercase(cds_ContasEmail.asstring));
 MeusDominios.add(pegadominio(uppercase(cds_ContasEmail.asstring)));
 cds_contas.next;
 end;
 Cds_contas.first;

end;









end;


procedure TFmain.GravaIPnoWebService;
var
ErroServer : boolean;
Conta      : integer;
begin

with dm_server do
begin

 cds_IPSpam_Local.first;
 FComu.PB.Max := cds_IPSpam_Local.RecordCount;
 Fcomu.PB.Visible := true;
 FComu.PB.position := 0;
 PiscaLeds;

 conta := 0;

 while not cds_IPSpam_Local.eof do
 begin

 application.ProcessMessages;

 conta := conta + 1;

 FComu.PB.position := Conta;
 Fcomu.Panel2.caption := 'Sending '+Inttostr(conta)+' of '+inttostr(FComu.PB.Max);


    erroserver := false;

   try
    if cds_IPSpam_Server.Active  then  cds_IPSpam_Server.Active := false;
     cds_IPSpam_Server.Params[0].AsLargeInt := cds_IPSpam_LocalIPDecimal.AsLargeInt;
     cds_IPSpam_Server.Params[1].AsString   := cds_IPSpam_LocalIP.AsString;
     cds_IPSpam_Server.Params[2].AsLargeInt := cds_IpSpam_LocalQTD.AsInteger;
     cds_IPSpam_Server.Execute;

    except
     erroserver := true;
     showmessage('Insert Error');
    end;

 if not erroserver  then cds_IPSpam_Local.delete else  cds_IPSpam_Local.Next;

 Fcomu.Repaint;

 end;

  ParaLeds;
  FComu.PB.position := 0;
  Fcomu.PB.Visible := true;

end;


end;


procedure TFmain.FechaTodasTabelas;
begin


with dm_server do
begin


  try
   cds_Contas.First;
   while not cds_Contas.Eof do
   begin
   cds_Contas.Edit;
   if cds_ContasExcluida.AsInteger = 1 then
   Begin
   cds_ContasSenha.AsString := EnCrypt_Decrypt('E', cds_ContasSenha.AsString, 'laranja');
   cds_ContasExcluida.AsInteger := 2;
   end;
   cds_Contas.Post;
   cds_Contas.Next;
   end;
   cds_Contas.First;
  except
  showmessage('Cannot save the Accounts file');
  end;


  if  cds_Contas.active then  cds_contas.Active := false;
  if  cds_Boxes.active then   cds_Boxes.Active  := False;
  if  cds_Mens.active then    cds_Mens.Active := false;
  if  cds_sigla.Active then    cds_sigla.Active := false;
  if  cds_dns.Active then        cds_dns.Active := false;
  qsetup.Edit;
  qsetupQTDOK.asInteger := dm_server.TotOK;
  qsetupQTDBad.asInteger := dm_server.TotBad;
  qsetup.Post;
  if  qsetup.Active then      qsetup.Active := false;
  if  QContasCon.active then   QContasCon.Active := false;
  if  cds_IPSpam_Local.active then   cds_IPSpam_Local.Active := false;
  if  cds_ALLM.Active then cds_ALLM.Active := false;
  if  cds_pais.active then  cds_pais.Active := false;
end;

  try
  palavras.savetoFile(dm_server.dire+'Conf/palavras.dat', TEncoding.Unicode);
  palavrasComple.savetoFile(dm_server.dire+'Conf/palavrasComple.dat', TEncoding.Unicode);
  except
  showmessage('Cannot save the words Baysean data file');
  end;



end;




Procedure TFmain.TransfereExcluidos;
var
I : integer;
begin


PiscaLeds;


with dm_server do
begin


if not cds_AllM.active then  cds_AllM.active := true;
cds_AllM.Last;




cds_Mens.Filter := 'Excluida = 1';
cds_mens.Filtered := true;
cds_mens.First;

Fmens.JvSpecialProgress1.Maximum :=  cds_Mens.RecordCount;
Fmens.JvSpecialProgress1.Position := 0;


cds_mens.DisableControls;


 while not cds_mens.Eof do
 begin
 Application.ProcessMessages;
 Fmens.JvSpecialProgress1.Position := cds_Mens.recno;
   if cds_mensExcluida.AsInteger = 1 then
   begin
   cds_AllM.Append;
     for I:=0  to cds_ALLM.FieldCount - 1 do
       begin
         cds_ALLM.Fields[i].value := cds_Mens.Fields[i].Value;
       end;
   Cds_AllM.Post;
   Cds_Mens.Delete;
   end
   else
   begin
   cds_mens.Next;
   end;
 end;
 Fmens.JvSpecialProgress1.Position := 0;
 cds_mens.Filtered := false;
 cds_mens.EnableControls;
 Cds_Mens.First;

 cds_AllM.close;


end;

end;


procedure TFmain.removerTodosPopIMAP(reset:Boolean);
var
  I: Integer;
begin


 if reset then
    begin
     with dm_server do
     begin

    cds_mens.DisableControls;
    cds_Mens.Filter := 'excluida = 1';
    cds_Mens.filtered := true;
    cds_mens.First;

    fmens.JvSpecialProgress1.Maximum := cds_mens.recordcount;

    while not cds_Mens.eof do
     begin
    application.ProcessMessages;
    fmens.JvSpecialProgress1.position := cds_mens.recno;
    cds_Mens.Edit;
    cds_MensExcluida.AsInteger := 0;
    //cds_mensFiltrada.AsInteger := -1;
    cds_Mens.Post;
    cds_mens.Next;
     end;

    fmens.JvSpecialProgress1.Position := 0;
    cds_Mens.Filtered := false;
    cds_mens.EnableControls;
    cds_mens.First;
    end;



    end;


  for I := 0 to ListaPOP.Count - 1 do
  begin
    if reset then
    begin
        ListaPOP[i].Reset;
    end;
    try
        ListaPOP[i].DisconnectNotifyPeer;
        ListaPOP[i].Free;
    Except

    end;
  end;

  ListaPop.Clear;



    for I := 0 to ListaIMAP.Count - 1 do
  begin
    if not reset then
    begin
        ListaIMAP[i].ExpungeMailBox;
    end;
    try
        ListaIMAP[i].DisconnectNotifyPeer;
        ListaIMAP[i].Free;
    Except

    end;
  end;
  ListaIMAP.Clear;


end;



Function TFmain.ExcluirMensagens(Conta:Integer;Num:Integer;UIDY:string):Boolean;
var
achou : integer;
POP   : TPOP;
IMAP4 : TImap;
begin
  Result := false;
  with dm_server do
  begin


    if Not PegaContasPOP(conta) then
    begin
      exit;
    end;
    if dm_server.QContasCon.FieldByName('Tipo').AsString <> 'IMAP' then
    begin
      POP := InicializaPOP(conta);
      if POP <> nil then
      begin
        POP := CriaPOP(POP,-1);
      end
      else
      begin
        Result := False;
        exit;
      end;

      if  POP <> nil then
      begin
        POP := criaPop(POP,-1);
        achou :=  POP.UIDOKLida.IndexOf(UIDY);
        if achou >= 0 then
        begin
          try
            POP.Delete(strtoint(POP.UIDNUMLida.strings[achou]));
          except
            showmessage('Cannot delete '+POP.UIDNUMLida.strings[achou]);
            Result := False;
            exit;
          end;

        end
        else
        begin
          Fmain.ListBox1.Items.add('ERROR: CANNOT CONNECT TO '+dm_server.QContasCon.FieldByName('Nome').AsString);
          Fmain.ListBox1.itemindex := Fmain.ListBox1.items.Count-1;
          Result := False;
          exit;

        end;
      end;
    end
    else
    begin
      IMAP4 := InicializaIMAP(conta);
      if IMAP4 <> nil then
      begin
        IMAP4 := CriaImap(IMAP4,-1);
      end
      else
      begin
        Result := False;
        exit;
      end;


      if IMAP4 <> nil then
      begin
        achou :=  IMAP4.UIDOKLida.IndexOf(UIDY);
        if achou >= 0 then
        begin
          try
            imap4.UIDDeleteMsg(IMAP4.UIDOKLida.strings[achou]);
          except
            showmessage('Cannot delete '+IMAP4.UIDOKLida.strings[achou]);
            Result := False;
            exit;
          end;
        end;
      end
      else
      begin
        Fmain.ListBox1.Items.add('ERROR: CANNOT CONNECT TO '+dm_server.QContasCon.FieldByName('Nome').AsString);
        Fmain.ListBox1.itemindex := Fmain.ListBox1.items.Count-1;
        Result := False;
        exit;
      end;
    end;
    Result := true;
  end;
end;








Procedure TFmain.IniciarExcluirMensagens;
var
TemUP : boolean;
  p : TBayesian;
begin





TemUP := false;

TotDel := 0;


Piscaleds;


Fmens.wwDBGrid1.Enabled := false;


With DM_Server do
begin

  if cds_Mens.State = dsEdit then
     begin
       cds_Mens.post;
     end;


  Fmens.JvSpecialProgress1.Maximum := cds_Mens.recordcount;

  Cds_Mens.First;

  p :=TBayesian.create();

  while not cds_Mens.eof do
  begin

   application.ProcessMessages;


  // if FastDelete = 1 then cds_Mens.DisableControls;




   if parar then
   begin
    // p.Free;
     break;
   end;

   if (Cds_Mensselecionada.AsInteger <> 0) and
       (Cds_Mensexcluida.AsInteger = 0)    then
       begin
         If ExcluirMensagens(cds_MensID_Conta.AsInteger,cds_MensNumeroMens.AsInteger,Cds_MensUID.asstring) then
         begin
          Cds_Mens.Edit;

          if cds_mensaprendeu.AsInteger <> 1 then
          begin
          if cds_mensFavoritos.AsInteger = 1 then
             begin
             p.learn(cds_menspalavrasBaysean.asString,2);
             cds_mensaprendeu.AsInteger := 1;
             end
             else
             begin
             p.learn(cds_menspalavrasBaysean.asString,1);
             cds_mensaprendeu.AsInteger := 1;
             end;
          end;
          TotDel := Totdel + 1;
          Fmens.SB.Panels[0].Text := 'Deleted Total: '+inttostr(TotDel);
          Fmens.SB.Panels[1].Text := 'Account: '+DM_Server.qContasCon.FieldByName('Nome').AsString;
          Fmens.SB.Panels[2].Text := 'To: '+dm_server.qContasCon.FieldByName('Email').asstring;
          Fmens.SB.Panels[3].Text := '';
          Fmens.JvSpecialProgress1.Position := Totdel;
          Cds_MensExcluida.AsInteger    := 1;
          Cds_MensFiltrada.AsInteger    := 130;
          Cds_Mensselecionada.AsInteger := 0;
          cds_mensDT.asdatetime         := now;
          cds_mens.Post;
          TemUP := true;
         end
         else
         begin
         cds_mens.Next;
         end;
       end
       else
       begin
       cds_mens.Next;
       end;
  end;

P.Free;

Fespera.show;
Fespera.Animate1.Active := true;
Fespera.Update;


cds_mens.First;

removerTodosPopIMAP(False);

Fmens.JvSpecialProgress1.Position := 0;

TransfereExcluidos;


try
cds_mens.close;
cds_mens.Open;
except

showmessage('EmC-ERROR Message Files Corrupted. Restore files');

end;


Fmens.wwDBGrid1.Enabled := true;
cds_mens.First;

 try
  palavras.savetoFile(dm_server.dire+'Conf/palavras.dat', TEncoding.Unicode);
  palavrasComple.savetoFile(dm_server.dire+'Conf/palavrasComple.dat', TEncoding.Unicode);
  except
  showmessage('Cannot save the words Baysean data file');
  end;


Fespera.Animate1.Active := false;
Fespera.hide;
Paraleds;



end;



end;







procedure TFmain.JvTrayIcon1DblClick(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
ShowMain1Click(self);
end;

procedure TFmain.ExcluirSelecionadasExecute(Sender: TObject);
begin


 if Dialogs.MessageDlg('WARNING: All selected messages wil be deleted. Are You Sure?',
    mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrNo then
  begin

  exit;




  end;


parar := false;

RestoreTimer.Enabled := false;
EstadoDosBotoesMensagens(False,True,False);
Action1Execute(self);

IniciarExcluirMensagens;
EstadoDosBotoesMensagens(True,False,True);
TotAvisa := 0;
if dm_server.Cds_Mens.Locate('Selecionada',1,[])  then
   begin
   EstadoDosBotoesMensagens(True,False,True);
   end;



end;

procedure TFmain.Exit1Click(Sender: TObject);
begin
Terminando;
end;

procedure TFmain.FormActivate(Sender: TObject);
begin
Application.OnHint := DisplayHint;
end;


procedure TFmain.Terminando;
begin
if (fmens.wwDBGrid1.Enabled = False) or (Threads_em_execucao > 0) or
   (ManagerPegaMSG.ActiveThreads) then
   begin
     showmessage('Please wait process terminate...');
     try
     ManagerPegaMSG.TerminateThreads;
     ManagerFiltros.TerminateThreads;
     fmens.wwDBGrid1.Enabled := true;
     Threads_em_execucao := 0;
     except
     showmessage('Pau');
     end;
     RestoreTimer.Enabled := false;
     Parar := true;
     application.ProcessMessages;
     exit;
   end
   else
   begin
 //    canclose := true;
   end;



ManagerPegaMSG.TerminateThreads;
ManagerFiltros.TerminateThreads;
RestoreTimer.Enabled := false;
Parar := true;
application.ProcessMessages;
FechaTodasTabelas;
DestruirTstrings;
DestroiFormMens;
Application.Terminate;




end;




procedure TFmain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin

canclose := false;
RestoreTimer.Enabled := true;
JvTrayIcon1.HideApplication;

end;


procedure TFmain.DestruirTstrings;
begin
try
//Filtros.free;
UID.free;
UIDOK.free;
UIDNUM.free;
//VeUID.free;
//Frases.Free;
//TCabec.Free;
//CorpoTop.free;
//POPCapa.Free;
Palavras.Free;
PalavrasComple.free;
ListaIMAP.Free;
ListaPOP.Free;
//GuardaMens.free;
//MensTMP.Free;
ListaPais.Free;
ListaPaisaOri.free;
ListaPaisTudo.Free;
MeusEmails.free;
MeusDominios.Free;

try
Fav_Email.SaveToFile(dm_server.Dire+'Conf/Fav_Email.dat',TEncoding.Unicode);
Fav_Domain.SaveToFile(dm_server.Dire+'Conf/Fav_Domain.dat',TEncoding.Unicode);
Black_Domain.SaveToFile(dm_server.Dire+'Conf/Black_Domain.dat',TEncoding.Unicode);
Black_Email.SaveToFile(dm_server.Dire+'Conf/Black_Email.dat',TEncoding.Unicode);

except

end;


Fav_Email.Free;
Fav_Domain.Free;
Black_Email.Free;
Black_Domain.Free;

except
end;
end;





procedure TFmain.CriarTstrings;
begin
//Filtros        := THashedStringList.Create;
UID            := THashedStringList.Create;
UIDOK          := THashedStringList.Create;
UIDNUM         := THashedStringList.Create;
//VeUID          := THashedStringList.Create;
//Frases         := THashedStringList.Create;
//TCabec         := THashedStringList.Create;
//CorpoTop       := THashedStringList.Create;
//POPCapa        := THashedStringList.Create;
Palavras       := THashedStringList.Create;
PalavrasComple := THashedStringList.Create;

Fav_Email      := THashedStringList.Create;
Fav_Domain     := THashedStringList.Create;
Black_Email    := THashedStringList.Create;
Black_Domain   := THashedStringList.Create;

MeusEmails     := THashedStringList.Create;
MeusDominios     := THashedStringList.Create;


ListaPais      := TList<ThashedStringList>.Create;



ListaPaisaOri := TList<ThashedStringList>.Create;
ListaPaisTudo := TList<ThashedStringList>.Create;


try
Fav_Email.Loadfromfile(dm_server.Dire+'Conf/Fav_Email.dat',TEncoding.Unicode);
Fav_Domain.Loadfromfile(dm_server.Dire+'Conf/Fav_Domain.dat',TEncoding.Unicode);
Black_Domain.Loadfromfile(dm_server.Dire+'Conf/Black_Domain.dat',TEncoding.Unicode);
Black_Email.Loadfromfile(dm_server.Dire+'Conf/Black_Email.dat',TEncoding.Unicode);

except

end;



ListaIMAP      := TList<TIMAP>.create;
ListaPOP       := TList<TPOP>.create;
//GuardaMens     := TList<TMSG>.create;
//MensTMP := TList<TMSG>.create;
end;





procedure TFmain.FormCreate(Sender: TObject);
begin
Application.OnException := MyExceptionHandler;

CriarTstrings;
CriaFormMens;
AbreTodasTabelas;
ParaLeds;
end;

procedure TFmain.FormHide(Sender: TObject);
begin
RestoreTimer.Enabled := True;
end;

procedure TFmain.FormShow(Sender: TObject);
begin




RestoreTimer.Enabled := False;
Action1Execute(self);
if dm_server.Cds_Mens.RecordCount > 0 then
EstadoDosBotoesMensagens(True,True,true) else
EstadoDosBotoesMensagens(true,false,False);


if dm_server.cds_Contas.RecordCount = 0 then
   begin
   showmessage('Please, add one or more accounts in next screen.');
    ContasMostrarExecute(self);
   end;




CriaThreadFiltro;

end;

procedure TFmain.ContasMostrarExecute(Sender: TObject);
begin
  FContas := TFcontas.Create(self);
  Fcontas.ShowModal;
  Fcontas.Free;
end;

procedure TFmain.CriaFormMens;
begin
FMens := TFmens.Create(self);
FMens.Show;
//dm_server.cds_mens.IndexFieldNames := 'ID_Conta;ID';
end;

procedure TFmain.DestroiFormMens;
begin
FMens.free;
end;


procedure TFmain.CriaFiltroFriend(Mens:TMSG);
var
EmailG, monta    : string;
CbItensT  : TstringList;
estado : boolean;
I      : integer;
begin


CbItensT := TStringList.Create;


with dm_server do
begin

  CbItensT.Text := MontaItensCabec(Mens.Headers.text);
  if cds_Cabectmp.active then cds_cabectmp.Active := false;
  cds_Cabectmp.Filter := 'ID = '+inttostr(Mens.IDMens);
  cds_Cabectmp.Filtered := true;
  cds_Cabectmp.Active := true;
  if cds_Cabectmp.RecordCount = 0 then
     begin
      estado := true;
     end
     else
     begin
      estado := false;
     end;


for I := 0 to CbitensT.Count - 1 do
  begin
  if estado then
   begin
   cds_Cabectmp.append;
   cds_CabecTmpID.AsInteger   := Mens.IDMens;
   cds_CabecTmpItem.AsString  := CbitensT.strings[i];
   cds_CabecTmpValor.AsString := PegaItensCabec(CBItensT.strings[I], Mens.Headers.text);
   monta := trim(stringreplace(cds_CabecTmpValor.AsString,CBItensT.strings[I],'',[]));
   cds_CabecTmpValor.AsString := monta;
   cds_CabecTmpFiltro.Asinteger := 0;
   cds_CabecTmp.Post;
   end;
  end;

EmailG := dm_server.QContasCon.FieldByName('Email').asstring;

dm_server.GravaBoxes(1,1, Mens.IDMens,'AND','To:',2, '*'+EmailG+'*',0,'EmC-'+EMailG);
dm_server.GravaBoxes(1,1, Mens.IDMens,'AND','From:',2, '*'+Mens.EmailFrom+'*',0,'EmC-'+EMailG);
dm_server.GravaBoxes(1,1, Mens.IDMens,'AND','Received:',2, '*'+Mens.IPSender+'*',0,'EmC-'+EMailG);

CbItensT.Free;

end;
end;



procedure TFmain.MontaEmCFiltro(Mens:TMSG);
Var
Monta : string;
begin

if DM_Server.PegaContasPOP(Mens.IDConta) then
   begin
   Monta := copy(Mens.Subject,20,length(mens.Subject)-19);
   if monta = dm_server.QContasCon.FieldByName('Guid').asstring then
      begin
        CriaFiltroFriend(Mens);
      end;
   end;
end;





procedure TFmain.GravaMens(Mens:TMSG);
var
I, achou : integer;
Datax      : string;
MontaFrom, monta  : string;
MontaRec   : string;
MontaSub   : ansistring;
begin


with dm_Server do
begin


 cds_Mens.Append;


  for I:= 0 to cds_Mens.Fields.count - 1 do
  begin
    if cds_Mens.Fields[i].DataType = ftInteger then
       cds_Mens.Fields[i].value := 0;

  end;


  cds_mensFiltrada.AsInteger := -1;
  cds_mensAnexos.AsInteger   := -1;
  Cds_mensConta.Asstring       := Mens.NomeConta;
  Cds_MensID_Conta.AsInteger   := Mens.IdConta;
  Cds_MensNumeroMens.AsInteger := Mens.UIDNum;
  Cds_MensUID.AsString         := Mens.UIDOK;
  cds_mensDT.AsDateTime        := now;
  cds_mensEmail.AsString       := Mens.Recipients.EMailAddresses;



  try
  Cds_MensIPSender.AsString :=  Mens.IPSender;//  ExtrairRegexp(ExtraiIP,montaRec);
  except
  end;

  Cds_MensAssunto.AsString     := mens.Subject;


  if pos('EmC-Authentication ',mens.Subject)  > 0  then
  begin
    if DM_Server.PegaContasPOP(Mens.IDConta) then
       begin
       Monta := copy(Mens.Subject,20,length(mens.Subject)-19);
       if monta = dm_server.QContasCon.FieldByName('Guid').asstring then
          begin
            cds_mensFavoritos.AsInteger := 1;
            mens.Favorita               := 1;
            Mens.ListaNegra             := 0;
            Mens.Filtrada               := 148;
            Mens.Selecionada            := 1;
          end;
       end;
   end;



  Cds_MensAssunto.AsString := stringreplace(Cds_MensAssunto.AsString,#$FFFF,' ',[rfReplaceAll]);


  Cds_MensEmitente.AsString    := mens.From.Name+' '+mens.From.Address;

  try
  Cds_MensEmailFrom.AsString   := Mens.EmailFrom;//  ExtrairRegexp(EmailRegExp,montaFrom);
  except
  end;

  Cds_MensEmitente.AsString    := Mens.EmailFrom;     //Cds_MensEmailFrom.AsString;

  Cds_MensDominioFrom.AsString := Mens.DominioFrom;  // pegaDominio(Cds_MensEmailFrom.AsString);


  try
  Cds_MensTama.AsInteger       := Mens.Tamanho; //      round(Tama/1024);
  except
  end;



  try
  Cds_MensDaTaMens.asstring            := datetimetostr(Mens.Date);
  except
  Cds_MensDaTaMens.asstring            := '';
  end;




 Cds_MensCabec.AsString                   := {DecodeHeader}(Mens.Headers.Text);
 Cds_MensDataOrig.asstring                :=  Mens.Headers.Values['Date'];
 Cds_MensXmailer.asstring                 :=  Mens.Headers.Values['X-Mailer'];

 Cds_MensReceivedFrom.asstring            :=  Mens.Headers.Values['Received'];



  cds_mensselecionada.AsInteger  := Mens.Selecionada;
  cds_mensExcluida.AsInteger     := Mens.Excluida;
  cds_mensFiltrada.AsInteger     := Mens.Filtrada;
  cds_mensListaNegra.AsInteger   := Mens.ListaNegra;
  cds_mensFavoritos.AsInteger    := Mens.Favorita;


  Cds_MensCountry.asstring            :=  Mens.pais;


Cds_MensFiltroResult.AsString := Mens.FiltroResultado.Text;
cds_menspalavrasBaysean.AsString := Mens.FrasesBaesyan.Text;

//GuardaMens.add(Mens);


//Cds_MensMSG_REF.AsInteger := Guardamens.count-1;

 try
 Cds_Mens.Post;
 Mens.IDMens                   := Cds_MensID.AsVariant;
 except
 showmessage('Cannot save mens '+inttostr(Mens.UIDNum)+' '+Mens.Subject);
 exit;
 end;

  if pos('EmC-Authentication ',mens.Subject)  > 0  then
  begin
  MontaEmCFiltro(Mens);
  end;

 Fmens.SB.Panels[0].Text := 'Total: '+inttostr(cds_mens.RecordCount)+' messages';
 Fmens.SB.Panels[2].Text := 'Email: '+Mens.NomeConta;
 Fmens.SB.Panels[3].Text := 'Total Account: '+inttostr(Mens.CountAtual)+ ' of '+inttostr(Mens.TotPop);

end;

end;







procedure TFmain.ProcessaConta(conta:integer);
Begin



if ConectaPOP(conta) then
 begin
 end;


End;


procedure TFmain.LeContas;
begin


with DM_Server do
begin
 cds_Contas.first;
 cds_Mens.First;


    while not cds_Contas.eof do
    begin
     Application.ProcessMessages;
      if parar then
       begin
       break;
       end;
     Avisa(1);

     ProcessaConta(cds_ContasID.AsInteger);

     cds_Contas.Next;
    end;




cds_Mens.filter           := '';
cds_Mens.filtered         := false;
cds_Mens.First;


PoeStatusBar('Total: '+inttostr(dm_server.cds_Mens.recordcount)+' message(s)','Showing InBox','','');

end;
end;



procedure TFmain.LeMensagem;
begin
  with dm_server do
  begin
    cds_Contas.Filtered := False;
    cds_Contas.first;
    cds_Contas.Filter := 'Ativada = 1';
    cds_Contas.Filtered := true;
    cds_Contas.first;
  end;
end;


procedure TFmain.verificaThreadsFiltros;
begin
  if not ManagerFiltros.ActiveThreads then
  begin
    CriaThreadFiltro;
  end;

end;



procedure TFmain.JvMTThread1Execute(Sender: TJvMTThread;
  MTThread: TJvMTSingleThread);
begin

{

  while true do
  begin
    try
      CurrentMTThread.CheckTerminate;
      while MensTMP.Count > 0 do
      begin
        email_Filtro1.Write(MensTMP.Items[MensTMP.Count-1]);
        MensTMP.Delete(MensTMP.Count-1);
      end;
      CurrentMTThread.Terminate;
    finally
      CurrentMTThread.Terminate;
    end;
  end;

 }

end;



{
procedure TFmain.filtraMSGAntigas();
var
  MSGwork:TMSG;
  I : integer;
begin

ListBox1.Items.Add('Filtering again...');
listbox1.ItemIndex := listbox1.count-1;

with dm_server do
begin
  Threads_em_execucao := 0;

  cds_mens.IndexFieldNames := 'ID';
  cds_mens.First;
  cds_mens.DisableControls;
  Fmens.JvSpecialProgress1.Maximum := cds_mens.RecordCount;



  while not cds_mens.Eof do
  begin
    Application.ProcessMessages;
    Fmens.JvSpecialProgress1.Position := cds_mens.RecNo;
    MSGwork := TMSG.create;
    MSGwork.Headers.Text := cds_mensCabec.AsString;
    MSGwork.ProcessHeaders;


    MSGwork.Tag := 0;
    MSGwork.IDConta   :=  cds_mensID_Conta.AsInteger;
    MSGwork.NomeConta := cds_mensConta.asString;
    MSGwork.Tamanho   := cds_mensTama.AsInteger;
    MSGwork.UIDOK     := cds_mensUID.AsString;
    MSGwork.UIDNum    := cds_mensNumeroMens.AsInteger;
    MSGwork.Getvariaveis;
    MSGwork.getFrases;
    MSGwork.CamposObrigatorios;
    MensTMP.Add(MSGwork);

    cds_mens.Next;
  end;
  cds_mens.EmptyDataSet;
  cds_mens.EnableControls;
  Threads_em_execucao := MensTMP.Count;
  JvMTThread1.RunCopy;


end;



end;
 }

procedure TFmain.MensagensLerExecute(Sender: TObject);
begin


entrou := true;
Fmens.wwDBGrid1.Enabled := false;

Listbox1.Items.Clear;


if (dm_server.cds_mens.recordcount = 0) and (dm_server.TemFiltroNovo) then
dm_server.TemFiltroNovo := false;



Threads_em_execucao := 0;

listbox1.Items.Add('Get Process started. '+datetimetostr(now));
listbox1.ItemIndex := listbox1.Items.Count-1;


PiscaLeds;


PoeStatusBar('Total: 0 message(s)','Getting messages...Wait!!','','');
EstadoDosBotoesMensagens(False,True,False);
RibbonGroup2.Enabled    := false;
RibbonGroup3.Enabled    := false;
RibbonGroup7.Enabled    := false;

Parar := false;
Total := 0;

Action1Execute(self);
Inicio                := dm_server.Cds_Mens.RecordCount;
JvTrayIcon1.Animated  := true;


verificaThreadsFiltros;


dm_server.cds_mens.IndexFieldNames := '';


LeMensagem;
LeContas;
entrou := false;


if not ManagerPegaMSG.ActiveThreads then
begin
  termina;
end;

end;


procedure TFmain.MensagensInterromperExecute(Sender: TObject);
var
  i,achou: Integer;
  marca:TstringList;
begin

ManagerPegaMSG.TerminateThreads;
EstadoDosBotoesMensagens(True,True,True);
ListBox1.Items.Add('Process aborted by user. '+datetimetostr(now));
ListBox1.ItemIndex := ListBox1.Items.Count-1;
PoeStatusBar('','Process aborted by user!!','','');
Parar := True;
ParaLeds;
JvTrayIcon1.Animated              := false;
Fmens.wwDBGrid1.Enabled           := true;
RibbonGroup2.Enabled    := true;
RibbonGroup3.Enabled    := true;
RibbonGroup7.Enabled    := true;
Fmens.JvSpecialProgress1.Position := 0;
//removerTodosPopIMAP(false);
marca := TstringList.Create;
for i := 0 to Fmain.ComponentCount - 1 do
begin
  if (Fmain.Components[i] is Tpop) then
  begin
    try
      Tpop(Fmain.Components[i]).DisconnectNotifyPeer;

    except

    end;
    //marca.Add(inttostr(i));
  end
  else if (Fmain.Components[i] is TIMAP) then
  begin
    try
      TIMAP(Fmain.Components[i]).DisconnectNotifyPeer;
    except

    end;
    //marca.Add(inttostr(i));
  end;
end;

{for I := 0 to marca.count - 1 do
begin
  achou := strtoint(marca[i]);
  Fmain.Components[achou].Free;
end;}
 marca.Free;
 ListaPOP.Clear;
 ListaIMAP.Clear;


end;


procedure TFmain.RestoreTimerTimer(Sender: TObject);
begin

  RestoreTimer.Enabled := false;

  if IsWindowVisible(Handle) then
  Begin
    RestoreTimer.Enabled := True;
  End
  else
  begin
     if Threads_em_execucao = 0 then
    begin
      MensagensLerExecute(self);
      RestoreTimer.Enabled := True;
    end
    else
    begin
      RestoreTimer.Enabled := True;
    end;

  end;

end;



Procedure TFmain.Avisa(Tipo:integer);
begin
 if Tipo = 0 then
  begin
   TotAvisa := dm_server.cds_mens.recordcount;
   if (Totavisa) > 0 then
   begin
   JvTrayIcon1.BalloonHint('EmC-NEWS','There are '+inttostr(TotAvisa)+' messages.',btInfo,5000,true);
   end;
  end;
end;


procedure TFmain.BufferCanRead(Sender: TObject);
var
Mens : TMSG;
begin


Mens :=  Buffer.Read as TMSG;
try

Gravamens(Mens);


finally

Mens.Free;
Threads_em_execucao := Threads_em_execucao - 1;
end;

if (Threads_em_execucao = 0) and (not ManagerPegaMSG.ActiveThreads) then
   begin
     Termina;
   end;



end;

procedure TFmain.ShowMain1Click(Sender: TObject);
begin
  if IsWindowVisible(Handle) then
    begin
    JvTrayIcon1.HideApplication;
    RestoreTimer.Enabled := true;
    end
  else
  begin
    RestoreTimer.Enabled := False;
    JvTrayIcon1.ShowApplication;
  end;
end;






procedure TFmain.Action1Execute(Sender: TObject);
begin
if dm_server.cds_AllM.active then  dm_server.cds_AllM.active := false;
dm_server.DS_qMens.DataSet := dm_server.cds_Mens;
dm_server.EstounoMenu := 1;
dm_server.Cds_Mens.Filter   := 'Excluida = 0';
dm_server.Cds_Mens.Filtered := false;
dm_server.Cds_Mens.first;
PoeStatusBar('Total: '+inttostr(dm_server.cds_Mens.recordcount)+' message(s)','Showing InBox','','');

end;

procedure TFmain.Action2Execute(Sender: TObject);
begin

if dm_server.cds_AllM.active then  dm_server.cds_AllM.active := false;

dm_server.DS_qMens.DataSet := dm_server.cds_Mens;
 dm_server.EstounoMenu := 2;

    dm_server.Cds_Mens.filter   := 'Favoritos = 1 and excluida = 0';
     dm_server.Cds_Mens.Filtered := true;
     dm_server.Cds_Mens.first;
     PoeStatusBar('Total: '+inttostr(dm_server.cds_Mens.recordcount)+' message(s)','Showing My Friends Box','','');
end;

procedure TFmain.Action3Execute(Sender: TObject);
begin

if dm_server.cds_AllM.active then  dm_server.cds_AllM.active := false;

dm_server.DS_qMens.DataSet := dm_server.cds_Mens;
 dm_server.EstounoMenu := 3;

   dm_server.Cds_Mens.filter   := '(Filtrada = 145 or Filtrada = 147) and excluida = 0';
     dm_server.Cds_Mens.Filtered := true;
     dm_server.Cds_Mens.first;
 PoeStatusBar('Total: '+inttostr(dm_server.cds_Mens.recordcount)+' message(s)','Showing Filtered Box','','');

end;

procedure TFmain.Action4Execute(Sender: TObject);
begin

if dm_server.cds_AllM.active then  dm_server.cds_AllM.active := false;

 dm_server.DS_qMens.DataSet := dm_server.cds_Mens;
dm_server.EstounoMenu := 4;

   dm_server.Cds_Mens.filter   := 'ListaNegra = 0 and Filtrada = -1 and Favoritos = 0 and Excluida = 0';
     dm_server.Cds_Mens.Filtered := true;
     dm_server.Cds_Mens.first;

  PoeStatusBar('Total: '+inttostr(dm_server.cds_Mens.recordcount)+' message(s)','Showing Not Filtered Box','','');


end;

procedure TFmain.Action5Execute(Sender: TObject);
begin

     if dm_server.cds_AllM.active then  dm_server.cds_AllM.active := false;



     dm_server.DS_qMens.DataSet := dm_server.cds_Mens;
     dm_server.EstounoMenu := 5;
     dm_server.Cds_Mens.filter   := 'ListaNegra = 1 and excluida = 0';
     dm_server.Cds_Mens.Filtered := true;
     dm_server.Cds_Mens.first;
     PoeStatusBar('Total: '+inttostr(dm_server.cds_Mens.recordcount)+' message(s)','Showing BlackList Box','','');
end;

procedure TFmain.Action6Execute(Sender: TObject);
var
Datax : Tdatetime;
DataS : string;
begin
  dm_server.EstounoMenu := 6;
  dm_server.Cds_Mens.filtered := false;
  DataS := datetostr(date);
  Datas := Datas + ' 00:00:00';
  Datax := strtodatetime(Datas);

  if not dm_server.cds_AllM.active then  dm_server.cds_AllM.active := true;
  dm_server.DS_qMens.DataSet := dm_server.cds_ALLM;
  dm_server.cds_ALLM.filter := 'DT >= '+quotedstr(datetimetostr(datax));
  dm_server.cds_ALLM.filtered := true;
  dm_server.cds_ALLM.first;
  PoeStatusBar('Total: '+inttostr(dm_server.cds_ALLM.recordcount)+' message(s)','Showing Deleted Today','','');
end;

procedure TFmain.Action7Execute(Sender: TObject);
begin


{
Fcomu := TFcomu.Create(self);
Fcomu.showmodal;
FComu.Free;
 }


 shellexecute(handle, 'open',pchar('http://www.emc50.com'),nil,nil,SW_SHOWNORMAL);



end;

procedure TFmain.Action8Execute(Sender: TObject);
begin
FSetUp := TFSetUp.create(self);
FSetUp.showmodal;
FSetUp.free;

if dm_server.TemFiltroNovo then
begin
Refiltrar;
dm_server.TemFiltroNovo := false;
end;
end;


procedure TFmain.Action9Execute(Sender: TObject);
begin

Fabout  := TFabout.create(self);
Fabout.showmodal;
Fabout.free;

end;

procedure TFmain.Action10Execute(Sender: TObject);
begin
dm_server.Quem := 1;
Ffavoritos := TFfavoritos.create(self);
Ffavoritos.showmodal;
Ffavoritos.free;
end;

procedure TFmain.Action11Execute(Sender: TObject);
begin
Terminando;
end;

procedure TFmain.Action12Execute(Sender: TObject);
begin
dm_server.Quem := 2;
Ffavoritos := TFfavoritos.create(self);
Ffavoritos.showmodal;
Ffavoritos.free;
end;












procedure TFmain.Action13Execute(Sender: TObject);
begin

Fbackup := TFbackup.create(self);
Fbackup.showmodal;
Fbackup.free;



end;

procedure TFmain.Action15Execute(Sender: TObject);
begin



end;

//-------------------------------------------Threads



function TFmain.buscaPop(Ticket: TMTTicket):tPop;
var
  I: Integer;
begin
  result := nil;
  for I := 0 to ListaPop.Count - 1 do
  begin
    if (ListaPop.Items[i].Ticket = Ticket) then
    begin
      if ListaPop.Items[i].Connected then
      begin
        ListaPop.Items[i].KeepAlive;
        result:= ListaPop.Items[i];
      end
      else
      begin
        result := nil;
        listbox1.Items.Add('('+inttostr(Ticket)+')ERROR: Thread '+ListaPop.Items[i].NomeConta+' disconected from server');
        listbox1.ItemIndex := listbox1.Items.Count-1;
        ManagerPegaMSG.ReleaseThread(Ticket);
      end;
    end
    else
    begin
      result := nil;
    end;
  end;

end;


function TFmain.buscaIMAP(Ticket: TMTTicket):TImap;
var
  I: Integer;
begin
  result := nil;
  for I := 0 to ListaIMAP.Count - 1 do
  begin
    if ListaIMAP.Items[i].Connected then
      begin
        ListaIMAP.Items[i].KeepAlive;
        result:= ListaIMAP.Items[i];
      end
      else
      begin
        result := nil;
        listbox1.Items.Add('('+inttostr(Ticket)+')ERROR: Thread '+ListaIMAP.Items[i].NomeConta+' disconected from server');
        listbox1.ItemIndex := listbox1.Items.Count-1;
        ManagerPegaMSG.ReleaseThread(Ticket);
      end;
  end;

end;


procedure TFmain.ThreadFiltro1Execute(Sender: TJvMTThread;
  MTThread: TJvMTSingleThread);
var
  MSG : TMSG;
begin
  try
    while true do
    begin

      CurrentMTThread.CheckTerminate;

      MSG :=  email_Filtro1.Read as TMSG;

      if dm_server.Countries > 0 then
      begin
      MSG :=  DM_Pais.Filtrar_pais(MSG);
      end;

      MSG :=  DM_FavoNegra.filtrar_favoritos_listaNegra(MSG);

      if (MSG.Favorita = 0) and (MSG.ListaNegra = 0)  then
      MSG :=  dm_Avancado.Filtrar_Favoritos_Nao_Grupados(MSG);

      if (MSG.Favorita = 0) and (MSG.ListaNegra = 0)  then
      MSG :=  dm_Avancado.Filtrar_Favoritos_Grupados(MSG);

      if (MSG.Favorita = 1) or (MSG.Filtrada > 0) or(MSG.ListaNegra = 1) then
        buffer.Write(MSG)
      else
        Filtro1_Filtro2.Write(MSG);


      //Buffer.Write(MSG);
    end;
  finally
    CurrentMTThread.Terminate;
  end;
end;

procedure TFmain.ThreadFiltro1Finished(Sender: TJvMTThread;
  MTThread: TJvMTSingleThread);
begin

  ListBox1.Items.Add('('+inttostr(MTThread.Ticket)+')'+'Filtro1 aborted');
  listbox1.ItemIndex := listbox1.Items.Count-1;
  ManagerPegaMSG.TerminateThreads;
  ManagerFiltros.TerminateThreads;


if not ManagerFiltros.ActiveThreads then
begin
Threads_em_execucao := 0;
Termina;
end;



end;

procedure TFmain.ThreadFiltro2Execute(Sender: TJvMTThread;
  MTThread: TJvMTSingleThread);
var
  MSG : TMSG;
begin
  try
    while true do
    begin




      CurrentMTThread.CheckTerminate;



      MSG := Filtro1_Filtro2.Read as TMSG;




      if dm_server.DNS > 0 then
      begin
      if (MSG.Favorita = 0) and (MSG.ListaNegra = 0) and (MSG.Filtrada <= 0) then
      MSG := DM_DNS.Filtrar_DNS(MSG);
      end;




      if dm_server.filter > 0  then
      begin

      if (MSG.Favorita = 0) and (MSG.ListaNegra = 0) and (MSG.Filtrada <= 0) then
      MSG := dm_Avancado.Filtrar_ListaNegra_NaoGrupados(MSG);

      if (MSG.Favorita = 0) and (MSG.ListaNegra = 0) and (MSG.Filtrada <= 0) then
      MSG := dm_Avancado.Filtrar_ListaNegra_Grupados(MSG);

      end;

      if (MSG.Favorita = 0) and (MSG.ListaNegra = 0) and (MSG.Filtrada <= 0) then
      MSG := DM_Baysean.Filtrar_Bayesian(MSG);



      //Filtro1_Filtro2.Write(MSG);
      Buffer.Write(MSG);
    end;
  finally
    CurrentMTThread.Terminate;
  end;
end;

procedure TFmain.ThreadFiltro2Finished(Sender: TJvMTThread;
  MTThread: TJvMTSingleThread);
begin
  ListBox1.Items.Add('('+inttostr(MTThread.Ticket)+')'+'Filter 2 aborted');
  listbox1.ItemIndex := listbox1.Items.Count-1;

  ManagerPegaMSG.TerminateThreads;
  ManagerFiltros.TerminateThreads;


if not ManagerFiltros.ActiveThreads then
begin
Threads_em_execucao := 0;
Termina;
end;


end;

procedure TFmain.ThreadImapExecute(Sender: TJvMTThread;
  MTThread: TJvMTSingleThread);
var
  MSG:TMSG;
  IMAP:TImap;
  Mens,I:Integer;
  timeout, tama : Integer;
begin
  try
    timeout := 1000;
    while true do
    begin
      CurrentMTThread.CheckTerminate;
      IMAP := buscaIMAP(CurrentMTThread.Ticket);
      if IMAP <> nil then
      begin
        mens := IMAP.UIDNum.Count;
        for I := 0 to mens-1 do
        begin
            MSG := TMSG.Create();
            msg.CountAtual := i+1;
            msg.NoEncode := false;
            msg.NoDecode := false;



            try
              IMAP.UIDRetrieveHeader(IMAP.UIDNum[i],Msg);
            except
              listbox1.Items.Add('('+inttostr(CurrentMTThread.Ticket)+')ERROR: Thread '+ListaIMAP.Items[i].NomeConta+' disconected from server');
              listbox1.ItemIndex := listbox1.Items.Count-1;
              CurrentMTThread.Terminate;
            end;

            try
              tama := IMAP.UIDRetrieveMsgSize(IMAP.UIDNum[i]);
            except
              listbox1.Items.Add('('+inttostr(CurrentMTThread.Ticket)+')ERROR: Thread '+ListaIMAP.Items[i].NomeConta+' disconected from server');
              listbox1.ItemIndex := listbox1.Items.Count-1;
              CurrentMTThread.Terminate;
            end;



            MSG.Tag := CurrentMTThread.Ticket;
            MSG.IDConta :=  IMAP.IDConta;
            MSG.NomeConta := IMAP.NomeConta;
            try
              MSG.Tamanho := round(tama/1024);
            except
              MSG.Tamanho := 0;
            end;

            MSG.UIDOK:= IMAP.UIDOK[i];
            MSG.UIDNum := strtoint(IMAP.UIDNum[i]);
            MSG.Getvariaveis;
            MSG.getFrases;
            MSG.CamposObrigatorios;
            MSG.TotPop := IMAP.UIDOK.Count;
            email_Filtro1.Write(msg);

            Threads_em_execucao := Threads_em_execucao + 1;

        end;
        CurrentMTThread.Terminate;
      end
      else
      begin
        if timeout > 0 then
        begin
          dec(timeout);
          sleep(10);
        end
        else
        begin
          listbox1.Items.Add('('+inttostr(CurrentMTThread.Ticket)+')ERROR: Thread '+ListaIMAP.Items[i].NomeConta+' time out');
          listbox1.ItemIndex := listbox1.Items.Count-1;
          CurrentMTThread.Terminate;
        end;
      end;
    end;
  finally
    CurrentMTThread.Terminate;
  end;
end;

procedure TFmain.ThreadIMAPFinished(Sender: TJvMTThread;
  MTThread: TJvMTSingleThread);
var
Nomeconta:String;
begin



Nomeconta := RemoveIMAP(MTThread.Ticket);
listbox1.Items.Add('('+inttostr(MTThread.Ticket)+') Thread account '+Nomeconta+'  finished');
listbox1.ItemIndex := listbox1.count-1;
//ManagerPegaMSG.ReleaseThread(MTThread.Ticket);

if (not ManagerPegaMSG.ActiveThreads) and (Threads_em_execucao = 0) and (not entrou) then
begin
  Termina;
end;

end;

procedure TFmain.ThreadPOPExecute(Sender: TJvMTThread;
  MTThread: TJvMTSingleThread);
var
  MSG:TMSG;
  Pop:TPop;
  Mens,I:Integer;
  tam:Integer;
  timeout:Integer;
begin
  timeout := 1000;
  try
    while true do
    begin


      Pop := buscaPop(CurrentMTThread.Ticket);
      CurrentMTThread.CheckTerminate;
      if pop <> nil then
      begin
        Mens := Pop.UIDNum.Count;
        for I := 0 to mens-1 do
        begin

            MSG := TMSG.Create();
            msg.NoEncode := false;
            msg.NoDecode := false;
            msg.countatual := i+1;

            try
              pop.RetrieveHeader(strtoint(Pop.UIDNum[i]),Msg);
            except
              listbox1.Items.Add('('+inttostr(CurrentMTThread.Ticket)+')ERROR: Thread '+ListaIMAP.Items[i].NomeConta+' disconected from server');
              listbox1.ItemIndex := listbox1.Items.Count-1;
              CurrentMTThread.Terminate;
            end;

            try
              tam := Pop.RetrieveMsgSize(strtoint(Pop.UIDNum[i]));
            except
              listbox1.Items.Add('('+inttostr(CurrentMTThread.Ticket)+')ERROR: Thread '+ListaIMAP.Items[i].NomeConta+' disconected from server');
              listbox1.ItemIndex := listbox1.Items.Count-1;
              CurrentMTThread.Terminate;
            end;

              MSG.Tag := CurrentMTThread.Ticket;
              MSG.IDConta :=  pop.IDConta;
              MSG.NomeConta := pop.NomeConta;



              try
                MSG.Tamanho := round(tam/1024);
              except
                MSG.Tamanho := 0;
              end;

              MSG.UIDOK:= pop.UIDOK[i];
              MSG.UIDNum := strtoint(pop.UIDNum[i]);
              MSG.Getvariaveis;
              MSG.getFrases;
              MSG.CamposObrigatorios;
              MSG.TotPop := POP.UIDOK.Count;
              email_Filtro1.Write(msg);
              Threads_em_execucao := Threads_em_execucao + 1;
        end;
        CurrentMTThread.Terminate;
      end
      else
      begin
        if timeout > 0 then
        begin
          dec(timeout);
          Sleep(10);
        end
        else
        begin
          listbox1.Items.Add('('+inttostr(CurrentMTThread.Ticket)+')ERROR: Thread '+ListaIMAP.Items[i].NomeConta+' time out');
          listbox1.ItemIndex := listbox1.Items.Count-1;
          CurrentMTThread.Terminate;
        end;
      end;
    end;
  finally
    CurrentMTThread.Terminate;
  end;
end;



function TFmain.RemoveIMAP(Ticket: TmTticket): String;
var
I,achou : integer;
IMAP : TIMAP;
begin

achou := -1;

 for I:= 0 to ListaIMAP.Count - 1 do
  begin
      if listaIMAP.items[i].Ticket = Ticket then
          begin
            IMAP := listaIMAP.items[i];
            achou := i;
            break;
          end;
  end;

          if achou >= 0 then
          begin
            result:= IMAP.NomeConta;
            if IMAP <> nil then
            begin
              try
                IMAP.DisconnectNotifyPeer;
              except
              end;
              IMAP.Free;
            end;
            listaIMAP.Delete(achou);
          end
          else
          begin
            result:= 'IMAP not found';
          end;
end;

function TFmain.RemovePOP(Ticket:TmTticket):String;
var
I,achou : integer;
POP : TPOP;
begin

achou := -1;

 for I:= 0 to ListaPop.Count - 1 do
  begin
      if listaPOP.items[i].Ticket = Ticket then
          begin
            POP := listaPOP.items[i];
            achou := i;
            break;
          end;
  end;



  if achou >= 0 then
  begin
    result:= Pop.NomeConta;
    if POP <> nil then
    begin
      try
        Pop.DisconnectNotifyPeer;
      except
      end;
      Pop.Free;
    end;
    listaPOP.Delete(achou);
  end
  else
  begin
    result:= 'Pop not found';
  end;






end;


procedure TFmain.ThreadPOPFinished(Sender: TJvMTThread;
  MTThread: TJvMTSingleThread);
  var
    NomeConta:String;
  begin



NomeConta := RemovePOP(MTThread.Ticket);


//listbox1.Items.Add('Thread account '+NomeConta+' ('+inttostr(MTThread.Ticket)+') finished');
listbox1.Items.Add('('+inttostr(MTThread.Ticket)+') Thread account '+Nomeconta+'  finished');
listbox1.ItemIndex := listbox1.count-1;
 //ManagerPegaMSG.ReleaseThread(MTThread.Ticket);
if (not ManagerPegaMSG.ActiveThreads) and (Threads_em_execucao = 0) and (not entrou) then
begin
  Termina;
end;


end;

procedure TFmain.Termina;
begin



  if (not ManagerPegaMSG.ActiveThreads) {and (not ManagerFiltros.ActiveThreads)} then
  begin


  if dm_server.cds_mens.Active then
  begin
        Fim                   := dm_server.Cds_Mens.RecordCount;
        JvTrayIcon1.Animated  := false;
        JvTrayIcon1.IconIndex := 0;
        Avisa(0);
        EstadoDosBotoesMensagens(True,True,True);
        ParaLeds;
        ListBox1.Items.Add('Get Process terminated. '+datetimetostr(now));
        ListBox1.ItemIndex := ListBox1.Items.Count-1;
        RibbonGroup2.Enabled    := true;
        RibbonGroup3.Enabled    := true;
        RibbonGroup7.Enabled    := true;
        Fmens.wwDBGrid1.Enabled := true;
        abrendeTodos;
        end;
  end;

end;


procedure TFmain.abrendeTodos;
var
  p : TBayesian;
begin
  dm_server.cds_mens.Filter := 'aprendeu <> 1 and Favoritos = 1';
  dm_server.cds_mens.Filtered := true;

  dm_server.cds_mens.first;
  fmens.JvSpecialProgress1.Maximum := dm_server.cds_mens.RecordCount;
  p :=TBayesian.create();
  dm_server.cds_mens.DisableControls;
  while not dm_server.cds_mens.eof do
  begin
    Application.ProcessMessages;
    fmens.JvSpecialProgress1.Position := dm_server.cds_mens.Recno;

    if dm_server.cds_mensFavoritos.AsInteger = 1 then
    begin
      if dm_server.cds_mensaprendeu.AsInteger <> 1 then
      begin
      p.learn(dm_server.cds_menspalavrasBaysean.asString,2);
      dm_server.cds_mens.Edit;
      dm_server.cds_mensaprendeu.AsInteger := 1;
      dm_server.cds_mens.Post;
      end;
    end;

     dm_server.cds_mens.next;
  end;

  p.Free;
  dm_server.cds_mens.IndexFieldNames := 'ID_Conta;NumeroMens';
  dm_server.cds_mens.Filtered := false;
  dm_server.cds_mens.EnableControls;
  dm_server.cds_mens.First;
  fmens.JvSpecialProgress1.Position := 0;
end;



end.

unit UConectaImap;


interface

uses
  UcriaObjetos, JvMTConsts, Windows, Messages, SysUtils, Variants, Classes,
  Graphics, Controls, IdIOHandlerSocket,IdSSL,IdSSLOpenSSL,
  IdMessage,
  IdBaseComponent, IdComponent, IdTCPConnection,IdTCPClient,
  IdExplicitTLSClientServerBase,
  IdMessageClient, IdPOP3, DBClient;

Function CriaIMAP(IMAPT:TIMAP;Ticket:TmtTicket):TImap;
Procedure PegaMensImap(Imapwork:TImap);
Procedure SeparaUIDT(Imapwork:TImap);
function inicializaIMAP(Conta:Integer):TIMAP;



implementation



Uses Udmserver, Umain;


Procedure PegaMensImap(Imapwork:TImap);
var
tabMens : TClientDataSet;

i,achou:Integer;
begin
  With DM_Server do
  begin

    tabMens := TClientDataSet.create(nil);
    tabMens.CloneCursor(dm_server.cds_Mens,false,false);
    tabMens.IndexFieldNames := 'ID_Conta';
    tabmens.filter := 'ID_conta = '+inttostr(Imapwork.IDConta);
    tabmens.Filtered := true;
    tabMens.First;



    while not tabMens.Eof do
    begin
      achou := Imapwork.UIDOK.indexof(tabMens.FieldByName('UID').asstring);
      if achou >= 0 then
      begin
        Imapwork.UIDOK.BeginUpdate;
        Imapwork.UIDOK.Delete(achou);
        Imapwork.UIDOK.EndUpdate;

        Imapwork.UIDNUM.BeginUpdate;
        Imapwork.UIDNUM.Delete(achou);
        Imapwork.UIDNUM.EndUpdate;
      end
      else
      begin
        tabMens.edit;
        tabMens.FieldByName('Excluida').AsInteger    := 1;
        tabMens.FieldByName('Filtrada').AsInteger    := 130;
        tabMens.FieldByName('selecionada').AsInteger := 0;
        tabMens.Post;
      end;
      tabMens.Next;
    end;



  end;
end;



Procedure SeparaUIDT(Imapwork:TImap);
var
I, achou : integer;
Monta, Num, UIDT    : string;
begin
{
Imapwork.UIDOK.Clear;
Imapwork.UIDNUM.Clear;

for I := 0 to Imapwork.UIDs.Count - 1 do
   begin
     monta :=  stringreplace(Imapwork.UIDs.Strings[i],#13#10,'',[]);
     achou := pos(' ',monta);
     Num   := copy(monta,1,achou-1);
     UIDT  := copy(monta,achou+1,length(monta)-(achou));
     Imapwork.UIDOK.Add(UIDT);
     Imapwork.UIDNUM.Add(Num);
   end; }
end;




function inicializaIMAP(Conta:Integer):TIMAP;
            function existeLista(conta:integer):TImap;
            var
              i : Integer;
            begin
              result:=nil;
              for i := 0 to Fmain.ListaIMAP.count - 1 do
              begin
                if Fmain.ListaIMAP.Items[i].IDConta = conta then
                begin
                  result:= Fmain.ListaIMAP.Items[i];
                  break;
                end;
              end;

            end;
var
  IMAPT : TIMAP;
  SSLT : TIdSSLIOHandlerSocketOpenSSL;
  i:Integer;
  S:String;
begin


  if DM_Server.PegaContasPOP(Conta) then
  begin

    With dm_Server do
    begin
      IMAPT := existeLista(Conta);
      if IMAPT = nil then
      begin

        IMAPT := TIMAP.Create;
        SSLT := TIdSSLIOHandlerSocketOpenSSL.Create(IMAPT);
        IMAPT.IOHandler := SSLT;

        IMAPT.Host      :=  QContasCon.FieldByName('POP').AsString;
        IMAPT.Password  :=  QContasCon.FieldByName('Senha').AsString;
        IMAPT.Port      :=  QContasCon.FieldByName('Porta').AsInteger;
        IMAPT.Username  :=  QContasCon.FieldByName('usuario').AsString;
        IMAPT.IDConta := Conta;
        IMAPT.NomeConta :=  QContasCon.FieldByName('Nome').AsString;


        if QContasCon.FieldByName('SSL').asinteger = 1 then
        begin
          SSLT.SSLOptions.Method := sslvSSLv2;
          IMAPT.UseTLS    := utUseImplicitTLS;
        end
        else
        begin
          IMAPT.UseTLS    := utNoTLSSupport;
        end;



        IMAPT.ConnectTimeout := 10000;
        IMAPT.ReadTimeout := 10000;

        try
          IMAPT.Connect;
        except
          Fmain.ListBox1.Items.add('ERROR: CANNOT CONNECT TO '+IMAPT.NomeConta);
          Fmain.ListBox1.itemindex := Fmain.ListBox1.items.Count-1;
          result := nil;
          IMAPT.DisconnectNotifyPeer;
          IMAPT.Free;
          exit;
        end;

        IMAPT.UIDOK.Clear;
        IMAPT.UIDNUM.clear;
        IMAPT.UIDOKLida.Clear;
        IMAPT.UIDNUMLida.clear;
        if IMAPT.SelectMailBox('inbox') then
        begin
          try
            IMAPT.QtdMens := IMAPT.MailBox.TotalMsgs;
          except
            Fmain.ListBox1.Items.add('ERROR: Disconnected from server '+IMAPT.NomeConta);
            Fmain.ListBox1.itemindex := Fmain.ListBox1.items.Count-1;
            result:=nil;
            IMAPT.DisconnectNotifyPeer;
            IMAPT.free;
            exit;
          end;
          for i := 1 to IMAPT.MailBox.TotalMsgs do
          begin
            try
              IMAPT.GetUID(i,S);
            except
               result:=nil;
               IMAPT.DisconnectNotifyPeer;
               IMAPT.free;
               exit;
            end;
            IMAPT.UIDOK.Add(S);
            IMAPT.UIDNUM.Add(S);
            IMAPT.UIDOKLida.Add(S);
            IMAPT.UIDNUMlida.Add(S);
          end;
          PegaMensImap(IMAPT);
        end;
        result:=IMAPT;
      end
      else
      begin
        result:=IMAPT;
      end;
    end;
  end;
end;







Function CriaIMAP(IMAPT:TIMAP;Ticket:TmtTicket):TImap;
            function existeLista(conta:integer):TImap;
            var
              i : Integer;
            begin
              result:=nil;
              for i := 0 to Fmain.ListaIMAP.count - 1 do
              begin
                if Fmain.ListaIMAP.Items[i].IDConta = conta then
                begin
                  result:= Fmain.ListaIMAP.Items[i];
                  break;
                end;
              end;

            end;

var
  IMAPT2 : TIMAP;
  //SSLT : TIdSSLIOHandlerSocketOpenSSL;
  i:Integer;
  S:String;
begin



  {
  if DM_Server.PegaContasPOP(Conta) then
  begin

    With dm_Server do
    begin
      IMAPT := existeLista(Conta);
      if IMAPT = nil then
      begin

        IMAPT := TIMAP.Create;
        SSLT := TIdSSLIOHandlerSocketOpenSSL.Create(IMAPT);

        IMAPT.Host      :=  QContasCon.FieldByName('POP').AsString;
        IMAPT.Password  :=  QContasCon.FieldByName('Senha').AsString;
        IMAPT.Port      :=  QContasCon.FieldByName('Porta').AsInteger;
        IMAPT.Username  :=  QContasCon.FieldByName('usuario').AsString;
        SSLT.SSLOptions.Method := sslvSSLv2;
        IMAPT.IDConta := Conta;
        IMAPT.NomeConta :=  QContasCon.FieldByName('Nome').AsString;


        if QContasCon.FieldByName('SSL').asinteger = 1 then
        begin
          IMAPT.IOHandler := SSLT;
          IMAPT.UseTLS    := utUseImplicitTLS;
        end
        else
        begin
          IMAPT.IOHandler := nil;
          IMAPT.UseTLS    := utNoTLSSupport;
        end;


      try
        IMAPT.ConnectTimeout := 2000;

          try
          IMAPT.Connect;
          except
          result := nil;
          IMAPT.Free;
          exit;
          end;  }



        IMAPT2 := existeLista(IMAPT.IDConta);
        if  IMAPT2 = nil then
        begin
          IMAPT.Ticket := ticket;
          Fmain.ListaIMAP.add(IMAPT);
          Result := IMAPT;
        end
        else
        begin
          result:= IMAPT2;
        end;

    end;







end.


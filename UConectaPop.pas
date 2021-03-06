unit UConectaPop;


interface

uses
  UcriaObjetos, JvMTConsts, Windows, Messages, SysUtils, Variants, Classes,
  Graphics, Controls, IdIOHandlerSocket,IdSSL,IdSSLOpenSSL,
  IdMessage,
  IdBaseComponent, IdComponent, IdTCPConnection,IdTCPClient,
  IdExplicitTLSClientServerBase,
  IdMessageClient, IdPOP3, myaccess, DBClient, IdAntiFreezeBase, dialogs;

Function  CriaPOP(POPT:TPOP;Ticket:TmtTicket):Tpop;
Procedure PegaMensPop(Popwork:Tpop);
Procedure SeparaUIDPop(PopWork:Tpop);
Function  inicializaPop(Conta:integer):Tpop;



implementation



Uses Udmserver, Umain;


Procedure PegaMensPop(Popwork:Tpop);
var
  I,achou : Integer;
  tabMens : TClientDataSet;
begin
  With DM_Server do
  begin



    tabMens := TClientDataSet.create(nil);
    tabMens.CloneCursor(dm_server.cds_Mens,false,false);
    tabMens.IndexFieldNames := 'ID_Conta';
    tabmens.filter := 'ID_conta = '+inttostr(Popwork.IDConta);
    tabmens.Filtered := true;
    {tabMens.SQL.text := 'Select * from messages where ID_conta = '+inttostr(Popwork.IDConta);
    tabMens.SQLInsert := cds_Mens.SQLInsert;
    tabMens.SQLDelete := cds_Mens.SQLDelete;
    tabMens.SQLUpdate := cds_Mens.SQLUpdate;
    tabMens.SQLRefresh := cds_Mens.SQLRefresh;
    tabMens.Connection := cds_Mens.Connection;
    tabMens.open;}



    tabMens.First;



    while not tabMens.Eof do
    begin
      achou := Popwork.UIDOK.Indexof(tabMens.FieldByName('UID').asString);
      if achou >= 0 then
      begin
        Popwork.UIDOK.BeginUpdate;
        Popwork.UIDOK.Delete(achou);
        Popwork.UIDOK.EndUpdate;

        Popwork.UIDNUM.BeginUpdate;
        Popwork.UIDNUM.Delete(achou);
        Popwork.UIDNUM.EndUpdate;
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



Procedure SeparaUIDPop(PopWork:Tpop);
var
I, achou : integer;
Monta, Num, UIDT    : string;
begin

PopWork.UIDOK.Clear;
PopWork.UIDNUM.Clear;
PopWork.UIDOKLida.Clear;
PopWork.UIDNUMLida.Clear;

for I := 0 to PopWork.UIDs.Count - 1 do
   begin
     monta :=  stringreplace(PopWork.UIDs.Strings[i],#13#10,'',[]);
     achou := pos(' ',monta);
     Num   := copy(monta,1,achou-1);
     UIDT  := copy(monta,achou+1,length(monta)-(achou));
     PopWork.UIDOK.Add(UIDT);
     PopWork.UIDNUM.Add(Num);
     PopWork.UIDOKlida.Add(UIDT);
     PopWork.UIDNUMLida.Add(Num);
   end;
end;













function inicializaPop(conta:integer):Tpop;
            function existeListaPop(conta:integer):Tpop;
            var
              i : Integer;
            begin
              result:=nil;
              for i := 0 to Fmain.ListaPop.count - 1 do
              begin
                if Fmain.ListaPop.Items[i].IDConta = conta then
                begin
                  result:= Fmain.ListaPop.Items[i];
                  break;
                end;
              end;

            end;


var
  POPT : TPOP;
  SSLT : TIdSSLIOHandlerSocketOpenSSL;

begin

  if DM_Server.PegaContasPOP(Conta) then
  begin
    With dm_Server do
    begin
    Popt := existeListaPop(Conta);


      if Popt = nil then
      begin


        POPT := Tpop.Create;
        SSLT := TIdSSLIOHandlerSocketOpenSSL.Create(POPT);
        POPT.IOHandler := SSLT;

        POPT.Host      :=  QContasCon.FieldByName('POP').AsString;
        POPT.Password  :=  QContasCon.FieldByName('Senha').AsString;
        POPT.Port      :=  QContasCon.FieldByName('Porta').AsInteger;
        POPT.Username  :=  QContasCon.FieldByName('Usuario').AsString;
        POPT.IDConta   :=  Conta;
        POPT.NomeConta :=  QContasCon.FieldByName('Nome').AsString;

        if POPT.Port <> 110 then
        begin
          SSLT.SSLOptions.Method := sslvTLSv1;
          POPT.UseTLS    := utUseImplicitTLS;
        end
        else
        begin
          SSLT.SSLOptions.Method := sslvTLSv1;
          POPT.UseTLS    := utNoTLSSupport;
        end;
        POPT.ConnectTimeout := 10000;
        POPT.ReadTimeout := 10000;
        try
          POPT.Connect;
        except
          try
            POPT.DisconnectNotifyPeer;
          except
          end;
          Fmain.ListBox1.Items.add('ERROR: CANNOT CONNECT TO '+POPT.NomeConta);
          Fmain.ListBox1.itemindex := Fmain.ListBox1.items.Count-1;
          POPT.Free;
          result := nil;
          exit;
        end;
        try
          POPT.QtdMens := POPT.CheckMessages;
        except
          try
            popt.DisconnectNotifyPeer;
          except
          end;
          Fmain.ListBox1.Items.add('ERROR: Disconnected from server '+POPT.NomeConta);
          Fmain.ListBox1.itemindex := Fmain.ListBox1.items.Count-1;
          POPT.Free;
          result:=nil;
          exit;
        end;
        try
          POPT.UIDL(POPT.UIDS);
        except
          try
            popt.DisconnectNotifyPeer;
          except
          end;
          Fmain.ListBox1.Items.add('ERROR: Disconnected from server '+POPT.NomeConta);
          Fmain.ListBox1.itemindex := Fmain.ListBox1.items.Count-1;
          popt.Free;
          result:=nil;
          exit;
        end;
        SeparaUIDPop(POPT);
        PegaMensPop(POPT);
        Popt.KeepAlive;
        result := Popt;
      end
      else
      begin
        result := Popt;
      end;
    end;
  end;
end;



Function CriaPOP(POPT:TPOP;Ticket:TmtTicket):Tpop;
            function existeListaPop(conta:integer):Tpop;
            var
              i : Integer;
            begin
              result:=nil;
              for i := 0 to Fmain.ListaPop.count - 1 do
              begin
                if Fmain.ListaPop.Items[i].IDConta = conta then
                begin
                  result:= Fmain.ListaPop.Items[i];
                  break;
                end;
              end;
            end;

var
  POPT2 : TPOP;
begin
  POPT2 :=  existeListaPop(POPT.IDConta);
  if POPT2 = nil then
  begin
    POPT.Ticket := Ticket;
    Fmain.ListaPop.add(POPT);
    result:= POPT;
  end
  else
  begin
    result:= POPT2;
  end;
end;







end.

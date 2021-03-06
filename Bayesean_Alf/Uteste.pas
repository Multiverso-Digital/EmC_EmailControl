unit Uteste;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBAccess, MyAccess, MemDS, StdCtrls, DBClient, Provider, ComCtrls,
  Grids, Wwdbigrd, Wwdbgrid, Menus, DAScript, MyScript, generics.collections;

type
  TFteste = class(TForm)
    qToken: TMyQuery;
    MyConnection1: TMyConnection;
    provToken: TDataSetProvider;
    cdsToken: TClientDataSet;
    qMens: TMyQuery;
    provMens: TDataSetProvider;
    cdsMens: TClientDataSet;
    PB: TProgressBar;
    qbayesian: TMyQuery;
    ProvBayesian: TDataSetProvider;
    cdsBayesian: TClientDataSet;
    cdsTest: TClientDataSet;
    ProvTeste: TDataSetProvider;
    qTest: TMyQuery;
    ProgressBar1: TProgressBar;
    Memo1: TMemo;
    cdsTokenid: TIntegerField;
    cdsTokenpalavra: TStringField;
    cdsTokenqtd_spam: TIntegerField;
    cdsTokenqtd_ok: TIntegerField;
    cdsTokenmail_spam: TIntegerField;
    cdsTokenmail_ok: TIntegerField;
    cdsBayesianid: TIntegerField;
    cdsBayesianqtd_mail_spam: TIntegerField;
    cdsBayesianqtd_mail_ok: TIntegerField;
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    GroupBox2: TGroupBox;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Label1: TLabel;
    StringGrid1: TStringGrid;
    wwDBGrid1: TwwDBGrid;
    MyQuery1: TMyQuery;
    DataSource1: TDataSource;
    PopupMenu1: TPopupMenu;
    Aprende1: TMenuItem;
    AprendeOK1: TMenuItem;
    Button7: TButton;
    MyTable1: TMyTable;
    cdsMensID: TLargeintField;
    cdsMensDT: TDateTimeField;
    cdsMensEmail: TStringField;
    cdsMensAssunto: TStringField;
    cdsMensEmitente: TStringField;
    cdsMensTama: TIntegerField;
    cdsMensDatamens: TStringField;
    cdsMensCabec: TMemoField;
    cdsMensCorpo: TMemoField;
    cdsMensStatus: TIntegerField;
    cdsMensFiltrada: TIntegerField;
    cdsMensListaNegra: TIntegerField;
    cdsMensFavoritos: TIntegerField;
    cdsMensFiltroResult: TMemoField;
    cdsMensListaNegraResult: TMemoField;
    cdsMensNumeroMens: TIntegerField;
    cdsMensExcluida: TIntegerField;
    cdsMensAnexos: TIntegerField;
    cdsMensselecionada: TIntegerField;
    cdsMensConta: TStringField;
    cdsMensMsgId: TStringField;
    cdsMensIsBodyEmpty: TBooleanField;
    cdsMensUID: TStringField;
    cdsMensIsMsgSinglePartMime: TBooleanField;
    cdsMensAttachmentEncoding: TStringField;
    cdsMensCharSet: TStringField;
    cdsMensContentType: TStringField;
    cdsMensContentTransferEncoding: TStringField;
    cdsMensContentDisposition: TStringField;
    cdsMensNoEncode: TBooleanField;
    cdsMensNoDecode: TBooleanField;
    cdsMensOrganization: TStringField;
    cdsMensDataOrig: TStringField;
    cdsMensXmailer: TStringField;
    cdsMensReplayTO: TStringField;
    cdsMensReturnPath: TStringField;
    cdsMensFromOrig: TStringField;
    cdsMensToOrig: TMemoField;
    cdsMensCCOrig: TMemoField;
    cdsMensBCCOrig: TMemoField;
    cdsMensReceivedFrom: TStringField;
    cdsMensFriendResult: TMemoField;
    cdsMensEmailFrom: TStringField;
    cdsMensDominioFrom: TStringField;
    cdsMensIPSender: TStringField;
    cdsMensID_Conta: TIntegerField;
    cdsMensAnexosFiles: TMemoField;
    cdsMensCountry: TStringField;
    cdsMenslida: TIntegerField;
    cdsMensCorpoTexto: TMemoField;
    cdsTestID: TLargeintField;
    cdsTestDT: TDateTimeField;
    cdsTestEmail: TStringField;
    cdsTestAssunto: TStringField;
    cdsTestEmitente: TStringField;
    cdsTestTama: TIntegerField;
    cdsTestDatamens: TStringField;
    cdsTestCabec: TMemoField;
    cdsTestCorpo: TMemoField;
    cdsTestStatus: TIntegerField;
    cdsTestFiltrada: TIntegerField;
    cdsTestListaNegra: TIntegerField;
    cdsTestFavoritos: TIntegerField;
    cdsTestFiltroResult: TMemoField;
    cdsTestListaNegraResult: TMemoField;
    cdsTestNumeroMens: TIntegerField;
    cdsTestExcluida: TIntegerField;
    cdsTestAnexos: TIntegerField;
    cdsTestselecionada: TIntegerField;
    cdsTestConta: TStringField;
    cdsTestMsgId: TStringField;
    cdsTestIsBodyEmpty: TBooleanField;
    cdsTestUID: TStringField;
    cdsTestIsMsgSinglePartMime: TBooleanField;
    cdsTestAttachmentEncoding: TStringField;
    cdsTestCharSet: TStringField;
    cdsTestContentType: TStringField;
    cdsTestContentTransferEncoding: TStringField;
    cdsTestContentDisposition: TStringField;
    cdsTestNoEncode: TBooleanField;
    cdsTestNoDecode: TBooleanField;
    cdsTestOrganization: TStringField;
    cdsTestDataOrig: TStringField;
    cdsTestXmailer: TStringField;
    cdsTestReplayTO: TStringField;
    cdsTestReturnPath: TStringField;
    cdsTestFromOrig: TStringField;
    cdsTestToOrig: TMemoField;
    cdsTestCCOrig: TMemoField;
    cdsTestBCCOrig: TMemoField;
    cdsTestReceivedFrom: TStringField;
    cdsTestFriendResult: TMemoField;
    cdsTestEmailFrom: TStringField;
    cdsTestDominioFrom: TStringField;
    cdsTestIPSender: TStringField;
    cdsTestID_Conta: TIntegerField;
    cdsTestAnexosFiles: TMemoField;
    cdsTestCountry: TStringField;
    cdsTestlida: TIntegerField;
    cdsTestCorpoTexto: TMemoField;
    MyQuery2: TMyQuery;
    MyQuery1ID: TLargeintField;
    MyQuery1DT: TDateTimeField;
    MyQuery1Email: TStringField;
    MyQuery1Assunto: TStringField;
    MyQuery1Emitente: TStringField;
    MyQuery1Tama: TIntegerField;
    MyQuery1Datamens: TDateTimeField;
    MyQuery1Cabec: TMemoField;
    MyQuery1Corpo: TMemoField;
    MyQuery1Status: TIntegerField;
    MyQuery1Filtrada: TIntegerField;
    MyQuery1ListaNegra: TIntegerField;
    MyQuery1Favoritos: TIntegerField;
    MyQuery1FiltroResult: TMemoField;
    MyQuery1ListaNegraResult: TMemoField;
    MyQuery1NumeroMens: TIntegerField;
    MyQuery1Excluida: TIntegerField;
    MyQuery1Anexos: TIntegerField;
    MyQuery1selecionada: TIntegerField;
    MyQuery1Conta: TStringField;
    MyQuery1MsgId: TStringField;
    MyQuery1IsBodyEmpty: TBooleanField;
    MyQuery1UID: TStringField;
    MyQuery1IsMsgSinglePartMime: TBooleanField;
    MyQuery1AttachmentEncoding: TStringField;
    MyQuery1CharSet: TStringField;
    MyQuery1ContentType: TStringField;
    MyQuery1ContentTransferEncoding: TStringField;
    MyQuery1ContentDisposition: TStringField;
    MyQuery1NoEncode: TBooleanField;
    MyQuery1NoDecode: TBooleanField;
    MyQuery1Organization: TStringField;
    MyQuery1DataOrig: TStringField;
    MyQuery1Xmailer: TStringField;
    MyQuery1ReplayTO: TStringField;
    MyQuery1ReturnPath: TStringField;
    MyQuery1FromOrig: TStringField;
    MyQuery1ToOrig: TStringField;
    MyQuery1CCOrig: TMemoField;
    MyQuery1BCCOrig: TMemoField;
    MyQuery1ReceivedFrom: TStringField;
    MyQuery1FriendResult: TMemoField;
    MyQuery1EmailFrom: TStringField;
    MyQuery1DominioFrom: TStringField;
    MyQuery1IPSender: TStringField;
    MyQuery1ID_Conta: TIntegerField;
    MyQuery1AnexosFiles: TMemoField;
    MyQuery1Country: TStringField;
    MyQuery1lida: TIntegerField;
    MyQuery1Spam: TLargeintField;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure wwDBGrid1DblClick(Sender: TObject);
    procedure Aprende1Click(Sender: TObject);
    procedure AprendeOK1Click(Sender: TObject);
    procedure wwDBGrid1TitleButtonClick(Sender: TObject; AFieldName: string);
    procedure Button7Click(Sender: TObject);
  private
    { Private declarations }
    procedure aprendeNormal();
    procedure TestaSpamNormal();
    procedure TestaOKNormal();
    procedure aprendeCabec();
    procedure testaSpanCabec();
    procedure testaOKCabec();
  public
    { Public declarations }
  end;

var
  Fteste: TFteste;
Const
  itens : array[1..8] of string = ('From','Subject','Received', 'CC', 'To', 'Return-Path', 'DomainKey-Signature', 'Sender' );

implementation

{$R *.dfm}

uses Ubayesian;

procedure TFteste.Aprende1Click(Sender: TObject);
var
teste : TBayesian;
begin
teste := TBayesian.create('K:\@Projetos_em_andamento\EmC2011_Thread\Dados\');
teste.learn(MyQuery1Cabec.AsString,Itens,1);
end;

procedure TFteste.aprendeCabec;
var
  teste:TBayesian;
  i,v: Integer;
  s:String;
begin
  teste := TBayesian.create('K:\@Projetos_em_andamento\EmC2011_Thread\Dados\');
  if cdsMens.active then cdsMens.Close;
  cdsMens.Open;
  memo1.lines.add('Aprendendo com: '+inttostr(cdsMens.RecordCount)+' mensagens');
  teste.reset();
  PB.Max := cdsMens.RecordCount;
  v:=0;
  while NOT cdsMens.eof do
  begin
    PB.Position := cdsMens.RecNo;
    Application.ProcessMessages;
    inc(v);
    if cdsMensListaNegra.AsInteger = 1 then
    begin
      s:= cdsMensCabec.AsString;
      teste.learn(s, itens, 1);
    end
    else if cdsMensFavoritos.AsInteger = 1 then
    begin
      s:= cdsMensCabec.AsString;
      teste.learn(s, itens, 2);
    end;
    label1.Caption := inttostr(v);
    cdsMens.Next;
  end;

  teste.Free;

end;

procedure TFteste.aprendeNormal();
var
  teste:TBayesian;
  i,v: Integer;
begin
  teste := TBayesian.create('K:\@Projetos_em_andamento\EmC2011_Thread\Dados\');
  if cdsMens.active then cdsMens.Close;
  cdsMens.Open;
  memo1.lines.add('Aprendendo com: '+inttostr(cdsMens.RecordCount)+' mensagens');
  teste.reset();
  PB.Max := cdsMens.RecordCount;
  v:=0;
  while NOT cdsMens.eof do
  begin
    inc(v);
    PB.Position := cdsMens.RecNo;
    Application.ProcessMessages;
    if cdsMensListaNegra.AsInteger = 1 then
    begin
      teste.learn(cdsMensCabec.asString, 1);
    end
    else if cdsMensFavoritos.AsInteger = 1 then
    begin
      teste.learn(cdsMensCabec.asString, 2);
    end;

    cdsMens.Next;
    label1.Caption := inttostr(v);
  end;
  teste.Free;
end;

procedure TFteste.AprendeOK1Click(Sender: TObject);
var
teste : TBayesian;
begin
teste := TBayesian.create('K:\@Projetos_em_andamento\EmC2011_Thread\Dados\');
teste.learn(MyQuery1Cabec.AsString,Itens,2);
teste.Free;
end;

procedure TFteste.TestaSpamNormal();
var
  teste:TBayesian;

begin
  if cdsTest.Active then cdsTest.Close;
  cdsTest.Params[0].AsInteger := 1;
  cdsTest.Params[1].AsInteger := 0;
  cdsTest.Open;
  cdsTest.first;
  memo1.Lines.Add('');
  teste := TBayesian.create('K:\@Projetos_em_andamento\EmC2011_Thread\Dados\');
  while not cdsTest.eof do
  begin
    memo1.Lines.Add(formatFloat('##0.000000000000',teste.TesteMail(cdsTestCabec.asString, [])));
    cdsTest.Next;
  end;
  teste.Free;
end;

procedure TFteste.testaSpanCabec;
var
  teste:TBayesian;
  i: Integer;
begin
  if cdsTest.Active then cdsTest.Close;
  cdsTest.Params[0].AsInteger := 1;
  cdsTest.Params[1].AsInteger := 0;
  cdsTest.Open;
  cdsTest.first;
  memo1.Lines.Add('');
  teste := TBayesian.create('K:\@Projetos_em_andamento\EmC2011_Thread\Dados\');
  while not cdsTest.eof do
  begin
    memo1.Lines.Add(formatFloat('##0.000000000000',teste.TesteMail(cdsTestCabec.asString, Itens)));



    cdsTest.Next;
  end;
  teste.Free;
end;

procedure TFteste.wwDBGrid1DblClick(Sender: TObject);
var
  teste:TBayesian;
  i:Integer;
  Lista2:Tlist<TToken>;
begin
 memo1.Lines.Add('');
 teste := TBayesian.create('K:\@Projetos_em_andamento\EmC2011_Thread\Dados\');
 Lista2:=Tlist<TToken>.Create;
 memo1.Lines.Add(formatFloat('##0.000000000000',teste.TesteMail(MyQuery1Cabec.asString, [])));
 Lista2 := teste.listaTokenTeste;
 StringGrid1.RowCount := Lista2.Count;
 for i := 0 to Teste.listaTokenTeste.Count - 1 do
 begin
   StringGrid1.Cells[0,i] := Lista2.Items[i].strToken;
   StringGrid1.Cells[1,i] := formatFloat('##0.000000000000',Lista2.Items[i].PToken);
 end;
 teste.Free;
end;

procedure TFteste.wwDBGrid1TitleButtonClick(Sender: TObject;
  AFieldName: string);
begin
  MyQuery1.IndexFieldNames := AFieldName;
  MyQuery1.Refresh;
end;

procedure TFteste.TestaOKNormal();
var
  teste:TBayesian;

begin
  if cdsTest.Active then cdsTest.Close;
  cdsTest.Params[0].AsInteger := 0;
  cdsTest.Params[1].AsInteger := 1;
  cdsTest.Open;
  cdsTest.first;

  memo1.Lines.Add('');
  teste := TBayesian.create('K:\@Projetos_em_andamento\EmC2011_Thread\Dados\');
  while not cdsTest.eof do
  begin
    memo1.Lines.Add(formatFloat('##0.000000000000',teste.TesteMail(cdsTestCabec.asString, [])));
    cdsTest.Next;
  end;
  teste.Free;
end;



procedure TFteste.Button1Click(Sender: TObject);
begin
aprendeNormal();
end;

procedure TFteste.Button2Click(Sender: TObject);
begin
TestaSpamNormal();
end;

procedure TFteste.Button3Click(Sender: TObject);
begin
TestaOKNormal();
end;






procedure TFteste.Button4Click(Sender: TObject);
begin
  aprendeCabec();
end;

procedure TFteste.Button5Click(Sender: TObject);
begin
testaSpanCabec();
end;

procedure TFteste.Button6Click(Sender: TObject);
begin
testaOKCabec();
end;

procedure TFteste.Button7Click(Sender: TObject);
var
teste:TBayesian;
begin
teste := TBayesian.create('K:\@Projetos_em_andamento\EmC2011_Thread\Dados\');
teste.reset;
teste.Free;
end;

procedure TFteste.FormShow(Sender: TObject);
begin
  MyQuery1.Open;
end;

procedure TFteste.testaOKCabec;
var
  teste:TBayesian;

begin
  if cdsTest.Active then cdsTest.Close;
  cdsTest.Params[0].AsInteger := 0;
  cdsTest.Params[1].AsInteger := 1;
  cdsTest.Open;
  cdsTest.first;
  memo1.Lines.Add('');
  teste := TBayesian.create('K:\@Projetos_em_andamento\EmC2011_Thread\Dados\');
  while not cdsTest.eof do
  begin
    memo1.Lines.Add(formatFloat('##0.000000000000',teste.TesteMail(cdsTestCabec.asString, Itens)));
    cdsTest.Next;
  end;
end;

end.

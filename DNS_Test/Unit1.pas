unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection,
  IdDNSResolver, DB, Wwdatsrc, DBClient, Provider, MemDS, DBAccess, MyAccess,
  Grids, Wwdbigrd, Wwdbgrid, ComCtrls, ExtCtrls, IdIntercept, IdLogBase,
  IdLogEvent, IdCustomTransparentProxy, IdSocks;

type
  TForm1 = class(TForm)
    IdDNSResolver1: TIdDNSResolver;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Edit1: TEdit;
    Memo1: TMemo;
    Button1: TButton;
    TabSheet2: TTabSheet;
    wwDBGrid1: TwwDBGrid;
    MyConnection1: TMyConnection;
    MyQuery1: TMyQuery;
    DataSetProvider1: TDataSetProvider;
    ClientDataSet1: TClientDataSet;
    wwDataSource1: TwwDataSource;
    Button2: TButton;
    ClientDataSet1ID: TLargeintField;
    ClientDataSet1DT: TDateTimeField;
    ClientDataSet1Email: TStringField;
    ClientDataSet1Assunto: TStringField;
    ClientDataSet1Emitente: TStringField;
    ClientDataSet1Tama: TIntegerField;
    ClientDataSet1Datamens: TDateTimeField;
    ClientDataSet1Cabec: TMemoField;
    ClientDataSet1Corpo: TMemoField;
    ClientDataSet1Status: TIntegerField;
    ClientDataSet1Filtrada: TIntegerField;
    ClientDataSet1ListaNegra: TIntegerField;
    ClientDataSet1Favoritos: TIntegerField;
    ClientDataSet1FiltroResult: TMemoField;
    ClientDataSet1ListaNegraResult: TMemoField;
    ClientDataSet1NumeroMens: TIntegerField;
    ClientDataSet1Excluida: TIntegerField;
    ClientDataSet1Anexos: TIntegerField;
    ClientDataSet1selecionada: TIntegerField;
    ClientDataSet1Conta: TStringField;
    ClientDataSet1MsgId: TStringField;
    ClientDataSet1IsBodyEmpty: TBooleanField;
    ClientDataSet1UID: TStringField;
    ClientDataSet1IsMsgSinglePartMime: TBooleanField;
    ClientDataSet1AttachmentEncoding: TStringField;
    ClientDataSet1CharSet: TStringField;
    ClientDataSet1ContentType: TStringField;
    ClientDataSet1ContentTransferEncoding: TStringField;
    ClientDataSet1ContentDisposition: TStringField;
    ClientDataSet1NoEncode: TBooleanField;
    ClientDataSet1NoDecode: TBooleanField;
    ClientDataSet1Organization: TStringField;
    ClientDataSet1DataOrig: TStringField;
    ClientDataSet1Xmailer: TStringField;
    ClientDataSet1ReplayTO: TStringField;
    ClientDataSet1ReturnPath: TStringField;
    ClientDataSet1FromOrig: TStringField;
    ClientDataSet1ToOrig: TStringField;
    ClientDataSet1CCOrig: TMemoField;
    ClientDataSet1BCCOrig: TMemoField;
    ClientDataSet1ReceivedFrom: TStringField;
    ClientDataSet1FriendResult: TMemoField;
    ClientDataSet1EmailFrom: TStringField;
    ClientDataSet1DominioFrom: TStringField;
    ClientDataSet1IPSender: TStringField;
    ClientDataSet1ID_Conta: TIntegerField;
    ClientDataSet1AnexosFiles: TMemoField;
    ClientDataSet1Country: TStringField;
    ClientDataSet1DNSresolv: TStringField;
    Memo2: TMemo;
    IdConnectionIntercept1: TIdConnectionIntercept;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure IdLogEvent1Received(ASender: TComponent; const AText,
      AData: string);
    procedure IdLogEvent1Status(ASender: TComponent; const AText: string);
    procedure IdSocksInfo1Status(ASender: TObject; const AStatus: TIdStatus;
      const AStatusText: string);
    procedure IdDNSResolver1Status(ASender: TObject; const AStatus: TIdStatus;
      const AStatusText: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  i:integer;
begin
  IdDNSResolver1.QueryType := [qta];

  IdDNSResolver1.Resolve(edit1.Text);
  begin
    for i := 0 to IdDNSResolver1.QueryResult.Count - 1 do
    begin
      if IdDNSResolver1.QueryResult.Items[i] is TARecord then
      begin
       memo1.Lines.Add( TARecord(IdDNSResolver1.QueryResult.Items[i]).IPAddress);

      end;

    end;
  end;


end;

procedure TForm1.Button2Click(Sender: TObject);
var
  i: Integer;
  tDNS:String;
begin
  if ClientDataSet1.Active then ClientDataSet1.Close;
  ClientDataSet1.Open;

  IdDNSResolver1.QueryType := [qtPTR];
  IdDNSResolver1.QueryResult.Clear;
  tDNS := '';
  while not ClientDataSet1.Eof do
  begin
    Application.ProcessMessages;
  if (trim(ClientDataSet1IPSender.asString) <> '') then
  begin
    try
      IdDNSResolver1.Resolve(ClientDataSet1IPSender.asString);
      for i := 0 to IdDNSResolver1.QueryResult.Count - 1 do
      begin
        if IdDNSResolver1.QueryResult.Items[i] is TPTRRecord then
        begin
          ClientDataSet1.Edit;
          ClientDataSet1DNSresolv.AsString := ClientDataSet1DNSresolv.AsString +
                    TPTRRecord(IdDNSResolver1.QueryResult.Items[i]).HostName;
          ClientDataSet1.Post;
          ClientDataSet1.RefreshRecord;
        end;
      end;
    except
      ClientDataSet1.Edit;
          ClientDataSet1DNSresolv.AsString := 'Erro de dns';
          ClientDataSet1.Post;
    end;
  end;
  ClientDataSet1.Next;
  IdDNSResolver1.QueryResult.Clear;
  tDNS := '';
  end;

end;

procedure TForm1.IdDNSResolver1Status(ASender: TObject;
  const AStatus: TIdStatus; const AStatusText: string);
begin
memo2.lines.add('****');
memo2.lines.add(AStatusText);

end;

procedure TForm1.IdLogEvent1Received(ASender: TComponent; const AText,
  AData: string);
begin
memo2.lines.add('****');
memo2.lines.add(AText);
memo2.lines.add(AData);
end;

procedure TForm1.IdLogEvent1Status(ASender: TComponent; const AText: string);
begin
memo2.lines.add('****');
memo2.lines.add(AText);
end;

procedure TForm1.IdSocksInfo1Status(ASender: TObject; const AStatus: TIdStatus;
  const AStatusText: string);
begin
memo2.lines.add('****');
memo2.lines.add(AStatusText);
end;

end.

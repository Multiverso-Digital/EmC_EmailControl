unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WideStrings, DbxBlackfishSQL, FMTBcd, wwSpeedButton, wwDBNavigator,
  ExtCtrls, wwclearpanel, Grids, Wwdbigrd, Wwdbgrid, DB, SqlExpr, StdCtrls,
  DBClient, Provider;

type
  TForm1 = class(TForm)
    Teste_Thread: TSQLConnection;
    DataSource1: TDataSource;
    wwDBGrid1: TwwDBGrid;
    wwDBNavigator1: TwwDBNavigator;
    wwDBNavigator1First: TwwNavButton;
    wwDBNavigator1PriorPage: TwwNavButton;
    wwDBNavigator1Prior: TwwNavButton;
    wwDBNavigator1Next: TwwNavButton;
    wwDBNavigator1NextPage: TwwNavButton;
    wwDBNavigator1Last: TwwNavButton;
    wwDBNavigator1Insert: TwwNavButton;
    wwDBNavigator1Delete: TwwNavButton;
    wwDBNavigator1Edit: TwwNavButton;
    wwDBNavigator1Post: TwwNavButton;
    wwDBNavigator1Cancel: TwwNavButton;
    wwDBNavigator1Refresh: TwwNavButton;
    wwDBNavigator1SaveBookmark: TwwNavButton;
    wwDBNavigator1RestoreBookmark: TwwNavButton;
    Button1: TButton;
    Button2: TButton;
    DataSetProvider1: TDataSetProvider;
    ClientDataSet1: TClientDataSet;
    SQLQuery1: TSQLQuery;
    ClientDataSet1NOME: TWideStringField;
    DataSource2: TDataSource;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
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
begin
  ClientDataSet1.Open;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  ClientDataSet1.ApplyUpdates(0);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  dire:string;
begin
  dire:= ExtractFilePath(Application.ExeName);
  with Teste_Thread.Params do
  begin
        Clear;
        Add('drivername=BLACKFISHSQL');
        Add('Password=masterkey');
        Add('user_name=sysdba');
        Add('port=2508');
        Add('create=false');
        Add('readonlydb=False');
        Add('HostName=localhost');
        Add('database='+dire+'Teste.jds');
  end;

  Teste_Thread.Connected := true;

end;

end.

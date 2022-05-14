unit Unit2;

interface

uses
  SysUtils, Classes, IdMessage, IdAntiFreezeBase, IdAntiFreeze, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase,
  IdMessageClient, IdPOP3, DB, MemDS, DBAccess, MyAccess;

type
  TDM = class(TDataModule)
    MC: TMyConnection;
    MyQuery1: TMyQuery;
    POP: TIdPOP3;
    IdAntiFreeze1: TIdAntiFreeze;
    MSG: TIdMessage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{$R *.dfm}

end.

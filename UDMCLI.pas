unit UDMCLI;

interface

uses
  SysUtils, Classes, DB, DBClient;

type
  TDM_CLI = class(TDataModule)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM_CLI: TDM_CLI;

implementation

{$R *.dfm}

uses udmserver;

end.

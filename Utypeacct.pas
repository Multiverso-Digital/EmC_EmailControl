unit Utypeacct;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFTypeAcct = class(TForm)
    RadioGroup1: TRadioGroup;
    procedure RadioGroup1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FTypeAcct: TFTypeAcct;

implementation

uses UDMSERVER, Ucontas_new;

{$R *.dfm}

procedure TFTypeAcct.RadioGroup1Click(Sender: TObject);
begin

if RadioGroup1.ItemIndex = 0 then  dm_server.TipoConta := 'POP3';
if RadioGroup1.ItemIndex = 1 then  dm_server.TipoConta := 'IMAP';
if RadioGroup1.ItemIndex = 2 then  dm_server.TipoConta := 'Hotmail';

FContas_New := TFContas_New.create(self);
FContas_New.showmodal;
FContas_New.free;


close;

end;

end.

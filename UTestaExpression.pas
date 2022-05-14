unit UTestaExpression;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, funcoes;

type
  TFTestaExpression = class(TForm)
    GroupBox1: TGroupBox;
    Etexto: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Eexpressao: TEdit;
    Button1: TButton;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    GroupBox3: TGroupBox;
    Label7: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label8: TLabel;
    Label11: TLabel;
    GroupBox4: TGroupBox;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FTestaExpression: TFTestaExpression;

implementation

uses udmserver;

{$R *.dfm}

procedure TFTestaExpression.Button1Click(Sender: TObject);
begin

if trim(etexto.Text) = '' then
   begin
   showmessage('Text to test is missing. ');
   exit;
   end;


if trim(eexpressao.Text) = '' then
   begin
   showmessage('Expression to test is missing. ');
   exit;
   end;


 If   buscaRegexp(trim(Eexpressao.text),trim(Etexto.text),2) then
      begin
        showmessage('Result is OK!');
      end
      else
      begin
        showmessage('Result is NOT OK!');
      end;

end;

procedure TFTestaExpression.FormShow(Sender: TObject);
begin

if dm_server.quem = 1 then FTestaExpression.Color := clMoneyGreen;
if dm_server.quem = 2 then FTestaExpression.Color := $00CECEFF;
if dm_server.quem = 3 then FTestaExpression.Color := $00BFFFFF;




end;

end.

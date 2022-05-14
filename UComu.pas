unit UComu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls;

type
  TFComu = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    GroupBox1: TGroupBox;
    Button1: TButton;
    PB: TProgressBar;
    Panel2: TPanel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FComu: TFComu;

implementation

uses Umain;

{$R *.dfm}

procedure TFComu.Button1Click(Sender: TObject);
begin
Fmain.GravaIPnoWebService;
end;

end.

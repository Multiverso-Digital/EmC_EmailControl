unit USetUp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, JvExMask, JvSpin, ExtCtrls, Grids, Wwdbigrd, Wwdbgrid, db,
  {Tabs,} ComCtrls, wwDialog, wwrcdvw, DBCtrls, wwdbedit, Wwdbspin, JvExExtCtrls,
  JvImage, JvExControls, JvxSlider, Tabs;

type
  TFSetUp = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    TabSet1: TTabSet;
    wwDBGrid2: TwwDBGrid;
    wwDBGrid1: TwwDBGrid;
    wwRecordViewDialog1: TwwRecordViewDialog;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    DBCheckBox5: TDBCheckBox;
    DBCheckBox6: TDBCheckBox;
    wwDBSpinEdit1: TwwDBSpinEdit;
    JvImage1: TJvImage;
    JvImage2: TJvImage;
    JvImage3: TJvImage;
    JvImage4: TJvImage;
    JvImage5: TJvImage;
    JvxSlider1: TJvxSlider;
    CB1: TCheckBox;
    DBCheckBox2: TDBCheckBox;
    Label3: TLabel;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure wwDBGrid2DblClick(Sender: TObject);
    procedure JvxSlider1Change(Sender: TObject);
    procedure CB1Click(Sender: TObject);
    procedure DBCheckBox1Click(Sender: TObject);
    procedure DBCheckBox3Click(Sender: TObject);
    procedure DBCheckBox4Click(Sender: TObject);
    procedure DBCheckBox5Click(Sender: TObject);
    procedure DBCheckBox6Click(Sender: TObject);
    procedure wwDBSpinEdit1Change(Sender: TObject);
    procedure DBCheckBox2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FSetUp: TFSetUp;

implementation

uses UDMSERVER, Umain;

{$R *.dfm}

procedure TFSetUp.Button1Click(Sender: TObject);
begin
close;
end;

procedure TFSetUp.CB1Click(Sender: TObject);
begin
if cb1.checked then JvxSlider1.Value := 56;

end;

procedure TFSetUp.DBCheckBox1Click(Sender: TObject);
begin
if DBCheckBox1.Checked then dm_server.Baysean := 1 else  dm_server.Baysean := 0;
dm_server.TemFiltroNovo := true;

end;

procedure TFSetUp.DBCheckBox2Click(Sender: TObject);
begin
if DBCheckBox2.Checked then dm_server.FastDelete := 1 else  dm_server.FastDelete := 0;

end;

procedure TFSetUp.DBCheckBox3Click(Sender: TObject);
begin
if DBCheckBox3.Checked then dm_server.BlackList := 1 else  dm_server.BlackList := 0;
dm_server.TemFiltroNovo := true;
end;

procedure TFSetUp.DBCheckBox4Click(Sender: TObject);
begin
if DBCheckBox4.Checked then dm_server.Filter := 1 else  dm_server.Filter := 0;
dm_server.TemFiltroNovo := true;
end;

procedure TFSetUp.DBCheckBox5Click(Sender: TObject);
begin
if DBCheckBox5.Checked then dm_server.DNS := 1 else  dm_server.DNS := 0;
dm_server.TemFiltroNovo := true;
end;

procedure TFSetUp.DBCheckBox6Click(Sender: TObject);
begin
if DBCheckBox6.Checked then dm_server.Countries := 1 else  dm_server.Countries := 0;
dm_server.TemFiltroNovo := true;
end;

procedure TFSetUp.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin

if dm_server.qsetup.State = dsedit then
  begin
    dm_server.qsetupvalorBaysean.AsFloat := JvxSlider1.Value / 100;
    dm_server.qsetup.post;
  end;

if dm_server.cds_dns.State = dsedit then
  begin
    dm_server.cds_dns.post;
  end;

if dm_server.cds_sigla.State = dsedit then
begin
dm_server.cds_sigla.post;
end;


Fmain.RestoreTimer.interval := Round(dm_server.qsetupminutes.asinteger * 60000);


end;

procedure TFSetUp.FormShow(Sender: TObject);
begin
//eminuset.Value := dm_server.MinuSet;

dm_server.TemFiltroNovo := false;

dm_server.cds_sigla.Edit;
dm_server.qsetup.Edit;

JvxSlider1.Value := trunc(dm_server.qsetupvalorBaysean.AsFloat * 100);

end;

procedure TFSetUp.JvxSlider1Change(Sender: TObject);
begin

dm_server.valorBaysean := JvxSlider1.Value/100;

JvxSlider1.Hint := inttostr(JvxSlider1.value);

end;

procedure TFSetUp.wwDBGrid2DblClick(Sender: TObject);
begin
wwRecordViewDialog1.Execute;
end;

procedure TFSetUp.wwDBSpinEdit1Change(Sender: TObject);
begin
  if trunc(wwDBSpinEdit1.Value) < 1 then
  dm_server.MinuSet := 1 else
  dm_server.MinuSet := trunc(wwDBSpinEdit1.Value);
end;

end.

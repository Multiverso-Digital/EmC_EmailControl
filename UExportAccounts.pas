unit UExportAccounts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, JvComponentBase, JvDBGridExport, StdCtrls,
  JvExStdCtrls, JvButton, JvCtrls;

type
  TFExportAccounts = class(TForm)
    JvImgBtn1: TJvImgBtn;
    JvImgBtn2: TJvImgBtn;
    JvImgBtn3: TJvImgBtn;
    JvDBGridExcelExport1: TJvDBGridExcelExport;
    DBGrid1: TDBGrid;
    SaveDialog1: TSaveDialog;
    JvDBGridCSVExport1: TJvDBGridCSVExport;
    JvDBGridXMLExport1: TJvDBGridXMLExport;
    procedure JvImgBtn1Click(Sender: TObject);
    procedure JvDBGridExcelExport1Progress(Sender: TObject; Min, Max,
      Position: Cardinal; const AText: string; var AContinue: Boolean);
    procedure JvImgBtn2Click(Sender: TObject);
    procedure JvImgBtn3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
  Function PegaArq(Ext:string):string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FExportAccounts: TFExportAccounts;

implementation

uses udmserver;

{$R *.dfm}


function TFExportAccounts.PegaArq(Ext: string): string;
begin

if ext = 'xls' then
begin
Savedialog1.Filter      := 'MS-Excel|*.xls';
Savedialog1.DefaultExt  := Ext;
end;

if ext = 'csv' then
begin
Savedialog1.Filter      := 'CSV|*.csv';
Savedialog1.DefaultExt  := Ext;
end;


if ext = 'xml' then
begin
Savedialog1.Filter      := 'XML|*.xml';
Savedialog1.DefaultExt  := Ext;
end;


Savedialog1.execute;

result :=  Savedialog1.FileName;

end;



procedure TFExportAccounts.FormShow(Sender: TObject);
begin


  With DM_Server do
  begin
   cds_Contas.filtered := false;
   cds_Contas.first;
  end;


end;

procedure TFExportAccounts.JvDBGridExcelExport1Progress(Sender: TObject; Min,
  Max, Position: Cardinal; const AText: string; var AContinue: Boolean);
begin
application.ProcessMessages;
end;

procedure TFExportAccounts.JvImgBtn1Click(Sender: TObject);
begin

JvDBGridExcelExport1.FileName := PegaArq('xls');

try
JvDBGridExcelExport1.ExportGrid;
except
end;

end;

procedure TFExportAccounts.JvImgBtn2Click(Sender: TObject);
begin
JvDBGridCSVExport1.FileName := PegaArq('csv');
try
JvDBGridCSVExport1.ExportGrid;
except
end;



end;



procedure TFExportAccounts.JvImgBtn3Click(Sender: TObject);
begin

JvDBGridXMLExport1.FileName := PegaArq('xml');
try
JvDBGridXMLExport1.ExportGrid;
except
end;


end;

end.

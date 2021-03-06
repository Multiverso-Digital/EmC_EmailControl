unit Umontacdspais;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JvComponentBase, JvCSVBaseControls, DB, Grids, DBGrids,
  DBClient, ExtCtrls;

type
  TForm2 = class(TForm)
    JvCSVBase1: TJvCSVBase;
    Button1: TButton;
    cds: TClientDataSet;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    cdsIPNUMFROM: TLargeintField;
    cdsIPNUMTO: TLargeintField;
    cdssigla: TWideStringField;
    cdsmpais: TWideStringField;
    cdsID: TAutoIncField;
    Memo1: TMemo;
    Panel1: TPanel;
    Button2: TButton;
    procedure JvCSVBase1CursorChanged(Sender: TObject; NameValues: TStrings;
      FieldCount: Integer);
    procedure Button1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  parar : boolean;
  inclu, Naoinclu : integer;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin


parar := false;
inclu := 0;
naoinclu := 0;
cds.Open;
cds.DisableControls;
JvCSVBase1.RecordFirst;


while not parar do
begin
parar := true;
application.ProcessMessages;
JvCSVBase1.RecordNext;
Form2.Repaint;
end;


showmessage('Terminou');

cds.EnableControls;


end;

procedure TForm2.Button2Click(Sender: TObject);
begin

Parar := true;

end;

procedure TForm2.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
cds.close;
end;

procedure TForm2.JvCSVBase1CursorChanged(Sender: TObject; NameValues: TStrings;
  FieldCount: Integer);
var
SIPFrom, SIPTO, SPais, SSigla : string;
IPFROM,IPTO : Largeint;


begin


Parar := false;

SIPFROM :=  NameValues.Values['IPFROM'];
SIPTO   :=  NameValues.Values['IPTO'];
SPAIS   :=  NameValues.Values['PAIS'];
SSIGLA  := NameValues.Values['CTRY'];


if trim(SIPFROM) = '' then
   begin

   parar := true;
   exit;
   end;




try
IPFrom := strtoint64(SIPFROM);
IPTo := strtoint64(SIPTo);
except
showmessage('Pau no IP');
exit;
end;



if not cds.Locate('IPNUMFROM;IPNUMTO',vararrayof([IPFROM,IPTO]),[]) then
   begin

  // memo1.Lines.Add('From: '+SIPFROM+' TO: '+SIPTO+' Sigla: '+SSIGLA+' Pais: '+Spais);

   cds.Append;
   cdsIPNUMFROM.AsLargeInt := IPFROM;
   cdsIPNUMTO.AsLargeInt   := IPTO;
   cdssigla.AsString       := SSIGLA;
   cdsmpais.AsString       := SPAIS;
   cds.Post;
   inclu := inclu + 1;
   end
   else
   begin
     naoinclu := naoinclu + 1;
   end;


 panel1.Caption := 'Incluidos: '+inttostr(inclu)+'    N?o Incluidos: '+inttostr(naoinclu);



end;

end.

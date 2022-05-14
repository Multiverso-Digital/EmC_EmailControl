unit UTestaCrip;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, DBClient, funcoes, ExtCtrls, DBCtrls, StdCtrls, inifiles;

type
  TForm1 = class(TForm)
    DataSource1: TDataSource;
    cds: TClientDataSet;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Button1: TButton;
    Button2: TButton;
    cdsIPNUMFROM: TLargeintField;
    cdsIPNUMTO: TLargeintField;
    cdssigla: TWideStringField;
    cdsmpais: TWideStringField;
    cdsID: TAutoIncField;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public

  Lista : ThashedStringList;
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
cds.Close;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
achou : integer;
tama,zeros, I : integer;
monta : string;
begin

{
Cds.Open;
cds.DisableControls;
cds.First;
while not cds.eof do
begin

 tama  := length(inttostr(cdsIPNUMFROM.aslargeint));
 zeros :=  10 - tama;

 monta := '';

 for I := 1 to zeros do
   begin

    Monta := monta +'0';

   end;


 monta := monta + inttostr(cdsIPNUMFROM.aslargeint);

 Lista.Add(monta);
 cds.Next;


end;

cds.Close;
showmessage('Terminou');
}


 //achou := Lista.IndexOfName(edit1.text);
 Lista.Add(edit1.text);

 achou := Lista.IndexOf(edit1.text);
 if achou >= 0 then
  begin
  showmessage('Acchou '+inttostr(achou));
  Lista.Delete(achou);
  end;




end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin

Lista.SaveToFile('C:\PaisHashed.dat');
Lista.Free;


end;

procedure TForm1.FormCreate(Sender: TObject);
begin
Lista :=  ThashedStringList.Create;
Lista.LoadFromFile('C:\PaisHashed.dat');
Lista.Sorted := true;
Lista.Sort;
end;

end.

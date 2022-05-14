unit ULimpaCDS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, JvExMask, JvToolEdit, JvComponentBase, JvSearchFiles,
  Grids, DBGrids, ExtCtrls, DBCtrls, DB, DBClient;

type
  TForm2 = class(TForm)
    DataSource1: TDataSource;
    cds: TClientDataSet;
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    JvSearchFiles1: TJvSearchFiles;
    JvDirectoryEdit1: TJvDirectoryEdit;
    ComboBox1: TComboBox;
    Button1: TButton;
    ListBox1: TListBox;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure JvDirectoryEdit1AfterDialog(Sender: TObject; var AName: string;
      var AAction: Boolean);
    procedure ComboBox1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin

cds.EmptyDataSet;

end;

procedure TForm2.Button2Click(Sender: TObject);
begin

Listbox1.items.savetofile(combobox1.Items[combobox1.ItemIndex]);

end;

procedure TForm2.Button3Click(Sender: TObject);
begin

ListBox1.Items.Clear;

end;

procedure TForm2.Button4Click(Sender: TObject);
begin


cds.First;
while not cds.eof do
begin

 if cds.FieldByName('TypeBox').AsInteger <> 4 then
   begin
     cds.Delete;
   end
   else
   begin

   cds.Next;
   end;


end;



end;

procedure TForm2.ComboBox1Click(Sender: TObject);
begin



if pos('.dat',combobox1.Items[combobox1.ItemIndex]) <= 0 then
begin
if cds.Active then cds.Active := false;
cds.FileName := combobox1.Items[combobox1.ItemIndex];
cds.open;
end
else
begin

listbox1.Items.LoadFromFile(combobox1.Items[combobox1.ItemIndex]);

end;





end;

procedure TForm2.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
cds.Close;
end;

procedure TForm2.JvDirectoryEdit1AfterDialog(Sender: TObject; var AName: string;
  var AAction: Boolean);
begin
JvSearchFiles1.RootDirectory := Aname;

JvSearchFiles1.Search;


combobox1.Items := JvSearchFiles1.Files;

end;

end.

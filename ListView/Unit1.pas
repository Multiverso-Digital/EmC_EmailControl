unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, JvMemoryDataset, StdCtrls, ComCtrls, JvExComCtrls, JvListView,
  ImgList, Grids, JvExGrids, JvGrids, Wwdbigrd, Wwdbgrid, JvDataSource, DBGrids,
  JvExDBGrids, JvDBGrid, JvDBUltimGrid;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ilGFX16: TImageList;
    JvListView1: TJvListView;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure JvListView1DrawItem(Sender: TCustomListView; Item: TListItem;
      Rect: TRect; State: TOwnerDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin

JvListView1.SaveToCSV('c:\teste\teste.csv');
//JvListView1.SaveToFile('c:\teste\teste.ini');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin

JvListView1.LoadFromCSV('c:\teste\teste.csv');
//JvListView1.LoadFromFile('c:\teste\teste.ini');
end;

procedure TForm1.Button3Click(Sender: TObject);
var
item: TListItem;
begin





item := JvListView1.Items.Add();

Item.ImageIndex := 145;
item.SubItems.Add('1. sub 1');
item.SubItems.Add('2. sub 2');
item.SubItems.Add('3. sub 3');
item.SubItems.Add('4. sub 4');
item.SubItems.Add('5. sub 5');
item.SubItems.Add('6. sub 6');
item.SubItems.Add('7. sub 7');




end;

procedure TForm1.JvListView1DrawItem(Sender: TCustomListView; Item: TListItem;
  Rect: TRect; State: TOwnerDrawState);
begin
 if Odd(Item.Index) then
    // odd list items have green background
    JvListView1.Canvas.Brush.Color := clYellow
  else
    // even list items have window colour background
    JvListView1.Canvas.Brush.Color := clWindow;
end;

end.

unit Ulistview;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, JvExComCtrls, JvListView, ImgList, StdCtrls, IdMessage,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdMessageClient, IdPOP3;

type
  TForm1 = class(TForm)
    JvListView1: TJvListView;
    Button1: TButton;
    ilGFX16: TImageList;
    Button2: TButton;
    IdPOP31: TIdPOP3;
    MSG: TIdMessage;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
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
var
li: TJvListItem;

begin

JvListView1.Columns.Add.Caption := 'Teste3';

li := TJvListItem(JvListView1.Items.Add);
li.GroupId := 1;
li.ImageIndex := 1;
li.SubItems.Add('Teste10');
li.SubItems.Add('Teste11');
li.SubItems.Add('Teste12');
li.SubItems.Add('Teste13');


li := TJvListItem(JvListView1.Items.Add);
li.GroupId := 1;
li.ImageIndex := 2;
//li.Caption := 'Gr2';
li.SubItems.Add('Teste1');


li := TJvListItem(JvListView1.Items.Add);
li.GroupId := 1;
//li.Caption := 'Gr3';
li.SubItems.Add('Teste3');


li := TJvListItem(JvListView1.Items.Add);
li.GroupId := 1;
//li.Caption := 'Gr4';
li.SubItems.Add('Teste4');

JvListView1.ShowColumnHeaders := true;



end;

procedure TForm1.Button2Click(Sender: TObject);
var
TOT, I, tama : integer;

li: TJvListItem;
begin


try
idpop31.Connect;

except
showmessage('Pau');
exit;

end;



TOT := idpop31.CheckMessages;

for I:=1 to   tot do
  begin

  application.ProcessMessages;
  form1.Repaint;

  idpop31.RetrieveHeader(I,MSG);
  tama := idPop31.RetrieveMsgSize(I);

  li := TJvListItem(JvListView1.Items.Add);
  li.GroupId := 1;
  li.ImageIndex := 1;
  li.SubItems.Add(MSG.From.Address);
  li.SubItems.Add(MSG.Subject);
  li.SubItems.Add(datetostr(MSG.Date));
  li.SubItems.Add(inttostr(tama));





  end;


idpop31.Disconnect;

//showmessage(JvListView1.Items[4].SubItems;

end;

end.

unit Utestafuncao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, xmldom, XMLIntf, StdCtrls, msxmldom, XMLDoc, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, funcoes;

type
  TForm1 = class(TForm)
    IdHTTP1: TIdHTTP;
    XMLDocument1: TXMLDocument;
    Memo1: TMemo;
    Button1: TButton;
    Edit1: TEdit;
    Button2: TButton;
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
nd, pega : IXMLNode;
I : integer;
begin
Memo1.Lines.Text :=idHTTP1.Get('http://api.hostip.info/?ip=77.238.132.3');
Memo1.Lines.SaveToFile('c:\teste.xml');


XMLDocument1.Active := true;
nd := XMLDocument1.DocumentElement.ChildNodes.First;



if not (nd.NodeType = ntElement) then
    Exit;


for I := 0 to nd.AttributeNodes.Count - 1 do
  begin
    pega := nd.AttributeNodes.Nodes[I];
    memo1.lines.add('[' + pega.NodeName + ' = "' + Pega.Text + '"]');
  end;






//Hostip

end;

procedure TForm1.Button2Click(Sender: TObject);
begin


edit1.Text := PegaItensCabec(''From:',memo1.Lines.Text);

end;

end.

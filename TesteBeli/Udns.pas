unit Udns;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection,
  IdDNSResolver, IdTCPClient, IdWhois, JvComponentBase, JvCreateProcess;

type
  TForm1 = class(TForm)
    IdDNSResolver1: TIdDNSResolver;
    Button1: TButton;
    Memo1: TMemo;
    IdWhois1: TIdWhois;
    Memo2: TMemo;
    JvCreateProcess1: TJvCreateProcess;
    procedure Button1Click(Sender: TObject);
    procedure JvCreateProcess1Read(Sender: TObject; const S: string;
      const StartsOnNewLine: Boolean);
    procedure JvCreateProcess1RawRead(Sender: TObject; const S: string);
    procedure JvCreateProcess1ErrorRead(Sender: TObject; const S: string;
      const StartsOnNewLine: Boolean);
    procedure JvCreateProcess1ErrorRawRead(Sender: TObject; const S: string);
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
Teste : integer;
acha  : TresultRecord;
respo : TstringList;

begin


{
Respo := TstringList.Create;
try

JvCreateProcess1.CommandLine := 'nslookup 232.11.51.94.bl.spamcop.net';
JvCreateProcess1.Run;
respo.text        := JvCreateProcess1.ConsoleOutput.text;
memo1.Lines.Text := respo.Text;

finally
JvCreateProcess1.Free;
respo.Free;
end;

exit;

//202.102.14.141
// 203.156.77.91.in-addr.arpa


//94.51.11.232


//IdDNSResolver1.Disconnect;
 }

try

//IdDNSResolver1.Resolve('94.51.11.232');
//IdDNSResolver1.QueryType:=[qtA];
//IdDNSResolver1.Resolve('abreuretto.com');

IdDNSResolver1.Resolve('232.11.51.94.zen.spamhaus.net');


except
on E: Exception do
      Memo1.Lines.Add(E.Message);
end;

teste := IdDNSResolver1.QueryResult.count;

  if teste > 0 then
  begin
      acha := IdDNSResolver1.QueryResult.Items[0];
      acha.Collection.Items[0].ClassName;


  memo1.lines.add(inttostr(teste));



  //IdWhois1.Connect;
  memo2.Lines.Text := IdWhois1.WhoIs('69.64.64.125');
  IdWhois1.Disconnect;
  end;
end;

procedure TForm1.JvCreateProcess1ErrorRawRead(Sender: TObject; const S: string);
begin
memo1.Lines.Add(s);
end;

procedure TForm1.JvCreateProcess1ErrorRead(Sender: TObject; const S: string;
  const StartsOnNewLine: Boolean);
begin
memo1.Lines.Add(s);
end;

procedure TForm1.JvCreateProcess1RawRead(Sender: TObject; const S: string);
begin
memo1.Lines.Add(s);
end;

procedure TForm1.JvCreateProcess1Read(Sender: TObject; const S: string;
  const StartsOnNewLine: Boolean);
begin

memo1.Lines.Add(s);

end;

end.

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IDpop3;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Lista : TList;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  lista := Tlist.create;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  lista.free;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  ListaSTR:TStringlist;
  I:Integer;
begin
  for i:=0 to 250 do
  begin
    ListaSTR := TStringlist.create();
    lista.Add(pop);
  end;
  label1.caption := 'Total: '+inttostr(Lista.count);
end;

procedure TForm1.Button2Click(Sender: TObject);
var i:integer;
begin
  for i := 0 to Lista.count-1 do
  begin
    TStringlist(lista[i]).free;

  end;
  lista.clear;
  label1.caption := 'Total: '+inttostr(Lista.count);
end;

end.

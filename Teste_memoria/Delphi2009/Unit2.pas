unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, generics.collections, StdCtrls, IDpop3;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Lista : TList;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
var
  ListaStr: TStringList;
  I  : Integer;
begin
for I := 0 to 250 do
  begin
  ListaStr := TStringList.create;
  lista.Add(ListaStr);
  end;
  label1.caption := 'Total: '+inttostr(lista.Count);
end;

procedure TForm2.Button2Click(Sender: TObject);
var
  I: Integer;
begin


  for I := 0 to Lista.Count - 1 do
  begin
    TStringList(Lista[i]).free;
    lista[i] := nil;

  end;
  lista.Clear;


  // FreeandNil(lista);
  label1.caption := 'Total: '+inttostr(lista.Count);
end;

procedure TForm2.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  FreeandNil(lista);
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  lista := TList.create;
end;

end.
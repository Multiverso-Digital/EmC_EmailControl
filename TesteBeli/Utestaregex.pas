unit Utestaregex;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PerlRegEx, StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit4: TEdit;
    Label5: TLabel;
    Edit5: TEdit;
    Texto: TPerlRegEx;
    procedure Button1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private

  Procedure Cria;
  Procedure Destroi;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  //Texto : TPerlRegEx;
implementation

{$R *.dfm}


Procedure TForm1.Cria;
begin
Texto := TPerlRegEx.Create(self);
end;

Procedure TForm1.Destroi;
begin

try
Texto.DestroyComponents;
//Texto.Destroy;
except
end;

end;



procedure TForm1.Button1Click(Sender: TObject);

begin


//.*@abreu.+retto.com$

//Cria;


Texto.Subject := trim(edit1.Text);
Texto.RegEx   := trim(edit2.Text);


try
If Texto.Match then
   begin
   Edit3.text := Texto.MatchedExpression;
   Edit4.Text := Texto.SubjectLeft;
   Edit5.Text := Texto.SubjectRight;
   end
   else
   begin
   Edit3.text := 'Erro';
   Edit4.Text := 'Erro';
   Edit5.Text := 'Erro';
   end;

except


end;


//Destroi;


end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
//destroi;
end;

end.

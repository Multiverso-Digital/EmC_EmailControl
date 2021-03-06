unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, JvExComCtrls, JvProgressBar, DB, MemDS, DBAccess,
  MyAccess, Inifiles;

type
  TForm2 = class(TForm)
    MyConnection1: TMyConnection;
    MyTable1: TMyTable;
    JvProgressBar1: TJvProgressBar;
    Button1: TButton;
    MyTable1ID: TIntegerField;
    MyTable1palavra: TStringField;
    MyTable1qtd_spam: TIntegerField;
    MyTable1qtd_ok: TIntegerField;
    MyTable1DT: TDateTimeField;
    procedure Button1Click(Sender: TObject);
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
var
palavra,compl:THashedStringList;
work:String;
begin
  palavra:=THashedStringList.create;
  compl:=THashedStringList.create;
  if MyTable1.active then MyTable1.close;
  MyTable1.open;
  JvProgressBar1.Max:=MyTable1.RecordCount;
  while not MyTable1.eof do
  begin
    Application.ProcessMessages;
    JvProgressBar1.Position:=MyTable1.RecNo;
    palavra.Add(MyTable1palavra.AsString);
    work:=inttostr(MyTable1qtd_spam.AsInteger)+';';
    work:=work+inttostr(MyTable1qtd_ok.AsInteger)+';';
    work:=work+DateTimeToStr(MyTable1DT.AsDateTime)+'';
    compl.Add(work);
    MyTable1.Next;
  end;
  palavra.SaveToFile('K:\@Projetos_em_andamento\EmC2011_Thread\Dados\palavras.dat');
  compl.SaveToFile('K:\@Projetos_em_andamento\EmC2011_Thread\Dados\palavrasComple.dat');
  palavra.Free;
  compl.Free;
  showmessage('Terminou');

end;

end.

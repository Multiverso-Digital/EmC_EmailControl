program TestaFuncao;

uses
  Forms,
  Utestafuncao in 'TesteBeli\Utestafuncao.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

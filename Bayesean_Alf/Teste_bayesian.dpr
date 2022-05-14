program Teste_bayesian;

uses
  Forms,
  Uteste in 'Uteste.pas' {Fteste},
  Ubayesian in 'Ubayesian.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFteste, Fteste);
  Application.Run;
end.

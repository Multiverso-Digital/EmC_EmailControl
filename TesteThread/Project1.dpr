program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Udm in 'Udm.pas' {DM: TDataModule},
  UPOP in 'UPOP.pas',
  UTPop in 'UTPop.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

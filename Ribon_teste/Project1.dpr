program Project1;

uses
  Forms,
  Umain in 'Umain.pas' {Fmain},
  Uproj in 'Uproj.pas' {Fproj},
  Udm in 'Udm.pas' {DM: TDataModule},
  Ucliente in 'Ucliente.pas' {FCliente};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFmain, Fmain);
  Application.Run;
end.

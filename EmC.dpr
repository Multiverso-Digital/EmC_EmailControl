program EmC;

uses
  Forms,
  Umain in 'Umain.pas' {Fmain},
  UDMSERVER in 'UDMSERVER.pas' {DM_SERVER: TDataModule},
  UContas in 'UContas.pas' {FContas},
  Umens in 'Umens.pas' {Fmens},
  UImportAccounts in 'UImportAccounts.pas' {FImportAccounts},
  UExportAccounts in 'UExportAccounts.pas' {FExportAccounts},
  UFavoritos in 'UFavoritos.pas' {FFavoritos},
  UShowFilterFriends in 'UShowFilterFriends.pas' {FShowFilterFriends},
  UShowWhyFilter in 'UShowWhyFilter.pas' {FShowWhyFilter},
  UTestaExpression in 'UTestaExpression.pas' {FTestaExpression},
  UBody in 'UBody.pas' {FBody},
  USetUp in 'USetUp.pas' {FSetUp},
  Ucontas_new in 'Ucontas_new.pas' {FContas_New},
  Utypeacct in 'Utypeacct.pas' {FTypeAcct},
  UConectaPop in 'UConectaPop.pas',
  UconectaImap in 'UconectaImap.pas',
  UDM_FavoNegra in 'UDM_FavoNegra.pas' {DM_FavoNegra: TDataModule},
  UDM_pais in 'UDM_pais.pas' {DM_pais: TDataModule},
  UDM_DNS in 'UDM_DNS.pas' {DM_DNS: TDataModule},
  UDM_Avancado in 'UDM_Avancado.pas' {DM_Avancado: TDataModule},
  UDM_Baysean in 'UDM_Baysean.pas' {DM_Baysean: TDataModule},
  UcriaObjetos in 'UcriaObjetos.pas',
  Ubayesian in 'Ubayesian.pas',
  RecError in 'RecError.pas' {ReconcileErrorForm},
  UComu in 'UComu.pas' {FComu},
  Uabout in 'Uabout.pas' {Fabout},
  UBackup in 'UBackup.pas' {Fbackup},
  MsgHdrCoders in 'MsgHdrCoders.pas',
  MultipleInstancePrevention in 'MultipleInstancePrevention.pas',
  Uespera in 'Uespera.pas' {Fespera};

{$R *.res}

  Const
  MyUniqueID : String = 'EmC-Email Control';


begin

  IF (MultipleInstance.IsAllreadyStarted(MyUniqueID)) Then
   Begin
      IF (MultipleInstance.ShowApplication(MyUniqueID)) Then Exit;
   End;
   MultipleInstance.SetAppHandle(MyUniqueID, Application.Handle);



  Application.Initialize;
 // Application.ShowMainForm := false;
  Application.MainFormOnTaskbar := True;

  Application.Title := 'EmC-Email Control';
  Application.CreateForm(TDM_SERVER, DM_SERVER);
  Application.CreateForm(TFmain, Fmain);
  Application.CreateForm(TDM_FavoNegra, DM_FavoNegra);
  Application.CreateForm(TDM_DNS, DM_DNS);
  Application.CreateForm(TDM_Avancado, DM_Avancado);
  Application.CreateForm(TDM_Baysean, DM_Baysean);
  Application.CreateForm(TDM_pais, DM_pais);
  Application.CreateForm(TFespera, Fespera);
  Application.Run;
end.

unit Urefiltrar;

interface
Procedure Refiltrar();

implementation

Uses Umain, UDMServer,Umens, UCriaObjetos,UDM_DNS, UDM_Avancado, UDM_Baysean, UDM_pais,
      UDM_FavoNegra,Forms ;



procedure Refiltrar();
var
  MSGwork:TMSG;
begin
  with dm_server do
  begin

  Fmain.PiscaLeds;
  Fmain.PoeStatusBar('Wait.Running Filters...','','','');
  Fmain.ListBox1.items.add('Wait.Running Filters...');
  Fmain.listbox1.itemindex := Fmain.listbox1.items.count -1;
  Fmain.EstadoDosBotoesMensagens(False,True,False);
  Fmain.RibbonGroup2.Enabled    := false;
  Fmain.RibbonGroup3.Enabled    := false;
  Fmain.RibbonGroup7.Enabled    := false;




 //   cds_mens.IndexFieldNames := 'ID';
    cds_mens.Filtered := false;
    cds_mens.First;
    cds_mens.DisableControls;
    Fmens.JvSpecialProgress1.Maximum := cds_mens.RecordCount;
    while not cds_mens.Eof do
    begin
      Application.ProcessMessages;

      if fmain.parar then
      begin
      break;
      end;

      Fmens.JvSpecialProgress1.Position := cds_mens.RecNo;
      MSGwork := TMSG.create;
      MSGwork.Headers.Text := cds_mensCabec.AsString;
      MSGwork.ProcessHeaders;
      MSGwork.Tag := 0;
      MSGwork.IDConta   :=  cds_mensID_Conta.AsInteger;
      MSGwork.NomeConta := cds_mensConta.asString;
      MSGwork.Tamanho   := cds_mensTama.AsInteger;
      MSGwork.UIDOK     := cds_mensUID.AsString;
      MSGwork.UIDNum    := cds_mensNumeroMens.AsInteger;
      MSGwork.Getvariaveis;
      MSGwork.getFrases;
      MSGwork.CamposObrigatorios;


      if dm_server.Countries > 0 then
      begin
      MSGwork :=  DM_Pais.Filtrar_pais(MSGwork);
      end;

      MSGwork :=  DM_FavoNegra.filtrar_favoritos_listaNegra(MSGwork);


      if (MSGwork.Favorita = 0) and (MSGwork.ListaNegra = 0)  then
      MSGwork :=  dm_Avancado.Filtrar_Favoritos_Nao_Grupados(MSGwork);

      if (MSGwork.Favorita = 0) and (MSGwork.ListaNegra = 0)  then
      MSGwork :=  dm_Avancado.Filtrar_Favoritos_Grupados(MSGwork);


      if not ((MSGwork.Favorita = 1) or (MSGwork.Filtrada > 0) or(MSGwork.ListaNegra = 1)) then
      begin
        if dm_server.DNS > 0 then
        begin
          if (MSGwork.Favorita = 0) and (MSGwork.ListaNegra = 0) and (MSGwork.Filtrada <= 0) then
          MSGwork := DM_DNS.Filtrar_DNS(MSGwork);
        end;




        if dm_server.filter > 0  then
        begin

          if (MSGwork.Favorita = 0) and (MSGwork.ListaNegra = 0) and (MSGwork.Filtrada <= 0) then
          MSGwork := dm_Avancado.Filtrar_ListaNegra_NaoGrupados(MSGwork);

          if (MSGwork.Favorita = 0) and (MSGwork.ListaNegra = 0) and (MSGwork.Filtrada <= 0) then
          MSGwork := dm_Avancado.Filtrar_ListaNegra_Grupados(MSGwork);

        end;

        if (MSGwork.Favorita = 0) and (MSGwork.ListaNegra = 0) and (MSGwork.Filtrada <= 0) then
        MSGwork := DM_Baysean.Filtrar_Bayesian(MSGwork);
      end;

      cds_mens.edit;
      cds_mensselecionada.AsInteger  := MSGwork.Selecionada;
      cds_mensExcluida.AsInteger     := MSGwork.Excluida;
      cds_mensFiltrada.AsInteger     := MSGwork.Filtrada;
      cds_mensListaNegra.AsInteger   := MSGwork.ListaNegra;
      cds_mensFavoritos.AsInteger    := MSGwork.Favorita;


      Cds_MensCountry.asstring            :=  MSGwork.pais;


      Cds_MensFiltroResult.AsString := MSGwork.FiltroResultado.Text;
      cds_menspalavrasBaysean.AsString := MSGwork.FrasesBaesyan.Text;
      cds_mens.post;

      cds_mens.Next;
    end;
    Fmens.JvSpecialProgress1.Position := 0;
    cds_mens.First;
    cds_mens.EnableControls;

      Fmain.Paraleds;
      Fmain.PoeStatusBar('Run Filter Done.','','','');
      Fmain.ListBox1.items.add('Run Filter Done.');
      Fmain.listbox1.itemindex := Fmain.listbox1.items.count -1;
      Fmain.EstadoDosBotoesMensagens(true,True,true);
      Fmain.RibbonGroup2.Enabled    := true;
      Fmain.RibbonGroup3.Enabled    := true;
      Fmain.RibbonGroup7.Enabled    := true;






  end;
end;


end.








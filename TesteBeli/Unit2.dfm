object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 455
  ClientWidth = 584
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object wwDBGrid1: TwwDBGrid
    Left = 8
    Top = 8
    Width = 521
    Height = 289
    ControlType.Strings = (
      'rota_concluida;CheckBox;True;False'
      'dtatu;CustomEdit;wwDBDateTimePicker1;T')
    Selected.Strings = (
      'Ficha'#9'8'#9'Ficha'
      'Digito'#9'4'#9'Digito'
      'Tels'#9'10'#9'Tels'
      'Oquefalamos'#9'10'#9'Oquefalamos'
      'dtatu'#9'34'#9'dtatu'
      'quem'#9'20'#9'quem'
      'Encerrou1'#9'10'#9'Encerrou1'
      'Encerrou2'#9'10'#9'Encerrou2'
      'Encerrou3'#9'10'#9'Encerrou3'
      'Encerrou4'#9'10'#9'Encerrou4'
      'Encerramento1'#9'12'#9'Encerramento1'
      'Encerramento2'#9'12'#9'Encerramento2'
      'Encerramento3'#9'12'#9'Encerramento3'
      'Encerramento4'#9'12'#9'Encerramento4'
      'tipo1'#9'10'#9'tipo1'
      'tipo2'#9'10'#9'tipo2'
      'tipo3'#9'10'#9'tipo3'
      'tipo4'#9'10'#9'tipo4'
      'faleicom1'#9'50'#9'faleicom1'
      'faleicom2'#9'50'#9'faleicom2'
      'faleicom3'#9'50'#9'faleicom3'
      'faleicom4'#9'50'#9'faleicom4'
      'ligardia1'#9'10'#9'ligardia1'
      'ligardia2'#9'10'#9'ligardia2'
      'ligardia3'#9'10'#9'ligardia3'
      'ligardia4'#9'10'#9'ligardia4'
      'prof_infosemi'#9'10'#9'prof_infosemi'
      'prof_dadosconfirmados'#9'18'#9'prof_dadosconfirmados'
      'prof_presencaconfirmada'#9'20'#9'prof_presencaconfirmada'
      'prof_mandaroficiofaltas'#9'19'#9'prof_mandaroficiofaltas'
      'aluno_dadosconfirmados'#9'19'#9'aluno_dadosconfirmados'
      'aluno_presencaconfirmada'#9'21'#9'aluno_presencaconfirmada'
      'aluno_mandaroficio'#9'15'#9'aluno_mandaroficio'
      'aluno_mandarautorizacao'#9'20'#9'aluno_mandarautorizacao'
      'ligar_pais'#9'10'#9'ligar_pais'
      'ligar_diretor'#9'10'#9'ligar_diretor'
      'informou_itinerario'#9'15'#9'informou_itinerario'
      'enviou_emailitinerario'#9'17'#9'enviou_emailitinerario'
      'informei_valordeposito'#9'18'#9'informei_valordeposito'
      'recebeu_envelope'#9'14'#9'recebeu_envelope'
      'retirou_deposito'#9'13'#9'retirou_deposito'
      'recebeu_roteiro'#9'12'#9'recebeu_roteiro'
      'comprou_passagens'#9'16'#9'comprou_passagens'
      'aluno_problema'#9'12'#9'aluno_problema'
      'problema_descricao'#9'15'#9'problema_descricao'
      'prof_problema'#9'11'#9'prof_problema'
      'problema_itinerario'#9'15'#9'problema_itinerario'
      'problema_desc_itinerario'#9'20'#9'problema_desc_itinerario'
      'problema_documentos'#9'18'#9'problema_documentos'
      'problema_desc_docs'#9'16'#9'problema_desc_docs'
      'KM_taxi'#9'10'#9'KM_taxi'
      'valor_taxi'#9'10'#9'valor_taxi'
      'valor_aviao'#9'10'#9'valor_aviao'
      'Valor_onibus'#9'10'#9'Valor_onibus'
      'valor_outros'#9'10'#9'valor_outros'
      'ajuda_custo'#9'10'#9'ajuda_custo'
      'duracao_total'#9'11'#9'duracao_total'
      'Km_total'#9'10'#9'Km_total'
      'Total_deposito'#9'11'#9'Total_deposito'
      'problemas_ultimo'#9'13'#9'problemas_ultimo'
      'problema_desc_ultimo'#9'17'#9'problema_desc_ultimo'
      'valor_extra'#9'10'#9'valor_extra'
      'Nome_representante'#9'60'#9'Nome_representante'
      'RG_representante'#9'20'#9'RG_representante'
      'CPF_representante'#9'15'#9'CPF_representante'
      'Bilhetes_OBS'#9'10'#9'Bilhetes_OBS'
      'oficio_recebido'#9'12'#9'oficio_recebido'
      'Prof_falacom_pais'#9'14'#9'Prof_falacom_pais'
      'Prof_falacom_diretor'#9'16'#9'Prof_falacom_diretor'
      'Atende_falacom_pais'#9'17'#9'Atende_falacom_pais'
      'Atende_falacom_diretor'#9'19'#9'Atende_falacom_diretor'
      'enviar_envelope'#9'13'#9'enviar_envelope'
      'enviou_envelope_em'#9'17'#9'enviou_envelope_em'
      'enviou_envelope'#9'13'#9'enviou_envelope'
      'enviou_deposito_em'#9'16'#9'enviou_deposito_em'
      'enviou_deposito'#9'13'#9'enviou_deposito'
      'bilhete_aereo_em'#9'14'#9'bilhete_aereo_em'
      'bilhete_aereo'#9'11'#9'bilhete_aereo'
      'prof_e_ticket'#9'255'#9'prof_e_ticket'
      'aluno_e_ticket'#9'255'#9'aluno_e_ticket'
      'representante_confirmado'#9'21'#9'representante_confirmado'
      'rota_concluida'#9'11'#9'rota_concluida'
      'selecionou'#9'8'#9'selecionou')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = DataSource1
    Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    TabOrder = 0
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
  end
  object wwCheckBox1: TwwCheckBox
    Left = 59
    Top = 383
    Width = 97
    Height = 17
    DisableThemes = False
    AlwaysTransparent = False
    ValueChecked = 'True'
    ValueUnchecked = 'False'
    DisplayValueChecked = 'True'
    DisplayValueUnchecked = 'False'
    NullAndBlankState = cbUnchecked
    Caption = 'wwCheckBox1'
    TabOrder = 1
  end
  object wwDBNavigator1: TwwDBNavigator
    Left = 128
    Top = 408
    Width = 350
    Height = 25
    DataSource = DataSource1
    RepeatInterval.InitialDelay = 500
    RepeatInterval.Interval = 100
    Visible = False
    object wwDBNavigator1First: TwwNavButton
      Left = 0
      Top = 0
      Width = 25
      Height = 25
      Hint = 'Move to first record'
      ImageIndex = -1
      NumGlyphs = 2
      Spacing = 4
      Transparent = False
      Caption = 'wwDBNavigator1First'
      Enabled = False
      DisabledTextColors.ShadeColor = clGray
      DisabledTextColors.HighlightColor = clBtnHighlight
      Index = 0
      Style = nbsFirst
    end
    object wwDBNavigator1PriorPage: TwwNavButton
      Left = 25
      Top = 0
      Width = 25
      Height = 25
      Hint = 'Move backward 10 records'
      ImageIndex = -1
      NumGlyphs = 2
      Spacing = 4
      Transparent = False
      Caption = 'wwDBNavigator1PriorPage'
      Enabled = False
      DisabledTextColors.ShadeColor = clGray
      DisabledTextColors.HighlightColor = clBtnHighlight
      Index = 1
      Style = nbsPriorPage
    end
    object wwDBNavigator1Prior: TwwNavButton
      Left = 50
      Top = 0
      Width = 25
      Height = 25
      Hint = 'Move to prior record'
      ImageIndex = -1
      NumGlyphs = 2
      Spacing = 4
      Transparent = False
      Caption = 'wwDBNavigator1Prior'
      Enabled = False
      DisabledTextColors.ShadeColor = clGray
      DisabledTextColors.HighlightColor = clBtnHighlight
      Index = 2
      Style = nbsPrior
    end
    object wwDBNavigator1Next: TwwNavButton
      Left = 75
      Top = 0
      Width = 25
      Height = 25
      Hint = 'Move to next record'
      ImageIndex = -1
      NumGlyphs = 2
      Spacing = 4
      Transparent = False
      Caption = 'wwDBNavigator1Next'
      DisabledTextColors.ShadeColor = clGray
      DisabledTextColors.HighlightColor = clBtnHighlight
      Index = 3
      Style = nbsNext
    end
    object wwDBNavigator1NextPage: TwwNavButton
      Left = 100
      Top = 0
      Width = 25
      Height = 25
      Hint = 'Move forward 10 records'
      ImageIndex = -1
      NumGlyphs = 2
      Spacing = 4
      Transparent = False
      Caption = 'wwDBNavigator1NextPage'
      DisabledTextColors.ShadeColor = clGray
      DisabledTextColors.HighlightColor = clBtnHighlight
      Index = 4
      Style = nbsNextPage
    end
    object wwDBNavigator1Last: TwwNavButton
      Left = 125
      Top = 0
      Width = 25
      Height = 25
      Hint = 'Move to last record'
      ImageIndex = -1
      NumGlyphs = 2
      Spacing = 4
      Transparent = False
      Caption = 'wwDBNavigator1Last'
      DisabledTextColors.ShadeColor = clGray
      DisabledTextColors.HighlightColor = clBtnHighlight
      Index = 5
      Style = nbsLast
    end
    object wwDBNavigator1Insert: TwwNavButton
      Left = 150
      Top = 0
      Width = 25
      Height = 25
      Hint = 'Insert new record'
      ImageIndex = -1
      NumGlyphs = 2
      Spacing = 4
      Transparent = False
      Caption = 'wwDBNavigator1Insert'
      Enabled = False
      DisabledTextColors.ShadeColor = clGray
      DisabledTextColors.HighlightColor = clBtnHighlight
      Index = 6
      Style = nbsInsert
    end
    object wwDBNavigator1Delete: TwwNavButton
      Left = 175
      Top = 0
      Width = 25
      Height = 25
      Hint = 'Delete current record'
      ImageIndex = -1
      NumGlyphs = 2
      Spacing = 4
      Transparent = False
      Caption = 'wwDBNavigator1Delete'
      Enabled = False
      DisabledTextColors.ShadeColor = clGray
      DisabledTextColors.HighlightColor = clBtnHighlight
      Index = 7
      Style = nbsDelete
    end
    object wwDBNavigator1Edit: TwwNavButton
      Left = 200
      Top = 0
      Width = 25
      Height = 25
      Hint = 'Edit current record'
      ImageIndex = -1
      NumGlyphs = 2
      Spacing = 4
      Transparent = False
      Caption = 'wwDBNavigator1Edit'
      Enabled = False
      DisabledTextColors.ShadeColor = clGray
      DisabledTextColors.HighlightColor = clBtnHighlight
      Index = 8
      Style = nbsEdit
    end
    object wwDBNavigator1Post: TwwNavButton
      Left = 225
      Top = 0
      Width = 25
      Height = 25
      Hint = 'Post changes of current record'
      ImageIndex = -1
      NumGlyphs = 2
      Spacing = 4
      Transparent = False
      Caption = 'wwDBNavigator1Post'
      Enabled = False
      DisabledTextColors.ShadeColor = clGray
      DisabledTextColors.HighlightColor = clBtnHighlight
      Index = 9
      Style = nbsPost
    end
    object wwDBNavigator1Cancel: TwwNavButton
      Left = 250
      Top = 0
      Width = 25
      Height = 25
      Hint = 'Cancel changes made to current record'
      ImageIndex = -1
      NumGlyphs = 2
      Spacing = 4
      Transparent = False
      Caption = 'wwDBNavigator1Cancel'
      Enabled = False
      DisabledTextColors.ShadeColor = clGray
      DisabledTextColors.HighlightColor = clBtnHighlight
      Index = 10
      Style = nbsCancel
    end
    object wwDBNavigator1Refresh: TwwNavButton
      Left = 275
      Top = 0
      Width = 25
      Height = 25
      Hint = 'Refresh the contents of the dataset'
      ImageIndex = -1
      NumGlyphs = 2
      Spacing = 4
      Transparent = False
      Caption = 'wwDBNavigator1Refresh'
      Enabled = False
      DisabledTextColors.ShadeColor = clGray
      DisabledTextColors.HighlightColor = clBtnHighlight
      Index = 11
      Style = nbsRefresh
    end
    object wwDBNavigator1SaveBookmark: TwwNavButton
      Left = 300
      Top = 0
      Width = 25
      Height = 25
      Hint = 'Bookmark current record'
      ImageIndex = -1
      NumGlyphs = 2
      Spacing = 4
      Transparent = False
      Caption = 'wwDBNavigator1SaveBookmark'
      DisabledTextColors.ShadeColor = clGray
      DisabledTextColors.HighlightColor = clBtnHighlight
      Index = 12
      Style = nbsSaveBookmark
    end
    object wwDBNavigator1RestoreBookmark: TwwNavButton
      Left = 325
      Top = 0
      Width = 25
      Height = 25
      Hint = 'Go back to saved bookmark'
      ImageIndex = -1
      NumGlyphs = 2
      Spacing = 4
      Transparent = False
      Caption = 'wwDBNavigator1RestoreBookmark'
      Enabled = False
      DisabledTextColors.ShadeColor = clGray
      DisabledTextColors.HighlightColor = clBtnHighlight
      Index = 13
      Style = nbsRestoreBookmark
    end
  end
  object wwDBDateTimePicker1: TwwDBDateTimePicker
    Left = 82
    Top = 303
    Width = 208
    Height = 16
    AutoFillDateAndTime = True
    CalendarAttributes.Font.Charset = DEFAULT_CHARSET
    CalendarAttributes.Font.Color = clWindowText
    CalendarAttributes.Font.Height = -11
    CalendarAttributes.Font.Name = 'Tahoma'
    CalendarAttributes.Font.Style = []
    DataSource = DataSource1
    Epoch = 1950
    ShowButton = True
    TabOrder = 3
    UnboundDataType = wwDTEdtDate
  end
  object MYSQLCONNECTION: TSQLConnection
    ConnectionName = 'MYSQLCONNECTION'
    DriverName = 'MySQL'
    GetDriverFunc = 'getSQLDriverMYSQL'
    LibraryName = 'dbxmys.dll'
    LoginPrompt = False
    Params.Strings = (
      ';DelegateConnection=DBXTraceConnection'
      'drivername=MySQL'
      'HostName=192.168.0.1'
      'Database=escrevendofuturo'
      'User_Name=melhorias'
      'Password=aw3248'
      'blobsize=-1'
      'localecode=0000'
      'compressed=False'
      'encrypted=False')
    VendorLib = 'LIBMYSQL.dll'
    Connected = True
    Left = 58
    Top = 178
  end
  object alunos_ef_ligacoes: TSQLDataSet
    SchemaName = 'melhorias'
    Active = True
    CommandText = 'select *  from `alunos_ef_ligacoes`'
    DbxCommandType = 'Dbx.SQL'
    MaxBlobSize = -1
    Params = <>
    SQLConnection = MYSQLCONNECTION
    Left = 21
    Top = 181
    object alunos_ef_ligacoesFicha: TStringField
      DisplayWidth = 8
      FieldName = 'Ficha'
      Required = True
      Size = 6
    end
    object alunos_ef_ligacoesDigito: TStringField
      DisplayWidth = 4
      FieldName = 'Digito'
      Size = 1
    end
    object alunos_ef_ligacoesTels: TMemoField
      DisplayWidth = 10
      FieldName = 'Tels'
      BlobType = ftMemo
      Size = 1
    end
    object alunos_ef_ligacoesOquefalamos: TMemoField
      DisplayWidth = 10
      FieldName = 'Oquefalamos'
      BlobType = ftMemo
      Size = 1
    end
    object alunos_ef_ligacoesdtatu: TSQLTimeStampField
      DisplayWidth = 34
      FieldName = 'dtatu'
    end
    object alunos_ef_ligacoesquem: TStringField
      DisplayWidth = 20
      FieldName = 'quem'
    end
    object alunos_ef_ligacoesEncerrou1: TIntegerField
      DisplayWidth = 10
      FieldName = 'Encerrou1'
    end
    object alunos_ef_ligacoesEncerrou2: TIntegerField
      DisplayWidth = 10
      FieldName = 'Encerrou2'
    end
    object alunos_ef_ligacoesEncerrou3: TIntegerField
      DisplayWidth = 10
      FieldName = 'Encerrou3'
    end
    object alunos_ef_ligacoesEncerrou4: TIntegerField
      DisplayWidth = 10
      FieldName = 'Encerrou4'
    end
    object alunos_ef_ligacoesEncerramento1: TIntegerField
      DisplayWidth = 12
      FieldName = 'Encerramento1'
    end
    object alunos_ef_ligacoesEncerramento2: TIntegerField
      DisplayWidth = 12
      FieldName = 'Encerramento2'
    end
    object alunos_ef_ligacoesEncerramento3: TIntegerField
      DisplayWidth = 12
      FieldName = 'Encerramento3'
    end
    object alunos_ef_ligacoesEncerramento4: TIntegerField
      DisplayWidth = 12
      FieldName = 'Encerramento4'
    end
    object alunos_ef_ligacoestipo1: TIntegerField
      DisplayWidth = 10
      FieldName = 'tipo1'
    end
    object alunos_ef_ligacoestipo2: TIntegerField
      DisplayWidth = 10
      FieldName = 'tipo2'
    end
    object alunos_ef_ligacoestipo3: TIntegerField
      DisplayWidth = 10
      FieldName = 'tipo3'
    end
    object alunos_ef_ligacoestipo4: TIntegerField
      DisplayWidth = 10
      FieldName = 'tipo4'
    end
    object alunos_ef_ligacoesfaleicom1: TStringField
      DisplayWidth = 50
      FieldName = 'faleicom1'
      Size = 50
    end
    object alunos_ef_ligacoesfaleicom2: TStringField
      DisplayWidth = 50
      FieldName = 'faleicom2'
      Size = 50
    end
    object alunos_ef_ligacoesfaleicom3: TStringField
      DisplayWidth = 50
      FieldName = 'faleicom3'
      Size = 50
    end
    object alunos_ef_ligacoesfaleicom4: TStringField
      DisplayWidth = 50
      FieldName = 'faleicom4'
      Size = 50
    end
    object alunos_ef_ligacoesligardia1: TDateField
      DisplayWidth = 10
      FieldName = 'ligardia1'
    end
    object alunos_ef_ligacoesligardia2: TDateField
      DisplayWidth = 10
      FieldName = 'ligardia2'
    end
    object alunos_ef_ligacoesligardia3: TDateField
      DisplayWidth = 10
      FieldName = 'ligardia3'
    end
    object alunos_ef_ligacoesligardia4: TDateField
      DisplayWidth = 10
      FieldName = 'ligardia4'
    end
    object alunos_ef_ligacoesprof_infosemi: TIntegerField
      DisplayWidth = 10
      FieldName = 'prof_infosemi'
    end
    object alunos_ef_ligacoesprof_dadosconfirmados: TIntegerField
      DisplayWidth = 18
      FieldName = 'prof_dadosconfirmados'
    end
    object alunos_ef_ligacoesprof_presencaconfirmada: TIntegerField
      DisplayWidth = 20
      FieldName = 'prof_presencaconfirmada'
    end
    object alunos_ef_ligacoesprof_mandaroficiofaltas: TIntegerField
      DisplayWidth = 19
      FieldName = 'prof_mandaroficiofaltas'
    end
    object alunos_ef_ligacoesaluno_dadosconfirmados: TIntegerField
      DisplayWidth = 19
      FieldName = 'aluno_dadosconfirmados'
    end
    object alunos_ef_ligacoesaluno_presencaconfirmada: TIntegerField
      DisplayWidth = 21
      FieldName = 'aluno_presencaconfirmada'
    end
    object alunos_ef_ligacoesaluno_mandaroficio: TIntegerField
      DisplayWidth = 15
      FieldName = 'aluno_mandaroficio'
    end
    object alunos_ef_ligacoesaluno_mandarautorizacao: TIntegerField
      DisplayWidth = 20
      FieldName = 'aluno_mandarautorizacao'
    end
    object alunos_ef_ligacoesligar_pais: TIntegerField
      DisplayWidth = 10
      FieldName = 'ligar_pais'
    end
    object alunos_ef_ligacoesligar_diretor: TIntegerField
      DisplayWidth = 10
      FieldName = 'ligar_diretor'
    end
    object alunos_ef_ligacoesinformou_itinerario: TIntegerField
      DisplayWidth = 15
      FieldName = 'informou_itinerario'
    end
    object alunos_ef_ligacoesenviou_emailitinerario: TIntegerField
      DisplayWidth = 17
      FieldName = 'enviou_emailitinerario'
    end
    object alunos_ef_ligacoesinformei_valordeposito: TIntegerField
      DisplayWidth = 18
      FieldName = 'informei_valordeposito'
    end
    object alunos_ef_ligacoesrecebeu_envelope: TIntegerField
      DisplayWidth = 14
      FieldName = 'recebeu_envelope'
    end
    object alunos_ef_ligacoesretirou_deposito: TIntegerField
      DisplayWidth = 13
      FieldName = 'retirou_deposito'
    end
    object alunos_ef_ligacoesrecebeu_roteiro: TIntegerField
      DisplayWidth = 12
      FieldName = 'recebeu_roteiro'
    end
    object alunos_ef_ligacoescomprou_passagens: TIntegerField
      DisplayWidth = 16
      FieldName = 'comprou_passagens'
    end
    object alunos_ef_ligacoesaluno_problema: TIntegerField
      DisplayWidth = 12
      FieldName = 'aluno_problema'
    end
    object alunos_ef_ligacoesproblema_descricao: TMemoField
      DisplayWidth = 15
      FieldName = 'problema_descricao'
      BlobType = ftMemo
      Size = 1
    end
    object alunos_ef_ligacoesprof_problema: TIntegerField
      DisplayWidth = 11
      FieldName = 'prof_problema'
    end
    object alunos_ef_ligacoesproblema_itinerario: TIntegerField
      DisplayWidth = 15
      FieldName = 'problema_itinerario'
    end
    object alunos_ef_ligacoesproblema_desc_itinerario: TMemoField
      DisplayWidth = 20
      FieldName = 'problema_desc_itinerario'
      BlobType = ftMemo
      Size = 1
    end
    object alunos_ef_ligacoesproblema_documentos: TIntegerField
      DisplayWidth = 18
      FieldName = 'problema_documentos'
    end
    object alunos_ef_ligacoesproblema_desc_docs: TMemoField
      DisplayWidth = 16
      FieldName = 'problema_desc_docs'
      BlobType = ftMemo
      Size = 1
    end
    object alunos_ef_ligacoesKM_taxi: TFloatField
      DisplayWidth = 10
      FieldName = 'KM_taxi'
    end
    object alunos_ef_ligacoesvalor_taxi: TFloatField
      DisplayWidth = 10
      FieldName = 'valor_taxi'
    end
    object alunos_ef_ligacoesvalor_aviao: TFloatField
      DisplayWidth = 10
      FieldName = 'valor_aviao'
    end
    object alunos_ef_ligacoesValor_onibus: TFloatField
      DisplayWidth = 10
      FieldName = 'Valor_onibus'
    end
    object alunos_ef_ligacoesvalor_outros: TFloatField
      DisplayWidth = 10
      FieldName = 'valor_outros'
    end
    object alunos_ef_ligacoesajuda_custo: TFloatField
      DisplayWidth = 10
      FieldName = 'ajuda_custo'
    end
    object alunos_ef_ligacoesduracao_total: TFloatField
      DisplayWidth = 11
      FieldName = 'duracao_total'
    end
    object alunos_ef_ligacoesKm_total: TFloatField
      DisplayWidth = 10
      FieldName = 'Km_total'
    end
    object alunos_ef_ligacoesTotal_deposito: TFloatField
      DisplayWidth = 11
      FieldName = 'Total_deposito'
    end
    object alunos_ef_ligacoesproblemas_ultimo: TIntegerField
      DisplayWidth = 13
      FieldName = 'problemas_ultimo'
    end
    object alunos_ef_ligacoesproblema_desc_ultimo: TMemoField
      DisplayWidth = 17
      FieldName = 'problema_desc_ultimo'
      BlobType = ftMemo
      Size = 1
    end
    object alunos_ef_ligacoesvalor_extra: TFloatField
      DisplayWidth = 10
      FieldName = 'valor_extra'
    end
    object alunos_ef_ligacoesNome_representante: TStringField
      DisplayWidth = 60
      FieldName = 'Nome_representante'
      Size = 60
    end
    object alunos_ef_ligacoesRG_representante: TStringField
      DisplayWidth = 20
      FieldName = 'RG_representante'
    end
    object alunos_ef_ligacoesCPF_representante: TStringField
      DisplayWidth = 15
      FieldName = 'CPF_representante'
      Size = 11
    end
    object alunos_ef_ligacoesBilhetes_OBS: TMemoField
      DisplayWidth = 10
      FieldName = 'Bilhetes_OBS'
      BlobType = ftMemo
      Size = 1
    end
    object alunos_ef_ligacoesoficio_recebido: TDateField
      DisplayWidth = 12
      FieldName = 'oficio_recebido'
    end
    object alunos_ef_ligacoesProf_falacom_pais: TMemoField
      DisplayWidth = 14
      FieldName = 'Prof_falacom_pais'
      BlobType = ftMemo
      Size = 1
    end
    object alunos_ef_ligacoesProf_falacom_diretor: TMemoField
      DisplayWidth = 16
      FieldName = 'Prof_falacom_diretor'
      BlobType = ftMemo
      Size = 1
    end
    object alunos_ef_ligacoesAtende_falacom_pais: TMemoField
      DisplayWidth = 17
      FieldName = 'Atende_falacom_pais'
      BlobType = ftMemo
      Size = 1
    end
    object alunos_ef_ligacoesAtende_falacom_diretor: TMemoField
      DisplayWidth = 19
      FieldName = 'Atende_falacom_diretor'
      BlobType = ftMemo
      Size = 1
    end
    object alunos_ef_ligacoesenviar_envelope: TIntegerField
      DisplayWidth = 13
      FieldName = 'enviar_envelope'
    end
    object alunos_ef_ligacoesenviou_envelope_em: TDateField
      DisplayWidth = 17
      FieldName = 'enviou_envelope_em'
    end
    object alunos_ef_ligacoesenviou_envelope: TIntegerField
      DisplayWidth = 13
      FieldName = 'enviou_envelope'
    end
    object alunos_ef_ligacoesenviou_deposito_em: TDateField
      DisplayWidth = 16
      FieldName = 'enviou_deposito_em'
    end
    object alunos_ef_ligacoesenviou_deposito: TIntegerField
      DisplayWidth = 13
      FieldName = 'enviou_deposito'
    end
    object alunos_ef_ligacoesbilhete_aereo_em: TDateField
      DisplayWidth = 14
      FieldName = 'bilhete_aereo_em'
    end
    object alunos_ef_ligacoesbilhete_aereo: TIntegerField
      DisplayWidth = 11
      FieldName = 'bilhete_aereo'
    end
    object alunos_ef_ligacoesprof_e_ticket: TStringField
      DisplayWidth = 255
      FieldName = 'prof_e_ticket'
      Size = 255
    end
    object alunos_ef_ligacoesaluno_e_ticket: TStringField
      DisplayWidth = 255
      FieldName = 'aluno_e_ticket'
      Size = 255
    end
    object alunos_ef_ligacoesrepresentante_confirmado: TIntegerField
      DisplayWidth = 21
      FieldName = 'representante_confirmado'
    end
    object alunos_ef_ligacoesrota_concluida: TIntegerField
      DisplayWidth = 11
      FieldName = 'rota_concluida'
    end
    object alunos_ef_ligacoesselecionou: TBooleanField
      DisplayWidth = 8
      FieldName = 'selecionou'
    end
  end
  object DataSource1: TDataSource
    DataSet = alunos_ef_ligacoes
    Left = 160
    Top = 184
  end
  object wwIntl1: TwwIntl
    Navigator.ConfirmDeleteMessage = 'Delete record?'
    Navigator.Hints.FirstHint = 'Move to first record'
    Navigator.Hints.PriorHint = 'Move to prior record'
    Navigator.Hints.NextHint = 'Move to next record'
    Navigator.Hints.LastHint = 'Move to last record'
    Navigator.Hints.InsertHint = 'Insert new record'
    Navigator.Hints.DeleteHint = 'Delete current record'
    Navigator.Hints.EditHint = 'Edit current record'
    Navigator.Hints.PostHint = 'Post changes of current record'
    Navigator.Hints.CancelHint = 'Cancel changes made to current record'
    Navigator.Hints.RefreshHint = 'Refresh the contents of the dataset'
    Navigator.Hints.PriorPageHint = 'Move backward %d records'
    Navigator.Hints.NextPageHint = 'Move forward %d records'
    Navigator.Hints.SaveBookmarkHint = 'Bookmark current record'
    Navigator.Hints.RestoreBookmarkHint = 'Go back to saved bookmark'
    Navigator.Hints.RecordViewDialogHint = 'View current record'
    Navigator.Hints.LocateDialogHint = 'Locate a specific record'
    Navigator.Hints.FilterDialogHint = 'Filter the dataset'
    Navigator.Hints.SearchDialogHint = 'Search the dataset'
    SearchDialog.SearchCharLabel = '&Search Characters'
    SearchDialog.SearchCharShortLabel = '&Search Char'
    SearchDialog.SearchByLabel = 'Search &By'
    SearchDialog.StatusRecLabel = 'Rec #'
    SearchDialog.StatusOfLabel = 'of'
    SearchDialog.SearchCharHint = 'Enter characters for incremental search'
    SearchDialog.SearchByHint = 'Incremental searching and sorting order'
    LocateDialog.FieldValueLabel = 'Field &Value'
    LocateDialog.SearchTypeLabel = '&Search Type'
    LocateDialog.CaseSensitiveLabel = '&Case-sensitive'
    LocateDialog.MatchExactLabel = '&Exact Match'
    LocateDialog.MatchStartLabel = '&Partial Match at Beginning'
    LocateDialog.MatchAnyLabel = 'Partial Match &Anywhere'
    LocateDialog.FieldsLabel = '&Fields'
    LocateDialog.BtnFirst = 'Fi&rst'
    LocateDialog.BtnNext = '&Next'
    LocateDialog.BtnCancel = 'Cancel'
    LocateDialog.BtnClose = 'Close'
    LocateDialog.FieldValueHint = 'Enter field'#39's search value'
    LocateDialog.CaseSensitiveHint = 'Searching is case-sensitive'
    LocateDialog.MatchExactHint = 'Match occurs only if there is an exact match'
    LocateDialog.MatchStartHint = 'Match occurs if the start of the field'#39's value matches'
    LocateDialog.MatchAnyHint = 'Match occurs if any part of the field matches'
    LocateDialog.BtnFirstHint = 'Find first match'
    LocateDialog.BtnNextHint = 'Find next match from current record'
    LocateDialog.FieldNameHint = 'Select the field to search on'
    MonthCalendar.PopupYearLabel = 'Edit Year'
    MonthCalendar.EnterYearPrompt = 'Enter Valid Year'
    FilterDialog.BtnViewSummary = 'View Su&mmary'
    FilterDialog.BtnViewSummaryHint = 'View summary of current search criteria'
    FilterDialog.BtnNewSearch = '&New Search'
    FilterDialog.BtnNewSearchHint = 'Start a new search'
    FilterDialog.FieldOrderLabel = 'Field Order'
    FilterDialog.FieldOrderHint = 'Sort field list alphabetically or in their natural logical order'
    FilterDialog.AlphabeticLabel = 'Alpha&betic'
    FilterDialog.LogicalLabel = '&Logical'
    FilterDialog.AllFieldsLabel = '&All'
    FilterDialog.SearchedFieldsLabel = '&Searched'
    FilterDialog.StartingRangeLabel = '&Starting Range'
    FilterDialog.EndingRangeLabel = 'En&ding Range'
    FilterDialog.StartingRangeHint = 'Enter starting range for field'
    FilterDialog.EndingRangeHint = 'Enter ending range for field'
    FilterDialog.BtnClearMin = '&Clear'
    FilterDialog.BtnClearMax = 'Cl&ear'
    FilterDialog.BtnClearFilterValue = '&Clear'
    FilterDialog.BtnClearMinHint = 'Clear starting range for field'
    FilterDialog.BtnClearMaxHint = 'Clear ending range for field'
    FilterDialog.BtnClearFilterValueHint = 'Clear the current field'#39's search value'
    FilterDialog.ByValueLabel = 'By &Value'
    FilterDialog.ByRangeLabel = 'By &Range'
    FilterDialog.FieldValueLabel = 'Field &Value'
    FilterDialog.FieldValueHint = 'Enter field'#39's search value'
    FilterDialog.SearchTypeLabel = 'Search Type'
    FilterDialog.SearchTypeHint = 'Specify how the Field Value should be compared'
    FilterDialog.MatchExactLabel = '&Exact Match'
    FilterDialog.MatchStartLabel = '&Partial Match at Beginning'
    FilterDialog.MatchAnyLabel = 'Partial Match Any&where'
    FilterDialog.CaseSensitiveLabel = 'Case Sensi&tive'
    FilterDialog.CaseSensitiveHint = 'Searching is case-sensitive'
    FilterDialog.NonMatchingLabel = 'N&on-matching records'
    FilterDialog.NonMatchingHint = 'Show records that do not match the field value criteria'
    FilterDialog.SummaryFieldLabel = 'Field'
    FilterDialog.SummarySearchLabel = 'Search Type'
    FilterDialog.SummaryValueLabel = 'Value'
    FilterDialog.FieldsLabel = '&Fields'
    FilterDialog.ValueRangeTabHint = 'Search fields by value or by range'
    FilterDialog.AllSearchedTabHint = 'Show all fields or only currently searched fields'
    FilterDialog.ViewSummaryNotText = 'NOT'
    RichEdit.FontNameComboHint = 'Font | Changes the font of the selection'
    RichEdit.FontSizeComboHint = 'Font Size | Changes the font size of the selection'
    RichEdit.NewButtonHint = 'New | Creates a new document'
    RichEdit.LoadButtonHint = 'Load | Load from file'
    RichEdit.SaveAsButtonHint = 'Save As | Save to file'
    RichEdit.PrintButtonHint = 'Print | Prints the active document'
    RichEdit.PrintPreviewButtonHint = 'Print Preview | Print Preview the active document'
    RichEdit.FindButtonHint = 'Find | Finds the specified text'
    RichEdit.CutButtonHint = 'Cut | Cuts the selection and puts it on the Clipboard'
    RichEdit.CopyButtonHint = 'Copy | Copies the selection and puts it on the Clipboard'
    RichEdit.UndoButtonHint = 'Undo | Reverses the last action'
    RichEdit.RedoButtonHint = 'Redo | Reverses the last undo action'
    RichEdit.PasteButtonHint = 'Paste | Inserts Clipboard contents'
    RichEdit.BoldButtonHint = 'Bold | Makes the selection bold (toggle)'
    RichEdit.ColorButtonHint = 'Color | Formats the selection with a color'
    RichEdit.UnderlineButtonHint = 
      'Underline | Formats the selection with a continuous underline (t' +
      'oggle)'
    RichEdit.ItalicButtonHint = 'Italic | Makes the selection italic (toggle)'
    RichEdit.LeftButtonHint = 'Align Left | Left-justifies paragraph (toggle)'
    RichEdit.CenterButtonHint = 'Center | Center-justifies paragraph (toggle)'
    RichEdit.RightButtonHint = 'Align Right | Right-justifies paragraph (toggle)'
    RichEdit.JustifyButtonHint = 'Justify | Full Justification for paragraph (toggle)'
    RichEdit.BulletButtonHint = 'Bullets | Inserts a bullet on this line (toggle)'
    RichEdit.NumberingButtonHint = 'Numbering | Makes the selection numbered'
    RichEdit.HighlightButtonHint = 'Highlight Text | Makes the selection highlighted'
    RichEdit.FormatCaptionHint = 'Format | Formats the current selection'
    RichEdit.SaveExitHint = 'Save And Exit | Saves changes and exits editor'
    RichEdit.PageSetupHint = 'Page Setup | Changes page layout settings'
    RichEdit.ExitHint = 'Exit'
    RichEdit.ClearHint = 'Erases the Selection'
    RichEdit.SelectAllHint = 'Selects all of the text'
    RichEdit.FindNextHint = 'Repeats the last find'
    RichEdit.ReplaceHint = 'Replaces specific text with different text'
    RichEdit.InsertObjectHint = 'Inserts new embedded object'
    RichEdit.SpellCheckHint = 'Check spelling'
    RichEdit.ToolbarHint = 'Shows or hides the toolbar'
    RichEdit.FormatBarHint = 'Shows or hides the format bar'
    RichEdit.ViewStatusBarHint = 'Shows or hides the status bar'
    RichEdit.OptionsHint = 'Sets options'
    RichEdit.FontHint = 'Selects font for current selection'
    RichEdit.ParagraphHint = 'Formats current or selected paragraph(s)'
    RichEdit.TabsHint = 'Sets tabs'
    RichEdit.CAPLockCaption = 'CAP'
    RichEdit.NUMLockCaption = 'NUM'
    RichEdit.MenuLabels.FileCaption = '&File'
    RichEdit.MenuLabels.LoadCaption = '&Load'
    RichEdit.MenuLabels.SaveAsCaption = 'Save &As'
    RichEdit.MenuLabels.SaveExitCaption = '&Save and Exit'
    RichEdit.MenuLabels.PrintCaption = '&Print'
    RichEdit.MenuLabels.PrintPreviewCaption = '&Print Pre&view'
    RichEdit.MenuLabels.PageSetupCaption = 'Page Set&up'
    RichEdit.MenuLabels.ExitCaption = 'E&xit'
    RichEdit.MenuLabels.EditCaption = '&Edit'
    RichEdit.MenuLabels.UndoCaption = '&Undo'
    RichEdit.MenuLabels.CutCaption = 'Cu&t'
    RichEdit.MenuLabels.CopyCaption = '&Copy'
    RichEdit.MenuLabels.PasteCaption = '&Paste'
    RichEdit.MenuLabels.ClearCaption = 'Cle&ar'
    RichEdit.MenuLabels.SelectallCaption = 'Select A&ll'
    RichEdit.MenuLabels.FindCaption = '&Find'
    RichEdit.MenuLabels.FindNextCaption = 'Find &Next'
    RichEdit.MenuLabels.ReplaceCaption = 'R&eplace'
    RichEdit.MenuLabels.InsertObjectCaption = '&Object...'
    RichEdit.MenuLabels.ToolCaption = '&Tools'
    RichEdit.MenuLabels.SpellCheckCaption = 'Check &Spelling'
    RichEdit.MenuLabels.InsertCaption = '&Insert'
    RichEdit.MenuLabels.RulerCaption = '&Ruler'
    RichEdit.MenuLabels.ViewCaption = '&View'
    RichEdit.MenuLabels.ToolbarCaption = '&Toolbar'
    RichEdit.MenuLabels.FormatBarCaption = '&Format Bar'
    RichEdit.MenuLabels.ViewStatusBarCaption = '&Status Bar'
    RichEdit.MenuLabels.OptionsCaption = '&Options'
    RichEdit.MenuLabels.FormatCaption = 'F&ormat'
    RichEdit.MenuLabels.FontCaption = '&Font'
    RichEdit.MenuLabels.BulletStyleCaption = '&Bullet Style'
    RichEdit.MenuLabels.ParagraphCaption = '&Paragraph'
    RichEdit.MenuLabels.TabsCaption = '&Tabs'
    RichEdit.MenuLabels.HelpCaption = 'Help'
    RichEdit.PopupMenuLabels.EditCaption = '&Edit'
    RichEdit.PopupMenuLabels.ViewCaption = '&View'
    RichEdit.PopupMenuLabels.CutCaption = 'Cu&t'
    RichEdit.PopupMenuLabels.CopyCaption = '&Copy'
    RichEdit.PopupMenuLabels.PasteCaption = '&Paste'
    RichEdit.PopupMenuLabels.FontCaption = '&Font'
    RichEdit.PopupMenuLabels.BulletStyleCaption = '&Bullet Style'
    RichEdit.PopupMenuLabels.BoldCaption = 'B&old'
    RichEdit.PopupMenuLabels.ItalicCaption = '&Italic'
    RichEdit.PopupMenuLabels.UnderlineCaption = '&Underline'
    RichEdit.PopupMenuLabels.ParagraphCaption = 'P&aragraph'
    RichEdit.PopupMenuLabels.TabsCaption = '&Tabs'
    RichEdit.PopupMenuLabels.FindCaption = 'Fin&d'
    RichEdit.PopupMenuLabels.ReplaceCaption = '&Replace'
    RichEdit.PopupMenuLabels.InsertObjectCaption = 'Insert &Object...'
    RichEdit.PopupMenuLabels.ObjectPropertiesCaption = 'Object P&roperties'
    RichEdit.PopupMenuLabels.SpellCheckCaption = 'Check &Spelling'
    RichEdit.ParagraphDialog.ParagraphDlgCaption = 'Paragraph'
    RichEdit.ParagraphDialog.IndentationGroupBoxCaption = 'Indentation'
    RichEdit.ParagraphDialog.LeftEditHint = 'Left Indentation'
    RichEdit.ParagraphDialog.RightEditHint = 'Right Indentation'
    RichEdit.ParagraphDialog.FirstLineEditHint = 'First Line of Paragraph Indentation'
    RichEdit.ParagraphDialog.AlignmentHint = 'Changes Alignment of Paragraph'
    RichEdit.ParagraphDialog.LeftEditCaption = 'Left:'
    RichEdit.ParagraphDialog.RightEditCaption = 'Right:'
    RichEdit.ParagraphDialog.FirstLineEditCaption = 'First line:'
    RichEdit.ParagraphDialog.SpacingGroupCaption = 'Spacing'
    RichEdit.ParagraphDialog.BeforeParagraphCaption = '&Before'
    RichEdit.ParagraphDialog.AfterParagraphCaption = 'Aft&er'
    RichEdit.ParagraphDialog.WithinParagraphCaption = 'Li&ne Spacing'
    RichEdit.ParagraphDialog.WithinParagraphAtCaption = '&At'
    RichEdit.ParagraphDialog.AlignmentCaption = 'Alignment'
    RichEdit.ParagraphDialog.AlignLeft = 'Left'
    RichEdit.ParagraphDialog.AlignRight = 'Right'
    RichEdit.ParagraphDialog.AlignCenter = 'Center'
    RichEdit.ParagraphDialog.AlignJustify = 'Justify'
    RichEdit.TabDialog.TabDlgCaption = 'Tab'
    RichEdit.TabDialog.TabGroupBoxCaption = '&Tab Stop Position'
    RichEdit.TabDialog.SetTabButtonCaption = 'Set'
    RichEdit.TabDialog.ClearTabButtonCaption = 'Clear'
    RichEdit.TabDialog.ClearAllButtonCaption = 'Clear All'
    RichEdit.TabDialog.TabPositionEditHint = 'Tab Position Edit Box'
    RichEdit.TabDialog.ListBoxHint = 'List of tabs and their positions'
    RichEdit.TabDialog.SetButtonHint = 'Set a new tab position'
    RichEdit.TabDialog.ClearButtonHint = 'Clear the selected tab position'
    RichEdit.TabDialog.ClearAllButtonHint = 'Clear all the tabs'
    UserMessages.wwDBGridDiscardChanges = 'Discard changes to this record?'
    UserMessages.PictureValidateError = 'Invalid characters. Field : '
    UserMessages.LocateNoMatches = 'No matches found'
    UserMessages.LocateNoMoreMatches = 'No more matches found'
    UserMessages.MemoChangesWarning = 'Changes have been made!  Are you sure you wish to cancel?'
    UserMessages.RichEditExitWarning = 'Changes have been made!  Do you wish to save your changes?'
    UserMessages.RichEditClearWarning = 'Clear entire text?'
    UserMessages.RichEditSpellCheckComplete = 'The spell check is complete.'
    UserMessages.RichEditMSWordNotFound = 'Unable to start Microsoft Word'#39's Spell Checker.'
    UserMessages.FilterDlgNoCriteria = 'You have not selected any search criteria'
    UserMessages.RecordViewExitWarning = 'Changes have been made!  Do you wish to save your changes?'
    OKCancelBitmapped = True
    BtnOKCaption = '&OK'
    BtnCancelCaption = 'Cancel'
    CheckBoxInGridStyle = cbStyleAuto
    VersionInfoPower = 'IPStudioWin Grid Essentials 6.0.1.2'
    FilterMemoSize = 65536
    DialogFontStyle = []
    Connected = False
    Left = 352
    Top = 416
  end
  object wwRecordViewDialog1: TwwRecordViewDialog
    DataSource = DataSource1
    FormPosition.Left = 0
    FormPosition.Top = 0
    FormPosition.Width = 0
    FormPosition.Height = 0
    NavigatorButtons = [nbsFirst, nbsPrior, nbsNext, nbsLast, nbsInsert, nbsDelete, nbsEdit, nbsPost, nbsCancel, nbsRefresh, nbsPriorPage, nbsNextPage, nbsSaveBookmark, nbsRestoreBookmark]
    ControlOptions = []
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'Tahoma'
    LabelFont.Style = []
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Caption = 'Record View'
    Selected.Strings = (
      'Ficha'#9'6'#9'Ficha'#9#9
      'Digito'#9'1'#9'Digito'#9#9
      'Tels'#9'10'#9'Tels'#9#9
      'Oquefalamos'#9'10'#9'Oquefalamos'#9#9
      'dtatu'#9'34'#9'dtatu'#9#9
      'quem'#9'20'#9'quem'#9#9
      'Encerrou1'#9'10'#9'Encerrou1'#9#9
      'Encerrou2'#9'10'#9'Encerrou2'#9#9
      'Encerrou3'#9'10'#9'Encerrou3'#9#9
      'Encerrou4'#9'10'#9'Encerrou4'#9#9
      'Encerramento1'#9'10'#9'Encerramento1'#9#9
      'Encerramento2'#9'10'#9'Encerramento2'#9#9
      'Encerramento3'#9'10'#9'Encerramento3'#9#9
      'Encerramento4'#9'10'#9'Encerramento4'#9#9
      'tipo1'#9'10'#9'tipo1'#9#9
      'tipo2'#9'10'#9'tipo2'#9#9
      'tipo3'#9'10'#9'tipo3'#9#9
      'tipo4'#9'10'#9'tipo4'#9#9
      'faleicom1'#9'50'#9'faleicom1'#9#9
      'faleicom2'#9'50'#9'faleicom2'#9#9
      'faleicom3'#9'50'#9'faleicom3'#9#9
      'faleicom4'#9'50'#9'faleicom4'#9#9
      'ligardia1'#9'10'#9'ligardia1'#9#9
      'ligardia2'#9'10'#9'ligardia2'#9#9
      'ligardia3'#9'10'#9'ligardia3'#9#9
      'ligardia4'#9'10'#9'ligardia4'#9#9
      'prof_infosemi'#9'10'#9'prof_infosemi'#9#9
      'prof_dadosconfirmados'#9'10'#9'prof_dadosconfirmados'#9#9
      'prof_presencaconfirmada'#9'10'#9'prof_presencaconfirmada'#9#9
      'prof_mandaroficiofaltas'#9'10'#9'prof_mandaroficiofaltas'#9#9
      'aluno_dadosconfirmados'#9'10'#9'aluno_dadosconfirmados'#9#9
      'aluno_presencaconfirmada'#9'10'#9'aluno_presencaconfirmada'#9#9
      'aluno_mandaroficio'#9'10'#9'aluno_mandaroficio'#9#9
      'aluno_mandarautorizacao'#9'10'#9'aluno_mandarautorizacao'#9#9
      'ligar_pais'#9'10'#9'ligar_pais'#9#9
      'ligar_diretor'#9'10'#9'ligar_diretor'#9#9
      'informou_itinerario'#9'10'#9'informou_itinerario'#9#9
      'enviou_emailitinerario'#9'10'#9'enviou_emailitinerario'#9#9
      'informei_valordeposito'#9'10'#9'informei_valordeposito'#9#9
      'recebeu_envelope'#9'10'#9'recebeu_envelope'#9#9
      'retirou_deposito'#9'10'#9'retirou_deposito'#9#9
      'recebeu_roteiro'#9'10'#9'recebeu_roteiro'#9#9
      'comprou_passagens'#9'10'#9'comprou_passagens'#9#9
      'aluno_problema'#9'10'#9'aluno_problema'#9#9
      'problema_descricao'#9'10'#9'problema_descricao'#9#9
      'prof_problema'#9'10'#9'prof_problema'#9#9
      'problema_itinerario'#9'10'#9'problema_itinerario'#9#9
      'problema_desc_itinerario'#9'10'#9'problema_desc_itinerario'#9#9
      'problema_documentos'#9'10'#9'problema_documentos'#9#9
      'problema_desc_docs'#9'10'#9'problema_desc_docs'#9#9
      'KM_taxi'#9'10'#9'KM_taxi'#9#9
      'valor_taxi'#9'10'#9'valor_taxi'#9#9
      'valor_aviao'#9'10'#9'valor_aviao'#9#9
      'Valor_onibus'#9'10'#9'Valor_onibus'#9#9
      'valor_outros'#9'10'#9'valor_outros'#9#9
      'ajuda_custo'#9'10'#9'ajuda_custo'#9#9
      'duracao_total'#9'10'#9'duracao_total'#9#9
      'Km_total'#9'10'#9'Km_total'#9#9
      'Total_deposito'#9'10'#9'Total_deposito'#9#9
      'problemas_ultimo'#9'10'#9'problemas_ultimo'#9#9
      'problema_desc_ultimo'#9'10'#9'problema_desc_ultimo'#9#9
      'valor_extra'#9'10'#9'valor_extra'#9#9
      'Nome_representante'#9'60'#9'Nome_representante'#9#9
      'RG_representante'#9'20'#9'RG_representante'#9#9
      'CPF_representante'#9'11'#9'CPF_representante'#9#9
      'Bilhetes_OBS'#9'10'#9'Bilhetes_OBS'#9#9
      'oficio_recebido'#9'10'#9'oficio_recebido'#9#9
      'Prof_falacom_pais'#9'10'#9'Prof_falacom_pais'#9#9
      'Prof_falacom_diretor'#9'10'#9'Prof_falacom_diretor'#9#9
      'Atende_falacom_pais'#9'10'#9'Atende_falacom_pais'#9#9
      'Atende_falacom_diretor'#9'10'#9'Atende_falacom_diretor'#9#9
      'enviar_envelope'#9'10'#9'enviar_envelope'#9#9
      'enviou_envelope_em'#9'10'#9'enviou_envelope_em'#9#9
      'enviou_envelope'#9'10'#9'enviou_envelope'#9#9
      'enviou_deposito_em'#9'10'#9'enviou_deposito_em'#9#9
      'enviou_deposito'#9'10'#9'enviou_deposito'#9#9
      'bilhete_aereo_em'#9'10'#9'bilhete_aereo_em'#9#9
      'bilhete_aereo'#9'10'#9'bilhete_aereo'#9#9
      'prof_e_ticket'#9'255'#9'prof_e_ticket'#9#9
      'aluno_e_ticket'#9'255'#9'aluno_e_ticket'#9#9
      'representante_confirmado'#9'10'#9'representante_confirmado'#9#9
      'rota_concluida'#9'10'#9'rota_concluida'#9#9
      'selecionou'#9'5'#9'selecionou'#9#9)
    NavigatorFlat = True
    Navigator = wwDBNavigator1
    Left = 40
    Top = 408
  end
end

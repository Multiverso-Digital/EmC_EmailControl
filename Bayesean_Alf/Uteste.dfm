object Fteste: TFteste
  Left = 0
  Top = 0
  Caption = 'Fteste'
  ClientHeight = 596
  ClientWidth = 746
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 316
    Top = 221
    Width = 3
    Height = 13
  end
  object PB: TProgressBar
    Left = 160
    Top = 221
    Width = 150
    Height = 17
    TabOrder = 0
  end
  object ProgressBar1: TProgressBar
    Left = 451
    Top = 221
    Width = 150
    Height = 17
    TabOrder = 1
  end
  object Memo1: TMemo
    Left = 8
    Top = 261
    Width = 441
    Height = 143
    TabOrder = 2
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 166
    Width = 305
    Height = 49
    Caption = 'Normal'
    TabOrder = 3
    object Button1: TButton
      Left = 16
      Top = 17
      Width = 75
      Height = 25
      Caption = 'Aprende'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 127
      Top = 21
      Width = 75
      Height = 25
      Caption = 'Calcula spam'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 214
      Top = 21
      Width = 75
      Height = 25
      Caption = 'Calcula ok'
      TabOrder = 2
      OnClick = Button3Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 433
    Top = 166
    Width = 305
    Height = 49
    Caption = 'Itens Cabe'#231'lho'
    TabOrder = 4
    object Button4: TButton
      Left = 3
      Top = 21
      Width = 75
      Height = 25
      Caption = 'Aprende'
      TabOrder = 0
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 104
      Top = 21
      Width = 75
      Height = 25
      Caption = 'Calcula spam'
      TabOrder = 1
      OnClick = Button5Click
    end
    object Button6: TButton
      Left = 185
      Top = 21
      Width = 75
      Height = 25
      Caption = 'Calcula ok'
      TabOrder = 2
      OnClick = Button6Click
    end
  end
  object StringGrid1: TStringGrid
    Left = 8
    Top = 410
    Width = 441
    Height = 156
    ColCount = 4
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    TabOrder = 5
    ColWidths = (
      142
      115
      79
      66)
  end
  object wwDBGrid1: TwwDBGrid
    Left = 8
    Top = 8
    Width = 730
    Height = 152
    Selected.Strings = (
      'Email'#9'35'#9'Email'
      'Assunto'#9'50'#9'Assunto'
      'Emitente'#9'50'#9'Emitente'
      'Filtrada'#9'5'#9'Filtrada'
      'ListaNegra'#9'5'#9'ListaNegra'
      'Favoritos'#9'5'#9'Favoritos'
      'selecionada'#9'5'#9'selecionada'
      'Spam'#9'15'#9'Spam')
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    PopupMenu = PopupMenu1
    TabOrder = 6
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = True
    OnTitleButtonClick = wwDBGrid1TitleButtonClick
    OnDblClick = wwDBGrid1DblClick
  end
  object Button7: TButton
    Left = 537
    Top = 512
    Width = 75
    Height = 25
    Caption = 'Limpa Tudo'
    TabOrder = 7
    OnClick = Button7Click
  end
  object qToken: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      'select * from tab_token')
    Left = 176
    Top = 8
  end
  object MyConnection1: TMyConnection
    Database = 'emc'
    Username = 'root'
    Password = 'aw1122'
    Server = '192.168.0.10'
    Connected = True
    LoginPrompt = False
    Left = 88
    Top = 40
  end
  object provToken: TDataSetProvider
    DataSet = qToken
    Left = 224
    Top = 8
  end
  object cdsToken: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'provToken'
    Left = 280
    Top = 8
    object cdsTokenid: TIntegerField
      FieldName = 'id'
    end
    object cdsTokenpalavra: TStringField
      FieldName = 'palavra'
      Size = 255
    end
    object cdsTokenqtd_spam: TIntegerField
      FieldName = 'qtd_spam'
    end
    object cdsTokenqtd_ok: TIntegerField
      FieldName = 'qtd_ok'
    end
    object cdsTokenmail_spam: TIntegerField
      FieldName = 'mail_spam'
    end
    object cdsTokenmail_ok: TIntegerField
      FieldName = 'mail_ok'
    end
  end
  object qMens: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT '
      '    *'
      'FROM'
      '  all_messages'
      'Where'
      '  favoritos = 1 or listaNegra =1'
      'ORDER BY'
      ' ID'
      'limit'
      '1500')
    Left = 176
    Top = 56
  end
  object provMens: TDataSetProvider
    DataSet = qMens
    Left = 224
    Top = 56
  end
  object cdsMens: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'provMens'
    Left = 280
    Top = 56
    object cdsMensID: TLargeintField
      FieldName = 'ID'
    end
    object cdsMensDT: TDateTimeField
      FieldName = 'DT'
    end
    object cdsMensEmail: TStringField
      FieldName = 'Email'
      Size = 200
    end
    object cdsMensAssunto: TStringField
      FieldName = 'Assunto'
      Size = 255
    end
    object cdsMensEmitente: TStringField
      FieldName = 'Emitente'
      Size = 255
    end
    object cdsMensTama: TIntegerField
      FieldName = 'Tama'
    end
    object cdsMensDatamens: TStringField
      FieldName = 'Datamens'
    end
    object cdsMensCabec: TMemoField
      FieldName = 'Cabec'
      BlobType = ftMemo
    end
    object cdsMensCorpo: TMemoField
      FieldName = 'Corpo'
      BlobType = ftMemo
    end
    object cdsMensStatus: TIntegerField
      FieldName = 'Status'
    end
    object cdsMensFiltrada: TIntegerField
      FieldName = 'Filtrada'
    end
    object cdsMensListaNegra: TIntegerField
      FieldName = 'ListaNegra'
    end
    object cdsMensFavoritos: TIntegerField
      FieldName = 'Favoritos'
    end
    object cdsMensFiltroResult: TMemoField
      FieldName = 'FiltroResult'
      BlobType = ftMemo
    end
    object cdsMensListaNegraResult: TMemoField
      FieldName = 'ListaNegraResult'
      BlobType = ftMemo
    end
    object cdsMensNumeroMens: TIntegerField
      FieldName = 'NumeroMens'
    end
    object cdsMensExcluida: TIntegerField
      FieldName = 'Excluida'
    end
    object cdsMensAnexos: TIntegerField
      FieldName = 'Anexos'
    end
    object cdsMensselecionada: TIntegerField
      FieldName = 'selecionada'
    end
    object cdsMensConta: TStringField
      FieldName = 'Conta'
      Size = 50
    end
    object cdsMensMsgId: TStringField
      FieldName = 'MsgId'
      Size = 255
    end
    object cdsMensIsBodyEmpty: TBooleanField
      FieldName = 'IsBodyEmpty'
    end
    object cdsMensUID: TStringField
      FieldName = 'UID'
      Size = 255
    end
    object cdsMensIsMsgSinglePartMime: TBooleanField
      FieldName = 'IsMsgSinglePartMime'
    end
    object cdsMensAttachmentEncoding: TStringField
      FieldName = 'AttachmentEncoding'
      Size = 255
    end
    object cdsMensCharSet: TStringField
      FieldName = 'CharSet'
      Size = 255
    end
    object cdsMensContentType: TStringField
      FieldName = 'ContentType'
      Size = 255
    end
    object cdsMensContentTransferEncoding: TStringField
      FieldName = 'ContentTransferEncoding'
      Size = 255
    end
    object cdsMensContentDisposition: TStringField
      FieldName = 'ContentDisposition'
      Size = 255
    end
    object cdsMensNoEncode: TBooleanField
      FieldName = 'NoEncode'
    end
    object cdsMensNoDecode: TBooleanField
      FieldName = 'NoDecode'
    end
    object cdsMensOrganization: TStringField
      FieldName = 'Organization'
      Size = 255
    end
    object cdsMensDataOrig: TStringField
      FieldName = 'DataOrig'
      Size = 255
    end
    object cdsMensXmailer: TStringField
      FieldName = 'Xmailer'
      Size = 255
    end
    object cdsMensReplayTO: TStringField
      FieldName = 'ReplayTO'
      Size = 255
    end
    object cdsMensReturnPath: TStringField
      FieldName = 'ReturnPath'
      Size = 255
    end
    object cdsMensFromOrig: TStringField
      FieldName = 'FromOrig'
      Size = 255
    end
    object cdsMensToOrig: TMemoField
      FieldName = 'ToOrig'
      BlobType = ftMemo
    end
    object cdsMensCCOrig: TMemoField
      FieldName = 'CCOrig'
      BlobType = ftMemo
    end
    object cdsMensBCCOrig: TMemoField
      FieldName = 'BCCOrig'
      BlobType = ftMemo
    end
    object cdsMensReceivedFrom: TStringField
      FieldName = 'ReceivedFrom'
      Size = 255
    end
    object cdsMensFriendResult: TMemoField
      FieldName = 'FriendResult'
      BlobType = ftMemo
    end
    object cdsMensEmailFrom: TStringField
      FieldName = 'EmailFrom'
      Size = 255
    end
    object cdsMensDominioFrom: TStringField
      FieldName = 'DominioFrom'
      Size = 255
    end
    object cdsMensIPSender: TStringField
      FieldName = 'IPSender'
      Size = 15
    end
    object cdsMensID_Conta: TIntegerField
      FieldName = 'ID_Conta'
    end
    object cdsMensAnexosFiles: TMemoField
      FieldName = 'AnexosFiles'
      BlobType = ftMemo
    end
    object cdsMensCountry: TStringField
      FieldName = 'Country'
      Size = 50
    end
    object cdsMenslida: TIntegerField
      FieldName = 'lida'
    end
    object cdsMensCorpoTexto: TMemoField
      FieldName = 'CorpoTexto'
      BlobType = ftMemo
    end
  end
  object qbayesian: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT '
      '    *'
      'FROM'
      '  tab_bayesian')
    Left = 176
    Top = 112
  end
  object ProvBayesian: TDataSetProvider
    DataSet = qbayesian
    Left = 224
    Top = 112
  end
  object cdsBayesian: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'ProvBayesian'
    Left = 280
    Top = 112
    object cdsBayesianid: TIntegerField
      FieldName = 'id'
    end
    object cdsBayesianqtd_mail_spam: TIntegerField
      FieldName = 'qtd_mail_spam'
    end
    object cdsBayesianqtd_mail_ok: TIntegerField
      FieldName = 'qtd_mail_ok'
    end
  end
  object cdsTest: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftUnknown
        Name = 'negra'
        ParamType = ptUnknown
      end
      item
        DataType = ftUnknown
        Name = 'fav'
        ParamType = ptUnknown
      end>
    ProviderName = 'ProvTeste'
    Left = 272
    Top = 208
    object cdsTestID: TLargeintField
      FieldName = 'ID'
    end
    object cdsTestDT: TDateTimeField
      FieldName = 'DT'
    end
    object cdsTestEmail: TStringField
      FieldName = 'Email'
      Size = 200
    end
    object cdsTestAssunto: TStringField
      FieldName = 'Assunto'
      Size = 255
    end
    object cdsTestEmitente: TStringField
      FieldName = 'Emitente'
      Size = 255
    end
    object cdsTestTama: TIntegerField
      FieldName = 'Tama'
    end
    object cdsTestDatamens: TStringField
      FieldName = 'Datamens'
    end
    object cdsTestCabec: TMemoField
      FieldName = 'Cabec'
      BlobType = ftMemo
    end
    object cdsTestCorpo: TMemoField
      FieldName = 'Corpo'
      BlobType = ftMemo
    end
    object cdsTestStatus: TIntegerField
      FieldName = 'Status'
    end
    object cdsTestFiltrada: TIntegerField
      FieldName = 'Filtrada'
    end
    object cdsTestListaNegra: TIntegerField
      FieldName = 'ListaNegra'
    end
    object cdsTestFavoritos: TIntegerField
      FieldName = 'Favoritos'
    end
    object cdsTestFiltroResult: TMemoField
      FieldName = 'FiltroResult'
      BlobType = ftMemo
    end
    object cdsTestListaNegraResult: TMemoField
      FieldName = 'ListaNegraResult'
      BlobType = ftMemo
    end
    object cdsTestNumeroMens: TIntegerField
      FieldName = 'NumeroMens'
    end
    object cdsTestExcluida: TIntegerField
      FieldName = 'Excluida'
    end
    object cdsTestAnexos: TIntegerField
      FieldName = 'Anexos'
    end
    object cdsTestselecionada: TIntegerField
      FieldName = 'selecionada'
    end
    object cdsTestConta: TStringField
      FieldName = 'Conta'
      Size = 50
    end
    object cdsTestMsgId: TStringField
      FieldName = 'MsgId'
      Size = 255
    end
    object cdsTestIsBodyEmpty: TBooleanField
      FieldName = 'IsBodyEmpty'
    end
    object cdsTestUID: TStringField
      FieldName = 'UID'
      Size = 255
    end
    object cdsTestIsMsgSinglePartMime: TBooleanField
      FieldName = 'IsMsgSinglePartMime'
    end
    object cdsTestAttachmentEncoding: TStringField
      FieldName = 'AttachmentEncoding'
      Size = 255
    end
    object cdsTestCharSet: TStringField
      FieldName = 'CharSet'
      Size = 255
    end
    object cdsTestContentType: TStringField
      FieldName = 'ContentType'
      Size = 255
    end
    object cdsTestContentTransferEncoding: TStringField
      FieldName = 'ContentTransferEncoding'
      Size = 255
    end
    object cdsTestContentDisposition: TStringField
      FieldName = 'ContentDisposition'
      Size = 255
    end
    object cdsTestNoEncode: TBooleanField
      FieldName = 'NoEncode'
    end
    object cdsTestNoDecode: TBooleanField
      FieldName = 'NoDecode'
    end
    object cdsTestOrganization: TStringField
      FieldName = 'Organization'
      Size = 255
    end
    object cdsTestDataOrig: TStringField
      FieldName = 'DataOrig'
      Size = 255
    end
    object cdsTestXmailer: TStringField
      FieldName = 'Xmailer'
      Size = 255
    end
    object cdsTestReplayTO: TStringField
      FieldName = 'ReplayTO'
      Size = 255
    end
    object cdsTestReturnPath: TStringField
      FieldName = 'ReturnPath'
      Size = 255
    end
    object cdsTestFromOrig: TStringField
      FieldName = 'FromOrig'
      Size = 255
    end
    object cdsTestToOrig: TMemoField
      FieldName = 'ToOrig'
      BlobType = ftMemo
    end
    object cdsTestCCOrig: TMemoField
      FieldName = 'CCOrig'
      BlobType = ftMemo
    end
    object cdsTestBCCOrig: TMemoField
      FieldName = 'BCCOrig'
      BlobType = ftMemo
    end
    object cdsTestReceivedFrom: TStringField
      FieldName = 'ReceivedFrom'
      Size = 255
    end
    object cdsTestFriendResult: TMemoField
      FieldName = 'FriendResult'
      BlobType = ftMemo
    end
    object cdsTestEmailFrom: TStringField
      FieldName = 'EmailFrom'
      Size = 255
    end
    object cdsTestDominioFrom: TStringField
      FieldName = 'DominioFrom'
      Size = 255
    end
    object cdsTestIPSender: TStringField
      FieldName = 'IPSender'
      Size = 15
    end
    object cdsTestID_Conta: TIntegerField
      FieldName = 'ID_Conta'
    end
    object cdsTestAnexosFiles: TMemoField
      FieldName = 'AnexosFiles'
      BlobType = ftMemo
    end
    object cdsTestCountry: TStringField
      FieldName = 'Country'
      Size = 50
    end
    object cdsTestlida: TIntegerField
      FieldName = 'lida'
    end
    object cdsTestCorpoTexto: TMemoField
      FieldName = 'CorpoTexto'
      BlobType = ftMemo
    end
  end
  object ProvTeste: TDataSetProvider
    DataSet = qTest
    Left = 216
    Top = 208
  end
  object qTest: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      'SELECT '
      '    *'
      'FROM'
      '  all_messages'
      'Where'
      'all_messages.`ListaNegra` = :negra and '
      'all_messages.`Favoritos` = :fav'
      'ORDER BY'
      ' ID'
      'limit 10')
    Left = 168
    Top = 208
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'negra'
      end
      item
        DataType = ftUnknown
        Name = 'fav'
      end>
  end
  object MyQuery1: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      'Select *, 0 as Spam from messages_thread')
    Left = 528
    Top = 320
    object MyQuery1Email: TStringField
      DisplayWidth = 35
      FieldName = 'Email'
      Origin = 'messages_thread.Email'
      Size = 200
    end
    object MyQuery1Assunto: TStringField
      DisplayWidth = 50
      FieldName = 'Assunto'
      Origin = 'messages_thread.Assunto'
      Size = 255
    end
    object MyQuery1Emitente: TStringField
      DisplayWidth = 50
      FieldName = 'Emitente'
      Origin = 'messages_thread.Emitente'
      Size = 255
    end
    object MyQuery1Filtrada: TIntegerField
      DisplayWidth = 5
      FieldName = 'Filtrada'
      Origin = 'messages_thread.Filtrada'
    end
    object MyQuery1ListaNegra: TIntegerField
      DisplayWidth = 5
      FieldName = 'ListaNegra'
      Origin = 'messages_thread.ListaNegra'
    end
    object MyQuery1Favoritos: TIntegerField
      DisplayWidth = 5
      FieldName = 'Favoritos'
      Origin = 'messages_thread.Favoritos'
    end
    object MyQuery1selecionada: TIntegerField
      DisplayWidth = 5
      FieldName = 'selecionada'
      Origin = 'messages_thread.selecionada'
    end
    object MyQuery1Spam: TLargeintField
      DisplayWidth = 15
      FieldName = 'Spam'
      Origin = '.Spam'
    end
    object MyQuery1ID: TLargeintField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'messages_thread.ID'
      Visible = False
    end
    object MyQuery1DT: TDateTimeField
      FieldName = 'DT'
      Origin = 'messages_thread.DT'
      Visible = False
    end
    object MyQuery1Tama: TIntegerField
      FieldName = 'Tama'
      Origin = 'messages_thread.Tama'
      Visible = False
    end
    object MyQuery1Datamens: TDateTimeField
      FieldName = 'Datamens'
      Origin = 'messages_thread.Datamens'
      Visible = False
    end
    object MyQuery1Cabec: TMemoField
      FieldName = 'Cabec'
      Origin = 'messages_thread.Cabec'
      Visible = False
      BlobType = ftMemo
    end
    object MyQuery1Corpo: TMemoField
      FieldName = 'Corpo'
      Origin = 'messages_thread.Corpo'
      Visible = False
      BlobType = ftMemo
    end
    object MyQuery1Status: TIntegerField
      FieldName = 'Status'
      Origin = 'messages_thread.Status'
      Visible = False
    end
    object MyQuery1FiltroResult: TMemoField
      FieldName = 'FiltroResult'
      Origin = 'messages_thread.FiltroResult'
      Visible = False
      BlobType = ftMemo
    end
    object MyQuery1ListaNegraResult: TMemoField
      FieldName = 'ListaNegraResult'
      Origin = 'messages_thread.ListaNegraResult'
      Visible = False
      BlobType = ftMemo
    end
    object MyQuery1NumeroMens: TIntegerField
      FieldName = 'NumeroMens'
      Origin = 'messages_thread.NumeroMens'
      Visible = False
    end
    object MyQuery1Excluida: TIntegerField
      FieldName = 'Excluida'
      Origin = 'messages_thread.Excluida'
      Visible = False
    end
    object MyQuery1Anexos: TIntegerField
      FieldName = 'Anexos'
      Origin = 'messages_thread.Anexos'
      Visible = False
    end
    object MyQuery1Conta: TStringField
      FieldName = 'Conta'
      Origin = 'messages_thread.Conta'
      Visible = False
      Size = 50
    end
    object MyQuery1MsgId: TStringField
      FieldName = 'MsgId'
      Origin = 'messages_thread.MsgId'
      Visible = False
      Size = 255
    end
    object MyQuery1IsBodyEmpty: TBooleanField
      FieldName = 'IsBodyEmpty'
      Origin = 'messages_thread.IsBodyEmpty'
      Visible = False
    end
    object MyQuery1UID: TStringField
      FieldName = 'UID'
      Origin = 'messages_thread.UID'
      Visible = False
      Size = 255
    end
    object MyQuery1IsMsgSinglePartMime: TBooleanField
      FieldName = 'IsMsgSinglePartMime'
      Origin = 'messages_thread.IsMsgSinglePartMime'
      Visible = False
    end
    object MyQuery1AttachmentEncoding: TStringField
      FieldName = 'AttachmentEncoding'
      Origin = 'messages_thread.AttachmentEncoding'
      Visible = False
      Size = 255
    end
    object MyQuery1CharSet: TStringField
      FieldName = 'CharSet'
      Origin = 'messages_thread.CharSet'
      Visible = False
      Size = 255
    end
    object MyQuery1ContentType: TStringField
      FieldName = 'ContentType'
      Origin = 'messages_thread.ContentType'
      Visible = False
      Size = 255
    end
    object MyQuery1ContentTransferEncoding: TStringField
      FieldName = 'ContentTransferEncoding'
      Origin = 'messages_thread.ContentTransferEncoding'
      Visible = False
      Size = 255
    end
    object MyQuery1ContentDisposition: TStringField
      FieldName = 'ContentDisposition'
      Origin = 'messages_thread.ContentDisposition'
      Visible = False
      Size = 255
    end
    object MyQuery1NoEncode: TBooleanField
      FieldName = 'NoEncode'
      Origin = 'messages_thread.NoEncode'
      Visible = False
    end
    object MyQuery1NoDecode: TBooleanField
      FieldName = 'NoDecode'
      Origin = 'messages_thread.NoDecode'
      Visible = False
    end
    object MyQuery1Organization: TStringField
      FieldName = 'Organization'
      Origin = 'messages_thread.Organization'
      Visible = False
      Size = 255
    end
    object MyQuery1DataOrig: TStringField
      FieldName = 'DataOrig'
      Origin = 'messages_thread.DataOrig'
      Visible = False
      Size = 255
    end
    object MyQuery1Xmailer: TStringField
      FieldName = 'Xmailer'
      Origin = 'messages_thread.Xmailer'
      Visible = False
      Size = 255
    end
    object MyQuery1ReplayTO: TStringField
      FieldName = 'ReplayTO'
      Origin = 'messages_thread.ReplayTO'
      Visible = False
      Size = 255
    end
    object MyQuery1ReturnPath: TStringField
      FieldName = 'ReturnPath'
      Origin = 'messages_thread.ReturnPath'
      Visible = False
      Size = 255
    end
    object MyQuery1FromOrig: TStringField
      FieldName = 'FromOrig'
      Origin = 'messages_thread.FromOrig'
      Visible = False
      Size = 255
    end
    object MyQuery1ToOrig: TStringField
      FieldName = 'ToOrig'
      Origin = 'messages_thread.ToOrig'
      Visible = False
      Size = 255
    end
    object MyQuery1CCOrig: TMemoField
      FieldName = 'CCOrig'
      Origin = 'messages_thread.CCOrig'
      Visible = False
      BlobType = ftMemo
    end
    object MyQuery1BCCOrig: TMemoField
      FieldName = 'BCCOrig'
      Origin = 'messages_thread.BCCOrig'
      Visible = False
      BlobType = ftMemo
    end
    object MyQuery1ReceivedFrom: TStringField
      FieldName = 'ReceivedFrom'
      Origin = 'messages_thread.ReceivedFrom'
      Visible = False
      Size = 255
    end
    object MyQuery1FriendResult: TMemoField
      FieldName = 'FriendResult'
      Origin = 'messages_thread.FriendResult'
      Visible = False
      BlobType = ftMemo
    end
    object MyQuery1EmailFrom: TStringField
      FieldName = 'EmailFrom'
      Origin = 'messages_thread.EmailFrom'
      Visible = False
      Size = 255
    end
    object MyQuery1DominioFrom: TStringField
      FieldName = 'DominioFrom'
      Origin = 'messages_thread.DominioFrom'
      Visible = False
      Size = 255
    end
    object MyQuery1IPSender: TStringField
      FieldName = 'IPSender'
      Origin = 'messages_thread.IPSender'
      Visible = False
      Size = 15
    end
    object MyQuery1ID_Conta: TIntegerField
      FieldName = 'ID_Conta'
      Origin = 'messages_thread.ID_Conta'
      Visible = False
    end
    object MyQuery1AnexosFiles: TMemoField
      FieldName = 'AnexosFiles'
      Origin = 'messages_thread.AnexosFiles'
      Visible = False
      BlobType = ftMemo
    end
    object MyQuery1Country: TStringField
      FieldName = 'Country'
      Origin = 'messages_thread.Country'
      Visible = False
      Size = 50
    end
    object MyQuery1lida: TIntegerField
      FieldName = 'lida'
      Origin = 'messages_thread.lida'
      Visible = False
    end
  end
  object DataSource1: TDataSource
    DataSet = MyQuery1
    Left = 584
    Top = 320
  end
  object PopupMenu1: TPopupMenu
    Left = 552
    Top = 400
    object Aprende1: TMenuItem
      Caption = 'Aprende Spam'
      OnClick = Aprende1Click
    end
    object AprendeOK1: TMenuItem
      Caption = 'Aprende OK'
      OnClick = AprendeOK1Click
    end
  end
  object MyTable1: TMyTable
    Connection = MyConnection1
    Left = 512
    Top = 448
  end
  object MyQuery2: TMyQuery
    SQLInsert.Strings = (
      'INSERT INTO tab_token'
      '  (ID, palavra, qtd_spam, qtd_ok, DT)'
      'VALUES'
      '  (:ID, :palavra, :qtd_spam, :qtd_ok, :DT)')
    SQLDelete.Strings = (
      'DELETE FROM tab_token'
      'WHERE'
      '  ID = :Old_ID')
    SQLUpdate.Strings = (
      'UPDATE tab_token'
      'SET'
      
        '  ID = :ID, palavra = :palavra, qtd_spam = :qtd_spam, qtd_ok = :' +
        'qtd_ok, DT = :DT'
      'WHERE'
      '  ID = :Old_ID')
    SQLRefresh.Strings = (
      
        'SELECT tab_token.ID, tab_token.palavra, tab_token.qtd_spam, tab_' +
        'token.qtd_ok, tab_token.DT FROM tab_token'
      'WHERE'
      '  tab_token.ID = :ID')
    Connection = MyConnection1
    SQL.Strings = (
      'Select * from tab_token where palavra = :palavra')
    Left = 360
    Top = 304
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'palavra'
      end>
  end
end

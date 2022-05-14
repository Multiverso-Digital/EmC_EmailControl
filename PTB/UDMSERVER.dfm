object DM_SERVER: TDM_SERVER
  OldCreateOrder = False
  Height = 346
  Width = 511
  object MC: TMyConnection
    Database = 'emc'
    Username = 'root'
    Password = 'aw1122'
    Server = '192.168.0.10'
    Connected = True
    LoginPrompt = False
    Left = 40
    Top = 24
  end
  object qcontas: TMyQuery
    Connection = MC
    SQL.Strings = (
      'select * from accounts')
    Left = 112
    Top = 24
    object qcontasID: TIntegerField
      AutoGenerateValue = arAutoInc
      FieldName = 'ID'
      Origin = 'accounts.ID'
    end
    object qcontasNome: TStringField
      FieldName = 'Nome'
      Origin = 'accounts.Nome'
      Size = 50
    end
    object qcontasPOP: TStringField
      FieldName = 'POP'
      Origin = 'accounts.POP'
      Size = 200
    end
    object qcontasSMTP: TStringField
      FieldName = 'SMTP'
      Origin = 'accounts.SMTP'
      Size = 200
    end
    object qcontasPorta: TIntegerField
      FieldName = 'Porta'
      Origin = 'accounts.Porta'
    end
    object qcontasUsuario: TStringField
      FieldName = 'Usuario'
      Origin = 'accounts.Usuario'
      Size = 200
    end
    object qcontasSenha: TStringField
      FieldName = 'Senha'
      Origin = 'accounts.Senha'
      Size = 50
    end
    object qcontasEmail: TStringField
      FieldName = 'Email'
      Origin = 'accounts.Email'
      Size = 200
    end
    object qcontasSMTPautentica: TIntegerField
      FieldName = 'SMTPautentica'
      Origin = 'accounts.SMTPautentica'
    end
    object qcontasSMTPusuario: TStringField
      FieldName = 'SMTPusuario'
      Origin = 'accounts.SMTPusuario'
      Size = 50
    end
    object qcontasSMTPSenha: TStringField
      FieldName = 'SMTPSenha'
      Origin = 'accounts.SMTPSenha'
      Size = 50
    end
    object qcontasSMTPPorta: TIntegerField
      FieldName = 'SMTPPorta'
      Origin = 'accounts.SMTPPorta'
    end
    object qcontasAtivada: TIntegerField
      FieldName = 'Ativada'
      Origin = 'accounts.Ativada'
    end
    object qcontasExcluida: TIntegerField
      FieldName = 'Excluida'
      Origin = 'accounts.Excluida'
    end
    object qcontasDTALT: TDateTimeField
      FieldName = 'DTALT'
      Origin = 'accounts.DTALT'
    end
  end
  object Prov_Contas: TDataSetProvider
    DataSet = qcontas
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 176
    Top = 24
  end
  object Cds_Contas: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'Prov_Contas'
    BeforePost = Cds_ContasBeforePost
    Left = 248
    Top = 24
    object Cds_ContasAtivada: TIntegerField
      DisplayWidth = 10
      FieldName = 'Ativada'
    end
    object Cds_ContasNome: TStringField
      DisplayWidth = 30
      FieldName = 'Nome'
      Size = 50
    end
    object Cds_ContasEmail: TStringField
      DisplayWidth = 30
      FieldName = 'Email'
      Size = 200
    end
    object Cds_ContasID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Visible = False
    end
    object Cds_ContasPOP: TStringField
      DisplayWidth = 37
      FieldName = 'POP'
      Visible = False
      Size = 200
    end
    object Cds_ContasSMTP: TStringField
      DisplayWidth = 200
      FieldName = 'SMTP'
      Visible = False
      Size = 200
    end
    object Cds_ContasPorta: TIntegerField
      DisplayWidth = 10
      FieldName = 'Porta'
      Visible = False
    end
    object Cds_ContasUsuario: TStringField
      DisplayWidth = 200
      FieldName = 'Usuario'
      Visible = False
      Size = 200
    end
    object Cds_ContasSenha: TStringField
      DisplayWidth = 50
      FieldName = 'Senha'
      Visible = False
      Size = 50
    end
    object Cds_ContasSMTPautentica: TIntegerField
      DisplayWidth = 10
      FieldName = 'SMTPautentica'
      Visible = False
    end
    object Cds_ContasSMTPusuario: TStringField
      DisplayWidth = 50
      FieldName = 'SMTPusuario'
      Visible = False
      Size = 50
    end
    object Cds_ContasSMTPSenha: TStringField
      DisplayWidth = 50
      FieldName = 'SMTPSenha'
      Visible = False
      Size = 50
    end
    object Cds_ContasSMTPPorta: TIntegerField
      DisplayWidth = 10
      FieldName = 'SMTPPorta'
      Visible = False
    end
    object Cds_ContasExcluida: TIntegerField
      DisplayWidth = 10
      FieldName = 'Excluida'
      Visible = False
    end
    object Cds_ContasDTALT: TDateTimeField
      DisplayWidth = 18
      FieldName = 'DTALT'
      Visible = False
    end
  end
  object DS_qContas: TDataSource
    DataSet = Cds_Contas
    Left = 316
    Top = 24
  end
  object qmens: TMyQuery
    Connection = MC
    SQL.Strings = (
      'select * from messages'
      'where status = :status')
    Left = 112
    Top = 72
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'STATUS'
      end>
  end
  object Prov_Mens: TDataSetProvider
    DataSet = qmens
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 176
    Top = 72
  end
  object Cds_Mens: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftUnknown
        Name = 'STATUS'
        ParamType = ptUnknown
      end>
    ProviderName = 'Prov_Mens'
    Left = 248
    Top = 72
    object Cds_Mensselecionada: TIntegerField
      DisplayLabel = 'SEL'
      DisplayWidth = 4
      FieldName = 'selecionada'
      Origin = 'mensagens.selecionada'
    end
    object Cds_MensFiltrada: TIntegerField
      DisplayLabel = 'Filter'
      DisplayWidth = 5
      FieldName = 'Filtrada'
      Origin = 'mensagens.Filtrada'
    end
    object Cds_MensAnexos: TIntegerField
      DisplayLabel = 'Attachs'
      DisplayWidth = 6
      FieldName = 'Anexos'
      Origin = 'mensagens.Anexos'
    end
    object Cds_MensEmitente: TStringField
      DisplayLabel = 'Sender'
      DisplayWidth = 37
      FieldName = 'Emitente'
      Origin = 'mensagens.Emitente'
      Size = 255
    end
    object Cds_MensAssunto: TStringField
      DisplayLabel = 'Subject'
      DisplayWidth = 37
      FieldName = 'Assunto'
      Origin = 'mensagens.Assunto'
      Size = 255
    end
    object Cds_MensTama: TIntegerField
      DisplayLabel = 'Bytes'
      DisplayWidth = 10
      FieldName = 'Tama'
      Origin = 'mensagens.Tama'
    end
    object Cds_MensDataOrig: TStringField
      DisplayLabel = 'Date'
      DisplayWidth = 37
      FieldName = 'DataOrig'
      Size = 255
    end
    object Cds_MensCabec: TMemoField
      DisplayLabel = 'Header'
      DisplayWidth = 37
      FieldName = 'Cabec'
      Origin = 'mensagens.Cabec'
      BlobType = ftMemo
    end
    object Cds_MensConta: TStringField
      DisplayLabel = 'Account'
      DisplayWidth = 10
      FieldName = 'Conta'
      Origin = 'mensagens.Conta'
      Size = 50
    end
    object Cds_MensNumeroMens: TIntegerField
      Alignment = taLeftJustify
      DisplayLabel = 'ID'
      DisplayWidth = 10
      FieldName = 'NumeroMens'
      Origin = 'mensagens.NumeroMens'
    end
    object Cds_MensDT: TDateTimeField
      Alignment = taRightJustify
      DisplayLabel = 'Date'
      DisplayWidth = 9
      FieldName = 'DT'
      Origin = 'mensagens.DT'
      Visible = False
    end
    object Cds_MensID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'mensagens.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Visible = False
    end
    object Cds_MensEmail: TStringField
      DisplayWidth = 38
      FieldName = 'Email'
      Origin = 'mensagens.Email'
      Visible = False
      Size = 200
    end
    object Cds_MensDatamens: TDateTimeField
      DisplayWidth = 18
      FieldName = 'Datamens'
      Origin = 'mensagens.Datamens'
      Visible = False
    end
    object Cds_MensCorpo: TMemoField
      DisplayWidth = 10
      FieldName = 'Corpo'
      Origin = 'mensagens.Corpo'
      Visible = False
      BlobType = ftMemo
    end
    object Cds_MensStatus: TIntegerField
      DisplayWidth = 10
      FieldName = 'Status'
      Origin = 'mensagens.Status'
      Visible = False
    end
    object Cds_MensListaNegra: TIntegerField
      DisplayWidth = 10
      FieldName = 'ListaNegra'
      Origin = 'mensagens.ListaNegra'
      Visible = False
    end
    object Cds_MensFavoritos: TIntegerField
      DisplayWidth = 10
      FieldName = 'Favoritos'
      Origin = 'mensagens.Favoritos'
      Visible = False
    end
    object Cds_MensFiltroResult: TMemoField
      DisplayWidth = 10
      FieldName = 'FiltroResult'
      Origin = 'mensagens.FiltroResult'
      Visible = False
      BlobType = ftMemo
    end
    object Cds_MensListaNegraResult: TMemoField
      DisplayWidth = 13
      FieldName = 'ListaNegraResult'
      Origin = 'mensagens.ListaNegraResult'
      Visible = False
      BlobType = ftMemo
    end
    object Cds_MensExcluida: TIntegerField
      DisplayWidth = 10
      FieldName = 'Excluida'
      Origin = 'mensagens.Excluida'
      Visible = False
    end
    object Cds_MensMsgId: TStringField
      FieldName = 'MsgId'
      Origin = 'mensagens.MsgId'
      Visible = False
      Size = 255
    end
    object Cds_MensIsBodyEmpty: TBooleanField
      DisplayWidth = 5
      FieldName = 'IsBodyEmpty'
      Visible = False
    end
    object Cds_MensUID: TStringField
      DisplayWidth = 255
      FieldName = 'UID'
      Visible = False
      Size = 255
    end
    object Cds_MensIsMsgSinglePartMime: TBooleanField
      DisplayWidth = 5
      FieldName = 'IsMsgSinglePartMime'
      Visible = False
    end
    object Cds_MensAttachmentEncoding: TStringField
      DisplayWidth = 255
      FieldName = 'AttachmentEncoding'
      Visible = False
      Size = 255
    end
    object Cds_MensCharSet: TStringField
      DisplayWidth = 255
      FieldName = 'CharSet'
      Visible = False
      Size = 255
    end
    object Cds_MensContentType: TStringField
      DisplayWidth = 255
      FieldName = 'ContentType'
      Visible = False
      Size = 255
    end
    object Cds_MensContentTransferEncoding: TStringField
      DisplayWidth = 255
      FieldName = 'ContentTransferEncoding'
      Visible = False
      Size = 255
    end
    object Cds_MensContentDisposition: TStringField
      DisplayWidth = 255
      FieldName = 'ContentDisposition'
      Visible = False
      Size = 255
    end
    object Cds_MensNoEncode: TBooleanField
      DisplayWidth = 5
      FieldName = 'NoEncode'
      Visible = False
    end
    object Cds_MensNoDecode: TBooleanField
      DisplayWidth = 5
      FieldName = 'NoDecode'
      Visible = False
    end
    object Cds_MensOrganization: TStringField
      DisplayWidth = 255
      FieldName = 'Organization'
      Visible = False
      Size = 255
    end
    object Cds_MensXmailer: TStringField
      DisplayWidth = 255
      FieldName = 'Xmailer'
      Visible = False
      Size = 255
    end
    object Cds_MensReplayTO: TStringField
      DisplayWidth = 255
      FieldName = 'ReplayTO'
      Visible = False
      Size = 255
    end
    object Cds_MensReturnPath: TStringField
      DisplayWidth = 255
      FieldName = 'ReturnPath'
      Visible = False
      Size = 255
    end
    object Cds_MensFromOrig: TStringField
      DisplayWidth = 255
      FieldName = 'FromOrig'
      Visible = False
      Size = 255
    end
    object Cds_MensToOrig: TStringField
      DisplayWidth = 255
      FieldName = 'ToOrig'
      Visible = False
      Size = 255
    end
    object Cds_MensCCOrig: TMemoField
      DisplayWidth = 10
      FieldName = 'CCOrig'
      Visible = False
      BlobType = ftMemo
    end
    object Cds_MensBCCOrig: TMemoField
      DisplayWidth = 10
      FieldName = 'BCCOrig'
      Visible = False
      BlobType = ftMemo
    end
    object Cds_MensReceivedFrom: TStringField
      DisplayWidth = 255
      FieldName = 'ReceivedFrom'
      Visible = False
      Size = 255
    end
  end
  object DS_qMens: TDataSource
    DataSet = Cds_Mens
    Left = 316
    Top = 72
  end
  object QupStatus: TMyQuery
    Connection = MC
    SQL.Strings = (
      'update messages set status = 1')
    Left = 112
    Top = 128
  end
  object QBoxes: TMyQuery
    Connection = MC
    SQL.Strings = (
      'select * from allboxes'
      'where TypeBox = :Box')
    Left = 112
    Top = 184
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'Box'
      end>
  end
  object Prov_Boxes: TDataSetProvider
    DataSet = QBoxes
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 176
    Top = 184
  end
  object cds_Boxes: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftUnknown
        Name = 'Box'
        ParamType = ptUnknown
      end>
    ProviderName = 'Prov_Boxes'
    Left = 248
    Top = 184
    object cds_BoxesItem: TStringField
      DisplayWidth = 20
      FieldName = 'Item'
      Size = 255
    end
    object cds_BoxesExpression: TStringField
      DisplayWidth = 30
      FieldName = 'Expression'
      Size = 255
    end
    object cds_BoxesMatchType: TStringField
      DisplayWidth = 3
      FieldName = 'MatchType'
      Size = 3
    end
    object cds_BoxesID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ID'
      Visible = False
    end
    object cds_BoxesTypeBox: TIntegerField
      DisplayWidth = 10
      FieldName = 'TypeBox'
      Visible = False
    end
    object cds_BoxesWhereFilter: TIntegerField
      DisplayWidth = 10
      FieldName = 'WhereFilter'
      Visible = False
    end
    object cds_BoxesFilterID: TIntegerField
      DisplayWidth = 10
      FieldName = 'FilterID'
      Visible = False
    end
    object cds_BoxesKind: TIntegerField
      DisplayWidth = 10
      FieldName = 'Kind'
      Visible = False
    end
    object cds_BoxesDT: TDateTimeField
      DisplayWidth = 18
      FieldName = 'DT'
      Visible = False
    end
    object cds_BoxesStatus: TIntegerField
      DisplayWidth = 10
      FieldName = 'Status'
      Visible = False
    end
  end
  object DS_qBoxes: TDataSource
    DataSet = cds_Boxes
    Left = 316
    Top = 184
  end
  object qveconta: TMyQuery
    Connection = MC
    SQL.Strings = (
      'SELECT '
      '  accounts.ID,'
      '  accounts.Nome'
      'FROM'
      '  accounts '
      '  '
      'where ID <> :ID and Nome = :Nome')
    Left = 392
    Top = 24
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end
      item
        DataType = ftUnknown
        Name = 'Nome'
      end>
    object qvecontaID: TIntegerField
      FieldName = 'ID'
    end
    object qvecontaNome: TStringField
      FieldName = 'Nome'
      Size = 50
    end
  end
  object qcabectmp: TMyQuery
    Connection = MC
    SQL.Strings = (
      'select * from tab_cabec_tmp'
      'where ID = :ID')
    Left = 104
    Top = 248
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ID'
      end>
  end
  object prov_qcabectmp: TDataSetProvider
    DataSet = qcabectmp
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 168
    Top = 248
  end
  object cds_CabecTmp: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftUnknown
        Name = 'ID'
        ParamType = ptUnknown
      end>
    ProviderName = 'prov_qcabectmp'
    Left = 240
    Top = 248
    object cds_CabecTmpFiltro: TBooleanField
      DisplayLabel = 'Make rule'
      DisplayWidth = 5
      FieldName = 'Filtro'
      Origin = 'tab_cabec_tmp.Filtro'
    end
    object cds_CabecTmpItem: TStringField
      DisplayWidth = 30
      FieldName = 'Item'
      Origin = 'tab_cabec_tmp.Item'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Size = 80
    end
    object cds_CabecTmpValor: TMemoField
      DisplayLabel = 'Value'
      DisplayWidth = 80
      FieldName = 'Valor'
      Origin = 'tab_cabec_tmp.Valor'
      BlobType = ftMemo
    end
    object cds_CabecTmpID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ID'
      Origin = 'tab_cabec_tmp.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Visible = False
    end
  end
  object ds_Cabectmp: TDataSource
    DataSet = cds_CabecTmp
    Left = 308
    Top = 248
  end
end

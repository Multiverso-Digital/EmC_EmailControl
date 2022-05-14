object DM: TDM
  OldCreateOrder = False
  Height = 395
  Width = 488
  object MC: TMyConnection
    Database = 'ar_projetos'
    Username = 'root'
    Password = 'aw1122'
    Server = '192.168.0.10'
    LoginPrompt = False
    Left = 32
    Top = 24
  end
  object qClientes: TMyQuery
    Connection = MC
    SQL.Strings = (
      'SELECT '
      '*'
      'FROM'
      '  tcliente')
    Left = 152
    Top = 24
    object qClientesID: TIntegerField
      AutoGenerateValue = arAutoInc
      DisplayWidth = 6
      FieldName = 'ID'
      Origin = 'tcliente.ID'
    end
    object qClientesCNPJ: TStringField
      DisplayWidth = 12
      FieldName = 'CNPJ'
      Origin = 'tcliente.CNPJ'
      Size = 14
    end
    object qClientesRazaoSocial: TStringField
      DisplayWidth = 32
      FieldName = 'RazaoSocial'
      Origin = 'tcliente.RazaoSocial'
      Size = 100
    end
    object qClientesApelido: TStringField
      DisplayWidth = 20
      FieldName = 'Apelido'
      Origin = 'tcliente.Apelido'
      Size = 50
    end
  end
  object MCPrj: TMyConnection
    Left = 32
    Top = 88
  end
  object ds_qclientes: TwwDataSource
    DataSet = qClientes
    Left = 208
    Top = 24
  end
end

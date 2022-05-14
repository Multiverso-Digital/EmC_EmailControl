object DM: TDM
  OldCreateOrder = False
  Height = 434
  Width = 481
  object MC: TMyConnection
    Database = 'emc'
    Username = 'root'
    Password = 'aw1122'
    Server = '192.168.0.10'
    Connected = True
    LoginPrompt = False
    Left = 64
    Top = 40
  end
  object QPais: TMyQuery
    Connection = MC
    SQL.Strings = (
      'SELECT '
      '  pais.sigla,'
      '  pais.PAIS,'
      '  pais.ID,'
      '  pais.IPNUMFROM,'
      '  pais.IPNUMTO'
      'FROM'
      '  pais'
      'where :Nume1 BETWEEN IPNUMFROM and IPNUMTO')
    Left = 120
    Top = 40
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'Nume1'
      end>
    object QPaissigla: TStringField
      FieldName = 'sigla'
      Size = 2
    end
    object QPaisPAIS: TStringField
      FieldName = 'PAIS'
      Size = 50
    end
    object QPaisID: TIntegerField
      FieldName = 'ID'
    end
    object QPaisIPNUMFROM: TLargeintField
      FieldName = 'IPNUMFROM'
    end
    object QPaisIPNUMTO: TLargeintField
      FieldName = 'IPNUMTO'
    end
  end
  object prov_Qpais: TDataSetProvider
    DataSet = QPais
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 168
    Top = 40
  end
end

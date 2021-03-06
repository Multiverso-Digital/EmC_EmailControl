object DM_SERVER: TDM_SERVER
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 757
  Width = 712
  object DS_qMens: TDataSource
    DataSet = cds_mens
    Left = 92
    Top = 136
  end
  object ds_Cabectmp: TDataSource
    DataSet = cds_CabecTmp
    Left = 324
    Top = 264
  end
  object ds_MostraBoxes: TDataSource
    DataSet = qmostraBoxes
    Left = 340
    Top = 200
  end
  object ds_MostraFG: TDataSource
    Left = 428
    Top = 200
  end
  object cds_AllM: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftUnknown
        Name = 'ID'
        ParamType = ptUnknown
      end>
    ProviderName = 'prov_allM'
    Left = 96
    Top = 24
    object cds_AllMselecionada: TIntegerField
      FieldName = 'selecionada'
    end
    object cds_AllMFiltrada: TIntegerField
      FieldName = 'Filtrada'
    end
    object cds_AllMAnexos: TIntegerField
      FieldName = 'Anexos'
    end
    object cds_AllMConta: TWideStringField
      FieldName = 'Conta'
      Size = 50
    end
    object cds_AllMNumeroMens: TIntegerField
      FieldName = 'NumeroMens'
    end
    object cds_AllMEmitente: TWideStringField
      FieldName = 'Emitente'
      Size = 255
    end
    object cds_AllMAssunto: TWideStringField
      FieldName = 'Assunto'
      Size = 255
    end
    object cds_AllMTama: TIntegerField
      FieldName = 'Tama'
    end
    object cds_AllMDataOrig: TWideStringField
      FieldName = 'DataOrig'
      Size = 255
    end
    object cds_AllMIPSender: TWideStringField
      FieldName = 'IPSender'
      Size = 15
    end
    object cds_AllMCountry: TWideStringField
      FieldName = 'Country'
      Size = 50
    end
    object cds_AllMID1: TLargeintField
      FieldName = 'ID1'
    end
    object cds_AllMDT: TDateTimeField
      FieldName = 'DT'
    end
    object cds_AllMEmail: TWideStringField
      FieldName = 'Email'
      Size = 200
    end
    object cds_AllMDatamens: TWideStringField
      FieldName = 'Datamens'
    end
    object cds_AllMCabec: TWideMemoField
      FieldName = 'Cabec'
      BlobType = ftWideMemo
    end
    object cds_AllMCorpo: TWideMemoField
      FieldName = 'Corpo'
      BlobType = ftWideMemo
    end
    object cds_AllMListaNegra: TIntegerField
      FieldName = 'ListaNegra'
    end
    object cds_AllMFavoritos: TIntegerField
      FieldName = 'Favoritos'
    end
    object cds_AllMFiltroResult: TWideMemoField
      FieldName = 'FiltroResult'
      BlobType = ftWideMemo
    end
    object cds_AllMExcluida: TIntegerField
      FieldName = 'Excluida'
    end
    object cds_AllMUID: TWideStringField
      FieldName = 'UID'
      Size = 255
    end
    object cds_AllMXmailer: TWideStringField
      FieldName = 'Xmailer'
      Size = 255
    end
    object cds_AllMReceivedFrom: TWideStringField
      FieldName = 'ReceivedFrom'
      Size = 255
    end
    object cds_AllMEmailFrom: TWideStringField
      FieldName = 'EmailFrom'
      Size = 255
    end
    object cds_AllMDominioFrom: TWideStringField
      FieldName = 'DominioFrom'
      Size = 255
    end
    object cds_AllMID_Conta: TIntegerField
      FieldName = 'ID_Conta'
    end
    object cds_AllMAnexosFiles: TWideMemoField
      FieldName = 'AnexosFiles'
      BlobType = ftWideMemo
    end
    object cds_AllMlida: TIntegerField
      FieldName = 'lida'
    end
    object cds_AllMCorpoTexto: TWideMemoField
      FieldName = 'CorpoTexto'
      BlobType = ftWideMemo
    end
    object cds_AllMMSG_REF: TIntegerField
      FieldName = 'MSG_REF'
    end
    object cds_AllMpalavrasBaysean: TWideMemoField
      FieldName = 'palavrasBaysean'
      BlobType = ftWideMemo
      Size = 400
    end
    object cds_AllMaprendeu: TIntegerField
      FieldName = 'aprendeu'
    end
  end
  object DS_AllM: TDataSource
    DataSet = cds_AllM
    Left = 156
    Top = 24
  end
  object DS_qContas: TDataSource
    DataSet = cds_Contas
    Left = 92
    Top = 80
  end
  object cds_mens: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 24
    Top = 136
    object cds_mensselecionada: TIntegerField
      DisplayLabel = 'SEL'
      DisplayWidth = 5
      FieldName = 'selecionada'
    end
    object cds_mensFiltrada: TIntegerField
      DisplayLabel = 'Filter'
      DisplayWidth = 5
      FieldName = 'Filtrada'
    end
    object cds_mensAnexos: TIntegerField
      DisplayLabel = 'Attach'
      DisplayWidth = 5
      FieldName = 'Anexos'
    end
    object cds_mensConta: TWideStringField
      DisplayLabel = 'Account'
      DisplayWidth = 10
      FieldName = 'Conta'
      Size = 50
    end
    object cds_mensNumeroMens: TIntegerField
      DisplayLabel = 'ID'
      DisplayWidth = 5
      FieldName = 'NumeroMens'
    end
    object cds_mensEmitente: TWideStringField
      DisplayLabel = 'From'
      DisplayWidth = 30
      FieldName = 'Emitente'
      Size = 255
    end
    object cds_mensAssunto: TWideStringField
      DisplayLabel = 'Subject'
      DisplayWidth = 30
      FieldName = 'Assunto'
      Size = 255
    end
    object cds_mensTama: TIntegerField
      DisplayLabel = 'KB'
      DisplayWidth = 5
      FieldName = 'Tama'
    end
    object cds_mensDataOrig: TWideStringField
      DisplayLabel = 'Date'
      DisplayWidth = 20
      FieldName = 'DataOrig'
      Size = 255
    end
    object cds_mensIPSender: TWideStringField
      DisplayWidth = 15
      FieldName = 'IPSender'
      Size = 15
    end
    object cds_mensCountry: TWideStringField
      DisplayWidth = 15
      FieldName = 'Country'
      Size = 50
    end
    object cds_mensID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'ID'
      ReadOnly = True
      Visible = False
    end
    object cds_mensDT: TDateTimeField
      DisplayWidth = 18
      FieldName = 'DT'
      Visible = False
    end
    object cds_mensEmail: TWideStringField
      DisplayWidth = 200
      FieldName = 'Email'
      Visible = False
      Size = 200
    end
    object cds_mensDatamens: TWideStringField
      DisplayWidth = 20
      FieldName = 'Datamens'
      Visible = False
    end
    object cds_mensCabec: TWideMemoField
      DisplayWidth = 10
      FieldName = 'Cabec'
      Visible = False
      BlobType = ftWideMemo
      Size = 400
    end
    object cds_mensCorpo: TWideMemoField
      DisplayWidth = 10
      FieldName = 'Corpo'
      Visible = False
      BlobType = ftWideMemo
      Size = 400
    end
    object cds_mensListaNegra: TIntegerField
      DisplayWidth = 10
      FieldName = 'ListaNegra'
      Visible = False
    end
    object cds_mensFavoritos: TIntegerField
      DisplayWidth = 10
      FieldName = 'Favoritos'
      Visible = False
    end
    object cds_mensFiltroResult: TWideMemoField
      DisplayWidth = 10
      FieldName = 'FiltroResult'
      Visible = False
      BlobType = ftWideMemo
      Size = 400
    end
    object cds_mensExcluida: TIntegerField
      DisplayWidth = 10
      FieldName = 'Excluida'
      Visible = False
    end
    object cds_mensUID: TWideStringField
      DisplayWidth = 255
      FieldName = 'UID'
      Visible = False
      Size = 255
    end
    object cds_mensXmailer: TWideStringField
      DisplayWidth = 255
      FieldName = 'Xmailer'
      Visible = False
      Size = 255
    end
    object cds_mensReceivedFrom: TWideStringField
      DisplayWidth = 255
      FieldName = 'ReceivedFrom'
      Visible = False
      Size = 255
    end
    object cds_mensEmailFrom: TWideStringField
      DisplayWidth = 255
      FieldName = 'EmailFrom'
      Visible = False
      Size = 255
    end
    object cds_mensDominioFrom: TWideStringField
      DisplayWidth = 255
      FieldName = 'DominioFrom'
      Visible = False
      Size = 255
    end
    object cds_mensID_Conta: TIntegerField
      DisplayWidth = 10
      FieldName = 'ID_Conta'
      Visible = False
    end
    object cds_mensAnexosFiles: TWideMemoField
      DisplayWidth = 10
      FieldName = 'AnexosFiles'
      Visible = False
      BlobType = ftWideMemo
      Size = 400
    end
    object cds_menslida: TIntegerField
      DisplayWidth = 10
      FieldName = 'lida'
      Visible = False
    end
    object cds_mensCorpoTexto: TWideMemoField
      DisplayWidth = 10
      FieldName = 'CorpoTexto'
      Visible = False
      BlobType = ftWideMemo
      Size = 400
    end
    object cds_mensMSG_REF: TIntegerField
      DisplayWidth = 10
      FieldName = 'MSG_REF'
      Visible = False
    end
    object cds_menspalavrasBaysean: TWideMemoField
      DisplayWidth = 10
      FieldName = 'palavrasBaysean'
      Visible = False
      BlobType = ftWideMemo
      Size = 400
    end
    object cds_mensaprendeu: TIntegerField
      DisplayWidth = 10
      FieldName = 'aprendeu'
      Visible = False
    end
  end
  object cds_IPSpam_Local: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'IPDecimal'
    Params = <>
    Left = 640
    Top = 40
    object cds_IPSpam_LocalIPDecimal: TLargeintField
      FieldName = 'IPDecimal'
    end
    object cds_IPSpam_LocalIP: TWideStringField
      FieldName = 'IP'
      Size = 15
    end
    object cds_IPSpam_LocalDT: TDateTimeField
      FieldName = 'DT'
    end
    object cds_IPSpam_LocalQTD: TIntegerField
      FieldName = 'QTD'
    end
  end
  object cds_IpSpam_Server: TClientDataSet
    Aggregates = <>
    AutoCalcFields = False
    Params = <
      item
        DataType = ftLargeint
        Name = 'PIPDecimal'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'PIP'
        ParamType = ptInput
      end
      item
        DataType = ftLargeint
        Name = 'PQTD'
        ParamType = ptInput
      end>
    ProviderName = 'prov_IPSpam'
    RemoteServer = Qsoap
    OnReconcileError = cds_IpSpam_ServerReconcileError
    Left = 638
    Top = 144
    object cds_IpSpam_ServerIPDecimal: TLargeintField
      FieldName = 'IPDecimal'
      Origin = 'ipspam.IPDecimal'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object cds_IpSpam_ServerIP: TStringField
      FieldName = 'IP'
      Origin = 'ipspam.IP'
      Size = 15
    end
    object cds_IpSpam_ServerQTD: TLargeintField
      FieldName = 'QTD'
      Origin = 'ipspam.QTD'
    end
  end
  object cds_Sigla: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'Sigla'
    Params = <>
    Left = 24
    Top = 248
    object cds_SiglaSigla: TWideStringField
      FieldName = 'Sigla'
      Size = 3
    end
    object cds_SiglaPais: TWideStringField
      FieldName = 'Pais'
      Size = 50
    end
    object cds_SiglaFiltro: TIntegerField
      FieldName = 'Filtro'
    end
  end
  object DS_Sigla: TDataSource
    DataSet = cds_Sigla
    Left = 72
    Top = 248
  end
  object cds_Dns: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 264
    Top = 24
    object cds_DnsID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object cds_DnsName: TWideStringField
      FieldName = 'Name'
    end
    object cds_Dnsdns: TWideStringField
      FieldName = 'dns'
      Size = 255
    end
    object cds_Dnsactive: TIntegerField
      FieldName = 'active'
    end
    object cds_DnsDT: TDateTimeField
      FieldName = 'DT'
    end
  end
  object ds_cds_dns: TDataSource
    DataSet = cds_Dns
    Left = 320
    Top = 24
  end
  object qsetup: TClientDataSet
    Aggregates = <>
    FileName = 'K:\@Projetos_em_andamento\EmC2011_Thread\Dados\setup.cds'
    Params = <>
    Left = 264
    Top = 80
    object qsetupID: TIntegerField
      FieldName = 'ID'
    end
    object qsetupBayesian: TIntegerField
      FieldName = 'Bayesian'
    end
    object qsetupMyFriends: TIntegerField
      FieldName = 'MyFriends'
    end
    object qsetupBlackList: TIntegerField
      FieldName = 'BlackList'
    end
    object qsetupDNS: TIntegerField
      FieldName = 'DNS'
    end
    object qsetupCountries: TIntegerField
      FieldName = 'Countries'
    end
    object qsetupDT: TDateTimeField
      FieldName = 'DT'
    end
    object qsetupFilter: TIntegerField
      FieldName = 'Filter'
    end
    object qsetupminutes: TIntegerField
      FieldName = 'minutes'
    end
    object qsetupIPdns: TWideStringField
      FieldName = 'IPdns'
      Size = 15
    end
    object qsetupvalorBaysean: TFloatField
      FieldName = 'valorBaysean'
    end
    object qsetupQTDOK: TLargeintField
      FieldName = 'QTDOK'
    end
    object qsetupQTDBad: TLargeintField
      FieldName = 'QTDBad'
    end
    object qsetupFastDelete: TIntegerField
      FieldName = 'FastDelete'
    end
  end
  object ds_Qsetup: TDataSource
    DataSet = qsetup
    Left = 320
    Top = 80
  end
  object ds_boxes: TDataSource
    DataSet = cds_boxes
    Left = 88
    Top = 192
  end
  object cds_boxes: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'TypeBox;WhereFilter;FilterID;Kind'
    Params = <>
    Left = 24
    Top = 192
    object cds_boxesNameRule: TWideStringField
      DisplayWidth = 20
      FieldName = 'NameRule'
      Size = 255
    end
    object cds_boxesItem: TWideStringField
      DisplayWidth = 20
      FieldName = 'Item'
      Size = 255
    end
    object cds_boxesExpression: TWideStringField
      DisplayWidth = 50
      FieldName = 'Expression'
      Size = 500
    end
    object cds_boxesMatchType: TWideStringField
      DisplayWidth = 3
      FieldName = 'MatchType'
      Size = 3
    end
    object cds_boxesID: TAutoIncField
      DisplayWidth = 10
      FieldName = 'ID'
      ReadOnly = True
      Visible = False
    end
    object cds_boxesTypeBox: TIntegerField
      DisplayWidth = 10
      FieldName = 'TypeBox'
      Visible = False
    end
    object cds_boxesWhereFilter: TIntegerField
      DisplayWidth = 10
      FieldName = 'WhereFilter'
      Visible = False
    end
    object cds_boxesFilterID: TIntegerField
      DisplayWidth = 10
      FieldName = 'FilterID'
      Visible = False
    end
    object cds_boxesKind: TIntegerField
      DisplayWidth = 10
      FieldName = 'Kind'
      Visible = False
    end
    object cds_boxesDT: TDateTimeField
      DisplayWidth = 18
      FieldName = 'DT'
      Visible = False
    end
    object cds_boxesStatus: TIntegerField
      DisplayWidth = 10
      FieldName = 'Status'
      Visible = False
    end
    object cds_boxescountmacths: TLargeintField
      DisplayWidth = 15
      FieldName = 'countmacths'
      Visible = False
    end
  end
  object cds_CabecTmp: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 256
    Top = 264
    object cds_CabecTmpFiltro: TIntegerField
      DisplayLabel = 'Filter'
      DisplayWidth = 5
      FieldName = 'Filtro'
    end
    object cds_CabecTmpItem: TWideStringField
      DisplayWidth = 20
      FieldName = 'Item'
      Size = 80
    end
    object cds_CabecTmpValor: TWideStringField
      DisplayLabel = 'Value'
      DisplayWidth = 90
      FieldName = 'Valor'
      Size = 6000
    end
    object cds_CabecTmpID: TLargeintField
      DisplayWidth = 15
      FieldName = 'ID'
      Visible = False
    end
    object cds_CabecTmpDT: TDateTimeField
      DisplayWidth = 18
      FieldName = 'DT'
      Visible = False
    end
  end
  object qIdioma: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 264
    Top = 136
    object qIdiomaID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object qIdiomapais: TWideStringField
      FieldName = 'pais'
      Size = 2
    end
    object qIdiomaFormNome: TWideStringField
      FieldName = 'FormNome'
      Size = 50
    end
    object qIdiomaComponente: TWideStringField
      FieldName = 'Componente'
      Size = 50
    end
    object qIdiomaPropiedade: TWideStringField
      FieldName = 'Propiedade'
      Size = 50
    end
    object qIdiomaValor: TWideStringField
      FieldName = 'Valor'
      Size = 255
    end
  end
  object cds_Contas: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 24
    Top = 80
    object cds_ContasID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object cds_ContasNome: TWideStringField
      FieldName = 'Nome'
      Size = 50
    end
    object cds_ContasPOP: TWideStringField
      FieldName = 'POP'
      Size = 200
    end
    object cds_ContasSMTP: TWideStringField
      FieldName = 'SMTP'
      Size = 200
    end
    object cds_ContasPorta: TIntegerField
      FieldName = 'Porta'
    end
    object cds_ContasUsuario: TWideStringField
      FieldName = 'Usuario'
      Size = 200
    end
    object cds_ContasSenha: TWideStringField
      FieldName = 'Senha'
      Size = 50
    end
    object cds_ContasEmail: TWideStringField
      FieldName = 'Email'
      Size = 200
    end
    object cds_ContasSMTPautentica: TIntegerField
      FieldName = 'SMTPautentica'
    end
    object cds_ContasSMTPusuario: TWideStringField
      FieldName = 'SMTPusuario'
      Size = 50
    end
    object cds_ContasSMTPSenha: TWideStringField
      FieldName = 'SMTPSenha'
      Size = 50
    end
    object cds_ContasSMTPPorta: TIntegerField
      FieldName = 'SMTPPorta'
    end
    object cds_ContasAtivada: TIntegerField
      FieldName = 'Ativada'
    end
    object cds_ContasExcluida: TIntegerField
      FieldName = 'Excluida'
    end
    object cds_ContasDTALT: TDateTimeField
      FieldName = 'DTALT'
    end
    object cds_ContasTipo: TWideStringField
      FieldName = 'Tipo'
    end
    object cds_ContasSSL: TIntegerField
      FieldName = 'SSL'
    end
    object cds_ContasAutentica: TIntegerField
      FieldName = 'Autentica'
    end
    object cds_ContasLeBody: TIntegerField
      FieldName = 'LeBody'
    end
    object cds_ContasProxiServer: TWideStringField
      FieldName = 'ProxiServer'
      Size = 255
    end
    object cds_ContasProxiPorta: TIntegerField
      FieldName = 'ProxiPorta'
    end
    object cds_ContasHotMailServer: TIntegerField
      FieldName = 'HotMailServer'
    end
    object cds_ContasGUID: TWideStringField
      FieldName = 'GUID'
      Size = 50
    end
  end
  object qmostraBoxes: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 264
    Top = 200
  end
  object Qsoap: TSoapConnection
    Agent = 'Borland SOAP 1.2'
    Connected = True
    URL = 'http://69.64.64.125/EmCService/EmCService.dll/soap/IDM'
    SOAPServerIID = 'IAppServerSOAP - {C99F4735-D6D2-495C-8CA2-E53E5A439E61}'
    UseSOAPAdapter = True
    Left = 640
    Top = 88
  end
  object cds_pais: TClientDataSet
    Aggregates = <>
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'cds_paisIndex1'
        Fields = 'IPNUMFROM;IPNUMTO'
        Options = [ixPrimary]
      end>
    IndexName = 'cds_paisIndex1'
    Params = <>
    StoreDefs = True
    Left = 24
    Top = 24
    object cds_paisIPNUMFROM: TLargeintField
      FieldName = 'IPNUMFROM'
    end
    object cds_paisIPNUMTO: TLargeintField
      FieldName = 'IPNUMTO'
    end
    object cds_paissigla: TWideStringField
      FieldName = 'sigla'
      Size = 2
    end
    object cds_paismpais: TWideStringField
      FieldName = 'mpais'
      Size = 50
    end
    object cds_paisID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
  end
end

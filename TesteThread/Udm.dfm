object DM: TDM
  OldCreateOrder = False
  Height = 638
  Width = 725
  object MC: TMyConnection
    Database = 'emc'
    Options.UseUnicode = True
    Options.NumericType = ntFmtBCD
    Username = 'root'
    Password = 'aw1122'
    Server = '192.168.0.10'
    Connected = True
    LoginPrompt = False
    Left = 40
    Top = 16
  end
  object POP: TIdPOP3
    IOHandler = IdIOHandlerStack1
    AutoLogin = True
    Host = 'abreuretto.com'
    Username = 'abreu@abreu retto informatica'
    Password = 'aw112233'
    SASLMechanisms = <>
    Left = 32
    Top = 112
  end
  object IdAntiFreeze1: TIdAntiFreeze
    Left = 96
    Top = 112
  end
  object MSG: TIdMessage
    AttachmentEncoding = 'UUE'
    BccList = <>
    CCList = <>
    Encoding = meDefault
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 168
    Top = 112
  end
  object IDT: TIdThreadComponent
    Active = False
    Loop = False
    Priority = tpNormal
    StopMode = smTerminate
    ThreadName = 'Minha1'
    Left = 240
    Top = 112
  end
  object IdPool: TIdSchedulerOfThreadPool
    MaxThreads = 16
    Left = 328
    Top = 112
  end
  object DataSource1: TDataSource
    DataSet = Tmem
    Left = 200
    Top = 16
  end
  object Tmem: TMyQuery
    SQLInsert.Strings = (
      'INSERT INTO messages_thread'
      
        '  (ID, DT, Email, Assunto, Emitente, Tama, Datamens, Cabec, Corp' +
        'o, Status, Filtrada, ListaNegra, Favoritos, FiltroResult, ListaN' +
        'egraResult, NumeroMens, Excluida, Anexos, selecionada, Conta, Ms' +
        'gId, IsBodyEmpty, UID, IsMsgSinglePartMime, AttachmentEncoding, ' +
        'CharSet, ContentType, ContentTransferEncoding, ContentDispositio' +
        'n, NoEncode, NoDecode, Organization, DataOrig, Xmailer, ReplayTO' +
        ', ReturnPath, FromOrig, ToOrig, CCOrig, BCCOrig, ReceivedFrom, F' +
        'riendResult, EmailFrom, DominioFrom, IPSender, ID_Conta, AnexosF' +
        'iles, Country, lida)'
      'VALUES'
      
        '  (:ID, :DT, :Email, :Assunto, :Emitente, :Tama, :Datamens, :Cab' +
        'ec, :Corpo, :Status, :Filtrada, :ListaNegra, :Favoritos, :Filtro' +
        'Result, :ListaNegraResult, :NumeroMens, :Excluida, :Anexos, :sel' +
        'ecionada, :Conta, :MsgId, :IsBodyEmpty, :UID, :IsMsgSinglePartMi' +
        'me, :AttachmentEncoding, :CharSet, :ContentType, :ContentTransfe' +
        'rEncoding, :ContentDisposition, :NoEncode, :NoDecode, :Organizat' +
        'ion, :DataOrig, :Xmailer, :ReplayTO, :ReturnPath, :FromOrig, :To' +
        'Orig, :CCOrig, :BCCOrig, :ReceivedFrom, :FriendResult, :EmailFro' +
        'm, :DominioFrom, :IPSender, :ID_Conta, :AnexosFiles, :Country, :' +
        'lida)')
    SQLDelete.Strings = (
      'DELETE FROM messages_thread'
      'WHERE'
      '  ID = :Old_ID')
    SQLUpdate.Strings = (
      'UPDATE messages_thread'
      'SET'
      
        '  ID = :ID, DT = :DT, Email = :Email, Assunto = :Assunto, Emiten' +
        'te = :Emitente, Tama = :Tama, Datamens = :Datamens, Cabec = :Cab' +
        'ec, Corpo = :Corpo, Status = :Status, Filtrada = :Filtrada, List' +
        'aNegra = :ListaNegra, Favoritos = :Favoritos, FiltroResult = :Fi' +
        'ltroResult, ListaNegraResult = :ListaNegraResult, NumeroMens = :' +
        'NumeroMens, Excluida = :Excluida, Anexos = :Anexos, selecionada ' +
        '= :selecionada, Conta = :Conta, MsgId = :MsgId, IsBodyEmpty = :I' +
        'sBodyEmpty, UID = :UID, IsMsgSinglePartMime = :IsMsgSinglePartMi' +
        'me, AttachmentEncoding = :AttachmentEncoding, CharSet = :CharSet' +
        ', ContentType = :ContentType, ContentTransferEncoding = :Content' +
        'TransferEncoding, ContentDisposition = :ContentDisposition, NoEn' +
        'code = :NoEncode, NoDecode = :NoDecode, Organization = :Organiza' +
        'tion, DataOrig = :DataOrig, Xmailer = :Xmailer, ReplayTO = :Repl' +
        'ayTO, ReturnPath = :ReturnPath, FromOrig = :FromOrig, ToOrig = :' +
        'ToOrig, CCOrig = :CCOrig, BCCOrig = :BCCOrig, ReceivedFrom = :Re' +
        'ceivedFrom, FriendResult = :FriendResult, EmailFrom = :EmailFrom' +
        ', DominioFrom = :DominioFrom, IPSender = :IPSender, ID_Conta = :' +
        'ID_Conta, AnexosFiles = :AnexosFiles, Country = :Country, lida =' +
        ' :lida'
      'WHERE'
      '  ID = :Old_ID')
    SQLRefresh.Strings = (
      
        'SELECT messages_thread.ID, messages_thread.DT, messages_thread.E' +
        'mail, messages_thread.Assunto, messages_thread.Emitente, message' +
        's_thread.Tama, messages_thread.Datamens, messages_thread.Cabec, ' +
        'messages_thread.Corpo, messages_thread.Status, messages_thread.F' +
        'iltrada, messages_thread.ListaNegra, messages_thread.Favoritos, ' +
        'messages_thread.FiltroResult, messages_thread.ListaNegraResult, ' +
        'messages_thread.NumeroMens, messages_thread.Excluida, messages_t' +
        'hread.Anexos, messages_thread.selecionada, messages_thread.Conta' +
        ', messages_thread.MsgId, messages_thread.IsBodyEmpty, messages_t' +
        'hread.UID, messages_thread.IsMsgSinglePartMime, messages_thread.' +
        'AttachmentEncoding, messages_thread.CharSet, messages_thread.Con' +
        'tentType, messages_thread.ContentTransferEncoding, messages_thre' +
        'ad.ContentDisposition, messages_thread.NoEncode, messages_thread' +
        '.NoDecode, messages_thread.Organization, messages_thread.DataOri' +
        'g, messages_thread.Xmailer, messages_thread.ReplayTO, messages_t' +
        'hread.ReturnPath, messages_thread.FromOrig, messages_thread.ToOr' +
        'ig, messages_thread.CCOrig, messages_thread.BCCOrig, messages_th' +
        'read.ReceivedFrom, messages_thread.FriendResult, messages_thread' +
        '.EmailFrom, messages_thread.DominioFrom, messages_thread.IPSende' +
        'r, messages_thread.ID_Conta, messages_thread.AnexosFiles, messag' +
        'es_thread.Country, messages_thread.lida FROM messages_thread'
      'WHERE'
      '  messages_thread.ID = :Old_ID')
    Connection = MC
    SQL.Strings = (
      'select '
      '*'
      'from '
      '  messages_thread'
      'order by ID')
    CachedUpdates = True
    AutoCalcFields = False
    Left = 120
    Top = 16
    object TmemID: TLargeintField
      DisplayWidth = 15
      FieldName = 'ID'
    end
    object TmemDT: TDateTimeField
      DisplayWidth = 18
      FieldName = 'DT'
    end
    object TmemEmail: TWideStringField
      DisplayWidth = 10
      FieldName = 'Email'
      Size = 200
    end
    object TmemAssunto: TWideStringField
      DisplayWidth = 10
      FieldName = 'Assunto'
      Size = 255
    end
    object TmemEmitente: TWideStringField
      DisplayWidth = 10
      FieldName = 'Emitente'
      Size = 255
    end
    object TmemListaNegra: TIntegerField
      DisplayWidth = 10
      FieldName = 'ListaNegra'
    end
    object TmemFavoritos: TIntegerField
      DisplayWidth = 10
      FieldName = 'Favoritos'
    end
    object TmemFiltroResult: TWideMemoField
      DisplayWidth = 10
      FieldName = 'FiltroResult'
      BlobType = ftWideMemo
    end
    object TmemIPSender: TWideStringField
      DisplayWidth = 15
      FieldName = 'IPSender'
      Size = 15
    end
    object TmemAnexos: TIntegerField
      DisplayWidth = 10
      FieldName = 'Anexos'
      Visible = False
    end
    object Tmemselecionada: TIntegerField
      DisplayWidth = 10
      FieldName = 'selecionada'
      Visible = False
    end
    object TmemTama: TIntegerField
      DisplayWidth = 10
      FieldName = 'Tama'
      Visible = False
    end
    object TmemDatamens: TDateTimeField
      DisplayWidth = 18
      FieldName = 'Datamens'
      Visible = False
    end
    object TmemCabec: TWideMemoField
      DisplayWidth = 10
      FieldName = 'Cabec'
      Visible = False
      BlobType = ftWideMemo
    end
    object TmemCorpo: TWideMemoField
      DisplayWidth = 10
      FieldName = 'Corpo'
      Visible = False
      BlobType = ftWideMemo
    end
    object TmemStatus: TIntegerField
      DisplayWidth = 10
      FieldName = 'Status'
      Visible = False
    end
    object TmemFiltrada: TIntegerField
      DisplayWidth = 10
      FieldName = 'Filtrada'
      Visible = False
    end
    object TmemListaNegraResult: TWideMemoField
      DisplayWidth = 10
      FieldName = 'ListaNegraResult'
      Visible = False
      BlobType = ftWideMemo
    end
    object TmemNumeroMens: TIntegerField
      DisplayWidth = 10
      FieldName = 'NumeroMens'
      Visible = False
    end
    object TmemExcluida: TIntegerField
      DisplayWidth = 10
      FieldName = 'Excluida'
      Visible = False
    end
    object TmemConta: TWideStringField
      DisplayWidth = 50
      FieldName = 'Conta'
      Visible = False
      Size = 50
    end
    object TmemMsgId: TWideStringField
      DisplayWidth = 255
      FieldName = 'MsgId'
      Visible = False
      Size = 255
    end
    object TmemIsBodyEmpty: TBooleanField
      DisplayWidth = 5
      FieldName = 'IsBodyEmpty'
      Visible = False
    end
    object TmemUID: TWideStringField
      DisplayWidth = 255
      FieldName = 'UID'
      Visible = False
      Size = 255
    end
    object TmemIsMsgSinglePartMime: TBooleanField
      DisplayWidth = 5
      FieldName = 'IsMsgSinglePartMime'
      Visible = False
    end
    object TmemAttachmentEncoding: TWideStringField
      DisplayWidth = 255
      FieldName = 'AttachmentEncoding'
      Visible = False
      Size = 255
    end
    object TmemCharSet: TWideStringField
      DisplayWidth = 255
      FieldName = 'CharSet'
      Visible = False
      Size = 255
    end
    object TmemContentType: TWideStringField
      DisplayWidth = 255
      FieldName = 'ContentType'
      Visible = False
      Size = 255
    end
    object TmemContentTransferEncoding: TWideStringField
      DisplayWidth = 255
      FieldName = 'ContentTransferEncoding'
      Visible = False
      Size = 255
    end
    object TmemContentDisposition: TWideStringField
      DisplayWidth = 255
      FieldName = 'ContentDisposition'
      Visible = False
      Size = 255
    end
    object TmemNoEncode: TBooleanField
      DisplayWidth = 5
      FieldName = 'NoEncode'
      Visible = False
    end
    object TmemNoDecode: TBooleanField
      DisplayWidth = 5
      FieldName = 'NoDecode'
      Visible = False
    end
    object TmemOrganization: TWideStringField
      DisplayWidth = 255
      FieldName = 'Organization'
      Visible = False
      Size = 255
    end
    object TmemDataOrig: TWideStringField
      DisplayWidth = 255
      FieldName = 'DataOrig'
      Visible = False
      Size = 255
    end
    object TmemXmailer: TWideStringField
      DisplayWidth = 255
      FieldName = 'Xmailer'
      Visible = False
      Size = 255
    end
    object TmemReplayTO: TWideStringField
      DisplayWidth = 255
      FieldName = 'ReplayTO'
      Visible = False
      Size = 255
    end
    object TmemReturnPath: TWideStringField
      DisplayWidth = 255
      FieldName = 'ReturnPath'
      Visible = False
      Size = 255
    end
    object TmemFromOrig: TWideStringField
      DisplayWidth = 255
      FieldName = 'FromOrig'
      Visible = False
      Size = 255
    end
    object TmemToOrig: TWideStringField
      DisplayWidth = 255
      FieldName = 'ToOrig'
      Visible = False
      Size = 255
    end
    object TmemCCOrig: TWideMemoField
      DisplayWidth = 10
      FieldName = 'CCOrig'
      Visible = False
      BlobType = ftWideMemo
    end
    object TmemBCCOrig: TWideMemoField
      DisplayWidth = 10
      FieldName = 'BCCOrig'
      Visible = False
      BlobType = ftWideMemo
    end
    object TmemReceivedFrom: TWideStringField
      DisplayWidth = 255
      FieldName = 'ReceivedFrom'
      Visible = False
      Size = 255
    end
    object TmemFriendResult: TWideMemoField
      DisplayWidth = 10
      FieldName = 'FriendResult'
      Visible = False
      BlobType = ftWideMemo
    end
    object TmemEmailFrom: TWideStringField
      DisplayWidth = 255
      FieldName = 'EmailFrom'
      Visible = False
      Size = 255
    end
    object TmemDominioFrom: TWideStringField
      DisplayWidth = 255
      FieldName = 'DominioFrom'
      Visible = False
      Size = 255
    end
    object TmemID_Conta: TIntegerField
      DisplayWidth = 10
      FieldName = 'ID_Conta'
      Visible = False
    end
    object TmemAnexosFiles: TWideMemoField
      DisplayWidth = 10
      FieldName = 'AnexosFiles'
      Visible = False
      BlobType = ftWideMemo
    end
    object TmemCountry: TWideStringField
      DisplayWidth = 50
      FieldName = 'Country'
      Visible = False
      Size = 50
    end
    object Tmemlida: TIntegerField
      DisplayWidth = 10
      FieldName = 'lida'
      Visible = False
    end
  end
  object qdns: TMyQuery
    SQLInsert.Strings = (
      'INSERT INTO dns'
      '  (ID, Name, dns, active)'
      'VALUES'
      '  (:ID, :Name, :dns, :active)')
    SQLDelete.Strings = (
      'DELETE FROM dns'
      'WHERE'
      '  ID = :Old_ID')
    SQLUpdate.Strings = (
      'UPDATE dns'
      'SET'
      '  ID = :ID, Name = :Name, dns = :dns, active = :active'
      'WHERE'
      '  ID = :Old_ID')
    SQLRefresh.Strings = (
      'SELECT dns.ID, dns.Name, dns.dns, dns.active FROM dns'
      'WHERE'
      '  dns.ID = :Old_ID')
    Connection = MC
    SQL.Strings = (
      'SELECT '
      '  dns.ID,'
      '  dns.Name,'
      '  dns.dns,'
      '  dns.active'
      'FROM'
      '  dns')
    CachedUpdates = True
    Left = 40
    Top = 184
    object qdnsactive: TIntegerField
      DisplayLabel = 'Active'
      DisplayWidth = 5
      FieldName = 'active'
    end
    object qdnsName: TWideStringField
      DisplayWidth = 10
      FieldName = 'Name'
    end
    object qdnsdns: TWideStringField
      DisplayLabel = 'Domain'
      DisplayWidth = 20
      FieldName = 'dns'
      Size = 255
    end
    object qdnsID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ID'
      Visible = False
    end
  end
  object ds_Qdns: TDataSource
    DataSet = qdns
    Left = 96
    Top = 184
  end
  object qVePais: TMyQuery
    Connection = MC
    SQL.Strings = (
      'SELECT '
      '  pais.sigla,'
      '  pais.PAIS,'
      '  pais.ID,'
      '  pais.IPNUMFROM,'
      '  pais.IPNUMTO'
      'FROM'
      '  pais')
    Left = 64
    Top = 256
    object qVePaissigla: TWideStringField
      FieldName = 'sigla'
      Size = 2
    end
    object qVePaisPAIS: TWideStringField
      FieldName = 'PAIS'
      Size = 50
    end
    object qVePaisID: TIntegerField
      FieldName = 'ID'
    end
    object qVePaisIPNUMFROM: TLargeintField
      FieldName = 'IPNUMFROM'
    end
    object qVePaisIPNUMTO: TLargeintField
      FieldName = 'IPNUMTO'
    end
  end
  object IdLogEvent1: TIdLogEvent
    Left = 184
    Top = 264
  end
  object MyScript1: TMyScript
    SQL.Strings = (
      'delete from messages_thread;'
      ''
      'alter table messages_thread AUTO_INCREMENT = 1;')
    Connection = MC
    Left = 184
    Top = 456
  end
  object IdIOHandlerStack1: TIdIOHandlerStack
    Destination = 'abreuretto.com:110'
    Host = 'abreuretto.com'
    MaxLineAction = maException
    Port = 110
    DefaultPort = 0
    Left = 376
    Top = 392
  end
  object ClientDataSet2: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 520
    Top = 288
  end
  object ClientDataSet3: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 528
    Top = 344
  end
end

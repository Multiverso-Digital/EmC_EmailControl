object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 455
  ClientWidth = 738
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 738
    Height = 455
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 602
    object TabSheet1: TTabSheet
      Caption = 'BDNS'
      ExplicitWidth = 594
      object Edit1: TEdit
        Left = 152
        Top = 80
        Width = 289
        Height = 21
        TabOrder = 0
        Text = '2.0.0.127.zen.spamhaus.org'
      end
      object Memo1: TMemo
        Left = 152
        Top = 136
        Width = 289
        Height = 89
        TabOrder = 1
      end
      object Button1: TButton
        Left = 264
        Top = 231
        Width = 75
        Height = 25
        Caption = 'Buscar'
        TabOrder = 2
        OnClick = Button1Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'DNS'
      ImageIndex = 1
      ExplicitWidth = 594
      object wwDBGrid1: TwwDBGrid
        Left = 0
        Top = 0
        Width = 730
        Height = 313
        Selected.Strings = (
          'selecionada'#9'5'#9'selecionada'#9'F'
          'Filtrada'#9'5'#9'Filtrada'#9'F'
          'Favoritos'#9'5'#9'Favoritos'#9'F'
          'ListaNegra'#9'5'#9'ListaNegra'#9'F'
          'IPSender'#9'14'#9'IPSender'#9'F'#9
          'DominioFrom'#9'60'#9'DominioFrom'#9'F'
          'DNSresolv'#9'150'#9'DNSresolv'#9'F'#9)
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 0
        ShowHorzScrollBar = True
        Align = alTop
        DataSource = wwDataSource1
        TabOrder = 0
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        TitleLines = 1
        TitleButtons = False
        ExplicitWidth = 594
      end
      object Button2: TButton
        Left = 240
        Top = 344
        Width = 129
        Height = 25
        Caption = 'Buscar Paises'
        TabOrder = 1
        OnClick = Button2Click
      end
    end
  end
  object Memo2: TMemo
    Left = 520
    Top = 343
    Width = 185
    Height = 89
    TabOrder = 1
  end
  object IdDNSResolver1: TIdDNSResolver
    OnStatus = IdDNSResolver1Status
    Intercept = IdConnectionIntercept1
    QueryType = []
    WaitingTime = 5000
    AllowRecursiveQueries = True
    Host = '208.67.220.220'
    IPVersion = Id_IPv4
    Left = 360
    Top = 16
  end
  object MyConnection1: TMyConnection
    Database = 'emc'
    Username = 'root'
    Password = 'aw1122'
    Server = '192.168.0.10'
    Connected = True
    LoginPrompt = False
    Left = 48
    Top = 296
  end
  object MyQuery1: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      'Select * from all_messages'
      'limit 150')
    Left = 128
    Top = 296
  end
  object DataSetProvider1: TDataSetProvider
    DataSet = MyQuery1
    Left = 208
    Top = 296
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProvider1'
    Left = 296
    Top = 296
    object ClientDataSet1selecionada: TIntegerField
      DisplayWidth = 5
      FieldName = 'selecionada'
      Origin = 'all_messages.selecionada'
    end
    object ClientDataSet1Filtrada: TIntegerField
      DisplayWidth = 5
      FieldName = 'Filtrada'
      Origin = 'all_messages.Filtrada'
    end
    object ClientDataSet1Favoritos: TIntegerField
      DisplayWidth = 5
      FieldName = 'Favoritos'
      Origin = 'all_messages.Favoritos'
    end
    object ClientDataSet1ListaNegra: TIntegerField
      DisplayWidth = 5
      FieldName = 'ListaNegra'
      Origin = 'all_messages.ListaNegra'
    end
    object ClientDataSet1IPSender: TStringField
      DisplayWidth = 14
      FieldName = 'IPSender'
      Origin = 'all_messages.IPSender'
      Size = 15
    end
    object ClientDataSet1DominioFrom: TStringField
      DisplayWidth = 60
      FieldName = 'DominioFrom'
      Origin = 'all_messages.DominioFrom'
      Size = 255
    end
    object ClientDataSet1DNSresolv: TStringField
      DisplayWidth = 150
      FieldKind = fkInternalCalc
      FieldName = 'DNSresolv'
      Size = 150
    end
    object ClientDataSet1Email: TStringField
      DisplayWidth = 23
      FieldName = 'Email'
      Origin = 'all_messages.Email'
      Visible = False
      Size = 200
    end
    object ClientDataSet1Assunto: TStringField
      DisplayWidth = 50
      FieldName = 'Assunto'
      Origin = 'all_messages.Assunto'
      Visible = False
      Size = 255
    end
    object ClientDataSet1Emitente: TStringField
      DisplayWidth = 34
      FieldName = 'Emitente'
      Origin = 'all_messages.Emitente'
      Visible = False
      Size = 255
    end
    object ClientDataSet1Country: TStringField
      DisplayWidth = 43
      FieldName = 'Country'
      Origin = 'all_messages.Country'
      Visible = False
      Size = 50
    end
    object ClientDataSet1ID: TLargeintField
      FieldName = 'ID'
      Origin = 'all_messages.ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Visible = False
    end
    object ClientDataSet1DT: TDateTimeField
      FieldName = 'DT'
      Origin = 'all_messages.DT'
      Visible = False
    end
    object ClientDataSet1Tama: TIntegerField
      FieldName = 'Tama'
      Origin = 'all_messages.Tama'
      Visible = False
    end
    object ClientDataSet1Datamens: TDateTimeField
      FieldName = 'Datamens'
      Origin = 'all_messages.Datamens'
      Visible = False
    end
    object ClientDataSet1Cabec: TMemoField
      FieldName = 'Cabec'
      Origin = 'all_messages.Cabec'
      Visible = False
      BlobType = ftMemo
    end
    object ClientDataSet1Corpo: TMemoField
      FieldName = 'Corpo'
      Origin = 'all_messages.Corpo'
      Visible = False
      BlobType = ftMemo
    end
    object ClientDataSet1Status: TIntegerField
      FieldName = 'Status'
      Origin = 'all_messages.Status'
      Visible = False
    end
    object ClientDataSet1FiltroResult: TMemoField
      FieldName = 'FiltroResult'
      Origin = 'all_messages.FiltroResult'
      Visible = False
      BlobType = ftMemo
    end
    object ClientDataSet1ListaNegraResult: TMemoField
      FieldName = 'ListaNegraResult'
      Origin = 'all_messages.ListaNegraResult'
      Visible = False
      BlobType = ftMemo
    end
    object ClientDataSet1NumeroMens: TIntegerField
      FieldName = 'NumeroMens'
      Origin = 'all_messages.NumeroMens'
      Visible = False
    end
    object ClientDataSet1Excluida: TIntegerField
      FieldName = 'Excluida'
      Origin = 'all_messages.Excluida'
      Visible = False
    end
    object ClientDataSet1Anexos: TIntegerField
      FieldName = 'Anexos'
      Origin = 'all_messages.Anexos'
      Visible = False
    end
    object ClientDataSet1Conta: TStringField
      FieldName = 'Conta'
      Origin = 'all_messages.Conta'
      Visible = False
      Size = 50
    end
    object ClientDataSet1MsgId: TStringField
      FieldName = 'MsgId'
      Origin = 'all_messages.MsgId'
      Visible = False
      Size = 255
    end
    object ClientDataSet1IsBodyEmpty: TBooleanField
      FieldName = 'IsBodyEmpty'
      Origin = 'all_messages.IsBodyEmpty'
      Visible = False
    end
    object ClientDataSet1UID: TStringField
      FieldName = 'UID'
      Origin = 'all_messages.UID'
      Visible = False
      Size = 255
    end
    object ClientDataSet1IsMsgSinglePartMime: TBooleanField
      FieldName = 'IsMsgSinglePartMime'
      Origin = 'all_messages.IsMsgSinglePartMime'
      Visible = False
    end
    object ClientDataSet1AttachmentEncoding: TStringField
      FieldName = 'AttachmentEncoding'
      Origin = 'all_messages.AttachmentEncoding'
      Visible = False
      Size = 255
    end
    object ClientDataSet1CharSet: TStringField
      FieldName = 'CharSet'
      Origin = 'all_messages.CharSet'
      Visible = False
      Size = 255
    end
    object ClientDataSet1ContentType: TStringField
      FieldName = 'ContentType'
      Origin = 'all_messages.ContentType'
      Visible = False
      Size = 255
    end
    object ClientDataSet1ContentTransferEncoding: TStringField
      FieldName = 'ContentTransferEncoding'
      Origin = 'all_messages.ContentTransferEncoding'
      Visible = False
      Size = 255
    end
    object ClientDataSet1ContentDisposition: TStringField
      FieldName = 'ContentDisposition'
      Origin = 'all_messages.ContentDisposition'
      Visible = False
      Size = 255
    end
    object ClientDataSet1NoEncode: TBooleanField
      FieldName = 'NoEncode'
      Origin = 'all_messages.NoEncode'
      Visible = False
    end
    object ClientDataSet1NoDecode: TBooleanField
      FieldName = 'NoDecode'
      Origin = 'all_messages.NoDecode'
      Visible = False
    end
    object ClientDataSet1Organization: TStringField
      FieldName = 'Organization'
      Origin = 'all_messages.Organization'
      Visible = False
      Size = 255
    end
    object ClientDataSet1DataOrig: TStringField
      FieldName = 'DataOrig'
      Origin = 'all_messages.DataOrig'
      Visible = False
      Size = 255
    end
    object ClientDataSet1Xmailer: TStringField
      FieldName = 'Xmailer'
      Origin = 'all_messages.Xmailer'
      Visible = False
      Size = 255
    end
    object ClientDataSet1ReplayTO: TStringField
      FieldName = 'ReplayTO'
      Origin = 'all_messages.ReplayTO'
      Visible = False
      Size = 255
    end
    object ClientDataSet1ReturnPath: TStringField
      FieldName = 'ReturnPath'
      Origin = 'all_messages.ReturnPath'
      Visible = False
      Size = 255
    end
    object ClientDataSet1FromOrig: TStringField
      FieldName = 'FromOrig'
      Origin = 'all_messages.FromOrig'
      Visible = False
      Size = 255
    end
    object ClientDataSet1ToOrig: TStringField
      FieldName = 'ToOrig'
      Origin = 'all_messages.ToOrig'
      Visible = False
      Size = 255
    end
    object ClientDataSet1CCOrig: TMemoField
      FieldName = 'CCOrig'
      Origin = 'all_messages.CCOrig'
      Visible = False
      BlobType = ftMemo
    end
    object ClientDataSet1BCCOrig: TMemoField
      FieldName = 'BCCOrig'
      Origin = 'all_messages.BCCOrig'
      Visible = False
      BlobType = ftMemo
    end
    object ClientDataSet1ReceivedFrom: TStringField
      FieldName = 'ReceivedFrom'
      Origin = 'all_messages.ReceivedFrom'
      Visible = False
      Size = 255
    end
    object ClientDataSet1FriendResult: TMemoField
      FieldName = 'FriendResult'
      Origin = 'all_messages.FriendResult'
      Visible = False
      BlobType = ftMemo
    end
    object ClientDataSet1EmailFrom: TStringField
      FieldName = 'EmailFrom'
      Origin = 'all_messages.EmailFrom'
      Visible = False
      Size = 255
    end
    object ClientDataSet1ID_Conta: TIntegerField
      FieldName = 'ID_Conta'
      Origin = 'all_messages.ID_Conta'
      Visible = False
    end
    object ClientDataSet1AnexosFiles: TMemoField
      FieldName = 'AnexosFiles'
      Origin = 'all_messages.AnexosFiles'
      Visible = False
      BlobType = ftMemo
    end
  end
  object wwDataSource1: TwwDataSource
    DataSet = ClientDataSet1
    Left = 384
    Top = 296
  end
  object IdConnectionIntercept1: TIdConnectionIntercept
    Left = 464
    Top = 40
  end
end

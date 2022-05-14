object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 529
  ClientWidth = 719
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
  object Edit1: TEdit
    Left = 8
    Top = 8
    Width = 673
    Height = 21
    TabOrder = 0
    Text = 
      #39'Subject: =?koi8-r?B?IvvQyc/Oy8EiLiDxINXXxdLFziDe1M8g2s7BwCDPIND' +
      'PxMHSy8HIIA==?= =?koi8-r?B?19Oj?='#39
  end
  object Edit2: TEdit
    Left = 8
    Top = 35
    Width = 673
    Height = 21
    TabOrder = 1
    Text = 'Edit2'
  end
  object Button1: TButton
    Left = 320
    Top = 62
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Edit5: TEdit
    Left = 8
    Top = 93
    Width = 673
    Height = 21
    TabOrder = 3
    Text = 
      'Subject: =?koi8-r?B?IvvQyc/Oy8EiLiDxINXXxdLFziDe1M8g2s7BwCDPINDP' +
      'xMHSy8HIIA==?= =?koi8-r?B?19Oj?='
  end
  object Edit6: TEdit
    Left = 8
    Top = 120
    Width = 673
    Height = 21
    TabOrder = 4
    Text = 'Edit6'
  end
  object Button2: TButton
    Left = 320
    Top = 192
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 5
    OnClick = Button2Click
  end
  object wwDBGrid1: TwwDBGrid
    Left = 8
    Top = 248
    Width = 673
    Height = 201
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = DataSource1
    TabOrder = 6
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
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
    Left = 32
    Top = 120
  end
  object IdIMAP41: TIdIMAP4
    IOHandler = IdSSLIOHandlerSocketOpenSSL1
    Password = 'aw112233'
    Port = 993
    Username = 'belijoomla@gmail.com'
    Host = 'imap.gmail.com'
    UseTLS = utUseImplicitTLS
    SASLMechanisms = <>
    MilliSecsToWaitToClearBuffer = 10
    Left = 80
    Top = 48
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    Destination = 'imap.gmail.com:993'
    Host = 'imap.gmail.com'
    MaxLineAction = maException
    Port = 993
    DefaultPort = 0
    SSLOptions.Method = sslvSSLv2
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 184
    Top = 112
  end
  object IdMailBox1: TIdMailBox
    Left = 296
    Top = 104
  end
  object MyConnection1: TMyConnection
    Database = 'emc'
    Options.UseUnicode = True
    Username = 'root'
    Password = 'aw1122'
    Server = '192.168.0.10'
    Connected = True
    LoginPrompt = False
    Left = 96
    Top = 176
  end
  object MyQuery1: TMyQuery
    Connection = MyConnection1
    SQL.Strings = (
      'Select * from teste')
    CachedUpdates = True
    Left = 200
    Top = 176
    object MyQuery1id: TIntegerField
      FieldName = 'id'
    end
    object MyQuery1valor: TWideStringField
      FieldName = 'valor'
      Size = 255
    end
  end
  object DataSource1: TDataSource
    DataSet = MyQuery1
    Left = 272
    Top = 184
  end
end

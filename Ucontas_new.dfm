object FContas_New: TFContas_New
  Left = 0
  Top = 0
  Caption = 'mc-Accounts'
  ClientHeight = 349
  ClientWidth = 530
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 530
    Height = 313
    ActivePage = TabSheet1
    Align = alTop
    Style = tsButtons
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'POP3'
      object Label1: TLabel
        Left = 40
        Top = 24
        Width = 72
        Height = 13
        Caption = 'Account name:'
      end
      object Label2: TLabel
        Left = 40
        Top = 85
        Width = 65
        Height = 13
        Caption = 'POP3 Server:'
      end
      object Label3: TLabel
        Left = 40
        Top = 112
        Width = 55
        Height = 13
        Caption = 'User name:'
      end
      object Label4: TLabel
        Left = 40
        Top = 139
        Width = 50
        Height = 13
        Caption = 'Password:'
      end
      object Label5: TLabel
        Left = 40
        Top = 166
        Width = 63
        Height = 13
        Caption = 'Port number:'
      end
      object Label15: TLabel
        Left = 40
        Top = 57
        Width = 32
        Height = 13
        Caption = 'E-mail:'
      end
      object Label19: TLabel
        Left = 117
        Top = 234
        Width = 178
        Height = 13
        Caption = 'EmC Authentication account number:'
      end
      object DBEdit1: TDBEdit
        Left = 117
        Top = 83
        Width = 292
        Height = 21
        DataField = 'POP'
        DataSource = DM_SERVER.DS_qContas
        TabOrder = 0
      end
      object DBEdit2: TDBEdit
        Left = 117
        Top = 110
        Width = 292
        Height = 21
        DataField = 'Usuario'
        DataSource = DM_SERVER.DS_qContas
        TabOrder = 1
      end
      object DBEdit3: TDBEdit
        Left = 117
        Top = 137
        Width = 140
        Height = 21
        DataField = 'Senha'
        DataSource = DM_SERVER.DS_qContas
        TabOrder = 2
      end
      object DBEdit4: TDBEdit
        Left = 117
        Top = 164
        Width = 36
        Height = 21
        DataField = 'Porta'
        DataSource = DM_SERVER.DS_qContas
        TabOrder = 3
      end
      object DBRadioGroup1: TDBRadioGroup
        Left = 415
        Top = 16
        Width = 72
        Height = 105
        Cursor = crHandPoint
        Caption = 'Authentication'
        DataField = 'Autentica'
        DataSource = DM_SERVER.DS_qContas
        Items.Strings = (
          'none'
          'APOP'
          'MSN SPA')
        ParentBackground = True
        TabOrder = 4
        Values.Strings = (
          '0'
          '1'
          '2')
        Visible = False
      end
      object DBRadioGroup2: TDBRadioGroup
        Left = 435
        Top = 23
        Width = 52
        Height = 74
        Cursor = crHandPoint
        Caption = 'How Body Message will be read'
        DataField = 'LeBody'
        DataSource = DM_SERVER.DS_qContas
        Items.Strings = (
          'Only 50 lines (TOP command - Recomended)'
          'Body (RETR command - Not recomended)')
        ParentBackground = True
        TabOrder = 5
        Values.Strings = (
          '0'
          '1')
        Visible = False
        OnClick = DBRadioGroup2Click
      end
      object DBEdit12: TDBEdit
        Left = 117
        Top = 21
        Width = 139
        Height = 21
        DataField = 'Nome'
        DataSource = DM_SERVER.DS_qContas
        TabOrder = 6
      end
      object DBCheckBox1: TDBCheckBox
        Left = 159
        Top = 165
        Width = 250
        Height = 17
        Cursor = crHandPoint
        Caption = 'This server use a secure SSL connection(995)'
        DataField = 'SSL'
        DataSource = DM_SERVER.DS_qContas
        TabOrder = 7
        ValueChecked = '1'
        ValueUnchecked = '0'
        OnClick = DBCheckBox1Click
      end
      object DBCheckBox4: TDBCheckBox
        Left = 271
        Top = 23
        Width = 138
        Height = 17
        Cursor = crHandPoint
        Caption = 'Active'
        DataField = 'Ativada'
        DataSource = DM_SERVER.DS_qContas
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 8
        ValueChecked = '1'
        ValueUnchecked = '0'
      end
      object Button4: TButton
        Left = 117
        Top = 205
        Width = 291
        Height = 25
        Caption = 'Test Server Connection'
        TabOrder = 9
        OnClick = Button4Click
      end
      object DBEdit17: TDBEdit
        Left = 117
        Top = 55
        Width = 292
        Height = 21
        DataField = 'Email'
        DataSource = DM_SERVER.DS_qContas
        TabOrder = 10
      end
      object DBEdit19: TDBEdit
        Left = 116
        Top = 248
        Width = 292
        Height = 21
        DataField = 'GUID'
        DataSource = DM_SERVER.DS_qContas
        Enabled = False
        ReadOnly = True
        TabOrder = 11
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'IMAP'
      ImageIndex = 1
      object Label6: TLabel
        Left = 40
        Top = 24
        Width = 72
        Height = 13
        Caption = 'Account name:'
      end
      object Label7: TLabel
        Left = 40
        Top = 88
        Width = 64
        Height = 13
        Caption = 'IMAP Server:'
      end
      object Label8: TLabel
        Left = 40
        Top = 115
        Width = 55
        Height = 13
        Caption = 'User name:'
      end
      object Label9: TLabel
        Left = 40
        Top = 142
        Width = 50
        Height = 13
        Caption = 'Password:'
      end
      object Label10: TLabel
        Left = 40
        Top = 169
        Width = 63
        Height = 13
        Caption = 'Port number:'
      end
      object Label18: TLabel
        Left = 40
        Top = 57
        Width = 32
        Height = 13
        Caption = 'E-mail:'
      end
      object Label20: TLabel
        Left = 117
        Top = 234
        Width = 178
        Height = 13
        Caption = 'EmC Authentication account number:'
      end
      object DBEdit5: TDBEdit
        Left = 117
        Top = 86
        Width = 292
        Height = 21
        DataField = 'POP'
        DataSource = DM_SERVER.DS_qContas
        TabOrder = 0
      end
      object DBEdit6: TDBEdit
        Left = 117
        Top = 113
        Width = 292
        Height = 21
        DataField = 'Usuario'
        DataSource = DM_SERVER.DS_qContas
        TabOrder = 1
      end
      object DBEdit7: TDBEdit
        Left = 117
        Top = 140
        Width = 140
        Height = 21
        DataField = 'Senha'
        DataSource = DM_SERVER.DS_qContas
        TabOrder = 2
      end
      object DBEdit8: TDBEdit
        Left = 117
        Top = 167
        Width = 36
        Height = 21
        DataField = 'Porta'
        DataSource = DM_SERVER.DS_qContas
        TabOrder = 3
      end
      object DBRadioGroup3: TDBRadioGroup
        Left = 424
        Top = 16
        Width = 72
        Height = 105
        Cursor = crHandPoint
        Caption = 'Authentication'
        DataField = 'Autentica'
        DataSource = DM_SERVER.DS_qContas
        Items.Strings = (
          'none'
          'CRAM/MD5')
        ParentBackground = True
        TabOrder = 4
        Values.Strings = (
          '0'
          '3')
        Visible = False
      end
      object DBEdit15: TDBEdit
        Left = 117
        Top = 21
        Width = 139
        Height = 21
        DataField = 'Nome'
        DataSource = DM_SERVER.DS_qContas
        TabOrder = 5
      end
      object DBCheckBox2: TDBCheckBox
        Left = 159
        Top = 168
        Width = 250
        Height = 17
        Cursor = crHandPoint
        Caption = 'This server use a secure SSL connection(993)'
        DataField = 'SSL'
        DataSource = DM_SERVER.DS_qContas
        TabOrder = 6
        ValueChecked = '1'
        ValueUnchecked = '0'
        OnClick = DBCheckBox2Click
      end
      object DBCheckBox3: TDBCheckBox
        Left = 271
        Top = 23
        Width = 138
        Height = 17
        Cursor = crHandPoint
        Caption = 'Active'
        DataField = 'Ativada'
        DataSource = DM_SERVER.DS_qContas
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 7
        ValueChecked = '1'
        ValueUnchecked = '0'
      end
      object Button5: TButton
        Left = 118
        Top = 202
        Width = 291
        Height = 25
        Caption = 'Test Server Connection'
        TabOrder = 8
        OnClick = Button5Click
      end
      object DBEdit18: TDBEdit
        Left = 117
        Top = 55
        Width = 292
        Height = 21
        DataField = 'Email'
        DataSource = DM_SERVER.DS_qContas
        TabOrder = 9
      end
      object DBEdit20: TDBEdit
        Left = 116
        Top = 248
        Width = 292
        Height = 21
        DataField = 'GUID'
        DataSource = DM_SERVER.DS_qContas
        ReadOnly = True
        TabOrder = 10
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Hotmail'
      ImageIndex = 2
      object Label11: TLabel
        Left = 40
        Top = 24
        Width = 72
        Height = 13
        Caption = 'Account name:'
      end
      object Label12: TLabel
        Left = 40
        Top = 48
        Width = 74
        Height = 13
        Caption = 'Hotmail Server:'
      end
      object Label13: TLabel
        Left = 40
        Top = 75
        Width = 55
        Height = 13
        Caption = 'User name:'
      end
      object Label14: TLabel
        Left = 40
        Top = 102
        Width = 50
        Height = 13
        Caption = 'Password:'
      end
      object DBEdit9: TDBEdit
        Left = 117
        Top = 46
        Width = 292
        Height = 21
        DataField = 'POP'
        DataSource = DM_SERVER.DS_qContas
        TabOrder = 0
      end
      object DBEdit10: TDBEdit
        Left = 117
        Top = 73
        Width = 292
        Height = 21
        DataField = 'Usuario'
        DataSource = DM_SERVER.DS_qContas
        TabOrder = 1
      end
      object DBEdit11: TDBEdit
        Left = 117
        Top = 100
        Width = 140
        Height = 21
        DataField = 'Senha'
        DataSource = DM_SERVER.DS_qContas
        TabOrder = 2
      end
      object DBRadioGroup4: TDBRadioGroup
        Left = 40
        Top = 161
        Width = 129
        Height = 105
        Cursor = crHandPoint
        Caption = 'Server'
        DataField = 'HotMailServer'
        DataSource = DM_SERVER.DS_qContas
        Items.Strings = (
          'Hotmail'
          'MSN Hotmail')
        ParentBackground = True
        TabOrder = 3
        Values.Strings = (
          '0'
          '1')
      end
      object GroupBox1: TGroupBox
        Left = 184
        Top = 161
        Width = 305
        Height = 105
        Caption = 'Use a Proxi Server'
        TabOrder = 4
        object Label16: TLabel
          Left = 5
          Top = 23
          Width = 43
          Height = 13
          Caption = 'Address:'
        end
        object Label17: TLabel
          Left = 5
          Top = 50
          Width = 24
          Height = 13
          Caption = 'Port:'
        end
        object DBEdit13: TDBEdit
          Left = 60
          Top = 20
          Width = 236
          Height = 21
          DataField = 'ProxiServer'
          DataSource = DM_SERVER.DS_qContas
          TabOrder = 0
        end
        object DBEdit14: TDBEdit
          Left = 60
          Top = 47
          Width = 41
          Height = 21
          DataField = 'ProxiPorta'
          DataSource = DM_SERVER.DS_qContas
          TabOrder = 1
        end
      end
      object DBEdit16: TDBEdit
        Left = 117
        Top = 21
        Width = 139
        Height = 21
        DataField = 'Nome'
        DataSource = DM_SERVER.DS_qContas
        TabOrder = 5
      end
      object DBCheckBox5: TDBCheckBox
        Left = 271
        Top = 23
        Width = 138
        Height = 17
        Cursor = crHandPoint
        Caption = 'Active'
        DataField = 'Ativada'
        DataSource = DM_SERVER.DS_qContas
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 6
        ValueChecked = '1'
        ValueUnchecked = '0'
      end
    end
  end
  object Button1: TButton
    Left = 392
    Top = 319
    Width = 121
    Height = 25
    Cursor = crHandPoint
    Caption = 'Save'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 213
    Top = 320
    Width = 106
    Height = 25
    Cursor = crHandPoint
    Caption = 'Cancel'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 320
    Width = 106
    Height = 25
    Cursor = crHandPoint
    Caption = 'Delete this account'
    TabOrder = 3
    Visible = False
    OnClick = Button3Click
  end
  object memo1: TListBox
    Left = 4
    Top = 350
    Width = 509
    Height = 121
    ItemHeight = 13
    TabOrder = 4
  end
  object POP3: TIdPOP3
    OnStatus = POP3Status
    Intercept = IdLogEvent1
    IOHandler = SSL1
    AutoLogin = True
    SASLMechanisms = <>
    Left = 424
    Top = 160
  end
  object IMAP4: TIdIMAP4
    SASLMechanisms = <>
    MilliSecsToWaitToClearBuffer = 10
    Left = 424
    Top = 208
  end
  object SSL1: TIdSSLIOHandlerSocketOpenSSL
    OnStatus = SSL1Status
    Destination = ':110'
    Intercept = IdLogEvent1
    MaxLineAction = maException
    Port = 110
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    OnStatusInfo = SSL1StatusInfo
    Left = 464
    Top = 160
  end
  object IdLogEvent1: TIdLogEvent
    OnStatus = IdLogEvent1Status
    Left = 464
    Top = 208
  end
  object JvMail1: TJvMail
    BlindCopy = <>
    CarbonCopy = <>
    ReadOptions = [roHeaderOnly]
    Recipient = <>
    Left = 440
    Top = 252
  end
end

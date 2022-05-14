object FContas: TFContas
  Left = 0
  Top = 0
  Caption = 'EmC-Contas'
  ClientHeight = 566
  ClientWidth = 492
  Color = 15984085
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object wwDBGrid1: TwwDBGrid
    Left = 0
    Top = 57
    Width = 492
    Height = 509
    Cursor = crHandPoint
    ControlType.Strings = (
      'Ativada;CheckBox;1;0'
      'SMTPautentica;CheckBox;1;0'
      'Senha;CustomEdit;wwDBEdit1;T'
      'SMTPSenha;CustomEdit;wwDBEdit1;T')
    Selected.Strings = (
      'Ativada'#9'10'#9'Ativada'#9#9
      'Nome'#9'30'#9'Nome'#9'F'#9
      'Email'#9'30'#9'Email'#9'F'#9)
    IniAttributes.FileName = 'delphi32.ini.ini'
    IniAttributes.Delimiter = ';;'
    TitleColor = 15984085
    FixedCols = 0
    ShowHorzScrollBar = True
    Align = alClient
    DataSource = DM_SERVER.DS_qContas
    Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
    TabOrder = 0
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
    OnDblClick = wwDBGrid1DblClick
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 492
    Height = 57
    ButtonHeight = 52
    ButtonWidth = 50
    Caption = 'ToolBar1'
    GradientEndColor = clTeal
    HotTrackColor = clMoneyGreen
    Images = Fmain.ilGFX32
    GradientDirection = gdHorizontal
    ShowCaptions = True
    TabOrder = 1
    Transparent = False
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Hint = 'Add new account'
      CustomHint = BalloonHint1
      Caption = 'Add New'
      ImageIndex = 18
      ParentShowHint = False
      ShowHint = True
      Style = tbsCheck
      OnClick = ToolButton1Click
    end
    object ToolButton3: TToolButton
      Left = 50
      Top = 0
      Width = 8
      Caption = 'ToolButton3'
      ImageIndex = 20
      Style = tbsSeparator
    end
    object ToolButton2: TToolButton
      Left = 58
      Top = 0
      Cursor = crHandPoint
      Hint = 'Import accounts from old EmC version'
      CustomHint = BalloonHint1
      Caption = 'Import'
      ImageIndex = 19
      ParentShowHint = False
      ShowHint = True
      OnClick = ToolButton2Click
    end
    object ToolButton4: TToolButton
      Left = 108
      Top = 0
      Width = 8
      Caption = 'ToolButton4'
      ImageIndex = 20
      Style = tbsSeparator
    end
    object ToolButton5: TToolButton
      Left = 116
      Top = 0
      Cursor = crHandPoint
      Hint = 'Exportar contas do EmC para outros arquivos'
      CustomHint = BalloonHint1
      Caption = 'Exportar'
      ImageIndex = 35
      ParentShowHint = False
      ShowHint = True
      OnClick = ToolButton5Click
    end
  end
  object wwDBEdit1: TwwDBEdit
    Left = 90
    Top = 192
    Width = 121
    Height = 21
    DataField = 'Senha'
    DataSource = DM_SERVER.DS_qContas
    PasswordChar = '*'
    TabOrder = 2
    UnboundDataType = wwDefault
    WantReturns = False
    WordWrap = False
  end
  object wwDBEdit2: TwwDBEdit
    Left = 90
    Top = 219
    Width = 121
    Height = 21
    DataField = 'SMTPSenha'
    DataSource = DM_SERVER.DS_qContas
    PasswordChar = '*'
    TabOrder = 3
    UnboundDataType = wwDefault
    Visible = False
    WantReturns = False
    WordWrap = False
  end
  object wwRecordViewDialog1: TwwRecordViewDialog
    Controller = wwController1
    ControlType.Strings = (
      'Ativada;CheckBox;1;0'
      'Senha;CustomEdit;wwDBEdit1;T'
      'SMTPSenha;CustomEdit;wwDBEdit2;F'
      'SMTPautentica;CheckBox;1;0')
    EditFrame.Enabled = True
    EditFrame.Transparent = True
    EditFrame.NonFocusBorders = [efLeftBorder, efTopBorder, efRightBorder, efBottomBorder]
    EditFrame.FocusStyle = efsFrameSingle
    EditFrame.NonFocusStyle = efsFrameSingle
    EditFrame.NonFocusColor = clYellow
    DataSource = DM_SERVER.DS_qContas
    FormPosition.Left = 0
    FormPosition.Top = 0
    FormPosition.Width = 0
    FormPosition.Height = 0
    NavigatorButtons = [nbsFirst, nbsPrior, nbsNext, nbsLast, nbsInsert, nbsDelete, nbsEdit, nbsPost, nbsCancel, nbsRefresh, nbsPriorPage, nbsNextPage]
    Options = [rvoUseCustomControls, rvoShortenEditBox, rvoModalForm, rvoConfirmCancel, rvoCloseIsCancel, rvoMaximizeMemoWidth, rvoSetControlMinWidth, rvoUseDateTimePicker]
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
    OnAfterCreateControl = wwRecordViewDialog1AfterCreateControl
    Caption = 'Account View'
    Selected.Strings = (
      'Nome'#9'15'#9'Account Name'#9#9
      'Ativada'#9'5'#9'Active'#9#9
      'POP'#9'30'#9'POP3 Server'#9#9
      'Porta'#9'5'#9'Port'#9#9
      'Email'#9'30'#9'E-mail'#9#9
      'Usuario'#9'30'#9'User ID'#9#9
      'Senha'#9'15'#9'Password'#9#9
      'SMTP'#9'37'#9'SMTP Server'#9#9
      'SMTPautentica'#9'10'#9'SMTP Authentication'#9#9
      'SMTPPorta'#9'10'#9'SMTP Port'#9#9
      'SMTPusuario'#9'37'#9'SMTP User ID'#9'F'
      'SMTPSenha'#9'15'#9'SMTP Password'#9'F')
    NavigatorFlat = True
    Left = 232
    Top = 280
  end
  object wwController1: TwwController
    Frame.Enabled = True
    Frame.Transparent = True
    Frame.NonFocusBorders = [efLeftBorder, efTopBorder, efRightBorder, efBottomBorder]
    Frame.FocusStyle = efsFrameSingle
    Frame.NonFocusStyle = efsFrameSingle
    Frame.NonFocusColor = clYellow
    ButtonEffects.Transparent = True
    ButtonEffects.Flat = True
    Left = 136
    Top = 280
  end
  object BalloonHint1: TBalloonHint
    Images = Fmain.ilGFX16
    Left = 352
    Top = 208
  end
end

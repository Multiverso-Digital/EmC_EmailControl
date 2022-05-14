object FContas: TFContas
  Left = 0
  Top = 0
  Caption = 'mC-Accounts'
  ClientHeight = 566
  ClientWidth = 492
  Color = clWhite
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
      'SMTPSenha;CustomEdit;wwDBEdit1;T'
      'Tipo;CustomEdit;wwDBComboBox1;F')
    Selected.Strings = (
      'Ativada'#9'10'#9'Ativada'
      'Nome'#9'28'#9'Nome'
      'Tipo'#9'10'#9'Tipo')
    IniAttributes.FileName = 'delphi32.ini.ini'
    IniAttributes.Delimiter = ';;'
    TitleColor = clWhite
    FixedCols = 0
    ShowHorzScrollBar = True
    EditControlOptions = [ecoCheckboxSingleClick, ecoSearchOwnerForm]
    Align = alClient
    DataSource = DM_SERVER.DS_qContas
    KeyOptions = []
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
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
    HideAllLines = True
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
      Cursor = crHandPoint
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
      Hint = 'Export EmC accounts to others files'
      CustomHint = BalloonHint1
      Caption = 'Export'
      ImageIndex = 35
      ParentShowHint = False
      ShowHint = True
      OnClick = ToolButton5Click
    end
  end
  object BalloonHint1: TBalloonHint
    Images = Fmain.ilGFX16
    Left = 352
    Top = 208
  end
end

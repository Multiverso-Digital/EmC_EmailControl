object FFavoritos: TFFavoritos
  Left = 0
  Top = 0
  Caption = 'EmC-Friends'
  ClientHeight = 566
  ClientWidth = 792
  Color = clMoneyGreen
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 792
    Height = 377
    Align = alTop
    Caption = 'GroupBox1'
    TabOrder = 0
    ExplicitLeft = 32
    ExplicitTop = 8
    ExplicitWidth = 657
    object wwDBGrid1: TwwDBGrid
      Left = 2
      Top = 15
      Width = 788
      Height = 360
      Selected.Strings = (
        'ID'#9'10'#9'ID'#9#9
        'TypeBox'#9'10'#9'TypeBox'#9#9
        'Filter'#9'10'#9'Filter'#9#9
        'Kind'#9'10'#9'Kind'#9#9
        'Expression'#9'255'#9'Expression'#9#9
        'DT'#9'18'#9'DT'#9#9)
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 0
      ShowHorzScrollBar = True
      Align = alClient
      DataSource = DM_SERVER.DS_qBoxes
      TabOrder = 0
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      TitleLines = 1
      TitleButtons = False
      ExplicitLeft = 3
      ExplicitTop = 16
      ExplicitWidth = 651
      ExplicitHeight = 345
    end
  end
  object wwRecordViewPanel1: TwwRecordViewPanel
    Left = 35
    Top = 391
    Width = 651
    Height = 130
    TabOrder = 1
    ControlOptions = []
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'Tahoma'
    LabelFont.Style = []
  end
  object wwController1: TwwController
    Left = 688
    Top = 64
  end
end

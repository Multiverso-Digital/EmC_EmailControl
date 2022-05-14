object FShowWhyFilter: TFShowWhyFilter
  Left = 0
  Top = 0
  Caption = 'mC - Show why message was filtered'
  ClientHeight = 566
  ClientWidth = 792
  Color = 15984085
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
  object GroupBox1: TGroupBox
    Left = 16
    Top = 8
    Width = 768
    Height = 550
    Caption = 'Header details from selected message'
    TabOrder = 0
    object GroupBox2: TGroupBox
      Left = 1
      Top = 328
      Width = 764
      Height = 209
      Caption = 'Filter'
      TabOrder = 0
      object wwDBRichEdit1: TDBMemo
        Left = 3
        Top = 16
        Width = 758
        Height = 190
        DataField = 'FiltroResult'
        DataSource = DM_SERVER.DS_qMens
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
    object DBMemo1: TDBMemo
      Left = 3
      Top = 16
      Width = 762
      Height = 306
      DataField = 'Cabec'
      DataSource = DM_SERVER.DS_qMens
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 1
    end
  end
end

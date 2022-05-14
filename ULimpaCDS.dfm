object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 620
  ClientWidth = 694
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object DBNavigator1: TDBNavigator
    Left = 24
    Top = 319
    Width = 630
    Height = 25
    DataSource = DataSource1
    TabOrder = 0
  end
  object DBGrid1: TDBGrid
    Left = 24
    Top = 64
    Width = 633
    Height = 249
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object JvDirectoryEdit1: TJvDirectoryEdit
    Left = 24
    Top = 8
    Width = 630
    Height = 21
    OnAfterDialog = JvDirectoryEdit1AfterDialog
    DialogKind = dkWin32
    TabOrder = 2
  end
  object ComboBox1: TComboBox
    Left = 24
    Top = 37
    Width = 630
    Height = 21
    ItemHeight = 13
    TabOrder = 3
    OnClick = ComboBox1Click
  end
  object Button1: TButton
    Left = 24
    Top = 568
    Width = 169
    Height = 25
    Caption = 'EmptyDataset'
    TabOrder = 4
    OnClick = Button1Click
  end
  object ListBox1: TListBox
    Left = 24
    Top = 360
    Width = 630
    Height = 137
    ItemHeight = 13
    TabOrder = 5
  end
  object Button2: TButton
    Left = 520
    Top = 503
    Width = 134
    Height = 25
    Caption = 'Salvar'
    TabOrder = 6
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 368
    Top = 504
    Width = 113
    Height = 25
    Caption = 'Limpar'
    TabOrder = 7
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 24
    Top = 503
    Width = 137
    Height = 25
    Caption = 'Boxes Limpa'
    TabOrder = 8
    OnClick = Button4Click
  end
  object DataSource1: TDataSource
    DataSet = cds
    Left = 440
    Top = 280
  end
  object cds: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 368
    Top = 280
  end
  object JvSearchFiles1: TJvSearchFiles
    FileParams.SearchTypes = [stFileMask]
    FileParams.FileMasks.Strings = (
      '*.cds'
      '*.dat')
    Left = 288
    Top = 248
  end
end

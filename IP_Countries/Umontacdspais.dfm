object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 529
  ClientWidth = 698
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
  object Button1: TButton
    Left = 304
    Top = 496
    Width = 121
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 152
    Width = 657
    Height = 289
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Memo1: TMemo
    Left = 168
    Top = 16
    Width = 497
    Height = 130
    TabOrder = 2
  end
  object Panel1: TPanel
    Left = 96
    Top = 448
    Width = 521
    Height = 25
    Caption = 'Panel1'
    TabOrder = 3
  end
  object Button2: TButton
    Left = 24
    Top = 496
    Width = 75
    Height = 25
    Caption = 'Parar'
    TabOrder = 4
    OnClick = Button2Click
  end
  object JvCSVBase1: TJvCSVBase
    CSVFileName = 
      'K:\@Projetos_em_andamento\EmC2011_Thread\IP_Countries\IpToCountr' +
      'y1\IpToCountryabreu.csv'
    CSVFieldNames.Strings = (
      'IPFROM'
      'IPTO'
      'REGI'
      'ASSIGX'
      'CTRY'
      'CNTRY'
      'PAIS')
    OnCursorChanged = JvCSVBase1CursorChanged
    Left = 120
    Top = 96
  end
  object cds: TClientDataSet
    Aggregates = <>
    FileName = 'K:\@Projetos_em_andamento\EmC2011_Thread\Dados\pais.cds'
    IndexFieldNames = 'IPNUMFROM;IPNUMTO'
    Params = <>
    Left = 56
    Top = 24
    object cdsIPNUMFROM: TLargeintField
      FieldName = 'IPNUMFROM'
    end
    object cdsIPNUMTO: TLargeintField
      FieldName = 'IPNUMTO'
    end
    object cdssigla: TWideStringField
      FieldName = 'sigla'
      Size = 2
    end
    object cdsmpais: TWideStringField
      FieldName = 'mpais'
      Size = 50
    end
    object cdsID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
  end
  object DataSource1: TDataSource
    DataSet = cds
    Left = 120
    Top = 24
  end
end

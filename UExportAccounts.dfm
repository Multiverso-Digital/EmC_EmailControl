object FExportAccounts: TFExportAccounts
  Left = 0
  Top = 0
  Caption = 'mC-Export Accounts'
  ClientHeight = 200
  ClientWidth = 401
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
  object JvImgBtn1: TJvImgBtn
    Left = 96
    Top = 48
    Width = 193
    Height = 25
    Cursor = crHandPoint
    Caption = 'Export Accounts to MS-Excel'
    ImageIndex = 2
    Images = Fmain.ilGFX16
    TabOrder = 0
    OnClick = JvImgBtn1Click
    Animate = True
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'Tahoma'
    HotTrackFont.Style = []
  end
  object JvImgBtn2: TJvImgBtn
    Left = 96
    Top = 79
    Width = 193
    Height = 25
    Cursor = crHandPoint
    Caption = 'Export Accounts to CSV'
    ImageIndex = 3
    Images = Fmain.ilGFX16
    TabOrder = 1
    OnClick = JvImgBtn2Click
    Animate = True
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'Tahoma'
    HotTrackFont.Style = []
  end
  object JvImgBtn3: TJvImgBtn
    Left = 96
    Top = 110
    Width = 193
    Height = 25
    Cursor = crHandPoint
    Caption = 'Export Accounts to XML'
    ImageIndex = 6
    Images = Fmain.ilGFX16
    TabOrder = 2
    OnClick = JvImgBtn3Click
    Animate = True
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'Tahoma'
    HotTrackFont.Style = []
  end
  object DBGrid1: TDBGrid
    Left = 40
    Top = 141
    Width = 320
    Height = 45
    DataSource = DM_SERVER.DS_qContas
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Visible = False
    Columns = <
      item
        Expanded = False
        FieldName = 'Nome'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Ativada'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'POP'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Porta'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Usuario'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Porta'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Email'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SMTP'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SMTPPorta'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SMTPautentica'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SMTPusuario'
        Visible = True
      end>
  end
  object JvDBGridExcelExport1: TJvDBGridExcelExport
    Caption = 'Exporting to MS Excel...'
    Grid = DBGrid1
    OnProgress = JvDBGridExcelExport1Progress
    AutoFit = False
    Left = 8
    Top = 8
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = 'xls'
    Filter = 'MS-Excel|*.xls'
    Left = 96
    Top = 8
  end
  object JvDBGridCSVExport1: TJvDBGridCSVExport
    Caption = 'Exporting to CSV/Text...'
    Grid = DBGrid1
    ExportSeparator = esComma
    Left = 144
    Top = 8
  end
  object JvDBGridXMLExport1: TJvDBGridXMLExport
    Grid = DBGrid1
    Left = 56
    Top = 8
  end
end

object Fmycomputer: TFmycomputer
  Left = 0
  Top = 0
  Caption = 'mC-My Computer'
  ClientHeight = 523
  ClientWidth = 559
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 487
    Width = 559
    Height = 36
    Align = alBottom
    TabOrder = 0
    ExplicitTop = 249
    ExplicitWidth = 426
    object Button1: TButton
      Left = 232
      Top = 6
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Caption = 'Ok'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 559
    Height = 487
    Align = alClient
    TabOrder = 1
  end
  object JvInspector1: TJvInspector
    Left = 0
    Top = 0
    Width = 559
    Height = 487
    Cursor = crHandPoint
    Style = isItemPainter
    Align = alClient
    RelativeDivider = True
    Divider = 39
    ItemHeight = 16
    Painter = JvInspectorBorlandPainter1
    ReadOnly = True
    TabStop = True
    TabOrder = 2
  end
  object JvInspectorBorlandPainter1: TJvInspectorBorlandPainter
    CategoryFont.Charset = DEFAULT_CHARSET
    CategoryFont.Color = clBtnText
    CategoryFont.Height = -11
    CategoryFont.Name = 'Tahoma'
    CategoryFont.Style = []
    NameFont.Charset = DEFAULT_CHARSET
    NameFont.Color = clWindowText
    NameFont.Height = -11
    NameFont.Name = 'Tahoma'
    NameFont.Style = []
    ValueFont.Charset = DEFAULT_CHARSET
    ValueFont.Color = clNavy
    ValueFont.Height = -11
    ValueFont.Name = 'Tahoma'
    ValueFont.Style = []
    DrawNameEndEllipsis = False
    Left = 114
    Top = 48
  end
  object JvComputerInfoEx1: TJvComputerInfoEx
    Left = 112
    Top = 104
  end
end

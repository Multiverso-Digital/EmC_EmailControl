object FTypeAcct: TFTypeAcct
  Left = 0
  Top = 0
  Caption = 'mC-Type accounts'
  ClientHeight = 209
  ClientWidth = 218
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object RadioGroup1: TRadioGroup
    Left = 8
    Top = 8
    Width = 202
    Height = 185
    Cursor = crHandPoint
    Caption = 'Type of account to add'
    Items.Strings = (
      'POP3'
      'IMAP'
      'Hotmail')
    TabOrder = 0
    OnClick = RadioGroup1Click
  end
end

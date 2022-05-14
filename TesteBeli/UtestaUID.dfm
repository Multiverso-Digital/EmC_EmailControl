object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 546
  ClientWidth = 662
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 24
    Top = 80
    Width = 609
    Height = 305
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object Button1: TButton
    Left = 192
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Conecta'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 328
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Desconecta'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 488
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Retrive Raw'
    TabOrder = 3
    OnClick = Button3Click
  end
  object Edit1: TEdit
    Left = 488
    Top = 47
    Width = 121
    Height = 21
    TabOrder = 4
    Text = 'Edit1'
  end
  object POP: TIdPOP3
    AutoLogin = True
    Host = 'abreuretto.com'
    Username = 'abreu@abreu retto informatica'
    Password = 'aw112233'
    SASLMechanisms = <>
    Left = 24
    Top = 24
  end
  object IdAntiFreeze1: TIdAntiFreeze
    Left = 56
    Top = 24
  end
  object MSG: TIdMessage
    AttachmentEncoding = 'MIME'
    BccList = <>
    CCList = <>
    Encoding = meDefault
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 112
    Top = 24
  end
end

object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 286
  ClientWidth = 426
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
  object Label1: TLabel
    Left = 14
    Top = 20
    Width = 28
    Height = 13
    Caption = 'Texto'
  end
  object Label2: TLabel
    Left = 14
    Top = 60
    Width = 31
    Height = 13
    Caption = 'RegEx'
  end
  object Label3: TLabel
    Left = 11
    Top = 108
    Width = 30
    Height = 13
    Caption = 'Result'
  end
  object Label4: TLabel
    Left = 11
    Top = 148
    Width = 19
    Height = 13
    Caption = 'Left'
  end
  object Label5: TLabel
    Left = 11
    Top = 192
    Width = 25
    Height = 13
    Caption = 'Rigth'
  end
  object Edit1: TEdit
    Left = 48
    Top = 17
    Width = 370
    Height = 21
    TabOrder = 0
    Text = 'Este '#233' o email de abreu@abreuretto.com'
  end
  object Edit2: TEdit
    Left = 48
    Top = 57
    Width = 370
    Height = 21
    TabOrder = 1
    Text = 'Edit2'
  end
  object Button1: TButton
    Left = 176
    Top = 216
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Edit3: TEdit
    Left = 48
    Top = 105
    Width = 370
    Height = 21
    TabOrder = 3
    Text = 'Edit2'
  end
  object Edit4: TEdit
    Left = 48
    Top = 145
    Width = 370
    Height = 21
    TabOrder = 4
    Text = 'Edit2'
  end
  object Edit5: TEdit
    Left = 48
    Top = 189
    Width = 370
    Height = 21
    TabOrder = 5
    Text = 'Edit2'
  end
  object Texto: TPerlRegEx
    Options = []
    Left = 288
    Top = 232
  end
end

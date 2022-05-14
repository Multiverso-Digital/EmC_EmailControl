object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 286
  ClientWidth = 426
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object JvProgressBar1: TJvProgressBar
    Left = 104
    Top = 216
    Width = 201
    Height = 17
    TabOrder = 0
  end
  object Button1: TButton
    Left = 160
    Top = 152
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object MyConnection1: TMyConnection
    Database = 'emc'
    Username = 'root'
    Password = 'aw1122'
    Server = '192.168.0.10'
    Connected = True
    LoginPrompt = False
    Left = 72
    Top = 40
  end
  object MyTable1: TMyTable
    TableName = 'tab_token'
    Connection = MyConnection1
    Left = 240
    Top = 40
    object MyTable1ID: TIntegerField
      FieldName = 'ID'
    end
    object MyTable1palavra: TStringField
      FieldName = 'palavra'
      Size = 255
    end
    object MyTable1qtd_spam: TIntegerField
      FieldName = 'qtd_spam'
    end
    object MyTable1qtd_ok: TIntegerField
      FieldName = 'qtd_ok'
    end
    object MyTable1DT: TDateTimeField
      FieldName = 'DT'
    end
  end
end

object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 447
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
  object Button1: TButton
    Left = 120
    Top = 368
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 16
    Top = 8
    Width = 385
    Height = 169
    Lines.Strings = (
      'Memo1')
    TabOrder = 1
  end
  object Memo2: TMemo
    Left = 16
    Top = 193
    Width = 385
    Height = 169
    Lines.Strings = (
      'Memo1')
    TabOrder = 2
  end
  object IdDNSResolver1: TIdDNSResolver
    QueryType = [qtA]
    WaitingTime = 5000
    AllowRecursiveQueries = True
    Host = '207.225.209.66'
    IPVersion = Id_IPv4
    Left = 104
    Top = 64
  end
  object IdWhois1: TIdWhois
    Host = 'whois.internic.net'
    Left = 40
    Top = 64
  end
  object JvCreateProcess1: TJvCreateProcess
    ApplicationName = 'C:\WINXP\system32\nslookup.exe'
    CurrentDirectory = 'C:\WINXP\system32'
    Left = 288
    Top = 392
  end
end

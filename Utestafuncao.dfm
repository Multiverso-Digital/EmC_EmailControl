object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 543
  ClientWidth = 714
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
    Left = 16
    Top = 120
    Width = 657
    Height = 249
    Lines.Strings = (
      ''
      
        'Received: from 121.241.0.83.mumbai-static.vsnl.net.in ([121.241.' +
        '0.83]) by abreuretto.com with MailEnable ESMTP; Fri, 02 Jan '
      '2009 04:34:54 -0800'
      
        'Received: from localhost by mx.mtu-net.ru; Fri, 2 Jan 2009 18:04' +
        ':53 +0530'
      'Message-ID: <01c96d04$9c849080$5300f179@streamer08>'
      'From: =?koi8-r?B?IuzB0snTwSDrz9bV0s/XIg==?= '
      #9'<streamer08@mtu-net.ru>'
      'To: <abreu@abreuretto.com>'
      
        'Subject: =?koi8-r?B?7NXbycog18HSycHO1CDEzNEgzsXEz9LPx8/HzyDJINDS' +
        'ydTRzs/Hzw==?='
      #9'=?koi8-r?B?INDPxMHSy8EgwszJ2svJzSE=?='
      'Date: Fri, 2 Jan 2009 18:04:53 +0530'
      'MIME-Version: 1.0'
      'Content-Type: multipart/alternative;'
      #9'boundary="----=_NextPart_000_0007_01C96D04.9C849080"'
      'X-Priority: 3'
      'X-MSMail-Priority: Normal'
      'X-Mailer: Microsoft Outlook Express 6.00.2900.2180'
      'X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180'
      'Return-Path: <streamer08@mtu-net.ru>')
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Button1: TButton
    Left = 216
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 16
    Top = 424
    Width = 657
    Height = 21
    TabOrder = 2
    Text = 'Edit1'
  end
  object Button2: TButton
    Left = 376
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Button2'
    TabOrder = 3
    OnClick = Button2Click
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    HTTPOptions = [hoForceEncodeParams]
    Left = 56
    Top = 56
  end
  object XMLDocument1: TXMLDocument
    FileName = 'C:\teste.xml'
    Left = 136
    Top = 64
    DOMVendorDesc = 'MSXML'
  end
end

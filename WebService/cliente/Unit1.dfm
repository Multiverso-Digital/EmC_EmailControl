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
  PixelsPerInch = 96
  TextHeight = 13
  object SoapConnection1: TSoapConnection
    Agent = 'Borland SOAP 1.2'
    Connected = True
    URL = 'http://192.168.0.18/EmCService/EmCService.dll/soap/IDM'
    SOAPServerIID = 'IAppServerSOAP - {C99F4735-D6D2-495C-8CA2-E53E5A439E61}'
    UseSOAPAdapter = True
    Left = 64
    Top = 72
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftUnknown
        Name = 'Nume1'
        ParamType = ptUnknown
      end>
    ProviderName = 'prov_Qpais'
    RemoteServer = SoapConnection1
    Left = 152
    Top = 72
  end
end

object DM: TDM
  OldCreateOrder = False
  Height = 501
  Width = 594
  object MC: TMyConnection
    Database = 'emc'
    Options.UseUnicode = True
    Username = 'root'
    Password = 'aw1122'
    Server = '192.168.0.10'
    Connected = True
    LoginPrompt = False
    Left = 96
    Top = 48
  end
  object MyQuery1: TMyQuery
    Connection = MC
    Left = 184
    Top = 48
  end
  object POP: TIdPOP3
    AutoLogin = True
    SASLMechanisms = <>
    Left = 88
    Top = 144
  end
  object IdAntiFreeze1: TIdAntiFreeze
    Left = 152
    Top = 144
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
    Left = 224
    Top = 144
  end
end

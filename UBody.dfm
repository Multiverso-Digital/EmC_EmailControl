object FBody: TFBody
  Left = 0
  Top = 0
  Caption = 'mC-Message Body'
  ClientHeight = 565
  ClientWidth = 740
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 740
    Height = 101
    Align = alTop
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object Label1: TLabel
      Left = 6
      Top = 12
      Width = 28
      Height = 13
      Caption = 'From:'
    end
    object Label2: TLabel
      Left = 6
      Top = 33
      Width = 16
      Height = 13
      Caption = 'To:'
    end
    object Label3: TLabel
      Left = 6
      Top = 57
      Width = 40
      Height = 13
      Caption = 'Subject:'
    end
    object Label4: TLabel
      Left = 7
      Top = 79
      Width = 27
      Height = 13
      Caption = 'Date:'
    end
    object Label5: TLabel
      Left = 440
      Top = 38
      Width = 16
      Height = 13
      Caption = 'Cc:'
      Visible = False
    end
    object Label6: TLabel
      Left = 415
      Top = 12
      Width = 41
      Height = 13
      Caption = 'Attachs:'
      Visible = False
    end
    object CBAttach: TComboBox
      Left = 462
      Top = 9
      Width = 267
      Height = 21
      Cursor = crHandPoint
      Style = csDropDownList
      Ctl3D = False
      Enabled = False
      ItemHeight = 13
      ParentCtl3D = False
      TabOrder = 0
      Visible = False
      OnClick = CBAttachClick
    end
    object CBCC: TComboBox
      Left = 463
      Top = 36
      Width = 266
      Height = 21
      Cursor = crHandPoint
      BevelEdges = []
      BevelInner = bvNone
      BevelOuter = bvNone
      Style = csDropDownList
      Ctl3D = False
      ItemHeight = 13
      ParentCtl3D = False
      TabOrder = 1
      Visible = False
    end
    object Efrom: TEdit
      Left = 57
      Top = 12
      Width = 352
      Height = 19
      BevelEdges = []
      BevelOuter = bvNone
      BorderStyle = bsNone
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 2
    end
    object ETo: TEdit
      Left = 57
      Top = 33
      Width = 352
      Height = 19
      BevelEdges = []
      BevelOuter = bvNone
      BorderStyle = bsNone
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 3
    end
    object Esubject: TEdit
      Left = 57
      Top = 57
      Width = 672
      Height = 19
      BevelEdges = []
      BevelOuter = bvNone
      BorderStyle = bsNone
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 4
    end
    object Edate: TEdit
      Left = 57
      Top = 78
      Width = 280
      Height = 19
      BevelEdges = []
      BevelOuter = bvNone
      BorderStyle = bsNone
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 5
    end
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 101
    Width = 740
    Height = 52
    ButtonHeight = 52
    ButtonWidth = 120
    Caption = 'ToolBar1'
    Color = clSkyBlue
    Images = Fmain.ilGFX32
    GradientDrawingOptions = []
    ParentColor = False
    ShowCaptions = True
    TabOrder = 1
    object ToolButton1: TToolButton
      Left = 0
      Top = 0
      Cursor = crHandPoint
      Caption = 'Quick response'
      Grouped = True
      ImageIndex = 16
      OnClick = ToolButton1Click
    end
    object ToolButton4: TToolButton
      Left = 120
      Top = 0
      Width = 8
      Caption = 'ToolButton4'
      ImageIndex = 19
      Style = tbsSeparator
    end
    object ToolButton2: TToolButton
      Left = 128
      Top = 0
      Cursor = crHandPoint
      Caption = 'Show Header'
      Grouped = True
      ImageIndex = 20
      OnClick = ToolButton2Click
    end
    object ToolButton3: TToolButton
      Left = 248
      Top = 0
      Cursor = crHandPoint
      Caption = 'Show Source'
      Grouped = True
      ImageIndex = 18
      OnClick = ToolButton3Click
    end
    object ToolButton5: TToolButton
      Left = 368
      Top = 0
      Cursor = crHandPoint
      Caption = 'Show message'
      Grouped = True
      ImageIndex = 23
      OnClick = ToolButton5Click
    end
    object ToolButton6: TToolButton
      Left = 488
      Top = 0
      Cursor = crHandPoint
      Caption = 'Attachment WARNIG!!!'
      ImageIndex = 31
      Visible = False
      OnClick = ToolButton6Click
    end
  end
  object WebBrowser1: TWebBrowser
    Left = 0
    Top = 153
    Width = 740
    Height = 393
    Align = alClient
    TabOrder = 2
    OnStatusTextChange = WebBrowser1StatusTextChange
    ExplicitTop = 163
    ExplicitHeight = 402
    ControlData = {
      4C0000007B4C00009E2800000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 546
    Width = 740
    Height = 19
    Panels = <
      item
        Width = 500
      end>
  end
  object JvMail1: TJvMail
    BlindCopy = <>
    CarbonCopy = <>
    ReadOptions = [roHeaderOnly]
    Recipient = <>
    Left = 224
    Top = 372
  end
  object JvHTMLParser1: TJvHTMLParser
    Left = 432
    Top = 344
  end
end

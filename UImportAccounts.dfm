object FImportAccounts: TFImportAccounts
  Left = 0
  Top = 0
  Caption = 'mC-Import Accounts'
  ClientHeight = 283
  ClientWidth = 426
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
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 410
    Height = 265
    Caption = 'Import Accounts from old EmC version'
    Color = clWhite
    ParentBackground = False
    ParentColor = False
    TabOrder = 0
    object JvImgBtn1: TJvImgBtn
      Left = 72
      Top = 48
      Width = 233
      Height = 25
      Cursor = crHandPoint
      Caption = 'Import accounts from last EmC version'
      ImageIndex = 1
      Images = Fmain.ilGFX16
      TabOrder = 0
      OnClick = JvImgBtn1Click
      Animate = True
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'Tahoma'
      HotTrackFont.Style = []
    end
    object Panel1: TPanel
      Left = 2
      Top = 238
      Width = 406
      Height = 25
      Align = alBottom
      Alignment = taLeftJustify
      BevelInner = bvRaised
      BevelOuter = bvLowered
      Color = clWhite
      ParentBackground = False
      TabOrder = 1
      Visible = False
    end
    object JvHTListBox1: TJvHTListBox
      Left = 96
      Top = 79
      Width = 193
      Height = 18
      HideSel = False
      ColorHighlight = clHighlight
      ColorHighlightText = clHighlightText
      ColorDisabledText = clGrayText
      TabOrder = 2
      Visible = False
    end
    object JvImgBtn2: TJvImgBtn
      Left = 72
      Top = 112
      Width = 233
      Height = 25
      Cursor = crHandPoint
      Caption = 'Import accounts from MS-Outlook'
      ImageIndex = 16
      Images = Fmain.ilGFX16
      TabOrder = 3
      OnClick = JvImgBtn2Click
      Animate = True
      HotTrackFont.Charset = DEFAULT_CHARSET
      HotTrackFont.Color = clWindowText
      HotTrackFont.Height = -11
      HotTrackFont.Name = 'Tahoma'
      HotTrackFont.Style = []
    end
  end
  object JvSearchFiles1: TJvSearchFiles
    RootDirectory = 'C:\'
    DirParams.SearchTypes = [stFileMask]
    FileParams.SearchTypes = [stFileMask]
    FileParams.FileMasks.Strings = (
      'ini')
    OnBeginScanDir = JvSearchFiles1BeginScanDir
    OnFindFile = JvSearchFiles1FindFile
    OnProgress = JvSearchFiles1Progress
    Left = 328
    Top = 72
  end
end

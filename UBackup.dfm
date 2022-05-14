object Fbackup: TFbackup
  Left = 0
  Top = 0
  Caption = 'mC-Backup/Restore system files'
  ClientHeight = 286
  ClientWidth = 403
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 403
    Height = 286
    ActivePage = TabSheet2
    Align = alClient
    Style = tsButtons
    TabOrder = 0
    ExplicitWidth = 426
    object TabSheet1: TTabSheet
      Caption = 'Backup'
      ExplicitWidth = 405
      object GroupBox1: TGroupBox
        Left = 3
        Top = 3
        Width = 390
        Height = 241
        Caption = 'Backup System Files - select the target folder'
        TabOrder = 0
        object Label1: TLabel
          Left = 24
          Top = 34
          Width = 143
          Height = 13
          Caption = 'Select target folder to backup'
        end
        object JvDir: TJvDirectoryEdit
          Left = 24
          Top = 48
          Width = 338
          Height = 21
          OnAfterDialog = JvDirAfterDialog
          DialogKind = dkWin32
          TabOrder = 0
        end
        object ListBox1: TListBox
          Left = 24
          Top = 75
          Width = 338
          Height = 97
          ItemHeight = 13
          TabOrder = 1
        end
        object Button1: TButton
          Left = 152
          Top = 178
          Width = 75
          Height = 25
          Cursor = crHandPoint
          Caption = 'BackUp'
          TabOrder = 2
          OnClick = Button1Click
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Restore'
      ImageIndex = 1
      ExplicitWidth = 418
      object GroupBox2: TGroupBox
        Left = 3
        Top = 0
        Width = 389
        Height = 252
        Caption = 'Restore backup - Select source folder'
        TabOrder = 0
        object Label2: TLabel
          Left = 24
          Top = 34
          Width = 149
          Height = 13
          Caption = 'Select source folder to Restore'
        end
        object JvDirRes: TJvDirectoryEdit
          Left = 24
          Top = 48
          Width = 321
          Height = 21
          OnAfterDialog = JvDirResAfterDialog
          DialogKind = dkWin32
          TabOrder = 0
        end
        object Button2: TButton
          Left = 152
          Top = 207
          Width = 75
          Height = 25
          Cursor = crHandPoint
          Caption = 'Restore'
          TabOrder = 1
          OnClick = Button2Click
        end
        object ListBox2: TListBox
          Left = 24
          Top = 75
          Width = 338
          Height = 97
          ItemHeight = 13
          TabOrder = 2
        end
      end
    end
  end
  object JvFile: TJvSearchFiles
    Options = [soSearchFiles, soStripDirs]
    FileParams.SearchTypes = [stFileMask]
    FileParams.FileMasks.Strings = (
      '*.cds'
      '*.dat')
    Left = 288
    Top = 40
  end
end

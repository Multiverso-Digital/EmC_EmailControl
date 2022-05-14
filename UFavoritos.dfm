object FFavoritos: TFFavoritos
  Left = 0
  Top = 0
  Caption = 'mC-My Friends List'
  ClientHeight = 566
  ClientWidth = 671
  Color = clMoneyGreen
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 671
    Height = 566
    Align = alClient
    TabOrder = 0
    object PageControl1: TPageControl
      Left = 2
      Top = 15
      Width = 663
      Height = 549
      Cursor = crHandPoint
      ActivePage = TabSheet1
      Style = tsButtons
      TabOrder = 0
      OnChange = PageControl1Change
      object TabSheet1: TTabSheet
        Caption = 'E-Mail'
        object Label1: TLabel
          Left = 2
          Top = 4
          Width = 37
          Height = 13
          Caption = 'Search:'
        end
        object Label5: TLabel
          Left = 351
          Top = 505
          Width = 3
          Height = 13
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object GroupBox3: TGroupBox
          Left = 357
          Top = 0
          Width = 269
          Height = 121
          Caption = 'Actions'
          TabOrder = 0
          object Label2: TLabel
            Left = 3
            Top = 26
            Width = 28
            Height = 13
            Caption = 'E-Mail'
          end
          object Label9: TLabel
            Left = 4
            Top = 66
            Width = 231
            Height = 13
            Cursor = crHandPoint
            Hint = 'Example: Pa?l@domain.com  '
            Caption = 'Use  ? to accept 0 or more characters in position'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsUnderline]
            ParentFont = False
            ParentShowHint = False
            ShowHint = False
            Visible = False
            OnClick = Label9Click
          end
          object Label10: TLabel
            Left = 4
            Top = 81
            Width = 246
            Height = 13
            Cursor = crHandPoint
            Hint = 'Example: Pa+l@domain.com'
            Caption = 'Use + to accept one or more  characters in position'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsUnderline]
            ParentFont = False
            ParentShowHint = False
            ShowHint = False
            Visible = False
            OnClick = Label9Click
          end
          object Label11: TLabel
            Left = 4
            Top = 96
            Width = 195
            Height = 13
            Cursor = crHandPoint
            Hint = 'Example: *@domain.com   or  *Paul*@domain.*'
            Caption = 'Use * to accept any characters or words'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsUnderline]
            ParentFont = False
            ParentShowHint = False
            ShowHint = False
            Visible = False
            OnClick = Label9Click
          end
          object EEmail: TEdit
            Left = 3
            Top = 39
            Width = 263
            Height = 21
            TabOrder = 0
          end
          object Button4: TButton
            Left = 34
            Top = 76
            Width = 191
            Height = 25
            Cursor = crHandPoint
            Caption = 'Add/Save'
            TabOrder = 1
            OnClick = Button4Click
          end
        end
        object GroupBox6: TGroupBox
          Left = 357
          Top = 127
          Width = 266
          Height = 274
          Caption = 'Import'
          TabOrder = 1
          object Label8: TLabel
            Left = 30
            Top = 142
            Width = 155
            Height = 13
            Caption = 'Windows Vista - Contacts Folder'
            Visible = False
          end
          object Button3: TButton
            Left = 32
            Top = 195
            Width = 191
            Height = 25
            Cursor = crHandPoint
            Caption = 'Import'
            TabOrder = 0
            OnClick = Button3Click
          end
          object CBAdress: TRadioButton
            Left = 15
            Top = 60
            Width = 184
            Height = 17
            Caption = 'From Windows Address Book'
            TabOrder = 1
            OnClick = CBEmCClick
          end
          object CBTexto: TRadioButton
            Left = 15
            Top = 39
            Width = 200
            Height = 17
            Caption = 'From Text File(One line per e-mail)'
            TabOrder = 2
            OnClick = CBEmCClick
          end
          object CBEmC: TRadioButton
            Left = 15
            Top = 20
            Width = 138
            Height = 17
            Caption = 'From old EmC version'
            TabOrder = 3
            OnClick = CBEmCClick
          end
          object CBOutLook: TRadioButton
            Left = 15
            Top = 81
            Width = 200
            Height = 17
            Caption = 'From Outlook Contacts'
            TabOrder = 4
            OnClick = CBEmCClick
          end
          object CBGoogle: TRadioButton
            Left = 15
            Top = 103
            Width = 200
            Height = 17
            Caption = 'From Google Contacts (comming soon)'
            TabOrder = 5
            OnClick = CBEmCClick
          end
          object CBVista: TRadioButton
            Left = 15
            Top = 125
            Width = 200
            Height = 17
            Caption = 'From Windows Vista Contacts'
            TabOrder = 6
            OnClick = CBVistaClick
          end
          object JDir: TJvDirectoryEdit
            Left = 31
            Top = 154
            Width = 230
            Height = 21
            OnAfterDialog = JDirAfterDialog
            DialogKind = dkWin32
            TabOrder = 7
            Visible = False
          end
        end
        object PB: TProgressBar
          Left = 390
          Top = 353
          Width = 190
          Height = 17
          TabOrder = 2
          Visible = False
        end
        object Edit1: TEdit
          Left = 40
          Top = 1
          Width = 302
          Height = 21
          TabOrder = 3
          OnKeyPress = Edit1KeyPress
        end
        object LBFav_Email: TJvxCheckListBox
          Left = 3
          Top = 28
          Width = 339
          Height = 490
          ItemHeight = 13
          PopupMenu = PopupMenu1
          Sorted = True
          TabOrder = 4
          OnStateChange = LBFav_EmailStateChange
          InternalVersion = 202
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Domains'
        ImageIndex = 1
        object Label4: TLabel
          Left = 2
          Top = 4
          Width = 37
          Height = 13
          Caption = 'Search:'
        end
        object Label6: TLabel
          Left = 354
          Top = 505
          Width = 3
          Height = 13
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object GroupBox5: TGroupBox
          Left = 348
          Top = 0
          Width = 293
          Height = 121
          Caption = 'Actions'
          TabOrder = 0
          object Label3: TLabel
            Left = 3
            Top = 26
            Width = 175
            Height = 13
            Caption = 'Domain(example: @abreuretto.com)'
          end
          object Label12: TLabel
            Left = 4
            Top = 66
            Width = 231
            Height = 13
            Cursor = crHandPoint
            Hint = 'Example: Pa?l@domain.com  '
            Caption = 'Use  ? to accept 0 or more characters in position'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsUnderline]
            ParentFont = False
            ParentShowHint = False
            ShowHint = False
            Visible = False
            OnClick = Label9Click
          end
          object Label13: TLabel
            Left = 4
            Top = 81
            Width = 246
            Height = 13
            Cursor = crHandPoint
            Hint = 'Example: Pa+l@domain.com'
            Caption = 'Use + to accept one or more  characters in position'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsUnderline]
            ParentFont = False
            ParentShowHint = False
            ShowHint = False
            Visible = False
            OnClick = Label9Click
          end
          object Label14: TLabel
            Left = 4
            Top = 96
            Width = 195
            Height = 13
            Cursor = crHandPoint
            Hint = 'Example: *@domain.com   or  *Paul*@domain.*'
            Caption = 'Use * to accept any characters or words'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsUnderline]
            ParentFont = False
            ParentShowHint = False
            ShowHint = False
            Visible = False
            OnClick = Label9Click
          end
          object Edomain: TEdit
            Left = 3
            Top = 39
            Width = 263
            Height = 21
            TabOrder = 0
          end
          object Button2: TButton
            Left = 42
            Top = 85
            Width = 191
            Height = 25
            Cursor = crHandPoint
            Caption = 'Add/Save'
            TabOrder = 1
            OnClick = Button2Click
          end
        end
        object Edit2: TEdit
          Left = 40
          Top = 1
          Width = 302
          Height = 21
          TabOrder = 1
          OnKeyPress = Edit2KeyPress
        end
        object LBFav_Domain: TJvxCheckListBox
          Left = 3
          Top = 28
          Width = 339
          Height = 490
          ItemHeight = 13
          PopupMenu = PopupMenu2
          Sorted = True
          TabOrder = 2
          OnStateChange = LBFav_DomainStateChange
          InternalVersion = 202
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'Header Filters'
        ImageIndex = 2
        object Label7: TLabel
          Left = 3
          Top = 3
          Width = 272
          Height = 13
          Caption = 'Name Rules Filter (My Friends) - Double click to access it.'
        end
        object JvListBox1: TJvListBox
          Left = 3
          Top = 16
          Width = 649
          Height = 502
          Cursor = crHandPoint
          Columns = 3
          ItemHeight = 13
          Background.FillMode = bfmTile
          Background.Visible = False
          PopupMenu = PopupMenu3
          TabOrder = 0
          OnDblClick = JvListBox1DblClick
        end
      end
    end
  end
  object JvGridFilter1: TJvGridFilter
    Left = 192
    Top = 65376
  end
  object PopupMenu1: TPopupMenu
    Left = 176
    Top = 184
    object DeleteselectedEmail1: TMenuItem
      Caption = 'Delete selecteds E-mail'
      OnClick = DeleteselectedEmail1Click
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 280
    Top = 184
    object MenuItem1: TMenuItem
      Caption = 'Delete selecteds Domain'
      OnClick = MenuItem1Click
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'ini'
    FileName = 'EmCFavoritos.ini'
    Filter = 'Favoritos|*.ini'
    Left = 320
    Top = 280
  end
  object OpenDialog2: TOpenDialog
    DefaultExt = 'ini'
    Filter = 'Favoritos|*.txt'
    Left = 584
    Top = 168
  end
  object PopupMenu3: TPopupMenu
    Left = 240
    Top = 112
    object ShowthisRule1: TMenuItem
      Caption = 'Show this Rule'
      OnClick = JvListBox1DblClick
    end
  end
  object OutlookApplication1: TOutlookApplication
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    AutoQuit = False
    Left = 136
    Top = 328
  end
  object JvMail1: TJvMail
    BlindCopy = <>
    CarbonCopy = <>
    ReadOptions = [roHeaderOnly]
    Recipient = <>
    Left = 216
    Top = 324
  end
  object JvSimpleXML1: TJvSimpleXML
    IndentString = '  '
    Left = 200
    Top = 392
  end
  object JvSearchFiles1: TJvSearchFiles
    RootDirectory = 'C:\'
    DirParams.SearchTypes = [stFileMask]
    FileParams.SearchTypes = [stFileMask]
    FileParams.FileMasks.Strings = (
      '*.contact')
    OnFindFile = JvSearchFiles1FindFile
    Left = 72
    Top = 440
  end
end

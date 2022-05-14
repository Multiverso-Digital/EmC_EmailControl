object Form1: TForm1
  Left = 197
  Top = 110
  Width = 776
  Height = 598
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 265
    Top = 0
    Width = 503
    Height = 571
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'Memo1')
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 265
    Height = 571
    Align = alLeft
    TabOrder = 1
    object extension_edit_: TEdit
      Left = 8
      Top = 520
      Width = 41
      Height = 21
      TabOrder = 0
      Text = '*.pas'
      OnChange = extension_edit_Change
    end
    object evaluate_trial_: TButton
      Left = 176
      Top = 528
      Width = 80
      Height = 25
      Caption = 'evaluate_trial_'
      TabOrder = 1
      OnClick = evaluate_trial_Click
    end
    object DirectoryListBox1: TDirectoryListBox
      Left = 8
      Top = 216
      Width = 145
      Height = 169
      FileList = FileListBox1
      ItemHeight = 16
      TabOrder = 2
      OnChange = DirectoryListBox1Change
    end
    object all_dir_: TButton
      Left = 160
      Top = 219
      Width = 63
      Height = 25
      Caption = 'all_dir_'
      TabOrder = 3
      OnClick = all_dir_Click
    end
    object all_dir_recursive_: TButton
      Left = 160
      Top = 246
      Width = 97
      Height = 25
      Caption = 'all_dir_recursive_'
      TabOrder = 4
      OnClick = all_dir_recursive_Click
    end
    object FileListBox1: TFileListBox
      Left = 8
      Top = 392
      Width = 249
      Height = 121
      ItemHeight = 13
      TabOrder = 5
      OnClick = FileListBox1Click
    end
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 263
      Height = 41
      Align = alTop
      TabOrder = 6
      object exit_: TButton
        Left = 8
        Top = 8
        Width = 44
        Height = 25
        Caption = 'exit_'
        TabOrder = 0
        OnClick = exit_Click
      end
      object clear_: TButton
        Left = 208
        Top = 8
        Width = 44
        Height = 25
        Caption = 'clear_'
        TabOrder = 1
        OnClick = clear_Click
      end
    end
    object PageControl1: TPageControl
      Left = 1
      Top = 42
      Width = 263
      Height = 135
      ActivePage = query_
      Align = alTop
      TabIndex = 0
      TabOrder = 7
      object query_: TTabSheet
        Caption = 'query_'
        object search_edit_: TEdit
          Left = 6
          Top = 8
          Width = 249
          Height = 21
          TabOrder = 0
          Text = 'interbase'
        end
        object case_insensitive_: TCheckBox
          Left = 8
          Top = 40
          Width = 105
          Height = 17
          Caption = 'case_insensitive_'
          TabOrder = 1
        end
      end
      object expressions_: TTabSheet
        Caption = 'expressions_'
        ImageIndex = 1
        object sample_requests_listbox_: TListBox
          Left = 0
          Top = 0
          Width = 255
          Height = 107
          Align = alClient
          ItemHeight = 13
          TabOrder = 0
          OnClick = sample_requests_listbox_Click
        end
      end
    end
    object felix_: TButton
      Left = 8
      Top = 184
      Width = 41
      Height = 25
      Caption = 'felix_'
      Enabled = False
      TabOrder = 8
      OnClick = felix_Click
    end
    object programs_: TButton
      Left = 56
      Top = 184
      Width = 75
      Height = 25
      Caption = 'programs_'
      Enabled = False
      TabOrder = 9
      OnClick = programs_Click
    end
  end
end

object Form1: TForm1
  Left = 208
  Top = 152
  Width = 776
  Height = 567
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 249
    Top = 0
    Width = 2
    Height = 533
    Color = clYellow
    ParentColor = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 249
    Height = 533
    Align = alLeft
    TabOrder = 0
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 247
      Height = 40
      Align = alTop
      TabOrder = 0
      object exit_: TButton
        Left = 16
        Top = 8
        Width = 42
        Height = 25
        Caption = 'exit_'
        TabOrder = 0
        OnClick = exit_Click
      end
      object clear_: TButton
        Left = 172
        Top = 8
        Width = 42
        Height = 25
        Caption = 'clear_'
        TabOrder = 1
        OnClick = clear_Click
      end
    end
    object Panel3: TPanel
      Left = 1
      Top = 41
      Width = 247
      Height = 329
      Align = alClient
      TabOrder = 1
      object Splitter2: TSplitter
        Left = 1
        Top = 115
        Width = 245
        Height = 2
        Cursor = crVSplit
        Align = alTop
        Color = clYellow
        ParentColor = False
      end
      object DirectoryListBox1: TDirectoryListBox
        Left = 1
        Top = 1
        Width = 245
        Height = 114
        Align = alTop
        FileList = FileListBox1
        ItemHeight = 16
        TabOrder = 0
        OnChange = DirectoryListBox1Change
      end
      object FileListBox1: TFileListBox
        Left = 1
        Top = 194
        Width = 245
        Height = 134
        Align = alClient
        ItemHeight = 13
        Mask = '*.txt'
        TabOrder = 1
        OnClick = FileListBox1Click
      end
      object Panel5: TPanel
        Left = 1
        Top = 117
        Width = 245
        Height = 77
        Align = alTop
        TabOrder = 2
        object Label3: TLabel
          Left = 56
          Top = 8
          Width = 25
          Height = 13
          Caption = 'spam'
        end
        object Label4: TLabel
          Left = 136
          Top = 8
          Width = 12
          Height = 13
          Caption = 'ok'
        end
        object Label5: TLabel
          Left = 16
          Top = 35
          Width = 60
          Height = 13
          Caption = 'train_vs_test'
        end
        object spam_: TCheckBox
          Left = 5
          Top = 7
          Width = 50
          Height = 17
          Caption = 'spam_'
          TabOrder = 0
        end
        object max_spam_edit_: TEdit
          Left = 88
          Top = 5
          Width = 41
          Height = 21
          TabOrder = 1
          Text = '2900'
        end
        object max_ok_edit_: TEdit
          Left = 152
          Top = 5
          Width = 47
          Height = 21
          TabOrder = 2
          Text = '4800'
        end
        object all_: TButton
          Left = 208
          Top = 5
          Width = 33
          Height = 25
          Caption = 'all_'
          TabOrder = 3
          OnClick = all_Click
        end
        object spam_sampling_edit_: TEdit
          Left = 88
          Top = 32
          Width = 40
          Height = 21
          TabOrder = 4
          Text = '80'
        end
        object ok_sampling_edit_: TEdit
          Left = 152
          Top = 32
          Width = 48
          Height = 21
          TabOrder = 5
          Text = '4'
        end
        object load_mail_: TCheckBox
          Left = 8
          Top = 55
          Width = 97
          Height = 17
          Caption = 'load_mail_'
          Checked = True
          State = cbChecked
          TabOrder = 6
        end
      end
    end
    object Panel4: TPanel
      Left = 1
      Top = 370
      Width = 247
      Height = 162
      Align = alBottom
      TabOrder = 2
      object Label2: TLabel
        Left = 24
        Top = 104
        Width = 50
        Height = 13
        Caption = 'keep_best'
      end
      object all_dir_: TButton
        Left = 8
        Top = 8
        Width = 63
        Height = 25
        Caption = 'all_dir_'
        TabOrder = 0
        OnClick = all_dir_Click
      end
      object all_dir_recursive_: TButton
        Left = 144
        Top = 8
        Width = 89
        Height = 25
        Caption = 'all_dir_recursive_'
        TabOrder = 1
        OnClick = all_dir_recursive_Click
      end
      object compute: TButton
        Left = 64
        Top = 40
        Width = 57
        Height = 25
        Caption = 'compute'
        TabOrder = 2
        OnClick = computeClick
      end
      object display_frequency_: TButton
        Left = 128
        Top = 40
        Width = 113
        Height = 25
        Caption = 'display_frequency_'
        TabOrder = 3
        OnClick = display_frequency_Click
      end
      object compute_probabilities_: TButton
        Left = 8
        Top = 72
        Width = 116
        Height = 25
        Caption = 'compute_probabilities_'
        TabOrder = 4
        OnClick = compute_probabilities_Click
      end
      object test_ok_mail_: TButton
        Left = 8
        Top = 128
        Width = 71
        Height = 25
        Caption = 'test_ok_mail_'
        TabOrder = 5
        OnClick = test_ok_mail_Click
      end
      object display_proba_: TButton
        Left = 130
        Top = 72
        Width = 73
        Height = 25
        Caption = 'display_proba_'
        TabOrder = 6
        OnClick = display_proba_Click
      end
      object test_spam_mail_: TButton
        Left = 85
        Top = 128
        Width = 90
        Height = 25
        Caption = 'test_spam_mail_'
        TabOrder = 7
        OnClick = test_spam_mail_Click
      end
      object best_count_edit_: TEdit
        Left = 88
        Top = 101
        Width = 44
        Height = 21
        TabOrder = 8
        Text = '15'
      end
      object mail_: TCheckBox
        Left = 8
        Top = 42
        Width = 48
        Height = 17
        Caption = 'mail_'
        Checked = True
        State = cbChecked
        TabOrder = 9
      end
      object sort_: TButton
        Left = 210
        Top = 72
        Width = 30
        Height = 25
        Caption = 'sort_'
        TabOrder = 10
        OnClick = sort_Click
      end
      object new_mail_: TButton
        Left = 181
        Top = 128
        Width = 63
        Height = 25
        Caption = 'new_mail_'
        TabOrder = 11
      end
    end
  end
  object PageControl1: TPageControl
    Left = 251
    Top = 0
    Width = 517
    Height = 533
    ActivePage = display_
    Align = alClient
    TabOrder = 1
    object display_: TTabSheet
      Caption = 'display_'
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 509
        Height = 505
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
    end
    object parameters_: TTabSheet
      Caption = 'parameters_'
      ImageIndex = 3
      object Label1: TLabel
        Left = 24
        Top = 16
        Width = 84
        Height = 13
        Caption = 'token_length_min'
      end
      object Label6: TLabel
        Left = 24
        Top = 40
        Width = 76
        Height = 13
        Caption = 'buffer_size_max'
      end
      object Label7: TLabel
        Left = 24
        Top = 64
        Width = 82
        Height = 13
        Caption = 'ok_token_weight'
      end
      object Label8: TLabel
        Left = 24
        Top = 88
        Width = 74
        Height = 13
        Caption = 'in_token_count'
      end
      object Label9: TLabel
        Left = 24
        Top = 112
        Width = 48
        Height = 13
        Caption = 'score_min'
      end
      object Label11: TLabel
        Left = 24
        Top = 160
        Width = 95
        Height = 13
        Caption = 'certain_spam_score'
      end
      object Label12: TLabel
        Left = 24
        Top = 184
        Width = 96
        Height = 13
        Caption = 'certain_spam_count'
      end
      object Label10: TLabel
        Left = 24
        Top = 136
        Width = 86
        Height = 13
        Caption = 'likely_spam_score'
      end
      object token_length_min_edit_: TEdit
        Left = 152
        Top = 16
        Width = 121
        Height = 21
        TabOrder = 0
        Text = '6'
      end
      object buffer_size_max_edit_: TEdit
        Left = 152
        Top = 40
        Width = 121
        Height = 21
        TabOrder = 1
        Text = '4096'
      end
      object ok_token_weight_edit_: TEdit
        Left = 152
        Top = 64
        Width = 121
        Height = 21
        TabOrder = 2
        Text = '2'
      end
      object min_token_count_edit_: TEdit
        Left = 152
        Top = 88
        Width = 121
        Height = 21
        TabOrder = 3
        Text = '5'
      end
      object score_min_edit_: TEdit
        Left = 152
        Top = 112
        Width = 121
        Height = 21
        TabOrder = 4
        Text = '0.40'
      end
      object likely_spam_score_edit_: TEdit
        Left = 152
        Top = 136
        Width = 121
        Height = 21
        TabOrder = 5
        Text = '0.998'
      end
      object certain_spam_score_edit_: TEdit
        Left = 152
        Top = 160
        Width = 121
        Height = 21
        TabOrder = 6
        Text = '0.9998'
      end
      object certain_spam_count_edit_: TEdit
        Left = 152
        Top = 184
        Width = 121
        Height = 21
        TabOrder = 7
        Text = '10'
      end
      object set_parameters_: TButton
        Left = 240
        Top = 224
        Width = 105
        Height = 25
        Caption = 'set_parameters_'
        TabOrder = 8
        OnClick = set_parameters_Click
      end
    end
    object result_: TTabSheet
      Caption = 'result_'
      ImageIndex = 2
      object Splitter3: TSplitter
        Left = 0
        Top = 169
        Width = 509
        Height = 2
        Cursor = crVSplit
        Align = alTop
        Color = clYellow
        ParentColor = False
      end
      object result_panel_: TPanel
        Left = 0
        Top = 0
        Width = 509
        Height = 41
        Align = alTop
        TabOrder = 0
        object train_spam_: TLabel
          Left = 8
          Top = 6
          Width = 57
          Height = 13
          Caption = 'train_spam_'
        end
        object train_ok_: TLabel
          Left = 200
          Top = 6
          Width = 44
          Height = 13
          Caption = 'train_ok_'
        end
        object test_spam_: TLabel
          Left = 8
          Top = 24
          Width = 54
          Height = 13
          Caption = 'test_spam_'
        end
        object test_ok_: TLabel
          Left = 200
          Top = 24
          Width = 41
          Height = 13
          Caption = 'test_ok_'
        end
        object train_time_: TLabel
          Left = 392
          Top = 6
          Width = 51
          Height = 13
          Caption = 'train_time_'
        end
      end
      object result_listbox_: TListBox
        Left = 0
        Top = 41
        Width = 509
        Height = 128
        Align = alTop
        ItemHeight = 13
        Sorted = True
        TabOrder = 1
        OnClick = result_listbox_Click
      end
      object result_memo_: TMemo
        Left = 0
        Top = 171
        Width = 509
        Height = 334
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
        TabOrder = 2
      end
    end
    object parse_mail_: TTabSheet
      Caption = 'parse_mail_'
      ImageIndex = 3
      object Splitter5: TSplitter
        Left = 0
        Top = 105
        Width = 509
        Height = 2
        Cursor = crVSplit
        Align = alTop
        Color = clYellow
        ParentColor = False
      end
      object Panel7: TPanel
        Left = 0
        Top = 0
        Width = 509
        Height = 105
        Align = alTop
        Caption = 'Panel7'
        TabOrder = 0
        object Splitter4: TSplitter
          Left = 273
          Top = 1
          Width = 2
          Height = 103
          Color = clYellow
          ParentColor = False
        end
        object mail_header_memo_: TMemo
          Left = 1
          Top = 1
          Width = 272
          Height = 103
          Align = alLeft
          Lines.Strings = (
            'Memo2')
          ScrollBars = ssVertical
          TabOrder = 0
        end
        object mail_mime_content_memo_: TMemo
          Left = 275
          Top = 1
          Width = 233
          Height = 103
          Align = alClient
          Lines.Strings = (
            'mail_mime_content_memo_')
          ScrollBars = ssVertical
          TabOrder = 1
        end
      end
      object PageControl2: TPageControl
        Left = 0
        Top = 148
        Width = 509
        Height = 405
        ActivePage = raw_mail_
        Align = alCustom
        TabOrder = 1
        object raw_mail_: TTabSheet
          Caption = 'raw_mail_'
          ImageIndex = 2
          object raw_mail_memo_: TMemo
            Left = 0
            Top = 0
            Width = 501
            Height = 377
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
        end
        object debug_reader_: TTabSheet
          Caption = 'debug_reader_'
          object mail_memo_: TMemo
            Left = 0
            Top = 0
            Width = 501
            Height = 377
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
        end
        object mail_content_: TTabSheet
          Caption = 'mail_content_'
          ImageIndex = 1
          object mail_content_memo_: TMemo
            Left = 0
            Top = 0
            Width = 501
            Height = 377
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
        end
        object token_list_: TTabSheet
          Caption = 'token_list_'
          ImageIndex = 3
          object test_token_list_memo_: TMemo
            Left = 0
            Top = 0
            Width = 501
            Height = 377
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
        end
        object sorted_token_list_: TTabSheet
          Caption = 'sorted_token_list_'
          ImageIndex = 4
          object test_sorted_token_listbox_: TListBox
            Left = 0
            Top = 0
            Width = 501
            Height = 377
            Align = alClient
            ItemHeight = 13
            Sorted = True
            TabOrder = 0
          end
        end
      end
      object Panel6: TPanel
        Left = 0
        Top = 107
        Width = 509
        Height = 41
        Align = alTop
        Caption = 'Panel6'
        TabOrder = 2
      end
    end
  end
end

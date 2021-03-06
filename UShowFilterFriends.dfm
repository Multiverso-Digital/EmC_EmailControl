object FShowFilterFriends: TFShowFilterFriends
  Left = 0
  Top = 0
  Caption = 'mC-My Friends filters to selected header'
  ClientHeight = 566
  ClientWidth = 792
  Color = clMoneyGreen
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 11
    Top = 8
    Width = 768
    Height = 550
    Caption = 'My Friends filters to the selected message'
    TabOrder = 0
    object CBItens: TListBox
      Left = 7
      Top = 24
      Width = 165
      Height = 281
      ItemHeight = 13
      TabOrder = 0
    end
    object wwDBGrid1: TwwDBGrid
      Left = 2
      Top = 15
      Width = 764
      Height = 290
      Cursor = crHandPoint
      ControlType.Strings = (
        'Filtro;CheckBox;1;0')
      Selected.Strings = (
        'Filtro'#9'5'#9'Filter'#9'F'#9
        'Item'#9'20'#9'Item'#9'F'
        'Valor'#9'90'#9'Value'#9'F')
      MemoAttributes = [mSizeable, mWordWrap, mGridShow, mViewOnly]
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 0
      ShowHorzScrollBar = True
      EditControlOptions = [ecoCheckboxSingleClick, ecoDisableEditorIfReadOnly]
      Align = alTop
      Color = clCream
      DataSource = DM_SERVER.ds_Cabectmp
      KeyOptions = []
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgTrailingEllipsis, dgShowCellHint]
      TabOrder = 1
      TitleAlignment = taLeftJustify
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      TitleLines = 1
      TitleButtons = False
      OnFieldChanged = wwDBGrid1FieldChanged
    end
    object PageControl1: TPageControl
      Left = 3
      Top = 311
      Width = 762
      Height = 236
      ActivePage = TabSheet1
      Style = tsButtons
      TabOrder = 2
      object TabSheet1: TTabSheet
        Caption = 'Making Rules'
        object Label1: TLabel
          Left = 6
          Top = 3
          Width = 150
          Height = 13
          Caption = 'Please, give a name to this rule'
        end
        object GroupBox2: TGroupBox
          Left = 3
          Top = 43
          Width = 748
          Height = 142
          Caption = 'Making rule'
          TabOrder = 0
          object Label7: TLabel
            Left = 5
            Top = 15
            Width = 101
            Height = 13
            Caption = 'Selected header item'
          end
          object Eitem: TEdit
            Left = 6
            Top = 29
            Width = 150
            Height = 21
            ReadOnly = True
            TabOrder = 0
          end
          object Button1: TButton
            Left = 224
            Top = 114
            Width = 311
            Height = 25
            Cursor = crHandPoint
            Caption = 'Add rule'
            TabOrder = 1
            OnClick = Button1Click
          end
          object CBExists: TCheckBox
            Left = 171
            Top = 31
            Width = 166
            Height = 17
            Cursor = crHandPoint
            Caption = 'This Item MUST exist in header'
            TabOrder = 2
            OnClick = CBExistsClick
          end
          object GroupBox4: TGroupBox
            Left = 6
            Top = 54
            Width = 739
            Height = 57
            TabOrder = 3
            object Label4: TLabel
              Left = 4
              Top = 1
              Width = 163
              Height = 13
              Caption = 'Text to match in the selected item'
            end
            object SpeedButton1: TSpeedButton
              Left = 428
              Top = 35
              Width = 23
              Height = 19
              Cursor = crHandPoint
              Hint = 'Click here to see about Regular Expression'
              CustomHint = BalloonHint1
              Glyph.Data = {
                36030000424D3603000000000000360000002800000010000000100000000100
                18000000000000030000120B0000120B00000000000000000000FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFDF0F0F0DCDCDCD1D1D1D1D1D1DA
                DADAEDEDEDFBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFDFD
                EBEBEBBDBDBD8A8A8A737373737373868686B3B3B3E3E3E3FBFBFBFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFEFEFEF9CA5993067203C853648CC8320622B3A
                513D6F6F6FB2B2B2ECECECFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8F8ACB8AC
                2B832099C59EE4EAE240B154318D4E1F7D403A553D7E7E7EC6C6C6F2F2F2FFFF
                FFFFFFFFFFFFFFFFFFFFDDE4E0368831ACE2C0EFEFEFF8F8F85FB6682772323B
                B77B2C713E555555858585BEBEBEE6E6E6FAFAFAFFFFFFFFFFFF92D8B2518740
                FFFFFFFFFFFFE8EDE66EDF9E34915259F3B83190550F361447504A737373A5A5
                A5D6D6D6F5F5F5FFFFFF4EB9649FB499FEFEFEFFFFFF90BF804DD89468C69473
                FFCB359C6106532128874F3660456060608E8E8EC8C8C8F2F2F259B361E7EAE6
                F6F6F6CDDEC74EC7725FCB94E4F4EBC7FFEB1B793C30B0764DDCA038B0742F7D
                505056538C8C8CDCDCDC4ABF66A0B29A9EC29270CF8962F4BAB6DDC4F1FFFA95
                BF9E2EA36A9BFFDA6FFFCA5CF6BB4AD49936A46C717171D0D0D06AEEB740BF62
                50DF9394E8C281DDB0B8FFE5AEE4C847BD82E1F9EFF7FFFCD2FFEE90FFD66AFF
                C859F2B7707070CFCFCFE4F7EF83D9AF8ADDB365F4BB63FFC65BC1A84ACF9B9A
                FFDAC2FFE8DFFFF3F3FFFBF4FFFBC7FFEA87FFD3757575D2D2D2FFFFFFFFFFFF
                DAF0E69EDBBD9ECAAE53BDD61F9CD543BDC777FFCDA1FFDDC7FFEBE3FFF5F5FF
                FBF0FFFA949494E0E0E0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCEF0E591
                EEC85CF9BE63FFC67DFFCFA9FFDFCDFFEDB3D3C3CBCBCBF4F4F4FFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE4F1E98CE1BC59F1B765FFC682DB
                B4DEE2E0F4F4F4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
                FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
              ParentShowHint = False
              ShowHint = True
              OnClick = SpeedButton1Click
            end
            object Label5: TLabel
              Left = 457
              Top = 4
              Width = 263
              Height = 13
              Cursor = crHandPoint
              Hint = 'Example: Pa?l@domain.com  '
              Caption = 'Use wildcard ? to accept ANY characters in the position'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsUnderline]
              ParentFont = False
              ParentShowHint = False
              ShowHint = False
              OnClick = Label5Click
            end
            object Label6: TLabel
              Left = 457
              Top = 29
              Width = 281
              Height = 13
              Cursor = crHandPoint
              Hint = 'Example: *@domain.com   or  *Paul*@domain.*'
              Caption = 'Use wildcard * to accept zero or more unknown characters'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsUnderline]
              ParentFont = False
              ParentShowHint = False
              ShowHint = False
              OnClick = Label5Click
            end
            object Label8: TLabel
              Left = 457
              Top = 16
              Width = 280
              Height = 13
              Cursor = crHandPoint
              Hint = 'Example: Pa+l@domain.com'
              Caption = 'Use wildcard + to accept one or more unknown characters'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clNavy
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsUnderline]
              ParentFont = False
              ParentShowHint = False
              ShowHint = False
              OnClick = Label5Click
            end
            object Etexto: TEdit
              Left = 3
              Top = 13
              Width = 448
              Height = 21
              TabOrder = 0
            end
            object CBRegExpr: TCheckBox
              Left = 5
              Top = 36
              Width = 161
              Height = 17
              Cursor = crHandPoint
              Hint = 'Use Regular Expression if you know about that'
              Caption = 'Text to match is a RegExpr'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              ParentShowHint = False
              ShowHint = False
              TabOrder = 1
            end
          end
        end
        object RBAND: TRadioButton
          Left = 307
          Top = 16
          Width = 147
          Height = 17
          Cursor = crHandPoint
          Caption = 'Match only all rules(and)'
          TabOrder = 1
          OnClick = RBANDClick
        end
        object RBOR: TRadioButton
          Left = 451
          Top = 16
          Width = 164
          Height = 17
          Cursor = crHandPoint
          Caption = 'Match one or more rules(or)'
          TabOrder = 2
          OnClick = RBORClick
        end
        object Ename: TEdit
          Left = 6
          Top = 16
          Width = 291
          Height = 21
          TabOrder = 3
        end
        object CBAtivo: TCheckBox
          Left = 617
          Top = 17
          Width = 72
          Height = 17
          Caption = 'Active'
          Checked = True
          State = cbChecked
          TabOrder = 4
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Saved Rule'
        ImageIndex = 1
        ExplicitLeft = 0
        ExplicitTop = 0
        ExplicitWidth = 0
        ExplicitHeight = 0
        object wwDBGrid2: TwwDBGrid
          Left = 0
          Top = 0
          Width = 754
          Height = 205
          Selected.Strings = (
            'NameRule'#9'20'#9'NameRule'#9'F'
            'Item'#9'20'#9'Item'#9'F'
            'Expression'#9'50'#9'Expression'#9'F'
            'MatchType'#9'3'#9'MatchType'#9#9)
          MemoAttributes = [mSizeable, mWordWrap, mGridShow]
          IniAttributes.Delimiter = ';;'
          TitleColor = clBtnFace
          FixedCols = 0
          ShowHorzScrollBar = True
          Align = alClient
          Color = clCream
          DataSource = DM_SERVER.ds_boxes
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
          PopupMenu = PopupMenu1
          ReadOnly = True
          TabOrder = 0
          TitleAlignment = taLeftJustify
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          TitleLines = 1
          TitleButtons = False
          OnDblClick = wwDBGrid2DblClick
        end
      end
    end
  end
  object BalloonHint1: TBalloonHint
    Left = 296
    Top = 200
  end
  object PopupMenu1: TPopupMenu
    Images = Fmain.ilGFX16
    Left = 488
    Top = 224
    object Deleteselectedrule1: TMenuItem
      Caption = 'Delete selected rule'
      ImageIndex = 5
      OnClick = Deleteselectedrule1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object DeleteALLrules1: TMenuItem
      Caption = 'Delete ALL rules'
      ImageIndex = 31
      OnClick = DeleteALLrules1Click
    end
  end
end

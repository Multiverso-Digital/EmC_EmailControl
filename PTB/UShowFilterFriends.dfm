object FShowFilterFriends: TFShowFilterFriends
  Left = 0
  Top = 0
  Caption = 'EmC-My Friends  filters to selected message header'
  ClientHeight = 566
  ClientWidth = 792
  Color = 15984085
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
    Left = 16
    Top = 8
    Width = 768
    Height = 550
    Caption = 'My Friends filters to the selected message'
    TabOrder = 0
    object CBItens: TListBox
      Left = 7
      Top = 24
      Width = 165
      Height = 302
      ItemHeight = 13
      TabOrder = 0
    end
    object wwDBGrid1: TwwDBGrid
      Left = 2
      Top = 15
      Width = 764
      Height = 312
      ControlType.Strings = (
        'Filtro;CheckBox;true;false'
        'Valor;RichEdit;;F')
      Selected.Strings = (
        'Filtro'#9'5'#9'Make rule'#9'F'#9
        'Item'#9'30'#9'Item'#9'T'#9
        'Valor'#9'80'#9'Value'#9'T'#9)
      MemoAttributes = [mSizeable, mWordWrap, mGridShow, mViewOnly]
      IniAttributes.Delimiter = ';;'
      TitleColor = clBtnFace
      FixedCols = 0
      ShowHorzScrollBar = True
      EditControlOptions = [ecoCheckboxSingleClick, ecoDisableEditorIfReadOnly]
      Align = alTop
      DataSource = DM_SERVER.ds_Cabectmp
      KeyOptions = []
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap]
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
    object GroupBox2: TGroupBox
      Left = 7
      Top = 355
      Width = 326
      Height = 188
      Caption = 'Making rule'
      TabOrder = 2
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
        TabOrder = 0
      end
      object Button1: TButton
        Left = 8
        Top = 159
        Width = 311
        Height = 25
        Cursor = crHandPoint
        Caption = 'Add rule'
        TabOrder = 1
        OnClick = Button1Click
      end
      object CBExists: TCheckBox
        Left = 159
        Top = 32
        Width = 166
        Height = 17
        Cursor = crHandPoint
        Caption = 'This Item MUST exist in header'
        TabOrder = 2
        OnClick = CBExistsClick
      end
      object GroupBox4: TGroupBox
        Left = 4
        Top = 50
        Width = 320
        Height = 108
        TabOrder = 3
        object Label4: TLabel
          Left = 4
          Top = 1
          Width = 163
          Height = 13
          Caption = 'Text to match in the selected item'
        end
        object SpeedButton1: TSpeedButton
          Left = 232
          Top = 83
          Width = 23
          Height = 22
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
          Left = 7
          Top = 36
          Width = 263
          Height = 13
          Cursor = crHandPoint
          Hint = 'Example: Pa?l@domain.com  '
          CustomHint = BalloonHint1
          Caption = 'Use wildcard ? to accept ANY characters in the position'
          ParentShowHint = False
          ShowHint = True
        end
        object Label6: TLabel
          Left = 7
          Top = 61
          Width = 281
          Height = 13
          Cursor = crHandPoint
          Hint = 'Example: *@domain.com   or  *Paul*@domain.*'
          CustomHint = BalloonHint1
          Caption = 'Use wildcard * to accept zero or more unknown characters'
          ParentShowHint = False
          ShowHint = True
        end
        object Label8: TLabel
          Left = 7
          Top = 48
          Width = 277
          Height = 13
          Cursor = crHandPoint
          Hint = 'Example: Pa+l@domain.com'
          CustomHint = BalloonHint1
          Caption = 'Use wildcard +to accept one or more unknown characters'
          ParentShowHint = False
          ShowHint = True
        end
        object Etexto: TEdit
          Left = 3
          Top = 13
          Width = 313
          Height = 21
          TabOrder = 0
        end
        object CBRegExpr: TCheckBox
          Left = 68
          Top = 86
          Width = 161
          Height = 17
          Cursor = crHandPoint
          Hint = 'Use Regular Expression if you know about that'
          CustomHint = BalloonHint1
          Caption = 'Text to match is a RegExpr'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
        end
      end
    end
    object GroupBox3: TGroupBox
      Left = 335
      Top = 327
      Width = 430
      Height = 218
      Caption = 'Rules saved(Double click to edit or Rigth click to delete)'
      TabOrder = 3
      object wwDBGrid2: TwwDBGrid
        Left = 2
        Top = 15
        Width = 426
        Height = 201
        Selected.Strings = (
          'Item'#9'20'#9'Item'
          'Expression'#9'30'#9'Expression'
          'MatchType'#9'3'#9'MatchType')
        IniAttributes.Delimiter = ';;'
        TitleColor = clBtnFace
        FixedCols = 0
        ShowHorzScrollBar = True
        Align = alClient
        DataSource = DM_SERVER.DS_qBoxes
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
        ExplicitLeft = 32
        ExplicitTop = 32
        ExplicitWidth = 320
        ExplicitHeight = 120
      end
    end
    object RBAND: TRadioButton
      Left = 12
      Top = 335
      Width = 147
      Height = 17
      Cursor = crHandPoint
      Caption = 'Match only all rules(and)'
      TabOrder = 4
      OnClick = RBANDClick
    end
    object RBOR: TRadioButton
      Left = 165
      Top = 335
      Width = 164
      Height = 17
      Cursor = crHandPoint
      Caption = 'Match one or more rules(or)'
      TabOrder = 5
      OnClick = RBORClick
    end
  end
  object BalloonHint1: TBalloonHint
    Left = 360
    Top = 288
  end
  object PopupMenu1: TPopupMenu
    Images = Fmain.ilGFX16
    Left = 504
    Top = 448
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

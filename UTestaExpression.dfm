object FTestaExpression: TFTestaExpression
  Left = 0
  Top = 0
  Caption = 'EmC - Test expression'
  ClientHeight = 552
  ClientWidth = 561
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 32
    Top = 8
    Width = 497
    Height = 518
    Caption = 'Test'
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 57
      Height = 13
      Caption = 'Text to test'
    end
    object Label2: TLabel
      Left = 16
      Top = 72
      Width = 122
      Height = 13
      Caption = 'Expression with wildcards'
    end
    object Etexto: TEdit
      Left = 16
      Top = 40
      Width = 465
      Height = 21
      TabOrder = 0
      Text = 'abreu@abreuretto.com'
    end
    object Eexpressao: TEdit
      Left = 16
      Top = 88
      Width = 465
      Height = 21
      TabOrder = 1
      Text = 'abreu@abreu?retto.com'
    end
    object Button1: TButton
      Left = 203
      Top = 120
      Width = 75
      Height = 25
      Cursor = crHandPoint
      Caption = 'Test'
      TabOrder = 2
      OnClick = Button1Click
    end
    object GroupBox2: TGroupBox
      Left = 16
      Top = 159
      Width = 465
      Height = 105
      Caption = 'Examples Using wildcard ?'
      TabOrder = 3
      object Label3: TLabel
        Left = 10
        Top = 32
        Width = 446
        Height = 13
        Caption = 
          'abreu@abreu?retto.com  -> This result OK only if the wildcard ? ' +
          'position has no character  or'
      end
      object Label4: TLabel
        Left = 9
        Top = 44
        Width = 276
        Height = 13
        Caption = 
          '                                              has one any single' +
          ' character'
      end
      object Label5: TLabel
        Left = 10
        Top = 64
        Width = 311
        Height = 13
        Caption = 'abreu@abreuXretto.com IS OK(have one character X in position)'
      end
      object Label6: TLabel
        Left = 10
        Top = 82
        Width = 372
        Height = 13
        Caption = 
          'abreu@abreuXYretto.com IS NOT OK(have more than one character X ' +
          'and Y)'
      end
    end
    object GroupBox3: TGroupBox
      Left = 16
      Top = 270
      Width = 465
      Height = 117
      Caption = 'Examples Using wildcard +'
      TabOrder = 4
      object Label7: TLabel
        Left = 10
        Top = 32
        Width = 439
        Height = 13
        Caption = 
          'abreu@abreu+retto.com  -> This result OK only if the wildcard + ' +
          'position has one or more  '
      end
      object Label9: TLabel
        Left = 10
        Top = 64
        Width = 311
        Height = 13
        Caption = 'abreu@abreuXretto.com IS OK(have one character X in position)'
      end
      object Label10: TLabel
        Left = 10
        Top = 82
        Width = 348
        Height = 13
        Caption = 
          'abreu@abreuXYretto.com IS OK(have more than one character X and ' +
          'Y)'
      end
      object Label8: TLabel
        Left = 152
        Top = 45
        Width = 51
        Height = 13
        Caption = 'characters'
      end
      object Label11: TLabel
        Left = 11
        Top = 99
        Width = 277
        Height = 13
        Caption = 'abreu@abreuretto.com IS NOT OK(There is no character)'
      end
    end
    object GroupBox4: TGroupBox
      Left = 16
      Top = 393
      Width = 465
      Height = 117
      Caption = 'Examples Using wildcard *'
      TabOrder = 5
      object Label12: TLabel
        Left = 10
        Top = 32
        Width = 438
        Height = 13
        Caption = 
          'abreu@abreu*retto.com  -> This result OK only if the wildcard * ' +
          'position has zero or more  '
      end
      object Label13: TLabel
        Left = 10
        Top = 64
        Width = 311
        Height = 13
        Caption = 'abreu@abreuXretto.com IS OK(have one character X in position)'
      end
      object Label14: TLabel
        Left = 10
        Top = 82
        Width = 348
        Height = 13
        Caption = 
          'abreu@abreuXYretto.com IS OK(have more than one character X and ' +
          'Y)'
      end
      object Label15: TLabel
        Left = 152
        Top = 45
        Width = 51
        Height = 13
        Caption = 'characters'
      end
      object Label16: TLabel
        Left = 11
        Top = 99
        Width = 253
        Height = 13
        Caption = 'abreu@abreuretto.com IS OK(There is no character)'
      end
    end
  end
end

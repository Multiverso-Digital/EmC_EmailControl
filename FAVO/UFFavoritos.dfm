object FFavoritos: TFFavoritos
  Left = 598
  Top = 190
  Width = 313
  Height = 190
  BorderIcons = [biSystemMenu]
  Caption = 'mC - Import'
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    00000000000000000000000000000000000000000000000000000000000000FF
    FFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FF
    FFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FF
    FFF000000000000000000000000000FFFFF000000000000000000000000000FF
    FFF000000000000000000000000000FFFFF000000000000000000000000000FF
    FFF000000000000000000000000000FFFFF000000000000000000000000000FF
    FFF000000000000000000000000000FFFFF000000000000000000000000000FF
    FFFFFFFFFFFFFFFFFFFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFFF0000000FF
    FFFFFFFFFFFFFFFFFFFFFFF0000000FFFFFFFFFFFFFFFFFFFFFFFFF0000000FF
    FFF000000000000000000000000000FFFFF000000000000000000000000000FF
    FFF000000000000000000000000000FFFFF000000000000000000000000000FF
    FFF000000000000000000000000000FFFFF000000000000000000000000000FF
    FFF000000000000000000000000000FFFFF000000000000000000000000000FF
    FFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF000FF
    FFFFFFFFFFFFFFFFFFFFFFFFFFF000FFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000
    000000000000000000000000000000000000000000000000000000000000FFFF
    FFFF80000000800000008000000080000000800000008000000080FFFFFF80FF
    FFFF80FFFFFF80FFFFFF80FFFFFF80FFFFFF8000000F8000000F8000000F8000
    000F8000000F8000000F80FFFFFF80FFFFFF80FFFFFF80FFFFFF80FFFFFF80FF
    FFFF800000008000000080000000800000008000000080000000FFFFFFFF}
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object AdrBookListView: TListView
    Left = 16
    Top = 24
    Width = 249
    Height = 73
    Columns = <
      item
        Caption = 'Name'
        Width = 130
      end
      item
        Caption = 'Email address'
        Width = 180
      end
      item
        Caption = 'Home page'
        Width = 140
      end>
    ColumnClick = False
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    Visible = False
  end
  object DetailListView: TListView
    Left = 24
    Top = 8
    Width = 193
    Height = 57
    Columns = <
      item
        Caption = 'Index'
        Width = 40
      end
      item
        Caption = 'Prop ID'
        Width = 220
      end
      item
        Caption = 'Prop value'
        Width = 200
      end>
    ColumnClick = False
    GridLines = True
    OwnerData = True
    ReadOnly = True
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsReport
    Visible = False
  end
  object Button3: TButton
    Left = 32
    Top = 56
    Width = 233
    Height = 25
    Cursor = crHandPoint
    Caption = 'Import Address Book'
    TabOrder = 2
    OnClick = RCatalogoClick
  end
  object PB: TProgressBar
    Left = 24
    Top = 112
    Width = 249
    Height = 17
    TabOrder = 3
  end
  object Edit1: TEdit
    Left = 16
    Top = 120
    Width = 273
    Height = 21
    TabOrder = 4
    Visible = False
  end
  object OpenDialog: TOpenDialog
    DefaultExt = 'wab'
    Filter = 'WAB file (*.wab)|*.wab'
    Options = [ofReadOnly, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Title = 'Open a copy of the selected file'
    Left = 48
    Top = 120
  end
end

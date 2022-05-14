object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 471
  ClientWidth = 670
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object CoolBar1: TCoolBar
    Left = 0
    Top = 0
    Width = 670
    Height = 43
    AutoSize = True
    Bands = <
      item
        Control = ToolBar1
        ImageIndex = -1
        MinHeight = 19
        Width = 668
      end
      item
        ImageIndex = -1
        Width = 668
      end>
    EdgeBorders = []
    EdgeInner = esNone
    EdgeOuter = esNone
    object ToolBar1: TToolBar
      AlignWithMargins = True
      Left = 12
      Top = 0
      Width = 654
      Height = 19
      AutoSize = True
      ButtonHeight = 19
      ButtonWidth = 100
      Caption = 'ToolBar1'
      Color = clSkyBlue
      DrawingStyle = dsGradient
      EdgeInner = esNone
      EdgeOuter = esNone
      GradientEndColor = clSkyBlue
      GradientStartColor = clSkyBlue
      HideClippedButtons = True
      HotTrackColor = clYellow
      List = True
      GradientDirection = gdHorizontal
      ParentColor = False
      ShowCaptions = True
      TabOrder = 0
      object ToolButton1: TToolButton
        Left = 0
        Top = 0
        Caption = 'Ler mensagens'
        ImageIndex = 0
      end
      object ToolButton2: TToolButton
        Left = 100
        Top = 0
        Caption = 'Excluir mensagens'
        ImageIndex = 1
      end
    end
  end
  object CategoryPanelGroup1: TCategoryPanelGroup
    Left = 0
    Top = 43
    Width = 177
    Height = 428
    VertScrollBar.Tracking = True
    ChevronAlignment = taRightJustify
    ChevronHotColor = clMoneyGreen
    Color = clSkyBlue
    GradientBaseColor = clCream
    GradientColor = clYellow
    HeaderFont.Charset = DEFAULT_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -11
    HeaderFont.Name = 'Tahoma'
    HeaderFont.Style = []
    TabOrder = 1
    object CategoryPanel1: TCategoryPanel
      Top = 0
      Caption = 'Contas'
      Color = clWhite
      TabOrder = 0
      object JvDBGrid1: TJvDBGrid
        Left = 0
        Top = 0
        Width = 173
        Height = 174
        Align = alClient
        DataSource = DM_SERVER.DS_qContas
        Options = [dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        ShowGlyphs = False
        SelectColumnsDialogStrings.Caption = 'Select columns'
        SelectColumnsDialogStrings.OK = '&OK'
        SelectColumnsDialogStrings.NoSelectionWarning = 'At least one column must be visible!'
        EditControls = <>
        RowsHeight = 17
        TitleRowHeight = 17
        ShowMemos = False
        Columns = <
          item
            Expanded = False
            FieldName = 'Nome'
            Width = 151
            Visible = True
          end>
      end
    end
    object CategoryPanel2: TCategoryPanel
      Top = 200
      Caption = 'Favoritos'
      Color = clWhite
      TabOrder = 1
    end
  end
end

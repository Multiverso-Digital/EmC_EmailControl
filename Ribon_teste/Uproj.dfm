object Fproj: TFproj
  Left = 0
  Top = 0
  ActiveControl = ENomeProjeto
  Caption = 'Fproj'
  ClientHeight = 714
  ClientWidth = 710
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  Visible = True
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object JvWizard1: TJvWizard
    Left = 0
    Top = 0
    Width = 710
    Height = 714
    ActivePage = JvWizardInteriorPage1
    ButtonBarHeight = 42
    ButtonStart.Caption = 'To &Start Page'
    ButtonStart.NumGlyphs = 1
    ButtonStart.Width = 85
    ButtonLast.Caption = 'To &Last Page'
    ButtonLast.NumGlyphs = 1
    ButtonLast.Width = 85
    ButtonBack.Caption = '< &Back'
    ButtonBack.NumGlyphs = 1
    ButtonBack.Width = 75
    ButtonNext.Caption = '&Next >'
    ButtonNext.NumGlyphs = 1
    ButtonNext.Width = 75
    ButtonFinish.Caption = '&Finish'
    ButtonFinish.NumGlyphs = 1
    ButtonFinish.Width = 75
    ButtonCancel.Caption = 'Cancel'
    ButtonCancel.NumGlyphs = 1
    ButtonCancel.ModalResult = 2
    ButtonCancel.Width = 75
    ButtonHelp.Caption = '&Help'
    ButtonHelp.NumGlyphs = 1
    ButtonHelp.Width = 75
    ShowRouteMap = True
    OnCancelButtonClick = JvWizard1CancelButtonClick
    DesignSize = (
      710
      714)
    object JvWizardInteriorPage1: TJvWizardInteriorPage
      Header.Color = 15719884
      Header.Title.Color = clNone
      Header.Title.Text = 'Gerando um novo projeto'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'Tahoma'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 'Informe os dados para o novo projeto'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -11
      Header.Subtitle.Font.Name = 'Tahoma'
      Header.Subtitle.Font.Style = []
      Panel.Color = clWhite
      Panel.Visible = True
      Color = 16767935
      Caption = 'Novo projeto'
      OnEnterPage = JvWizardInteriorPage1EnterPage
      OnExitPage = JvWizardInteriorPage1ExitPage
      ExplicitLeft = 151
      object Label4: TLabel
        Left = 32
        Top = 144
        Width = 99
        Height = 13
        Caption = 'Descri'#231#227'o do projeto'
        Color = clWhite
        ParentColor = False
      end
      object ENomeProjeto: TLabeledEdit
        Left = 32
        Top = 120
        Width = 489
        Height = 19
        Ctl3D = False
        EditLabel.Width = 80
        EditLabel.Height = 13
        EditLabel.Caption = 'Nome do projeto'
        EditLabel.Color = clWhite
        EditLabel.ParentColor = False
        ParentCtl3D = False
        TabOrder = 0
      end
      object EDescProjeto: TMemo
        Left = 32
        Top = 160
        Width = 489
        Height = 129
        Ctl3D = False
        Lines.Strings = (
          'EDescProjeto')
        ParentCtl3D = False
        TabOrder = 1
      end
      object EnomeCliente: TLabeledEdit
        Left = 32
        Top = 328
        Width = 489
        Height = 19
        Ctl3D = False
        EditLabel.Width = 144
        EditLabel.Height = 13
        EditLabel.Caption = 'Nome do cliente deste projeto'
        EditLabel.Color = clWhite
        EditLabel.ParentColor = False
        ParentCtl3D = False
        TabOrder = 2
      end
      object wwDBGrid1: TwwDBGrid
        Left = 33
        Top = 353
        Width = 489
        Height = 120
        Selected.Strings = (
          'ID'#9'6'#9'ID'
          'CNPJ'#9'12'#9'CNPJ'
          'RazaoSocial'#9'32'#9'RazaoSocial'
          'Apelido'#9'20'#9'Apelido')
        IniAttributes.FileName = 'delphi32.ini.ini'
        IniAttributes.Delimiter = ';;'
        TitleColor = 15719884
        FixedCols = 0
        ShowHorzScrollBar = True
        Color = clWhite
        Ctl3D = False
        DataSource = DM.ds_qclientes
        Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgPerfectRowFit, dgShowFooter, dgFooter3DCells, dgColLinesDisableFixed]
        ParentCtl3D = False
        TabOrder = 3
        TitleAlignment = taLeftJustify
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        TitleLines = 1
        TitleButtons = False
        OnDblClick = wwDBGrid1DblClick
        PaintOptions.BackgroundOptions = [coBlendFixedColumn]
        object wwDBGrid1IButton: TwwIButton
          AlignWithMargins = True
          Left = 0
          Top = 0
          Width = 33
          Height = 25
          AllowAllUp = True
          Glyph.Data = {
            A2050000424DA2050000000000003604000028000000190000000D0000000100
            0800000000006C0100000DB305000DB305000001000000000000000000000000
            8000C0C0C0000000FF000000330000006600000099000000CC00000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000020202020000
            0000000202020202020202020202020202020200000002020000040400000000
            0002020202020202020202020202020000000204040404040404000000000202
            0202020202020202020202000000020405050505040404040000020202020202
            0202020202020200000004050501010101050404000000020202020202020202
            0202020000000501060606060101050404000002020202020202020202020200
            0000050606060707060605050400000202020202020202020202020000000106
            0707030707060105040400020202020202020202020202000000010607070307
            0706010504000002020202020202020202020200000002060707070707060105
            0404020202020202020202020202020000000206060707070606050504000202
            0202020202020202020202000000020206060606060105040402020202020202
            0202020202020200000002020202010105050402020202020202020202020202
            020202000000}
          Margin = 7
          OnClick = wwDBGrid1IButtonClick
        end
      end
      object wwRecordViewPanel1: TwwRecordViewPanel
        Left = 32
        Top = 479
        Width = 488
        Height = 146
        HorzScrollBar.Margin = 6
        HorzScrollBar.Range = 211
        VertScrollBar.Increment = 21
        VertScrollBar.Margin = 6
        VertScrollBar.Range = 78
        AutoScroll = False
        Ctl3D = False
        ParentCtl3D = False
        TabOrder = 4
        DataSource = DM.ds_qclientes
        EditFrame.Enabled = True
        EditFrame.Transparent = True
        EditFrame.FocusStyle = efsFrameSunken
        Style = rvpsHorizontal
        Options = [rvopUseCustomControls, rvopShortenEditBox, rvopMaximizeMemoWidth, rvopUseDateTimePicker, rvopLabelsBeneathControl]
        ControlOptions = []
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
      end
      object wwDBNavigator1: TwwDBNavigator
        Left = 16
        Top = 41
        Width = 350
        Height = 25
        DataSource = DM.ds_qclientes
        RepeatInterval.InitialDelay = 500
        RepeatInterval.Interval = 100
        Visible = False
        object wwDBNavigator1First: TwwNavButton
          Left = 0
          Top = 0
          Width = 25
          Height = 25
          Hint = 'Move to first record'
          ImageIndex = -1
          NumGlyphs = 2
          Spacing = 4
          Transparent = False
          Caption = 'wwDBNavigator1First'
          Enabled = False
          DisabledTextColors.ShadeColor = clGray
          DisabledTextColors.HighlightColor = clBtnHighlight
          Index = 0
          Style = nbsFirst
        end
        object wwDBNavigator1PriorPage: TwwNavButton
          Left = 25
          Top = 0
          Width = 25
          Height = 25
          Hint = 'Move backward 10 records'
          ImageIndex = -1
          NumGlyphs = 2
          Spacing = 4
          Transparent = False
          Caption = 'wwDBNavigator1PriorPage'
          Enabled = False
          DisabledTextColors.ShadeColor = clGray
          DisabledTextColors.HighlightColor = clBtnHighlight
          Index = 1
          Style = nbsPriorPage
        end
        object wwDBNavigator1Prior: TwwNavButton
          Left = 50
          Top = 0
          Width = 25
          Height = 25
          Hint = 'Move to prior record'
          ImageIndex = -1
          NumGlyphs = 2
          Spacing = 4
          Transparent = False
          Caption = 'wwDBNavigator1Prior'
          Enabled = False
          DisabledTextColors.ShadeColor = clGray
          DisabledTextColors.HighlightColor = clBtnHighlight
          Index = 2
          Style = nbsPrior
        end
        object wwDBNavigator1Next: TwwNavButton
          Left = 75
          Top = 0
          Width = 25
          Height = 25
          Hint = 'Move to next record'
          ImageIndex = -1
          NumGlyphs = 2
          Spacing = 4
          Transparent = False
          Caption = 'wwDBNavigator1Next'
          DisabledTextColors.ShadeColor = clGray
          DisabledTextColors.HighlightColor = clBtnHighlight
          Index = 3
          Style = nbsNext
        end
        object wwDBNavigator1NextPage: TwwNavButton
          Left = 100
          Top = 0
          Width = 25
          Height = 25
          Hint = 'Move forward 10 records'
          ImageIndex = -1
          NumGlyphs = 2
          Spacing = 4
          Transparent = False
          Caption = 'wwDBNavigator1NextPage'
          DisabledTextColors.ShadeColor = clGray
          DisabledTextColors.HighlightColor = clBtnHighlight
          Index = 4
          Style = nbsNextPage
        end
        object wwDBNavigator1Last: TwwNavButton
          Left = 125
          Top = 0
          Width = 25
          Height = 25
          Hint = 'Move to last record'
          ImageIndex = -1
          NumGlyphs = 2
          Spacing = 4
          Transparent = False
          Caption = 'wwDBNavigator1Last'
          DisabledTextColors.ShadeColor = clGray
          DisabledTextColors.HighlightColor = clBtnHighlight
          Index = 5
          Style = nbsLast
        end
        object wwDBNavigator1Insert: TwwNavButton
          Left = 150
          Top = 0
          Width = 25
          Height = 25
          Hint = 'Insert new record'
          ImageIndex = -1
          NumGlyphs = 2
          Spacing = 4
          Transparent = False
          Caption = 'wwDBNavigator1Insert'
          DisabledTextColors.ShadeColor = clGray
          DisabledTextColors.HighlightColor = clBtnHighlight
          Index = 6
          Style = nbsInsert
        end
        object wwDBNavigator1Delete: TwwNavButton
          Left = 175
          Top = 0
          Width = 25
          Height = 25
          Hint = 'Delete current record'
          ImageIndex = -1
          NumGlyphs = 2
          Spacing = 4
          Transparent = False
          Caption = 'wwDBNavigator1Delete'
          DisabledTextColors.ShadeColor = clGray
          DisabledTextColors.HighlightColor = clBtnHighlight
          Index = 7
          Style = nbsDelete
        end
        object wwDBNavigator1Edit: TwwNavButton
          Left = 200
          Top = 0
          Width = 25
          Height = 25
          Hint = 'Edit current record'
          ImageIndex = -1
          NumGlyphs = 2
          Spacing = 4
          Transparent = False
          Caption = 'wwDBNavigator1Edit'
          DisabledTextColors.ShadeColor = clGray
          DisabledTextColors.HighlightColor = clBtnHighlight
          Index = 8
          Style = nbsEdit
        end
        object wwDBNavigator1Post: TwwNavButton
          Left = 225
          Top = 0
          Width = 25
          Height = 25
          Hint = 'Post changes of current record'
          ImageIndex = -1
          NumGlyphs = 2
          Spacing = 4
          Transparent = False
          Caption = 'wwDBNavigator1Post'
          Enabled = False
          DisabledTextColors.ShadeColor = clGray
          DisabledTextColors.HighlightColor = clBtnHighlight
          Index = 9
          Style = nbsPost
        end
        object wwDBNavigator1Cancel: TwwNavButton
          Left = 250
          Top = 0
          Width = 25
          Height = 25
          Hint = 'Cancel changes made to current record'
          ImageIndex = -1
          NumGlyphs = 2
          Spacing = 4
          Transparent = False
          Caption = 'wwDBNavigator1Cancel'
          Enabled = False
          DisabledTextColors.ShadeColor = clGray
          DisabledTextColors.HighlightColor = clBtnHighlight
          Index = 10
          Style = nbsCancel
        end
        object wwDBNavigator1Refresh: TwwNavButton
          Left = 275
          Top = 0
          Width = 25
          Height = 25
          Hint = 'Refresh the contents of the dataset'
          ImageIndex = -1
          NumGlyphs = 2
          Spacing = 4
          Transparent = False
          Caption = 'wwDBNavigator1Refresh'
          DisabledTextColors.ShadeColor = clGray
          DisabledTextColors.HighlightColor = clBtnHighlight
          Index = 11
          Style = nbsRefresh
        end
        object wwDBNavigator1SaveBookmark: TwwNavButton
          Left = 300
          Top = 0
          Width = 25
          Height = 25
          Hint = 'Bookmark current record'
          ImageIndex = -1
          NumGlyphs = 2
          Spacing = 4
          Transparent = False
          Caption = 'wwDBNavigator1SaveBookmark'
          DisabledTextColors.ShadeColor = clGray
          DisabledTextColors.HighlightColor = clBtnHighlight
          Index = 12
          Style = nbsSaveBookmark
        end
        object wwDBNavigator1RestoreBookmark: TwwNavButton
          Left = 325
          Top = 0
          Width = 25
          Height = 25
          Hint = 'Go back to saved bookmark'
          ImageIndex = -1
          NumGlyphs = 2
          Spacing = 4
          Transparent = False
          Caption = 'wwDBNavigator1RestoreBookmark'
          Enabled = False
          DisabledTextColors.ShadeColor = clGray
          DisabledTextColors.HighlightColor = clBtnHighlight
          Index = 13
          Style = nbsRestoreBookmark
        end
      end
    end
    object JvWizardInteriorPage2: TJvWizardInteriorPage
      Header.Color = 15719884
      Header.Title.Color = clNone
      Header.Title.Text = 'Banco de dados'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'Tahoma'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 'Informa'#231#245'es do banco de dados'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -11
      Header.Subtitle.Font.Name = 'Tahoma'
      Header.Subtitle.Font.Style = []
      Panel.Color = clWhite
      Panel.Visible = True
      Color = 15719884
      Caption = 'Banco de dados'
      object LabeledEdit3: TLabeledEdit
        Left = 64
        Top = 136
        Width = 345
        Height = 19
        Ctl3D = False
        EditLabel.Width = 67
        EditLabel.Height = 13
        EditLabel.Caption = 'IP do servidor'
        EditLabel.Color = clWhite
        EditLabel.ParentColor = False
        ParentCtl3D = False
        TabOrder = 0
      end
      object LabeledEdit4: TLabeledEdit
        Left = 64
        Top = 176
        Width = 345
        Height = 19
        Ctl3D = False
        EditLabel.Width = 36
        EditLabel.Height = 13
        EditLabel.Caption = 'Usu'#225'rio'
        EditLabel.Color = clWhite
        EditLabel.ParentColor = False
        ParentCtl3D = False
        TabOrder = 1
      end
      object LabeledEdit5: TLabeledEdit
        Left = 64
        Top = 218
        Width = 345
        Height = 19
        Ctl3D = False
        EditLabel.Width = 30
        EditLabel.Height = 13
        EditLabel.Caption = 'Senha'
        EditLabel.Color = clWhite
        EditLabel.ParentColor = False
        ParentCtl3D = False
        TabOrder = 2
      end
      object LabeledEdit6: TLabeledEdit
        Left = 64
        Top = 263
        Width = 345
        Height = 19
        Ctl3D = False
        EditLabel.Width = 74
        EditLabel.Height = 13
        EditLabel.Caption = 'Nome do banco'
        EditLabel.Color = clWhite
        EditLabel.ParentColor = False
        ParentCtl3D = False
        TabOrder = 3
      end
    end
    object JvWizardInteriorPage3: TJvWizardInteriorPage
      Header.Color = 15719884
      Header.Title.Color = clNone
      Header.Title.Text = 'Concluir'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'Tahoma'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 'Verifique se as informa'#231#245'es est'#227'o corretas e clique no bot'#227'o.'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -11
      Header.Subtitle.Font.Name = 'Tahoma'
      Header.Subtitle.Font.Style = []
      Panel.Color = clWhite
      Panel.Visible = True
      VisibleButtons = [bkBack, bkCancel]
      Color = 15719884
      Caption = 'Concluir'
      object Label5: TLabel
        Left = 24
        Top = 112
        Width = 84
        Height = 13
        Caption = 'Nome do projeto:'
        Color = clWhite
        ParentColor = False
      end
      object Label6: TLabel
        Left = 24
        Top = 149
        Width = 103
        Height = 13
        Caption = 'Descri'#231#227'o do projeto:'
        Color = clWhite
        ParentColor = False
      end
      object Label7: TLabel
        Left = 23
        Top = 202
        Width = 37
        Height = 13
        Caption = 'Cliente:'
        Color = clWhite
        ParentColor = False
      end
      object Label8: TLabel
        Left = 23
        Top = 258
        Width = 14
        Height = 13
        Caption = 'IP:'
        Color = clWhite
        ParentColor = False
      end
      object Label9: TLabel
        Left = 23
        Top = 291
        Width = 40
        Height = 13
        Caption = 'Usu'#225'rio:'
        Color = clWhite
        ParentColor = False
      end
      object Label10: TLabel
        Left = 23
        Top = 326
        Width = 34
        Height = 13
        Caption = 'Senha:'
        Color = clWhite
        ParentColor = False
      end
      object BitBtn1: TBitBtn
        Left = 248
        Top = 560
        Width = 129
        Height = 25
        Caption = 'Gerar Projeto'
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 0
      end
    end
    object Label1: TLabel
      Left = 256
      Top = 168
      Width = 31
      Height = 13
      Caption = 'Label1'
    end
    object Label2: TLabel
      Left = 256
      Top = 168
      Width = 31
      Height = 13
      Caption = 'Label2'
    end
    object Label3: TLabel
      Left = 240
      Top = 216
      Width = 31
      Height = 13
      Caption = 'Label3'
    end
    object JvWizardRouteMapSteps1: TJvWizardRouteMapSteps
      Left = 0
      Top = 0
      Width = 145
      Height = 672
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      PreviousStepText = 'Voltar para'
      ActiveStepFormat = 'Passo %0:d de %1:d'
      NextStepText = 'Pr'#243'ximo passo'
    end
  end
  object JvEmbeddedFormLink1: TJvEmbeddedFormLink
    Left = 600
    Top = 576
  end
  object wwRecordViewDialog1: TwwRecordViewDialog
    EditFrame.Enabled = True
    EditFrame.Transparent = True
    EditFrame.FocusStyle = efsFrameSunken
    DataSource = DM.ds_qclientes
    FormPosition.Left = 0
    FormPosition.Top = 0
    FormPosition.Width = 0
    FormPosition.Height = 0
    NavigatorButtons = [nbsFirst, nbsPrior, nbsNext, nbsLast, nbsInsert, nbsDelete, nbsEdit, nbsPost, nbsCancel, nbsRefresh, nbsPriorPage, nbsNextPage, nbsSaveBookmark, nbsRestoreBookmark]
    Style = rvsHorizontal
    Options = [rvoUseCustomControls, rvoShortenEditBox, rvoModalForm, rvoConfirmCancel, rvoCloseIsCancel, rvoMaximizeMemoWidth, rvoUseDateTimePicker, rvoLabelsBeneathControl]
    ControlOptions = []
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clWindowText
    LabelFont.Height = -11
    LabelFont.Name = 'Tahoma'
    LabelFont.Style = []
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Caption = 'Registro selecionado'
    ReadOnlyColor = clSkyBlue
    Selected.Strings = (
      'ID'#9'10'#9'ID'#9#9
      'CNPJ'#9'14'#9'CNPJ'#9#9
      'RazaoSocial'#9'50'#9'RazaoSocial'#9#9
      'Apelido'#9'20'#9'Apelido'#9#9)
    NavigatorFlat = True
    Navigator = wwDBNavigator1
    Left = 448
    Top = 568
  end
end

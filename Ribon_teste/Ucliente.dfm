object FCliente: TFCliente
  Left = 0
  Top = 0
  Caption = 'FCliente'
  ClientHeight = 643
  ClientWidth = 721
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object JvWizard1: TJvWizard
    Left = 0
    Top = 0
    Width = 721
    Height = 643
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
      721
      643)
    object JvWizardInteriorPage1: TJvWizardInteriorPage
      Header.Color = 15719884
      Header.Title.Color = clNone
      Header.Title.Text = 'Incluindo um novo cliente'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'Tahoma'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 'Para incluir um novo cliente siga os passos deste wizard.'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -11
      Header.Subtitle.Font.Name = 'Tahoma'
      Header.Subtitle.Font.Style = []
      Panel.Color = clWhite
      Panel.Visible = True
      Color = 16767935
      Caption = 'Novo Cliente'
      object wwDBGrid1: TwwDBGrid
        Left = 0
        Top = 70
        Width = 576
        Height = 531
        ControlType.Strings = (
          'selected;CheckBox;Yes;No'
          'EDUCATION;CustomEdit;wwRadioGroup1;F'
          'SEX;CustomEdit;wwRadioGroup2;F'
          'MARRIED;CustomEdit;wwCheckBox2;F'
          'RINTERESTS;RichEdit;wwDBRichEdit2;T'
          'IMAGE;CustomEdit;DBImage2;T'
          'PAYMETHOD;CustomEdit;wwRadioGroup2;F'
          'ShippingAddress;CustomEdit;wwExpandButton2;F'
          'Name;CustomEdit;wwExpandButton1;F')
        Selected.Strings = (
          'ID'#9'7'#9'ID'#9'F'
          'CNPJ'#9'15'#9'CNPJ'#9'F'
          'RazaoSocial'#9'40'#9'RazaoSocial'#9'F'
          'Apelido'#9'25'#9'Apelido'#9'F')
        IniAttributes.FileName = 'delphi32.ini.ini'
        IniAttributes.Delimiter = ';;'
        TitleColor = clSkyBlue
        FixedCols = 1
        ShowHorzScrollBar = True
        Align = alClient
        DataSource = DM.ds_qclientes
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Options = [dgEditing, dgAlwaysShowEditor, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgFixedResizable, dgProportionalColResize]
        ParentFont = False
        TabOrder = 0
        TitleAlignment = taCenter
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clBlack
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        TitleLines = 1
        TitleButtons = True
        UseTFields = False
        PaintOptions.BackgroundBitmap.Data = {
          07544269746D617076010000424D760100000000000036000000280000000A00
          00000A000000010018000000000040010000120B0000120B0000000000000000
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          0000}
        PaintOptions.AlternatingRowRegions = [arrDataColumns]
        PaintOptions.FastRecordScrolling = False
        PaintOptions.AlternatingRowColor = clSilver
        PaintOptions.BackgroundOptions = [coFillDataCells, coBlendFixedColumn, coBlendActiveRecord, coBlendAlternatingRow]
        ExplicitHeight = 67
      end
    end
    object JvWizardRouteMapSteps1: TJvWizardRouteMapSteps
      Left = 0
      Top = 0
      Width = 145
      Height = 601
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
    Left = 640
    Top = 536
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
    Left = 512
    Top = 528
  end
end

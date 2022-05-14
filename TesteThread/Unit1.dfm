object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 608
  ClientWidth = 905
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 383
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Label2: TLabel
    Left = 8
    Top = 213
    Width = 73
    Height = 13
    Caption = 'Threads Status'
  end
  object Label3: TLabel
    Left = 303
    Top = 213
    Width = 54
    Height = 13
    Caption = 'POP Status'
  end
  object Button1: TButton
    Left = 32
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 8
    Top = 232
    Width = 289
    Height = 122
    TabOrder = 1
  end
  object PB: TProgressBar
    Left = 8
    Top = 360
    Width = 584
    Height = 17
    TabOrder = 2
  end
  object wwDBGrid1: TwwDBGrid
    Left = 8
    Top = 39
    Width = 833
    Height = 145
    ControlType.Strings = (
      'selecionada;CheckBox;1;0')
    Selected.Strings = (
      'ID'#9'15'#9'ID'#9'F'#9
      'DT'#9'18'#9'DT'#9'F'#9
      'Email'#9'10'#9'Email'#9'F'#9
      'Assunto'#9'10'#9'Assunto'#9'F'#9
      'Emitente'#9'10'#9'Emitente'#9'F'#9
      'ListaNegra'#9'10'#9'ListaNegra'#9'F'#9
      'Favoritos'#9'10'#9'Favoritos'#9'F'#9
      'FiltroResult'#9'10'#9'FiltroResult'#9'F'#9
      'IPSender'#9'15'#9'IPSender'#9'F'#9)
    MemoAttributes = [mSizeable, mWordWrap, mGridShow]
    IniAttributes.Delimiter = ';;'
    TitleColor = clBtnFace
    FixedCols = 0
    ShowHorzScrollBar = True
    DataSource = DM.DataSource1
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgWordWrap, dgShowFooter]
    TabOrder = 3
    TitleAlignment = taLeftJustify
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    TitleLines = 1
    TitleButtons = False
    OnCalcCellColors = wwDBGrid1CalcCellColors
  end
  object seTimeToWork: TSpinEdit
    Left = 256
    Top = 190
    Width = 121
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 4
    Value = 100
  end
  object btnCreate: TButton
    Left = 144
    Top = 8
    Width = 75
    Height = 25
    Caption = 'btnCreate'
    TabOrder = 5
    OnClick = btnCreateClick
  end
  object btnTerminate: TButton
    Left = 240
    Top = 8
    Width = 89
    Height = 25
    Caption = 'btnTerminate'
    TabOrder = 6
    OnClick = btnTerminateClick
  end
  object Button2: TButton
    Left = 352
    Top = 8
    Width = 89
    Height = 25
    Caption = 'btnResume'
    TabOrder = 7
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 608
    Top = 266
    Width = 121
    Height = 25
    Caption = 'JVMThread Pega start'
    TabOrder = 8
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 608
    Top = 297
    Width = 121
    Height = 25
    Caption = 'JVMThread stop'
    TabOrder = 9
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 32
    Top = 200
    Width = 75
    Height = 25
    Caption = 'Button5'
    TabOrder = 10
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 144
    Top = 201
    Width = 75
    Height = 25
    Caption = 'Button6'
    TabOrder = 11
    OnClick = Button6Click
  end
  object SpeedBar: TTrackBar
    Left = 598
    Top = 328
    Width = 154
    Height = 40
    Max = 500
    Frequency = 50
    Position = 1
    TabOrder = 12
    OnChange = SpeedBarChange
  end
  object Button7: TButton
    Left = 608
    Top = 235
    Width = 121
    Height = 25
    Caption = 'Thread Filtra start'
    TabOrder = 13
    OnClick = Button7Click
  end
  object EIP: TJvIPAddress
    Left = 471
    Top = 80
    Width = 150
    Height = 21
    Address = -925902584
    AddressValues.Address = -925902584
    AddressValues.Value1 = 200
    AddressValues.Value2 = 207
    AddressValues.Value3 = 217
    AddressValues.Value4 = 8
    ParentColor = False
    TabOrder = 14
    Text = '200.207.217.8'
    Visible = False
  end
  object Memo2: TMemo
    Left = 303
    Top = 232
    Width = 289
    Height = 122
    TabOrder = 15
  end
  object Button8: TButton
    Left = 24
    Top = 472
    Width = 97
    Height = 25
    Caption = 'IDThreade Start'
    TabOrder = 16
    OnClick = Button8Click
  end
  object JvMTManager1: TJvMTManager
    Left = 672
    Top = 256
  end
  object ThreadPegaEmail: TJvMTThread
    Manager = JvMTManager1
    RunOnCreate = False
    OnExecute = ThreadPegaEmailExecute
    OnFinished = ThreadPegaEmailFinished
    Left = 608
    Top = 208
  end
  object Buffer: TJvMTThreadToVCL
    OnCanRead = BufferCanRead
    Left = 672
    Top = 312
  end
  object Section: TJvMTCountingSection
    Left = 496
    Top = 400
  end
  object JvMTThreadToThread1: TJvMTThreadToThread
    Left = 416
    Top = 248
  end
  object ThreadFiltraMSG: TJvMTThread
    Manager = JvMTManager2
    RunOnCreate = False
    OnExecute = ThreadFiltraMSGExecute
    OnFinished = ThreadFiltraMSGFinished
    Left = 40
    Top = 240
  end
  object JvMTManager2: TJvMTManager
    Left = 120
    Top = 240
  end
  object JvMTThreadToVCL1: TJvMTThreadToVCL
    OnCanRead = JvMTThreadToVCL1CanRead
    Left = 680
    Top = 392
  end
  object JvMTMonitorSection1: TJvMTMonitorSection
    Left = 576
    Top = 400
  end
  object IdThreadComponent1: TIdThreadComponent
    Active = False
    Loop = False
    Priority = tpNormal
    StopMode = smTerminate
    OnRun = IdThreadComponent1Run
    Left = 168
    Top = 456
  end
end

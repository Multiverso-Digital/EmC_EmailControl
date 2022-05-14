unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ToolWin, ActnMan, ActnCtrls, Ribbon, ActnList, ImgList,
  PlatformDefaultStyleActnCtrls, RibbonLunaStyleActnCtrls, ActnMenus,
  RibbonActnMenus, Menus, ActnPopup, StdActns, ExtActns, JvDialogActns,
  StdCtrls, RibbonActnCtrls, RibbonSilverStyleActnCtrls, JvDBActions,
  JvActionsEngine, wwDialog, wwrcdvw, ScreenTips, DB, MemDS, DBAccess, MyAccess,
  RibbonObsidianStyleActnCtrls;

type
  TForm2 = class(TForm)
    Ribbon1: TRibbon;
    RibbonPage1: TRibbonPage;
    RibbonGroup1: TRibbonGroup;
    RibbonQuickAccessToolbar1: TRibbonQuickAccessToolbar;
    RibbonApplicationMenuBar1: TRibbonApplicationMenuBar;
    RibbonPage2: TRibbonPage;
    RibbonGroup2: TRibbonGroup;
    RibbonComboBox1: TRibbonComboBox;
    RibbonPage3: TRibbonPage;
    RibbonGroup3: TRibbonGroup;
    PopupActionBar1: TPopupActionBar;
    MyConnection1: TMyConnection;
    MyQuery1: TMyQuery;
    ScreenTipsManager1: TScreenTipsManager;
    wwRecordViewDialog1: TwwRecordViewDialog;
    ImageList2: TImageList;
    ImageList1: TImageList;
    ilGFX16: TImageList;
    ilGFX32: TImageList;
    ilGFX16_d: TImageList;
    ilGFX32_d: TImageList;
    ilBulletNumberGallery: TImageList;
    ActionManager1: TActionManager;
    Action1: TAction;
    FileOpen1: TFileOpen;
    FileOpenWith1: TFileOpenWith;
    FileSaveAs1: TFileSaveAs;
    FilePrintSetup1: TFilePrintSetup;
    FilePageSetup1: TFilePageSetup;
    FileExit1: TFileExit;
    RichEditBold1: TRichEditBold;
    RichEditItalic1: TRichEditItalic;
    RichEditUnderline1: TRichEditUnderline;
    RichEditStrikeOut1: TRichEditStrikeOut;
    RichEditBullets1: TRichEditBullets;
    RichEditAlignLeft1: TRichEditAlignLeft;
    RichEditAlignRight1: TRichEditAlignRight;
    RichEditAlignCenter1: TRichEditAlignCenter;
    JvSelectDirectoryAction1: TJvSelectDirectoryAction;
    JvDatabaseInsertAction1: TJvDatabaseInsertAction;
    JvDatabaseCopyAction1: TJvDatabaseCopyAction;
    JvDatabaseEditAction1: TJvDatabaseEditAction;
    JvDatabaseDeleteAction1: TJvDatabaseDeleteAction;
    JvDatabasePostAction1: TJvDatabasePostAction;
    JvDatabaseCancelAction1: TJvDatabaseCancelAction;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    EditSelectAll1: TEditSelectAll;
    EditUndo1: TEditUndo;
    EditDelete1: TEditDelete;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

end.

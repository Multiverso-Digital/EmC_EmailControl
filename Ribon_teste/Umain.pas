unit Umain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ToolWin, ActnMan, ActnCtrls, Ribbon, ActnList, ImgList,
  PlatformDefaultStyleActnCtrls, RibbonLunaStyleActnCtrls, ActnMenus,
  RibbonActnMenus, Menus, ActnPopup, StdActns, ExtActns, JvDialogActns,
  StdCtrls, RibbonActnCtrls, RibbonSilverStyleActnCtrls, JvDBActions,
  JvActionsEngine, wwDialog, wwrcdvw, ScreenTips, DB, MemDS, DBAccess, MyAccess,
  RibbonObsidianStyleActnCtrls, ComCtrls, JvExComCtrls, JvStatusBar,
  JvComponentBase, JvFormMagnet, JvExControls, JvEmbeddedForms;

type
  TFmain = class(TForm)
    PopupActionBar1: TPopupActionBar;
    ScreenTipsManager1: TScreenTipsManager;
    ilGFX16: TImageList;
    ilGFX32: TImageList;
    ilGFX16_d: TImageList;
    ilGFX32_d: TImageList;
    ilBulletNumberGallery: TImageList;
    Ribbon1: TRibbon;
    RibbonPage1: TRibbonPage;
    RibbonPage2: TRibbonPage;
    RibbonApplicationMenuBar1: TRibbonApplicationMenuBar;
    RibbonQuickAccessToolbar1: TRibbonQuickAccessToolbar;
    JvStatusBar1: TJvStatusBar;
    RibbonGroup1: TRibbonGroup;
    JvEmbeddedFormPanel1: TJvEmbeddedFormPanel;
    RibbonGroup2: TRibbonGroup;
    ActionManager1: TActionManager;
    FileOpen2: TFileOpen;
    FileSaveAs2: TFileSaveAs;
    FilePrintSetup2: TFilePrintSetup;
    FilePageSetup2: TFilePageSetup;
    FileExit2: TFileExit;
    EditCut2: TEditCut;
    EditCopy2: TEditCopy;
    EditPaste2: TEditPaste;
    EditSelectAll2: TEditSelectAll;
    EditUndo2: TEditUndo;
    EditDelete2: TEditDelete;
    FileSaveActn: TAction;
    FileNewActn: TAction;
    RichEditBold2: TRichEditBold;
    RichEditItalic2: TRichEditItalic;
    FontCalibriActn: TAction;
    FontCambriaActn: TAction;
    FontCourierNewActn: TAction;
    FontArialRoundedMTBoldActn: TAction;
    FontArialActn: TAction;
    FontArialNarrowActn: TAction;
    FontTahomaActn: TAction;
    FontSegoeUIActn: TAction;
    FontSegoeScriptActn: TAction;
    RichEditUnderline2: TRichEditUnderline;
    RichEditStrikeOut2: TRichEditStrikeOut;
    RichEditBullets2: TRichEditBullets;
    RichEditAlignLeft2: TRichEditAlignLeft;
    RichEditAlignRight2: TRichEditAlignRight;
    RichEditAlignCenter2: TRichEditAlignCenter;
    SearchFind1: TSearchFind;
    SearchReplace1: TSearchReplace;
    LunaStyleActn: TAction;
    ObsidianStyleActn: TAction;
    SilverStyleActn: TAction;
    FileCloseActn: TAction;
    FileSaveAsText: TAction;
    FileSaveAsRTF: TAction;
    FileQuickPrint: TAction;
    FilePrintPreview: TAction;
    FontGrowSizeActn: TAction;
    FontShrinkSizeActn: TAction;
    FontSubscriptActn: TAction;
    FontSuperScriptActn: TAction;
    ChangeCaseSentenceActn: TAction;
    ChangeCaseLowerActn: TAction;
    ChangeCaseUpperActn: TAction;
    ChangeCaseCapitalizeActn: TAction;
    ChangeCaseToggleActn: TAction;
    FontHighlightActn: TAction;
    FontColorActn: TAction;
    ChangeCaseActn: TAction;
    EditPasteSpecial: TAction;
    EditPasteHyperlink: TAction;
    FileRun1: TFileRun;
    FontEdit1: TFontEdit;
    PrintDlg1: TPrintDlg;
    RadioAction1: TAction;
    RadioAction2: TAction;
    RadioAction3: TAction;
    CheckboxAction1: TAction;
    CheckboxAction2: TAction;
    CheckboxAction3: TAction;
    NumberingActn: TAction;
    Action1: TAction;
    procedure FileNewActnExecute(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fmain: TFmain;

implementation

uses Uproj, Ucliente;

{$R *.dfm}

procedure TFmain.Action1Execute(Sender: TObject);
begin
FCliente := TFCliente.Create(Fmain);
FCliente.top := Ribbon1.Height;
JvEmbeddedFormPanel1.FormLink := FCliente.JvEmbeddedFormLink1;
FCliente.Update;
FCliente.Show;
end;

procedure TFmain.FileNewActnExecute(Sender: TObject);
begin
Fproj := TFproj.Create(Fmain);
JvEmbeddedFormPanel1.FormLink := Fproj.JvEmbeddedFormLink1;
Fproj.top := Ribbon1.Height;
Fproj.Update;
Fproj.Show;
end;

end.

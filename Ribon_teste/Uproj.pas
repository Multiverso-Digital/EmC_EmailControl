unit Uproj;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvComponentBase, JvFormMagnet, JvFormAutoSize, JvEmbeddedForms,
  StdCtrls, ExtCtrls, JvExExtCtrls, JvExtComponent, JvCaptionPanel,
  JvComponentPanel, JvExControls, JvRuler, JvLookOut, JvPageList,
  JvNavigationPane, JvButton, JvgHelpPanel, JvgTransparentMemo, JvExStdCtrls,
  JvRichEdit, JvDotNetControls, JvWizard, JvWizardRouteMapSteps, Buttons, Grids,
  Wwdbigrd, Wwdbgrid, wwDialog, wwrcdvw, wwSpeedButton, wwDBNavigator,
  wwclearpanel, wwrcdpnl, Wwintl;

type
  TFproj = class(TForm)
    JvEmbeddedFormLink1: TJvEmbeddedFormLink;
    JvWizard1: TJvWizard;
    JvWizardInteriorPage1: TJvWizardInteriorPage;
    JvWizardRouteMapSteps1: TJvWizardRouteMapSteps;
    JvWizardInteriorPage2: TJvWizardInteriorPage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ENomeProjeto: TLabeledEdit;
    EDescProjeto: TMemo;
    Label4: TLabel;
    EnomeCliente: TLabeledEdit;
    JvWizardInteriorPage3: TJvWizardInteriorPage;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    BitBtn1: TBitBtn;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    wwRecordViewDialog1: TwwRecordViewDialog;
    wwDBGrid1: TwwDBGrid;
    wwDBNavigator1: TwwDBNavigator;
    wwDBNavigator1First: TwwNavButton;
    wwDBNavigator1PriorPage: TwwNavButton;
    wwDBNavigator1Prior: TwwNavButton;
    wwDBNavigator1Next: TwwNavButton;
    wwDBNavigator1NextPage: TwwNavButton;
    wwDBNavigator1Last: TwwNavButton;
    wwDBNavigator1Insert: TwwNavButton;
    wwDBNavigator1Delete: TwwNavButton;
    wwDBNavigator1Edit: TwwNavButton;
    wwDBNavigator1Post: TwwNavButton;
    wwDBNavigator1Cancel: TwwNavButton;
    wwDBNavigator1Refresh: TwwNavButton;
    wwDBNavigator1SaveBookmark: TwwNavButton;
    wwDBNavigator1RestoreBookmark: TwwNavButton;
    wwRecordViewPanel1: TwwRecordViewPanel;
    wwDBGrid1IButton: TwwIButton;
    procedure JvWizardInteriorPage1EnterPage(Sender: TObject;
      const FromPage: TJvWizardCustomPage);
    procedure JvWizardInteriorPage1ExitPage(Sender: TObject;
      const FromPage: TJvWizardCustomPage);
    procedure wwDBGrid1DblClick(Sender: TObject);
    procedure wwDBGrid1IButtonClick(Sender: TObject);
    procedure JvWizard1CancelButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fproj: TFproj;

implementation

uses udm;

{$R *.dfm}

procedure TFproj.JvWizard1CancelButtonClick(Sender: TObject);
begin
close;
end;

procedure TFproj.JvWizardInteriorPage1EnterPage(Sender: TObject;
  const FromPage: TJvWizardCustomPage);
begin
if not dm.qClientes.Active then dm.qClientes.Active := true;

end;

procedure TFproj.JvWizardInteriorPage1ExitPage(Sender: TObject;
  const FromPage: TJvWizardCustomPage);
begin
if dm.qClientes.Active then dm.qClientes.Active := false;
end;

procedure TFproj.wwDBGrid1DblClick(Sender: TObject);
begin
wwRecordViewDialog1.Execute;

end;

procedure TFproj.wwDBGrid1IButtonClick(Sender: TObject);
begin
 wwRecordViewDialog1.Execute;
end;

end.

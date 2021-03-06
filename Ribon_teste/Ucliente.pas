unit Ucliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvWizard, JvWizardRouteMapSteps, JvExControls, JvComponentBase,
  JvEmbeddedForms, Buttons, Wwdbigrd, Grids, Wwdbgrid, wwDialog, wwrcdvw;

type
  TFCliente = class(TForm)
    JvEmbeddedFormLink1: TJvEmbeddedFormLink;
    JvWizard1: TJvWizard;
    JvWizardRouteMapSteps1: TJvWizardRouteMapSteps;
    JvWizardInteriorPage1: TJvWizardInteriorPage;
    wwRecordViewDialog1: TwwRecordViewDialog;
    wwDBGrid1: TwwDBGrid;
    procedure JvWizard1CancelButtonClick(Sender: TObject);
    procedure wwDBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCliente: TFCliente;

implementation

uses udm;

{$R *.dfm}

procedure TFCliente.JvWizard1CancelButtonClick(Sender: TObject);
begin
close;
end;

procedure TFCliente.wwDBGrid1DblClick(Sender: TObject);
begin
wwRecordViewDialog1.Execute;
end;

end.

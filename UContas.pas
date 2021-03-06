unit UContas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, Wwdbigrd, Wwdbgrid, JvComponentBase, {JvEmbeddedForms,}
  ComCtrls, ToolWin, wwDialog, wwrcdvw, StdCtrls, Mask, wwdbedit, Wwintl,
  wwcheckbox, wwrcdpnl, db, Wwdotdot, Wwdbcomb;

type
  TFContas = class(TForm)
    wwDBGrid1: TwwDBGrid;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    BalloonHint1: TBalloonHint;
    procedure wwDBGrid1DblClick(Sender: TObject);
    procedure wwRecordViewDialog1AfterCreateControl(Form: TwwRecordViewForm;
      curField: TField; Control: TControl);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ToolButton5Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
   
  private
  Procedure MostraForm;
  Procedure MostraFormType;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  FContas: TFContas;

implementation

uses udmserver, umain, UImportAccounts, UExportAccounts, Utypeacct, Ucontas_new;

{$R *.dfm}

procedure TFContas.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin

//dm_server.cds_Contas.ApplyUpdates(0);
//dm_server.cds_Contas.refresh;
dm_server.cds_Contas.filtered := true;

end;

procedure TFContas.FormShow(Sender: TObject);
begin
dm_server.cds_Contas.filtered := false;
end;


Procedure TFContas.MostraFormType;
begin
FTypeAcct := TFTypeAcct.create(self);
FTypeAcct.showmodal;
FTypeAcct.free;
end;




Procedure TFContas.MostraForm;
begin

dm_server.TipoConta := dm_server.Cds_ContasTipo.AsString;
dm_server.Cds_Contas.Edit;

Fcontas_new := TFcontas_new.create(self);
Fcontas_new.showmodal;
Fcontas_new.free;

//wwRecordViewDialog1.Execute;
end;

procedure TFContas.ToolButton1Click(Sender: TObject);
begin

dm_server.Cds_Contas.Append;
MostraFormType;


end;

procedure TFContas.ToolButton2Click(Sender: TObject);
begin

FimportAccounts := TFimportAccounts.create(self);
FimportAccounts.showmodal;
FimportAccounts.free;


end;

procedure TFContas.ToolButton5Click(Sender: TObject);
begin
FexportAccounts := TFexportAccounts.create(self);
FexportAccounts.showmodal;
FexportAccounts.free;
end;

procedure TFContas.wwDBGrid1DblClick(Sender: TObject);
begin
MostraForm;
end;

procedure TFContas.wwRecordViewDialog1AfterCreateControl(
  Form: TwwRecordViewForm; curField: TField; Control: TControl);
begin
Form.Color := $00F3E5D5;
Form.RecordPanel.Color := $00F3E5D5;
end;



end.

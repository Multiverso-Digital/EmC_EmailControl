unit UMyComputer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, JvExControls, JvInspector, JvExStdCtrls,
  JvRichEdit, ComCtrls, JvComputerInfoEx, JvComponentBase;

type
  TFmycomputer = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    JvInspectorBorlandPainter1: TJvInspectorBorlandPainter;
    JvComputerInfoEx1: TJvComputerInfoEx;
    PageControl1: TPageControl;
    JvInspector1: TJvInspector;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fmycomputer: TFmycomputer;

implementation

{$R *.dfm}

procedure TFmycomputer.Button1Click(Sender: TObject);
begin
close;
end;

procedure TFmycomputer.FormCreate(Sender: TObject);
begin
JvInspector1.InspectObject := JvComputerInfoEx1;
end;

end.

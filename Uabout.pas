unit Uabout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls,  StdCtrls, JvHtControls, JvExStdCtrls, JvBehaviorLabel;

type
  TFabout = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    JvBehaviorLabel1: TJvBehaviorLabel;
    JvBehaviorLabel3: TJvBehaviorLabel;
    Label2: TLabel;
    Button1: TButton;
    JvHTLabel1: TJvHTLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fabout: TFabout;

implementation

uses UMyComputer;

{$R *.dfm}

procedure TFabout.Button1Click(Sender: TObject);
begin
close;
end;

procedure TFabout.Button2Click(Sender: TObject);
begin
FmyComputer := TFmyComputer.create(self);
FmyComputer.showmodal;
FmyComputer.free;
end;

end.

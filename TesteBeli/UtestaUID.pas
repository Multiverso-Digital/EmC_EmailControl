unit UtestaUID;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdAntiFreezeBase, IdAntiFreeze, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase,
  IdMessageClient, IdPOP3, shellapi, IdMessage, JvLogFile, JvWinHelp,
  JvTranslator, JvComponentBase, JvTranslateString;

type
  TForm1 = class(TForm)
    POP: TIdPOP3;
    IdAntiFreeze1: TIdAntiFreeze;
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit1: TEdit;
    MSG: TIdMessage;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin

POP.Connect;
POP.UIDL(Memo1.lines);

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
POP.Disconnect;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
Testa : string;
begin

Memo1.lines.Clear;

POP.RetrieveRaw(strtoint(edit1.text),Memo1.lines);
POP.Retrieve(strtoint(edit1.text),MSG);
memo1.Lines.SaveToFile('c:\teste.msg');
//ShellExecute (hwnd, "open", "mailto:" & txtTo.Text & "?cc=" & txtCc.Text & "&bcc=" & txtBcc.Text & "&subject=" & txtSubject.Text &  "&body=" & Replace(txtMessage.Text, vbCrLf, "%0D%0A"),  vbNullString, vbNullString, SW_SHOW);




Testa := 'MailTo:'+MSG.Sender.Address+'?Subject='+MSG.Subject+'&body='+MSG.Body.;


ShellExecute(handle, 'open', Pchar(testa),nil, nil, SW_SHOW);


end;

end.

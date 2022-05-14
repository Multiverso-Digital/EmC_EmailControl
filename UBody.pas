unit UBody;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, ComCtrls, ToolWin, StdCtrls, ExtCtrls, shellapi, funcoes,
  JvComponentBase, JvMail, JvHtmlParser;

type
  TFBody = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    CBAttach: TComboBox;
    CBCC: TComboBox;
    Efrom: TEdit;
    ETo: TEdit;
    Esubject: TEdit;
    Edate: TEdit;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    WebBrowser1: TWebBrowser;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    StatusBar1: TStatusBar;
    JvMail1: TJvMail;
    JvHTMLParser1: TJvHTMLParser;
    ToolButton6: TToolButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure CBAttachClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure WebBrowser1StatusTextChange(ASender: TObject;
      const Text: WideString);
    procedure ToolButton6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FBody: TFBody;

implementation

uses umain, udmserver;

{$R *.dfm}

procedure TFBody.CBAttachClick(Sender: TObject);
var
Monta : string;
Exte  : string;
begin

if CBAttach.ItemIndex >= 0 then
   begin
     Exte := ExtractFileExt(dm_server.Dire+'Anexos\A_'+inttostr(dm_server.cds_mensID.asinteger)+'_'+Cbattach.Items[Cbattach.itemindex]);
     if (uppercase(exte) = '.SCR') or (uppercase(exte) = '.EXE') or (uppercase(exte) = '.COM') or (uppercase(exte) = '.BAT') then
         begin

          if Dialogs.MessageDlg('EmC_WARNING: You try to run a unknow file. Are you sure ?',
          mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrNo then
             begin
             exit;
             end
             else
             begin
              monta := dm_server.Dire+'Anexos\A_'+inttostr(dm_server.cds_mensID.asinteger)+'_'+Cbattach.Items[Cbattach.itemindex];
              shellexecute(handle, 'open',pchar(monta),nil,nil,SW_SHOWNORMAL);
             end;



         end
         else
         begin
          monta := dm_server.Dire+'Anexos\A_'+inttostr(dm_server.cds_mensID.asinteger)+'_'+Cbattach.Items[Cbattach.itemindex];
          shellexecute(handle, 'open',pchar(monta),nil,nil,SW_SHOWNORMAL);
         end;


   end;



end;

procedure TFBody.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 //dm_server.qbody.Active := false;
end;

procedure TFBody.FormCreate(Sender: TObject);
begin


{

with dm_server do
begin

if qbody.Active then qbody.Active := false;
  if BodyDB = 1  then
    begin
     qbody.SQL.Strings[1] := 'from messages';
    end;
  if BodyDB = 2  then
    begin
     qbody.SQL.Strings[1] := 'from all_messages';
    end;

  qbody.Params[0].AsInteger := BodyID;
  qbody.Active := true;




end;
 }


end;

procedure TFBody.FormShow(Sender: TObject);
var
I : integer;
CCMSG : TstringList;
Exte : string;
begin



with dm_server do
begin


if EstounoMenu <> 6 then
begin
Efrom.Text      := cds_mensEmailFrom.AsString;
ETo.Text        := ExtrairRegexp(EmailRegExp,cds_mensEmail.AsString);
Edate.Text      := cds_mensDataOrig.AsString;
Esubject.Text   := cds_mensAssunto.AsString;
end
else
begin
Efrom.Text      := cds_ALLMEmailFrom.AsString;
ETo.Text        := ExtrairRegexp(EmailRegExp,cds_ALLMEmail.AsString);
Edate.Text      := cds_ALLMDataOrig.AsString;
Esubject.Text   := cds_ALLMAssunto.AsString;
end;




if Bodyheader = 0  then
begin

   if estounomenu <> 6 then
      begin

      CBAttach.Items.Text := cds_mensAnexosFiles.asstring;
      for I:=  0 to CBAttach.Items.Count - 1 do
      begin
         Exte := ExtractFileExt(dm_server.Dire+'Anexos\A_'+inttostr(dm_server.cds_mensID.asinteger)+'_'+Cbattach.Items[I]);
         if (uppercase(exte) = '.SCR') or (uppercase(exte) = '.EXE') or (uppercase(exte) = '.COM') or (uppercase(exte) = '.BAT') then
         begin
         ToolButton6.Visible := true;
         CBAttach.Enabled := false;
         end
         else
         begin
         ToolButton6.Visible := false;
         CBAttach.Enabled := true;
         end;
      end;
      if CBAttach.Items.Count > 0 then
         begin
          label6.Visible       := true;
          CBAttach.visible     := true;
          CBAttach.ItemIndex := 0;
        end;
      deletefile(dm_server.dire+'@EmCBody.txt');
      deletefile(dm_server.dire+'@EmCBody.html');
      cds_mensCorpoTexto.SaveToFile(dm_server.dire+'@EmCBody.html');
      WebBrowser1.Navigate('file:///'+dm_server.Dire+'@EmCBody.html');

      end
      else
      begin

      CBAttach.Items.Text := Cds_ALLMAnexosFiles.asstring;
      for I:=  0 to CBAttach.Items.Count - 1 do
      begin
         Exte := ExtractFileExt(dm_server.Dire+'Anexos\A_'+inttostr(dm_server.Cds_ALLMID1.asinteger)+'_'+Cbattach.Items[I]);
         if (uppercase(exte) = '.SCR') or (uppercase(exte) = '.EXE') or (uppercase(exte) = '.COM') or (uppercase(exte) = '.BAT') then
         begin
         ToolButton6.Visible := true;
         CBAttach.Enabled := false;
         end
         else
         begin
         ToolButton6.Visible := false;
         CBAttach.Enabled := true;
         end;
      end;
      if CBAttach.Items.Count > 0 then
         begin
          label6.Visible       := true;
          CBAttach.visible     := true;
          CBAttach.ItemIndex := 0;
        end;
      deletefile(dm_server.dire+'@EmCBody.txt');
      deletefile(dm_server.dire+'@EmCBody.html');
      Cds_ALLMCorpoTexto.SaveToFile(dm_server.dire+'@EmCBody.html');
      WebBrowser1.Navigate('file:///'+dm_server.Dire+'@EmCBody.html');
      end;






end
else
begin
        FBody.caption := 'mC-Message Header';
        Fbody.Update;
        Toolbutton3.Visible := false;
        Toolbutton5.Visible := false;
        ToolButton2Click(self);
end;


end;


end;

procedure TFBody.ToolButton1Click(Sender: TObject);
var
Monta, Mensa : string;
Parse : TstringList;
Arq   : TFileName;
begin

if dm_server.EstounoMenu <> 6 then
begin
  screen.cursor := crSqlWait;
  JvMail1.Clear;
  JvMail1.Recipient.AddRecipient(Efrom.text);
  JvMail1.Subject   := ESubject.text;
  JvMail1.Body.Text := dm_server.Cds_MensCorpo.Asstring ;
  JvMail1.SendMail;
  screen.cursor := crDefault;

end
else
begin
  screen.cursor := crSqlWait;
  JvMail1.Clear;
  JvMail1.Recipient.AddRecipient(Efrom.text);
  JvMail1.Subject := ESubject.text;
  JvMail1.Body.Text := dm_server.cds_ALLMCorpo.Asstring ;
  JvMail1.SendMail;
  screen.cursor := crDefault;

end;

end;

procedure TFBody.ToolButton2Click(Sender: TObject);
var
Teste : TstringList;
begin

if dm_server.EstounoMenu <> 6 then
begin

Teste := TstringList.Create;
Teste.text := dm_server.Cds_MensCabec.asstring;
teste.savetofile(dm_server.dire+'@EmCCabec.txt',TEncoding.unicode);
Teste.Free;
WebBrowser1.Navigate('file:///'+dm_server.Dire+'@EmCCabec.txt');
StatusBar1.Panels.Items[0].Text := 'Show Header';

end
else
begin
Teste := TstringList.Create;
Teste.text := dm_server.cds_ALLMCabec.asstring;
teste.savetofile(dm_server.dire+'@EmCCabec.txt',TEncoding.unicode);
Teste.Free;
WebBrowser1.Navigate('file:///'+dm_server.Dire+'@EmCCabec.txt');
StatusBar1.Panels.Items[0].Text := 'Show Header';
end;


end;

procedure TFBody.ToolButton3Click(Sender: TObject);
var
Arquivo : string;
begin


if dm_server.EstounoMenu <> 6 then
begin
Arquivo := 'file:///'+dm_server.Dire+'Anexos/R_'+inttostr(dm_server.Cds_MensID.asinteger)+'.txt';
WebBrowser1.Navigate(arquivo);
StatusBar1.Panels.Items[0].Text := 'Show Source';
end
else
begin
Arquivo := 'file:///'+dm_server.Dire+'Anexos/R_'+inttostr(dm_server.Cds_ALLMID1.asinteger)+'.txt';
WebBrowser1.Navigate(arquivo);
StatusBar1.Panels.Items[0].Text := 'Show Source';
end;


end;

procedure TFBody.ToolButton5Click(Sender: TObject);
begin


WebBrowser1.Navigate('file:///'+dm_server.Dire+'@EmCBody.html');


end;

procedure TFBody.ToolButton6Click(Sender: TObject);
begin

 if Dialogs.MessageDlg('EmC_WARNING: Attachments unsafe or unknow. Do you want to enable it ?',
          mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrNo then
             begin
             exit;
             end ;

CBAttach.Enabled := true;


end;

procedure TFBody.WebBrowser1StatusTextChange(ASender: TObject;
  const Text: WideString);
begin
StatusBar1.Panels.Items[0].Text := Text;
end;

end.

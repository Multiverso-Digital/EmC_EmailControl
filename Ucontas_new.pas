unit Ucontas_new;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DBCtrls, Mask, ComCtrls, db, IdIntercept,
  IdLogBase, IdLogEvent, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack,
  IdSSL, IdSSLOpenSSL, IdIMAP4, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient, IdPOP3,
  IdServerInterceptLogBase, IdServerInterceptLogEvent, funcoes, JvComponentBase,
  JvMail;

type
  TFContas_New = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    Label3: TLabel;
    DBEdit2: TDBEdit;
    Label4: TLabel;
    DBEdit3: TDBEdit;
    Label5: TLabel;
    DBEdit4: TDBEdit;
    DBRadioGroup1: TDBRadioGroup;
    DBRadioGroup2: TDBRadioGroup;
    Label6: TLabel;
    Label7: TLabel;
    DBEdit5: TDBEdit;
    Label8: TLabel;
    DBEdit6: TDBEdit;
    Label9: TLabel;
    DBEdit7: TDBEdit;
    Label10: TLabel;
    DBEdit8: TDBEdit;
    DBRadioGroup3: TDBRadioGroup;
    Label11: TLabel;
    Label12: TLabel;
    DBEdit9: TDBEdit;
    Label13: TLabel;
    DBEdit10: TDBEdit;
    Label14: TLabel;
    DBEdit11: TDBEdit;
    DBRadioGroup4: TDBRadioGroup;
    GroupBox1: TGroupBox;
    Label16: TLabel;
    DBEdit13: TDBEdit;
    Label17: TLabel;
    DBEdit14: TDBEdit;
    Button1: TButton;
    Button2: TButton;
    DBEdit12: TDBEdit;
    DBEdit15: TDBEdit;
    DBEdit16: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    DBCheckBox5: TDBCheckBox;
    Button3: TButton;
    Button4: TButton;
    POP3: TIdPOP3;
    IMAP4: TIdIMAP4;
    SSL1: TIdSSLIOHandlerSocketOpenSSL;
    IdLogEvent1: TIdLogEvent;
    memo1: TListBox;
    Button5: TButton;
    Label15: TLabel;
    DBEdit17: TDBEdit;
    Label18: TLabel;
    DBEdit18: TDBEdit;
    Label19: TLabel;
    DBEdit19: TDBEdit;
    Label20: TLabel;
    DBEdit20: TDBEdit;
    JvMail1: TJvMail;
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DBCheckBox1Click(Sender: TObject);
    procedure DBCheckBox2Click(Sender: TObject);
    procedure DBRadioGroup2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure IdLogEvent1Status(ASender: TComponent; const AText: string);
    procedure Button4Click(Sender: TObject);
    procedure SSL1Status(ASender: TObject; const AStatus: TIdStatus;
      const AStatusText: string);
    procedure SSL1StatusInfo(Msg: string);
    procedure POP3Status(ASender: TObject; const AStatus: TIdStatus;
      const AStatusText: string);
    procedure Button5Click(Sender: TObject);
  private

  procedure MontaPOP;
  procedure MontaIMAP;
  procedure MontaHOTMail;
  procedure CriticaPOP;
  procedure CriticaIMAP;
  procedure CriticaHotMail;
  procedure EnviaEmail(Email,Identi:string);




    { Private declarations }
  public
    { Public declarations }
  end;

var
  FContas_New: TFContas_New;
  erro : boolean;
  Numero : Tguid;

implementation

uses UDMSERVER;

{$R *.dfm}

procedure TFContas_New.EnviaEmail(Email,Identi:string);
var
Subje, email2 : string;
begin

{

  screen.cursor := crSqlWait;
  JvMail1.Clear;
  JvMail1.Recipient.AddRecipient(Efrom.text);
  JvMail1.Subject   := ESubject.text;
  JvMail1.Body.Text := dm_server.Cds_MensCorpo.Asstring ;
  JvMail1.SendMail;
  screen.cursor := crDefault;

 }



  screen.cursor := crSqlWait;

  Subje   :=  'EmC-Authentication '+Identi;
  email2  :=  email;

  try
  JvMail1.Clear;
  JvMail1.Recipient.AddRecipient(email2);
  JvMail1.Subject := Subje;

   if Dialogs.MessageDlg('Authentication method is ready to send e-mail to you with subject= '+ Subje+ ' and address = '+ email2+'.  Continue?',
    mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrNo then
  begin
   exit;
  end;

  JvMail1.Body.add(' This email create a Friend Filter to authenticate your account when you send message to yourself. When you reiceve that the EmC will create a Friend Filter.') ;
  JvMail1.SendMail;
  except
  end;


  screen.cursor := crDefault;



end;



procedure TFContas_New.CriticaHotmail;
var
Teste : integer;
begin

erro := false;

  if trim(dbedit12.edittext) = '' then
     begin
       erro := true;
       showmessage('Account Name missing.');
       exit;
     end;

  if trim(dbedit1.edittext) = '' then
     begin
       erro := true;
       showmessage('POP3 Server missing.');
       exit;
     end;

  if trim(dbedit2.edittext) = '' then
     begin
       erro := true;
       showmessage('User name missing.');
       exit;
     end;

  if trim(dbedit3.edittext) = '' then
     begin
       erro := true;
       showmessage('Password missing.');
       exit;
     end;


  if trim(dbedit4.edittext) = '' then
     begin
       erro := true;
       showmessage('Port missing.');
       exit;
     end;


try
teste := strtoint(trim(dbedit4.edittext));
except
showmessage('Port accept only numbers.');
exit;
end;

  if dm_server.VeSeExisteNomeConta(trim(dbedit12.edittext)) then
     begin
        if dm_server.Cds_Contas.State = dsinsert then
            begin
              showmessage('This account already exists.');
              erro := true;
              exit;
            end;
     end;


  if dm_server.VeSeExisteUsuarioConta(trim(dbedit1.edittext),trim(dbedit2.edittext),strtoint(trim(dbedit4.edittext))) then
     begin
        if dm_server.Cds_Contas.State = dsinsert then
            begin
              showmessage('This Server/User/Port already exists.');
              erro := true;
            end;
     end;


end;















procedure TFContas_New.CriticaIMAP;
var
Teste : integer;
begin

erro := false;

  if trim(dbedit15.edittext) = '' then
     begin
       erro := true;
       showmessage('Account Name missing.');
       exit;
     end;

  if trim(dbedit5.edittext) = '' then
     begin
       erro := true;
       showmessage('IMAP Server missing.');
       exit;
     end;

  if trim(dbedit6.edittext) = '' then
     begin
       erro := true;
       showmessage('User name missing.');
       exit;
     end;

  if trim(dbedit7.edittext) = '' then
     begin
       erro := true;
       showmessage('Password missing.');
       exit;
     end;



  if trim(dbedit18.edittext) = '' then
     begin
       erro := true;
       showmessage('E-Mail missing.');
       exit;
     end;


  if not buscaRegexp(dm_server.EmailRegExp,trim(dbedit18.edittext),3) then
  begin
       erro := true;
       showmessage('Wrong E-Mail address.');
       exit;
  end;







  if trim(dbedit8.edittext) = '' then
     begin
       erro := true;
       showmessage('Port missing.');
       exit;
     end;


try
teste := strtoint(trim(dbedit8.edittext));
except
showmessage('Port accept only numbers.');
exit;
end;

  if dm_server.VeSeExisteNomeConta(trim(dbedit15.edittext)) then
     begin
        if dm_server.Cds_Contas.State = dsinsert then
            begin
              showmessage('This account already exists.');
              erro := true;
              exit;
            end;
     end;


  if dm_server.VeSeExisteUsuarioConta(trim(dbedit5.edittext),trim(dbedit6.edittext),strtoint(trim(dbedit8.edittext))) then
     begin
        if dm_server.Cds_Contas.State = dsinsert then
            begin
              showmessage('This Server/User/Port already exists.');
              erro := true;
            end;
     end;

end;


















procedure TFContas_New.CriticaPOP;
var
Teste : integer;
begin

erro := false;

  if trim(dbedit12.edittext) = '' then
     begin
       erro := true;
       showmessage('Account Name missing.');
       exit;
     end;

  if trim(dbedit1.edittext) = '' then
     begin
       erro := true;
       showmessage('POP3 Server missing.');
       exit;
     end;

  if trim(dbedit2.edittext) = '' then
     begin
       erro := true;
       showmessage('User name missing.');
       exit;
     end;

  if trim(dbedit3.edittext) = '' then
     begin
       erro := true;
       showmessage('Password missing.');
       exit;
     end;


  if trim(dbedit17.edittext) = '' then
     begin
       erro := true;
       showmessage('E-Mail missing.');
       exit;
     end;


  if not buscaRegexp(dm_server.EmailRegExp,trim(dbedit17.edittext),3) then
  begin
       erro := true;
       showmessage('Wrong E-Mail address.');
       exit;
  end;






  if trim(dbedit4.edittext) = '' then
     begin
       erro := true;
       showmessage('Port missing.');
       exit;
     end;


try
teste := strtoint(trim(dbedit4.edittext));
except
showmessage('Port accept only numbers.');
exit;
end;




  if dm_server.VeSeExisteNomeConta(trim(dbedit12.edittext)) then
     begin
        if dm_server.Cds_Contas.State = dsinsert then
            begin
              showmessage('This account already exists.');
              erro := true;
              exit;
            end;
     end;


  if dm_server.VeSeExisteUsuarioConta(trim(dbedit1.edittext),trim(dbedit2.edittext),strtoint(trim(dbedit4.edittext))) then
     begin
        if dm_server.Cds_Contas.State = dsinsert then
            begin
              showmessage('This Server/User/Port already exists.');
              erro := true;
            end;
     end;

end;




procedure TFContas_New.MontaPOP;
begin

with dm_server do
begin


if Cds_Contas.State = dsInsert then
   begin
   Cds_ContasPorta.AsInteger      := 110;
   Cds_ContasTipo.AsString        := 'POP3';
   Cds_ContasAutentica.AsInteger  := 0;
   Cds_ContasSSL.AsInteger        := 0;
   Cds_ContasLeBody.AsInteger     := 0;
   Cds_ContasAtivada.AsInteger    := 1;
   end;



end;
end;


procedure TFContas_New.POP3Status(ASender: TObject; const AStatus: TIdStatus;
  const AStatusText: string);
begin
memo1.Items.Add(AStatusText);
end;

procedure TFContas_New.SSL1Status(ASender: TObject; const AStatus: TIdStatus;
  const AStatusText: string);
begin
memo1.Items.Add(AStatusText);
end;

procedure TFContas_New.SSL1StatusInfo(Msg: string);
begin
memo1.Items.Add(Msg);
end;

procedure TFContas_New.MontaIMAP;
begin
with dm_server do
begin


if Cds_Contas.State = dsInsert then
   begin
   Cds_ContasPorta.AsInteger := 143;
   Cds_ContasTipo.AsString   := 'IMAP';
   Cds_ContasAutentica.AsInteger := 0;
   Cds_ContasSSL.AsInteger       := 0;
   Cds_ContasLeBody.AsInteger    := 0;
   Cds_ContasAtivada.AsInteger    := 1;
   end;



end;
end;


procedure TFContas_New.MontaHotMail;
begin

end;





procedure TFContas_New.Button1Click(Sender: TObject);
begin

if dm_server.TipoConta = 'POP3'    then  CriticaPOP;
if dm_server.TipoConta = 'IMAP'    then  CriticaIMAP;
if dm_server.TipoConta = 'Hotmail' then  CriticaHotmail;



if erro  then exit;

dm_server.Cds_Contas.Post;
//dm_server.Cds_Contas.ApplyUpdates(0);
//dm_server.Cds_Contas.Refresh;

close;




end;

procedure TFContas_New.Button2Click(Sender: TObject);
begin
dm_server.Cds_Contas.Cancel;
close;
end;

procedure TFContas_New.Button3Click(Sender: TObject);
begin

if Dialogs.MessageDlg('Delete this account? You can disable it. Are you sure to delete?',
  mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrNo then
  begin
    exit;
  end;

dm_server.Cds_Contas.Delete;
//dm_server.Cds_Contas.ApplyUpdates(0);
//dm_server.Cds_Contas.Refresh;

close;

end;

procedure TFContas_New.Button4Click(Sender: TObject);
var
Numero : Tguid;
Nume, ende : string;

begin

FContas_New.Height := 515;
memo1.items.Clear;


pop3.Host        := dbedit1.EditText;
pop3.Username    := dbedit2.EditText;
pop3.Port        := strtoint(dbedit4.EditText);
pop3.Password    := dbedit3.EditText;

  if dbcheckbox1.Checked then
     begin
     pop3.IOHandler := SSL1;
     pop3.UseTLS    := utUseImplicitTLS;
     SSL1.SSLOptions.Method := sslvTLSv1;
     end
     else
     begin
     SSL1.SSLOptions.Method := sslvTLSv1;
     pop3.UseTLS    := utNoTLSSupport;
     end;

pop3.ReadTimeout := 10000;

try
pop3.Connect;
except
showmessage('Connect failured');
FContas_New.Height := 385;
exit;
end;

memo1.Items.AddStrings(Pop3.Capabilities);

if memo1.Items.IndexOf('TOP') >= 0 then
   begin
     dbradiogroup2.ItemIndex := 0;
   end
   else
   begin
     showmessage('Your server do not support TOP command.');
     dbradiogroup2.ItemIndex := 1;
   end;

showmessage('Connection OK!');
pop3.Disconnect;
FContas_New.Height := 385;



CreateGuid(Numero);
dbedit19.edittext := GuidToString(Numero);

nume := GuidToString(Numero);
ende := trim(Dbedit17.EditText);

EnviaEmail(ende,nume);

Button1Click(self);






end;

procedure TFContas_New.Button5Click(Sender: TObject);
var
Numero : Tguid;
Begin


FContas_New.Height := 515;
memo1.items.Clear;

imap4.IOHandler := SSL1;
imap4.Host      := dbedit5.EditText;
imap4.Username  := dbedit6.EditText;
imap4.Password  := dbedit7.EditText;
SSL1.SSLOptions.Method := sslvSSLv2;

if dbcheckbox2.Checked then
begin
imap4.UseTLS    := utUseImplicitTLS;
end
else
begin
imap4.UseTLS    := utNoTLSSupport;
end;


try
imap4.Connect();
except

showmessage('Connection faiulired');
FContas_New.Height := 385;
exit;

end;

showmessage('Connection OK!');
imap4.Disconnect();

FContas_New.Height := 385;



CreateGuid(Numero);
dbedit20.edittext := GuidToString(Numero);
EnviaEmail(trim(Dbedit18.EditText),dbedit20.edittext);

Button1Click(self);








end;

procedure TFContas_New.DBCheckBox1Click(Sender: TObject);
begin

if dm_server.TipoConta = 'POP3' then
if DBCheckBox1.checked then dbedit4.EditText := '995' else  dbedit4.EditText := '110';


end;

procedure TFContas_New.DBCheckBox2Click(Sender: TObject);
begin


if dm_server.TipoConta = 'IMAP' then
if DBCheckBox2.checked then dbedit8.EditText := '993' else  dbedit8.EditText := '143';


end;

procedure TFContas_New.DBRadioGroup2Click(Sender: TObject);
begin


if DBRadioGroup2.ItemIndex = 1 then
   begin

  if Dialogs.MessageDlg('WARNING: This options is not recomended. If your Server was a GMAIL, YAHOO or another WEBMAIL the message after read will be DELETED from Server.  Are you sure?',
  mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrNo then
  begin
    DBRadioGroup2.ItemIndex := 0;

  end;
 end;





end;

procedure TFContas_New.FormShow(Sender: TObject);
begin


if dm_server.TipoConta = 'POP3' then
   begin
     Tabsheet1.TabVisible := true;
     Tabsheet2.TabVisible := false;
     Tabsheet3.TabVisible := false;
     MontaPOP;
   end;

if dm_server.TipoConta = 'IMAP' then
   begin
     Tabsheet1.TabVisible := false;
     Tabsheet2.TabVisible := true;
     Tabsheet3.TabVisible := false;
     MontaIMAP;
   end;

if dm_server.TipoConta = 'Hotmail' then
   begin
     Tabsheet1.TabVisible := false;
     Tabsheet2.TabVisible := false;
     Tabsheet3.TabVisible := true;
   end;

if dm_server.Cds_Contas.State = dsEdit then  Button3.Visible := true;

FContas_New.Update;

end;

procedure TFContas_New.IdLogEvent1Status(ASender: TComponent;
  const AText: string);
begin
memo1.Items.Add(Atext);
end;

end.

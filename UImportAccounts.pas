unit UImportAccounts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JvExStdCtrls, JvHtControls, JvButton, JvCtrls,
  JvProgressBar, JvXPProgressBar, JvBaseDlg, JvFindFiles, JvComponentBase,
  JvSearchFiles, ComCtrls, JvExComCtrls, JvStatusBar, ExtCtrls, {Grids, DBGrids,}
  DB, {JvDataSource, JvCsvData,} funcoes, ComObj;

type
  TFImportAccounts = class(TForm)
    GroupBox1: TGroupBox;
    JvImgBtn1: TJvImgBtn;
    JvSearchFiles1: TJvSearchFiles;
    Panel1: TPanel;
    JvHTListBox1: TJvHTListBox;
    JvImgBtn2: TJvImgBtn;
    procedure JvImgBtn1Click(Sender: TObject);
    procedure JvSearchFiles1Progress(Sender: TObject);
    procedure JvSearchFiles1BeginScanDir(Sender: TObject; const AName: string);
    procedure JvSearchFiles1FindFile(Sender: TObject; const AName: string);
    procedure JvImgBtn2Click(Sender: TObject);
  private
  procedure Importar;
  procedure GravarImport;
  Procedure GravaConta;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FImportAccounts: TFImportAccounts;
  arquivo : string;
  Ativa, Nome, UserID, Server, Email, Porta, Senha : AnsiString;
  Numero : Integer;
  erro : boolean;
  IND,NUM,Campo, Linha : AnsiString;
implementation

uses umain, udmserver;

{$R *.dfm}


procedure TFImportAccounts.GravaConta;
begin

With DM_Server do
begin


if cds_Contas.Locate('Nome',Nome,[loCaseInsensitive]) then exit;

cds_Contas.Append;
cds_ContasNome.AsString     := Nome;
cds_ContasAtivada.AsInteger := 0;
cds_ContasPOP.AsString      := Server;
cds_ContasTipo.asstring     := 'POP3';
cds_ContasUsuario.AsString  := UserID;
cds_ContasPorta.AsInteger   := strtoint(Porta);
cds_ContasEmail.AsString    := Email;


Fmain.MeusEmails.add(uppercase(cds_ContasEmail.asstring));
Fmain.MeusDominios.add(pegadominio(uppercase(cds_ContasEmail.asstring)));


cds_ContasSenha.AsString    := Senha;
cds_ContasSSL.AsInteger     := 0;
cds_Contas.Post;
//cds_Contas.ApplyUpdates(0);
//cds_Contas.Refresh;

end;



end;

Procedure TFImportAccounts.GravarImport;
Var
Conve : AnsiString;
I, achou, achou2   : Integer;
Begin

Num := '';
Ind := '';
Campo := '';
achou := pos(',',linha);

IND := copy(linha,1,achou-1);


for I := achou+1 to length(linha) do
  begin
    if linha[i] = ',' then
       begin
       achou2 := I;
       break;
       end
       else
       begin
       Num := Num+linha[i];
       end;
  end;

Campo := copy(linha,achou2+1,length(linha)-achou2);





  try
  Numero := strtoint(IND);
  except
  erro := True;
  exit;
  end;




  Conve :=  Campo;

  case Numero of
  0:begin  //Ativa
    If    Conve = 'T' then Ativa := '1' else ativa := '0';
    end;
  1:begin   //Nome
     Nome   := Conve;
    end;
  2:begin   //UserID
    UserID := Conve;
    end;

  4:begin   //Server
     Server := Conve;
    end;
  6:begin    //email
     Email := Conve;
    end;
  8:begin    //senha
     Senha := Decripta(Conve);
    end;
  12:begin    //porta
     Porta := Conve;
    GravaConta;
    end;

  end;



End;


procedure TFImportAccounts.Importar;
var
I : integer;
begin


  if Dialogs.MessageDlg('Import now.?',
    mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrNo then
  begin
    close;
    Exit;
  end;


  With DM_Server do
  begin
   cds_Contas.filtered := false;
   cds_Contas.first;
  end;



  for I := 27 to JvHTListBox1.Items.Count -1 do
  begin
   Linha := JvHTListBox1.Items[I];
   GravarImport;
  end;






end;

procedure TFImportAccounts.JvImgBtn1Click(Sender: TObject);
begin

Panel1.Visible := true;

Panel1.caption := 'Finding file EmCContas.ini in this computer...';
Panel1.repaint;

JvSearchFiles1.FileParams.FileMask:= 'EmCContas.ini' ;
JvSearchFiles1.Search;

if JvHTListBox1.Items.Count = 0 then
   begin
    Panel1.caption :='File EmCContas.ini doesnt exists in this computer';
    Panel1.repaint;
   end
   else
   begin
     Panel1.caption := 'Found file EmCContas.ini on: '+arquivo;
     Panel1.repaint;
     Importar;

     showmessage('Import done. Please, fill password fields accounts.');

     Close;
   end;
end;

procedure TFImportAccounts.JvImgBtn2Click(Sender: TObject);
var
 I : integer;
    Redemption,Recipient, Session, Acc, teste:OleVariant;
    ContactsFolder, OutlookSession, Accounts, Account,  Items,
    contact, contacts, contactsAB, mail : OLEVariant;
    AccountCount, contactCount: integer;


begin


try


OutlookSession := CreateOleObject('Redemption.RDOSession');
  OutlookSession.Logon('Outlook');
  Accounts  := OutlookSession.Accounts;
  AccountCount := Accounts.Count;

  if AccountCount = 0 then
  begin
  showmessage('Accounts not found');
  OutlookSession.logoff;
  exit;
  end;

  for i:=1 to AccountCount do begin
     Account:=Accounts.Item(i);
      if Account.AccountType = 0 then
        begin
        Server := (Account.POP3_Server);
        Porta  := (inttostr(Account.POP3_Port));
        UserID := (Account.POP3_UserName);
        Nome   := (Account.Name);
        Email  := (Account.SMTPAddress);
        Ativa  := '0';
        Senha  := '';
        GravaConta;
        end;
  end;


  OutlookSession.logoff;


showmessage('Accounts imported. Please supply the password to accounts and activate it.');

except

showmessage('Cannot access your OutLook...');

end;




end;

procedure TFImportAccounts.JvSearchFiles1BeginScanDir(Sender: TObject;
  const AName: string);
begin
Panel1.caption := AName;
Panel1.repaint;

end;

procedure TFImportAccounts.JvSearchFiles1FindFile(Sender: TObject;
  const AName: string);
begin
  JvSearchFiles1.Abort;
  JvHTListBox1.Items.LoadFromFile(AName);
  JvHTListBox1.Visible := true;
  Arquivo := Aname;

end;

procedure TFImportAccounts.JvSearchFiles1Progress(Sender: TObject);
begin
Application.ProcessMessages;

end;

end.

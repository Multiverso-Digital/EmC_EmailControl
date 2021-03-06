unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Outlook2000, StdCtrls, OleServer, JvComponentBase, JvAppStorage,
  JvAppRegistryStorage, ComCtrls, JvExComCtrls, JvRegistryTreeView, Access2000,
  Binder2000, MSPpt2000, CmAdmCtl, JvMail, OutlookXP;

type
  TForm1 = class(TForm)
    OutlookApplication1: TOutlookApplication;
    Button1: TButton;
    ListBox1: TListBox;
    JvAppRegistryStorage1: TJvAppRegistryStorage;
    Edit1: TEdit;
    Button2: TButton;
    Button3: TButton;
    JvMail1: TJvMail;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
    NmSpace: NameSpace;
    Folder: MAPIFolder;
    Appt: ContactItem;
    I : integer;
    Redemption,Recipient, Session, Acc, teste:OleVariant;
    ContactsFolder, OutlookSession, Accounts, Account,  Items,
    contact, contacts, contactsAB, mail : OLEVariant;
    AccountCount, contactCount: integer;

implementation

uses ComObj;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);


begin

  OutlookSession := CreateOleObject('Redemption.RDOSession');
  OutlookSession.Logon('Outlook');
  Accounts  := OutlookSession.Accounts;
  AccountCount := Accounts.Count;
  for i:=1 to AccountCount do begin
     Account:=Accounts.Item(i);
      if Account.AccountType = 0{atPOP3} then
        begin
        Listbox1.Items.add(Account.POP3_Server);
        Listbox1.Items.add(inttostr(Account.POP3_Port));
        Listbox1.Items.add(Account.POP3_UserName);
        Listbox1.Items.add(Account.Name);
        Listbox1.Items.add(Account.SMTPAddress);
        Listbox1.Items.add(' ');
        end;
  end;


  ContactsFolder := outlookSession.GetDefaultFolder(olFolderContacts);
  ContactCount := ContactsFolder.Items.count;
  for i:=1 to ContactCount do
  begin
     Contact:= ContactsFolder.Items.item(i);
     if pos('@',Contact.Email1Address) > 0 then
     ListBox1.items.add(Contact.Email1Address);
  end;

   ListBox1.items.add('****** Terminou Contatos OutLook *****');
   ListBox1.items.add(' ');


  ContactsAB := outlookSession.AddressBook.DefaultAddressList;
  ContactCount := ContactsAB.AddressEntries.Count;
  for i:=1 to ContactCount do
  begin
     Contact:= ContactsAB.AddressEntries.item(i);
     if pos('@',Contact.Address) > 0 then
     ListBox1.items.add(Contact.Address);
  end;





  OutlookSession.logoff;



   exit;




    OutlookApplication1.Connect;
    NmSpace := OutlookApplication1.GetNamespace('MAPI');
    NmSpace.Logon('', '', true, true);

    Folder := NmSpace.GetDefaultFolder(olFolderContacts);

   // Folder := NmSpace.GetDefaultFolder(olMailItem);





    appt := Folder.Items.GetFirst as ContactItem;
    for I:= 1 to Folder.Items.Count - 1 do
    begin
       if appt <> nil then
       begin
       appt := Folder.Items.Item(i) as ContactItem;
       listbox1.items.add(appt.FullName+' '+appt.Email1Address);
       listbox1.items.add(appt.FullName+' '+appt.Email2Address);
       listbox1.items.add(appt.FullName+' '+appt.Email3Address);
       end;
    end;


   OutlookApplication1.Disconnect;



   JvAppRegistryStorage1.ReadString('')


end;

procedure TForm1.Button2Click(Sender: TObject);
var
Numero : Tguid;
begin

CreateGuid(Numero);

edit1.Text := GuidToString(Numero);


end;




procedure TForm1.Button3Click(Sender: TObject);
begin

  OutlookSession := CreateOleObject('Redemption.RDOSession');
  OutlookSession.Logon('Outlook');




Mail := OutlookSession.GetDefaultFolder(olFolderOutbox).Items.Add('IPM.Note');
Mail.Recipients.Add('anita@abreuretto.com');
Mail.Subject := 'Teste ';
Mail.Body    := 'Ol? este o copr';
Mail.Send;



end;

procedure TForm1.Button4Click(Sender: TObject);
begin
JvMail1.SimpleMAPI.LoadClientLib;
showmessage(JvMail1.SimpleMAPI.CurrentClientName);
showmessage(JvMail1.SimpleMAPI.DefaultProfileName);
JvMail1.SimpleMAPI.UnloadClientLib;
end;

end.

unit UFavoritos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  StdCtrls, Buttons, ComCtrls, JvExControls, JvgShadow, Grids,
  {Wwdbigrd, Wwdbgrid, DBGrids,} JvExDBGrids, {JvDBGrid, JvDBUltimGrid,} Mask,
  DBCtrls, {JvDBDotNetControls,} JvExStdCtrls, JvEdit, JvDBSearchEdit,
  JvGridFilter, Wwkeycb, JvGradientCaption, ImgList, JvComponentBase,
  JvFormAnimatedIcon, JvFormTransparent, Menus, funcoes, {wwdbedit, Wwdotdot,
  Wwdbcomb, Registry, wwcheckbox,} db, JvExMask, JvToolEdit, JvMaskEdit,
  JvDBFindEdit, {CRGrid, {memdata,} dbclient, JvxCheckListBox, JvListBox,
  JvMail, OleServer, OutlookXP, JvSimpleXml, JvSearchFiles;

type
  TFFavoritos = class(TForm)
    GroupBox1: TGroupBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    JvGridFilter1: TJvGridFilter;
    GroupBox3: TGroupBox;
    EEmail: TEdit;
    GroupBox6: TGroupBox;
    Button4: TButton;
    Label2: TLabel;
    Button3: TButton;
    PopupMenu1: TPopupMenu;
    DeleteselectedEmail1: TMenuItem;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    GroupBox5: TGroupBox;
    Label3: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Edomain: TEdit;
    Button2: TButton;
    PopupMenu2: TPopupMenu;
    MenuItem1: TMenuItem;
    OpenDialog1: TOpenDialog;
    PB: TProgressBar;
    CBAdress: TRadioButton;
    CBTexto: TRadioButton;
    CBEmC: TRadioButton;
    OpenDialog2: TOpenDialog;
    PopupMenu3: TPopupMenu;
    ShowthisRule1: TMenuItem;
    Edit1: TEdit;
    Label1: TLabel;
    Label4: TLabel;
    Edit2: TEdit;
    LBFav_Email: TJvxCheckListBox;
    LBFav_Domain: TJvxCheckListBox;
    Label5: TLabel;
    Label6: TLabel;
    JvListBox1: TJvListBox;
    Label7: TLabel;
    CBOutLook: TRadioButton;
    CBGoogle: TRadioButton;
    OutlookApplication1: TOutlookApplication;
    JvMail1: TJvMail;
    CBVista: TRadioButton;
    JvSimpleXML1: TJvSimpleXML;
    JvSearchFiles1: TJvSearchFiles;
    JDir: TJvDirectoryEdit;
    Label8: TLabel;
    procedure PageControl1Change(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DeleteselectedEmail1Click(Sender: TObject);
    procedure Label9Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure LBFav_EmailStateChange(Sender: TObject; Index: Integer);
    procedure LBFav_DomainStateChange(Sender: TObject; Index: Integer);
    procedure JvListBox1DblClick(Sender: TObject);
    procedure CBVistaClick(Sender: TObject);
    procedure CBEmCClick(Sender: TObject);
    procedure JDirAfterDialog(Sender: TObject; var AName: string;
      var AAction: Boolean);
    procedure JvSearchFiles1FindFile(Sender: TObject; const AName: string);
  private





    procedure ImportaEmC;
    Procedure ImportaCatalogo;
    Procedure ImportaTexto;
    procedure ImportaOutLook;
    procedure ImportaGoogle;
    procedure ImportaVista;


    { Private declarations }
  public

   ListaBoxName, ListaVista : TstringList;
   ListaBoxID : TstringList;


    { Public declarations }
  end;



 Procedure ShowFavoritos;stdcall;external 'Favoritos.dll' name 'ShowFavoritos';



 var
  FFavoritos       : TFFavoritos;
  cds_mostraFG     : TclientDataset;
  vistadir         : string;
  Total : integer;

implementation

uses udmserver, UTestaExpression, UShowFilterFriends, umain, ComObj;

{$R *.dfm}



Procedure TFFavoritos.ImportaVista;
var
galho, galho1, galho2  : TJvSimpleXmlElem;
K,J, I: Integer;
begin


total := 0;


if Trim(Jdir.Text) = '' then
   begin
   showmessage('Windows Vista Contacts Folder missing.');
   exit;
   end;


ListaVista := TstringList.Create;

JvSearchFiles1.RootDirectory := vistadir;

JvSearchFiles1.Search;


if listaVista.Count = 0 then
   begin
   showmessage('Contacts files not found.');
   listavista.Free;
   exit;
   end;

PB.Visible := true;
PB.Max := ListaVista.Count;

for I:= 0 to ListaVista.Count - 1 do
begin


PB.Position := I+1;

JvSimpleXML1.LoadFromFile(ListaVista.Strings[i]);
galho :=  JvSimpleXML1.Root;
galho1 := galho.Items.ItemNamed['EmailAddressCollection'];
for j := 0 to galho1.items.Count - 1 do
begin
    galho2 := galho1.Items[j];
    for k := 0 to galho2.Items.Count - 1 do
      begin
      if galho2.Items[k].Name = 'Address' then
      dm_server.Incluir('FAVEMAIL', trim(galho2.Items[k].value));
      Total := total + 1;
      end;
end;
end;

listavista.Free;
PB.Position := 0;
PB.Visible := false;
showmessage('Vista Contacts Import done! '+inttostr(total)+' e-mails imported.' );


end;




Procedure TFFavoritos.ImportaGoogle;
begin


end;



Procedure TFFavoritos.ImportaOutLook;
var

    I : integer;
    ContactsFolder, OutlookSession, Accounts, Account,  Items,
    contact, contacts, contactsAB, mail : OLEVariant;
    contactCount: integer;
begin


total := 0;


  try
  OutlookSession := CreateOleObject('Redemption.RDOSession');
  OutlookSession.Logon('Outlook');
  ContactsFolder := outlookSession.GetDefaultFolder(olFolderContacts);
  ContactCount := ContactsFolder.Items.count;

  pb.Max :=  ContactCount;
  pb.Position := 0;


  for i:=1 to ContactCount do
  begin
     Contact:= ContactsFolder.Items.item(i);
     if pos('@',Contact.Email1Address) > 0 then
     begin
     pb.Position := I;

     dm_server.Incluir('FAVEMAIL', trim(Contact.Email1Address));
     total := total + 1;

     end;
  end;
  OutlookSession.logoff;
  pb.Position := 0;
  showmessage('OutLook Contacts Import done! '+inttostr(total)+' e-mails imported.' );

  except




  end;






end;




Procedure TFFavoritos.ImportaTexto;
var
ListaGeral : TstringList;
I : integer;
begin


Total := 0;


ListaGeral := TstringList.Create;

If Opendialog2.Execute then
begin

ListaGeral.LoadFromFile(OpenDialog2.filename);

pb.Visible := true;
pb.position := 0;
pb.Max := ListaGeral.count;

For I:= 0 to ListaGeral.count - 1 do
begin
application.ProcessMessages;
If trim(ListaGeral.Strings[i]) <> '' then
   begin
   If pos('@', ListaGeral.Strings[i]) > 0 then
   begin
   pb.position := I;


    dm_server.Incluir('FAVEMAIL', trim(ListaGeral.strings[i]));
    Total := Total + 1;


  // if Fmain.Fav_Email.IndexOf(trim(ListaGeral.strings[i])) = -1 then
  //    Fmain.Fav_Email.add(trim(ListaGeral.strings[i]));

   //dm_server.GravaBoxes(dm_server.quem,1,0,'0','From:',4,trim(ListaGeral.strings[i]),0,'My Friend E-mail');

   FFavoritos.Repaint;
   end;
   end;

end;

pb.position := 0;
pb.Visible := false;
ListaGeral.Free;

 showmessage('Text File Import done! '+inttostr(total)+' e-mails imported.' );




end;

end;


Procedure TFFavoritos.ImportaCatalogo;
var
ListaGeral : TstringList;
I : integer;
begin


Total := 0;


    ShowFavoritos;


    try

    if fileexists(dm_server.dire+'@EmCFavoritos.ini') then
       begin
       ListaGeral := TstringList.Create;
       FFavoritos.Repaint;
       ListaGeral.LoadFromFile(dm_server.dire+'@EmCFavoritos.ini');
       pb.Visible := true;
       pb.Max :=  ListaGeral.Count;

       for I:= 0 to ListaGeral.Count - 1 do
           begin
           application.ProcessMessages;
           pb.Position := I+1;
           FFavoritos.Repaint;
          dm_server.Incluir('FAVEMAIL', trim(ListaGeral.strings[i]));
          Total := Total + 1;
          end;
       pb.Position := 0;
       pb.Visible := false;
       end;

    except


    end;


  showmessage('Windows Address Book Import done! '+inttostr(total)+' e-mails imported.' );



end;



procedure TFFavoritos.ImportaEmC;
var
I      : Integer;
ListaF : TstringList;
begin

ListaF := TstringList.Create;


if dm_server.Quem = 1  then
   begin
    OpenDialog1.FileName := 'EmCFavoritos.ini';
    OpenDialog1.Filter   := 'My Friends|EmCFavoritos.ini';
   end;

if dm_server.Quem = 2  then
   begin
    OpenDialog1.FileName := 'EmCMinhaLst.ini';
    OpenDialog1.Filter   := 'BlackList|EmCMinhaLst.ini';
   end;




if OpenDialog1.Execute then
   begin

   ListaF.LoadFromFile(Opendialog1.FileName);

   PB.Visible := true;
   pb.Max := ListaF.Count;

   for I:= 0 to ListaF.Count - 1 do
       begin

       pb.Position := I+1;

       application.ProcessMessages;
       FFavoritos.Repaint;



       if dm_Server.Quem = 1 then
       begin
        if copy(ListaF.Strings[i],1,1) = 'A' then
           begin
              dm_server.GravaBoxes(1,1,-1,'OR','Subject:',2,copy(ListaF.Strings[i],4,length(ListaF.Strings[i])-3),0,'Subject old EmC version');
           end;
        if copy(ListaF.Strings[i],1,1) = 'E' then
           begin
             if copy(ListaF.Strings[i],4,5) = '*EmC*' then
               begin

                dm_server.Incluir('FAVDOMAIN', copy(ListaF.Strings[i],9,length(ListaF.Strings[i])-8));

               end
               else
               begin

               dm_server.Incluir('FAVEMAIL', copy(ListaF.Strings[i],4,length(ListaF.Strings[i])-3));


               end;
            end;
       end;


       if dm_Server.Quem = 2 then
       begin
             if copy(ListaF.Strings[i],1,5) = '*EmC*' then
               begin

               dm_server.Incluir('BLACKDOMAIN', copy(ListaF.Strings[i],6,length(ListaF.Strings[i])-5));


               end
               else
               begin

               dm_server.Incluir('BLACKEMAIL', copy(ListaF.Strings[i],1,length(ListaF.Strings[i])));



               end;

       end;








       end;


   end;

pb.Position := 0;
pb.Visible := false;
ListaF.Free;


end;



procedure TFFavoritos.Button2Click(Sender: TObject);
var
Monta : string;
Pega : integer;
begin

with dm_server do
begin


if quem = 1 then monta := 'My Friend Domain';
if quem = 2 then monta := 'BlackList Domain';
if quem = 3 then monta := 'Filter Domain';



if trim(Edomain.text) <> '' then
   begin

   if pos('@',Edomain.text) = 1 then
   begin


     if buscaRegexp(dm_server.VerDomain,Edomain.text,3) then
         begin


          if dm_server.Quem = 1  then
          begin
          if Incluir('FAVDOMAIN',(Edomain.text)) then
           begin
           showmessage('Domain '+(Edomain.text)+' added into the List');
           LBFav_Domain.Items.Assign(Fmain.Fav_Domain);
           end
           else
           begin
           showmessage('Domain '+(Edomain.text)+' already exist or is your Domain');
           end;



          end;

          if dm_server.Quem = 2  then
          begin
          Incluir('BLACKDOMAIN',(Edomain.text));
          showmessage('Domain '+(Edomain.text)+' added into the List');
          LBFav_Domain.Items.Assign(Fmain.Black_Domain);
          end;


           TemFiltroNovo := true;

         end
         else
         begin
           showmessage('Invalid Domain');
         end;

   end
   else
   begin
      showmessage('Invalid Domain');
   end;

end;


end;

end;


procedure TFFavoritos.Button3Click(Sender: TObject);

begin

if CBEmC.Checked then  ImportaEmC;
if CBTexto.checked then ImportaTexto;
if CBAdress.Checked  then ImportaCatalogo;
if CBOutLook.checked  then ImportaOutlook;
if CBVista.checked  then ImportaVista;



dm_server.TemFiltroNovo := true;



if dm_server.Quem = 1 then
begin
LBFav_Email.Items.Assign(fmain.Fav_Email);
LBFav_Domain.Items.Assign(fmain.Fav_Domain);
end;


if dm_server.Quem = 2 then
begin
LBFav_Email.Items.Assign(fmain.Black_Email);
LBFav_Domain.Items.Assign(fmain.Black_Domain);
end;




LBFav_EmailStateChange(self,0);
LBFav_DomainStateChange(self,0);


end;

procedure TFFavoritos.Button4Click(Sender: TObject);
var
Monta : string;
Pega : integer;
begin




with dm_server do
begin

if quem = 1  then monta := 'My Friend E-Mail';
if quem = 2  then monta := 'BlackList E-Mail';
if quem = 3  then monta := 'Filter E-Mail';



if trim(EEmail.text) <> '' then
   begin

     if buscaRegexp(dm_server.EmailRegExp,limpaemail(EEmail.text),3) then
          begin

          if dm_server.Quem = 1  then
          begin
          if Incluir('FAVEMAIL',limpaemail(EEmail.text)) then

           begin
           showmessage('E-mail '+limpaemail(EEmail.text)+' added into the List');
           LBFav_Email.Items.Assign(Fmain.Fav_Email);
           end
           else
           begin
           showmessage('E-mail '+limpaemail(EEmail.text)+' already exists or is your e-mail');
           end;

          end;

          if dm_server.Quem = 2  then
          begin
          Incluir('BLACKEMAIL',limpaemail(EEmail.text));
          showmessage('E-mail '+limpaemail(EEmail.text)+' added into the List');
          LBFav_Email.Items.Assign(Fmain.Black_Email);
          end;

          Pega := LBFav_Email.Items.IndexOf(limpaemail(EEmail.text));
          LBFav_Email.itemindex := pega;
          LBFav_EmailStateChange(self,0);
          TemFiltroNovo := true;

          end
          else
          begin
            showmessage('Invalid E-mail');
          end;
    end;



end;

end;

procedure TFFavoritos.CBEmCClick(Sender: TObject);
begin
label8.Visible := false;
JDir.Visible := false;
end;

procedure TFFavoritos.CBVistaClick(Sender: TObject);
begin
label8.Visible := true;
JDir.Visible := true;

end;

procedure TFFavoritos.DeleteselectedEmail1Click(Sender: TObject);
var
I, Fim: integer;
begin

//if dm_server.qmostraBoxes.RecordCount = 0 then exit;


 if Dialogs.MessageDlg('Are you sure?',
    mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrNo then
  begin
  exit;
  end;


for I:=0 to LBFav_Email.Items.Count - 1 do
begin
   if LBFav_Email.Checked[I] then
 begin

   if dm_Server.quem = 1 then
   dm_server.Excluir('FAVEMAIL',LBFav_Email.items[i]);

   if dm_Server.quem = 2 then
    dm_server.Excluir('BLACKEMAIL',LBFav_Email.items[i]);

 end;
end;

if dm_Server.quem = 1 then
LBFav_Email.items.Assign(Fmain.Fav_Email);

if dm_Server.quem = 2 then
LBFav_Email.items.Assign(Fmain.Black_Email);



LBFav_EmailStateChange(self,0);
dm_server.TemFiltroNovo := True;


end;

procedure TFFavoritos.Edit1KeyPress(Sender: TObject; var Key: Char);
begin

LBFav_Email.Perform(LB_SELECTSTRING,0,LongInt(PChar(Edit1.Text)));

end;

procedure TFFavoritos.Edit2KeyPress(Sender: TObject; var Key: Char);
begin


LBFav_Domain.Perform(LB_SELECTSTRING,0,LongInt(PChar(Edit2.Text)));




end;

procedure TFFavoritos.FormCloseQuery(Sender: TObject; var CanClose: Boolean);

begin
cds_MostraFG.active := false;
cds_MostraFG.Free;
ListaBoxName.free;
ListaBoxID.free;
end;

procedure TFFavoritos.FormShow(Sender: TObject);


begin


cds_MostraFG := TclientDataset.Create(nil);
cds_MostraFG.CloneCursor(dm_server.cds_boxes,false,false);

with cds_MostraFG.IndexDefs do
      begin
        Clear;
        with AddIndexDef do
          begin
            Name   := 'IndexMostra'; // Nome do Index
            Fields := 'TypeBox;NameRule;FilterID'; // Campo a ser odernado
            Options := [ixCaseInsensitive]; // tipo orderna??o.
          end;
      end;

cds_MostraFG.IndexName   := 'IndexMostra';
cds_MostraFG.filter      := 'Typebox = '+inttostr(dm_server.quem)+' and FilterID > 0 ';
cds_MostraFG.filtered    := true;
dm_server.ds_MostraFG.DataSet    :=  cds_MostraFG;


cds_MostraFG.active := true;
cds_MostraFG.first;

ListaBoxName := TstringList.Create;
ListaBoxID   := TstringList.Create;

while not  cds_MostraFG.eof do
begin

if (ListaBoxName.IndexOf(cds_MostraFG.FieldByName('NameRule').asstring) = -1) and
   (ListaBoxID.IndexOf(inttostr(cds_MostraFG.FieldByName('FilterID').asinteger)) = -1) then
   begin
    ListaBoxName.add(cds_MostraFG.FieldByName('NameRule').asstring);
    ListaBoxID.add(inttostr(cds_MostraFG.FieldByName('FilterID').asinteger));
   end;
cds_MostraFG.next;
end;


JvListBox1.items.Assign(ListaBoxName);




PageControl1.ActivePageIndex := 0;
PageControl1Change(self);



if dm_server.Quem = 1 then
   begin
    FFavoritos.caption :=   'mC-My Friends List';
    CBAdress.Visible := true;
    CBTexto.Visible  := true;
    CBEmC.Visible    := True;
    CBOutLook.Visible := true;
    CBVista.Visible    := true;
    CBGoogle.Visible    := true;

    FFavoritos.color := clMoneyGreen;
    LBfav_Email.Items.Assign(Fmain.Fav_Email);
    LBfav_Email.Color := clMoneyGreen;
    LBfav_Domain.Items.Assign(Fmain.Fav_Domain);
    LBfav_Domain.Color := clMoneyGreen;
    JvListBox1.Color := clMoneyGreen;
    Label7.caption := 'Name Rules Filter (My Friends) - Double click to access it.';
   end;


if dm_server.Quem = 2 then
   begin
    FFavoritos.caption :=   'mC-BlackList';
    CBAdress.Visible := False;
    CBTexto.Visible  := true;
    CBEmC.Visible    := True;
    CBOutLook.Visible := false;
    CBVista.Visible    := false;
    CBGoogle.Visible    := false;

    FFavoritos.color := $00CECEFF;
    LBfav_Email.Items.Assign(Fmain.Black_Email);
    LBFav_Email.Color := $00CECEFF;
    LBFav_Domain.Items.Assign(Fmain.Black_Domain);
    LBFav_Domain.Color := $00CECEFF;
    JvListBox1.Color :=  $00CECEFF;
    Label7.caption := 'Name Rules Filter (BlackList) - Double click to access it.';
   end;

if dm_server.Quem = 3 then
   begin
    FFavoritos.caption :=   'mC-Filters';
    CBAdress.Visible := False;
    CBTexto.Visible  := False;
    CBEmC.Visible    := False;
    FFavoritos.color := $00BFFFFF;
   end;


LBFav_DomainStateChange(self,0);
LBFav_EmailStateChange(self,0);


end;

procedure TFFavoritos.JDirAfterDialog(Sender: TObject; var AName: string;
  var AAction: Boolean);
begin
vistadir := AName;
end;

procedure TFFavoritos.JvListBox1DblClick(Sender: TObject);
begin
if JvListBox1.Items.count > 0 then
begin
dm_Server.MensID  :=  strtoint(ListaBoxID.strings[JvListBox1.itemindex]);//    cds_MostraFG.FieldByName('FilterID').AsInteger;
dm_Server.TipoFil := 1;
FShowFilterFriends := TFShowFilterFriends.create(self);
FShowFilterFriends.showmodal;
FShowFilterFriends.free;
end;

end;

procedure TFFavoritos.JvSearchFiles1FindFile(Sender: TObject;
  const AName: string);
begin


ListaVista.add(AName);




end;

procedure TFFavoritos.Label9Click(Sender: TObject);
begin
FtestaExpression := TFtestaExpression.create(self);
FtestaExpression.showmodal;
FtestaExpression.free;
end;

procedure TFFavoritos.LBFav_DomainStateChange(Sender: TObject; Index: Integer);
begin
Label6.Caption := inttostr(LBFav_Domain.Items.Count);
end;

procedure TFFavoritos.LBFav_EmailStateChange(Sender: TObject; Index: Integer);
begin
Label5.Caption := inttostr(LBFav_Email.Items.Count);
end;

procedure TFFavoritos.MenuItem1Click(Sender: TObject);
var
I, Fim : integer;
begin

 // if dm_server.qmostraBoxes.RecordCount = 0 then exit;


 if Dialogs.MessageDlg('Are you sure?',
    mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrNo then
  begin
  exit;
  end;


for I:=0 to LBFav_Domain.Items.Count - 1 do
begin
   if LBFav_Domain.Checked[I] then
 begin

   if dm_Server.quem = 1 then
    dm_server.Excluir('FAVDOMAIN',LBFav_Domain.items[i]);

   if dm_Server.quem = 2 then
    dm_server.Excluir('BLACKDOMAIN',LBFav_Domain.items[i]);

 end;
end;

if dm_Server.quem = 1 then
LBFav_Domain.items.Assign(Fmain.Fav_Domain);

if dm_Server.quem = 2 then
LBFav_Domain.items.Assign(Fmain.Black_Domain);


LBFav_DomainStateChange(self,0);
dm_server.TemFiltroNovo := True;



end;






procedure TFFavoritos.PageControl1Change(Sender: TObject);
begin

{
if PageControl1.ActivePageIndex = 0 then
dm_server.MostraBoxes(dm_server.quem,1,0,4);

if PageControl1.ActivePageIndex = 1 then
dm_server.MostraBoxes(dm_server.quem,1,0,5);
 }
{
if (PageControl1.ActivePageIndex = 2) and  (dm_server.Quem = 1) then
dm_server.MostraBoxes(dm_server.quem,1,0,5);

if (PageControl1.ActivePageIndex = 2) and  (dm_server.Quem = 2) then
dm_server.MostraBoxes(dm_server.quem,2,0,5);
 }


end;

end.

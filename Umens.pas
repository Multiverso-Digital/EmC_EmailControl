unit Umens;

interface

//Regras para Spam
//1.Tem que existir o FROM
//2.O From tem que conter um email v?lido

//^abreu@abreuretto.com$ (email)
// .*@abreuretto.com$ (dominio)

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvComponentBase, JvEmbeddedForms, Grids, Wwdbigrd, Wwdbgrid, ImgList,
  JvExControls, {JvSpecialProgress,} ComCtrls, ToolWin, JvExComCtrls, {JvToolBar,}
  JvStatusBar, wwDialog, wwrcdvw, JvComCtrls, Buttons, StdCtrls, wwriched,
  wwidlg, Wwlocate, Wwintl, wwfltdlg, wwcheckbox, DB, {Menus, JvMenus,}
  {PlatformDefaultStyleActnCtrls,} ActnPopup, DBClient, {RibbonLunaStyleActnCtrls,} funcoes,
  {IdBaseComponent, IdComponent, IdTCPConnection, IdDNSResolver,} JvProgressBar,
  JvLED, UDM_Baysean, urefiltrar, Menus, PlatformDefaultStyleActnCtrls,
  JvSpecialProgress;

type
  TFmens = class(TForm)
    SB: TJvStatusBar;
    ilGFX16: TImageList;
    JvEmbeddedFormLink1: TJvEmbeddedFormLink;
    PopupActionBar1: TPopupActionBar;
    este1: TMenuItem;
    wwDBGrid1: TwwDBGrid;
    AddEmailtoMyFriendsList1: TMenuItem;
    AddSelectedDomaintoMyFriendsList1: TMenuItem;
    N1: TMenuItem;
    hisSelectedMessageisMyFriend1: TMenuItem;
    N2: TMenuItem;
    AddSelectedEmailtoBlackList1: TMenuItem;
    AddSelectedEmailtotheBlackList1: TMenuItem;
    UsethismessagestoAddRulesto1: TMenuItem;
    N4: TMenuItem;
    Showwhymessagewasfiltered1: TMenuItem;
    N5: TMenuItem;
    SelectAllmessagesexceptMyFriends1: TMenuItem;
    UnselectAllmessages1: TMenuItem;
    ShowMessageBody1: TMenuItem;
    ShowHeader1: TMenuItem;
    RestoreSelectedsbyFilters1: TMenuItem;
    JvLED1: TJvLED;
    JvSpecialProgress1: TJvSpecialProgress;
    RemovethisEmailFromBlackList1: TMenuItem;
    N6: TMenuItem;
    RemovethisEmailDomainFromMyFriendsList: TMenuItem;
    procedure wwDBGrid1CalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure wwDBGrid2CalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure wwDBGrid3CalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure wwDBGrid4CalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure wwDBGrid6CalcCellColors(Sender: TObject; Field: TField;
      State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
    procedure wwDBGrid1TitleButtonClick(Sender: TObject; AFieldName: string);
    procedure wwDBGrid1CalcTitleAttributes(Sender: TObject; AFieldName: string;
      AFont: TFont; ABrush: TBrush; var ATitleAlignment: TAlignment);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton25Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton26Click(Sender: TObject);
    procedure este1Click(Sender: TObject);
    procedure Showwhymessagewasfiltered1Click(Sender: TObject);
    procedure AddEmailtoMyFriendsList1Click(Sender: TObject);
    procedure AddSelectedDomaintoMyFriendsList1Click(Sender: TObject);
    procedure SelectAllmessagesexceptMyFriends1Click(Sender: TObject);
    procedure UnselectAllmessages1Click(Sender: TObject);
    procedure AddSelectedEmailtoBlackList1Click(Sender: TObject);
    procedure AddSelectedEmailtotheBlackList1Click(Sender: TObject);
    procedure RestoreSelectedsbyFilters1Click(Sender: TObject);
    procedure UsethismessagestoAddRulesto1Click(Sender: TObject);
    procedure ShowMessageBody1Click(Sender: TObject);
    procedure ShowHeader1Click(Sender: TObject);
    procedure SBDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
      const Rect: TRect);
    procedure hisSelectedMessageisMyFriend1Click(Sender: TObject);
    procedure hisSelectedMessageisSPAM1Click(Sender: TObject);
    procedure LearALLCREAMcolorFilteredselectedmessageswithBADeemail1Click(
      Sender: TObject);
    procedure ALLGREENcolorFilteredselectedmessagesisFRIENDtolearn1Click(
      Sender: TObject);
    procedure PopupActionBar1Popup(Sender: TObject);
    procedure RemovethisEmailDomainFromMyFriendsListClick(Sender: TObject);
    procedure RemovethisEmailFromBlackList1Click(Sender: TObject);
    procedure wwDBGrid1DblClick(Sender: TObject);
    procedure wwDBGrid1CreateHintWindow(Sender: TObject;
      HintWindow: TwwGridHintWindow; AField: TField; R: TRect;
      var WordWrap: Boolean; var MaxWidth, MaxHeight: Integer;
      var DoDefault: Boolean);
  private
 // procedure DoSorting(cdsName:TClientDataset; AFieldName: String);


  //TypeBox(1=Friends, 2=BlackList, 3=Filter)
  //WhereFilter(1=Header, 2=Body)
  //FilterID(ID da mensagem ou Zero)
  //MatchType(AND ou OR)
  //Item(Tag do header)
  //Kind(1=Exists, 2=Contais,3=Regex)
  //Expression(Texto para comparar)
  //Status(0=ativo, 1=Excluido)
  

    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fmens: TFmens;
  mudou : boolean;


implementation

uses  udmserver, Umain, UShowFilterFriends, UShowWhyFilter, UBody;

{$R *.dfm}




procedure TFmens.ShowHeader1Click(Sender: TObject);
begin
  screen.Cursor := crDefault;

  if dm_server.EstounoMenu = 6 then
  begin
  dm_server.BodyDB := 2;
  dm_server.BodyID := dm_server.Cds_ALLMID1.AsVariant;// AslargeInt;
  end
  else
  begin
  dm_server.BodyID := dm_server.Cds_MensID.AsVariant;// AslargeInt;
  dm_server.BodyDB := 1;
  end;


  dm_server.BodyHeader := 1;
  Fbody := TFbody.create(self);
  FBody.showmodal;
  Fbody.free;



end;

procedure TFmens.ShowMessageBody1Click(Sender: TObject);
var
row : integer;
begin

screen.Cursor := crSqlWait;

if dm_server.EstounoMenu = 6 then
begin

   dm_server.BodyDB := 2;

   if (dm_server.cds_AllMlida.AsInteger = 1)  then
       begin
         if buscaRegexp('<(object|script)',dm_server.Cds_ALLMCorpoTexto.Asstring,3) then
         begin
            if Dialogs.MessageDlg('EmC-WARNING: Message Body have unsafe scripts or objects. Are you sure to open it?',
            mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrNo then
            begin
            exit;
            end;
         end;

           dm_server.BodyHeader := 0;
           dm_server.BOdyID := dm_server.Cds_ALLMID1.AsInteger;
           Fbody := TFbody.create(self);
           FBody.showmodal;
           Fbody.free;
           screen.Cursor := crDefault;
           exit;
       end
       else
       begin
         screen.Cursor := crDefault;
         showmessage('Sorry. The body of this message was not read');
         exit;
       end;
end;








if (dm_server.cds_menslida.AsInteger = 0) then
begin

 If Fmain.LeoCorpo(dm_server.Cds_MensUID.AsString, dm_server.Cds_MensID_Conta.asinteger) then
 begin
  screen.Cursor := crDefault;
  dm_server.BodyDB := 1;
  dm_server.BodyHeader := 0;
  dm_server.BOdyID := dm_server.Cds_MensID.AsInteger;
  if buscaRegexp('<(object|script)',dm_server.Cds_MensCorpoTexto.Asstring,3) then
     begin
        if Dialogs.MessageDlg('EmC-WARNING: Message Body have unsafe scripts or objects. Are you sure to open it?',
         mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrNo then
          begin
          exit;
          end;
     end;
  Fbody := TFbody.create(self);
  FBody.showmodal;
  Fbody.free;
 end;
 screen.Cursor := crDefault;
end
else
begin
  screen.Cursor := crDefault;
  dm_server.BodyDB := 1;
  dm_server.BodyHeader := 0;
  dm_server.BOdyID := dm_server.Cds_MensID.AsInteger;

   if buscaRegexp('<(object|script)',dm_server.Cds_MensCorpoTexto.Asstring,3) then
     begin
        if Dialogs.MessageDlg('EmC-WARNING: Message Body have unsafe scripts or objects. Are you sure to open it?',
         mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrNo then
          begin
          exit;
          end;
     end;

  Fbody := TFbody.create(self);
  FBody.showmodal;
  Fbody.free;
  screen.Cursor := crDefault;

end;


end;

procedure TFmens.Showwhymessagewasfiltered1Click(Sender: TObject);
begin
FShowWhyFilter := TFShowWhyFilter.create(self);
FShowWhyFilter.showmodal;
FShowWhyFilter.free;
end;

procedure TFmens.AddEmailtoMyFriendsList1Click(Sender: TObject);
begin

with dm_server do
begin


 if trim(Cds_MensEmailFrom.asstring) <> '' then
   begin

    if  cds_mensListaNegra.AsInteger = 1 then
        begin
          if Dialogs.MessageDlg('E-mail '+Cds_MensEmailFrom.asstring+' found in BlackList. You try to put this E-Mail in the MyFriend List.  If you agree EmC will remove the E-mail from BlackList and put it in the MyFriend List. Proceed now?',
            mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
                  begin
                       Excluir('BLACKEMAIL',Cds_MensEmailFrom.asstring);



                       if Incluir('FAVEMAIL',Cds_MensEmailFrom.asstring) then
                       begin

                       showmessage('E-mail '+limpaemail(Cds_MensEmailFrom.asstring)+' added into My Friend List');
                       cds_Mens.Edit;
                       cds_mensSelecionada.AsInteger  := 0;
                       cds_mensFiltrada.AsInteger     := 144;
                       cds_mensFavoritos.AsInteger    := 1;
                       cds_mensListaNegra.AsInteger   := 0;
                       cds_mensFiltroResult.AsString := 'E-mail added to My FriendList '+limpaemail(Cds_MensEmailFrom.asstring);
                       cds_mens.Post;
                       marcaEmail(Cds_MensEmailFrom.asstring,1);
                       end
                       else
                       begin
                       showmessage('E-mail '+limpaemail(Cds_MensEmailFrom.asstring)+' already exists or is your e-mail.');
                       end;

                  end;

        end
        else
        begin

                      if Incluir('FAVEMAIL',Cds_MensEmailFrom.asstring) then
                      begin
                       showmessage('E-mail '+limpaemail(Cds_MensEmailFrom.asstring)+' added into My Friend List');
                       cds_Mens.Edit;
                       cds_mensSelecionada.AsInteger  := 0;
                       cds_mensFiltrada.AsInteger     := 144;
                       cds_mensFavoritos.AsInteger    := 1;
                       cds_mensListaNegra.AsInteger   := 0;
                       cds_mensFiltroResult.AsString := 'E-mail added to My FriendList '+limpaemail(Cds_MensEmailFrom.asstring);
                       cds_mens.Post;
                       marcaEmail(Cds_MensEmailFrom.asstring,1);
                      end
                      else
                      begin
                      showmessage('E-mail '+limpaemail(Cds_MensEmailFrom.asstring)+' already exists or is your e-mail.');
                      end;
        end;

   end;

end;


end;

procedure TFmens.AddSelectedDomaintoMyFriendsList1Click(Sender: TObject);
begin

with dm_server do
begin


 if trim(Cds_MensDominioFrom.asstring) <> '' then
   begin

    if  cds_mensListaNegra.AsInteger = 1 then
        begin
          if Dialogs.MessageDlg('Domain '+Cds_MensDominioFrom.asstring+' found in BlackList. You try to put this Domain in the MyFriend List.  If you agree EmC will remove the Domain from BlackList and put it in the MyFriend List. Proceed now?',
            mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
                  begin
                       Excluir('BLACKDOMAIN',Cds_MensDominioFrom.asstring);

                       if Incluir('FAVDOMAIN',Cds_MensDominioFrom.asstring) then
                       begin
                       showmessage('Domain '+Cds_MensDominioFrom.asstring+' added into My Friend List');
                       cds_Mens.Edit;
                       cds_mensSelecionada.AsInteger  := 0;
                       cds_mensFiltrada.AsInteger     := 144;
                       cds_mensFavoritos.AsInteger    := 1;
                       cds_mensListaNegra.AsInteger   := 0;
                       cds_mensFiltroResult.AsString := 'Domain added to My FriendList '+Cds_MensDominioFrom.asstring;
                       cds_mens.Post;
                       marcaDomain(Cds_MensDominioFrom.asstring,1);

                       end
                       else
                       begin
                       showmessage('Domain '+Cds_MensDominioFrom.asstring+' already exists or is your Domain.');
                       end;

                  end;

        end
        else
        begin

                       if Incluir('FAVDOMAIN',Cds_MensDominioFrom.asstring) then
                       begin
                       showmessage('Domain '+Cds_MensDominioFrom.asstring+' added into My Friend List');
                       cds_Mens.Edit;
                       cds_mensSelecionada.AsInteger  := 0;
                       cds_mensFiltrada.AsInteger     := 144;
                       cds_mensFavoritos.AsInteger    := 1;
                       cds_mensListaNegra.AsInteger   := 0;
                       cds_mensFiltroResult.AsString := 'Domain added to My FriendList '+Cds_MensDominioFrom.asstring;
                       cds_mens.Post;
                       marcaDomain(Cds_MensDominioFrom.asstring,1);
                       end
                       else
                       begin
                       showmessage('Domain '+Cds_MensDominioFrom.asstring+' already exists or is your Domain.');
                       end;
        end;

   end;
end;


end;

procedure TFmens.AddSelectedEmailtoBlackList1Click(Sender: TObject);
begin

with dm_server do
begin


 if trim(Cds_MensEmailFrom.asstring) <> '' then
   begin

    if  cds_mensFavoritos.AsInteger = 1 then
        begin
          if Dialogs.MessageDlg('E-mail '+Cds_MensEmailFrom.asstring+' found in MyFriends List. You try to put this E-Mail in the BlackList.  If you agree EmC will remove the E-mail from MyFriends List and put it in the BlackList. Proceed now?',
            mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
                  begin
                       Excluir('FAVEMAIL',Cds_MensEmailFrom.asstring);
                       Incluir('BLACKEMAIL',Cds_MensEmailFrom.asstring);
                       showmessage('E-mail '+limpaemail(Cds_MensEmailFrom.asstring)+' added into BlackList');
                       cds_Mens.Edit;
                       cds_mensSelecionada.AsInteger  := 1;
                       cds_mensFiltrada.AsInteger     := 5;
                       cds_mensFavoritos.AsInteger    := 0;
                       cds_mensListaNegra.AsInteger   := 1;
                       cds_mensFiltroResult.AsString := 'E-mail added into BlackList '+limpaemail(Cds_MensEmailFrom.asstring);
                       cds_mens.Post;
                       marcaEmail(Cds_MensEmailFrom.asstring,2);
                  end;

        end
        else
        begin
                       Incluir('BLACKEMAIL',Cds_MensEmailFrom.asstring);
                       showmessage('E-mail '+limpaemail(Cds_MensEmailFrom.asstring)+' added into BlackList');
                       cds_Mens.Edit;
                       cds_mensSelecionada.AsInteger  := 1;
                       cds_mensFiltrada.AsInteger     := 5;
                       cds_mensFavoritos.AsInteger    := 0;
                       cds_mensListaNegra.AsInteger   := 1;
                       cds_mensFiltroResult.AsString := 'E-mail added into BlackList '+limpaemail(Cds_MensEmailFrom.asstring);
                       cds_mens.Post;
                       marcaEmail(Cds_MensEmailFrom.asstring,2);
        end;

   end;

end;





end;

procedure TFmens.AddSelectedEmailtotheBlackList1Click(Sender: TObject);
begin


with dm_server do
begin


 if trim(Cds_MensDominioFrom.asstring) <> '' then
   begin

    if  cds_mensFavoritos.AsInteger = 1 then
        begin
          if Dialogs.MessageDlg('Domain '+Cds_MensDominioFrom.asstring+' found in MyFriend List. You try to put this Domain in the BlackList.  If you agree EmC will remove the Domain from MyFriends List and put it in the BlackList. Proceed now?',
            mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
                  begin
                       Excluir('FAVDOMAIN',Cds_MensDominioFrom.asstring);
                       Incluir('BLCKDOMAIN',Cds_MensDominioFrom.asstring);
                       showmessage('Domain '+Cds_MensDominioFrom.asstring+' added into BlackList');
                       cds_Mens.Edit;
                       cds_mensSelecionada.AsInteger  := 1;
                       cds_mensFiltrada.AsInteger     := 5;
                       cds_mensFavoritos.AsInteger    := 0;
                       cds_mensListaNegra.AsInteger   := 1;
                       cds_mensFiltroResult.AsString := 'Domain added to BlackList '+Cds_MensDominioFrom.asstring;
                       cds_mens.Post;
                       marcaDomain(Cds_MensDominioFrom.asstring,2);
                  end;

        end
        else
        begin
                       Incluir('BLCKDOMAIN',Cds_MensDominioFrom.asstring);
                       showmessage('Domain '+Cds_MensDominioFrom.asstring+' added into BlackList');
                       cds_Mens.Edit;
                       cds_mensSelecionada.AsInteger  := 1;
                       cds_mensFiltrada.AsInteger     := 5;
                       cds_mensFavoritos.AsInteger    := 0;
                       cds_mensListaNegra.AsInteger   := 1;
                       cds_mensFiltroResult.AsString := 'Domain added to BlackList '+Cds_MensDominioFrom.asstring;
                       cds_mens.Post;
                       marcaDomain(Cds_MensDominioFrom.asstring,2);
        end;

   end;
end;

end;


procedure TFmens.ALLGREENcolorFilteredselectedmessagesisFRIENDtolearn1Click(
  Sender: TObject);
begin

{
 Fmain.parar := false;
 Fmain.MontaLearnGOOD;
 }
end;

procedure TFmens.este1Click(Sender: TObject);
begin

if dm_Server.Cds_Mens.RecordCount > 0 then
begin
dm_Server.MensID := dm_Server.Cds_MensID.AsInteger;
dm_Server.TipoFil := 0;
dm_Server.quem := 1;
FShowFilterFriends := TFShowFilterFriends.create(self);
FShowFilterFriends.showmodal;
FShowFilterFriends.free;

if dm_server.TemFiltroNovo then
   begin
   Refiltrar;
   dm_server.TemFiltroNovo := False;
   end;


end;


end;




procedure TFmens.hisSelectedMessageisMyFriend1Click(Sender: TObject);
begin
fmain.PoeStatusBar('Total: '+inttostr(dm_server.cds_Mens.recordcount)+' message(s)','Learn selected message by Baysean.Wait!','','');
DM_Baysean.Aprenderbayesian(DM_server.cds_menspalavrasBaysean.asstring,2);
fmain.PoeStatusBar('Total: '+inttostr(dm_server.cds_Mens.recordcount)+' message(s)','Ok. Done.!','','');
showmessage('Ok. This e-mail was selected with GOOD!');

end;

procedure TFmens.hisSelectedMessageisSPAM1Click(Sender: TObject);
begin

{
fmain.PoeStatusBar('Total: '+inttostr(dm_server.cds_Mens.recordcount)+' message(s)','Learn selected message by Baysean.Wait!','','');
DM_Baysean.Aprenderbayesian(DM_server.cds_menspalavrasBaysean.asstring,1);
fmain.PoeStatusBar('Total: '+inttostr(dm_server.cds_Mens.recordcount)+' message(s)','Ok. Done.!','','');
showmessage('Ok. This e-mail was selected with BAD!');
 }

end;

procedure TFmens.LearALLCREAMcolorFilteredselectedmessageswithBADeemail1Click(
  Sender: TObject);
begin

{
Fmain.parar := false;
Fmain.MontaLearnBAD;
}

end;

procedure TFmens.PopupActionBar1Popup(Sender: TObject);
var
I : integer;
begin


if dm_server.EstounoMenu <> 6 then
begin

if  dm_server.cds_mens.RecordCount = 0 then
    begin
      for I := 0 to PopupActionBar1.Items.Count - 1 do
         begin
          PopupActionBar1.Items[i].Enabled := false;
          end;

    end
    else
    begin
      for I := 0 to PopupActionBar1.Items.Count - 1 do
         begin
          PopupActionBar1.Items[i].Enabled := true;
          end;

    end;



if dm_server.cds_mensListaNegra.AsInteger = 1 then
   begin
   RemovethisEmailFromBlackList1.Visible := true;
   end
   else
   begin
   RemovethisEmailFromBlackList1.Visible := false;
   end;

if dm_server.cds_mensFavoritos.AsInteger = 1 then
   begin
   RemovethisEmailDomainFromMyFriendsList.Visible := true;
   end
   else
   begin
   RemovethisEmailDomainFromMyFriendsList.Visible := false;
   end;

end
else
begin




if  dm_server.cds_ALLM.RecordCount = 0 then
    begin
      for I := 0 to PopupActionBar1.Items.Count - 1 do
         begin
          PopupActionBar1.Items[i].Enabled := false;
          end;

    end
    else
    begin
      for I := 0 to 2 do
         begin
          PopupActionBar1.Items[i].Enabled := true;
          end;
      for I := 3 to PopupActionBar1.Items.Count - 1 do
         begin
          PopupActionBar1.Items[i].Enabled := false;
          end;


    end;

end;




end;

procedure TFmens.ToolButton1Click(Sender: TObject);
begin

{
Toolbar1.HotTrackColor := clWhite;
Toolbar1.Update;
Toolbar1.Repaint;
}




end;

procedure TFmens.ToolButton25Click(Sender: TObject);
begin

{
Toolbar1.HotTrackColor := $00CECEFF;
Toolbar1.Update;
Toolbar1.Repaint;
 }
  
end;

procedure TFmens.ToolButton26Click(Sender: TObject);
begin

{
Toolbar1.HotTrackColor := $00CECEFF;
Toolbar1.Update;
Toolbar1.Repaint;
 }

  
end;

procedure TFmens.ToolButton2Click(Sender: TObject);
begin
{
Toolbar1.HotTrackColor := clMoneyGreen;
Toolbar1.Update;
Toolbar1.Repaint;
 }

 

end;

procedure TFmens.ToolButton3Click(Sender: TObject);
begin

{
Toolbar1.HotTrackColor := $00BFFFFF;
Toolbar1.Update;
Toolbar1.Repaint;
 }

end;

procedure TFmens.ToolButton4Click(Sender: TObject);
begin

{
Toolbar1.HotTrackColor := clWhite;
Toolbar1.Update;
Toolbar1.Repaint;
 }
  
end;

procedure TFmens.UnselectAllmessages1Click(Sender: TObject);
begin
dm_server.PoeMarca(0,0);
end;


procedure TFmens.UsethismessagestoAddRulesto1Click(Sender: TObject);
begin
  if dm_Server.Cds_Mens.RecordCount > 0 then
begin
dm_Server.MensID := dm_Server.Cds_MensID.AsInteger;
dm_Server.TipoFil := 0;
dm_Server.quem := 2;
FShowFilterFriends := TFShowFilterFriends.create(self);
FShowFilterFriends.showmodal;
FShowFilterFriends.free;


if dm_server.TemFiltroNovo then
   begin
   Refiltrar;
   dm_server.TemFiltroNovo := False;
   end;

end;

end;

procedure TFmens.SBDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel;
  const Rect: TRect);
begin
if panel.Index = 4 then
   begin
     JvSpecialProgress1.Width := Panel.Width;
   end;
end;

procedure TFmens.SelectAllmessagesexceptMyFriends1Click(Sender: TObject);
begin
dm_server.PoeMarca(1,0);
end;

procedure TFmens.RemovethisEmailDomainFromMyFriendsListClick(Sender: TObject);
begin

with dm_server do
begin


  if Dialogs.MessageDlg('EmC will remove this E-mail '+Cds_MensEmailFrom.asstring+' from MyFirends List. Are you sure?',
  mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
  begin
     Excluir('FAVEMAIL',Cds_MensEmailFrom.asstring);
     showmessage('E-mail '+limpaemail(Cds_MensEmailFrom.asstring)+' removed from My Friend List');
     cds_Mens.Edit;
     cds_mensSelecionada.AsInteger  := 0;
     cds_mensFiltrada.AsInteger     := 35;
     cds_mensFavoritos.AsInteger    := 0;
     cds_mensListaNegra.AsInteger   := 0;
     cds_mensFiltroResult.AsString := 'E-mail removed from My FriendList '+limpaemail(Cds_MensEmailFrom.asstring);
     cds_mens.Post;

     MarcaRemoveEmail(Cds_MensEmailFrom.asstring,1);

  end;






end;




end;

procedure TFmens.RemovethisEmailFromBlackList1Click(Sender: TObject);
begin

with dm_server do
begin
  if Dialogs.MessageDlg('EmC will remove this E-mail '+Cds_MensEmailFrom.asstring+' from BlackList. Are you sure?',
  mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
  begin
     Excluir('BLACKEMAIL',Cds_MensEmailFrom.asstring);
     showmessage('E-mail '+limpaemail(Cds_MensEmailFrom.asstring)+' removed from BlackList');
     cds_Mens.Edit;
     cds_mensSelecionada.AsInteger  := 0;
     cds_mensFiltrada.AsInteger     := 35;
     cds_mensFavoritos.AsInteger    := 0;
     cds_mensListaNegra.AsInteger   := 0;
     cds_mensFiltroResult.AsString := 'E-mail removed from BlackList '+limpaemail(Cds_MensEmailFrom.asstring);
     cds_mens.Post;
     MarcaRemoveEmail(Cds_MensEmailFrom.asstring,2);
  end;
end;



end;

procedure TFmens.RestoreSelectedsbyFilters1Click(Sender: TObject);
begin
dm_server.PoeMarca(0,0);
dm_server.PoeMarca(1,1);
end;




procedure TFmens.wwDBGrid1CalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin




if Field.FieldName = 'Assunto' then
   begin

   if dm_server.EstounoMenu <> 6 then

     begin
     if dm_server.Cds_MensLida.asinteger = 0 then
        begin
        afont.Style := [fsBold];
        end
        else
        begin
        afont.Style := [];
        end;

     end
     else
     begin

     if dm_server.Cds_ALLMLida.asinteger = 0 then
        begin
        afont.Style := [fsBold];
        end
        else
        begin
        afont.Style := [];
        end;

     end;


   end;




if dm_server.Cds_Mensexcluida.AsInteger = 1 then
 begin
 ABrush.Color :=   $00F3E5D5;
 afont.Color := clBlack;
 end;

if (dm_server.Cds_MensFiltrada.AsInteger = 145) or  (dm_server.Cds_MensFiltrada.AsInteger = 147) then
 begin
 ABrush.Color := $00BFFFFF;
 afont.Color := clBlack;
 end;

if dm_server.Cds_MensFavoritos.AsInteger = 1  then
begin
ABrush.Color := clMoneygreen;
afont.Color := clBlack;
end;

if dm_server.Cds_MensListaNegra.AsInteger = 1  then
begin
ABrush.Color := $00CECEFF;
afont.Color := clBlack;
end;


if (dm_server.Cds_MensSelecionada.AsInteger = 1) and
   (dm_server.Cds_MensListaNegra.AsInteger = 0) and
   (dm_server.Cds_MensFiltrada.AsInteger = -1) then
 begin
 ABrush.Color := $00BFFFFF;
 afont.Color := clBlack;
 end;





if {(not Fmain.POP.Connected) and} (Highlight) then
   begin
      Afont.Color := clWhite;
      ABrush.Color := clGray;
   end;



if dm_server.DS_qMens.DataSet = dm_server.cds_ALLM then
   begin
   ABrush.Color :=   $00F3E5D5;
   afont.Color := clBlack;

      if (Highlight) then
       begin
      Afont.Color := clWhite;
      ABrush.Color := clGray;
      end;


   end;














end;

procedure TFmens.wwDBGrid1CalcTitleAttributes(Sender: TObject;
  AFieldName: string; AFont: TFont; ABrush: TBrush;
  var ATitleAlignment: TAlignment);
begin

if AFieldName = 'Tama' then
   begin
      ATitleAlignment := taRightJustify;
   end;

if AFieldName = 'NumeroMens' then
   begin
      ATitleAlignment := taRightJustify;
   end;



end;

procedure TFmens.wwDBGrid1CreateHintWindow(Sender: TObject;
  HintWindow: TwwGridHintWindow; AField: TField; R: TRect;
  var WordWrap: Boolean; var MaxWidth, MaxHeight: Integer;
  var DoDefault: Boolean);
begin




     //wwDBGrid1.Hint := dm_server.cds_mensFiltroResult.AsString;
     WordWrap := True;
    // MaxWidth := 200;
     MaxHeight := Screen.Height;




end;

procedure TFmens.wwDBGrid1DblClick(Sender: TObject);
begin

if dm_server.EstounoMenu <> 6 then
ShowMessageBody1Click(self);
end;

procedure TFmens.wwDBGrid1TitleButtonClick(Sender: TObject; AFieldName: string);
begin

if AfieldName = 'NumeroMens' then
begin
dm_server.Cds_Mens.IndexFieldNames := 'ID_Conta;ID';
dm_server.Cds_Mens.First;
end
else
begin
dm_server.Cds_Mens.IndexFieldNames := AFieldName;
dm_server.Cds_Mens.First;
end;


end;

procedure TFmens.wwDBGrid2CalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
ABrush.Color := clMoneygreen;
Afont.Color  := clBlack;
end;

procedure TFmens.wwDBGrid3CalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
ABrush.Color := $00BFFFFF;
Afont.Color  := clBlack;
end;

procedure TFmens.wwDBGrid4CalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
ABrush.Color := $00CECEFF;
Afont.Color  := clBlack;
end;

procedure TFmens.wwDBGrid6CalcCellColors(Sender: TObject; Field: TField;
  State: TGridDrawState; Highlight: Boolean; AFont: TFont; ABrush: TBrush);
begin
ABrush.Color := $00CECEFF;
Afont.Color  := clBlack;
end;

end.

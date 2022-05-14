unit Uimap_teste;

interface

{uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
  IdSSLOpenSSL, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdMessageClient, IdIMAP4, IdMessage, IdMailBox,
  IdPOP3, funcoes,  IdCoderHeader;}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Ribbon, RibbonLunaStyleActnCtrls, ToolWin, ActnMan, ActnCtrls,
  ImgList, ScreenTips, StdActns, ExtActns, ActnList, ActnMenus, RibbonActnMenus,
  StdCtrls, RibbonActnCtrls, JvExControls, JvEmbeddedForms, IdMessage,
  IdBaseComponent, IdComponent, IdTCPConnection,IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient, IdPOP3,
  IdMessageCoderMIME, IdMessageCoder, IdMessageCoderYenc, IdThreadComponent, DB,
  MemDS, DBAccess, MyAccess, funcoes, IdAntiFreezeBase, IdAntiFreeze, ExtCtrls,
  Menus, JvComponentBase, JvTrayIcon, JvBalloonHint, IdText,IdAttachment, IdHTTP, memdata,
  JvComCtrls, StrUtils, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
  IdSSLOpenSSL, IdDNSResolver, IdDateTimeStamp, Ubayesian, IdCoder, IdCoder3to4, IdCoderMIME,
  IdCoderBinHex4, IdCoderHeader, IdIMAP4, idMailBox, JvInspector, IdWebDAV;


type
 TCodeMatrix = array[1..255] of char;



type
  TForm1 = class(TForm)
    IdIMAP41: TIdIMAP4;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    Button1: TButton;
    IdMailBox1: TIdMailBox;
    MSG: TIdMessage;
    Memo1: TMemo;
    Edit1: TEdit;
    Edit2: TEdit;
    Button2: TButton;
    Button3: TButton;
    Edit3: TEdit;
    Edit4: TEdit;
    Button4: TButton;
    Memo2: TMemo;
    Button5: TButton;
    Edit5: TEdit;
    Edit6: TEdit;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    Edit7: TEdit;
    IdPOP31: TIdPOP3;
    Button9: TButton;
    IdWebDAV1: TIdWebDAV;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
  private

function ConvertCharset(AString: String; AMatrix: string): String;

    { Private declarations }
  public
    { Public declarations }
  end;




const
 FirstCodes : string =
   #1#2#3#4#5#6#7#8#9#10#11#12#13#14#15#16#17#18#19#20#21#22#23#24#25#26#27#28+
  #29#30#31' !"#$%&''()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^' +
   '_`abcdefghijklmnopqrstuvwxyz{|}~';
 cmAnsiToKoi8R: string = 'ЂЃ‚ѓ„…†‡€‰Љ‹ЊЌЋЏђ‘’“”•–—?™љ›њќћџ ЎўЈ¤Ґ¦§Ё©Є«¬­®Ї°±Ііґµ¶·Ј—є»јЅѕїбвчздецъй'
   + 'клмнопртуфхжигюыэящшьасБВЧЗДЕЦЪЙКЛМНОПРТУФХЖИГЮЫЭЯЩШЬАС';
 cmAnsiToKoi8U: string = 'ЂЃ‚ѓ„…†‡€‰Љ‹ЊЌЋЏђ‘’“”•–—?™љ›њќћџ ЎўЈ¤Ґ¦§Ё©Є«¬­®Ї°±Ііґµ¶·Ј—є»јЅѕїбвчздецъй'
   + 'клмнопртуфхжигюыэящшьасБВЧЗДЕЦЪЙКЛМНОПРТУФХЖИГЮЫЭЯЩШЬАС';
 cmKoi8RToAnsi: string = '-¦-¬L-++T++---¦¦---?¦•v??? ?°?·?=¦-ёгг¬¬¬LLL---¦¦¦¦Ё¦¦TTT¦¦¦+++©юабцдефгх'
   + 'ийклмнопярстужвьызшэщчъЮАБЦДЕФГХИЙКЛМНОПЯРСТУЖВЬЫЗШЭЩЧЪ';
 cmKoi8UToAnsi: string = '-¦-¬L-++T++---¦¦---?¦•v??? ?°?·?=¦-ёєгії¬LLL-ґў¦¦¦¦ЁЄ¦ІЇT¦¦¦+ҐЎ©юабцдефгх'
   + 'ийклмнопярстужвьызшэщчъЮАБЦДЕФГХИЙКЛМНОПЯРСТУЖВЬЫЗШЭЩЧЪ';
 cmOemDosToAnsi: string = 'АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдежзийклмноп---¦+¦¦¬¬¦¦¬---¬L+T+-+¦¦L'
   + 'г¦T¦=+¦¦TTLL-г++----¦¦-рстуфхцчшщъыьэюяЁёЄєЇїЎў°•·v№¤¦ ';
 cmIsoToAnsi: string = '???????????????????????????????? ЁЂЃЄЅІЇЈЉЊЋЌ­ЎЏАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШ'
   + 'ЩЪЫЬЭЮЯабвгдежзийклмнопрстуфхцчшщъыьэюя№ёђѓєѕіїјљњћќ§ўџ';


var
  Form1: TForm1;

implementation

{$R *.dfm}



function TForm1.ConvertCharset(AString: String; AMatrix: string): String;
var
 i    : Integer;
 cara : integer;
begin
 Result := '';
 for i:= 1 to Length(AString) do
   begin
   cara := ord(FirstCodes[Ord(AString[i])]);
   Result := Result + AMatrix[cara];
   end;
end;


procedure TForm1.Button1Click(Sender: TObject);
var
I : integer;
num : integer;
UID : string;


begin



memo1.Lines.Clear;

try

IdIMAP41.Connect  ;

except
showmessage('Pau');
end;


//JvInspector1.InspectObject := IdIMAP41;


IdIMAP41.Capability(memo2.Lines);



if IdIMAP41.SelectMailBox('inbox') then
begin



IdIMAP41.RetrieveAllHeaders(IdIMAP41.MailBox.MessageList);



for I:=0 to  IdIMAP41.MailBox.MessageList.Count - 1 do
begin


 msg := IdIMAP41.MailBox.MessageList.Messages[i];
 num := I + 1;
 IdIMAP41.GetUID(num,uid);

 memo1.lines.add(uid+' '+msg.Subject);
end;

end;


IdIMAP41.Disconnect();


end;

procedure TForm1.Button2Click(Sender: TObject);
var
//Testa : TIdHeaderCoderKOI8;
valor : string;
begin

//Testa := TIdHeaderCoderKOI8.Create;


valor := ansitoutf8(edit1.text);



edit2.Text := ConvertCharset(edit1.text,cmAnsiToKoi8U);



//Testa.Free;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
I : integer;
monta : string;
begin



end;

procedure TForm1.Button4Click(Sender: TObject);
var
resu, I : integer;
//Mime, mime2  : TmimeChar;
begin


//mime  := GetCPFromID(edit3.text);
//mime2 := GetCPFromID('iso-8859-1');

//memo2.Lines.Text := CharsetConversion(memo1.Lines.Text,mime2,mime);






//memo2.lines.Text := ConveCharHexa(memo1.lines.Text,cmKoi8UToAnsi);



//resu :=  HexToDec(edit3.text);

//edit4.Text := inttostr(resu);

end;

procedure TForm1.Button5Click(Sender: TObject);
begin





if pos(#32,edit5.Text) > 0 then showmessage('TEM 32 '+ inttostr(pos(#32,edit5.Text)));
if pos(#13,edit5.Text) > 0 then showmessage('TEM 13 '+ inttostr(pos(#13,edit5.Text)));
if pos(#10,edit5.Text) > 0 then showmessage('TEM 10 '+ inttostr(pos(#10,edit5.Text)));
if pos(#9,edit5.Text) > 0 then showmessage('TEM 9 '+ inttostr(pos(#9,edit5.Text)));
//showmessage(inttostr(length(edit5.text)));
edit6.Text := decodeheader(edit5.Text);
//memo2.Lines.Text :=  decodeheader(memo1.Lines.text);




end;

procedure TForm1.Button6Click(Sender: TObject);
var
  i,num:Integer;
  uid:String;
  uids:TStringList;
begin
  uids := TStringList.Create;
  memo1.Lines.Clear;
  memo2.Lines.Clear;
  try
    IdIMAP41.Connect;
  except
    showmessage('Pau');
  end;

  if IdIMAP41.SelectMailBox('inbox') then
  begin


  //memo2.Lines.Add(inttostr(idImap41.MailBox.TotalMsgs));

  for i := 1 to idImap41.MailBox.TotalMsgs do
    begin
      idImap41.GetUID(i,UID);
      memo1.Lines.Add(UID);
    end;

  end;

  IdIMAP41.Disconnect;
end;

procedure TForm1.Button7Click(Sender: TObject);
var
  i:Integer;
  UID, teste:String;
begin
  try
    IdIMAP41.Connect;
  except
    showmessage('Pau');
  end;

  if IdIMAP41.SelectMailBox('inbox') then
  begin


  //memo2.Lines.Add(inttostr(idImap41.MailBox.TotalMsgs));

  for i := 1 to idImap41.MailBox.TotalMsgs do
    begin
      idImap41.GetUID(i,UID);

      if memo1.Lines.IndexOf(UID) < 0 then
      begin

        IdImap41.UIDRetrieveTextPeek(UID,teste);
        IdImap41.UIDRetrieveTextPeek2(UID,teste);
        showmessage('Olha');


        IdImap41.RetrievePeek(i,MSG);

        memo2.Lines.Add(UID);
        memo2.Lines.Add(MSG.From.Address);
        memo2.Lines.Add(inttostr(msg.MessageParts.Count));
      end;
    end;

  end;
  IdIMAP41.Disconnect;
end;


procedure TForm1.Button8Click(Sender: TObject);
begin

try
    IdIMAP41.Connect;
  except
    showmessage('Pau');
  end;

  if IdIMAP41.SelectMailBox('inbox') then
  begin


    idImap41.UIDDeleteMsg(edit7.Text);




  end;
  IdIMAP41.Disconnect;
end;

procedure TForm1.Button9Click(Sender: TObject);
begin

idpop31.Connect;

memo2.Lines := idPop31.Capabilities;


idpop31.Disconnect;



end;

end.

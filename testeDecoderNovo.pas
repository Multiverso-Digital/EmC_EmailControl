unit testeDecoderNovo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Ribbon, RibbonLunaStyleActnCtrls, ToolWin, ActnMan, ActnCtrls,
  ImgList, ScreenTips, StdActns, ExtActns, ActnList, ActnMenus, RibbonActnMenus,
  StdCtrls, RibbonActnCtrls, JvExControls, JvEmbeddedForms, IdMessage,
  IdBaseComponent, IdComponent, IdTCPConnection,IdTCPClient, IdExplicitTLSClientServerBase, IdMessageClient, IdPOP3,
  IdMessageCoderMIME, IdMessageCoder, IdMessageCoderYenc, IdThreadComponent, DB,
  MemDS, DBAccess, MyAccess, IdAntiFreezeBase, IdAntiFreeze, ExtCtrls,
  Menus, JvComponentBase, JvTrayIcon, JvBalloonHint, IdText,IdAttachment, IdHTTP, memdata,
  JvComCtrls, StrUtils, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL,
  IdSSLOpenSSL, IdDNSResolver, IdDateTimeStamp, IdCoder, IdCoder3to4, IdCoderMIME,
  IdCoderBinHex4, IdCoderHeader, IdIMAP4, idMailBox, Grids, Wwdbigrd, Wwdbgrid;

type
 TCodeMatrix = array[1..255] of char;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    MSG: TIdMessage;
    IdIMAP41: TIdIMAP4;
    IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL;
    IdMailBox1: TIdMailBox;
    Edit5: TEdit;
    Edit6: TEdit;
    MyConnection1: TMyConnection;
    MyQuery1: TMyQuery;
    Button2: TButton;
    wwDBGrid1: TwwDBGrid;
    DataSource1: TDataSource;
    MyQuery1id: TIntegerField;
    MyQuery1valor: TWideStringField;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
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

procedure TForm1.Button1Click(Sender: TObject);
begin
  edit2.Text := DecodeHeader(edit1.Text);

  edit6.Text := DecodeHeader(edit5.text);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  teste : WideString;
begin
  Button1Click(self);
  MyQuery1.Append;
  teste := edit2.Text;
  MyQuery1valor.asstring := edit2.text;
  MyQuery1.Post;
  MyQuery1.ApplyUpdates;
  MyQuery1.Refresh;
end;


procedure TForm1.FormShow(Sender: TObject);
begin
  myquery1.open;
end;

end.

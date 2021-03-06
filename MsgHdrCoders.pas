unit MsgHdrCoders;

interface

uses
 IdHeaderCoderPlain;

type
 TCodeMatrix = array[1..255] of char;

const
 FirstCodes =
   #1#2#3#4#5#6#7#8#9#10#11#12#13#14#15#16#17#18#19#20#21#22#23#24#25#26#27#28+
  #29#30#31' !"#$%&''()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^' +
   '_`abcdefghijklmnopqrstuvwxyz{|}~';

 cp1251 : TcodeMatrix = FirstCodes + 'ЂЃ‚ѓ„…†‡€‰Љ‹ЊЌЋЏђ‘’“”•–—�™љ›њќћџ ЎўЈ¤Ґ¦§'+
 'Ё©Є«¬­®Ї°±Ііґµ¶·ё№є»јЅѕїАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдежзийклмнопрстуф'+
 'хцчшщъыьэюя';



 cmAnsiToKoi8R: TCodeMatrix = FirstCodes
 + 'ЂЃ‚ѓ„…†‡€‰Љ‹ЊЌЋЏђ‘’“”•–—?™љ›њќћџ ЎўЈ¤Ґ¦§Ё©Є«¬­®Ї°±Ііґµ¶·Ј—є»јЅѕїбвчздецъй'
   + 'клмнопртуфхжигюыэящшьасБВЧЗДЕЦЪЙКЛМНОПРТУФХЖИГЮЫЭЯЩШЬАС';


 cmKoi8RToAnsi: TCodeMatrix = FirstCodes
 + '-¦-¬L-++T++---¦¦---?¦•v??? ?°?·?=¦-ёгг¬¬¬LLL---¦¦¦¦Ё¦¦TTT¦¦¦+++©юабцдефгх'
   + 'ийклмнопярстужвьызшэщчъЮАБЦДЕФГХИЙКЛМНОПЯРСТУЖВЬЫЗШЭЩЧЪ';

 cmAnsiToKoi8U: TCodeMatrix = FirstCodes
 + 'ЂЃ‚ѓ„…†‡€‰Љ‹ЊЌЋЏђ‘’“”•–—?™љ›њќћџ ЎўЈ¤Ґ¦§Ё©Є«¬­®Ї°±Ііґµ¶·Ј—є»јЅѕїбвчздецъй'
   + 'клмнопртуфхжигюыэящшьасБВЧЗДЕЦЪЙКЛМНОПРТУФХЖИГЮЫЭЯЩШЬАС';
 cmKoi8UToAnsi: TCodeMatrix = FirstCodes
 + '-¦-¬L-++T++---¦¦---?¦•v??? ?°?·?=¦-ёєгії¬LLL-ґў¦¦¦¦ЁЄ¦ІЇT¦¦¦+ҐЎ©юабцдефгх'
   + 'ийклмнопярстужвьызшэщчъЮАБЦДЕФГХИЙКЛМНОПЯРСТУЖВЬЫЗШЭЩЧЪ';
 cmOemDosToAnsi: TCodeMatrix = FirstCodes
 + 'АБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдежзийклмноп---¦+¦¦¬¬¦¦¬---¬L+T+-+¦¦L'
   + 'г¦T¦=+¦¦TTLL-г++----¦¦-рстуфхцчшщъыьэюяЁёЄєЇїЎў°•·v№¤¦ ';
 cmIsoToAnsi: TCodeMatrix = FirstCodes
 + '???????????????????????????????? ЁЂЃЄЅІЇЈЉЊЋЌ­ЎЏАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШ'
   + 'ЩЪЫЬЭЮЯабвгдежзийклмнопрстуфхцчшщъыьэюя№ёђѓєѕіїјљњћќ§ўџ';
type

 TIdHeaderCoderKOI8 = class(TIdHeaderCoderPlain)
 public
   class function Decode(const ACharSet, AData: String): String; override;
   class function Encode(const ACharSet, AData: String): String; override;
   class function CanHandle(const ACharSet: String): Boolean; override;
 end;

function ConvertCharset(AString: String; AMatrix: TCodeMatrix): String;

implementation

uses IdGlobal, IdHeaderCoderBase;

function ConvertCharset(AString: String; AMatrix: TCodeMatrix): String;
var
 i: Integer;
begin
 Result := '';
 for i:= 1 to Length(AString) do
   Result := Result + AMatrix[Ord(AString[i])];
end;

{ TIdHeaderCoderKOI8 }

class function TIdHeaderCoderKOI8.CanHandle(const ACharSet: String): Boolean;
begin
 Result := TextIsSame(ACharSet, 'KOI8-R') or TextIsSame(ACharSet, 'KOI8-U') or
 TextIsSame(ACharSet, 'WINDOWS-1251');
end;

class function TIdHeaderCoderKOI8.Decode(const ACharSet, AData: String): String;
begin
 if TextIsSame(ACharSet, 'KOI8-R') then
   Result := ConvertCharset(AData, cmKoi8RToAnsi)
 else if TextIsSame(ACharSet, 'KOI8-U') then
   Result := ConvertCharset(AData, cmKoi8UToAnsi)
 else if TextIsSame(ACharSet, 'WINDOWS-1251') then
   Result := ConvertCharset(AData, cp1251);
end;

class function TIdHeaderCoderKOI8.Encode(const ACharSet, AData: String): String;
begin
 if TextIsSame(ACharSet, 'KOI8-R') then
   Result := ConvertCharset(AData, cmAnsiToKoi8R)
 else if TextIsSame(ACharSet, 'KOI8-U') then
   Result := ConvertCharset(AData, cmAnsiToKoi8U);

end;

initialization
 RegisterHeaderCoder(TIdHeaderCoderKOI8);
finalization
 UnregisterHeaderCoder(TIdHeaderCoderKOI8);
end.



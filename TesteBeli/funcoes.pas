unit Funcoes;

interface

uses Windows, Forms, Messages, SysUtils, Classes, StrUtils, Math, DCPcrypt,
     Cast128, base64, PerlRegEx, Registry, WinInet;


function CaixaMista (mNome: string): string;
Function Poezero(num:integer):string;
function TestaCgc(xCGC: String):Boolean;
function Tiraponto(S:string):String;
function CheckCPF(cpf: string): boolean;
function SiglaUF(S:string):boolean;
function VerificaEmail(s:string):Boolean;
function CheckMod11(num: integer): integer;
function TiraAcentos(Str:string):String;
function MascaraTelefone(S:string):String;
function EncryptSTR(const InString:string; StartKey,MultKey,AddKey:Integer): string;
function DecryptSTR(const InString:string; StartKey,MultKey,AddKey:Integer): string;
function colocaPontoCPF(S:String):String;
function geraSenha(Qtd_Letra1:integer; Qtd_Numero:integer; Qtd_Letra2:Integer):String;
function acertaemail(email:string):TstringList;
function limpaemail(email:string):string;
function Decripta(S1:AnsiString):AnsiString;
function buscaRegexp(oque,aonde:string;forma:Integer):boolean;
function ExtrairRegexp(oque,aonde:string):String;
function MontaItensCabec(Cab:string):string;
function PegaItensCabec(Item, cabec:String):String;
function pegaDominio(Email:string):String;
function VeSeTemWildcard(S:string):Boolean;
function GetRegistryData(RootKey: HKEY; Key, Value: string): variant;
Function PegaValorXml(S:String;Tagini:String;TagFim:String):string;
Function PegaValorSite(S:String;Tagini:String;Tipo:Integer):string;


var
 crip : TDCP_cast128;

implementation








Function PegaValorSite(S:String;Tagini:String;Tipo:Integer):string;
var
achouini, achoufim, I, comeca : integer;
monta : string;
begin


Result := '';
monta := '';

achouini := pos(tagini,S);

if achouini < 1  then exit;


if tipo = 1 then
   begin
     result := copy(S,achouini+16,2);
     exit;
   end;



for I:= achouini to  length(s) do
begin
  if s[i] = '>' then
  begin
  comeca := I;
  Break;
  end;
end;

I := comeca+1;
while s[i] <> '<' do
begin
  monta := monta + s[i];
  i:=I+1;
end;

Result := monta;

end;









Function PegaValorXml(S:String;Tagini:String;TagFim:String):string;
var
achouini, achoufim, I, comeca : integer;
monta : string;
begin


Result := '';
monta := '';

achouini := pos(tagini,S);
achouFim := pos(tagFim,S);

if achouini < 1  then exit;

for I:= achouini to  length(s) do
begin
  if s[i] = '>' then
  begin
  comeca := I;
  Break;
  end;
end;

I := comeca+1;
while s[i] <> '<' do
begin
  monta := monta + s[i];
  i:=I+1;
end;

Result := monta;

end;



function GetRegistryData(RootKey: HKEY; Key, Value: string): variant;
var
  Reg: TRegistry;
  RegDataType: TRegDataType;
  DataSize, Len: integer;
  s: string;
label cantread;
begin
  Reg := nil;
  try
    Reg := TRegistry.Create(KEY_QUERY_VALUE);
    Reg.RootKey := RootKey;
    if Reg.OpenKeyReadOnly(Key) then begin
      try
        RegDataType := Reg.GetDataType(Value);
        if (RegDataType = rdString) or
           (RegDataType = rdExpandString) then
          Result := Reg.ReadString(Value)
        else if RegDataType = rdInteger then
          Result := Reg.ReadInteger(Value)
        else if RegDataType = rdBinary then begin
          DataSize := Reg.GetDataSize(Value);
          if DataSize = -1 then goto cantread;
          SetLength(s, DataSize);
          Len := Reg.ReadBinaryData(Value, PChar(s)^, DataSize);
          if Len <> DataSize then goto cantread;
          Result := s;
        end else
cantread:
          raise Exception.Create(SysErrorMessage(ERROR_CANTREAD));
      except
        s := ''; // Deallocates memory if allocated
        Reg.CloseKey;
        raise;
      end;
      Reg.CloseKey;
    end else
      raise Exception.Create(SysErrorMessage(GetLastError));
  except
    Reg.Free;
    raise;
  end;
  Reg.Free;
end;



{$R-} {$Q-}
function EncryptSTR(const InString:string; StartKey,MultKey,AddKey:Integer): string;
var I : Byte;
begin
  Result := '';
  for I := 1 to Length(InString) do
  begin
    Result := Result + CHAR(Byte(InString[I]) xor (StartKey shr 8));
    StartKey := (Byte(Result[I]) + StartKey) * MultKey + AddKey;
  end;
end;

function DecryptSTR(const InString:string; StartKey,MultKey,AddKey:Integer): string;
var I : Byte;
begin
  Result := '';
  for I := 1 to Length(InString) do
  begin
    Result := Result + CHAR(Byte(InString[I]) xor (StartKey shr 8));
    StartKey := (Byte(InString[I]) + StartKey) * MultKey + AddKey;
  end;
end;
{$R+} {$Q+}


function VeSeTemWildcard(S:string):Boolean;
begin
Result := false;
  if pos('*',S) > 0 then Result := true;
  if pos('?',S) > 0 then Result := true;
  if pos('+',S) > 0 then Result := true;
end;



function pegaDominio(Email:string):String;
var
achou : integer;
begin

achou := pos('@',email);
if achou > 0 then
begin
result := copy(email,achou,length(email)-(achou-1));
end
else
begin
result := '';
end;


end;




function PegaItensCabec(Item, cabec:String):String;
var
I, J, achou : integer;
Lista    : TstringList;
Monta    : string;
begin

Lista      := TstringList.Create;
Lista.Text := Cabec;
Monta := '';

for I:= 0 to Lista.Count - 1 do
  begin

    achou := pos(Item,Lista.Strings[i]);
    if achou > 0 then
       begin
         Monta := Monta + Lista.Strings[i];
         J := I+1;
         if J <= Lista.Count-1 then
         begin
         while copy(Lista.Strings[J],1,1) = ' ' do
            begin
            Monta := Monta + Lista.Strings[J];
            J := J+1;
            end;
         end;
       end;

  end;



Result := monta;
Lista.Free;



end;



function MontaItensCabec(Cab:string):string;
var
I , achou     : Integer;
Lista, Cabec  : TstringList;
Testa         : AnsiChar;
Monta         : Ansistring;
begin

Cabec := TstringList.Create;
Cabec.Text := Cab;
Lista := TstringList.Create;
Lista.Sorted := true;

for I:= 0 to Cabec.Count - 1 do
begin

monta := Trim(cabec.Strings[i]);
if Length(monta) > 0 then
begin

testa := monta[1];
if Testa in ['A'..'Z'] then
begin
achou := pos(':',cabec.Strings[i]);

  if achou > 0  then
     begin
       if Lista.IndexOf(copy(cabec.Strings[i],1,achou)) = -1 then
       Lista.Add(copy(cabec.Strings[i],1,achou));
     end;
end;
end;
end;

Result := Lista.Text;

Lista.Free;
Cabec.Free;


end;



function limpaemail(email:string):string;
var
I : integer;
monta : string;
begin

monta := '';

For I:=1 to length(email) do
begin

if email[i] <> ' ' then
   begin
   monta := monta + email[i];
   end;

result := monta;

end;

end;



function acertaemail(email:string):TstringList;
var
monta, montax : string;
I: integer;
tudo, tudoerrado   : string;

work : TstringList;

const
permitido: string=('@-_.');

begin


work := TstringList.create;

monta  := tiraacentos(trim(email))+' ';
montax := '';
tudo   := '';
tudoerrado := '';


For I:=1 to length(monta) do
begin

if (monta[i] in ['A'..'Z']) or
   (monta[i] in ['a'..'z']) or
   (monta[i] in ['0'..'9']) or
   (pos(monta[i],permitido) > 0) then
   begin
   montax := montax + monta[i];
   end
   else
   begin
   if (verificaemail(montax)) then
         begin
         tudo := tudo+montax+';';
         end
         else
         begin
          if (montax<>'') then
          begin
           tudoerrado := tudoerrado+montax+';';
          end;
         end;
   montax := '';
   end;

end;



work.add(tudo);
work.add(tudoerrado);

result := work;


end;






function geraSenha(Qtd_Letra1:integer; Qtd_Numero:integer; Qtd_Letra2:Integer):String;
CONST
Alfa : array[1..21] of string =('A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'J', 'K', 'M', 'N', 'P', 'Q' ,'R' ,'S' ,'T', 'U', 'V' ,'X' ,'Z');

var senha:String;
I:Integer;
begin
  Randomize;
  Senha := '';
  if Qtd_Letra1>0 then
  begin
    for I:=0 to Qtd_Letra1-1 do
    begin
      senha:=senha+RandomFrom(Alfa);
    end;
  end;
  if Qtd_Numero>0 then
  begin
    for I:=0 to Qtd_Numero-1 do
    begin
        senha:=senha+inttostr(RandomRange(0,9));
    end;
  end;

  if Qtd_Letra2 >0 then
  begin
    for I:=0 to Qtd_Letra2-1 do
    begin
      senha:=senha+RandomFrom(Alfa);
    end;
  end;
  result:=senha;
end;



function colocaPontoCPF(S:String):String;
var monta:string;
begin
  s:=tiraponto(trim(s));
  if length(s)<11 then
  begin
    result:='erro';
  end
  else
  begin
    monta:=copy(s,1,3)+'.'+copy(s,4,3)+'.'+copy(s,7,3)+'-'+copy(s,10,2);
    result:=monta;
  end;
end;


function MascaraTelefone(S:string):String;
var
Monta, tel : string;
begin

tel := tiraponto(trim(S));


If length(tel) < 7 then
   begin
   result := 'ERRO';
   exit;
   end;


If length(tel) = 7 then
   begin
   monta := copy(tel,1,3)+'-'+copy(tel,4,4);
   end;

If length(tel) = 8 then
   begin
   monta := copy(tel,1,4)+'-'+copy(tel,5,4);
   end;

If length(tel) > 8 then
   begin
   monta := copy(tel,1,4)+'-'+copy(tel,5,4)+' '+copy(tel,9,length(tel)-8);
   end;


Result := monta;

end;


function TiraAcentos(Str:String): String;
Const
    ComAcento = '‡‚ÍÙ˚„ı·ÈÌÛ˙Á¸¿¬ ‘€√’¡…Õ”⁄«‹';
    SemAcento = 'aaeouaoaeioucuAAEOUAOAEIOUCU';
Var
    x : Integer;
Begin
    For x := 1 to Length(Str) do
       if Pos(Str[x],ComAcento) <> 0  Then
          Str[x] := SemAcento[Pos(Str[x],ComAcento)];
    Result := Str;
end;



function VerificaEmail(s:string):Boolean;
var
i: integer;
achou : boolean;
begin

if pos('@', s) < 1 then
begin
result:= false;
exit;
end;

achou := false;
for I:= (pos('@',s)+1) to length(s) do
begin
If s[i] = '.' then achou := true;
end;

if pos('..', s) > 0 then achou := false;


result := achou;


end;



function SiglaUF(S:string):boolean;
Var
I : integer;
const
UF : array[1..27] of string = ('AC', 'AL', 'MA', 'RS', 'SC', 'PR', 'SP', 'RJ', 'ES', 'SE', 'BA', 'PB', 'PE', 'RN', 'CE', 'PA', 'PI', 'AM', 'RR', 'RO', 'AP', 'GO', 'TO', 'MG', 'MT', 'MS', 'DF');
begin

result := false;
For I:= 1 to 27 do
begin
If UF[i] = S then result := true;
end;


end;


function CheckMod11(num: integer): integer;
var
  soma, dg1, dg2: integer;
  Cpf,monta: string;
begin


  monta := inttostr(num);
  If length(monta) = 1 then cpf:= '00000'+monta;
  If length(monta) = 2 then cpf:= '0000'+monta;
  If length(monta) = 3 then cpf:= '000'+monta;
  If length(monta) = 4 then cpf:= '00'+monta;
  If length(monta) = 5 then cpf:= '0'+monta;
  If length(monta) = 6 then cpf:= monta;
  soma:=0;
  inc(soma,(ord(cpf[1])-$30)*7);
  inc(soma,(ord(cpf[2])-$30)*6);
  inc(soma,(ord(cpf[3])-$30)*5);
  inc(soma,(ord(cpf[4])-$30)*4);
  inc(soma,(ord(cpf[5])-$30)*3);
  inc(soma,(ord(cpf[6])-$30)*2);
  {
  inc(soma,(ord(cpf[7])-$30)*4);
  inc(soma,(ord(cpf[8])-$30)*3);
  inc(soma,(ord(cpf[9])-$30)*2); }
  dg1:=11-(soma mod 11);
  if dg1>=10 then dg1:=0;

  Result := dg1;

  {
  soma:=0;
  inc(soma,(ord(cpf[1])-$30)*11);
  inc(soma,(ord(cpf[2])-$30)*10);
  inc(soma,(ord(cpf[3])-$30)*9);
  inc(soma,(ord(cpf[4])-$30)*8);
  inc(soma,(ord(cpf[5])-$30)*7);
  inc(soma,(ord(cpf[6])-$30)*6);
  inc(soma,(ord(cpf[7])-$30)*5);
  inc(soma,(ord(cpf[8])-$30)*4);
  inc(soma,(ord(cpf[9])-$30)*3);
  inc(soma,(2*dg1));
  dg2:=11-(soma mod 11);
  if dg2>=10 then dg2:=0;
  CheckCPF:=(cpf[10]=chr(dg1+$30)) and (cpf[11]=chr(dg2+$30));
  }
end;



function CheckCPF(cpf: string): boolean;
var
  soma, dg1, dg2: integer;
begin
  if length(cpf)<>11 then
  begin
    CheckCPF:=false;
    exit;
  end;
  soma:=0;
  inc(soma,(ord(cpf[1])-$30)*10);
  inc(soma,(ord(cpf[2])-$30)*9);
  inc(soma,(ord(cpf[3])-$30)*8);
  inc(soma,(ord(cpf[4])-$30)*7);
  inc(soma,(ord(cpf[5])-$30)*6);
  inc(soma,(ord(cpf[6])-$30)*5);
  inc(soma,(ord(cpf[7])-$30)*4);
  inc(soma,(ord(cpf[8])-$30)*3);
  inc(soma,(ord(cpf[9])-$30)*2);
  dg1:=11-(soma mod 11);
  if dg1>=10 then dg1:=0;
  soma:=0;
  inc(soma,(ord(cpf[1])-$30)*11);
  inc(soma,(ord(cpf[2])-$30)*10);
  inc(soma,(ord(cpf[3])-$30)*9);
  inc(soma,(ord(cpf[4])-$30)*8);
  inc(soma,(ord(cpf[5])-$30)*7);
  inc(soma,(ord(cpf[6])-$30)*6);
  inc(soma,(ord(cpf[7])-$30)*5);
  inc(soma,(ord(cpf[8])-$30)*4);
  inc(soma,(ord(cpf[9])-$30)*3);
  inc(soma,(2*dg1));
  dg2:=11-(soma mod 11);
  if dg2>=10 then dg2:=0;
  CheckCPF:=(cpf[10]=chr(dg1+$30)) and (cpf[11]=chr(dg2+$30));
end;



function Tiraponto(S:string):String;
var
Monta, MOntaX : string;
begin
monta  := stringreplace(S,'.','',[rfReplaceAll, rfIgnoreCase]);
montaX := stringreplace(Monta,'/','',[rfReplaceAll, rfIgnoreCase]);
monta  := stringreplace(MontaX,'-','',[rfReplaceAll, rfIgnoreCase]);
Result := monta;
end;


function CaixaMista (mNome: string): string;
var
tam,pos1,pos2 : integer ;
pal, monta : string;
begin
result := '';
Tam   := Length(mNome);
monta := ansilowercase(mNome);
mNome := TrimRight(monta) + ' ';
while True do
begin
pos1:=POS( ' ' , mNome) ;
if pos1 = 0 then break;
pal := Copy(mNome,1,pos1) ;
pos2 := pos(pal, ' na no ao com · ‡ ‡s de das dos do da e os as a e i o u para em nos nas apto bloco cj quadra ');
If pos2 > 0 then pal :=AnsiLowerCase (pal)
else pal:= AnsiUpperCase(Copy(pal,1,1)) + AnsiLowerCase(Copy(pal,2,tam)) ;
result := Trimleft(result + pal) ;
mNome := copy(mNome,pos1+1,tam)
end;

monta := ansiuppercase(copy(result,1,1));
result := monta + (copy(result,2,length(result)-1));

end;



function TestaCgc(xCGC: String):Boolean;
Var
d1,d4,xx,nCount,fator,resto,digito1,digito2 : Integer;
Check : String;
begin
d1 := 0;
d4 := 0;
xx := 1;


If xCGC = '00000000000000' then
   begin
   result := false;
   exit;
   end;

for nCount := 1 to Length( xCGC )-2 do
    begin
    if Pos( Copy( xCGC, nCount, 1 ), '/-.' ) = 0 then
       begin
       if xx < 5 then
          begin
          fator := 6 - xx;
          end
       else
          begin
          fator := 14 - xx;
          end;
       d1 := d1 + StrToInt( Copy( xCGC, nCount, 1 ) ) * fator;
       if xx < 6 then
          begin
          fator := 7 - xx;
          end
       else
          begin
          fator := 15 - xx;
          end;
       d4 := d4 + StrToInt( Copy( xCGC, nCount, 1 ) ) * fator;
       xx := xx+1;
       end;
    end;
    resto := (d1 mod 11);
    if resto < 2 then
       begin
       digito1 := 0;
       end
   else
       begin
       digito1 := 11 - resto;
       end;
   d4 := d4 + 2 * digito1;
   resto := (d4 mod 11);
   if resto < 2 then
      begin
      digito2 := 0;
      end
   else
      begin
      digito2 := 11 - resto;
      end;
   Check := IntToStr(Digito1) + IntToStr(Digito2);
   if Check <> copy(xCGC,succ(length(xCGC)-2),2) then
      begin
      Result := False;
      end
   else
      begin
      Result := True;
      end;
end;


Function Poezero(num:integer):string;
var
monta : string;
begin

monta := inttostr(num);
Case length(monta) of
1: result := '000'+monta;
2: result := '00'+monta;
3: result := '0'+monta;
4: result := monta;
end;

end;




function Decripta(S1:AnsiString):AnsiString;
var
  i,j: integer;
  Cipher: TDCP_blockcipher;
  S    : AnsiString;

begin
  crip  := TDCP_cast128.Create(nil);
  crip.Algorithm  := 'Cast128';
  crip.BlockSize  := 64;
  crip.MaxKeySize := 128;
  Cipher:= TDCP_blockcipher(crip);
  Cipher.InitStr('1');    // initialize the cipher with the key
 try
  s:= B64Decode(S1);
 except
  Result := '';
  exit;
 end;
           // decode the Base64 encoded string
 // s:= S1;
  Cipher.DecryptCFB(S[1],S[1],Length(S));  // decrypt all of the strings
  Result:= s;
  Cipher.Reset;         // we are using CFB chaining mode so we must reset after each block of encrypted/decrypts
  Cipher.Burn;
end;



function ExtrairRegexp(oque,aonde:string):String;
var
  linha:TPerlRegEx;
begin
  Result := '';
  linha := TPerlRegEx.Create(nil);
  linha.Options := [preCaseLess];
  linha.RegEx := oque;
  linha.Subject := aonde;
  try
  linha.Match;
  result := linha.MatchedExpression;
  except
  Result := '';
  end;
  linha.Free;
end;



function buscaRegexp(oque,aonde:string;forma:Integer):boolean;
{  exato: integer = 1;
  contem: integer = 2;
  regex: integer = 3;}
var
  linha:TPerlRegEx;
  monta : string;
begin
  linha := TPerlRegEx.Create(nil);
  case forma of
    1:oque:='\b'+oque+'\b';
    2: begin
       oque:='.{0,}'+oque+'.{0,}';
       monta := stringreplace(oque ,'*','.*',[rfReplaceAll]);
       oque  := stringreplace(monta,'?','.?',[rfReplaceAll]);
       monta := stringreplace(oque ,'+','.+',[rfReplaceAll]);
       oque  := monta;
       end;
    3:oque:=oque;
  end;
  linha.Options := [preCaseLess];
  linha.RegEx   := oque;
  linha.Subject := aonde;
  try
  result:=linha.Match;
  except
  Result := False;
  end;
  linha.DestroyComponents;
end;





end.

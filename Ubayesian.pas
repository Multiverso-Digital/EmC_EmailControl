unit Ubayesian;

interface

uses Classes, StrUtils, SysUtils, DBClient, DB ,Forms,
     generics.collections, generics.defaults, UDMServer, DateUtils;


type



  TToken = class(TObject)
    public
      strToken:String;
      qtd_bad:integer;
      qtd_good:Integer;
      fbad:double;
      fGood:double;
      PToken:Double;
      PDecisao:Double;
      Data:TDateTime;
    private
      //procedure grava(TokenTable:TClientDataSet; campoStr,CampoBad,campoGood:String);
      procedure grava();
      procedure calculaProb(totOk,totSpam:Integer);
      procedure delete();
  end;


  TTokenComparer = TComparer<TToken>;


  TBayesian = class(TObject)
    private
      tab_Bayesian:TClientDataSet;
      TokenList:TClientDataSet;
      qtd_mail_spam,qtd_mail_Ok:Integer;
      pMailSpam,pMailOK,pSpam:Double;
      Lista:TList<TToken>;
      dire:String;
      //Con:TABSDatabase;
      //Session:TABSSession;
      campoStr,CampoBad,campoGood:String;
      procedure buscaQtdmail();
      procedure gravaQtdMail();
      function buscaToken(str:String):TToken;
      procedure addToken(Token:TToken);
      procedure calcPmail();
      function verificatabelas():Boolean;
      function criaTabToken():Boolean;
      function criatab_bayesian():Boolean;
    Public
      procedure learn(S: String;Tipo:Integer); overload;
    Published
      //constructor create(Conexao:TABSDatabase;Session:TABSSession);
      //constructor create(Diretorio:String);
      constructor create();
      procedure learn(S: String;Prefix:array of string;Tipo:Integer); overload;
      procedure reset();
      function TesteMail(Cabec:String;Itens:array of string):Double;
      function listaTokenTeste():TList<TToken>;
      procedure Free();
      procedure limpaToken();





  end;
  function  strToken(var S: String; Seperator: Char): String;
  function PegaItensCabec(Item, cabec:String):String;


implementation

Uses Umain;


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
    if achou = 1 then
       begin
         Monta := Monta + Lista.Strings[i];
         J := I+1;
         if J <= Lista.Count-1 then
         begin
         Lista.Strings[J] := stringreplace(Lista.Strings[J],#9, ' ',[]);
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



function strToken(var S: String; Seperator: Char): String;
var
  I               : Word;
begin
  I:=Pos(Seperator,S);
  if I<>0 then
  begin
    Result:=System.Copy(S,1,I-1);
    System.Delete(S,1,I);
  end else
  begin
    Result:=S;
    S:='';
  end;
end;

{TBayesian}

procedure TBayesian.addToken(Token: TToken);
begin
  //Token.grava(self.TokenList, self.campoStr, self.CampoBad, self.campoGood);
  Token.grava;
end;

procedure TBayesian.buscaQtdmail();
begin
  //if tab_Bayesian <> nil then
  //begin
    //if tab_Bayesian.active then tab_Bayesian.Close;
    //tab_Bayesian.open;
    //if tab_Bayesian.RecordCount > 0 then
    //begin
      //self.qtd_mail_spam:= tab_bayesian.FieldByName('qtd_mail_spam').asInteger;
      //self.qtd_mail_Ok:=tab_bayesian.FieldByName('qtd_mail_ok').asInteger;
    //end
    //else
    //begin
      //self.qtd_mail_spam:= 0;
      //self.qtd_mail_Ok:=0;
    //end;
    //calcPmail();

    self.qtd_mail_spam:= dm_server.TotBad;
    self.qtd_mail_Ok:=DM_SERVER.TotBad;

  //end;
end;



function TBayesian.buscaToken(str: String): TToken;
var
  rToken:TToken;
  work:TStringList;
  achou:Integer;
begin
  work := Tstringlist.Create;
  work.Delimiter := ';';
  achou := Fmain.Palavras.IndexOf(str);

  if achou >= 0 then
  begin
    work.DelimitedText := Fmain.PalavrasComple[achou];

    rtoken:= TToken.Create();
    rtoken.strToken := Fmain.Palavras[achou];
    rtoken.qtd_bad  := strtoint(work[0]);
    rtoken.qtd_Good := strtoint(work[1]);
    rtoken.Data := strtodateTime(work[2]);
    result:= rtoken;
  end
  else
  begin
    rtoken:= TToken.Create();
    rtoken.strToken := STR;
    rtoken.qtd_bad := 0;
    rtoken.qtd_Good := 0;
    result:= rtoken;
  end;

  work.Free;







  {if self.TokenList.Locate(self.campoStr,str,[loCaseInsensitive]) then
  begin
    rtoken:= TToken.Create();
    rtoken.strToken := self.TokenList.FieldByName(self.campoStr).asString;
    rtoken.qtd_bad  := self.TokenList.FieldByName(self.CampoBad).AsInteger;
    rtoken.qtd_Good := self.TokenList.FieldByName(self.campoGood).asInteger;

    result:= rtoken;
  end
  else
  begin
    rtoken:= TToken.Create();
    rtoken.strToken := STR;
    rtoken.qtd_bad := 0;
    rtoken.qtd_Good := 0;
    result:= rtoken;
  end;}




end;

procedure TBayesian.calcPmail();
var
  Tot:Integer;
  totbad,TotGood:Integer;
  ftotbad,ftotgood:Double;
begin
  tot := tab_Bayesian.FieldByName('qtd_mail_spam').AsInteger+
            tab_Bayesian.FieldByName('qtd_mail_ok').AsInteger;

  if tot > 0 then
  begin
    self.pMailSpam := tab_Bayesian.FieldByName('qtd_mail_spam').AsInteger / tot;
    self.pMailOK := tab_Bayesian.FieldByName('qtd_mail_ok').AsInteger / tot;
    totbad:=0;
    totGood:=0;
    self.TokenList.first;
    while not self.TokenList.eof do
    begin
      totbad := totbad+ self.TokenList.FieldByName('qtd_spam').AsInteger;
      totGood := totGood+ self.TokenList.FieldByName('qtd_ok').AsInteger;
      self.TokenList.Next;
    end;

    ftotbad:= totbad / (totbad+totgood);
    ftotgood:= totbad / (totbad+totgood);

    self.pSpam := (ftotbad * self.pMailSpam)/
                    ((ftotbad * self.pMailSpam) + (ftotgood * self.pMailOK));
  end
  else
  begin
    self.pMailSpam := 0;
    self.pMailOK := 0;
    self.pSpam := 0;
  end;





end;

{constructor TBayesian.create(arquivo:TstringList);
begin

end;}


procedure TBayesian.gravaQtdMail();
begin
  {if tab_Bayesian <> nil then
  begin
    tab_Bayesian.Open;
    if tab_Bayesian.RecordCount > 0 then
    begin
      tab_Bayesian.First;
      tab_Bayesian.Edit;
    end
    else
    begin
      tab_Bayesian.append;
    end;
    tab_Bayesian.FieldByName('qtd_mail_spam').AsInteger := self.qtd_mail_spam;
    tab_Bayesian.FieldByName('qtd_mail_ok').AsInteger := self.qtd_mail_ok;
    tab_Bayesian.Post;
    //tab_Bayesian.ApplyUpdates(0);
    tab_Bayesian.refresh;
  end; }
end;

procedure TBayesian.learn(S: String;Tipo:Integer);
{
  1=spam;
  2=ok;
}
var
  token:TToken;
  ws:String;
begin
  if tipo = 1 then
    self.qtd_mail_spam := self.qtd_mail_spam+1
  else if tipo = 2 then
    self.qtd_mail_ok := self.qtd_mail_ok+1;

  while Length(S)>0 do
  begin
    application.ProcessMessages;
    ws := stringreplace(s, #13, ' ', [rfReplaceAll]);
    s := stringreplace(ws, #10, ' ', [rfReplaceAll]);
    Token := buscaToken(strToken(S, ' '));
    if tipo = 1 then
    begin
      Token.qtd_bad := Token.qtd_bad + 1
    end
    else if tipo = 2 then
    begin
      Token.qtd_good := Token.qtd_Good + 1;

    end;

    if length(Token.strToken) > 3 then
    begin
      //Token.grava(self.TokenList,self.campoStr,self.campoBad,self.campoGood);
      Token.grava;
      self.gravaQtdMail();
    end;


    token.Free;

  end;
end;

procedure TBayesian.learn(S: String;Prefix:array of string;Tipo:Integer);
{
  1=spam;
  2=ok;
}
var
  token:TToken;
  ws,work:String;
  i:Integer;
begin
  if tipo = 1 then
    self.qtd_mail_spam := self.qtd_mail_spam+1
  else if tipo = 2 then
    self.qtd_mail_ok := self.qtd_mail_ok+1;
  for i := 0 to length(Prefix) - 1 do
  begin
      ws := PegaItensCabec(Prefix[i]+':',S);
      ws := stringreplace(ws, #13, ' ', [rfReplaceAll]);
      ws := stringreplace(ws, #10, ' ', [rfReplaceAll]);
    while Length(ws)>0 do
    begin
      application.ProcessMessages;
      work := strToken(ws, ' ');
      work:= stringreplace(work,Prefix[i]+':','', [rfIgnoreCase,rfReplaceAll]);
      Token := buscaToken(Prefix[i]+'@'+work);
      if tipo = 1 then
      begin
        Token.qtd_bad := Token.qtd_bad + 1
      end
      else if tipo = 2 then
      begin
        Token.qtd_good := Token.qtd_Good + 1;

      end;

      if (length(trim(work)) > 4) then
      begin
        //Token.grava(self.TokenList,self.campoStr,self.campoBad,self.campoGood);
        Token.grava();
        self.gravaQtdMail();
      end;


      token.Free;

    end;
  end;
end;



procedure TBayesian.limpaToken;
var
  i:integer;
  Data1,Data2 : TDateTime;
  Token : TToken;
  S:TStringList;
begin

  Data1 := IncMonth(now,-3);
  Data2 := IncMonth(now,-6);
  for i := 0 to Fmain.Palavras.Count - 1 do
  begin
    Token := buscaToken(Fmain.Palavras[i]);
    if (((token.Data <= data1) and (token.qtd_good+token.qtd_bad < 10)) or
       ((token.Data <= data2) and (token.qtd_good+token.qtd_bad <= 2)) or
       ((token.qtd_bad <= 1 ) and (token.qtd_good <= 1)) )
    then
    begin
      Token.delete;
      Token.Free;
    end;
  end;

end;

function TBayesian.listaTokenTeste():TList<TToken>;
var
  i:Integer;
  ListaRetorno:TList<TToken>;
begin
  ListaRetorno := TList<TToken>.create();
  for I := 0 to self.lista.Count -1 do
  begin
    if self.Lista.Items[i].PDecisao > 0 then
    begin
      ListaRetorno.Add(self.Lista.Items[i]);
    end;
  end;
  result:=ListaRetorno;
end;

procedure TBayesian.reset();
var
  query:TClientDataSet;
begin
  try
    query := TClientDataSet.Create(nil);
    query.FileName:=self.dire+'tab_token.xml';
    query.open;
    query.EmptyDataSet;
    query.Close;

    query.FileName:=self.dire+'tab_bayesian.xml';
    query.open;
    query.EmptyDataSet;
    query.Close;

    //query.DatabaseName := self.Con.Name;
    //query.SessionName := self.Session.Name;
    //query.SQL.add('delete from tab_token;');
    //query.SQL.add('alter table tab_token AUTO_INCREMENT = 1;');
    //query.SQL.add('update tab_bayesian set tab_bayesian.qtd_mail_ok = 0, tab_bayesian.qtd_mail_spam = 0;');
    //query.ExecSQL;
    //query.Free;
  except

  end;
end;

function TBayesian.TesteMail(Cabec:String;Itens:array of string):Double;
var
  token :Ttoken;
  s,ws,workS:String;
  fatorDividendo,fatorDivisor,fatorDecisao:Double;
  i,ate:Integer;
  pSpammsg:Double;

begin
  for I := 0 to self.Lista.Count - 1 do
  begin
    self.Lista[i].Free;
  end;
  self.Lista.Clear;
  if length(Itens) > 0 then
  begin
    for I := 0 to length(Itens) - 1 do
    begin
      ws := PegaItensCabec(itens[i]+':',Cabec);
      ws := stringreplace(ws, #13, ' ', [rfReplaceAll]);
      ws := stringreplace(ws, #10, ' ', [rfReplaceAll]);
      while Length(ws)>0 do
      begin
        token := TToken.Create;
        Token := buscaToken(itens[i]+'@'+strToken(ws, ' '));
        Token.calculaProb(self.qtd_mail_Ok,self.qtd_mail_spam);
        lista.Add(token);
      end;
    end;
  end
  else
  begin
    s := Cabec;
    ws := stringreplace(s, #13, ' ', [rfReplaceAll]);
    s := stringreplace(ws, #10, ' ', [rfReplaceAll]);
    while Length(S)>0 do
    begin
      token := TToken.Create;
      workS := strToken(S, ' ');
      if length(workS) > 4 then
      begin
        Token := buscaToken(workS);
        Token.calculaProb(self.qtd_mail_Ok,self.qtd_mail_spam);
        lista.Add(token);
      end
    end;
  end;



  Lista.Sort(TTokenComparer.Construct(
      function (const L, R: TToken): Integer
      begin
        if L.PDecisao = R.PDecisao then
          result:=0
        else if L.PDecisao < R.PDecisao then
          result := 1
        else if L.PDecisao > R.PDecisao then
          result:=-1;
      end
      )) ;


  fatorDividendo := 1;
  fatorDivisor := 1;
  if lista.Count >= 15 then
    ate := 15
  else
    ate := lista.Count;

  for I := 0 to lista.Count -1 do
  //for I := 0 to ate do
  begin
    if Lista.Items[i].PDecisao > 0 then
    begin
      fatorDividendo := fatorDividendo * Lista.items[i].PToken;
      fatorDivisor := fatorDivisor * (1 - Lista.items[i].PToken);
    end
    else
    begin
      break;
    end;
  end;
  pSpammsg:=fatorDividendo / (fatorDividendo + fatorDivisor);

  {result :=0;
  if pSpammsg >= self.pSpam  then
  begin
    result := 1;
  end;}

  result:= pSpammsg;

end;

function TBayesian.criaTabToken: Boolean;
//var query:TMyquery;
begin
  {try
    query.Create(nil);
    query.Connection := self.Con;
    query.SQL.add('CREATE TABLE `tab_token` ('+
    '`id` int(11) NOT NULL auto_increment,'+
    '`palavra` varchar(255) default NULL,'+
    '`qtd_spam` int(11) default NULL,'+
    '`qtd_ok` int(11) default NULL,'+
    '`mail_spam` int(11) default NULL,'+
    '`mail_ok` int(11) default NULL,'+
    'PRIMARY KEY  (`id`),'+
    'KEY `palavra` (`palavra`)'+
    ') ENGINE=InnoDB AUTO_INCREMENT=6816 DEFAULT CHARSET=latin1 COMMENT='+QuotedStr('InnoDB free: 8803328 kB; InnoDB free: 8803328 kB')+';');
    query.Execute;
    query.Free;
  Except
    result:=false;
    raise Exception.CreateFmt('Erro na cria??o da Tabela de Tokens',[]);
  end;}
  Result:=true;
end;

function TBayesian.criatab_bayesian: Boolean;
//var query:TMyquery;
begin
  {try
    query.Create(nil);
    query.Connection := self.Con;
    query.SQL.add('CREATE TABLE `tab_bayesian` ('+
    '`id` int(11) NOT NULL auto_increment,'+
    '`qtd_mail_spam` int(11) default '+QuotedStr('0')+','+
    '`qtd_mail_ok` int(11) default '+QuotedStr('0')+','+
    'PRIMARY KEY  (`id`)'+
    ') ENGINE=InnoDB AUTO_INCREMENT=6816 DEFAULT CHARSET=latin1 COMMENT='+QuotedStr('InnoDB free: 8803328 kB; InnoDB free: 8803328 kB')+';');
    query.Execute;
    query.Free;
  Except
    result:=false;
    raise Exception.CreateFmt('Erro na cria??o da Tabela Bayesian',[]);
  end; }
  Result:=true;

end;

procedure TBayesian.Free;
var
  i:Integer;
begin
  for I := 0 to self.Lista.Count - 1 do
  begin
    self.Lista[i].Free;
  end;
  self.TokenList.Free;
  self.tab_Bayesian.Free;
  self.Lista.Free;
  dm_server.TotOK := self.qtd_mail_Ok;
  dm_server.TotBad := self.qtd_mail_spam;
  inherited free;

end;

function TBayesian.verificatabelas(): Boolean;
var
  Listatabelas : TStringList;
begin
  {Listatabelas := TStringList.Create;
  Con.GetTableNames(Listatabelas);
  if Listatabelas.IndexOf('tab_token') < 0 then
  begin
    if not criaTabToken() then
    begin
      result:=false;
      exit;
    end;
  end; }
  try

    {
    self.TokenList := TClientDataSet.Create(Nil);
    self.TokenList.CloneCursor(DM_SERVER.tab_token,false,false);
    self.TokenList.IndexFieldNames := 'Palavra';
    }


    //self.TokenList.Filename := self.dire+'tab_token.xml'; //dm_server.Con_Bayesian.DatabaseName;
    //self.TokenList.InMemory     := true;
    //self.TokenList.Open;

    //    self.TokenList.SessionName :=  dm_server.SessaoSetup.SessionName;
    //self.TokenList.SQL.text := 'Select * from tab_token where palavra = :palavra';
    //self.TokenList.ReadOnly := false;
    //self.TokenList.RequestLive := true;
    {
    self.TokenList.SQLInsert.add('INSERT INTO tab_token');
    self.TokenList.SQLInsert.add('(ID, palavra, qtd_spam, qtd_ok, DT)');
    self.TokenList.SQLInsert.add('VALUES');
    self.TokenList.SQLInsert.add('(:ID, :palavra, :qtd_spam, :qtd_ok, :DT)');


    self.TokenList.SQLUpdate.add('UPDATE tab_token');
    self.TokenList.SQLUpdate.add('SET');
    self.TokenList.SQLUpdate.add('  ID = :ID, palavra = :palavra, qtd_spam = :qtd_spam, qtd_ok = :qtd_ok, DT = :DT');
    self.TokenList.SQLUpdate.add('WHERE');
    self.TokenList.SQLUpdate.add('  ID = :Old_ID');

    self.TokenList.SQLRefresh.Text := 'SELECT * FROM tab_token WHERE tab_token.ID = :ID';

    self.TokenList.SQLDelete.Text := 'DELETE FROM tab_token WHERE  ID = :Old_ID';
    self.TokenList.CachedUpdates := true;
    self.TokenList.IndexFieldNames := 'palavra';
    self.TokenList.Open; }
  Except
    result:=false;
    exit;
  end;

  {if Listatabelas.IndexOf('tab_bayesian') < 0 then
  begin
    criatab_bayesian();
  end;}
  try
    //self.tab_Bayesian := TClientDataSet.Create(Nil);
    //self.tab_Bayesian.Filename := self.dire+'tab_bayesian.xml'; //dm_server.Con_Bayesian.DatabaseName;    self.tab_Bayesian.Open;

    //self.tab_Bayesian.open;
  Except
    result:=false;
    exit;
  end;
  result:=true;

end;

//constructor TBayesian.create(Conexao:TABSDatabase;Session:TABSSession);
//constructor TBayesian.create(Diretorio:String);
constructor TBayesian.create();
var
  Token:TToken;
  Tabelas : TStringList;
  I:Integer;
begin

  self.Lista     := TList<TToken>.Create;
  self.campoStr  := 'palavra';
  self.CampoBad  := 'qtd_spam';
  self.campoGood := 'qtd_ok';
  //self.dire := Diretorio;
  //self.Con       := DM_Server.Con_Bayesian;
  //self.Session   := DM_Server.SessaoSetup;

  //self.Con := &Conexao;
  //self.Session := &Session;




  //if not self.verificatabelas() then
  //begin
    //self.Free;
  //end
  //else
  //begin
    buscaQtdmail()
  //end;
end;





{ TToken }

procedure TToken.calculaProb(totOk,totSpam:Integer);
var
  fatorOK,fatorSpam,probSpam,probOK:Double;

begin
  if (self.qtd_bad + self.qtd_good) >= 3 then
  begin

    if self.qtd_bad = 0 then
    begin
      self.PToken:= 0.1;
    end
    else if self.qtd_good = 0 then
    begin
      if qtd_bad < 10 then
      begin
        self.PToken:= 0.9;
      end
      else
      begin
        self.PToken:= 0.99;
      end;
    end
    else
    begin

      self.fbad := self.qtd_bad / (self.qtd_bad + self.qtd_good);
      self.fgood := self.qtd_good / (self.qtd_bad + self.qtd_good);
      self.fgood := self.fgood*6;

      probSpam := totSpam / (totSpam + totOk);
      probOK := totOk / (totSpam + totOk);


      self.fbad := self.fbad * probSpam;
      self.fgood := self.fGood * probOK;


      self.PToken:= self.fbad / (self.fGood + self.fbad);

    end;
    self.PDecisao := Abs( 0.5 - self.PToken );

  end
  else
  begin
    self.fbad :=0;
    self.fgood := 0;
    self.PToken := 0;
    self.PDecisao := 0;
  end;

end;


procedure TToken.delete;
var
achou : Integer;
begin
  achou := Fmain.Palavras.IndexOf(self.strToken);
  if achou >=0 then
  begin
    fmain.Palavras.Delete(achou);
    fmain.PalavrasComple.Delete(achou);
  end;
end;



//procedure TToken.grava(TokenTable: TClientDataSet; campoStr, CampoBad,campoGood: String);
procedure TToken.grava();
var
  achou:Integer;
  work:String;
begin
  {if TokenTable.Active then TokenTable.Close;
  TokenTable.Params[0].asString := self.strToken;
  TokenTable.open;

  if TokenTable.RecordCount > 0 then
  begin
    TokenTable.Edit;
  end
  else
  begin
    TokenTable.Append;
  end;



  if TokenTable.Locate(campoStr,self.strToken,[loCaseInsensitive]) then
  begin
    TokenTable.edit;
  end
  else
  begin
    TokenTable.append;
  end;

  TokenTable.FieldByName(campoSTR).AsString := self.strToken;
  TokenTable.FieldByName(CampoBad).AsFloat := self.qtd_bad;
  TokenTable.FieldByName(CampoGood).AsFloat := self.qtd_Good;
  TokenTable.Post; }
  achou := Fmain.Palavras.IndexOf(self.strToken);
  if achou >=0 then
  begin
    work := inttostr(self.qtd_bad)+';';
    work := work+inttostr(self.qtd_good)+';';
    work := work+DateTimeToStr(now)+'';
    fmain.PalavrasComple[achou] := work;
  end
  else
  begin
    work := inttostr(self.qtd_bad)+';';
    work := work+inttostr(self.qtd_good)+';';
    work := work+DateTimeToStr(now)+'';
    Fmain.Palavras.Add(self.strToken);
    fmain.PalavrasComple.Add(work);
  end;






end;


end.

unit UFiltro_Bayesian;

interface
uses
Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,Dialogs,IdMessage,
UCriaObjetos,  DB, funcoes, generics.Collections;

Function Filtrar_Bayesian(Mens:TMSG):TMSG;
Function Aprenderbayesian(s:string;RuimBom:integer):boolean;
Function Testabayesian(s:string):double;



implementation

uses UDM_Baysean, Ubayesian, UDMServer;

Function Filtrar_Bayesian(Mens:TMSG):TMSG;
var
Pala : TList<TToken>;
I    : integer;
Palavras : Tbayesian;
begin
  if DM_Server.Con_Bayesian.Connected then
  begin

    Result := Mens;
    if dm_server.Baysean = 1 then
    begin
      Palavras := Tbayesian.create(dm_server.dire='Dados\');
      Mens.IndiceBayesian :=   Palavras.TesteMail(Mens.FrasesBaesyan.text,[]);
      if Mens.IndiceBayesian >= dm_server.valorBaysean then
      begin
        Mens.Filtrada     := 147;
        Mens.Selecionada  := 1;
        Pala := Palavras.listaTokenTeste;
        Mens.FiltroResultado.Add('Bayesian token: '+floattostr(Mens.IndiceBayesian));
        for I:= 0 to Pala.Count - 1 do
        begin
          Mens.FiltroResultado.Add('Word: '+pala.Items[i].strToken+' Prob:'+floattostr(pala.Items[i].PToken))
        end;
        Pala.Free;
      end;

      Result := Mens;
      Palavras.Free;
    end;
  end
  else
  begin
    result:=Mens;
  end;
end;





Function Aprenderbayesian(s:string;RuimBom:integer):boolean;
var
  Palavras : Tbayesian;
begin
  if DM_Server.Con_Bayesian.Connected then
  begin
    Palavras := Tbayesian.create(dm_server.dire='Dados\');
    Palavras.learn(s,RuimBom);
    Palavras.Free;
  end;
end;


Function Testabayesian(s:string):double;
var
  Palavras : Tbayesian;
begin
  if DM_Server.Con_Bayesian.Connected then
  begin
    Palavras := Tbayesian.create(dm_server.dire='Dados\');
    result := Palavras.TesteMail(s,[]);
    Palavras.Free;
  end;
end;






end.

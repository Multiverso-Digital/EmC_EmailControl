unit UDM_Baysean;

interface

uses
  SysUtils, Classes, DB, {MemDS, DBAccess,} ABSMain, UcriaObjetos,
  Ubayesian, generics.Collections, midaslib;

type
  TDM_Baysean = class(TDataModule)
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Function Filtrar_Bayesian(Mens:TMSG):TMSG;
    Function Aprenderbayesian(s:string;RuimBom:integer):boolean;
    Function Testabayesian(s:string):double;
  end;

var
  DM_Baysean: TDM_Baysean;

implementation

Uses UDMSERVER, UMain;

{$R *.dfm}

procedure TDM_Baysean.DataModuleCreate(Sender: TObject);
begin

{
  try
  dm_server.Con_Bayesian.DatabaseFileName := dm_server.Dire+'Dados\bayesian.abs';
  dm_server.Con_Bayesian.DatabaseName := 'bayesian';
  dm_server.Con_Bayesian.Connected := true;
  Except
    Fmain.ListBox1.Items.Add('WARNING: Cannot connect to Bayesian Database. Sorry, this filter will not run.')
  end;
 }

end;

procedure TDM_Baysean.DataModuleDestroy(Sender: TObject);
begin
  //dm_server.Con_Bayesian.Connected := false;
end;


Function TDM_Baysean.Filtrar_Bayesian(Mens:TMSG):TMSG;
var
Pala : TList<TToken>;
I    : integer;
Palavras : Tbayesian;
begin


//  if dm_server.Con_Bayesian.Connected then
//  begin

    Result := Mens;
    if dm_server.Baysean = 1 then
    begin
      Palavras := Tbayesian.create();
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

 {
  end
  else
  begin
    result:=Mens;
  end;
  }

end;





Function TDM_Baysean.Aprenderbayesian(s:string;RuimBom:integer):boolean;
var
  Palavras : Tbayesian;
begin


//  if dm_server.Con_Bayesian.Connected then
//  begin
    Palavras := Tbayesian.create();
    Palavras.learn(s,RuimBom);
    Palavras.Free;
//  end;


end;


Function TDM_Baysean.Testabayesian(s:string):double;
var
  Palavras : Tbayesian;
begin
//  if dm_server.Con_Bayesian.Connected then
//  begin
    Palavras := Tbayesian.create();
    result := Palavras.TesteMail(s,[]);
    Palavras.Free;
//  end;
end;



end.

unit UDM_Avancado;

interface

uses
  SysUtils, Classes, DB, DBClient, Provider, {MemDS, {DBAccess,} MidasLib,
  UCriaObjetos, funcoes;

type
  TDM_Avancado = class(TDataModule)
  private
    { Private declarations }
  public


// Function FiltraBoxes(TypeBox:Integer;
//                        WhereFilter:Integer;
//                        Grupado:Integer):Boolean;

 Function AtualizaBoxes(ID:largeint):Boolean;



 Function Filtrar_Favoritos_Nao_Grupados(Mens:TMSG):TMSG;
 Function Filtrar_Favoritos_Grupados(Mens:TMSG):TMSG;
 Function Filtrar_ListaNegra_NaoGrupados(Mens:TMSG):TMSG;
 Function Filtrar_ListaNegra_Grupados(Mens:TMSG):TMSG;

    { Public declarations }
  end;

var
  DM_Avancado: TDM_Avancado;



implementation

uses UDMSERVER;



Function TDM_Avancado.AtualizaBoxes(ID:largeint):Boolean;
var
QupBoxesT : TClientDataset;
begin
QupBoxesT := TClientDataset.Create(nil);
qupBoxesT.CloneCursor(dm_server.cds_boxes,false,false);
qupboxesT.IndexFieldNames := 'ID';
if qupboxesT.Locate('ID',ID,[]) then
   begin
        qupboxesT.edit;
        qupboxesT.FieldByName('countmacths').AsInteger := qupboxesT.FieldByName('countmacths').AsInteger + 1;
        qupboxesT.FieldByName('DT').AsDateTime := now;
        qupboxesT.post;
   end;
qupboxesT.free;
end;


{
Function TDM_Avancado.FiltraBoxes(TypeBox:Integer;
                        WhereFilter:Integer;
                        Grupado:Integer):Boolean;
var
cds_BoxesF : TABSQuery;
begin



if cds_BoxesF.Active then cds_BoxesF.Active := false;

cds_BoxesF.Params[0].AsInteger := TypeBox;
if grupado = 0 then
cds_BoxesF.Filter              := 'WhereFilter = '+inttostr(WhereFilter)+' and '+'FilterID = 0 and kind < 4';
if grupado = -1 then
cds_BoxesF.Filter              := 'WhereFilter = '+inttostr(WhereFilter)+' and '+'FilterID > 0 and kind < 4';
if grupado > 0 then
cds_BoxesF.Filter              := 'WhereFilter = '+inttostr(WhereFilter)+' and '+'FilterID = '+inttostr(Grupado);


cds_BoxesF.Filtered := true;
try
cds_BoxesF.active := true;
cds_BoxesF.First;
except
Result := False;
exit;
end;

Result := true;

end;

 }



Function TDM_Avancado.Filtrar_Favoritos_Nao_Grupados(Mens:TMSG):TMSG;
var
Monta : string;
cds_BoxesF : TClientDataset;
begin


Result := Mens;


cds_BoxesF                := TClientDataset.Create(nil);
cds_BoxesF.CloneCursor(dm_server.cds_boxes,false,false);
cds_BoxesF.filter          := 'TypeBox = 1 and WhereFilter = 1 and FilterID = 0 and kind < 4' ;
cds_BoxesF.filtered := true;

try
cds_BoxesF.active := true;
cds_BoxesF.First;
except
cds_BoxesF.free;
exit;
end;



 while not cds_BoxesF.Eof do
   begin

    Monta := Trim(PegaItensCabec(cds_BoxesF.FieldByName('Item').AsString, Mens.Headers.Text));

    if (cds_BoxesF.FieldByName('Kind').AsInteger = 1) and (Monta <> '') then
       begin
        Mens.FiltroResultado.Add(cds_BoxesF.FieldByName('NameRule').AsString+' '+cds_BoxesF.FieldByName('Item').AsString+' found in this header.');
        Mens.Favorita    := 1;
        Mens.Filtrada    := 144;
        Mens.Selecionada := 0;
        Result := Mens;
        //atualizaboxes(cds_BoxesF.FieldByName('ID').AsInteger);
        break;
       end;



    if (cds_BoxesF.FieldByName('Kind').AsInteger = 2) and (Monta <> '') then
       begin
        if buscaRegexp(cds_BoxesF.FieldByName('Expression').asstring,Monta,2) then
           begin
           Mens.FiltroResultado.Add(cds_BoxesF.FieldByName('NameRule').AsString+' '+cds_BoxesF.FieldByName('Item').asstring+' match to filter: '+cds_BoxesF.FieldByName('Expression') .asstring);
           Mens.Favorita    := 1;
           Mens.Filtrada    := 144;
           Mens.Selecionada := 0;
           Result := Mens;
          // atualizaboxes(cds_BoxesF.FieldByName('ID').AsInteger);
           break;
           end;
       end;



    if (cds_BoxesF.FieldByName('Kind').AsInteger = 3) and (Monta <> '') then
       begin
        if buscaRegexp(cds_BoxesF.FieldByName('Expression').asstring,Monta,3) then
           begin
           Mens.FiltroResultado.Add(cds_BoxesF.FieldByName('NameRule').AsString+' '+cds_BoxesF.FieldByName('Item').asstring+' match to filter: '+cds_BoxesF.FieldByName('Expression') .asstring);
           Mens.Favorita    := 1;
           Mens.Filtrada    := 144;
           Mens.Selecionada := 0;
           Result := Mens;
           //atualizaboxes(cds_BoxesF.FieldByName('ID').AsInteger);
           break;
           end;
       end;
    cds_BoxesF.Next;
   end;

cds_BoxesF.Close;
cds_BoxesF.free;
end;





Function TDM_Avancado.Filtrar_Favoritos_Grupados(Mens:TMSG):TMSG;
var
Monta, Logica     : string;
IDFilter, Registros  : integer;
Total     : Integer;
GuardaID  : LongInt;
Filtro      : TstringList;
cds_BoxesF : TClientDataset;
begin


Result := Mens;



cds_BoxesF := TClientDataset.Create(nil);
cds_BoxesF.CloneCursor(dm_server.cds_boxes,false,false);
cds_BoxesF.filter := 'TypeBox = 1 and WhereFilter = 1 and FilterID > 0 and kind < 4';
cds_BoxesF.filtered := true;

Filtro := TStringList.Create;



try
cds_BoxesF.active := true;
cds_BoxesF.First;
except
cds_BoxesF.free;
exit;
end;


IDFilter := cds_BoxesF.FieldByName('FilterID').AsInteger;
Logica   := cds_BoxesF.FieldByName('MatchType').AsString;
Registros:= 0;
Total    := 0;

 while not cds_BoxesF.Eof do
   begin

    Monta := Trim(PegaItensCabec(cds_BoxesF.FieldByName('Item').AsString,Mens.Headers.Text));


    If IDFilter <> cds_BoxesF.FieldByName('FilterID').AsInteger then
    begin

      if Logica = 'AND' then
      begin
       if Total = Registros then
           Begin
           Mens.Filtrada    := 144;
           Mens.Favorita    := 1;
           Mens.Selecionada := 0;
           Mens.FiltroResultado.AddStrings(Filtro);
           Result := Mens;
           //atualizaboxes(cds_BoxesF.FieldByName('ID').AsInteger);
           Break;
           End
           else
           begin
           Registros := 0;
           Total := 0;
           IDFilter := cds_BoxesF.FieldByName('FilterID').AsInteger;
           Logica   := cds_BoxesF.FieldByName('MatchType').AsString;
           end;

      end
      else
      begin
          if Total > 0 then
           Begin
           Mens.Filtrada    := 144;
           Mens.Favorita    := 1;
           Mens.Selecionada := 0;
           Result := Mens;
           //atualizaboxes(cds_BoxesF.FieldByName('ID').AsInteger);
           Break;
           End
           else
           begin
           Registros := 0;
           Total := 0;
           IDFilter := cds_BoxesF.FieldByName('FilterID').AsInteger;
           Logica   := cds_BoxesF.FieldByName('MatchType').AsString;
           end;


     end;

    end;

    Registros := Registros + 1;

    if (cds_BoxesF.FieldByName('Kind').AsInteger = 1) and (Monta <> '') then
       begin
        Filtro.add(cds_BoxesF.FieldByName('NameRule').AsString+' '+cds_BoxesF.FieldByName('Item').AsString+' found in this header.');
        Total := Total + 1;
       end;

    if (cds_BoxesF.FieldByName('Kind').AsInteger = 2) and (Monta <> '') then
       begin
        if buscaRegexp(cds_BoxesF.FieldByName('Expression').AsString,Monta,2) then
           begin
           Filtro.add(cds_BoxesF.FieldByName('NameRule').AsString+' '+cds_BoxesF.FieldByName('Item').AsString+' match to filter: '+cds_BoxesF.FieldByName('Expression').AsString+' '+cds_BoxesF.FieldByName('MatchType').AsString);
           Total := Total + 1;
           end;
       end;

    if (cds_BoxesF.FieldByName('Kind').AsInteger = 3) and (Monta <> '') then
       begin
        if buscaRegexp(cds_BoxesF.FieldByName('Expression').AsString,Monta,3) then
           begin
           Filtro.add(cds_BoxesF.FieldByName('NameRule').AsString+' '+cds_BoxesF.FieldByName('Item').AsString+' match to filter: '+cds_BoxesF.FieldByName('Expression').AsString+' '+cds_BoxesF.FieldByName('MatchType').AsString);
           Total := Total + 1;
           end;
       end;

    GuardaID :=  cds_BoxesF.FieldByName('ID').AsInteger;
    cds_BoxesF.Next;
   end;


    if Logica = 'AND' then
     begin
       if Total = Registros then
           Begin
           Mens.Filtrada    := 144;
           Mens.Favorita    := 1;
           Mens.Selecionada := 0;
           Mens.FiltroResultado.AddStrings(Filtro);
           Result := Mens;
           atualizaboxes(cds_BoxesF.FieldByName('ID').AsInteger);
           End
           else
           begin
           Registros := 0;
           Total := 0;
           end;

     end
     else
     begin
          if Total > 0 then
           Begin
           Mens.Filtrada    := 144;
           Mens.Favorita    := 1;
           Mens.Selecionada := 0;
           Result := Mens;
           atualizaboxes(GuardaID);
           End
           else
           begin
           Registros := 0;
           Total := 0;
           end;
     end;
cds_BoxesF.Close;
cds_BoxesF.free;
Filtro.Free;



end;






Function TDM_Avancado.Filtrar_ListaNegra_NaoGrupados(Mens:TMSG):TMSG;
var
Monta : string;
cds_BoxesF : TClientDataset;
begin

Result := Mens;



cds_BoxesF := TClientDataset.Create(nil);
cds_BoxesF.CloneCursor(dm_server.cds_boxes,false,false);
cds_BoxesF.filter := 'TypeBox = 2 and WhereFilter = 1 and FilterID = 0 and kind < 4';
cds_BoxesF.filtered := true;

try
cds_BoxesF.active := true;
cds_BoxesF.First;
except
cds_BoxesF.free;
exit;
end;






 while not cds_BoxesF.Eof do
   begin

    Monta := Trim(PegaItensCabec(cds_BoxesF.FieldByName('Item').AsString, Mens.Headers.Text));

    if (cds_BoxesF.FieldByName('Kind').AsInteger = 1) and (Monta <> '') then
       begin
        Mens.FiltroResultado.Add(cds_BoxesF.FieldByName('NameRule').AsString+' '+cds_BoxesF.FieldByName('Item').AsString+' found in this header.');
        Mens.Filtrada    := 5;
        Mens.Selecionada := 1;
        Mens.ListaNegra  := 1;
        Result := Mens;
        atualizaboxes(cds_BoxesF.FieldByName('ID').AsInteger);
        break;
       end;

    if (cds_BoxesF.FieldByName('Kind').AsInteger = 2) and (Monta <> '') then
       begin
        if buscaRegexp(cds_BoxesF.FieldByName('Expression').AsString,Monta,2) then
           begin
           Mens.FiltroResultado.Add(cds_BoxesF.FieldByName('NameRule').AsString+' '+cds_BoxesF.FieldByName('Item').AsString+' match to filter: '+cds_BoxesF.FieldByName('Expression').AsString);
           Mens.Filtrada    := 5;
           Mens.Selecionada := 1;
           Mens.ListaNegra  := 1;
           Result := Mens;
           atualizaboxes(cds_BoxesF.FieldByName('ID').AsInteger);
           break;
           end
           else
           begin

             if cds_BoxesF.FieldByName('Item').AsString = 'Subject:' then
                begin
                      if buscaRegexp(cds_BoxesF.FieldByName('Expression').AsString, mens.Subject,2) then
                       begin
                        Mens.FiltroResultado.Add(cds_BoxesF.FieldByName('NameRule').AsString+' '+cds_BoxesF.FieldByName('Item').AsString+' match to filter: '+cds_BoxesF.FieldByName('Expression').AsString);
                        Mens.Filtrada    := 5;
                        Mens.Selecionada := 1;
                        Mens.ListaNegra  := 1;
                        Result := Mens;
                        atualizaboxes(cds_BoxesF.FieldByName('ID').AsInteger);
                        break;

                      end;
                end;

             if cds_BoxesF.FieldByName('Item').AsString = 'From:' then
                begin
                      if buscaRegexp(cds_BoxesF.FieldByName('Expression').AsString, mens.EmailFrom,2) then
                       begin
                        Mens.FiltroResultado.Add(cds_BoxesF.FieldByName('NameRule').AsString+' '+cds_BoxesF.FieldByName('Item').AsString+' match to filter: '+cds_BoxesF.FieldByName('Expression').AsString);
                        Mens.Filtrada    := 5;
                        Mens.Selecionada := 1;
                        Mens.ListaNegra  := 1;
                        Result := Mens;
                        atualizaboxes(cds_BoxesF.FieldByName('ID').AsInteger);
                        break;
                      end;
                end;
           end;
       end;


    if (cds_BoxesF.FieldByName('Kind').AsInteger = 3) and (Monta <> '') then
       begin
        if buscaRegexp(cds_BoxesF.FieldByName('Expression').AsString,Monta,3) then
           begin
           Mens.FiltroResultado.Add(cds_BoxesF.FieldByName('NameRule').AsString+' '+cds_BoxesF.FieldByName('Item').AsString+' match to filter: '+cds_BoxesF.FieldByName('Expression').AsString);
           Mens.Filtrada    := 5;
           Mens.Selecionada := 1;
           Mens.ListaNegra  := 1;
           Result := Mens;
           atualizaboxes(cds_BoxesF.FieldByName('ID').AsInteger);
           break;
           end;
       end;

    cds_BoxesF.Next;
   end;


cds_BoxesF.Close;
cds_BoxesF.free;
end;







Function TDM_Avancado.Filtrar_ListaNegra_Grupados(Mens:TMSG):TMSG;
var
Monta, Logica        : string;
IDFilter, Registros  : integer;
Total                : Integer;
GuardaID             : LongInt;
Filtro               : TstringList;
JaFez                : Boolean;
cds_BoxesF : TClientDataset;
begin


Result := Mens;


cds_BoxesF := TClientDataset.Create(nil);
cds_BoxesF.CloneCursor(dm_server.cds_boxes,false,false);
cds_BoxesF.Filter  := 'TypeBox = 2 and WhereFilter = 1 and FilterID > 0 and kind < 4';
cds_BoxesF.Filtered := true;


Filtro := TStringList.Create;



JaFez := false;

With dm_avancado do
begin

try
cds_BoxesF.active := true;
cds_BoxesF.First;
except
cds_BoxesF.Free;
exit;
end;



IDFilter := cds_BoxesF.FieldByName('FilterID').AsInteger;
Logica   := cds_BoxesF.FieldByName('MatchType').AsString;
Registros:= 0;
Total    := 0;

 while not cds_BoxesF.Eof do
   begin



    Monta := Trim(PegaItensCabec(cds_BoxesF.FieldByName('Item').AsString,Mens.Headers.Text));



    If IDFilter <> cds_BoxesF.FieldByName('FilterID').AsInteger then
    begin

     if Logica = 'AND' then
     begin
       if Total = Registros then
           Begin
            Mens.Filtrada     := 5;
            Mens.Selecionada  := 1;
            Mens.ListaNegra   := 1;
            Mens.FiltroResultado.AddStrings(filtro);
            Result := Mens;
            atualizaboxes(cds_BoxesF.FieldByName('ID').AsInteger);
            JaFez := True;
            Break;
           End
           else
           begin
           Registros := 0;
           Total := 0;
           IDFilter := cds_BoxesF.FieldByName('FilterID').AsInteger;
           Logica   := cds_BoxesF.FieldByName('MatchType').AsString;
           end;

     end
     else
     begin
          if Total > 0 then
           Begin
            Mens.Filtrada     := 5;
            Mens.Selecionada  := 1;
            Mens.ListaNegra   := 1;
            Mens.FiltroResultado.AddStrings(filtro);
            Result := Mens;
            atualizaboxes(cds_BoxesF.FieldByName('ID').AsInteger);
            JaFez := True;
            Break;
           End
           else
           begin
           Registros := 0;
           Total := 0;
           IDFilter := cds_BoxesF.FieldByName('FilterID').AsInteger;
           Logica   := cds_BoxesF.FieldByName('MatchType').AsString;
           end;
      end;

    end;



    Registros := Registros + 1;

    if (cds_BoxesF.FieldByName('Kind').AsInteger = 1) and (Monta <> '') then
       begin
       Filtro.Add(cds_BoxesF.FieldByName('NameRule').AsString+' '+cds_BoxesF.FieldByName('Item').AsString+' found in this header.');
       Total := Total + 1;
       end;

    if (cds_BoxesF.FieldByName('Kind').AsInteger = 2) and (Monta <> '') then
       begin
        if buscaRegexp(cds_BoxesF.FieldByName('Expression').AsString,Monta,2) then
           begin
           Filtro.Add(cds_BoxesF.FieldByName('NameRule').AsString+' '+cds_BoxesF.FieldByName('Item').AsString+' match to filter: '+cds_BoxesF.FieldByName('Expression').AsString+' '+cds_BoxesF.FieldByName('MatchType').AsString);
           Total := Total + 1;
           end
           else
           begin

           if cds_BoxesF.FieldByName('Item').AsString = 'Subject:' then
                begin
                      if buscaRegexp(cds_BoxesF.FieldByName('Expression').AsString, Mens.Subject,2) then
                       begin
                        Filtro.Add(cds_BoxesF.FieldByName('NameRule').AsString+' '+cds_BoxesF.FieldByName('Item').AsString+' match to filter: '+cds_BoxesF.FieldByName('Expression').AsString+' '+cds_BoxesF.FieldByName('MatchType').AsString);
                         Total := Total + 1;
                      end;
                end;

             if cds_BoxesF.FieldByName('Item').AsString = 'From:' then
                begin
                      if buscaRegexp(cds_BoxesF.FieldByName('Expression').AsString, Mens.EmailFrom,2) then
                       begin
                        Filtro.Add(cds_BoxesF.FieldByName('NameRule').AsString+' '+cds_BoxesF.FieldByName('Item').AsString+' match to filter: '+cds_BoxesF.FieldByName('Expression').AsString);
                         Total := Total + 1;
                      end;
                end;
            end;
        end;



    if (cds_BoxesF.FieldByName('Kind').AsInteger = 3) and (Monta <> '') then
       begin
        if buscaRegexp(cds_BoxesF.FieldByName('Expression').AsString,Monta,3) then
           begin
           Filtro.Add(cds_BoxesF.FieldByName('NameRule').AsString+' '+cds_BoxesF.FieldByName('Item').AsString+' match to filter: '+cds_BoxesF.FieldByName('Expression').AsString);
           Total := Total + 1;
           end;
       end;

    GuardaID := cds_BoxesF.FieldByName('ID').AsInteger;
    cds_BoxesF.Next;

   end;



 if not JaFez then
 begin


    if Logica = 'AND' then
     begin
       if Total = Registros then
           Begin
            atualizaboxes(GuardaID);
            Mens.Filtrada     := 5;
            Mens.Selecionada  := 1;
            Mens.ListaNegra   := 1;
            Mens.FiltroResultado.AddStrings(filtro);
            Result := Mens;
           End
           else
           begin
           Registros := 0;
           Total := 0;
           end;

     end
     else
     begin

          if Total > 0 then
           Begin
            atualizaboxes(GuardaID);
            Mens.Filtrada     := 5;
            Mens.Selecionada  := 1;
            Mens.ListaNegra   := 1;
            Mens.FiltroResultado.AddStrings(filtro);
            Result := Mens;
           End
           else
           begin
           Registros := 0;
           Total := 0;
           end;
     end;


 end;

cds_BoxesF.Close;
cds_BoxesF.free;
Filtro.Free;


end;

end;


{$R *.dfm}

end.

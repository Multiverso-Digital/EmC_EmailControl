unit UFiltro_Avancado;

interface
uses
Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,Dialogs,IdMessage,
UCriaObjetos, UDM_Avancado, DB, funcoes;


Function Filtrar_Favoritos_Nao_Grupados(Mens:TMSG):TMSG;
Function Filtrar_Favoritos_Grupados(Mens:TMSG):TMSG;
Function Filtrar_ListaNegra_NaoGrupados(Mens:TMSG):TMSG;
Function Filtrar_ListaNegra_Grupados(Mens:TMSG):TMSG;



implementation


Function Filtrar_Favoritos_Nao_Grupados(Mens:TMSG):TMSG;
var
Monta : string;
DM_Avancado : TDM_Avancado;
begin

DM_Avancado := TDM_Avancado.Create(nil);

Result := Mens;

With dm_avancado do
begin


FiltraBoxes(1,1,0); //Filtro n?o Grupado


 while not cds_Boxes.Eof do
   begin

    Monta := Trim(PegaItensCabec(cds_BoxesItem.AsString, Mens.Headers.Text));

    if (cds_BoxesKind.AsInteger = 1) and (Monta <> '') then
       begin
        Mens.FiltroResultado.Add(cds_BoxesNameRule.AsString+' '+cds_BoxesItem.asstring+' found in this header.');
        Mens.Favorita    := 1;
        Mens.Filtrada    := 144;
        Mens.Selecionada := 0;
        Result := Mens;
        atualizaboxes(cds_BoxesID.AsLargeInt);
        break;
       end;



    if (cds_BoxesKind.AsInteger = 2) and (Monta <> '') then
       begin
        if buscaRegexp(cds_BoxesExpression.asstring,Monta,2) then
           begin
           Mens.FiltroResultado.Add(cds_BoxesNameRule.AsString+' '+cds_BoxesItem.asstring+' match to filter: '+cds_BoxesExpression.asstring);
           Mens.Favorita    := 1;
           Mens.Filtrada    := 144;
           Mens.Selecionada := 0;
           Result := Mens;
           atualizaboxes(cds_BoxesID.AsLargeInt);
           break;
           end;
       end;



    if (cds_BoxesKind.AsInteger = 3) and (Monta <> '') then
       begin
        if buscaRegexp(cds_BoxesExpression.asstring,Monta,3) then
           begin
           Mens.FiltroResultado.Add(cds_BoxesNameRule.AsString+' '+cds_BoxesItem.asstring+' match to filter: '+cds_BoxesExpression.asstring);
           Mens.Favorita    := 1;
           Mens.Filtrada    := 144;
           Mens.Selecionada := 0;
           Result := Mens;
           atualizaboxes(cds_BoxesID.AsLargeInt);
           break;
           end;
       end;
    cds_Boxes.Next;
   end;

DM_Avancado.Free;


end;
end;





Function Filtrar_Favoritos_Grupados(Mens:TMSG):TMSG;
var
Monta, Logica     : string;
IDFilter, Registros  : integer;
Total     : Integer;
GuardaID  : LongInt;
DM_Avancado : TDM_Avancado;
Filtro      : TstringList;
begin

DM_Avancado := TDM_Avancado.Create(nil);

Filtro := TStringList.Create;

Result := Mens;
//Filtros.Clear;

With dm_avancado do
begin


FiltraBoxes(1,1,-1); //Filtro Grupado

IDFilter := cds_BoxesFilterID.AsInteger;
Logica   := cds_BoxesMatchType.AsString;
Registros:= 0;
Total    := 0;

 while not cds_Boxes.Eof do
   begin

    Monta := Trim(PegaItensCabec(cds_BoxesItem.AsString,Mens.Headers.Text));


    If IDFilter <> cds_BoxesFilterID.AsInteger then
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
           atualizaboxes(cds_BoxesID.AsLargeInt);
           Break;
           End
           else
           begin
           Registros := 0;
           Total := 0;
           IDFilter := cds_BoxesFilterID.AsInteger;
           Logica   := cds_BoxesMatchType.AsString;
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
           atualizaboxes(cds_BoxesID.AsLargeInt);
           Break;
           End
           else
           begin
           Registros := 0;
           Total := 0;
           IDFilter := cds_BoxesFilterID.AsInteger;
           Logica   := cds_BoxesMatchType.AsString;
           end;


     end;

    end;

    Registros := Registros + 1;

    if (cds_BoxesKind.AsInteger = 1) and (Monta <> '') then
       begin
        Filtro.add(cds_BoxesNameRule.AsString+' '+cds_BoxesItem.asstring+' found in this header.');
        Total := Total + 1;
       end;

    if (cds_BoxesKind.AsInteger = 2) and (Monta <> '') then
       begin
        if buscaRegexp(cds_BoxesExpression.asstring,Monta,2) then
           begin
           Filtro.add(cds_BoxesNameRule.AsString+' '+cds_BoxesItem.asstring+' match to filter: '+cds_BoxesExpression.asstring+' '+cds_BoxesMatchType.AsString);
           Total := Total + 1;
           end;
       end;

    if (cds_BoxesKind.AsInteger = 3) and (Monta <> '') then
       begin
        if buscaRegexp(cds_BoxesExpression.asstring,Monta,3) then
           begin
           Filtro.add(cds_BoxesNameRule.AsString+' '+cds_BoxesItem.asstring+' match to filter: '+cds_BoxesExpression.asstring+' '+cds_BoxesMatchType.AsString);
           Total := Total + 1;
           end;
       end;

    GuardaID :=  cds_BoxesID.AsLargeInt;
    cds_Boxes.Next;
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
           atualizaboxes(GuardaID);
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


DM_Avancado.Free;
Filtro.Free;


end;

end;






Function Filtrar_ListaNegra_NaoGrupados(Mens:TMSG):TMSG;
var
Monta : string;
DM_Avancado : TDM_Avancado;
begin

DM_Avancado := TDM_Avancado.Create(nil);

Result := Mens;
//Filtros.Clear;

With dm_avancado do
begin


FiltraBoxes(2,1,0); //Filtro n?o Grupado

 while not cds_Boxes.Eof do
   begin

    Monta := Trim(PegaItensCabec(cds_BoxesItem.AsString, Mens.Headers.Text));

    if (cds_BoxesKind.AsInteger = 1) and (Monta <> '') then
       begin
        Mens.FiltroResultado.Add(cds_BoxesNameRule.AsString+' '+cds_BoxesItem.asstring+' found in this header.');
        Mens.Filtrada    := 5;
        Mens.Selecionada := 1;
        Mens.ListaNegra  := 1;
        Result := Mens;
        atualizaboxes(cds_BoxesID.AsLargeInt);
       end;

    if (cds_BoxesKind.AsInteger = 2) and (Monta <> '') then
       begin
        if buscaRegexp(cds_BoxesExpression.asstring,Monta,2) then
           begin
           Mens.FiltroResultado.Add(cds_BoxesNameRule.AsString+' '+cds_BoxesItem.asstring+' match to filter: '+cds_BoxesExpression.asstring);
           Mens.Filtrada    := 5;
           Mens.Selecionada := 1;
           Mens.ListaNegra  := 1;
           Result := Mens;
           atualizaboxes(cds_BoxesID.AsLargeInt);
           end
           else
           begin

             if cds_BoxesItem.AsString = 'Subject:' then
                begin
                      if buscaRegexp(cds_BoxesExpression.asstring, mens.Subject,2) then
                       begin
                        Mens.FiltroResultado.Add(cds_BoxesNameRule.AsString+' '+cds_BoxesItem.asstring+' match to filter: '+cds_BoxesExpression.asstring);
                        Mens.Filtrada    := 5;
                        Mens.Selecionada := 1;
                        Mens.ListaNegra  := 1;
                        Result := Mens;
                        atualizaboxes(cds_BoxesID.AsLargeInt);
                      end;
                end;

             if cds_BoxesItem.AsString = 'From:' then
                begin
                      if buscaRegexp(cds_BoxesExpression.asstring, mens.EmailFrom,2) then
                       begin
                        Mens.FiltroResultado.Add(cds_BoxesNameRule.AsString+' '+cds_BoxesItem.asstring+' match to filter: '+cds_BoxesExpression.asstring);
                        Mens.Filtrada    := 5;
                        Mens.Selecionada := 1;
                        Mens.ListaNegra  := 1;
                        Result := Mens;
                        atualizaboxes(cds_BoxesID.AsLargeInt);
                      end;
                end;
           end;
       end;


    if (cds_BoxesKind.AsInteger = 3) and (Monta <> '') then
       begin
        if buscaRegexp(cds_BoxesExpression.asstring,Monta,3) then
           begin
           Mens.FiltroResultado.Add(cds_BoxesNameRule.AsString+' '+cds_BoxesItem.asstring+' match to filter: '+cds_BoxesExpression.asstring);
           Mens.Filtrada    := 5;
           Mens.Selecionada := 1;
           Mens.ListaNegra  := 1;
           Result := Mens;
           atualizaboxes(cds_BoxesID.AsLargeInt);
           end;
       end;

    cds_Boxes.Next;
   end;



DM_Avancado.Free;





end;






end;







Function Filtrar_ListaNegra_Grupados(Mens:TMSG):TMSG;
var
Monta, Logica        : string;
IDFilter, Registros  : integer;
Total                : Integer;
GuardaID             : LongInt;
DM_Avancado          : TDM_Avancado;
Filtro               : TstringList;
JaFez                : Boolean;
begin

DM_Avancado := TDM_Avancado.Create(nil);

Filtro := TStringList.Create;

Result := Mens;


JaFez := false;

With dm_avancado do
begin


FiltraBoxes(2,1,-1); //Filtro Grupado

IDFilter := cds_BoxesFilterID.AsInteger;
Logica   := cds_BoxesMatchType.AsString;
Registros:= 0;
Total    := 0;

 while not cds_Boxes.Eof do
   begin



    Monta := Trim(PegaItensCabec(cds_BoxesItem.AsString,Mens.Headers.Text));



    If IDFilter <> cds_BoxesFilterID.AsInteger then
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
            atualizaboxes(cds_BoxesID.AsLargeInt);
            JaFez := True;
            Break;
           End
           else
           begin
           Registros := 0;
           Total := 0;
           IDFilter := cds_BoxesFilterID.AsInteger;
           Logica   := cds_BoxesMatchType.AsString;
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
            atualizaboxes(cds_BoxesID.AsLargeInt);
            JaFez := True;
            Break;
           End
           else
           begin
           Registros := 0;
           Total := 0;
           IDFilter := cds_BoxesFilterID.AsInteger;
           Logica   := cds_BoxesMatchType.AsString;
           end;
      end;

    end;



    Registros := Registros + 1;

    if (cds_BoxesKind.AsInteger = 1) and (Monta <> '') then
       begin
       // GravaMark(Cds_MensID.AsInteger, cds_BoxesID.asinteger,0);
       Filtro.Add(cds_BoxesNameRule.AsString+' '+cds_BoxesItem.asstring+' found in this header.');
        Total := Total + 1;
       end;

    if (cds_BoxesKind.AsInteger = 2) and (Monta <> '') then
       begin
        if buscaRegexp(cds_BoxesExpression.asstring,Monta,2) then
           begin
           Filtro.Add(cds_BoxesNameRule.AsString+' '+cds_BoxesItem.asstring+' match to filter: '+cds_BoxesExpression.asstring+' '+cds_BoxesMatchType.AsString);
           Total := Total + 1;
           end
           else
           begin

           if cds_BoxesItem.AsString = 'Subject:' then
                begin
                      if buscaRegexp(cds_BoxesExpression.asstring, Mens.Subject,2) then
                       begin
                        Filtro.Add(cds_BoxesNameRule.AsString+' '+cds_BoxesItem.asstring+' match to filter: '+cds_BoxesExpression.asstring+' '+cds_BoxesMatchType.AsString);
                         Total := Total + 1;
                      end;
                end;

             if cds_BoxesItem.AsString = 'From:' then
                begin
                      if buscaRegexp(cds_BoxesExpression.asstring, Mens.EmailFrom,2) then
                       begin
                        Filtro.Add(cds_BoxesNameRule.AsString+' '+cds_BoxesItem.asstring+' match to filter: '+cds_BoxesExpression.asstring);
                         Total := Total + 1;
                      end;
                end;
            end;
        end;



    if (cds_BoxesKind.AsInteger = 3) and (Monta <> '') then
       begin
        if buscaRegexp(cds_BoxesExpression.asstring,Monta,3) then
           begin
           Filtro.Add(cds_BoxesNameRule.AsString+' '+cds_BoxesItem.asstring+' match to filter: '+cds_BoxesExpression.asstring);
           Total := Total + 1;
           end;
       end;

    GuardaID := cds_BoxesID.AsLargeInt;
    cds_Boxes.Next;

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


DM_Avancado.Free;
Filtro.Free;


end;

end;



end.

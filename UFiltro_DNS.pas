unit UFiltro_DNS;

interface


uses
Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,Dialogs,
udm_dns, IdMessage, IdDNSResolver, JvExControls, JvComCtrls, UCriaObjetos;

Function Filtrar_DNS(Mens:TMSG):TMSG;

implementation

Function Filtrar_DNS(Mens:TMSG):TMSG;
var
DNS     : TIdDNSResolver;
EIP     : TJvIPAddress;
Monta   : String;
Achou   : Boolean;
ErroDNS : Boolean;
I       : Integer;
DM_DNS  : TDM_DNS;
begin

DM_DNS  := TDM_DNS.Create(nil);


DM_DNS.qsetup.Active := true;
DM_DNS.qsetup.first;

DM_DNS.qdns.active := true;
DM_DNS.qdns.first;


result := Mens;


EIP         :=  TJvIPAddress.Create(nil);
DNS         :=  TIdDNSResolver.Create(nil);

DNS.Host    :=  DM_DNS.qsetupIPdns.AsString;
DNS.WaitingTime := 200;
DNS.QueryType := [qtA];
DNS.AllowRecursiveQueries := true;
DNS.Port      := 53;

EIP.ClearAddress;
EIP.Text := Mens.IPSender;
EIP.Update;


monta := inttostr(EIP.AddressValues.Value4)+'.'+inttostr(EIP.AddressValues.Value3)+'.'+inttostr(EIP.AddressValues.Value2)+'.'+inttostr(EIP.AddressValues.Value1);


achou := false;

with DM_DNS do
begin


 while (not qdns.Eof) and (Mens.Filtrada <> 145) do
 begin

 if achou then break;

 errodns := false;

 if qdnsactive.AsInteger = 1 then
  begin
  try
   DNS.Resolve(monta+'.'+qdnsdns.asstring);//'relays.ordb.org');
   except
   errodns:= true;
  end;
        if not errodns then
        begin
          For I:=0 to DNS.QueryResult.Count - 1 do
             begin
                if DNS.QueryResult.Items[i] is TARecord then
                  begin
                    if TARecord(DNS.QueryResult.Items[i]).IPAddress = '127.0.0.2' then
                        begin
                         GravaIPSpam(Mens.IPSender,EIP.Address);
                         Mens.FiltroResultado.Add('SPAM IP:'+Mens.IPSender+' found in '+qdnsName.AsString);
                         Mens.Filtrada     := 145;
                         Mens.Selecionada  := 1;
                         Result := Mens;
                         achou := true;
                         break;
                        end;
                  end;
             end;

        end;
    end;
  qdns.Next;
 end;
end;

try
DNS.Disconnect;
DNS.Free;
EIP.Free;
DM_DNS.Free;
except
end;

end;

end.

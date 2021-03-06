unit UDM_DNS;

interface

uses
  SysUtils, Classes, DB, {DBAccess, MemDS,} UCriaObjetos,IdMessage,
  IdDNSResolver, JvExControls, JvComCtrls, DBClient, MidasLib;

type
  TDM_DNS = class(TDataModule)
  private


    { Private declarations }
  public
  Function GravaIPSpam(IP:String;IPDec:largeInt):Boolean;
  Function Filtrar_DNS(Mens:TMSG):TMSG;
    { Public declarations }
  end;

var
  DM_DNS: TDM_DNS;

implementation

uses UDMServer;



Function TDM_DNS.GravaIPSpam(IP:String;IPDec:largeInt):Boolean;
 var
 CdsIPSpam : TclientDataset;
 begin


 try
 CdsIPSpam := TclientDataset.Create(nil);
 CdsIPSpam.CloneCursor(dm_server.cds_IPSpam_Local,false,false);
 CdsIPSpam.active := true;
 if CdsIPSpam.locate('IPDecimal',IPDEC,[]) then
    begin
     CdsIPSpam.Edit;
     CdsIPSpam.FieldByName('QTD').AsInteger := CdsIPSpam.FieldByName('QTD').AsInteger + 1;
     CdsIPSpam.Post;
    end
    else
    begin
     CdsIPSpam.append;
     CdsIPSpam.FieldByName('IPDecimal').AsInteger := IPDec;
     CdsIPSpam.FieldByName('IP').AsString := IP;
     CdsIPSpam.FieldByName('QTD').AsInteger := 1;
     CdsIPSpam.post;
    end;
 finally
  CdsIPSpam.Free;
 end;

 end;



Function TDM_DNS.Filtrar_DNS(Mens:TMSG):TMSG;
var
DNS     : TIdDNSResolver;
EIP     : TJvIPAddress;
Monta   : String;
Achou   : Boolean;
ErroDNS : Boolean;
I       : Integer;
qdnsT   : TClientDataset;

begin


result := Mens;


try
qdnsT := TClientDataset.Create(nil);
qdnsT.CloneCursor(dm_server.cds_Dns,false,false);
qdnsT.active := true;
qdnsT.first;

EIP         :=  TJvIPAddress.Create(nil);
DNS         :=  TIdDNSResolver.Create(nil);

DNS.Host    :=  DM_Server.IPDns;
DNS.WaitingTime := 200;
DNS.QueryType := [qtA];
DNS.AllowRecursiveQueries := true;
DNS.Port      := 53;

EIP.ClearAddress;
EIP.Text := Mens.IPSender;
EIP.Update;


monta := inttostr(EIP.AddressValues.Value4)+'.'+inttostr(EIP.AddressValues.Value3)+'.'+inttostr(EIP.AddressValues.Value2)+'.'+inttostr(EIP.AddressValues.Value1);


achou := false;


 while (not qdnsT.Eof) and (Mens.Filtrada <> 145) do
 begin

 if achou then break;

 errodns := false;

 if qdnsT.FieldByName('active').AsInteger = 1 then
  begin
  try
   DNS.Resolve(monta+'.'+qdnsT.FieldByName('dns').asstring);//'relays.ordb.org');
   except
   errodns:= true;
  end;

        try

        if not errodns then
        begin

          For I:=0 to DNS.QueryResult.Count - 1 do
             begin
                if DNS.QueryResult.Items[i] is TARecord then
                  begin
                    if TARecord(DNS.QueryResult.Items[i]).IPAddress = '127.0.0.2' then
                        begin
                    //     GravaIPSpam(Mens.IPSender,EIP.Address);
                         Mens.FiltroResultado.Add('SPAM IP:'+Mens.IPSender+' found in '+qdnsT.FieldByName('Name').AsString);
                         Mens.Filtrada     := 145;
                         Mens.Selecionada  := 1;
                         Result := Mens;
                         achou := true;
                         break;
                        end;
                  end;
             end;

        end;

        except
        end;



    end;
  qdnsT.Next;
 end;

finally
DNS.Disconnect;
DNS.Free;
EIP.Free;
qdnsT.Free;
end;
end;


{$R *.dfm}

end.

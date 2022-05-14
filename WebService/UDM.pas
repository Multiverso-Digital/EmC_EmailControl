Unit UDM;

interface

uses SysUtils, Classes, InvokeRegistry, Midas, SOAPMidas, SOAPDm, Provider, DB,
  MemDS, DBAccess, MyAccess, MidasLIB;

type
  IDM = interface(IAppServerSOAP)
    ['{1D37887C-71E7-4AC5-9840-EE50E20EA55C}']
  end;

  TDM = class(TSoapDataModule, IDM, IAppServerSOAP, IAppServer)
    MC: TMyConnection;
    QPais: TMyQuery;
    prov_Qpais: TDataSetProvider;
    QPaissigla: TStringField;
    QPaisPAIS: TStringField;
    QPaisID: TIntegerField;
    QPaisIPNUMFROM: TLargeintField;
    QPaisIPNUMTO: TLargeintField;
  private
  
  public
  
  end;

implementation

{$R *.DFM}



procedure TDMCreateInstance(out obj: TObject);
begin
 obj := TDM.Create(nil);
end;

initialization
   InvRegistry.RegisterInvokableClass(TDM, TDMCreateInstance);
   InvRegistry.RegisterInterface(TypeInfo(IDM));
end.

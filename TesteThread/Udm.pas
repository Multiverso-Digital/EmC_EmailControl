unit Udm;

interface

uses
  SysUtils, Classes, IdMessage, IdAntiFreezeBase, IdAntiFreeze, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase,
  IdMessageClient, IdPOP3, DB, MemDS, DBAccess, MyAccess,
  IdSchedulerOfThreadDefault, IdScheduler, IdSchedulerOfThread,
  IdSchedulerOfThreadPool, IdThreadComponent, Wwdatsrc,


   DBClient, funcoes,  Graphics, Controls, Forms, Dialogs, StdCtrls, ADODB,
  IdIntercept, IdLogBase, IdLogEvent, DAScript, MyScript, IdIOHandler,
  IdIOHandlerSocket, IdIOHandlerStack;



type
  TDM = class(TDataModule)
    MC: TMyConnection;
    POP: TIdPOP3;
    IdAntiFreeze1: TIdAntiFreeze;
    MSG: TIdMessage;
    IDT: TIdThreadComponent;
    IdPool: TIdSchedulerOfThreadPool;
    DataSource1: TDataSource;
    Tmem: TMyQuery;
    TmemID: TLargeintField;
    TmemDT: TDateTimeField;
    TmemEmail: TWideStringField;
    TmemAssunto: TWideStringField;
    TmemEmitente: TWideStringField;
    TmemTama: TIntegerField;
    TmemDatamens: TDateTimeField;
    TmemCabec: TWideMemoField;
    TmemCorpo: TWideMemoField;
    TmemStatus: TIntegerField;
    TmemFiltrada: TIntegerField;
    TmemListaNegra: TIntegerField;
    TmemFavoritos: TIntegerField;
    TmemFiltroResult: TWideMemoField;
    TmemListaNegraResult: TWideMemoField;
    TmemNumeroMens: TIntegerField;
    TmemExcluida: TIntegerField;
    TmemAnexos: TIntegerField;
    Tmemselecionada: TIntegerField;
    TmemConta: TWideStringField;
    TmemMsgId: TWideStringField;
    TmemIsBodyEmpty: TBooleanField;
    TmemUID: TWideStringField;
    TmemIsMsgSinglePartMime: TBooleanField;
    TmemAttachmentEncoding: TWideStringField;
    TmemCharSet: TWideStringField;
    TmemContentType: TWideStringField;
    TmemContentTransferEncoding: TWideStringField;
    TmemContentDisposition: TWideStringField;
    TmemNoEncode: TBooleanField;
    TmemNoDecode: TBooleanField;
    TmemOrganization: TWideStringField;
    TmemDataOrig: TWideStringField;
    TmemXmailer: TWideStringField;
    TmemReplayTO: TWideStringField;
    TmemReturnPath: TWideStringField;
    TmemFromOrig: TWideStringField;
    TmemToOrig: TWideStringField;
    TmemCCOrig: TWideMemoField;
    TmemBCCOrig: TWideMemoField;
    TmemReceivedFrom: TWideStringField;
    TmemFriendResult: TWideMemoField;
    TmemEmailFrom: TWideStringField;
    TmemDominioFrom: TWideStringField;
    TmemIPSender: TWideStringField;
    TmemID_Conta: TIntegerField;
    TmemAnexosFiles: TWideMemoField;
    TmemCountry: TWideStringField;
    Tmemlida: TIntegerField;
    qdns: TMyQuery;
    qdnsactive: TIntegerField;
    qdnsName: TWideStringField;
    qdnsdns: TWideStringField;
    qdnsID: TIntegerField;
    ds_Qdns: TDataSource;
    qVePais: TMyQuery;
    qVePaissigla: TWideStringField;
    qVePaisPAIS: TWideStringField;
    qVePaisID: TIntegerField;
    qVePaisIPNUMFROM: TLargeintField;
    qVePaisIPNUMTO: TLargeintField;
    IdLogEvent1: TIdLogEvent;
    MyScript1: TMyScript;
    IdIOHandlerStack1: TIdIOHandlerStack;
    ClientDataSet2: TClientDataSet;
    ClientDataSet3: TClientDataSet;

  private

    { Private declarations }
  public
    { Public declarations }
    function VePais(NUME: Cardinal): string;
  end;

var
  DM: TDM;

implementation

{$R *.dfm}




Function TDM.VePais(NUME:Cardinal):string;
var
  query : Tmyquery;
begin



  qVePais.Filter := 'pais.IPNUMFROM <= '+inttostr(NUME)+' and pais.IPNUMTO >= '+inttostr(NUME);
  qVePais.Filtered := true;
  if qVePais.recordcount > 0 then
     result := qVePais.FieldByName('PAIS').AsString+'_.'+qVePais.FieldByName('sigla').AsString
     else
     result := 'N�o achou '+inttostr(NUME);


end;

end.

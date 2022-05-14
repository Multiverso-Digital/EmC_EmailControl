unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WideStrings, DBXMySql, FMTBcd, DB, SqlExpr, Grids, Wwdbigrd, Wwdbgrid,
  StdCtrls, wwcheckbox, wwSpeedButton, wwDBNavigator, ExtCtrls, wwclearpanel,
  wwDialog, wwrcdvw, Wwintl, wwrcdpnl, wwdbdatetimepicker;

type
  TForm2 = class(TForm)
    wwDBGrid1: TwwDBGrid;
    MYSQLCONNECTION: TSQLConnection;
    alunos_ef_ligacoes: TSQLDataSet;
    DataSource1: TDataSource;
    alunos_ef_ligacoesFicha: TStringField;
    alunos_ef_ligacoesDigito: TStringField;
    alunos_ef_ligacoesTels: TMemoField;
    alunos_ef_ligacoesOquefalamos: TMemoField;
    alunos_ef_ligacoesdtatu: TSQLTimeStampField;
    alunos_ef_ligacoesquem: TStringField;
    alunos_ef_ligacoesEncerrou1: TIntegerField;
    alunos_ef_ligacoesEncerrou2: TIntegerField;
    alunos_ef_ligacoesEncerrou3: TIntegerField;
    alunos_ef_ligacoesEncerrou4: TIntegerField;
    alunos_ef_ligacoesEncerramento1: TIntegerField;
    alunos_ef_ligacoesEncerramento2: TIntegerField;
    alunos_ef_ligacoesEncerramento3: TIntegerField;
    alunos_ef_ligacoesEncerramento4: TIntegerField;
    alunos_ef_ligacoestipo1: TIntegerField;
    alunos_ef_ligacoestipo2: TIntegerField;
    alunos_ef_ligacoestipo3: TIntegerField;
    alunos_ef_ligacoestipo4: TIntegerField;
    alunos_ef_ligacoesfaleicom1: TStringField;
    alunos_ef_ligacoesfaleicom2: TStringField;
    alunos_ef_ligacoesfaleicom3: TStringField;
    alunos_ef_ligacoesfaleicom4: TStringField;
    alunos_ef_ligacoesligardia1: TDateField;
    alunos_ef_ligacoesligardia2: TDateField;
    alunos_ef_ligacoesligardia3: TDateField;
    alunos_ef_ligacoesligardia4: TDateField;
    alunos_ef_ligacoesprof_infosemi: TIntegerField;
    alunos_ef_ligacoesprof_dadosconfirmados: TIntegerField;
    alunos_ef_ligacoesprof_presencaconfirmada: TIntegerField;
    alunos_ef_ligacoesprof_mandaroficiofaltas: TIntegerField;
    alunos_ef_ligacoesaluno_dadosconfirmados: TIntegerField;
    alunos_ef_ligacoesaluno_presencaconfirmada: TIntegerField;
    alunos_ef_ligacoesaluno_mandaroficio: TIntegerField;
    alunos_ef_ligacoesaluno_mandarautorizacao: TIntegerField;
    alunos_ef_ligacoesligar_pais: TIntegerField;
    alunos_ef_ligacoesligar_diretor: TIntegerField;
    alunos_ef_ligacoesinformou_itinerario: TIntegerField;
    alunos_ef_ligacoesenviou_emailitinerario: TIntegerField;
    alunos_ef_ligacoesinformei_valordeposito: TIntegerField;
    alunos_ef_ligacoesrecebeu_envelope: TIntegerField;
    alunos_ef_ligacoesretirou_deposito: TIntegerField;
    alunos_ef_ligacoesrecebeu_roteiro: TIntegerField;
    alunos_ef_ligacoescomprou_passagens: TIntegerField;
    alunos_ef_ligacoesaluno_problema: TIntegerField;
    alunos_ef_ligacoesproblema_descricao: TMemoField;
    alunos_ef_ligacoesprof_problema: TIntegerField;
    alunos_ef_ligacoesproblema_itinerario: TIntegerField;
    alunos_ef_ligacoesproblema_desc_itinerario: TMemoField;
    alunos_ef_ligacoesproblema_documentos: TIntegerField;
    alunos_ef_ligacoesproblema_desc_docs: TMemoField;
    alunos_ef_ligacoesKM_taxi: TFloatField;
    alunos_ef_ligacoesvalor_taxi: TFloatField;
    alunos_ef_ligacoesvalor_aviao: TFloatField;
    alunos_ef_ligacoesValor_onibus: TFloatField;
    alunos_ef_ligacoesvalor_outros: TFloatField;
    alunos_ef_ligacoesajuda_custo: TFloatField;
    alunos_ef_ligacoesduracao_total: TFloatField;
    alunos_ef_ligacoesKm_total: TFloatField;
    alunos_ef_ligacoesTotal_deposito: TFloatField;
    alunos_ef_ligacoesproblemas_ultimo: TIntegerField;
    alunos_ef_ligacoesproblema_desc_ultimo: TMemoField;
    alunos_ef_ligacoesvalor_extra: TFloatField;
    alunos_ef_ligacoesNome_representante: TStringField;
    alunos_ef_ligacoesRG_representante: TStringField;
    alunos_ef_ligacoesCPF_representante: TStringField;
    alunos_ef_ligacoesBilhetes_OBS: TMemoField;
    alunos_ef_ligacoesoficio_recebido: TDateField;
    alunos_ef_ligacoesProf_falacom_pais: TMemoField;
    alunos_ef_ligacoesProf_falacom_diretor: TMemoField;
    alunos_ef_ligacoesAtende_falacom_pais: TMemoField;
    alunos_ef_ligacoesAtende_falacom_diretor: TMemoField;
    alunos_ef_ligacoesenviar_envelope: TIntegerField;
    alunos_ef_ligacoesenviou_envelope_em: TDateField;
    alunos_ef_ligacoesenviou_envelope: TIntegerField;
    alunos_ef_ligacoesenviou_deposito_em: TDateField;
    alunos_ef_ligacoesenviou_deposito: TIntegerField;
    alunos_ef_ligacoesbilhete_aereo_em: TDateField;
    alunos_ef_ligacoesbilhete_aereo: TIntegerField;
    alunos_ef_ligacoesprof_e_ticket: TStringField;
    alunos_ef_ligacoesaluno_e_ticket: TStringField;
    alunos_ef_ligacoesrepresentante_confirmado: TIntegerField;
    alunos_ef_ligacoesrota_concluida: TIntegerField;
    alunos_ef_ligacoesselecionou: TBooleanField;
    wwCheckBox1: TwwCheckBox;
    wwIntl1: TwwIntl;
    wwRecordViewDialog1: TwwRecordViewDialog;
    wwDBNavigator1: TwwDBNavigator;
    wwDBNavigator1First: TwwNavButton;
    wwDBNavigator1PriorPage: TwwNavButton;
    wwDBNavigator1Prior: TwwNavButton;
    wwDBNavigator1Next: TwwNavButton;
    wwDBNavigator1NextPage: TwwNavButton;
    wwDBNavigator1Last: TwwNavButton;
    wwDBNavigator1Insert: TwwNavButton;
    wwDBNavigator1Delete: TwwNavButton;
    wwDBNavigator1Edit: TwwNavButton;
    wwDBNavigator1Post: TwwNavButton;
    wwDBNavigator1Cancel: TwwNavButton;
    wwDBNavigator1Refresh: TwwNavButton;
    wwDBNavigator1SaveBookmark: TwwNavButton;
    wwDBNavigator1RestoreBookmark: TwwNavButton;
    wwDBDateTimePicker1: TwwDBDateTimePicker;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

end.

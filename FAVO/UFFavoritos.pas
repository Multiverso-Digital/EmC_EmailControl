unit UFFavoritos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, StdCtrls, ExtCtrls, Grids, DBGrids, Buttons, Menus,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdWhois,
  IdHTTP,  WabDefs, WabApi, WabIab, ComCtrls, Registry;

type
  TFFavoritos = class(TForm)
    OpenDialog: TOpenDialog;
    AdrBookListView: TListView;
    DetailListView: TListView;
    Button3: TButton;
    PB: TProgressBar;
    Edit1: TEdit;
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cdsFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure cdsFavoritosFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
    procedure RadioButton4Click(Sender: TObject);
    procedure RadioButton5Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure REmCClick(Sender: TObject);
    procedure RCatalogoClick(Sender: TObject);
    procedure RTextoClick(Sender: TObject);


  private

    FFileName: TFileName;
    FLastDetails: PSPropsArray;
    FLastDetailsCount: Integer;
    FLastDetailID: PSBinary;
    AddrBook: IAddrBook;
    WabObject: IWabObject;




 // procedure Mensagem(NUM:string);
  procedure MontaEmail;
  procedure MontaDominio;
  procedure MontaIP;
  procedure MontaAssunto;
  procedure MontaCabec;
//  Procedure Grava(tipos:integer);
 // Procedure ExcluirFavoritos;
 // Function Dialogo(NUM:string):boolean;
//  Function Veseexiste(Tipo:integer):boolean;
  Procedure MontaCat;
  Procedure MontaLista;

  procedure OpenWabFile(const FileName: TFileName);
  procedure LoadItems(RememberSelected: Boolean);
  procedure CloseWabFile;
  procedure ClearLastDetails;
  procedure FreeSBinary(var P: PSBinary);
  procedure FreeSRowSet(var P: PSRowSet);
  Procedure ImportaCatalogo;
  Procedure ImportaTexto;
  Procedure ImportaEmC;
    { Private declarations }
  public

    { Public declarations }
  end;

var
  FFavoritos: TFFavoritos;
 ListaGrava   : Tstringlist;
  Dire    : string;
  Filtra  : string;
  Usuario : string;
  Tipo    : Integer;
  erro    : boolean;
implementation

uses ComObj, WabTags, WabCode ;

{$R *.dfm}



function GetRegistryData(RootKey: HKEY; Key, Value: string): variant;
var
  Reg: TRegistry;
  RegDataType: TRegDataType;
  DataSize, Len: integer;
  s: string;
label cantread;
begin
  Reg := nil;
  try
    Reg := TRegistry.Create(KEY_QUERY_VALUE);
    Reg.RootKey := RootKey;
    if Reg.OpenKeyReadOnly(Key) then begin
      try
        RegDataType := Reg.GetDataType(Value);
        if (RegDataType = rdString) or
           (RegDataType = rdExpandString) then
          Result := Reg.ReadString(Value)
        else if RegDataType = rdInteger then
          Result := Reg.ReadInteger(Value)
        else if RegDataType = rdBinary then begin
          DataSize := Reg.GetDataSize(Value);
          if DataSize = -1 then goto cantread;
          SetLength(s, DataSize);
          Len := Reg.ReadBinaryData(Value, PChar(s)^, DataSize);
          if Len <> DataSize then goto cantread;
          Result := s;
        end else
cantread:
          raise Exception.Create(SysErrorMessage(ERROR_CANTREAD));
      except
        s := ''; // Deallocates memory if allocated
        Reg.CloseKey;
        raise;
      end;
      Reg.CloseKey;
    end else
      raise Exception.Create(SysErrorMessage(GetLastError));
  except
    Reg.Free;
    raise;
  end;
  Reg.Free;
end;





function SPropValueToStr(PropValue: TSPropValue): string;
var
  LT: TFileTime;
  ST: TSystemTime;
begin
  with PropValue do
    case PROP_TYPE(ulPropTag) of
      PT_TSTRING:
        Result := Value.lpszA;
      PT_BINARY:
        if Value.bin.cb = 4 then
          Result := Format('[Binary - Size: %d bytes] (%.8x)', [Value.bin.cb, PDWORD(Value.bin.lpb)^])
        else
          Result := Format('[Binary - Size: %d bytes]', [Value.bin.cb]);
      PT_I2:
        Result := IntToStr(Value.i);
      PT_LONG:
        Result := IntToStr(Value.l);
      PT_R4:
        Result := FloatToStr(Value.flt);
      PT_DOUBLE:
        Result := FloatToStr(Value.dbl);
      PT_BOOLEAN:
        Result := IntToStr(Value.b);
      PT_SYSTIME:
        begin
          FileTimeToLocalFileTime(Value.ft, LT);
          FileTimeToSystemTime(LT, ST);
          Result := DateTimeToStr(SystemTimeToDateTime(ST));
        end;
      PT_ERROR:
        Result := '';
    else
      Result := Format('[Unknown type %x]', [PROP_TYPE(ulPropTag)]);
    end;
end;

function StrToSPropValue(const TextValue: String; var PropValue: TSPropValue): Boolean;
begin
  Result := True;
  with PropValue do
    case PROP_TYPE(ulPropTag) of
      PT_TSTRING:
        Value.lpszA := PChar(TextValue);
      PT_I2:
        Value.i := StrToInt(TextValue);
      PT_LONG:
        Value.l := StrToInt(TextValue);
      PT_R4:
        Value.flt := StrToFloat(TextValue);
      PT_DOUBLE:
        Value.dbl := StrToFloat(TextValue);
      PT_BOOLEAN:
        Value.b := StrToInt(TextValue);
    else
      Result := False;
    end;
end;

function IsPropSimpleEditable(PropValue: TSPropValue): Boolean;
begin
  case PROP_TYPE(PropValue.ulPropTag) of
    PT_TSTRING, PT_I2, PT_LONG, PT_R4, PT_DOUBLE, PT_BOOLEAN:
      Result := True;
  else
    Result := False;
  end;
end;

function SPropValueToTypeStr(PropValue: TSPropValue): string;
const
  TagNames: array[1..321] of record
    Tag: ULONG;
    Name: PChar
  end = (
    (Tag: PR_ENTRYID; Name: 'ENTRYID'),
    (Tag: PR_OBJECT_TYPE; Name: 'OBJECT_TYPE'),
    (Tag: PR_ICON; Name: 'ICON'),
    (Tag: PR_MINI_ICON; Name: 'MINI_ICON'),
    (Tag: PR_STORE_ENTRYID; Name: 'STORE_ENTRYID'),
    (Tag: PR_STORE_RECORD_KEY; Name: 'STORE_RECORD_KEY'),
    (Tag: PR_RECORD_KEY; Name: 'RECORD_KEY'),
    (Tag: PR_MAPPING_SIGNATURE; Name: 'MAPPING_SIGNATURE'),
    (Tag: PR_ACCESS_LEVEL; Name: 'ACCESS_LEVEL'),
    (Tag: PR_INSTANCE_KEY; Name: 'INSTANCE_KEY'),
    (Tag: PR_ROW_TYPE; Name: 'ROW_TYPE'),
    (Tag: PR_ACCESS; Name: 'ACCESS'),
    (Tag: PR_ROWID; Name: 'ROWID'),
    (Tag: PR_DISPLAY_NAME; Name: 'DISPLAY_NAME'),
    (Tag: PR_DISPLAY_NAME_W; Name: 'DISPLAY_NAME_W'),
    (Tag: PR_DISPLAY_NAME_A; Name: 'DISPLAY_NAME_A'),
    (Tag: PR_ADDRTYPE; Name: 'ADDRTYPE'),
    (Tag: PR_ADDRTYPE_W; Name: 'ADDRTYPE_W'),
    (Tag: PR_ADDRTYPE_A; Name: 'ADDRTYPE_A'),
    (Tag: PR_EMAIL_ADDRESS; Name: 'EMAIL_ADDRESS'),
    (Tag: PR_EMAIL_ADDRESS_W; Name: 'EMAIL_ADDRESS_W'),
    (Tag: PR_EMAIL_ADDRESS_A; Name: 'EMAIL_ADDRESS_A'),
    (Tag: PR_COMMENT; Name: 'COMMENT'),
    (Tag: PR_COMMENT_W; Name: 'COMMENT_W'),
    (Tag: PR_COMMENT_A; Name: 'COMMENT_A'),
    (Tag: PR_DEPTH; Name: 'DEPTH'),
    (Tag: PR_PROVIDER_DISPLAY; Name: 'PROVIDER_DISPLAY'),
    (Tag: PR_PROVIDER_DISPLAY_W; Name: 'PROVIDER_DISPLAY_W'),
    (Tag: PR_PROVIDER_DISPLAY_A; Name: 'PROVIDER_DISPLAY_A'),
    (Tag: PR_CREATION_TIME; Name: 'CREATION_TIME'),
    (Tag: PR_LAST_MODIFICATION_TIME; Name: 'LAST_MODIFICATION_TIME'),
    (Tag: PR_RESOURCE_FLAGS; Name: 'RESOURCE_FLAGS'),
    (Tag: PR_PROVIDER_DLL_NAME; Name: 'PROVIDER_DLL_NAME'),
    (Tag: PR_PROVIDER_DLL_NAME_W; Name: 'PROVIDER_DLL_NAME_W'),
    (Tag: PR_PROVIDER_DLL_NAME_A; Name: 'PROVIDER_DLL_NAME_A'),
    (Tag: PR_SEARCH_KEY; Name: 'SEARCH_KEY'),
    (Tag: PR_PROVIDER_UID; Name: 'PROVIDER_UID'),
    (Tag: PR_PROVIDER_ORDINAL; Name: 'PROVIDER_ORDINAL'),
    (Tag: PR_CONTAINER_FLAGS; Name: 'CONTAINER_FLAGS'),
    (Tag: PR_FOLDER_TYPE; Name: 'FOLDER_TYPE'),
    (Tag: PR_CONTENT_COUNT; Name: 'CONTENT_COUNT'),
    (Tag: PR_CONTENT_UNREAD; Name: 'CONTENT_UNREAD'),
    (Tag: PR_CREATE_TEMPLATES; Name: 'CREATE_TEMPLATES'),
    (Tag: PR_DETAILS_TABLE; Name: 'DETAILS_TABLE'),
    (Tag: PR_SEARCH; Name: 'SEARCH'),
    (Tag: PR_SELECTABLE; Name: 'SELECTABLE'),
    (Tag: PR_SUBFOLDERS; Name: 'SUBFOLDERS'),
    (Tag: PR_STATUS; Name: 'STATUS'),
    (Tag: PR_ANR; Name: 'ANR'),
    (Tag: PR_ANR_W; Name: 'ANR_W'),
    (Tag: PR_ANR_A; Name: 'ANR_A'),
    (Tag: PR_CONTENTS_SORT_ORDER; Name: 'CONTENTS_SORT_ORDER'),
    (Tag: PR_CONTAINER_HIERARCHY; Name: 'CONTAINER_HIERARCHY'),
    (Tag: PR_CONTAINER_CONTENTS; Name: 'CONTAINER_CONTENTS'),
    (Tag: PR_FOLDER_ASSOCIATED_CONTENTS; Name: 'FOLDER_ASSOCIATED_CONTENTS'),
    (Tag: PR_DEF_CREATE_DL; Name: 'DEF_CREATE_DL'),
    (Tag: PR_DEF_CREATE_MAILUSER; Name: 'DEF_CREATE_MAILUSER'),
    (Tag: PR_CONTAINER_CLASS; Name: 'CONTAINER_CLASS'),
    (Tag: PR_CONTAINER_CLASS_W; Name: 'CONTAINER_CLASS_W'),
    (Tag: PR_CONTAINER_CLASS_A; Name: 'CONTAINER_CLASS_A'),
    (Tag: PR_CONTAINER_MODIFY_VERSION; Name: 'CONTAINER_MODIFY_VERSION'),
    (Tag: PR_AB_PROVIDER_ID; Name: 'AB_PROVIDER_ID'),
    (Tag: PR_DEFAULT_VIEW_ENTRYID; Name: 'DEFAULT_VIEW_ENTRYID'),
    (Tag: PR_ASSOC_CONTENT_COUNT; Name: 'ASSOC_CONTENT_COUNT'),
    (Tag: PR_DISPLAY_TYPE; Name: 'DISPLAY_TYPE'),
    (Tag: PR_TEMPLATEID; Name: 'TEMPLATEID'),
    (Tag: PR_PRIMARY_CAPABILITY; Name: 'PRIMARY_CAPABILITY'),
    (Tag: PR_7BIT_DISPLAY_NAME; Name: '7BIT_DISPLAY_NAME'),
    (Tag: PR_ACCOUNT; Name: 'ACCOUNT'),
    (Tag: PR_ACCOUNT_W; Name: 'ACCOUNT_W'),
    (Tag: PR_ACCOUNT_A; Name: 'ACCOUNT_A'),
    (Tag: PR_ALTERNATE_RECIPIENT; Name: 'ALTERNATE_RECIPIENT'),
    (Tag: PR_CALLBACK_TELEPHONE_NUMBER; Name: 'CALLBACK_TELEPHONE_NUMBER'),
    (Tag: PR_CALLBACK_TELEPHONE_NUMBER_W; Name: 'CALLBACK_TELEPHONE_NUMBER_W'),
    (Tag: PR_CALLBACK_TELEPHONE_NUMBER_A; Name: 'CALLBACK_TELEPHONE_NUMBER_A'),
    (Tag: PR_CONVERSION_PROHIBITED; Name: 'CONVERSION_PROHIBITED'),
    (Tag: PR_DISCLOSE_RECIPIENTS; Name: 'DISCLOSE_RECIPIENTS'),
    (Tag: PR_GENERATION; Name: 'GENERATION'),
    (Tag: PR_GENERATION_W; Name: 'GENERATION_W'),
    (Tag: PR_GENERATION_A; Name: 'GENERATION_A'),
    (Tag: PR_GIVEN_NAME; Name: 'GIVEN_NAME'),
    (Tag: PR_GIVEN_NAME_W; Name: 'GIVEN_NAME_W'),
    (Tag: PR_GIVEN_NAME_A; Name: 'GIVEN_NAME_A'),
    (Tag: PR_GOVERNMENT_ID_NUMBER; Name: 'GOVERNMENT_ID_NUMBER'),
    (Tag: PR_GOVERNMENT_ID_NUMBER_W; Name: 'GOVERNMENT_ID_NUMBER_W'),
    (Tag: PR_GOVERNMENT_ID_NUMBER_A; Name: 'GOVERNMENT_ID_NUMBER_A'),
    (Tag: PR_BUSINESS_TELEPHONE_NUMBER; Name: 'BUSINESS_TELEPHONE_NUMBER'),
    (Tag: PR_BUSINESS_TELEPHONE_NUMBER_W; Name: 'BUSINESS_TELEPHONE_NUMBER_W'),
    (Tag: PR_BUSINESS_TELEPHONE_NUMBER_A; Name: 'BUSINESS_TELEPHONE_NUMBER_A'),
    (Tag: PR_OFFICE_TELEPHONE_NUMBER; Name: 'OFFICE_TELEPHONE_NUMBER'),
    (Tag: PR_OFFICE_TELEPHONE_NUMBER_W; Name: 'OFFICE_TELEPHONE_NUMBER_W'),
    (Tag: PR_OFFICE_TELEPHONE_NUMBER_A; Name: 'OFFICE_TELEPHONE_NUMBER_A'),
    (Tag: PR_HOME_TELEPHONE_NUMBER; Name: 'HOME_TELEPHONE_NUMBER'),
    (Tag: PR_HOME_TELEPHONE_NUMBER_W; Name: 'HOME_TELEPHONE_NUMBER_W'),
    (Tag: PR_HOME_TELEPHONE_NUMBER_A; Name: 'HOME_TELEPHONE_NUMBER_A'),
    (Tag: PR_INITIALS; Name: 'INITIALS'),
    (Tag: PR_INITIALS_W; Name: 'INITIALS_W'),
    (Tag: PR_INITIALS_A; Name: 'INITIALS_A'),
    (Tag: PR_KEYWORD; Name: 'KEYWORD'),
    (Tag: PR_KEYWORD_W; Name: 'KEYWORD_W'),
    (Tag: PR_KEYWORD_A; Name: 'KEYWORD_A'),
    (Tag: PR_LANGUAGE; Name: 'LANGUAGE'),
    (Tag: PR_LANGUAGE_W; Name: 'LANGUAGE_W'),
    (Tag: PR_LANGUAGE_A; Name: 'LANGUAGE_A'),
    (Tag: PR_LOCATION; Name: 'LOCATION'),
    (Tag: PR_LOCATION_W; Name: 'LOCATION_W'),
    (Tag: PR_LOCATION_A; Name: 'LOCATION_A'),
    (Tag: PR_MAIL_PERMISSION; Name: 'MAIL_PERMISSION'),
    (Tag: PR_MHS_COMMON_NAME; Name: 'MHS_COMMON_NAME'),
    (Tag: PR_MHS_COMMON_NAME_W; Name: 'MHS_COMMON_NAME_W'),
    (Tag: PR_MHS_COMMON_NAME_A; Name: 'MHS_COMMON_NAME_A'),
    (Tag: PR_ORGANIZATIONAL_ID_NUMBER; Name: 'ORGANIZATIONAL_ID_NUMBER'),
    (Tag: PR_ORGANIZATIONAL_ID_NUMBER_W; Name: 'ORGANIZATIONAL_ID_NUMBER_W'),
    (Tag: PR_ORGANIZATIONAL_ID_NUMBER_A; Name: 'ORGANIZATIONAL_ID_NUMBER_A'),
    (Tag: PR_SURNAME; Name: 'SURNAME'),
    (Tag: PR_SURNAME_W; Name: 'SURNAME_W'),
    (Tag: PR_SURNAME_A; Name: 'SURNAME_A'),
    (Tag: PR_ORIGINAL_ENTRYID; Name: 'ORIGINAL_ENTRYID'),
    (Tag: PR_ORIGINAL_DISPLAY_NAME; Name: 'ORIGINAL_DISPLAY_NAME'),
    (Tag: PR_ORIGINAL_DISPLAY_NAME_W; Name: 'ORIGINAL_DISPLAY_NAME_W'),
    (Tag: PR_ORIGINAL_DISPLAY_NAME_A; Name: 'ORIGINAL_DISPLAY_NAME_A'),
    (Tag: PR_ORIGINAL_SEARCH_KEY; Name: 'ORIGINAL_SEARCH_KEY'),
    (Tag: PR_POSTAL_ADDRESS; Name: 'POSTAL_ADDRESS'),
    (Tag: PR_POSTAL_ADDRESS_W; Name: 'POSTAL_ADDRESS_W'),
    (Tag: PR_POSTAL_ADDRESS_A; Name: 'POSTAL_ADDRESS_A'),
    (Tag: PR_COMPANY_NAME; Name: 'COMPANY_NAME'),
    (Tag: PR_COMPANY_NAME_W; Name: 'COMPANY_NAME_W'),
    (Tag: PR_COMPANY_NAME_A; Name: 'COMPANY_NAME_A'),
    (Tag: PR_TITLE; Name: 'TITLE'),
    (Tag: PR_TITLE_W; Name: 'TITLE_W'),
    (Tag: PR_TITLE_A; Name: 'TITLE_A'),
    (Tag: PR_DEPARTMENT_NAME; Name: 'DEPARTMENT_NAME'),
    (Tag: PR_DEPARTMENT_NAME_W; Name: 'DEPARTMENT_NAME_W'),
    (Tag: PR_DEPARTMENT_NAME_A; Name: 'DEPARTMENT_NAME_A'),
    (Tag: PR_OFFICE_LOCATION; Name: 'OFFICE_LOCATION'),
    (Tag: PR_OFFICE_LOCATION_W; Name: 'OFFICE_LOCATION_W'),
    (Tag: PR_OFFICE_LOCATION_A; Name: 'OFFICE_LOCATION_A'),
    (Tag: PR_PRIMARY_TELEPHONE_NUMBER; Name: 'PRIMARY_TELEPHONE_NUMBER'),
    (Tag: PR_PRIMARY_TELEPHONE_NUMBER_W; Name: 'PRIMARY_TELEPHONE_NUMBER_W'),
    (Tag: PR_PRIMARY_TELEPHONE_NUMBER_A; Name: 'PRIMARY_TELEPHONE_NUMBER_A'),
    (Tag: PR_BUSINESS2_TELEPHONE_NUMBER; Name: 'BUSINESS2_TELEPHONE_NUMBER'),
    (Tag: PR_BUSINESS2_TELEPHONE_NUMBER_W; Name: 'BUSINESS2_TELEPHONE_NUMBER_W'),
    (Tag: PR_BUSINESS2_TELEPHONE_NUMBER_A; Name: 'BUSINESS2_TELEPHONE_NUMBER_A'),
    (Tag: PR_OFFICE2_TELEPHONE_NUMBER; Name: 'OFFICE2_TELEPHONE_NUMBER'),
    (Tag: PR_OFFICE2_TELEPHONE_NUMBER_W; Name: 'OFFICE2_TELEPHONE_NUMBER_W'),
    (Tag: PR_OFFICE2_TELEPHONE_NUMBER_A; Name: 'OFFICE2_TELEPHONE_NUMBER_A'),
    (Tag: PR_MOBILE_TELEPHONE_NUMBER; Name: 'MOBILE_TELEPHONE_NUMBER'),
    (Tag: PR_MOBILE_TELEPHONE_NUMBER_W; Name: 'MOBILE_TELEPHONE_NUMBER_W'),
    (Tag: PR_MOBILE_TELEPHONE_NUMBER_A; Name: 'MOBILE_TELEPHONE_NUMBER_A'),
    (Tag: PR_CELLULAR_TELEPHONE_NUMBER; Name: 'CELLULAR_TELEPHONE_NUMBER'),
    (Tag: PR_CELLULAR_TELEPHONE_NUMBER_W; Name: 'CELLULAR_TELEPHONE_NUMBER_W'),
    (Tag: PR_CELLULAR_TELEPHONE_NUMBER_A; Name: 'CELLULAR_TELEPHONE_NUMBER_A'),
    (Tag: PR_RADIO_TELEPHONE_NUMBER; Name: 'RADIO_TELEPHONE_NUMBER'),
    (Tag: PR_RADIO_TELEPHONE_NUMBER_W; Name: 'RADIO_TELEPHONE_NUMBER_W'),
    (Tag: PR_RADIO_TELEPHONE_NUMBER_A; Name: 'RADIO_TELEPHONE_NUMBER_A'),
    (Tag: PR_CAR_TELEPHONE_NUMBER; Name: 'CAR_TELEPHONE_NUMBER'),
    (Tag: PR_CAR_TELEPHONE_NUMBER_W; Name: 'CAR_TELEPHONE_NUMBER_W'),
    (Tag: PR_CAR_TELEPHONE_NUMBER_A; Name: 'CAR_TELEPHONE_NUMBER_A'),
    (Tag: PR_OTHER_TELEPHONE_NUMBER; Name: 'OTHER_TELEPHONE_NUMBER'),
    (Tag: PR_OTHER_TELEPHONE_NUMBER_W; Name: 'OTHER_TELEPHONE_NUMBER_W'),
    (Tag: PR_OTHER_TELEPHONE_NUMBER_A; Name: 'OTHER_TELEPHONE_NUMBER_A'),
    (Tag: PR_TRANSMITABLE_DISPLAY_NAME; Name: 'TRANSMITABLE_DISPLAY_NAME'),
    (Tag: PR_TRANSMITABLE_DISPLAY_NAME_W; Name: 'TRANSMITABLE_DISPLAY_NAME_W'),
    (Tag: PR_TRANSMITABLE_DISPLAY_NAME_A; Name: 'TRANSMITABLE_DISPLAY_NAME_A'),
    (Tag: PR_PAGER_TELEPHONE_NUMBER; Name: 'PAGER_TELEPHONE_NUMBER'),
    (Tag: PR_PAGER_TELEPHONE_NUMBER_W; Name: 'PAGER_TELEPHONE_NUMBER_W'),
    (Tag: PR_PAGER_TELEPHONE_NUMBER_A; Name: 'PAGER_TELEPHONE_NUMBER_A'),
    (Tag: PR_BEEPER_TELEPHONE_NUMBER; Name: 'BEEPER_TELEPHONE_NUMBER'),
    (Tag: PR_BEEPER_TELEPHONE_NUMBER_W; Name: 'BEEPER_TELEPHONE_NUMBER_W'),
    (Tag: PR_BEEPER_TELEPHONE_NUMBER_A; Name: 'BEEPER_TELEPHONE_NUMBER_A'),
    (Tag: PR_USER_CERTIFICATE; Name: 'USER_CERTIFICATE'),
    (Tag: PR_PRIMARY_FAX_NUMBER; Name: 'PRIMARY_FAX_NUMBER'),
    (Tag: PR_PRIMARY_FAX_NUMBER_W; Name: 'PRIMARY_FAX_NUMBER_W'),
    (Tag: PR_PRIMARY_FAX_NUMBER_A; Name: 'PRIMARY_FAX_NUMBER_A'),
    (Tag: PR_BUSINESS_FAX_NUMBER; Name: 'BUSINESS_FAX_NUMBER'),
    (Tag: PR_BUSINESS_FAX_NUMBER_W; Name: 'BUSINESS_FAX_NUMBER_W'),
    (Tag: PR_BUSINESS_FAX_NUMBER_A; Name: 'BUSINESS_FAX_NUMBER_A'),
    (Tag: PR_HOME_FAX_NUMBER; Name: 'HOME_FAX_NUMBER'),
    (Tag: PR_HOME_FAX_NUMBER_W; Name: 'HOME_FAX_NUMBER_W'),
    (Tag: PR_HOME_FAX_NUMBER_A; Name: 'HOME_FAX_NUMBER_A'),
    (Tag: PR_COUNTRY; Name: 'COUNTRY'),
    (Tag: PR_COUNTRY_W; Name: 'COUNTRY_W'),
    (Tag: PR_COUNTRY_A; Name: 'COUNTRY_A'),
    (Tag: PR_LOCALITY; Name: 'LOCALITY'),
    (Tag: PR_LOCALITY_W; Name: 'LOCALITY_W'),
    (Tag: PR_LOCALITY_A; Name: 'LOCALITY_A'),
    (Tag: PR_STATE_OR_PROVINCE; Name: 'STATE_OR_PROVINCE'),
    (Tag: PR_STATE_OR_PROVINCE_W; Name: 'STATE_OR_PROVINCE_W'),
    (Tag: PR_STATE_OR_PROVINCE_A; Name: 'STATE_OR_PROVINCE_A'),
    (Tag: PR_STREET_ADDRESS; Name: 'STREET_ADDRESS'),
    (Tag: PR_STREET_ADDRESS_W; Name: 'STREET_ADDRESS_W'),
    (Tag: PR_STREET_ADDRESS_A; Name: 'STREET_ADDRESS_A'),
    (Tag: PR_POSTAL_CODE; Name: 'POSTAL_CODE'),
    (Tag: PR_POSTAL_CODE_W; Name: 'POSTAL_CODE_W'),
    (Tag: PR_POSTAL_CODE_A; Name: 'POSTAL_CODE_A'),
    (Tag: PR_POST_OFFICE_BOX; Name: 'POST_OFFICE_BOX'),
    (Tag: PR_POST_OFFICE_BOX_W; Name: 'POST_OFFICE_BOX_W'),
    (Tag: PR_POST_OFFICE_BOX_A; Name: 'POST_OFFICE_BOX_A'),
    (Tag: PR_BUSINESS_ADDRESS_POST_OFFICE_BOX; Name: 'BUSINESS_ADDRESS_POST_OFFICE_BOX'),
    (Tag: PR_BUSINESS_ADDRESS_POST_OFFICE_BOX_W; Name: 'BUSINESS_ADDRESS_POST_OFFICE_BOX_W'),
    (Tag: PR_BUSINESS_ADDRESS_POST_OFFICE_BOX_A; Name: 'BUSINESS_ADDRESS_POST_OFFICE_BOX_A'),
    (Tag: PR_TELEX_NUMBER; Name: 'TELEX_NUMBER'),
    (Tag: PR_TELEX_NUMBER_W; Name: 'TELEX_NUMBER_W'),
    (Tag: PR_TELEX_NUMBER_A; Name: 'TELEX_NUMBER_A'),
    (Tag: PR_ISDN_NUMBER; Name: 'ISDN_NUMBER'),
    (Tag: PR_ISDN_NUMBER_W; Name: 'ISDN_NUMBER_W'),
    (Tag: PR_ISDN_NUMBER_A; Name: 'ISDN_NUMBER_A'),
    (Tag: PR_ASSISTANT_TELEPHONE_NUMBER; Name: 'ASSISTANT_TELEPHONE_NUMBER'),
    (Tag: PR_ASSISTANT_TELEPHONE_NUMBER_W; Name: 'ASSISTANT_TELEPHONE_NUMBER_W'),
    (Tag: PR_ASSISTANT_TELEPHONE_NUMBER_A; Name: 'ASSISTANT_TELEPHONE_NUMBER_A'),
    (Tag: PR_HOME2_TELEPHONE_NUMBER; Name: 'HOME2_TELEPHONE_NUMBER'),
    (Tag: PR_HOME2_TELEPHONE_NUMBER_W; Name: 'HOME2_TELEPHONE_NUMBER_W'),
    (Tag: PR_HOME2_TELEPHONE_NUMBER_A; Name: 'HOME2_TELEPHONE_NUMBER_A'),
    (Tag: PR_ASSISTANT; Name: 'ASSISTANT'),
    (Tag: PR_ASSISTANT_W; Name: 'ASSISTANT_W'),
    (Tag: PR_ASSISTANT_A; Name: 'ASSISTANT_A'),
    (Tag: PR_SEND_RICH_INFO; Name: 'SEND_RICH_INFO'),
    (Tag: PR_WEDDING_ANNIVERSARY; Name: 'WEDDING_ANNIVERSARY'),
    (Tag: PR_BIRTHDAY; Name: 'BIRTHDAY'),
    (Tag: PR_HOBBIES; Name: 'HOBBIES'),
    (Tag: PR_HOBBIES_W; Name: 'HOBBIES_W'),
    (Tag: PR_HOBBIES_A; Name: 'HOBBIES_A'),
    (Tag: PR_MIDDLE_NAME; Name: 'MIDDLE_NAME'),
    (Tag: PR_MIDDLE_NAME_W; Name: 'MIDDLE_NAME_W'),
    (Tag: PR_MIDDLE_NAME_A; Name: 'MIDDLE_NAME_A'),
    (Tag: PR_DISPLAY_NAME_PREFIX; Name: 'DISPLAY_NAME_PREFIX'),
    (Tag: PR_DISPLAY_NAME_PREFIX_W; Name: 'DISPLAY_NAME_PREFIX_W'),
    (Tag: PR_DISPLAY_NAME_PREFIX_A; Name: 'DISPLAY_NAME_PREFIX_A'),
    (Tag: PR_PROFESSION; Name: 'PROFESSION'),
    (Tag: PR_PROFESSION_W; Name: 'PROFESSION_W'),
    (Tag: PR_PROFESSION_A; Name: 'PROFESSION_A'),
    (Tag: PR_PREFERRED_BY_NAME; Name: 'PREFERRED_BY_NAME'),
    (Tag: PR_PREFERRED_BY_NAME_W; Name: 'PREFERRED_BY_NAME_W'),
    (Tag: PR_PREFERRED_BY_NAME_A; Name: 'PREFERRED_BY_NAME_A'),
    (Tag: PR_SPOUSE_NAME; Name: 'SPOUSE_NAME'),
    (Tag: PR_SPOUSE_NAME_W; Name: 'SPOUSE_NAME_W'),
    (Tag: PR_SPOUSE_NAME_A; Name: 'SPOUSE_NAME_A'),
    (Tag: PR_COMPUTER_NETWORK_NAME; Name: 'COMPUTER_NETWORK_NAME'),
    (Tag: PR_COMPUTER_NETWORK_NAME_W; Name: 'COMPUTER_NETWORK_NAME_W'),
    (Tag: PR_COMPUTER_NETWORK_NAME_A; Name: 'COMPUTER_NETWORK_NAME_A'),
    (Tag: PR_CUSTOMER_ID; Name: 'CUSTOMER_ID'),
    (Tag: PR_CUSTOMER_ID_W; Name: 'CUSTOMER_ID_W'),
    (Tag: PR_CUSTOMER_ID_A; Name: 'CUSTOMER_ID_A'),
    (Tag: PR_TTYTDD_PHONE_NUMBER; Name: 'TTYTDD_PHONE_NUMBER'),
    (Tag: PR_TTYTDD_PHONE_NUMBER_W; Name: 'TTYTDD_PHONE_NUMBER_W'),
    (Tag: PR_TTYTDD_PHONE_NUMBER_A; Name: 'TTYTDD_PHONE_NUMBER_A'),
    (Tag: PR_FTP_SITE; Name: 'FTP_SITE'),
    (Tag: PR_FTP_SITE_W; Name: 'FTP_SITE_W'),
    (Tag: PR_FTP_SITE_A; Name: 'FTP_SITE_A'),
    (Tag: PR_GENDER; Name: 'GENDER'),
    (Tag: PR_MANAGER_NAME; Name: 'MANAGER_NAME'),
    (Tag: PR_MANAGER_NAME_W; Name: 'MANAGER_NAME_W'),
    (Tag: PR_MANAGER_NAME_A; Name: 'MANAGER_NAME_A'),
    (Tag: PR_NICKNAME; Name: 'NICKNAME'),
    (Tag: PR_NICKNAME_W; Name: 'NICKNAME_W'),
    (Tag: PR_NICKNAME_A; Name: 'NICKNAME_A'),
    (Tag: PR_PERSONAL_HOME_PAGE; Name: 'PERSONAL_HOME_PAGE'),
    (Tag: PR_PERSONAL_HOME_PAGE_W; Name: 'PERSONAL_HOME_PAGE_W'),
    (Tag: PR_PERSONAL_HOME_PAGE_A; Name: 'PERSONAL_HOME_PAGE_A'),
    (Tag: PR_BUSINESS_HOME_PAGE; Name: 'BUSINESS_HOME_PAGE'),
    (Tag: PR_BUSINESS_HOME_PAGE_W; Name: 'BUSINESS_HOME_PAGE_W'),
    (Tag: PR_BUSINESS_HOME_PAGE_A; Name: 'BUSINESS_HOME_PAGE_A'),
    (Tag: PR_CONTACT_VERSION; Name: 'CONTACT_VERSION'),
    (Tag: PR_CONTACT_ENTRYIDS; Name: 'CONTACT_ENTRYIDS'),
    (Tag: PR_CONTACT_ADDRTYPES; Name: 'CONTACT_ADDRTYPES'),
    (Tag: PR_CONTACT_ADDRTYPES_W; Name: 'CONTACT_ADDRTYPES_W'),
    (Tag: PR_CONTACT_ADDRTYPES_A; Name: 'CONTACT_ADDRTYPES_A'),
    (Tag: PR_CONTACT_DEFAULT_ADDRESS_INDEX; Name: 'CONTACT_DEFAULT_ADDRESS_INDEX'),
    (Tag: PR_CONTACT_EMAIL_ADDRESSES; Name: 'CONTACT_EMAIL_ADDRESSES'),
    (Tag: PR_CONTACT_EMAIL_ADDRESSES_W; Name: 'CONTACT_EMAIL_ADDRESSES_W'),
    (Tag: PR_CONTACT_EMAIL_ADDRESSES_A; Name: 'CONTACT_EMAIL_ADDRESSES_A'),
    (Tag: PR_COMPANY_MAIN_PHONE_NUMBER; Name: 'COMPANY_MAIN_PHONE_NUMBER'),
    (Tag: PR_COMPANY_MAIN_PHONE_NUMBER_W; Name: 'COMPANY_MAIN_PHONE_NUMBER_W'),
    (Tag: PR_COMPANY_MAIN_PHONE_NUMBER_A; Name: 'COMPANY_MAIN_PHONE_NUMBER_A'),
    (Tag: PR_CHILDRENS_NAMES; Name: 'CHILDRENS_NAMES'),
    (Tag: PR_CHILDRENS_NAMES_W; Name: 'CHILDRENS_NAMES_W'),
    (Tag: PR_CHILDRENS_NAMES_A; Name: 'CHILDRENS_NAMES_A'),
    (Tag: PR_HOME_ADDRESS_CITY; Name: 'HOME_ADDRESS_CITY'),
    (Tag: PR_HOME_ADDRESS_CITY_W; Name: 'HOME_ADDRESS_CITY_W'),
    (Tag: PR_HOME_ADDRESS_CITY_A; Name: 'HOME_ADDRESS_CITY_A'),
    (Tag: PR_HOME_ADDRESS_COUNTRY; Name: 'HOME_ADDRESS_COUNTRY'),
    (Tag: PR_HOME_ADDRESS_COUNTRY_W; Name: 'HOME_ADDRESS_COUNTRY_W'),
    (Tag: PR_HOME_ADDRESS_COUNTRY_A; Name: 'HOME_ADDRESS_COUNTRY_A'),
    (Tag: PR_HOME_ADDRESS_POSTAL_CODE; Name: 'HOME_ADDRESS_POSTAL_CODE'),
    (Tag: PR_HOME_ADDRESS_POSTAL_CODE_W; Name: 'HOME_ADDRESS_POSTAL_CODE_W'),
    (Tag: PR_HOME_ADDRESS_POSTAL_CODE_A; Name: 'HOME_ADDRESS_POSTAL_CODE_A'),
    (Tag: PR_HOME_ADDRESS_STATE_OR_PROVINCE; Name: 'HOME_ADDRESS_STATE_OR_PROVINCE'),
    (Tag: PR_HOME_ADDRESS_STATE_OR_PROVINCE_W; Name: 'HOME_ADDRESS_STATE_OR_PROVINCE_W'),
    (Tag: PR_HOME_ADDRESS_STATE_OR_PROVINCE_A; Name: 'HOME_ADDRESS_STATE_OR_PROVINCE_A'),
    (Tag: PR_HOME_ADDRESS_STREET; Name: 'HOME_ADDRESS_STREET'),
    (Tag: PR_HOME_ADDRESS_STREET_W; Name: 'HOME_ADDRESS_STREET_W'),
    (Tag: PR_HOME_ADDRESS_STREET_A; Name: 'HOME_ADDRESS_STREET_A'),
    (Tag: PR_HOME_ADDRESS_POST_OFFICE_BOX; Name: 'HOME_ADDRESS_POST_OFFICE_BOX'),
    (Tag: PR_HOME_ADDRESS_POST_OFFICE_BOX_W; Name: 'HOME_ADDRESS_POST_OFFICE_BOX_W'),
    (Tag: PR_HOME_ADDRESS_POST_OFFICE_BOX_A; Name: 'HOME_ADDRESS_POST_OFFICE_BOX_A'),
    (Tag: PR_OTHER_ADDRESS_CITY; Name: 'OTHER_ADDRESS_CITY'),
    (Tag: PR_OTHER_ADDRESS_CITY_W; Name: 'OTHER_ADDRESS_CITY_W'),
    (Tag: PR_OTHER_ADDRESS_CITY_A; Name: 'OTHER_ADDRESS_CITY_A'),
    (Tag: PR_OTHER_ADDRESS_COUNTRY; Name: 'OTHER_ADDRESS_COUNTRY'),
    (Tag: PR_OTHER_ADDRESS_COUNTRY_W; Name: 'OTHER_ADDRESS_COUNTRY_W'),
    (Tag: PR_OTHER_ADDRESS_COUNTRY_A; Name: 'OTHER_ADDRESS_COUNTRY_A'),
    (Tag: PR_OTHER_ADDRESS_POSTAL_CODE; Name: 'OTHER_ADDRESS_POSTAL_CODE'),
    (Tag: PR_OTHER_ADDRESS_POSTAL_CODE_W; Name: 'OTHER_ADDRESS_POSTAL_CODE_W'),
    (Tag: PR_OTHER_ADDRESS_POSTAL_CODE_A; Name: 'OTHER_ADDRESS_POSTAL_CODE_A'),
    (Tag: PR_OTHER_ADDRESS_STATE_OR_PROVINCE; Name: 'OTHER_ADDRESS_STATE_OR_PROVINCE'),
    (Tag: PR_OTHER_ADDRESS_STATE_OR_PROVINCE_W; Name: 'OTHER_ADDRESS_STATE_OR_PROVINCE_W'),
    (Tag: PR_OTHER_ADDRESS_STATE_OR_PROVINCE_A; Name: 'OTHER_ADDRESS_STATE_OR_PROVINCE_A'),
    (Tag: PR_OTHER_ADDRESS_STREET; Name: 'OTHER_ADDRESS_STREET'),
    (Tag: PR_OTHER_ADDRESS_STREET_W; Name: 'OTHER_ADDRESS_STREET_W'),
    (Tag: PR_OTHER_ADDRESS_STREET_A; Name: 'OTHER_ADDRESS_STREET_A'),
    (Tag: PR_OTHER_ADDRESS_POST_OFFICE_BOX; Name: 'OTHER_ADDRESS_POST_OFFICE_BOX'),
    (Tag: PR_OTHER_ADDRESS_POST_OFFICE_BOX_W; Name: 'OTHER_ADDRESS_POST_OFFICE_BOX_W'),
    (Tag: PR_OTHER_ADDRESS_POST_OFFICE_BOX_A; Name: 'OTHER_ADDRESS_POST_OFFICE_BOX_A'),
    (Tag: PR_USER_X509_CERTIFICATE; Name: 'USER_X509_CERTIFICATE'),
    (Tag: PR_SEND_INTERNET_ENCODING; Name: 'SEND_INTERNET_ENCODING'),
    (Tag: PR_BUSINESS_ADDRESS_CITY; Name: 'BUSINESS_ADDRESS_CITY'),
    (Tag: PR_BUSINESS_ADDRESS_COUNTRY; Name: 'BUSINESS_ADDRESS_COUNTRY'),
    (Tag: PR_BUSINESS_ADDRESS_POSTAL_CODE; Name: 'BUSINESS_ADDRESS_POSTAL_CODE'),
    (Tag: PR_BUSINESS_ADDRESS_STATE_OR_PROVINCE; Name: 'BUSINESS_ADDRESS_STATE_OR_PROVINCE'),
    (Tag: PR_BUSINESS_ADDRESS_STREET; Name: 'BUSINESS_ADDRESS_STREET'),
    (Tag: PR_RECIPIENT_TYPE; Name: 'RECIPIENT_TYPE')
      );
var
  I: Integer;
  PropID: ULONG;
begin
  Result := '';
  PropID := PROP_ID(PropValue.ulPropTag);
  for I := Low(TagNames) to High(TagNames) do
    if PROP_ID(TagNames[I].Tag) = PropID then
    begin
      Result := TagNames[I].Name;
      Break;
    end;
  if Result = '' then Result := Format('[%x]', [PropID]);
end;

const
  imgIndexUser = 11;
  imgIndexDL = 12;


{

function TFFavoritos.Dialogo(NUM:string):boolean;
var
  mensa  : string;
  titulo : string;
{ ButtonSets
     MB_ABORTRETRYIGNORE
     MB_OK     The
     MB_OKCANCEL
     MB_RETRYCANCEL
     MB_YESNO
     MB_YESNOCANCE
  Icons
     MB_ICONEXCLAMATION
     MB_ICONWARNING
     MB_ICONINFORMATION
     MB_ICONASTERISK
     MB_ICONQUESTION
     MB_ICONSTOP
     MB_ICONERROR
     MB_ICONHAND
  Results
     IDABORT
     IDCANCEL
     IDIGNORE
     IDNO
     IDOK
     IDRETRY
     IDYES
more win api helpfile

var
  res : integer;

begin

cds.IndexFieldNames := 'componente;propriedade';
cds.first;
cds.locate('componente;propriedade', vararrayof(['Dialogo', num]), []);

mensa  := cdsmensagem.asstring;
titulo := cdstitulo.asstring;

  res := windows.MessageBox(self.Handle,pchar(mensa),pchar(titulo),MB_YESNO or MB_ICONWARNING);
  if res = IDYes then
    result := true // apertou o botão YES
  else
    result := false;
end;

}




Procedure TFFavoritos.ImportaCatalogo;
begin
Opendialog.FileName := (GetRegistryData(HKEY_CURRENT_USER,'\Software\Microsoft\WAB\WAB4\Wab File Name',''));
FFavoritos.Repaint;
MontaCat;
MontaLista;
edit1.clear;
end;

Procedure TFFavoritos.ImportaTexto;
var
I : integer;
begin

{
If OD.Execute then
begin

RE.Lines.LoadFromFile(od.filename);

pb.Visible := true;
pb.position := 0;
pb.Max := RE.lines.count;

For I:= 0 to RE.lines.count - 1 do
begin

If trim(re.lines[i]) <> '' then
   begin
   edit1.Text := trim(re.lines[i]);
   If pos('@', edit1.Text) > 0 then
   begin
   pb.position := I;
 //  Grava(0);
   FFavoritos.Repaint;
   end;
   end;

end;

pb.position := 0;
pb.Visible := false;
edit1.clear;


end;
 }
end;

Procedure TFFavoritos.ImportaEmC;
var
I : integer;
begin

{
If ODemc.Execute then
begin

RE.Lines.LoadFromFile(odemc.filename);

pb.Visible := true;
pb.position := 0;
pb.Max := RE.lines.count;

For I:= 0 to RE.lines.count - 1 do
begin

If trim(re.lines[i]) <> '' then
   begin
   If copy(re.lines[i],1,3) = 'A= ' then
      begin
      edit1.Text := copy(re.lines[i],4,length(re.lines[i])-3);
  //    Grava(3);
      end
      else
      begin
        If copy(re.lines[i],1,8) = 'E= *EmC*' then
          begin
           edit1.Text := copy(re.lines[i],10,length(re.lines[i])-9);
    //       Grava(1);
          end
          else
          begin
          edit1.Text := copy(re.lines[i],4,length(re.lines[i])-3);
      //    Grava(0);
          end;
      end;
   pb.position := I;
   FFavoritos.Repaint;
   end;

end;

pb.position := 0;
pb.Visible := false;
edit1.Clear;

end;

 }

end;

Procedure TFFavoritos.MontaCat;
begin
If Opendialog.Execute then
begin
OpenWabFile(Opendialog.FileName);
end;
end;


Procedure TFFavoritos.MontaLista;
var
I : integer;
begin
   Pb.Visible := true;
   pb.Position := 0;
   pb.Max := AdrBookListView.Items.Count;
   For I:= 0 to AdrBookListView.Items.Count - 1 do
      begin

        application.ProcessMessages;

        If trim(AdrBookListView.Items[i].SubItems.Text) <> '' then
           begin
           edit1.Text := trim(AdrBookListView.Items[i].SubItems.Text);
           if Listagrava.IndexOf(trim(edit1.Text)) = -1 then
           begin
           ListaGrava.Add(trim(edit1.Text));
           end;
           //Grava(0);
           pb.position := I;
           Ffavoritos.Update;
           end;
      end;

   pb.position := 0;
   pb.Visible := false;

end;

procedure TFFavoritos.FreeSBinary(var P: PSBinary);
begin
  if P = nil then Exit;
  FreeMem(P.lpb);
  Dispose(P);
  P := nil;
end;

procedure TFFavoritos.FreeSRowSet(var P: PSRowSet);
var
  I: Integer;
begin
  for I := 0 to P^.cRows - 1 do
    OleCheck(WabObject.FreeBuffer(P^.aRow[I].lpProps));
  OleCheck(WabObject.FreeBuffer(P));
  P := nil;
end;


procedure TFFavoritos.CloseWabFile;
begin
  with AdrBookListView.Items do
  begin
    BeginUpdate;
    Clear;
    EndUpdate;
  end;
  ClearLastDetails;
  AddrBook := nil;
  WabObject := nil;
  Sleep(0);
end;

procedure TFFavoritos.ClearLastDetails;
begin
  if FLastDetails <> nil then
  begin
    DetailListView.Items.Count := 0;
    OleCheck(WabObject.FreeBuffer(FLastDetails));
    FreeSBinary(FLastDetailID);
    FLastDetails := nil;
    FLastDetailsCount := 0;
  end;
end;


procedure TFFavoritos.OpenWabFile(const FileName: TFileName);
var
  WP: TWabParam;
begin
  CloseWabFile;
  ZeroMemory(@WP, Sizeof(WP));
  WP.cbSize := Sizeof(WP);
  WP.szFileName := PChar(FileName);
  WP.hwnd := Application.Handle;
  OleCheck(WabOpen(AddrBook, WabObject, @WP, 0));
  FFileName := FileName;
  LoadItems(True);
  
end;



procedure TFFavoritos.LoadItems(RememberSelected: Boolean);
const
  TableColumns: record // SizedSPropTagArray macro
    Count: ULONG;
    Definition: array[0..4] of ULONG;
  end = (
    Count: 5;
    Definition:
      (PR_DISPLAY_NAME,
       PR_EMAIL_ADDRESS,
       PR_PERSONAL_HOME_PAGE,
       PR_ENTRYID,
       PR_OBJECT_TYPE);
   );
var
  Container: IABContainer;
  EntryID: PEntryID;
  EntryIDSize, ObjType: ULONG;
  Table: IMAPITable;
  TableRow: PSRowSet;
  EntryIDData: PSBinary;
  Item, LastSelectedItem: TListItem;

function IsLastDetailItem: Boolean;
var
  Res: ULONG;
begin
  Result := (FLastDetailID <> nil) and RememberSelected;
  if not Result then Exit;
  with FLastDetailID^ do
    OleCheck(AddrBook.CompareEntryIDs(EntryIDSize, EntryID, cb, PEntryID(lpb), 0, Res));
  Result := Res <> 0;
end;

begin
  LastSelectedItem := nil;

  OleCheck(AddrBook.GetPAB(EntryIDSize, EntryID));
  OleCheck(AddrBook.OpenEntry(EntryIDSize, EntryID, nil, 0,
    ObjType, IUnknown(Container)));
  OleCheck(WabObject.FreeBuffer(EntryID));

  OleCheck(Container.GetContentsTable(0, Table));
  OleCheck(Table.SetColumns(@TableColumns, 0));
  OleCheck(Table.SeekRow(BOOKMARK_BEGINNING, 0, nil));

  with AdrBookListView do
  begin
    Items.BeginUpdate;
    try
      Items.Clear;
      repeat
        OleCheck(Table.QueryRows(1, 0, TableRow));
        if TableRow.cRows > 0 then with TableRow^.aRow[0] do
        begin
          if ULONG(lpProps[4].Value.l) in [MAPI_MAILUSER, MAPI_DISTLIST] then
          begin
            EntryID := lpProps[3].Value.bin.lpb;
            EntryIDSize := lpProps[3].Value.bin.cb;

            OleCheck(WabObject.AllocateBuffer(Sizeof(TSBinary), Pointer(EntryIDData)));
            OleCheck(WabObject.AllocateMore(EntryIDSize, EntryIDData, Pointer(EntryIDData.lpb)));
            CopyMemory(EntryIDData.lpb, EntryID, EntryIDSize);
            EntryIDData^.cb := EntryIDSize;

            Item := Items.Add;
            with Item do
            begin
              Caption := SPropValueToStr(lpProps[0]);
              SubItems.Add(SPropValueToStr(lpProps[1]));
              SubItems.Add(SPropValueToStr(lpProps[2]));
              Data := EntryIDData;
              case ULONG(lpProps[4].Value.l) of
                MAPI_MAILUSER:
                  ImageIndex := imgIndexUser;
                MAPI_DISTLIST:
                  ImageIndex := imgIndexDL;
              end;
            end;
            if IsLastDetailItem then LastSelectedItem := Item;
          end;
          FreeSRowSet(TableRow);
        end else Break;
      until False;

 //     StatusBar.Panels[0].Text := Format('%d items', [Items.Count]);
      ClearLastDetails;
      Selected := LastSelectedItem;
      if Selected <> nil then Selected.MakeVisible(False);
    finally
      Items.EndUpdate;
    end;
  end;
end;










Procedure TFFavoritos.MontaCabec;
begin

If trim(edit1.Text) = '' then
begin
exit;
end;

//Grava(4);

end;





Procedure TFFavoritos.MontaAssunto;
begin

If trim(edit1.Text) = '' then
begin
exit;
end;

//Grava(3);

end;




Procedure TFFavoritos.MontaIP;
var
I : integer;
monta : string;
begin
{

If trim(edit1.Text) = '' then
begin
exit;
end;

   If trim(edit1.Text) <> '' then
      begin
      If pos('.', edit1.Text) <= 0 then
         begin
         Mensagem('003');
         exit;
         end;
      end;

   monta := trim(edit1.text);
   erro := false;
   For I:= 1 to length(monta) do
   begin
      If not (monta[i]  in ['0'..'9', '.']) then erro := true;
   end;
   if erro then
      begin
      mensagem('003');
      exit;
      end;

Grava(2);

 }
end;







Procedure TFFavoritos.MontaDominio;
begin
{

If trim(edit1.Text) = '' then
begin
exit;
end;

   If trim(edit1.Text) <> '' then
      begin
      If pos('.', edit1.Text) <= 0 then
         begin
         Mensagem('002');
         exit;
         end;
      end;

      If pos('@', edit1.Text) > 0 then
         begin
         Mensagem('002');
         exit;
         end;

     


Grava(1);
  }

end;





Procedure TFFavoritos.MontaEmail;
begin


If trim(edit1.Text) = '' then
begin
exit;
end;

   If trim(edit1.Text) <> '' then
      begin
      If pos('@', edit1.Text) <= 0 then
         begin
      //   Mensagem('001');
         exit;
         end;
      end;


//Grava(0);


end;

{
Procedure TFFavoritos.Mensagem(NUM:string);
begin
cds.IndexFieldNames := 'componente;propriedade';
cds.first;
cds.locate('componente;propriedade', vararrayof(['Mensagem', num]), []);
showmessage(cdsmensagem.asstring);
end;
 }

procedure TFFavoritos.DBGrid1DblClick(Sender: TObject);
begin

//edit1.text := cdsfavoritosConteudo.asstring;

end;

procedure TFFavoritos.FormCreate(Sender: TObject);
begin


ListaGrava := Tstringlist.create;


{


Dire  := ExtractFilePath(Application.ExeName);
confi := Tstringlist.create;
confi.LoadFromFile(dire+'Conf\Emc.ini');
Filtra  := confi.strings[0];
Usuario := confi.strings[1];
if cds.Active then cds.active := false;
cds.FileName := dire+'Dados\'+confi.strings[0]+'.cds';
cds.active := true;

cdsfavoritos.FileName := (dire+'dados\Favoritos.cds');

cds.Open;
cds.Filtered := true;
cds.IndexFieldNames := 'componente';
cds.first;
for I:= 0 to ComponentCount - 1 do
   begin
   If  cds.locate('componente', Components[I].Name, []) then
       begin
        If (components[i] is TRadiobutton)   then  (components[i] as TRadiobutton).Caption    := cdsmensagem.asstring;
         If (components[i] is Tlabel)      then  (components[i] as Tlabel).Caption       := cdsmensagem.asstring;
         If (components[i] is TGroupbox)   then  (components[i] as TGroupbox).Caption    := cdsmensagem.asstring;
//         If (components[i] is TTabsheet)   then  (components[i] as TTabsheet).Caption    := cdsmensagem.asstring;
        If (components[i] is Tbutton)     then  (components[i] as Tbutton).Caption      := cdsmensagem.asstring;
         If (components[i] is Tbitbtn)     then  (components[i] as Tbitbtn).Caption      := cdsmensagem.asstring;
         If (components[i] is TRadioGroup) then  (components[i] as TRadioGroup).Caption  := cdsmensagem.asstring;
       end;
   end;


If not cdsfavoritos.active then cdsfavoritos.active := true;
//Radiobutton1click(self);

 }

end;

procedure TFFavoritos.cdsFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
//accept := (cdsidioma.asstring = filtra) and (cdsform.AsString = 'FFavoritos')
end;

procedure TFFavoritos.cdsFavoritosFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
//accept := (cdsfavoritosUsuario.asstring = Usuario) and (cdsfavoritosTipo.asinteger = Tipo);
end;

procedure TFFavoritos.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
dire : string;
begin


dire := ExtractFilePath(Application.ExeName);

try
Listagrava.SaveToFile(dire+'@EmCFavoritos.ini');
ListaGrava.Free;
DetailListView.Destroy;
AdrBookListView.Destroy;
except
end;

end;

procedure TFFavoritos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
try
//action := cafree;
except
end;
end;

procedure TFFavoritos.RadioButton1Click(Sender: TObject);
begin
{
Tipo := 0;
panel1.Caption := RadioButton1.Caption;
cdsfavoritos.Filtered := false;
cdsfavoritos.first;
cdsfavoritos.Filtered := true;
cdsfavoritos.first;
 }
end;

procedure TFFavoritos.RadioButton2Click(Sender: TObject);
begin
{
Tipo := 1;
panel1.Caption := RadioButton2.Caption;
cdsfavoritos.Filtered := false;
cdsfavoritos.first;
cdsfavoritos.Filtered := true;
cdsfavoritos.first;
 }


end;

procedure TFFavoritos.RadioButton3Click(Sender: TObject);
begin
{
Tipo := 2;
panel1.Caption := RadioButton3.Caption;
cdsfavoritos.Filtered := false;
cdsfavoritos.first;
cdsfavoritos.Filtered := true;
cdsfavoritos.first;
}



end;

procedure TFFavoritos.RadioButton4Click(Sender: TObject);
begin
{
Tipo := 3;
panel1.Caption := RadioButton4.Caption;
cdsfavoritos.Filtered := false;
cdsfavoritos.first;
cdsfavoritos.Filtered := true;
cdsfavoritos.first;
}
end;

procedure TFFavoritos.RadioButton5Click(Sender: TObject);
begin
{
Tipo := 4;
panel1.Caption := RadioButton5.Caption;
cdsfavoritos.Filtered := false;
cdsfavoritos.first;
cdsfavoritos.Filtered := true;
cdsfavoritos.first;
 }
end;

procedure TFFavoritos.FormShow(Sender: TObject);
begin

{
Cds.locate('componente', 'FFavoritos', []);
FFavoritos.Caption := cdsmensagem.asstring;
FFavoritos.Repaint;
}




end;

procedure TFFavoritos.Button2Click(Sender: TObject);
begin

 {
If tipo = 0 then montaemail; //email
If tipo = 1 then montadominio; //dominio
If tipo = 2 then montaIP; //IP
If tipo = 3 then montaAssunto; //IP
If tipo = 4 then montaCabec; //IP
  }

end;

procedure TFFavoritos.SpeedButton1Click(Sender: TObject);
begin

{
memo1.lines.text := IdHTTP1.Get('http://network-tools.com/default.asp?prog=lookup&Netnic=whois.arin.net&host=201.6.194.229');
exit;
IdWhois1.Host := 'whois.arin.net';
memo1.lines.text := IdWhois1.WhoIs(trim(edit1.Text));
}
end;

procedure TFFavoritos.Button1Click(Sender: TObject);
begin

//ExcluirFavoritos;


end;

procedure TFFavoritos.BitBtn3Click(Sender: TObject);
begin
ImportaCatalogo;
end;

procedure TFFavoritos.BitBtn1Click(Sender: TObject);
begin
ImportaTexto;

end;

procedure TFFavoritos.REmCClick(Sender: TObject);
begin

//ImportaEmC;

end;

procedure TFFavoritos.RCatalogoClick(Sender: TObject);
begin

ListaGrava.Clear;
FFavoritos.Update;
ImportaCatalogo;
Close;

 
end;

procedure TFFavoritos.RTextoClick(Sender: TObject);
begin
ImportaTexto;
end;

end.

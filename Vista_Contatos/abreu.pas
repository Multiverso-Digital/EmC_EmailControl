
{********************************************}
{                                            }
{              XML Data Binding              }
{                                            }
{         Generated on: 17/2/2009 12:07:26   }
{       Generated from: C:\@DELL\abreu.xml   }
{   Settings stored in: C:\@DELL\abreu.xdb   }
{                                            }
{********************************************}

unit abreu;

interface

uses xmldom, XMLDoc, XMLIntf;

type

{ Forward Decls }

  IXMLContactType = interface;
  IXMLExtendedType = interface;
  IXMLContactIDCollectionType = interface;
  IXMLContactIDType = interface;
  IXMLNameCollectionType = interface;
  IXMLNameType = interface;
  IXMLGivenNameType = interface;
  IXMLPhotoCollectionType = interface;
  IXMLPhotoType = interface;
  IXMLValueType = interface;
  IXMLLabelCollectionType = interface;
  IXMLLabelType = interface;
  IXMLEmailAddressCollectionType = interface;
  IXMLEmailAddressType = interface;
  IXMLType_ = interface;
  IXMLAddressType = interface;
  IXMLEmailAddressType2 = interface;

{ IXMLContactType }

  IXMLContactType = interface(IXMLNode)
    ['{437AAB88-08B6-4AA3-8AF6-D733D5EEF25C}']
    { Property Accessors }
    function Get_Version: Integer;
    function Get_CreationDate: WideString;
    function Get_Extended: IXMLExtendedType;
    function Get_ContactIDCollection: IXMLContactIDCollectionType;
    function Get_NameCollection: IXMLNameCollectionType;
    function Get_PhotoCollection: IXMLPhotoCollectionType;
    function Get_EmailAddressCollection: IXMLEmailAddressCollectionType;
    procedure Set_Version(Value: Integer);
    procedure Set_CreationDate(Value: WideString);
    { Methods & Properties }
    property Version: Integer read Get_Version write Set_Version;
    property CreationDate: WideString read Get_CreationDate write Set_CreationDate;
    property Extended: IXMLExtendedType read Get_Extended;
    property ContactIDCollection: IXMLContactIDCollectionType read Get_ContactIDCollection;
    property NameCollection: IXMLNameCollectionType read Get_NameCollection;
    property PhotoCollection: IXMLPhotoCollectionType read Get_PhotoCollection;
    property EmailAddressCollection: IXMLEmailAddressCollectionType read Get_EmailAddressCollection;
  end;

{ IXMLExtendedType }

  IXMLExtendedType = interface(IXMLNode)
    ['{632BF3F3-7A7A-441C-BCDB-B7E636781FFE}']
    { Property Accessors }
    function Get_Nil_: WideString;
    procedure Set_Nil_(Value: WideString);
    { Methods & Properties }
    property Nil_: WideString read Get_Nil_ write Set_Nil_;
  end;

{ IXMLContactIDCollectionType }

  IXMLContactIDCollectionType = interface(IXMLNode)
    ['{E28558DB-A8DE-4FE8-AE49-3FA1C2DC9563}']
    { Property Accessors }
    function Get_ContactID: IXMLContactIDType;
    { Methods & Properties }
    property ContactID: IXMLContactIDType read Get_ContactID;
  end;

{ IXMLContactIDType }

  IXMLContactIDType = interface(IXMLNode)
    ['{CDBA06F7-47D7-4D01-B7A7-25B1B0136C6D}']
    { Property Accessors }
    function Get_ElementID: WideString;
    function Get_Value: WideString;
    procedure Set_ElementID(Value: WideString);
    procedure Set_Value(Value: WideString);
    { Methods & Properties }
    property ElementID: WideString read Get_ElementID write Set_ElementID;
    property Value: WideString read Get_Value write Set_Value;
  end;

{ IXMLNameCollectionType }

  IXMLNameCollectionType = interface(IXMLNode)
    ['{447B59CD-3082-48E0-9773-97D0B4B446E0}']
    { Property Accessors }
    function Get_Name: IXMLNameType;
    { Methods & Properties }
    property Name: IXMLNameType read Get_Name;
  end;

{ IXMLNameType }

  IXMLNameType = interface(IXMLNode)
    ['{A9DE996F-EB29-48B5-B575-F9C4CB17A5FF}']
    { Property Accessors }
    function Get_ElementID: WideString;
    function Get_GivenName: IXMLGivenNameType;
    function Get_FormattedName: WideString;
    procedure Set_ElementID(Value: WideString);
    procedure Set_FormattedName(Value: WideString);
    { Methods & Properties }
    property ElementID: WideString read Get_ElementID write Set_ElementID;
    property GivenName: IXMLGivenNameType read Get_GivenName;
    property FormattedName: WideString read Get_FormattedName write Set_FormattedName;
  end;

{ IXMLGivenNameType }

  IXMLGivenNameType = interface(IXMLNode)
    ['{C049BBE0-E2C1-4475-8A74-7612009713B6}']
    { Property Accessors }
    function Get_Version: Integer;
    function Get_ModificationDate: WideString;
    procedure Set_Version(Value: Integer);
    procedure Set_ModificationDate(Value: WideString);
    { Methods & Properties }
    property Version: Integer read Get_Version write Set_Version;
    property ModificationDate: WideString read Get_ModificationDate write Set_ModificationDate;
  end;

{ IXMLPhotoCollectionType }

  IXMLPhotoCollectionType = interface(IXMLNode)
    ['{BECE3181-EBF5-4406-A623-214CEA9F5912}']
    { Property Accessors }
    function Get_Version: Integer;
    function Get_ModificationDate: WideString;
    function Get_Photo: IXMLPhotoType;
    procedure Set_Version(Value: Integer);
    procedure Set_ModificationDate(Value: WideString);
    { Methods & Properties }
    property Version: Integer read Get_Version write Set_Version;
    property ModificationDate: WideString read Get_ModificationDate write Set_ModificationDate;
    property Photo: IXMLPhotoType read Get_Photo;
  end;

{ IXMLPhotoType }

  IXMLPhotoType = interface(IXMLNode)
    ['{88DB34EF-0EDE-4E2D-9086-FC08C10867E0}']
    { Property Accessors }
    function Get_ElementID: WideString;
    function Get_Version: Integer;
    function Get_ModificationDate: WideString;
    function Get_Value: IXMLValueType;
    function Get_LabelCollection: IXMLLabelCollectionType;
    procedure Set_ElementID(Value: WideString);
    procedure Set_Version(Value: Integer);
    procedure Set_ModificationDate(Value: WideString);
    { Methods & Properties }
    property ElementID: WideString read Get_ElementID write Set_ElementID;
    property Version: Integer read Get_Version write Set_Version;
    property ModificationDate: WideString read Get_ModificationDate write Set_ModificationDate;
    property Value: IXMLValueType read Get_Value;
    property LabelCollection: IXMLLabelCollectionType read Get_LabelCollection;
  end;

{ IXMLValueType }

  IXMLValueType = interface(IXMLNode)
    ['{5944A0DF-35E8-45D2-A3D7-DE1C2DA74013}']
    { Property Accessors }
    function Get_ContentType: WideString;
    function Get_Version: Integer;
    function Get_ModificationDate: WideString;
    procedure Set_ContentType(Value: WideString);
    procedure Set_Version(Value: Integer);
    procedure Set_ModificationDate(Value: WideString);
    { Methods & Properties }
    property ContentType: WideString read Get_ContentType write Set_ContentType;
    property Version: Integer read Get_Version write Set_Version;
    property ModificationDate: WideString read Get_ModificationDate write Set_ModificationDate;
  end;

{ IXMLLabelCollectionType }

  IXMLLabelCollectionType = interface(IXMLNode)
    ['{5FE803CC-55EF-4EB9-8734-C1FC7884A069}']
    { Property Accessors }
    function Get_Label_: IXMLLabelType;
    { Methods & Properties }
    property Label_: IXMLLabelType read Get_Label_;
  end;

{ IXMLLabelType }

  IXMLLabelType = interface(IXMLNode)
    ['{22419A95-2403-40D7-B273-067446878197}']
    { Property Accessors }
    function Get_Version: Integer;
    function Get_ModificationDate: WideString;
    procedure Set_Version(Value: Integer);
    procedure Set_ModificationDate(Value: WideString);
    { Methods & Properties }
    property Version: Integer read Get_Version write Set_Version;
    property ModificationDate: WideString read Get_ModificationDate write Set_ModificationDate;
  end;

{ IXMLEmailAddressCollectionType }

  IXMLEmailAddressCollectionType = interface(IXMLNodeCollection)
    ['{56F345FF-C0CC-49F6-AAD1-11C0E2589BAC}']
    { Property Accessors }
    function Get_Version: Integer;
    function Get_ModificationDate: WideString;
    function Get_EmailAddress(Index: Integer): IXMLEmailAddressType;
    procedure Set_Version(Value: Integer);
    procedure Set_ModificationDate(Value: WideString);
    { Methods & Properties }
    function Add: IXMLEmailAddressType;
    function Insert(const Index: Integer): IXMLEmailAddressType;
    property Version: Integer read Get_Version write Set_Version;
    property ModificationDate: WideString read Get_ModificationDate write Set_ModificationDate;
    property EmailAddress[Index: Integer]: IXMLEmailAddressType read Get_EmailAddress; default;
  end;

{ IXMLEmailAddressType }

  IXMLEmailAddressType = interface(IXMLNode)
    ['{96451BF1-0DA7-47E5-A376-1AF63387D7B7}']
    { Property Accessors }
    function Get_ElementID: WideString;
    function Get_Version: Integer;
    function Get_ModificationDate: WideString;
    function Get_Type_: IXMLType_;
    function Get_Address: IXMLAddressType;
    function Get_LabelCollection: IXMLLabelCollectionType;
    procedure Set_ElementID(Value: WideString);
    procedure Set_Version(Value: Integer);
    procedure Set_ModificationDate(Value: WideString);
    { Methods & Properties }
    property ElementID: WideString read Get_ElementID write Set_ElementID;
    property Version: Integer read Get_Version write Set_Version;
    property ModificationDate: WideString read Get_ModificationDate write Set_ModificationDate;
    property Type_: IXMLType_ read Get_Type_;
    property Address: IXMLAddressType read Get_Address;
    property LabelCollection: IXMLLabelCollectionType read Get_LabelCollection;
  end;

{ IXMLType_ }

  IXMLType_ = interface(IXMLNode)
    ['{42B7A8F2-D30F-4F3F-B798-9C0B95C74FA5}']
    { Property Accessors }
    function Get_Version: Integer;
    function Get_ModificationDate: WideString;
    procedure Set_Version(Value: Integer);
    procedure Set_ModificationDate(Value: WideString);
    { Methods & Properties }
    property Version: Integer read Get_Version write Set_Version;
    property ModificationDate: WideString read Get_ModificationDate write Set_ModificationDate;
  end;

{ IXMLAddressType }

  IXMLAddressType = interface(IXMLNode)
    ['{45DAA74E-02AE-479C-8672-FE6612291199}']
    { Property Accessors }
    function Get_Version: Integer;
    function Get_ModificationDate: WideString;
    procedure Set_Version(Value: Integer);
    procedure Set_ModificationDate(Value: WideString);
    { Methods & Properties }
    property Version: Integer read Get_Version write Set_Version;
    property ModificationDate: WideString read Get_ModificationDate write Set_ModificationDate;
  end;

{ IXMLEmailAddressType2 }

  IXMLEmailAddressType2 = interface(IXMLNode)
    ['{B27FF171-6843-4BDE-978A-B69210F49206}']
    { Property Accessors }
    function Get_ElementID: WideString;
    function Get_Nil_: WideString;
    function Get_Version: Integer;
    function Get_ModificationDate: WideString;
    procedure Set_ElementID(Value: WideString);
    procedure Set_Nil_(Value: WideString);
    procedure Set_Version(Value: Integer);
    procedure Set_ModificationDate(Value: WideString);
    { Methods & Properties }
    property ElementID: WideString read Get_ElementID write Set_ElementID;
    property Nil_: WideString read Get_Nil_ write Set_Nil_;
    property Version: Integer read Get_Version write Set_Version;
    property ModificationDate: WideString read Get_ModificationDate write Set_ModificationDate;
  end;

{ Forward Decls }

  TXMLContactType = class;
  TXMLExtendedType = class;
  TXMLContactIDCollectionType = class;
  TXMLContactIDType = class;
  TXMLNameCollectionType = class;
  TXMLNameType = class;
  TXMLGivenNameType = class;
  TXMLPhotoCollectionType = class;
  TXMLPhotoType = class;
  TXMLValueType = class;
  TXMLLabelCollectionType = class;
  TXMLLabelType = class;
  TXMLEmailAddressCollectionType = class;
  TXMLEmailAddressType = class;
  TXMLType_ = class;
  TXMLAddressType = class;
  TXMLEmailAddressType2 = class;

{ TXMLContactType }

  TXMLContactType = class(TXMLNode, IXMLContactType)
  protected
    { IXMLContactType }
    function Get_Version: Integer;
    function Get_CreationDate: WideString;
    function Get_Extended: IXMLExtendedType;
    function Get_ContactIDCollection: IXMLContactIDCollectionType;
    function Get_NameCollection: IXMLNameCollectionType;
    function Get_PhotoCollection: IXMLPhotoCollectionType;
    function Get_EmailAddressCollection: IXMLEmailAddressCollectionType;
    procedure Set_Version(Value: Integer);
    procedure Set_CreationDate(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLExtendedType }

  TXMLExtendedType = class(TXMLNode, IXMLExtendedType)
  protected
    { IXMLExtendedType }
    function Get_Nil_: WideString;
    procedure Set_Nil_(Value: WideString);
  end;

{ TXMLContactIDCollectionType }

  TXMLContactIDCollectionType = class(TXMLNode, IXMLContactIDCollectionType)
  protected
    { IXMLContactIDCollectionType }
    function Get_ContactID: IXMLContactIDType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLContactIDType }

  TXMLContactIDType = class(TXMLNode, IXMLContactIDType)
  protected
    { IXMLContactIDType }
    function Get_ElementID: WideString;
    function Get_Value: WideString;
    procedure Set_ElementID(Value: WideString);
    procedure Set_Value(Value: WideString);
  end;

{ TXMLNameCollectionType }

  TXMLNameCollectionType = class(TXMLNode, IXMLNameCollectionType)
  protected
    { IXMLNameCollectionType }
    function Get_Name: IXMLNameType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLNameType }

  TXMLNameType = class(TXMLNode, IXMLNameType)
  protected
    { IXMLNameType }
    function Get_ElementID: WideString;
    function Get_GivenName: IXMLGivenNameType;
    function Get_FormattedName: WideString;
    procedure Set_ElementID(Value: WideString);
    procedure Set_FormattedName(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLGivenNameType }

  TXMLGivenNameType = class(TXMLNode, IXMLGivenNameType)
  protected
    { IXMLGivenNameType }
    function Get_Version: Integer;
    function Get_ModificationDate: WideString;
    procedure Set_Version(Value: Integer);
    procedure Set_ModificationDate(Value: WideString);
  end;

{ TXMLPhotoCollectionType }

  TXMLPhotoCollectionType = class(TXMLNode, IXMLPhotoCollectionType)
  protected
    { IXMLPhotoCollectionType }
    function Get_Version: Integer;
    function Get_ModificationDate: WideString;
    function Get_Photo: IXMLPhotoType;
    procedure Set_Version(Value: Integer);
    procedure Set_ModificationDate(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLPhotoType }

  TXMLPhotoType = class(TXMLNode, IXMLPhotoType)
  protected
    { IXMLPhotoType }
    function Get_ElementID: WideString;
    function Get_Version: Integer;
    function Get_ModificationDate: WideString;
    function Get_Value: IXMLValueType;
    function Get_LabelCollection: IXMLLabelCollectionType;
    procedure Set_ElementID(Value: WideString);
    procedure Set_Version(Value: Integer);
    procedure Set_ModificationDate(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLValueType }

  TXMLValueType = class(TXMLNode, IXMLValueType)
  protected
    { IXMLValueType }
    function Get_ContentType: WideString;
    function Get_Version: Integer;
    function Get_ModificationDate: WideString;
    procedure Set_ContentType(Value: WideString);
    procedure Set_Version(Value: Integer);
    procedure Set_ModificationDate(Value: WideString);
  end;

{ TXMLLabelCollectionType }

  TXMLLabelCollectionType = class(TXMLNode, IXMLLabelCollectionType)
  protected
    { IXMLLabelCollectionType }
    function Get_Label_: IXMLLabelType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLLabelType }

  TXMLLabelType = class(TXMLNode, IXMLLabelType)
  protected
    { IXMLLabelType }
    function Get_Version: Integer;
    function Get_ModificationDate: WideString;
    procedure Set_Version(Value: Integer);
    procedure Set_ModificationDate(Value: WideString);
  end;

{ TXMLEmailAddressCollectionType }

  TXMLEmailAddressCollectionType = class(TXMLNodeCollection, IXMLEmailAddressCollectionType)
  protected
    { IXMLEmailAddressCollectionType }
    function Get_Version: Integer;
    function Get_ModificationDate: WideString;
    function Get_EmailAddress(Index: Integer): IXMLEmailAddressType;
    procedure Set_Version(Value: Integer);
    procedure Set_ModificationDate(Value: WideString);
    function Add: IXMLEmailAddressType;
    function Insert(const Index: Integer): IXMLEmailAddressType;
  public
    procedure AfterConstruction; override;
  end;

{ TXMLEmailAddressType }

  TXMLEmailAddressType = class(TXMLNode, IXMLEmailAddressType)
  protected
    { IXMLEmailAddressType }
    function Get_ElementID: WideString;
    function Get_Version: Integer;
    function Get_ModificationDate: WideString;
    function Get_Type_: IXMLType_;
    function Get_Address: IXMLAddressType;
    function Get_LabelCollection: IXMLLabelCollectionType;
    procedure Set_ElementID(Value: WideString);
    procedure Set_Version(Value: Integer);
    procedure Set_ModificationDate(Value: WideString);
  public
    procedure AfterConstruction; override;
  end;

{ TXMLType_ }

  TXMLType_ = class(TXMLNode, IXMLType_)
  protected
    { IXMLType_ }
    function Get_Version: Integer;
    function Get_ModificationDate: WideString;
    procedure Set_Version(Value: Integer);
    procedure Set_ModificationDate(Value: WideString);
  end;

{ TXMLAddressType }

  TXMLAddressType = class(TXMLNode, IXMLAddressType)
  protected
    { IXMLAddressType }
    function Get_Version: Integer;
    function Get_ModificationDate: WideString;
    procedure Set_Version(Value: Integer);
    procedure Set_ModificationDate(Value: WideString);
  end;

{ TXMLEmailAddressType2 }

  TXMLEmailAddressType2 = class(TXMLNode, IXMLEmailAddressType2)
  protected
    { IXMLEmailAddressType2 }
    function Get_ElementID: WideString;
    function Get_Nil_: WideString;
    function Get_Version: Integer;
    function Get_ModificationDate: WideString;
    procedure Set_ElementID(Value: WideString);
    procedure Set_Nil_(Value: WideString);
    procedure Set_Version(Value: Integer);
    procedure Set_ModificationDate(Value: WideString);
  end;

implementation

{ TXMLContactType }

procedure TXMLContactType.AfterConstruction;
begin
  RegisterChildNode('Extended', TXMLExtendedType);
  RegisterChildNode('ContactIDCollection', TXMLContactIDCollectionType);
  RegisterChildNode('NameCollection', TXMLNameCollectionType);
  RegisterChildNode('PhotoCollection', TXMLPhotoCollectionType);
  RegisterChildNode('EmailAddressCollection', TXMLEmailAddressCollectionType);
  inherited;
end;

function TXMLContactType.Get_Version: Integer;
begin
  Result := AttributeNodes['Version'].NodeValue;
end;

procedure TXMLContactType.Set_Version(Value: Integer);
begin
  SetAttribute('Version', Value);
end;

function TXMLContactType.Get_CreationDate: WideString;
begin
  Result := ChildNodes['CreationDate'].Text;
end;

procedure TXMLContactType.Set_CreationDate(Value: WideString);
begin
  ChildNodes['CreationDate'].NodeValue := Value;
end;

function TXMLContactType.Get_Extended: IXMLExtendedType;
begin
  Result := ChildNodes['Extended'] as IXMLExtendedType;
end;

function TXMLContactType.Get_ContactIDCollection: IXMLContactIDCollectionType;
begin
  Result := ChildNodes['ContactIDCollection'] as IXMLContactIDCollectionType;
end;

function TXMLContactType.Get_NameCollection: IXMLNameCollectionType;
begin
  Result := ChildNodes['NameCollection'] as IXMLNameCollectionType;
end;

function TXMLContactType.Get_PhotoCollection: IXMLPhotoCollectionType;
begin
  Result := ChildNodes['PhotoCollection'] as IXMLPhotoCollectionType;
end;

function TXMLContactType.Get_EmailAddressCollection: IXMLEmailAddressCollectionType;
begin
  Result := ChildNodes['EmailAddressCollection'] as IXMLEmailAddressCollectionType;
end;

{ TXMLExtendedType }

function TXMLExtendedType.Get_Nil_: WideString;
begin
  Result := AttributeNodes['nil'].Text;
end;

procedure TXMLExtendedType.Set_Nil_(Value: WideString);
begin
  SetAttribute('nil', Value);
end;

{ TXMLContactIDCollectionType }

procedure TXMLContactIDCollectionType.AfterConstruction;
begin
  RegisterChildNode('ContactID', TXMLContactIDType);
  inherited;
end;

function TXMLContactIDCollectionType.Get_ContactID: IXMLContactIDType;
begin
  Result := ChildNodes['ContactID'] as IXMLContactIDType;
end;

{ TXMLContactIDType }

function TXMLContactIDType.Get_ElementID: WideString;
begin
  Result := AttributeNodes['ElementID'].Text;
end;

procedure TXMLContactIDType.Set_ElementID(Value: WideString);
begin
  SetAttribute('ElementID', Value);
end;

function TXMLContactIDType.Get_Value: WideString;
begin
  Result := ChildNodes['Value'].Text;
end;

procedure TXMLContactIDType.Set_Value(Value: WideString);
begin
  ChildNodes['Value'].NodeValue := Value;
end;

{ TXMLNameCollectionType }

procedure TXMLNameCollectionType.AfterConstruction;
begin
  RegisterChildNode('Name', TXMLNameType);
  inherited;
end;

function TXMLNameCollectionType.Get_Name: IXMLNameType;
begin
  Result := ChildNodes['Name'] as IXMLNameType;
end;

{ TXMLNameType }

procedure TXMLNameType.AfterConstruction;
begin
  RegisterChildNode('GivenName', TXMLGivenNameType);
  inherited;
end;

function TXMLNameType.Get_ElementID: WideString;
begin
  Result := AttributeNodes['ElementID'].Text;
end;

procedure TXMLNameType.Set_ElementID(Value: WideString);
begin
  SetAttribute('ElementID', Value);
end;

function TXMLNameType.Get_GivenName: IXMLGivenNameType;
begin
  Result := ChildNodes['GivenName'] as IXMLGivenNameType;
end;

function TXMLNameType.Get_FormattedName: WideString;
begin
  Result := ChildNodes['FormattedName'].Text;
end;

procedure TXMLNameType.Set_FormattedName(Value: WideString);
begin
  ChildNodes['FormattedName'].NodeValue := Value;
end;

{ TXMLGivenNameType }

function TXMLGivenNameType.Get_Version: Integer;
begin
  Result := AttributeNodes['Version'].NodeValue;
end;

procedure TXMLGivenNameType.Set_Version(Value: Integer);
begin
  SetAttribute('Version', Value);
end;

function TXMLGivenNameType.Get_ModificationDate: WideString;
begin
  Result := AttributeNodes['ModificationDate'].Text;
end;

procedure TXMLGivenNameType.Set_ModificationDate(Value: WideString);
begin
  SetAttribute('ModificationDate', Value);
end;

{ TXMLPhotoCollectionType }

procedure TXMLPhotoCollectionType.AfterConstruction;
begin
  RegisterChildNode('Photo', TXMLPhotoType);
  inherited;
end;

function TXMLPhotoCollectionType.Get_Version: Integer;
begin
  Result := AttributeNodes['Version'].NodeValue;
end;

procedure TXMLPhotoCollectionType.Set_Version(Value: Integer);
begin
  SetAttribute('Version', Value);
end;

function TXMLPhotoCollectionType.Get_ModificationDate: WideString;
begin
  Result := AttributeNodes['ModificationDate'].Text;
end;

procedure TXMLPhotoCollectionType.Set_ModificationDate(Value: WideString);
begin
  SetAttribute('ModificationDate', Value);
end;

function TXMLPhotoCollectionType.Get_Photo: IXMLPhotoType;
begin
  Result := ChildNodes['Photo'] as IXMLPhotoType;
end;

{ TXMLPhotoType }

procedure TXMLPhotoType.AfterConstruction;
begin
  RegisterChildNode('Value', TXMLValueType);
  RegisterChildNode('LabelCollection', TXMLLabelCollectionType);
  inherited;
end;

function TXMLPhotoType.Get_ElementID: WideString;
begin
  Result := AttributeNodes['ElementID'].Text;
end;

procedure TXMLPhotoType.Set_ElementID(Value: WideString);
begin
  SetAttribute('ElementID', Value);
end;

function TXMLPhotoType.Get_Version: Integer;
begin
  Result := AttributeNodes['Version'].NodeValue;
end;

procedure TXMLPhotoType.Set_Version(Value: Integer);
begin
  SetAttribute('Version', Value);
end;

function TXMLPhotoType.Get_ModificationDate: WideString;
begin
  Result := AttributeNodes['ModificationDate'].Text;
end;

procedure TXMLPhotoType.Set_ModificationDate(Value: WideString);
begin
  SetAttribute('ModificationDate', Value);
end;

function TXMLPhotoType.Get_Value: IXMLValueType;
begin
  Result := ChildNodes['Value'] as IXMLValueType;
end;

function TXMLPhotoType.Get_LabelCollection: IXMLLabelCollectionType;
begin
  Result := ChildNodes['LabelCollection'] as IXMLLabelCollectionType;
end;

{ TXMLValueType }

function TXMLValueType.Get_ContentType: WideString;
begin
  Result := AttributeNodes['ContentType'].Text;
end;

procedure TXMLValueType.Set_ContentType(Value: WideString);
begin
  SetAttribute('ContentType', Value);
end;

function TXMLValueType.Get_Version: Integer;
begin
  Result := AttributeNodes['Version'].NodeValue;
end;

procedure TXMLValueType.Set_Version(Value: Integer);
begin
  SetAttribute('Version', Value);
end;

function TXMLValueType.Get_ModificationDate: WideString;
begin
  Result := AttributeNodes['ModificationDate'].Text;
end;

procedure TXMLValueType.Set_ModificationDate(Value: WideString);
begin
  SetAttribute('ModificationDate', Value);
end;

{ TXMLLabelCollectionType }

procedure TXMLLabelCollectionType.AfterConstruction;
begin
  RegisterChildNode('Label', TXMLLabelType);
  inherited;
end;

function TXMLLabelCollectionType.Get_Label_: IXMLLabelType;
begin
  Result := ChildNodes['Label'] as IXMLLabelType;
end;

{ TXMLLabelType }

function TXMLLabelType.Get_Version: Integer;
begin
  Result := AttributeNodes['Version'].NodeValue;
end;

procedure TXMLLabelType.Set_Version(Value: Integer);
begin
  SetAttribute('Version', Value);
end;

function TXMLLabelType.Get_ModificationDate: WideString;
begin
  Result := AttributeNodes['ModificationDate'].Text;
end;

procedure TXMLLabelType.Set_ModificationDate(Value: WideString);
begin
  SetAttribute('ModificationDate', Value);
end;

{ TXMLEmailAddressCollectionType }

procedure TXMLEmailAddressCollectionType.AfterConstruction;
begin
  RegisterChildNode('EmailAddress', TXMLEmailAddressType);
  ItemTag := 'EmailAddress';
  ItemInterface := IXMLEmailAddressType;
  inherited;
end;

function TXMLEmailAddressCollectionType.Get_Version: Integer;
begin
  Result := AttributeNodes['Version'].NodeValue;
end;

procedure TXMLEmailAddressCollectionType.Set_Version(Value: Integer);
begin
  SetAttribute('Version', Value);
end;

function TXMLEmailAddressCollectionType.Get_ModificationDate: WideString;
begin
  Result := AttributeNodes['ModificationDate'].Text;
end;

procedure TXMLEmailAddressCollectionType.Set_ModificationDate(Value: WideString);
begin
  SetAttribute('ModificationDate', Value);
end;

function TXMLEmailAddressCollectionType.Get_EmailAddress(Index: Integer): IXMLEmailAddressType;
begin
  Result := List[Index] as IXMLEmailAddressType;
end;

function TXMLEmailAddressCollectionType.Add: IXMLEmailAddressType;
begin
  Result := AddItem(-1) as IXMLEmailAddressType;
end;

function TXMLEmailAddressCollectionType.Insert(const Index: Integer): IXMLEmailAddressType;
begin
  Result := AddItem(Index) as IXMLEmailAddressType;
end;

{ TXMLEmailAddressType }

procedure TXMLEmailAddressType.AfterConstruction;
begin
  RegisterChildNode('Type', TXMLType_);
  RegisterChildNode('Address', TXMLAddressType);
  RegisterChildNode('LabelCollection', TXMLLabelCollectionType);
  inherited;
end;

function TXMLEmailAddressType.Get_ElementID: WideString;
begin
  Result := AttributeNodes['ElementID'].Text;
end;

procedure TXMLEmailAddressType.Set_ElementID(Value: WideString);
begin
  SetAttribute('ElementID', Value);
end;

function TXMLEmailAddressType.Get_Version: Integer;
begin
  Result := AttributeNodes['Version'].NodeValue;
end;

procedure TXMLEmailAddressType.Set_Version(Value: Integer);
begin
  SetAttribute('Version', Value);
end;

function TXMLEmailAddressType.Get_ModificationDate: WideString;
begin
  Result := AttributeNodes['ModificationDate'].Text;
end;

procedure TXMLEmailAddressType.Set_ModificationDate(Value: WideString);
begin
  SetAttribute('ModificationDate', Value);
end;

function TXMLEmailAddressType.Get_Type_: IXMLType_;
begin
  Result := ChildNodes['Type'] as IXMLType_;
end;

function TXMLEmailAddressType.Get_Address: IXMLAddressType;
begin
  Result := ChildNodes['Address'] as IXMLAddressType;
end;

function TXMLEmailAddressType.Get_LabelCollection: IXMLLabelCollectionType;
begin
  Result := ChildNodes['LabelCollection'] as IXMLLabelCollectionType;
end;

{ TXMLType_ }

function TXMLType_.Get_Version: Integer;
begin
  Result := AttributeNodes['Version'].NodeValue;
end;

procedure TXMLType_.Set_Version(Value: Integer);
begin
  SetAttribute('Version', Value);
end;

function TXMLType_.Get_ModificationDate: WideString;
begin
  Result := AttributeNodes['ModificationDate'].Text;
end;

procedure TXMLType_.Set_ModificationDate(Value: WideString);
begin
  SetAttribute('ModificationDate', Value);
end;

{ TXMLAddressType }

function TXMLAddressType.Get_Version: Integer;
begin
  Result := AttributeNodes['Version'].NodeValue;
end;

procedure TXMLAddressType.Set_Version(Value: Integer);
begin
  SetAttribute('Version', Value);
end;

function TXMLAddressType.Get_ModificationDate: WideString;
begin
  Result := AttributeNodes['ModificationDate'].Text;
end;

procedure TXMLAddressType.Set_ModificationDate(Value: WideString);
begin
  SetAttribute('ModificationDate', Value);
end;

{ TXMLEmailAddressType2 }

function TXMLEmailAddressType2.Get_ElementID: WideString;
begin
  Result := AttributeNodes['ElementID'].Text;
end;

procedure TXMLEmailAddressType2.Set_ElementID(Value: WideString);
begin
  SetAttribute('ElementID', Value);
end;

function TXMLEmailAddressType2.Get_Nil_: WideString;
begin
  Result := AttributeNodes['nil'].Text;
end;

procedure TXMLEmailAddressType2.Set_Nil_(Value: WideString);
begin
  SetAttribute('nil', Value);
end;

function TXMLEmailAddressType2.Get_Version: Integer;
begin
  Result := AttributeNodes['Version'].NodeValue;
end;

procedure TXMLEmailAddressType2.Set_Version(Value: Integer);
begin
  SetAttribute('Version', Value);
end;

function TXMLEmailAddressType2.Get_ModificationDate: WideString;
begin
  Result := AttributeNodes['ModificationDate'].Text;
end;

procedure TXMLEmailAddressType2.Set_ModificationDate(Value: WideString);
begin
  SetAttribute('ModificationDate', Value);
end;

end.
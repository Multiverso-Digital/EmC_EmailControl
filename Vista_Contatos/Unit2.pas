unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, xmldom, XMLIntf, StdCtrls, msxmldom, XMLDoc;

type
  TForm2 = class(TForm)
    XMLDocument1: TXMLDocument;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation


uses abreu;

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
var

EmailReg  :  IXMLContactType;
Email     :  IXMLEmailAddressCollectionType;

begin





Email     := EmailReg.EmailAddressCollection;





//showmessage(inttostr(Email.Count));


end;

end.

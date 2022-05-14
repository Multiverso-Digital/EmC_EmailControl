unit UPOP;

interface

uses windows,classes,StdCtrls;

type
TThreadPOP = class(TThread)
private
FServeur,FUser,FPass: string;
FPort : Integer ;
Fedit : Tedit;
Fig : integer;
protected
constructor Create(CreateSuspended: Boolean;serveur:string;port:integer;user:string;pass:string;Edit:Tedit;ig:integer);
procedure Execute; override;
procedure VaChercher;
end;


implementation

constructor TThreadPOP.Create(CreateSuspended: Boolean;serveur:string;port:integer;user:string;pass:string;Edit:Tedit;ig:integer);
begin
inherited Create(CreateSuspended);
FreeOnTerminate := True;
Priority := tplower;
FServeur := serveur ;
FUser := user ;
FPass := pass ;
FPort := port ;
Fedit := edit ;
Fig   := ig ;
if CreateSuspended then
Resume;
end;



procedure TThreadPOP.Execute;
begin
synchronize(VaChercher);
end;

procedure TThreadPOP.VaChercher;
begin
Fedit.Text:=fserveur;
end;







end.

program p_coliget_search_engine;

uses
  Forms,
  u_coliget_search_engine in 'u_coliget_search_engine.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

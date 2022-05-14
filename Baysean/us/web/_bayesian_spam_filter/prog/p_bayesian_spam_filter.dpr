program p_bayesian_spam_filter;

uses
  Forms,
  u_bayesian_spam_filter in 'u_bayesian_spam_filter.pas' {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

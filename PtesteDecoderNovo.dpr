program PtesteDecoderNovo;

uses
  Forms,
  testeDecoderNovo in 'testeDecoderNovo.pas' {Form1},
  MsgHdrCoders in 'MsgHdrCoders.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

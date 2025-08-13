program ProjectCrud;

uses
  Vcl.Forms,
  UMain in 'UMain.pas' {Form1},
  UMain2 in 'UMain2.pas' {Form2},
  UMenu3 in 'UMenu3.pas' {Form3},
  UMenu4 in 'UMenu4.pas' {Form4},
  UMenu5 in 'UMenu5.pas' {Form5},
  UMenu6 in 'UMenu6.pas' {Form6},
  UProfessores in 'UProfessores.pas',
  UDisciplinas in 'UDisciplinas.pas',
  UTurmas in 'UTurmas.pas',
  UMatriculas in 'UMatriculas.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TForm6, Form6);
  Application.Run;
end.

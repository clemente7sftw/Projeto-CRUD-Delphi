unit UMain2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls,UMenu3,UMenu4,UMenu5,UMenu6,UMenu7, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.jpeg;

type
  TForm2 = class(TForm)
    Image1: TImage;
    Menu: TPanel;
    PEstudantes: TPanel;
    PProfessores: TPanel;
    PDisciplinas: TPanel;
    PTurmas: TPanel;
    PMatriculas: TPanel;
    procedure PEstudantesClick(Sender: TObject);
    procedure PProfessoresClick(Sender: TObject);
    procedure PDisciplinasClick(Sender: TObject);
    procedure PTurmasClick(Sender: TObject);
    procedure PMatriculasClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}
// Estudantes [3]
// Professores [4]
// Disciplinas [5]
// Turmas [6]
// Matrícula [7]

procedure TForm2.PDisciplinasClick(Sender: TObject);
begin
    Form5 := TForm5.Create(Self);
    Form5.Align := alClient;
    Form5.Show;
end;

procedure TForm2.PEstudantesClick(Sender: TObject);
begin
    Form3 := TForm3.Create(Self);
    Form3.Align := alClient;
    Form3.Show;
end;

procedure TForm2.PMatriculasClick(Sender: TObject);
begin
    Form7 := TForm7.Create(Self);
    Form7.Align := alClient;
    Form7.Show;
end;

procedure TForm2.PProfessoresClick(Sender: TObject);
begin
    Form4 := TForm4.Create(Self);
    Form4.Align := alClient;
    Form4.Show;
end;

procedure TForm2.PTurmasClick(Sender: TObject);
begin
    Form6 := TForm6.Create(Self);
    Form6.Align := alClient;
    Form6.Show;
end;

end.

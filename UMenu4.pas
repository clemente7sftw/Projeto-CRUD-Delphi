unit UMenu4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms,UProfessores, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.StdCtrls;

type
  TForm4 = class(TForm)
    Image1: TImage;
    Lista: TStringGrid;
    Menu: TPanel;
    PIncluir: TPanel;
    PListar: TPanel;
    PExcluir: TPanel;
    PSair: TPanel;
    PAtualizar: TPanel;
    MsgEnt: TLabel;
    BtnConf: TButton;
    BtnAdd: TButton;
    Dados: TListBox;
    procedure PSairClick(Sender: TObject);
    procedure ListaKeyPress(Sender: TObject; var Key: Char);
    procedure ListaEnter(Sender: TObject);
    procedure PIncluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PListarClick(Sender: TObject);
    procedure BtnConfClick(Sender: TObject);
    procedure PExcluirClick(Sender: TObject);
  private
   var Professores:TProfessor;
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

uses UMain2;

procedure TForm4.BtnConfClick(Sender: TObject);
begin
  Professores.ConfirmarDados;
  Professores.Salvar;
end;

procedure TForm4.FormCreate(Sender: TObject);
begin
Professores := TProfessor.Create(Lista, Dados, BtnAdd, BtnConf);
end;

procedure TForm4.ListaEnter(Sender: TObject);
begin
    Lista.Cells[0,0]:= 'Código';
    Lista.Cells[1,0]:= 'Nome';
    Lista.Cells[2,0]:= 'CPF';
end;

procedure TForm4.ListaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    Key := 0;

    if Lista.Row < Lista.RowCount - 1 then
      Lista.Row := Lista.Row + 1
    else
    begin
      Lista.RowCount := Lista.RowCount + 1;
      Lista.Row := Lista.RowCount - 1;
<<<<<<< HEAD
      Lista.Cells[0, Lista.Row] := IntToStr(50 + Lista.Row);
=======
      Lista.Cells[0, Lista.Row] := IntToStr(100 + Lista.Row);
>>>>>>> 12763858243fefdf2900cc6a6ed7af18491ddf6e
      Lista.Cells[1, Lista.Row] := '';
      Lista.Cells[2, Lista.Row] := '';
    end;

    Lista.Col := 1;
    Lista.SetFocus;
  end;
end;

procedure TForm4.ListaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Lista.RowCount := Lista.RowCount + 1;
    Lista.Row := Lista.RowCount - 1;
    Lista.Col := 0;
  end;
end;

procedure TForm4.PExcluirClick(Sender: TObject);
begin
Professores.ExcluirLinha;
end;

procedure TForm4.PIncluirClick(Sender: TObject);
begin
Professores.MostrarIncluir;
end;

procedure TForm4.PListarClick(Sender: TObject);
begin
Professores.MostrarListar;
end;

procedure TForm4.PSairClick(Sender: TObject);
begin
    Form2.Show;
end;

end.

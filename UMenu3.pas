unit UMenu3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.Grids, UFunçoes, Vcl.StdCtrls, UEstudantes;

type
  TForm3 = class(TForm)
    Image1: TImage;
    Lista: TStringGrid;
    Menu: TPanel;
    PIncluir: TPanel;
    PListar: TPanel;
    PExcluir: TPanel;
    PSair: TPanel;
    MsgEnt: TLabel;
    BtnAdd: TButton;
    BtnConf: TButton;
    Dados: TListBox;
    EdBuscar: TEdit;
    procedure PSairClick(Sender: TObject);
    procedure ListaEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PIncluirClick(Sender: TObject);
    procedure ListaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PExcluirClick(Sender: TObject);
    procedure PListarClick(Sender: TObject);
    procedure BtnConfClick(Sender: TObject);
    procedure EdBuscarChange(Sender: TObject);
  private
    var Estudantes: TEstudantes;
    procedure AtualizarLista;
  public
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses UMain2;

procedure TForm3.BtnConfClick(Sender: TObject);
begin
  Estudantes.ConfirmarDados;
  Estudantes.Salvar;
end;

procedure TForm3.EdBuscarChange(Sender: TObject);
begin
  Estudantes.Buscar(EdBuscar.Text);
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  Estudantes := TEstudantes.Create(Lista, Dados, BtnAdd, BtnConf, 2000);
  Estudantes.CarregarAlunos;
  EdBuscar.Visible := False;
end;

procedure TForm3.ListaEnter(Sender: TObject);
begin
  Lista.Cells[0, 0] := 'Código';
  Lista.Cells[1, 0] := 'Nome';
end;

procedure TForm3.ListaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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
      Lista.Cells[0, Lista.Row] := IntToStr(2000 + Lista.Row);
      Lista.Cells[1, Lista.Row] := '';
    end;
    Lista.Col := 1;
    Lista.SetFocus;
  end;
end;

procedure TForm3.PExcluirClick(Sender: TObject);
begin
  Estudantes.ExcluirAluno;
end;

procedure TForm3.PIncluirClick(Sender: TObject);
begin
  Estudantes.MostrarIncluir;
end;

procedure TForm3.PListarClick(Sender: TObject);
begin
  Estudantes.MostrarListar;
  EdBuscar.Visible := True;
end;

procedure TForm3.PSairClick(Sender: TObject);
begin
  Form2.Show;
  Close;
end;

procedure TForm3.AtualizarLista;
begin
  Estudantes.CarregarAlunos;
end;

end.


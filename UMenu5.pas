unit UMenu5;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls,UDisciplinas, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.Imaging.jpeg;

type
  TForm5 = class(TForm)
    Image1: TImage;
    Lista: TStringGrid;
    Menu: TPanel;
    PIncluir: TPanel;
    PListar: TPanel;
    PExcluir: TPanel;
    PSair: TPanel;
    PAtualizar: TPanel;
    MsgEnt: TLabel;
    BtnAdd: TButton;
    BtnConf: TButton;
    Dados: TListBox;
    procedure PSairClick(Sender: TObject);
    procedure ListaEnter(Sender: TObject);
    procedure PIncluirClick(Sender: TObject);
    procedure BtnConfClick(Sender: TObject);
    procedure PExcluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PListarClick(Sender: TObject);
    procedure ListaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ListaKeyPress(Sender: TObject; var Key: Char);
  private
   var Disciplinas:TDisciplina;
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

{$R *.dfm}

uses UMain2;


procedure TForm5.BtnConfClick(Sender: TObject);
begin
  Disciplinas.ConfirmarDados;
  Disciplinas.Salvar;
end;

procedure TForm5.FormCreate(Sender: TObject);
begin
Disciplinas := TDisciplina.Create(Lista, Dados, BtnAdd, BtnConf);
end;

procedure TForm5.ListaEnter(Sender: TObject);
begin
    Lista.Cells[0,0]:= 'Código';
    Lista.Cells[1,0]:= 'Disciplina';
end;

procedure TForm5.ListaKeyDown(Sender: TObject; var Key: Word;
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
      Lista.Cells[0, Lista.Row] := IntToStr(1000+ Lista.Row);
      Lista.Cells[1, Lista.Row] := '';
      Lista.Cells[2, Lista.Row] := '';
    end;

    Lista.Col := 1;
    Lista.SetFocus;
  end;
end;
procedure TForm5.ListaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Lista.RowCount := Lista.RowCount + 1;
    Lista.Row := Lista.RowCount - 1;
    Lista.Col := 0;
  end;
end;

procedure TForm5.PExcluirClick(Sender: TObject);
begin
Disciplinas.ExcluirLinha;
end;

procedure TForm5.PIncluirClick(Sender: TObject);
begin
  Disciplinas.MostrarIncluir;
end;

procedure TForm5.PListarClick(Sender: TObject);
begin
Disciplinas.MostrarListar;
end;

procedure TForm5.PSairClick(Sender: TObject);
begin
    Form2.Show;
end;

end.

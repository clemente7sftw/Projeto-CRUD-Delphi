unit Umenu7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls,UMatriculas, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.Imaging.jpeg;

type
  TForm7 = class(TForm)
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
    procedure PSairClick(Sender: TObject);
    procedure ListaEnter(Sender: TObject);
    procedure ListaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PIncluirClick(Sender: TObject);
    procedure PListarClick(Sender: TObject);
    procedure PExcluirClick(Sender: TObject);
    procedure BtnConfClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    Matriculas:TMatriculas;
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

{$R *.dfm}

uses UMain2;

procedure TForm7.BtnConfClick(Sender: TObject);
begin
  Matriculas.ConfirmarDadosGeral;
  Matriculas.Salvar;
end;

procedure TForm7.FormCreate(Sender: TObject);
begin
Matriculas := TMatriculas.Create(Lista, Dados, BtnAdd, BtnConf);
Matriculas.CarregarMatriculas;
end;

procedure TForm7.ListaEnter(Sender: TObject);
begin
    Lista.Cells[0,0]:= 'Código';
    Lista.Cells[1,0]:= 'Código Turma';
    Lista.Cells[2,0]:= 'Código Estudante';
end;

procedure TForm7.ListaKeyDown(Sender: TObject; var Key: Word;
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
      Lista.Cells[0, Lista.Row] := IntToStr(100000 + Lista.Row);
      Lista.Cells[1, Lista.Row] := '';
      Lista.Cells[2, Lista.Row] := '';
    end;

    Lista.Col := 1;
    Lista.SetFocus;
  end;
end;

procedure TForm7.PExcluirClick(Sender: TObject);
begin
Matriculas.ExcluirLinha;
end;

procedure TForm7.PIncluirClick(Sender: TObject);
begin
Matriculas.MostrarIncluir;
end;

procedure TForm7.PListarClick(Sender: TObject);
begin
Matriculas.MostrarListar;
end;

procedure TForm7.PSairClick(Sender: TObject);
begin
     Form2.Show;
end;

end.

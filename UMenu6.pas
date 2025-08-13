unit UMenu6;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, UTurmas, UProfessores, UDisciplinas, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.Imaging.jpeg;

type
  TForm6 = class(TForm)
    Image1: TImage;
    Menu: TPanel;
    PIncluir: TPanel;
    PListar: TPanel;
    PExcluir: TPanel;
    PSair: TPanel;
    MsgEnt: TLabel;
    Fundo: TPanel;
    CbProfessor: TComboBox;
    BtnCBAdd: TButton;
    CbDisciplinas: TComboBox;
    Lista: TStringGrid;
    BtnAdd: TButton;
    BtnConf: TButton;
    Dados: TListBox;
    procedure PSairClick(Sender: TObject);
    procedure ListaEnter(Sender: TObject);
    procedure ListaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnConfClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PIncluirClick(Sender: TObject);
    procedure PListarClick(Sender: TObject);
    procedure PExcluirClick(Sender: TObject);
    procedure AtualizarComboBox;
    procedure BtnCBAddClick(Sender: TObject);
  private
    Turmas: TTurmas;
    Professores: TProfessor;
    Disciplinas: TDisciplina;
  public
  end;

var
  Form6: TForm6;

implementation

{$R *.dfm}

uses UMain2;

procedure TForm6.AtualizarComboBox;
var
  i: Integer;
  codigo, nome: string;
begin
  CbProfessor.Clear;
  for i := 1 to Professores.Lista.RowCount - 1 do
  begin
    codigo := Professores.Lista.Cells[0, i];
    nome := Professores.Lista.Cells[1, i];
    if (codigo <> '') and (nome <> '') then
      CbProfessor.Items.Add(codigo + ' - ' + nome);
  end;

  CbDisciplinas.Clear;
  for i := 1 to Disciplinas.Lista.RowCount - 1 do
  begin
    codigo := Disciplinas.Lista.Cells[0, i];
    nome := Disciplinas.Lista.Cells[1, i];
    if (codigo <> '') and (nome <> '') then
      CbDisciplinas.Items.Add(codigo + ' - ' + nome);
  end;
end;

procedure TForm6.BtnCBAddClick(Sender: TObject);
var
  codigoProfessor, codigoDisciplina: string;
  posSeparador: Integer;
  novaLinha: Integer;
begin
  posSeparador := Pos(' - ', CbProfessor.Text);
  if posSeparador > 0 then
    codigoProfessor := Copy(CbProfessor.Text, 1, posSeparador - 1)
  else
    codigoProfessor := '';

  posSeparador := Pos(' - ', CbDisciplinas.Text);
  if posSeparador > 0 then
    codigoDisciplina := Copy(CbDisciplinas.Text, 1, posSeparador - 1)
  else
    codigoDisciplina := '';

  if (codigoProfessor = '') or (codigoDisciplina = '') then
  begin
    ShowMessage('Selecione professor e disciplina.');
    Exit;
  end;

  novaLinha := Turmas.Lista.RowCount;
  Turmas.Lista.RowCount := novaLinha + 1;
  Turmas.Lista.Cells[0, novaLinha] := IntToStr(200 + novaLinha - 1);
  Turmas.Lista.Cells[1, novaLinha] := codigoProfessor;
  Turmas.Lista.Cells[2, novaLinha] := codigoDisciplina;

  ShowMessage('Turma adicionada!');
  Turmas.Salvar;
  Lista.Visible := true;
end;

procedure TForm6.BtnConfClick(Sender: TObject);
begin
  Turmas.ConfirmarDadosGeral;
  Turmas.Salvar;
end;

procedure TForm6.FormCreate(Sender: TObject);
begin
  Lista.FixedRows := 1;
  Lista.RowCount := 2;

  Lista.Cells[0, 0] := 'Código';
  Lista.Cells[1, 0] := 'Código Professor';
  Lista.Cells[2, 0] := 'Código Disciplina';

  Professores := TProfessor.Create(TStringGrid.Create(nil), nil, nil, nil);
  Professores.Lista.Visible := False;
  Professores.CarregarProfessores;

  Lista.Visible := False;
  BtnConf.Visible := False;
  BtnAdd.Visible := False;
  Dados.Visible := False;

  Disciplinas := TDisciplina.Create(TStringGrid.Create(nil), nil, nil, nil);
  Disciplinas.Lista.Visible := False;
  Disciplinas.CarregarDisciplinas;

  Turmas := TTurmas.Create(Lista, Dados, BtnAdd, BtnConf);
  Turmas.CarregarTurmas;


  AtualizarComboBox;
end;

procedure TForm6.FormDestroy(Sender: TObject);
begin
  if Assigned(Professores) then
  begin
    Professores.Lista.Free;
    Professores.Free;
  end;

  if Assigned(Disciplinas) then
  begin
    Disciplinas.Lista.Free;
    Disciplinas.Free;
  end;

  if Assigned(Turmas) then
    Turmas.Free;
end;

procedure TForm6.ListaEnter(Sender: TObject);
begin
  Lista.Cells[0, 0] := 'Código';
  Lista.Cells[1, 0] := 'Código Professor';
  Lista.Cells[2, 0] := 'Código Disciplina';
end;

procedure TForm6.ListaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
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
      Lista.Cells[0, Lista.Row] := IntToStr(200 + Lista.Row);
      Lista.Cells[1, Lista.Row] := 'Código Professor';
      Lista.Cells[2, Lista.Row] := 'Código Disciplina';
    end;

    Lista.Col := 1;
    Lista.SetFocus;
  end;
end;

procedure TForm6.PExcluirClick(Sender: TObject);
begin
  Turmas.ExcluirLinha;
end;

procedure TForm6.PIncluirClick(Sender: TObject);
begin
  Turmas.MostrarIncluir;
  BtnConf.Visible := False;
  BtnAdd.Visible := False;
  Dados.Visible := False;
end;

procedure TForm6.PListarClick(Sender: TObject);
begin
  Turmas.MostrarListar;
  Dados.Visible := False;
end;

procedure TForm6.PSairClick(Sender: TObject);
begin
  Form2.Show;
end;

end.


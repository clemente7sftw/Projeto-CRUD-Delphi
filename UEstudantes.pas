unit UEstudantes;

interface

uses
  Vcl.Grids, Vcl.StdCtrls, Vcl.Controls, UFunçoes, System.Classes, System.SysUtils;

type
  TEstudantes = class(TFunçoes)
  private
    function ArquivoFullPath: string;
  public
    constructor Create(ALista: TStringGrid; ADados: TListBox; ABtnAdd, ABtnConf: TControl; ACodigoInicial: Integer = 2000); reintroduce; overload;

    procedure CarregarAlunos;
    procedure SalvarAlunos;

    procedure AdicionarAluno(const Nome: string);
    procedure ExcluirAluno;
  end;

implementation

{ TEstudantes }

constructor TEstudantes.Create(ALista: TStringGrid; ADados: TListBox; ABtnAdd, ABtnConf: TControl; ACodigoInicial: Integer);
begin
  inherited Create(ALista, ADados, ABtnAdd, ABtnConf, ACodigoInicial, 'C:\Users\gabi\OneDrive\Documents\estudantes.txt');
end;

function TEstudantes.ArquivoFullPath: string;
begin
  Result := Arquivo;
end;

procedure TEstudantes.CarregarAlunos;
var
  ListaCarregar: TStringList;
  i: Integer;
  linha: string;
  p: Integer;
  codigo, nome: string;
begin
  ListaCarregar := TStringList.Create;
  try
    if FileExists(ArquivoFullPath) then
    begin
      ListaCarregar.LoadFromFile(ArquivoFullPath, TEncoding.UTF8);
      Lista.RowCount := ListaCarregar.Count + 1;
      for i := 0 to ListaCarregar.Count - 1 do
      begin
        linha := ListaCarregar[i];
        p := Pos(';', linha);
        if p > 0 then
        begin
          codigo := Copy(linha, 1, p - 1);
          nome := Copy(linha, p + 1, Length(linha));
          Lista.Cells[0, i + 1] := codigo;
          Lista.Cells[1, i + 1] := nome;
        end;
      end;
    end else
      Lista.RowCount := 1;
  finally
    ListaCarregar.Free;
  end;
end;

procedure TEstudantes.SalvarAlunos;
var
  i: Integer;
  codigo, nome: string;
  ListaSalvar: TStringList;
begin
  ListaSalvar := TStringList.Create;
  try
    for i := 1 to Lista.RowCount - 1 do
    begin
      codigo := Trim(Lista.Cells[0, i]);
      nome := Trim(Lista.Cells[1, i]);
      if (codigo <> '') and (nome <> '') then
        ListaSalvar.Add(codigo + ';' + nome);
    end;
    ListaSalvar.SaveToFile(ArquivoFullPath, TEncoding.UTF8);
  finally
    ListaSalvar.Free;
  end;
end;

procedure TEstudantes.AdicionarAluno(const Nome: string);
var
  codigo: Integer;
  novaLinha: Integer;
begin
  codigo := ProximoCodigo;
  novaLinha := Lista.RowCount;
  Lista.RowCount := novaLinha + 1;
  Lista.Cells[0, novaLinha] := IntToStr(codigo);
  Lista.Cells[1, novaLinha] := Nome;
  Lista.Row := novaLinha;
  Lista.Col := 1;
  Lista.SetFocus;
  SalvarAlunos;
end;

procedure TEstudantes.ExcluirAluno;
var
  linhaAtual: Integer;
  i, j: Integer;
begin
  linhaAtual := Lista.Row;
  if (linhaAtual > 0) and (linhaAtual < Lista.RowCount) then
  begin

    for i := linhaAtual to Lista.RowCount - 2 do
      for j := 0 to Lista.ColCount - 1 do
        Lista.Cells[j, i] := Lista.Cells[j, i + 1];
    Lista.RowCount := Lista.RowCount - 1;

    SalvarAlunos;
  end;
end;

end.

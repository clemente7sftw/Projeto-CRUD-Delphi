unit UProfessores;

interface

uses
  Vcl.Grids, Vcl.StdCtrls, Vcl.Dialogs, Vcl.Controls, UFunçoes, System.Classes, System.SysUtils;

type
  TProfessor = class(TFunçoes)
  private
    procedure Excluir;
  public
    constructor Create(ALista: TStringGrid; ADados: TListBox; ABtnAdd, ABtnConf: TControl; ACodigoInicial: Integer = 50); reintroduce; overload;
    procedure SalvarProfessores;
    procedure AdicionarProfessor(const Nome: string);
    procedure CarregarProfessores;
    procedure Incluir;
    procedure Listar;
    procedure Salvar;
    procedure ExcluirProfessores;
    function Buscar(const TextoBusca: string): Integer;
  end;

implementation

procedure TProfessor.AdicionarProfessor(const Nome: string);
var
  novaLinha: Integer;
  codigoStr: string;
begin
  novaLinha := Lista.RowCount;
  Lista.RowCount := novaLinha + 1;
  codigoStr := IntToStr(50 + novaLinha - 1);
  Lista.Cells[0, novaLinha] := codigoStr;
  Lista.Cells[1, novaLinha] := Nome;
  Lista.Cells[2, novaLinha] := '';
  Salvar;
end;

function TProfessor.Buscar(const TextoBusca: string): Integer;
var
  i: Integer;
  TextoMinusculo, ItemMinusculo: string;
begin
  Result := -1;
  TextoMinusculo := LowerCase(Trim(TextoBusca));
  if TextoMinusculo = '' then Exit;

  for i := 0 to Dados.Items.Count - 1 do
  begin
    ItemMinusculo := LowerCase(Dados.Items[i]);
    if Pos(TextoMinusculo, ItemMinusculo) > 0 then
    begin
      Result := i;
      Dados.ItemIndex := i;
      Break;
    end;
  end;
end;

procedure TProfessor.CarregarProfessores;
var
  ListaCarregar: TStringList;
  i, p1, p2: Integer;
  linha, codigo, nome, cpf: string;
  CaminhoArquivo: string;
begin
  CaminhoArquivo := 'C:\Users\gabi\OneDrive\Documents\professores.txt';
  ListaCarregar := TStringList.Create;
  try
    if FileExists(CaminhoArquivo) then
    begin
      ListaCarregar.LoadFromFile(CaminhoArquivo, TEncoding.UTF8);
      Lista.RowCount := ListaCarregar.Count + 1;
      for i := 0 to ListaCarregar.Count - 1 do
      begin
        linha := ListaCarregar[i];
        p1 := Pos(' - ', linha);
        if p1 > 0 then
        begin
          codigo := Copy(linha, 1, p1 - 1);
          Delete(linha, 1, p1 + 2);
          p2 := Pos(' - ', linha);
          if p2 > 0 then
          begin
            nome := Copy(linha, 1, p2 - 1);
            cpf := Copy(linha, p2 + 3, Length(linha));
          end
          else
          begin
            nome := linha;
            cpf := '';
          end;
          Lista.Cells[0, i + 1] := codigo;
          Lista.Cells[1, i + 1] := nome;
          Lista.Cells[2, i + 1] := cpf;
        end;
      end;
    end
    else
      Lista.RowCount := 1;
  finally
    ListaCarregar.Free;
  end;
end;

constructor TProfessor.Create(ALista: TStringGrid; ADados: TListBox; ABtnAdd, ABtnConf: TControl; ACodigoInicial: Integer);
begin
  inherited Create(ALista, ADados, ABtnAdd, ABtnConf, ACodigoInicial, 'C:\Users\gabi\OneDrive\Documents\professores.txt');
end;

procedure TProfessor.Excluir;
begin
  Self.ExcluirLinha;
end;

procedure TProfessor.ExcluirProfessores;
var
  DadoUN: Integer;
  i, j: Integer;
begin
  DadoUN := Dados.ItemIndex;
  if DadoUN <> -1 then
  begin
    Dados.Items.Delete(DadoUN);
    if (DadoUN + 1) < Lista.RowCount then
    begin
      for i := DadoUN + 1 to Lista.RowCount - 2 do
        for j := 0 to Lista.ColCount - 1 do
          Lista.Cells[j, i] := Lista.Cells[j, i + 1];
      Lista.RowCount := Lista.RowCount - 1;
    end;
    Salvar;
  end
  else
    ShowMessage('Selecione um item para deletar.');
end;

procedure TProfessor.Incluir;
begin
  Self.MostrarIncluir;
end;

procedure TProfessor.Listar;
var
  i: Integer;
  codigo, nome, cpf: string;
begin
  Dados.Clear;
  for i := 1 to Lista.RowCount - 1 do
  begin
    codigo := Lista.Cells[0, i];
    nome := Lista.Cells[1, i];
    cpf := Lista.Cells[2, i];
    Dados.Items.Add(Format('Código: %s | Nome: %s | CPF: %s', [codigo, nome, cpf]));
  end;
end;

procedure TProfessor.Salvar;
var
  CaminhoArquivo: string;
  ListaSalvar: TStringList;
  i: Integer;
  codigo, nome, cpf: string;
begin
  ListaSalvar := TStringList.Create;
  try
    for i := 1 to Lista.RowCount - 1 do
    begin
      codigo := Trim(Lista.Cells[0, i]);
      nome := Trim(Lista.Cells[1, i]);
      cpf := Trim(Lista.Cells[2, i]);
      if (codigo <> '') and (nome <> '') then
        ListaSalvar.Add(codigo + ' - ' + nome + ' - ' + cpf);
    end;
    CaminhoArquivo := 'C:\Users\gabi\OneDrive\Documents\professores.txt';
    ListaSalvar.SaveToFile(CaminhoArquivo, TEncoding.UTF8);
  finally
    ListaSalvar.Free;
  end;
end;

procedure TProfessor.SalvarProfessores;
var
  i: Integer;
  linha: string;
begin
  Dados.Clear;
  for i := 1 to Lista.RowCount - 1 do
  begin
    linha := Trim(Lista.Cells[0, i]) + ' - ' + Trim(Lista.Cells[1, i]) + ' - ' + Trim(Lista.Cells[2, i]);
    if linha <> ' -  - ' then
      Dados.Items.Add(linha);
  end;
  Salvar;
  ShowMessage('Dados confirmados e salvos com sucesso!');
end;

end.


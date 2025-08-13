unit UDisciplinas;

interface

uses
  Vcl.Grids, Vcl.StdCtrls, Vcl.Dialogs, Vcl.Controls, UFunçoes, System.Classes, System.SysUtils;

type
  TDisciplina = class(TFunçoes)
  private
    FCodigo: Integer;
    FNome: string;
  public
    property Codigo: Integer read FCodigo write FCodigo;
    property Nome: string read FNome write FNome;
    constructor Create(ALista: TStringGrid; ADados: TListBox; ABtnAdd, ABtnConf: TControl; ACodigoInicial: Integer = 1000); reintroduce; overload;

    procedure SalvarDisciplinas;

    procedure CarregarDisciplinas;
    procedure Incluir;
    procedure Listar;
    procedure Salvar;
    procedure ExcluirDisciplina;
    function Buscar(const TextoBusca: string): Integer; override;
  end;

implementation

{ TDisciplina }

constructor TDisciplina.Create(ALista: TStringGrid; ADados: TListBox; ABtnAdd, ABtnConf: TControl; ACodigoInicial: Integer);
begin
  inherited Create(ALista, ADados, ABtnAdd, ABtnConf, ACodigoInicial, 'C:\Users\gabi\OneDrive\Documents\disciplinas.txt');
end;



function TDisciplina.Buscar(const TextoBusca: string): Integer;
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

procedure TDisciplina.CarregarDisciplinas;
var
  ListaCarregar: TStringList;
  i, p: Integer;
  linha, codigo, nome: string;
  CaminhoArquivo: string;
begin
  CaminhoArquivo := 'C:\Users\gabi\OneDrive\Documents\disciplinas.txt';
  ListaCarregar := TStringList.Create;
  try
    if FileExists(CaminhoArquivo) then
    begin
      ListaCarregar.LoadFromFile(CaminhoArquivo, TEncoding.UTF8);
      Lista.RowCount := ListaCarregar.Count + 1;

      for i := 0 to ListaCarregar.Count - 1 do
      begin
        linha := ListaCarregar[i];
        p := Pos(' - ', linha);
        if p > 0 then
        begin
          codigo := Copy(linha, 1, p - 1);
          nome := Copy(linha, p + 3, Length(linha));
          Lista.Cells[0, i + 1] := codigo;
          Lista.Cells[1, i + 1] := nome;
        end;
      end;
    end
    else
      Lista.RowCount := 1;
  finally
    ListaCarregar.Free;
  end;
end;

procedure TDisciplina.ExcluirDisciplina;
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

procedure TDisciplina.Incluir;
begin
  MostrarIncluir;
end;

procedure TDisciplina.Listar;
begin
  MostrarListar;
end;

procedure TDisciplina.Salvar;
var
  CaminhoArquivo: string;
  ListaSalvar: TStringList;
  i: Integer;
  codigo, nome: string;
begin
  try
    ListaSalvar := TStringList.Create;
    try
      for i := 1 to Lista.RowCount - 1 do
      begin
        codigo := Trim(Lista.Cells[0, i]);
        nome := Trim(Lista.Cells[1, i]);

        if (codigo <> '') and (nome <> '') then
          ListaSalvar.Add(codigo + ' - ' + nome);
      end;

      CaminhoArquivo := 'C:\Users\gabi\OneDrive\Documents\disciplinas.txt';
      ListaSalvar.SaveToFile(CaminhoArquivo);

      ShowMessage('Arquivo salvo com sucesso');
    finally
      ListaSalvar.Free;
    end;
  except
    on E: Exception do
      ShowMessage('Erro ao salvar arquivo: ' + E.Message);
  end;
end;

procedure TDisciplina.SalvarDisciplinas;
begin
  ConfirmarDados;
end;

end.


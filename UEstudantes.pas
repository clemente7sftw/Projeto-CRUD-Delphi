unit UEstudantes;

interface

uses
  Vcl.Grids, Vcl.StdCtrls,Vcl.Dialogs, Vcl.Controls, UFunçoes, System.Classes, System.SysUtils;

type
  TEstudantes = class(TFunçoes)
  private
    FCodigo: Integer;
    FNome: string;
    function ArquivoFullPath: string;
  public
    property Codigo: Integer read FCodigo write FCodigo;
    property Nome: string read FNome write FNome;
    constructor Create(ALista: TStringGrid; ADados: TListBox; ABtnAdd, ABtnConf: TControl; ACodigoInicial: Integer = 2000); reintroduce; overload;

    procedure CarregarAlunos;
    procedure ConfigGrid;
    procedure SalvarAlunos;
    procedure AdicionarAluno(const Nome: string);
    procedure ExcluirAluno;
    procedure Incluir;
    procedure Listar;
    procedure Salvar;
    function Buscar(const TextoBusca: string): Integer; virtual;
  end;

implementation

{ TEstudantes }

constructor TEstudantes.Create(ALista: TStringGrid; ADados: TListBox; ABtnAdd, ABtnConf: TControl; ACodigoInicial: Integer);
begin
  inherited Create(ALista, ADados, ABtnAdd, ABtnConf, ACodigoInicial, 'C:\Users\gabri\OneDrive\Documentos\estudantes.txt');
end;

function TEstudantes.ArquivoFullPath: string;
begin
  Result := Arquivo;
end;



function TEstudantes.Buscar(const TextoBusca: string): Integer;
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
      // Dados.SetFocus;  <- Remova ou comente esta linha!
      Break;
    end;
  end;
end;

procedure TEstudantes.CarregarAlunos;
var
  ListaCarregar: TStringList;
  i, p: Integer;
  linha, codigo, nome: string;
  CaminhoArquivo: string;
begin
  CaminhoArquivo := 'C:\Users\gabi\OneDrive\Documents\estudantes.txt';
  ListaCarregar := TStringList.Create;
  try
    try
      ListaCarregar.LoadFromFile(CaminhoArquivo, TEncoding.UTF8);
    except
      ListaCarregar.LoadFromFile(CaminhoArquivo, TEncoding.Default);
    end;

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
  finally
    ListaCarregar.Free;
  end;
end;

procedure TEstudantes.ConfigGrid;
begin
  Lista.ColCount := 2;
  Lista.RowCount := 2;
  Lista.FixedRows := 1;
  Lista.Cells[0, 0] := 'Código';
  Lista.Cells[1, 0] := 'Nome';
  Lista.Options := Lista.Options + [goEditing];

  // Ajustar largura das colunas (opcional)
  Lista.ColWidths[0] := 80;   // largura para código
  Lista.ColWidths[1] := 200;  // largura para nome
end;

procedure TEstudantes.Salvar;
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

      CaminhoArquivo := 'C:\Users\gabi\OneDrive\Documents\estudantes.txt';

      ListaSalvar.SaveToFile(CaminhoArquivo);

      ShowMessage('Arquivo salvo com sucesso ');
    finally
      ListaSalvar.Free;
    end;
  except
    on E: Exception do
      ShowMessage('Erro ao salvar arquivo: ' + E.Message);
  end;
end;


procedure TEstudantes.SalvarAlunos;
begin
Self.ConfirmarDados;
end;

procedure TEstudantes.AdicionarAluno(const Nome: string);
var
  novaLinha: Integer;
begin

  FCodigo := Codigo;
  FNome := Nome;
  novaLinha := Lista.RowCount;
  Lista.RowCount := novaLinha + 1;
  Lista.Cells[0, novaLinha] := IntToStr(FCodigo);
  Lista.Cells[1, novaLinha] := FNome;

  Dados.Items.Add(IntToStr(FCodigo) + ' - ' + FNome);
end;

procedure TEstudantes.ExcluirAluno;
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

    // Atualiza o arquivo após exclusão
    Salvar;  // Chama o método que salva o conteúdo da TStringGrid no arquivo
  end
  else
    ShowMessage('Selecione um item para deletar.');
end;
procedure TEstudantes.Incluir;
begin
Self.MostrarIncluir;
end;

procedure TEstudantes.Listar;
begin
Self.MostrarListar;
end;

end.

unit UEstudantes;

interface

uses
  Vcl.Grids, Vcl.StdCtrls,Vcl.Dialogs, Vcl.Controls, UFunçoes, System.Classes, System.SysUtils;

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
    procedure Incluir;
    procedure Listar;
    procedure Salvar;
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

procedure TEstudantes.CarregarAlunos;
var
  ListaCarregar: TStringList;
  i: Integer;
  linha, codigo, nome: string;
  p: Integer;
begin
 var CaminhoArquivo := 'C:\Users\gabri\OneDrive\Documentos\estudantes.txt';
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
    end else
      Lista.RowCount := 1;
  finally
    ListaCarregar.Free;
  end;
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

      CaminhoArquivo := 'C:\Users\gabri\OneDrive\Documentos\estudantes.txt';

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
begin

end;

procedure TEstudantes.ExcluirAluno;
begin
Self.ExcluirLinha;
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

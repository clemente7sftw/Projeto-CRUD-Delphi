unit UDisciplinas;

interface
uses
  Vcl.Grids, Vcl.StdCtrls,Vcl.Dialogs, Vcl.Controls, UFunçoes, System.Classes, System.SysUtils;
  Type TDisciplina= class(TFunçoes)
  private

   public
     constructor Create(ALista: TStringGrid; ADados: TListBox; ABtnAdd, ABtnConf: TControl; ACodigoInicial: Integer = 1000); reintroduce; overload;
    procedure SalvarDisciplinas;
    procedure AdicionarDisciplina(const Nome: string);
    procedure CarregarDisciplinas;
    procedure Incluir;
    procedure Listar;
    procedure Salvar;
    procedure Excluir;
    end;
implementation


{ TDisciplina }

procedure TDisciplina.AdicionarDisciplina(const Nome: string);
begin

end;

procedure TDisciplina.CarregarDisciplinas;
var
  ListaCarregar: TStringList;
  i: Integer;
  linha, codigo, nome: string;
  p: Integer;
begin
 var CaminhoArquivo := 'C:\Users\gabri\OneDrive\Documentos\disciplinas.txt';
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

constructor TDisciplina.Create(ALista: TStringGrid; ADados: TListBox; ABtnAdd,
  ABtnConf: TControl; ACodigoInicial: Integer);
begin
  inherited Create(ALista, ADados, ABtnAdd, ABtnConf, ACodigoInicial, 'C:\Users\gabri\OneDrive\Documentos\disciplinas.txt');
end;

procedure TDisciplina.Excluir;
begin
    Self.ExcluirLinha;
end;

procedure TDisciplina.Incluir;
begin
    Self.MostrarIncluir;
end;

procedure TDisciplina.Listar;
begin
    Self.MostrarListar;
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

      CaminhoArquivo := 'C:\Users\gabri\OneDrive\Documentos\disciplinas.txt';

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


procedure TDisciplina.SalvarDisciplinas;
begin
 Self.ConfirmarDados;
end;

end.

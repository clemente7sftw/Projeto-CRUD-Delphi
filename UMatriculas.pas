unit UMatriculas;

interface
uses
  Vcl.Grids, Vcl.StdCtrls,Vcl.Dialogs, Vcl.Controls, UFunçoes, System.Classes, System.SysUtils;
  Type TMatriculas= class(TFunçoes)
  private

   public
     constructor Create(ALista: TStringGrid; ADados: TListBox; ABtnAdd, ABtnConf: TControl; ACodigoInicial: Integer = 100000); reintroduce; overload;
    procedure SalvarMatriculas;
    procedure AdicionarMatriculas(const Nome: string);
    procedure CarregarMatriculas;
    procedure Incluir;
    procedure Listar;
    procedure Salvar;
    procedure Excluir;
    end;

implementation
{ TMatriculas }

procedure TMatriculas.AdicionarMatriculas(const Nome: string);
begin

end;

procedure TMatriculas.CarregarMatriculas;
var
  ListaCarregar: TStringList;
  i: Integer;
  linha, codigo, nome: string;
  p: Integer;
begin
 var CaminhoArquivo := 'C:\Users\gabri\OneDrive\Documentos\matriculas.txt';
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

constructor TMatriculas.Create(ALista: TStringGrid; ADados: TListBox; ABtnAdd,
  ABtnConf: TControl; ACodigoInicial: Integer);
begin
   inherited Create(ALista, ADados, ABtnAdd, ABtnConf, ACodigoInicial, 'C:\Users\gabri\OneDrive\Documentos\matriculas.txt');
end;

procedure TMatriculas.Excluir;
begin
  Self.ExcluirLinha;
end;

procedure TMatriculas.Incluir;
begin
Self.MostrarIncluir;
end;

procedure TMatriculas.Listar;
begin
 Self.MostrarListar;
end;

procedure TMatriculas.Salvar;
var
  CaminhoArquivo: string;
  ListaSalvar: TStringList;
  i, codigo: Integer;
  nome, strCodigo, strCodigoEst,strCodigoTurma: string;
begin
  try
    ListaSalvar := TStringList.Create;
    try
      for i := 1 to Lista.RowCount - 1 do
      begin
        strCodigo := Trim(Lista.Cells[0, i]);
        strCodigoTurma      := Trim(Lista.Cells[1, i]);
        strCodigoEst    := Trim(Lista.Cells[2, i]);

        if (strCodigo <> '') and (strCodigoTurma <> '') and (strCodigoEst <> '') then
        begin
          ListaSalvar.Add(strCodigo + ' - ' + strCodigoTurma + ' - ' + strCodigoEst);
        end;
      end;

      CaminhoArquivo := 'C:\Users\gabri\OneDrive\Documentos\matriculas.txt';
      ListaSalvar.SaveToFile(CaminhoArquivo, TEncoding.UTF8);
      ShowMessage('Arquivo salvo com sucesso');
    finally
      ListaSalvar.Free;
    end;
  except
    on E: Exception do
      ShowMessage('Erro ao salvar arquivo: ' + E.Message);
  end;
end;

procedure TMatriculas.SalvarMatriculas;
begin
 Self.ConfirmarDadosGeral;
end;

end.

unit UMatriculas;

interface
uses
  Vcl.Grids, Vcl.StdCtrls,Vcl.Dialogs, Vcl.Controls, UFunçoes, System.Classes, System.SysUtils;
  Type TMatriculas= class(TFunçoes)
  private

   public
     constructor Create(ALista: TStringGrid; ADados: TListBox; ABtnAdd, ABtnConf: TControl; ACodigoInicial: Integer = 2000); reintroduce; overload;
    procedure SalvarMatriculas;
    procedure AdicionarMatriculas(const Nome: string);
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
  i, cpf, codigo: Integer;
  nome, strCodigo, strCpf: string;
begin
  try
    ListaSalvar := TStringList.Create;
    try
      for i := 1 to Lista.RowCount - 1 do
      begin
        strCodigo := Trim(Lista.Cells[0, i]);
        nome      := Trim(Lista.Cells[1, i]);
        strCpf    := Trim(Lista.Cells[2, i]);

        if (strCodigo <> '') and (nome <> '') and (strCpf <> '') then
        begin
          ListaSalvar.Add(strCodigo + ' - ' + nome + ' - ' + strCpf);
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

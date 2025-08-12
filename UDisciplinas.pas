<<<<<<< HEAD
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
=======
unit UDisciplinas;

interface
uses
  Vcl.Grids, Vcl.StdCtrls,Vcl.Dialogs, Vcl.Controls, UFunçoes, System.Classes, System.SysUtils;
  Type TDisciplina= class(TFunçoes)
  private

   public
     constructor Create(ALista: TStringGrid; ADados: TListBox; ABtnAdd, ABtnConf: TControl; ACodigoInicial: Integer = 2000); reintroduce; overload;
    procedure SalvarDisciplinas;
    procedure AdicionarDisciplina(const Nome: string);
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
>>>>>>> 12763858243fefdf2900cc6a6ed7af18491ddf6e
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
<<<<<<< HEAD
end;


procedure TDisciplina.SalvarDisciplinas;
begin
 Self.ConfirmarDados;
end;

end.
=======
end;


procedure TDisciplina.SalvarDisciplinas;
begin
 Self.ConfirmarDados;
end;

end.
>>>>>>> 12763858243fefdf2900cc6a6ed7af18491ddf6e

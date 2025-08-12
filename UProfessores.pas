<<<<<<< HEAD
unit UProfessores;

interface

uses
  Vcl.Grids, Vcl.StdCtrls,Vcl.Dialogs, Vcl.Controls, UFunçoes, System.Classes, System.SysUtils;
  Type TProfessor= class(TFunçoes)
  private

   public
    constructor Create(ALista: TStringGrid; ADados: TListBox; ABtnAdd, ABtnConf: TControl; ACodigoInicial: Integer = 50); reintroduce; overload;
    procedure SalvarProfessores;
    procedure AdicionarProfessor(const Nome: string);
    procedure Incluir;
    procedure Listar;
    procedure Salvar;
    procedure Excluir;
  end;
implementation

{ TProfessor }

procedure TProfessor.AdicionarProfessor(const Nome: string);
begin

end;

constructor TProfessor.Create(ALista: TStringGrid; ADados: TListBox; ABtnAdd,
  ABtnConf: TControl; ACodigoInicial: Integer);
begin
  inherited Create(ALista, ADados, ABtnAdd, ABtnConf, ACodigoInicial, 'C:\Users\gabri\OneDrive\Documentos\professores.txt');
end;

procedure TProfessor.Excluir;
begin
Self.ExcluirLinha;
end;

procedure TProfessor.Incluir;
begin
Self.MostrarIncluir;
end;

procedure TProfessor.Listar;
begin
Self.MostrarListar;
end;

procedure TProfessor.Salvar;
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

      CaminhoArquivo := 'C:\Users\gabri\OneDrive\Documentos\professores.txt';
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


procedure TProfessor.SalvarProfessores;
begin
Self.ConfirmarDadosGeral;
end;

end.
=======
unit UProfessores;

interface

uses
  Vcl.Grids, Vcl.StdCtrls,Vcl.Dialogs, Vcl.Controls, UFunçoes, System.Classes, System.SysUtils;
  Type TProfessor= class(TFunçoes)
  private

   public
    constructor Create(ALista: TStringGrid; ADados: TListBox; ABtnAdd, ABtnConf: TControl; ACodigoInicial: Integer = 2000); reintroduce; overload;
    procedure SalvarProfessores;
    procedure AdicionarProfessor(const Nome: string);
    procedure Incluir;
    procedure Listar;
    procedure Salvar;
    procedure Excluir;
  end;
implementation

{ TProfessor }

procedure TProfessor.AdicionarProfessor(const Nome: string);
begin

end;

constructor TProfessor.Create(ALista: TStringGrid; ADados: TListBox; ABtnAdd,
  ABtnConf: TControl; ACodigoInicial: Integer);
begin
  inherited Create(ALista, ADados, ABtnAdd, ABtnConf, ACodigoInicial, 'C:\Users\gabri\OneDrive\Documentos\professores.txt');
end;

procedure TProfessor.Excluir;
begin
Self.ExcluirLinha;
end;

procedure TProfessor.Incluir;
begin
Self.MostrarIncluir;
end;

procedure TProfessor.Listar;
begin
Self.MostrarListar;
end;

procedure TProfessor.Salvar;
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

      CaminhoArquivo := 'C:\Users\gabri\OneDrive\Documentos\professores.txt';
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


procedure TProfessor.SalvarProfessores;
begin
Self.ConfirmarDadosGeral;
end;

end.
>>>>>>> 12763858243fefdf2900cc6a6ed7af18491ddf6e

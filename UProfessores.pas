
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
    procedure CarregarProfessores;
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

procedure TProfessor.CarregarProfessores;
var
  ListaCarregar: TStringList;
  i: Integer;
  linha, codigo, nome: string;
  p: Integer;
begin
 var CaminhoArquivo := 'C:\Users\gabri\OneDrive\Documentos\professores.txt';
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
  i, cpf: Integer;
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


unit UTurmas;

interface

uses
  Vcl.Grids, Vcl.StdCtrls,Vcl.Dialogs, Vcl.Controls, UFunçoes, System.Classes, System.SysUtils;
  Type TTurmas= class(TFunçoes)
  private

   public
    constructor Create(ALista: TStringGrid; ADados: TListBox; ABtnAdd, ABtnConf: TControl; ACodigoInicial: Integer = 10000); reintroduce; overload;
    procedure SalvarTurmas;
    procedure AdicionaTurma(const Nome: string);
    procedure Incluir;
    procedure Listar;
    procedure Salvar;
    procedure Excluir;
  end;
implementation

{ TTurmas }

procedure TTurmas.AdicionaTurma(const Nome: string);
begin

end;

constructor TTurmas.Create(ALista: TStringGrid; ADados: TListBox; ABtnAdd,
  ABtnConf: TControl; ACodigoInicial: Integer);
begin
   inherited Create(ALista, ADados, ABtnAdd, ABtnConf, ACodigoInicial, 'C:\Users\gabri\OneDrive\Documentos\turmas.txt');
end;

procedure TTurmas.Excluir;
begin
Self.ExcluirLinha;
end;

procedure TTurmas.Incluir;
begin
Self.MostrarIncluir;
end;

procedure TTurmas.Listar;
begin
 Self.MostrarListar;
end;

procedure TTurmas.Salvar;
var
  CaminhoArquivo: string;
  ListaSalvar: TStringList;
  i, cpf, codigo: Integer;
  strCodigoPro, strCodigo, strCodigoDisc: string;
begin
  try
    ListaSalvar := TStringList.Create;
    try
      for i := 1 to Lista.RowCount - 1 do
      begin
        strCodigo := Trim(Lista.Cells[0, i]);
        strCodigoPro      := Trim(Lista.Cells[1, i]);
        strCodigoDisc    := Trim(Lista.Cells[2, i]);

        if (strCodigo <> '') and (strCodigoPro <> '') and (strCodigoDisc <> '') then
        begin
          ListaSalvar.Add(strCodigo + ' - ' + strCodigoPro + ' - ' + strCodigoDisc);
        end;
      end;

      CaminhoArquivo := 'C:\Users\gabri\OneDrive\Documentos\turmas.txt';
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

procedure TTurmas.SalvarTurmas;
begin
Self.ConfirmarDadosGeral;
end;

end.

unit UFunçoes;

interface

uses
  Vcl.Grids, Winapi.Windows, Vcl.StdCtrls, Vcl.Controls, System.Classes, System.SysUtils, Vcl.Dialogs;

type
  TFunçoes = class
  private
    FArquivo: string;
    FLista: TStringGrid;
    FDados: TListBox;
    FBtnAdd, FBtnConf: TControl;
    FCodigoInicial: Integer;

    function GetLista: TStringGrid;
    function GetDados: TListBox;
    function GetBtnAdd: TControl;
    function GetBtnConf: TControl;

    procedure SetLista(Value: TStringGrid);
    procedure SetDados(Value: TListBox);
    procedure SetBtnAdd(Value: TControl);
    procedure SetBtnConf(Value: TControl);

    procedure DeleteGridRow(AGrid: TStringGrid; ARow: Integer); // Método privado para remover linha da grid

  protected
    property Arquivo: string read FArquivo write FArquivo;
    property Dados: TListBox read GetDados write SetDados;
    property BtnAdd: TControl read GetBtnAdd write SetBtnAdd;
    property BtnConf: TControl read GetBtnConf write SetBtnConf;
    property CodigoInicial: Integer read FCodigoInicial write FCodigoInicial;

    function ProximoCodigo: Integer; virtual;
    procedure PreencherCodigoNovaLinha(novaLinha: Integer); virtual;

  public
    property Lista: TStringGrid read GetLista write SetLista;

    constructor Create(ALista: TStringGrid; ADados: TListBox; ABtnAdd, ABtnConf: TControl; ALimite: Integer; AArquivo: string);

    procedure AtualizarDados; virtual;
    procedure AdicionarLinha; virtual;
    procedure ConfirmarDados; virtual;
    procedure ExcluirLinha; virtual;
    procedure PrepararGrid; virtual;
    procedure MostrarIncluir; virtual;
    procedure MostrarListar; virtual;
    procedure CarregarDados; virtual;
    procedure TratarEnterParaNovaLinha(Key: Word); virtual;
  end;

implementation

constructor TFunçoes.Create(ALista: TStringGrid; ADados: TListBox; ABtnAdd, ABtnConf: TControl; ALimite: Integer; AArquivo: string);
begin
  inherited Create;
  FLista := ALista;
  FDados := ADados;
  FBtnAdd := ABtnAdd;
  FBtnConf := ABtnConf;
  FCodigoInicial := ALimite;
  FArquivo := AArquivo;
end;

function TFunçoes.GetDados: TListBox;
begin
  Result := FDados;
end;

function TFunçoes.GetBtnAdd: TControl;
begin
  Result := FBtnAdd;
end;

function TFunçoes.GetBtnConf: TControl;
begin
  Result := FBtnConf;
end;

function TFunçoes.GetLista: TStringGrid;
begin
  Result := FLista;
end;

procedure TFunçoes.SetDados(Value: TListBox);
begin
  FDados := Value;
end;

procedure TFunçoes.SetBtnAdd(Value: TControl);
begin
  FBtnAdd := Value;
end;

procedure TFunçoes.SetBtnConf(Value: TControl);
begin
  FBtnConf := Value;
end;

procedure TFunçoes.SetLista(Value: TStringGrid);
begin
  FLista := Value;
end;

procedure TFunçoes.DeleteGridRow(AGrid: TStringGrid; ARow: Integer);
var
  i, j: Integer;
begin
  if (ARow <= 0) or (ARow >= AGrid.RowCount) then Exit; // Não remove cabeçalho ou inválidos

  for i := ARow to AGrid.RowCount - 2 do
    for j := 0 to AGrid.ColCount - 1 do
      AGrid.Cells[j, i] := AGrid.Cells[j, i + 1];

  AGrid.RowCount := AGrid.RowCount - 1;
end;

function TFunçoes.ProximoCodigo: Integer;
var
  maxCodigo, i, cod: Integer;
begin
  maxCodigo := CodigoInicial - 1;
  for i := 1 to Lista.RowCount - 1 do
  begin
    cod := StrToIntDef(Lista.Cells[0, i], 0);
    if cod > maxCodigo then
      maxCodigo := cod;
  end;
  Result := maxCodigo + 1;
end;

procedure TFunçoes.PreencherCodigoNovaLinha(novaLinha: Integer);
begin
  Lista.Cells[0, novaLinha] := IntToStr(ProximoCodigo);
  Lista.Cells[1, novaLinha] := '';
end;

procedure TFunçoes.AdicionarLinha;
var
  novaLinha: Integer;
begin
  novaLinha := Lista.RowCount;
  Lista.RowCount := novaLinha + 1;
  PreencherCodigoNovaLinha(novaLinha);
  Lista.Row := novaLinha;
  Lista.Col := 1;
  Lista.SetFocus;
end;

procedure TFunçoes.AtualizarDados;
begin
  Lista.RowCount := 1;
  CarregarDados;
  MostrarListar;
end;

procedure TFunçoes.CarregarDados;
var
  ListaCarregar: TStringList;
  i: Integer;
  linha, codigo, nome: string;
  p: Integer;
begin
  ListaCarregar := TStringList.Create;
  try
    if FileExists(FArquivo) then
    begin
      ListaCarregar.LoadFromFile(FArquivo, TEncoding.UTF8);
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
      Lista.RowCount := 1; // limpa grid se arquivo não existe
  finally
    ListaCarregar.Free;
  end;
end;

procedure TFunçoes.ConfirmarDados;
var
  i: Integer;
  linha: string;
  ListaSalvar: TStringList;
begin
  Dados.Items.Clear;
  for i := 1 to Lista.RowCount - 1 do
  begin
    if (Trim(Lista.Cells[0, i]) <> '') and (Trim(Lista.Cells[1, i]) <> '') then
    begin
      linha := Lista.Cells[0, i] + ' - ' + Lista.Cells[1, i];
      Dados.Items.Add(linha);
    end;
  end;

  ListaSalvar := TStringList.Create;
  try
    ListaSalvar.Assign(Dados.Items);
    ListaSalvar.SaveToFile(FArquivo, TEncoding.UTF8);
  finally
    ListaSalvar.Free;
  end;
end;

procedure TFunçoes.ExcluirLinha;
var
  linhaAtual: Integer;
begin
  linhaAtual := Lista.Row;
  if (linhaAtual > 0) and (linhaAtual < Lista.RowCount) then
  begin
    DeleteGridRow(Lista, linhaAtual);

    if Dados.ItemIndex <> -1 then
      Dados.Items.Delete(Dados.ItemIndex);

    ConfirmarDados;
  end
  else
    ShowMessage('Selecione uma linha válida para excluir.');
end;

procedure TFunçoes.PrepararGrid;
begin
  Lista.Options := Lista.Options + [goEditing, goRowSelect];
end;

procedure TFunçoes.MostrarIncluir;
begin
  Dados.Visible := False;
  Lista.Visible := True;
  BtnAdd.Visible := True;
  BtnConf.Visible := True;
end;

procedure TFunçoes.MostrarListar;
begin
  Lista.Visible := False;
  Dados.Visible := True;
  BtnAdd.Visible := False;
  BtnConf.Visible := False;
end;

procedure TFunçoes.TratarEnterParaNovaLinha(Key: Word);
begin
  if Key = VK_RETURN then
  begin
    Key := 0;
    if Lista.Row < Lista.RowCount - 1 then
      Lista.Row := Lista.Row + 1
    else
      AdicionarLinha;
    Lista.Col := 1;
    Lista.SetFocus;
  end;
end;

end.

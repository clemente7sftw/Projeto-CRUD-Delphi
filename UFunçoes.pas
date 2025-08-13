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

    procedure DeleteGridRow(AGrid: TStringGrid; ARow: Integer);

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
    procedure ConfirmarDadosGeral; virtual;
    procedure ConfirmarDados; virtual;
    procedure MostrarIncluir; virtual;
    procedure MostrarListar; virtual;
    function Buscar(const TextoBusca: string): Integer; virtual;
    procedure ExcluirLinha;
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
  i: Integer;
begin
  if (ARow < 0) or (ARow >= AGrid.RowCount) then Exit;

  for i := ARow to AGrid.RowCount - 2 do
    AGrid.Rows[i].Assign(AGrid.Rows[i + 1]);

  AGrid.RowCount := AGrid.RowCount - 1;
end;

procedure TFunçoes.ExcluirLinha;
begin

end;

function TFunçoes.ProximoCodigo: Integer;
begin
end;

procedure TFunçoes.PreencherCodigoNovaLinha(novaLinha: Integer);
begin

end;

procedure TFunçoes.AdicionarLinha;
begin
end;

procedure TFunçoes.AtualizarDados;
begin
  Lista.RowCount := 1;
  MostrarListar;
end;

function TFunçoes.Buscar;
var
  i: Integer;
  TextoMinusculo, ItemMinusculo: string;
begin
  Result := -1;
  TextoMinusculo := LowerCase(Trim(TextoBusca));
  if TextoMinusculo = '' then Exit;

  for i := 0 to FDados.Items.Count - 1 do
  begin
    ItemMinusculo := LowerCase(FDados.Items[i]);
    if Pos(TextoMinusculo, ItemMinusculo) > 0 then
    begin
      Result := i;
      FDados.ItemIndex := i;
      FDados.SetFocus;
      Break;
    end;
  end;
end;

procedure TFunçoes.ConfirmarDados;
var
  i: Integer;
  linha: string;
begin
  Dados.Items.Clear;

  for i := 1 to Lista.RowCount - 1 do
  begin
    if (Trim(Lista.Cells[0, i]) <> '') and (Trim(Lista.Cells[1, i]) <> '') then
    begin
      linha := Lista.Cells[0, i] + ' - ' + Lista.Cells[1, i] ;
      Dados.Items.Add(linha);
    end;
  end;
end;

procedure TFunçoes.ConfirmarDadosGeral;
var
  i: Integer;
  linha: string;
begin
  Dados.Items.Clear;

  for i := 2 to Lista.RowCount - 1 do
  begin
    if (Trim(Lista.Cells[0, i]) <> '') and (Trim(Lista.Cells[1, i]) <> '')  and (Trim(Lista.Cells[2, i]) <> '') then
    begin
      linha := Lista.Cells[0, i] + ' - ' + Lista.Cells[1, i]+ ' - ' + Lista.Cells[2, i] ;
      Dados.Items.Add(linha);
    end;
  end;
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
    if Lista.Col < Lista.ColCount - 1 then
    begin
      Lista.Col := Lista.Col + 1;
    end
    else
    begin
      if Lista.Row < Lista.RowCount - 1 then
        Lista.Row := Lista.Row + 1
      else
        AdicionarLinha;

      Lista.Col := 0;
    end;

    Lista.SetFocus;
  end;
end;


end.

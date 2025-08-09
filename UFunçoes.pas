unit UFunçoes;

interface

uses
  Vcl.Grids, Vcl.StdCtrls, Vcl.Controls, System.Classes, System.SysUtils;

type
  TBaseGridManager = class
  private
    FLista: TStringGrid;
    FDados: TListBox;
    FBtnAdd, FBtnConf: TControl;

    function GetLista: TStringGrid;
    function GetDados: TListBox;
    function GetBtnAdd: TControl;
    function GetBtnConf: TControl;

    procedure SetLista(Value: TStringGrid);
    procedure SetDados(Value: TListBox);
    procedure SetBtnAdd(Value: TControl);
    procedure SetBtnConf(Value: TControl);

  protected

    property Dados: TListBox read GetDados write SetDados;
    property BtnAdd: TControl read GetBtnAdd write SetBtnAdd;
    property BtnConf: TControl read GetBtnConf write SetBtnConf;

  public
   property Lista: TStringGrid read GetLista write SetLista;
    constructor Create(ALista: TStringGrid; ADados: TListBox; ABtnAdd, ABtnConf: TControl); virtual;

    procedure AdicionarLinha(CodigoInicial: Integer); virtual;
    procedure ConfirmarDados; virtual;
    procedure ExcluirLinha; virtual;
    procedure PrepararGrid; virtual;
    procedure MostrarIncluir; virtual;
    procedure MostrarListar; virtual;
   end;

implementation

{ TBaseGridManager }

constructor TBaseGridManager.Create(ALista: TStringGrid; ADados: TListBox; ABtnAdd, ABtnConf: TControl);
begin
  inherited Create;
  FLista := ALista;
  FDados := ADados;
  FBtnAdd := ABtnAdd;
  FBtnConf := ABtnConf;
end;

function TBaseGridManager.GetDados: TListBox;
begin
  Result := FDados;
end;

function TBaseGridManager.GetBtnAdd: TControl;
begin
  Result := FBtnAdd;
end;

function TBaseGridManager.GetBtnConf: TControl;
begin
  Result := FBtnConf;
end;

function TBaseGridManager.GetLista: TStringGrid;
begin
  Result := FLista;
end;

procedure TBaseGridManager.SetDados(Value: TListBox);
begin
  FDados := Value;
end;

procedure TBaseGridManager.SetBtnAdd(Value: TControl);
begin
  FBtnAdd := Value;
end;

procedure TBaseGridManager.SetBtnConf(Value: TControl);
begin
  FBtnConf := Value;
end;

procedure TBaseGridManager.SetLista(Value: TStringGrid);
begin
  FLista := Value;
end;

procedure TBaseGridManager.AdicionarLinha(CodigoInicial: Integer);
var
  novaLinha: Integer;
begin
  novaLinha := Lista.RowCount;
  Lista.RowCount := novaLinha + 1;
  Lista.Cells[0, novaLinha] := IntToStr(CodigoInicial + novaLinha - 1);
  Lista.Cells[1, novaLinha] := '';
  Lista.Row := novaLinha;
  Lista.Col := 1;
  Lista.SetFocus;
end;

procedure TBaseGridManager.ConfirmarDados;
var
  i: Integer;
  linha: string;
begin
  Dados.Items.Clear;
  for i := 1 to Lista.RowCount - 1 do
  begin
    if (Lista.Cells[0, i] <> '') and (Lista.Cells[1, i] <> '') then
    begin
      linha := Lista.Cells[0, i] + ' - ' + Lista.Cells[1, i];
      Dados.Items.Add(linha);
    end;
  end;
end;

procedure TBaseGridManager.ExcluirLinha;
var
  linhaAtual: Integer;
begin
  linhaAtual := Lista.Row;
  if (linhaAtual > 0) and (linhaAtual < Lista.RowCount) then
  begin
    Lista.Rows[linhaAtual].Clear;
    if Dados.ItemIndex <> -1 then
      Dados.Items.Delete(Dados.ItemIndex);
  end;
end;

procedure TBaseGridManager.PrepararGrid;
begin
  Lista.Options := Lista.Options + [goEditing];
  if Lista.RowCount = 0 then
  begin
    Lista.RowCount := 2;
    Lista.ColCount := 2;
    Lista.Cells[0, 0] := 'Código';
    Lista.Cells[1, 0] := 'Nome';
  end;
end;

procedure TBaseGridManager.MostrarIncluir;
begin
  Dados.Visible := False;
  Lista.Visible := True;
  BtnAdd.Visible := True;
  BtnConf.Visible := True;
end;

procedure TBaseGridManager.MostrarListar;
begin
  Lista.Visible := False;
  Dados.Visible := True;
  BtnAdd.Visible := False;
  BtnConf.Visible := False;
end;


end.

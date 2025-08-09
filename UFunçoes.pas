unit UFunçoes;

interface

uses
  Vcl.Grids, Vcl.StdCtrls, System.SysUtils, Vcl.Controls;

function AdicionarLinhaGrid(Lista: TStringGrid; CodigoInicial: Integer): Integer;
procedure ConfirmarDadosGridParaListBox(Lista: TStringGrid; Dados: TListBox);
procedure ExcluirLinhaGrid(Lista: TStringGrid; Dados: TListBox);
procedure PrepararGridParaEdicao(Lista: TStringGrid);
procedure MostrarIncluir(Lista: TStringGrid; Dados: TListBox; BtnAdd, BtnConf: TControl);
procedure MostrarListar(Lista: TStringGrid; Dados: TListBox; BtnAdd, BtnConf: TControl);

implementation

function AdicionarLinhaGrid(Lista: TStringGrid; CodigoInicial: Integer): Integer;
var
  novaLinha: Integer;
begin
  novaLinha := Lista.RowCount;
  Lista.RowCount := novaLinha + 1;
  Lista.Cells[0, novaLinha] := IntToStr(CodigoInicial + novaLinha - 1);
  Lista.Cells[1, novaLinha] := '';
  Result := novaLinha;
  Lista.Row := novaLinha;
  Lista.Col := 1;
  Lista.SetFocus;
end;

procedure ConfirmarDadosGridParaListBox(Lista: TStringGrid; Dados: TListBox);
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

procedure ExcluirLinhaGrid(Lista: TStringGrid; Dados: TListBox);
var
  linhaAtual: Integer;
begin
  linhaAtual := Lista.Row;
  if (linhaAtual > 0) and (linhaAtual < Lista.RowCount) then
  begin
    Lista.Rows[linhaAtual].Clear;
    // Opcional: pode remover a linha, ou manter vazia
    // Lista.DeleteRow(linhaAtual); // TStringGrid não tem método DeleteRow nativo

    // Também remove do ListBox se selecionado
    if Dados.ItemIndex <> -1 then
      Dados.Items.Delete(Dados.ItemIndex);
  end;
end;

procedure PrepararGridParaEdicao(Lista: TStringGrid);
begin
  Lista.Options := Lista.Options + [goEditing];
  if Lista.RowCount = 0 then
  begin
    Lista.RowCount := 2; // pelo menos 1 linha + header
    Lista.Cells[0, 0] := 'Código';
    Lista.Cells[1, 0] := 'Nome';
  end;
end;

procedure MostrarIncluir(Lista: TStringGrid; Dados: TListBox; BtnAdd, BtnConf: TControl);
begin
  Dados.Visible := False;
  Lista.Visible := True;
  BtnAdd.Visible := True;
  BtnConf.Visible := True;
end;

procedure MostrarListar(Lista: TStringGrid; Dados: TListBox; BtnAdd, BtnConf: TControl);
begin
  Lista.Visible := False;
  Dados.Visible := True;
  BtnAdd.Visible := False;
  BtnConf.Visible := False;
end;

end.

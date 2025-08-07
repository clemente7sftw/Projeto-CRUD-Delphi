unit UEntidades;

interface

uses
System.Classes,  System.Generics.Collections, Dialogs, Vcl.Grids;

    type
     TEntidades = class (TObject)
     public
     procedure IncluirDados(Grid: TStringGrid; Codigo, Nome: string);
     procedure ListarDados;
     procedure AtualizarDados;
     procedure ExcluirDados;

    end;

implementation
 uses UMain2;

{ TEntidades }

procedure TEntidades.AtualizarDados;
begin

end;

procedure TEntidades.ExcluirDados;
begin
   ShowMessage ('Dados excuidos');
end;

procedure TEntidades.IncluirDados(Grid: TStringGrid; Codigo, Nome: string);

var
  NovaLinha: Integer;
begin
  NovaLinha := Grid.RowCount;
  Grid.RowCount := NovaLinha + 1;

  Grid.Cells[0, NovaLinha] := Codigo;
  Grid.Cells[1, NovaLinha] := Nome;
end;

procedure TEntidades.ListarDados;
begin

end;

end.

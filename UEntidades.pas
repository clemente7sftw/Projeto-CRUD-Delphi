unit UEntidades;

interface

type
  TEntidades = class
  private
    FCodigo: Integer;
    FNome: string;
  public
    constructor Create(Codigo: Integer; Nome: string);
    property Codigo: Integer read FCodigo write FCodigo;
    property Nome: string read FNome write FNome;
  end;

implementation

constructor TEntidades.Create(Codigo: Integer; Nome: string);
begin
  FCodigo := Codigo;
  FNome := Nome;
end;

end.

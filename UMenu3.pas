unit UMenu3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.StdCtrls;

type
  TForm3 = class(TForm)
    Image1: TImage;
    Menu: TPanel;
    PIncluir: TPanel;
    PListar: TPanel;
    PAtualizar: TPanel;
    PExcluir: TPanel;
    PSair: TPanel;
    MsgEnt: TLabel;
    Lista: TStringGrid;
    procedure PSairClick(Sender: TObject);
    procedure ListaKeyPress(Sender: TObject; var Key: Char);
    procedure ListaEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}
uses UMain2;

procedure TForm3.ListaEnter(Sender: TObject);
begin
    Lista.Cells[0,0]:= 'Código';
    Lista.Cells[1,0]:= 'Nome';
end;

procedure TForm3.ListaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Lista.RowCount := Lista.RowCount + 1; // Adiciona nova linha
    Lista.Row := Lista.RowCount - 1;      // Move para a nova linha
    Lista.Col := 0;                    // Volta para a primeira coluna
  end;
end;

procedure TForm3.PSairClick(Sender: TObject);
begin
    Form2.Show;
end;

end.

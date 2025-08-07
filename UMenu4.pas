unit UMenu4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.StdCtrls;

type
  TForm4 = class(TForm)
    Image1: TImage;
    Lista: TStringGrid;
    Menu: TPanel;
    PIncluir: TPanel;
    PListar: TPanel;
    PExcluir: TPanel;
    PSair: TPanel;
    PAtualizar: TPanel;
    MsgEnt: TLabel;
    procedure PSairClick(Sender: TObject);
    procedure ListaKeyPress(Sender: TObject; var Key: Char);
    procedure ListaEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

uses UMain2;

procedure TForm4.ListaEnter(Sender: TObject);
begin
    Lista.Cells[0,0]:= 'Código';
    Lista.Cells[1,0]:= 'Nome';
    Lista.Cells[2,0]:= 'CPF';
end;

procedure TForm4.ListaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    Lista.RowCount := Lista.RowCount + 1;
    Lista.Row := Lista.RowCount - 1;
    Lista.Col := 0;
  end;
end;

procedure TForm4.PSairClick(Sender: TObject);
begin
    Form2.Show;
end;

end.

unit UMenu3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.StdCtrls;

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
    BtnAdd: TButton;
    Dados: TListBox;
    BtnConf: TButton;

    procedure PSairClick(Sender: TObject);
    procedure ListaEnter(Sender: TObject);
    procedure BtnAddClick(Sender: TObject);
    procedure PExcluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PListarClick(Sender: TObject);
    procedure BtnConfClick(Sender: TObject);
    procedure PIncluirClick(Sender: TObject);
    procedure ListaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}
uses UMain2, UEntidades;

procedure TForm3.FormCreate(Sender: TObject);
begin
  Lista.Options := Lista.Options + [goEditing];
  Dados.Visible := False;
  Lista.Visible := False;
  BtnAdd.Visible := False;
  BtnConf.Visible := False;
end;

procedure TForm3.ListaEnter(Sender: TObject);
begin
  Lista.Cells[0, 0] := 'Código';
  Lista.Cells[1, 0] := 'Nome';
end;

procedure TForm3.BtnAddClick(Sender: TObject);
var
  novaLinha: Integer;
begin
  novaLinha := Lista.RowCount - 1;
  Lista.RowCount := novaLinha + 1;
  Lista.Cells[0, novaLinha] := IntToStr(100 + novaLinha); // Código começa em 100
  Lista.Cells[100, novaLinha] := ''; // Nome
  Lista.SetFocus;
end;

procedure TForm3.BtnConfClick(Sender: TObject);
var
  i: Integer;
  linha: string;
begin
  Dados.Items.Clear;
  for i := 1 to Lista.RowCount - 1 do
  begin
    linha := Lista.Cells[0, i] + ' - ' + Lista.Cells[1, i];
    Dados.Items.Add(linha);
  end;
end;

procedure TForm3.ListaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    Key := 0;

    if Lista.Row < Lista.RowCount - 1 then
      Lista.Row := Lista.Row + 1
    else
    begin
      Lista.RowCount := Lista.RowCount + 1;
      Lista.Row := Lista.RowCount - 1;
      Lista.Cells[0, Lista.Row] := IntToStr(100 + Lista.Row);
      Lista.Cells[1, Lista.Row] := '';
    end;

    Lista.Col := 1;
    Lista.SetFocus;
  end;
end;

procedure TForm3.PExcluirClick(Sender: TObject);
var
  Linha, Coluna: Integer;
begin
  Linha := Lista.Row;
  Coluna := Lista.Col;
  Lista.Cells[Coluna, Linha] := '';
  Lista.Cells[0, Linha] := '';
  Lista.Cells[1, Linha] := '';

  if Dados.ItemIndex <> -1 then
    Dados.Items.Delete(Dados.ItemIndex);
end;

procedure TForm3.PIncluirClick(Sender: TObject);
begin
  Dados.Visible := False;
  Lista.Visible := True;
  BtnAdd.Visible := True;
  BtnConf.Visible := True;

end;

procedure TForm3.PListarClick(Sender: TObject);
begin
  Lista.Visible := False;
  Dados.Visible := True;
end;

procedure TForm3.PSairClick(Sender: TObject);
begin
  Form2.Show;
end;

end.

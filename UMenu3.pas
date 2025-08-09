unit UMenu3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.Grids, UFunçoes, Vcl.StdCtrls, UEstudantes;

type
  TForm3 = class(TForm)
    Image1: TImage;
    Lista: TStringGrid;
    Menu: TPanel;
    PIncluir: TPanel;
    PListar: TPanel;
    PExcluir: TPanel;
    PSair: TPanel;
    PAtualizar: TPanel;
    MsgEnt: TLabel;
    BtnAdd: TButton;
    BtnConf: TButton;
    Dados: TListBox;
    procedure PSairClick(Sender: TObject);
    procedure ListaEnter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnAddClick(Sender: TObject);
    procedure PIncluirClick(Sender: TObject);
    procedure BtnConfClick(Sender: TObject);
    procedure ListaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PExcluirClick(Sender: TObject);
    procedure PListarClick(Sender: TObject);
    procedure PAtualizarClick(Sender: TObject);
  private
    FGridManager: TEstudantesGridManager;
    procedure AtualizarLista;
  public
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses UMain2;

procedure TForm3.BtnAddClick(Sender: TObject);
begin
  FGridManager.AdicionarLinha(2000);
end;



procedure TForm3.BtnConfClick(Sender: TObject);
var
  CaminhoArquivo: string;
  ListaSalvar: TStringList;
  i: Integer;
  codigo, nome: string;
begin
  try
    ListaSalvar := TStringList.Create;
    try
      for i := 1 to Lista.RowCount - 1 do
      begin
        codigo := Trim(Lista.Cells[0, i]);
        nome := Trim(Lista.Cells[1, i]);

        if (codigo <> '') and (nome <> '') then
          ListaSalvar.Add(codigo + ' - ' + nome);
      end;

      CaminhoArquivo := 'C:\Users\gabi\OneDrive\Documents\estudantes.txt';

      ListaSalvar.SaveToFile(CaminhoArquivo);

      ShowMessage('Arquivo salvo com sucesso em: ' + CaminhoArquivo);
    finally
      ListaSalvar.Free;
    end;
  except
    on E: Exception do
      ShowMessage('Erro ao salvar arquivo: ' + E.Message);
  end;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  FGridManager := TEstudantesGridManager.Create(Lista, Dados, BtnAdd, BtnConf);
  FGridManager.PrepararGrid;

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
begin
  try
    FGridManager.ExcluirLinha;
    ShowMessage('Linha excluída com sucesso!');
  except
    on E: Exception do
      ShowMessage('Erro ao excluir: ' + E.Message);
  end;
end;

procedure TForm3.PIncluirClick(Sender: TObject);
begin
  FGridManager.MostrarIncluir;
  BtnAdd.Visible := True;
  BtnConf.Visible := True;
  Dados.Visible := False;
  Lista.Visible := True;
end;

procedure TForm3.PListarClick(Sender: TObject);
begin
  FGridManager.MostrarListar;
  BtnAdd.Visible := False;
  BtnConf.Visible := False;
  Dados.Visible := True;
  Lista.Visible := False;
end;

procedure TForm3.PAtualizarClick(Sender: TObject);
begin
  AtualizarLista;
  ShowMessage('Lista atualizada!');
end;

procedure TForm3.PSairClick(Sender: TObject);
begin
  Form2.Show;
  Close;
end;

procedure TForm3.AtualizarLista;
begin
  FGridManager.CarregarAlunos;
end;

end.

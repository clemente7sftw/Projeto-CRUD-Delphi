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
    procedure FormCreate(Sender: TObject);
    procedure BtnAddClick(Sender: TObject);
    procedure BtnConfClick(Sender: TObject);
    procedure ListaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PExcluirClick(Sender: TObject);
    procedure PIncluirClick(Sender: TObject);
    procedure PListarClick(Sender: TObject);
    procedure PAtualizarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FGridManager: TEstudantes;
    procedure AtualizarLista;
  public
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses UMain2;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(FGridManager) then
    FGridManager.ConfirmarDados;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin

  Lista.Options := Lista.Options + [goRowSelect];
  Lista.ColCount := 2;
  Lista.Cells[0, 0] := 'Código';
  Lista.Cells[1, 0] := 'Nome';
  Lista.RowCount := 2;

FGridManager := TEstudantes.Create(Lista, Dados, BtnAdd, BtnConf, 2000);
FGridManager.CarregarAlunos;
  FGridManager.MostrarListar;
  FGridManager.CarregarDados;
end;

procedure TForm3.BtnAddClick(Sender: TObject);
begin
  FGridManager.AdicionarLinha;
end;

procedure TForm3.BtnConfClick(Sender: TObject);
begin
  FGridManager.ConfirmarDados;
  ShowMessage('Dados salvos com sucesso!');
end;

procedure TForm3.ListaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  FGridManager.TratarEnterParaNovaLinha(Key);
end;

procedure TForm3.PExcluirClick(Sender: TObject);
begin
  FGridManager.ExcluirAluno;
end;

procedure TForm3.PIncluirClick(Sender: TObject);
begin
  FGridManager.MostrarIncluir;
end;

procedure TForm3.PListarClick(Sender: TObject);
begin

  FGridManager.MostrarListar;
end;

procedure TForm3.PAtualizarClick(Sender: TObject);
begin
  FGridManager.CarregarDados;
  ShowMessage('Lista atualizada!');
  FGridManager.AtualizarDados;
end;

procedure TForm3.PSairClick(Sender: TObject);
begin
  Form2.Show;
  Close;
end;

procedure TForm3.AtualizarLista;
begin
  FGridManager.CarregarDados;
end;

end.

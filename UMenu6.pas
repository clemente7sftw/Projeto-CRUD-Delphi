unit UMenu6;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls,UTurmas, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.Imaging.jpeg;

type
  TForm6 = class(TForm)
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
    procedure ListaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnConfClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PIncluirClick(Sender: TObject);
    procedure PListarClick(Sender: TObject);
    procedure PExcluirClick(Sender: TObject);
  private
   var Turmas:TTurmas;
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

{$R *.dfm}

uses UMain2;

procedure TForm6.BtnConfClick(Sender: TObject);
begin
  Turmas.ConfirmarDadosGeral;
  Turmas.Salvar;
end;

procedure TForm6.FormCreate(Sender: TObject);
begin
Turmas := TTurmas.Create(Lista, Dados, BtnAdd, BtnConf);
end;

procedure TForm6.ListaEnter(Sender: TObject);
begin
    Lista.Cells[0,0]:= 'Código';
    Lista.Cells[1,0]:= 'Código Professor';
    Lista.Cells[2,0]:= 'Código Disciplina';
end;

procedure TForm6.ListaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
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
      Lista.Cells[0, Lista.Row] := IntToStr(200 + Lista.Row);
      Lista.Cells[1, Lista.Row] := '';
      Lista.Cells[2, Lista.Row] := '';
    end;

    Lista.Col := 1;
    Lista.SetFocus;
  end;
end;
procedure TForm6.PExcluirClick(Sender: TObject);
begin
Turmas.ExcluirLinha;
end;

procedure TForm6.PIncluirClick(Sender: TObject);
begin
  Turmas.MostrarIncluir;
end;

procedure TForm6.PListarClick(Sender: TObject);
begin
 Turmas.MostrarListar;
end;

procedure TForm6.PSairClick(Sender: TObject);
begin
     Form2.Show;
end;

end.

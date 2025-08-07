unit UMenu6;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids,
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
    procedure PSairClick(Sender: TObject);
    procedure ListaEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

{$R *.dfm}

uses UMain2;

procedure TForm6.ListaEnter(Sender: TObject);
begin
    Lista.Cells[0,0]:= 'Código';
    Lista.Cells[1,0]:= 'Código Professor';
end;

procedure TForm6.PSairClick(Sender: TObject);
begin
     Form2.Show;
end;

end.

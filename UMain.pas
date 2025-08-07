unit UMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls,UMain2, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Image1: TImage;
    FormLogin: TPanel;
    InptUser: TEdit;
    InptSenha: TEdit;
    Botão: TButton;
    MsgLogin: TLabel;
    MsgCred: TLabel;
    procedure BotãoClick(Sender: TObject);
    procedure InptSenhaChange(Sender: TObject);
  private
    { Private declarations }
  public

  end;

var
  Form1: TForm1;
  UserCorreto, User: String;
  SenhaCorreta, Senha: Integer;

implementation
procedure LoginValido;
begin
UserCorreto := 'Admin';
SenhaCorreta :=  1234;
end;

{$R *.dfm}

procedure TForm1.BotãoClick(Sender: TObject);
begin
  LoginValido;
  User := InptUser.Text;
  Senha := StrToInt(InptSenha.Text);
  if ((UserCorreto = User) and (SenhaCorreta = Senha )) then begin
    ShowMessage('Acesso Permitido');
    Form2 := TForm2.Create(Self);
    Form2.Align := alClient;
    Form2.Show;
  end else
  ShowMessage ('Acesso Negado.')
end;

procedure TForm1.InptSenhaChange(Sender: TObject);
begin
     InptSenha.PasswordChar := '*';
end;

end.

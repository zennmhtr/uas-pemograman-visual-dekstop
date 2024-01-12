unit udbLogin;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, odbcconn, Forms, Controls, Graphics, Dialogs,
  StdCtrls;

type

  { TfrmLogin }

  TfrmLogin = class(TForm)
    BLogin: TButton;
    BExit: TButton;
    edtUsername: TEdit;
    edtPassword: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SQLConnector1: TSQLConnector;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    procedure BExitClick(Sender: TObject);
    procedure BLoginClick(Sender: TObject);

  private

  public
    function Login: boolean;
    function GetRole: integer;
  end;

var
  frmLogin: TfrmLogin;
  Role: integer;

implementation

{$R *.lfm}

procedure TfrmLogin.BLoginClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TfrmLogin.BExitClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

function TfrmLogin.GetRole: integer;
begin
  Result := Role;
end;

function TfrmLogin.Login: boolean;
begin
  Result := False;
  SQLConnector1.Connected := True;
  try
    with SQLQuery1 do
    begin
      SQL.Text := 'SELECT * FROM user WHERE username = :username AND password = :password';
      Params.ParamByName('username').AsString := edtUsername.Text;
      Params.ParamByName('password').AsString := edtPassword.Text;
      Open;

      if RecordCount >= 1 then
      begin
          Role := FieldByName('role').AsInteger;
          Result := True;
      end;
    end;
  finally
    SQLConnector1.Connected := False;
    Release;
  end;
end;

end.


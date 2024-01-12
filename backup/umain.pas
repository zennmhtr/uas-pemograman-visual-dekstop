unit uMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, StdCtrls,
  uLogin, uDataBarang, uTransaksi, uReport, uDataKategoriBarang, uTambahTransaksi;

type

  { TfrmMain }


  TfrmMain = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    MainMenu1: TMainMenu;
    MenuFile: TMenuItem;
    MenuDataMaster: TMenuItem;
    MenuDataBarang: TMenuItem;
    MenuDataKategoriBarang: TMenuItem;
    MenuDataCustomer: TMenuItem;
    MenuTransaksi: TMenuItem;
    MenuLaporan: TMenuItem;
    MenuLogin: TMenuItem;
    MenuLogout: TMenuItem;
    MenuExit: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure MenuDataBarangClick(Sender: TObject);
    procedure MenuDataCustomerClick(Sender: TObject);
    procedure MenuDataKategoriBarangClick(Sender: TObject);
    procedure MenuExitClick(Sender: TObject);
    procedure MenuLaporanClick(Sender: TObject);
    procedure MenuLoginClick(Sender: TObject);
    procedure MenuLogoutClick(Sender: TObject);
    procedure MenuTransaksiClick(Sender: TObject);

  private
    FUsername: string;
    FRole: integer;

  public
    procedure DisableMenu(AMenu: TMenuItem);
    procedure EnableMenu(AMenu: TMenuItem);
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.lfm}

{ TfrmMain }

procedure TfrmMain.MenuLoginClick(Sender: TObject);
var
  frmLogin: TfrmLogin;
begin
  try
    frmLogin := TfrmLogin.Create(Self);
    Self.Hide;
    if frmLogin.ShowModal = mrOk then
    begin
      if frmLogin.Login then
      begin
         FUsername := frmLogin.edtUsername.Text;
         FRole := frmLogin.GetRole;
         EnableMenu(MainMenu1.Items);
         if FRole <> 1 then
         begin
            MenuDataMaster.Enabled := false;
            MenuLaporan.Enabled := false;
         end;
         MenuLogin.Enabled := false;
      end
      else
          ShowMessage('Gagal login');
    end;
  finally
    frmLogin.Free;
    Self.Show;
  end;
end;

procedure TfrmMain.MenuLogoutClick(Sender: TObject);
begin
  DisableMenu(MainMenu1.items);

  FUsername := '';
  FRole := 0;
  MenuFile.Enabled:=true;
  MenuLogin.Enabled:=true;
  MenuExit.Enabled:=true;
end;

procedure TfrmMain.MenuTransaksiClick(Sender: TObject);
var
   frmTambahTransaksi: TfrmTambahTransaksi;
begin
  try
   frmTambahTransaksi := TfrmTambahTransaksi.Create(Self);
   Self.Hide;
   if frmTambahTransaksi.ShowModal = mrOk then
   begin
   end
   finally
      Self.Show;
      frmTambahTransaksi.Free;
   end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  DisableMenu(MainMenu1.items);
  MenuFile.Enabled:=true;
  MenuLogin.Enabled:=true;
  MenuExit.Enabled:=true;
end;

procedure TfrmMain.MenuDataBarangClick(Sender: TObject);
var
  frmDataBarang: TfrmDataBarang;
begin
  try
    frmDataBarang := TfrmDataBarang.Create(Self);
    Self.Hide;
    if frmDataBarang.ShowModal = mrOk then
    begin
    end;
  finally
    frmDataBarang.Free;
    Self.Show;
  end;
end;

procedure TfrmMain.MenuDataCustomerClick(Sender: TObject);
var
  frmTransaksi: TfrmTransaksi;
begin
  try
    frmTransaksi := TfrmTransaksi.Create(Self);
    Self.Hide;
    if frmTransaksi.ShowModal = mrOk then
    begin
    end;
  finally
    frmTransaksi.Free;
    Self.Show;
  end;
end;

procedure TfrmMain.MenuDataKategoriBarangClick(Sender: TObject);
var
  frmDataKategoriBarang: TfrmDataKategoriBarang;
begin
  try
    frmDataKategoriBarang := TfrmDataKategoriBarang.Create(Self);
    Self.Hide;
    if frmDataKategoriBarang.ShowModal = mrOk then
    begin
    end;
  finally
    frmDataKategoriBarang.Free;
    Self.Show;
  end;
end;

procedure TfrmMain.MenuExitClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmMain.MenuLaporanClick(Sender: TObject);
var
  frmReport: TTfrmReport;
begin
  try
    frmReport := TTfrmReport.Create(Self);
    Self.Hide;
    if frmReport.ShowModal = mrOk then
    begin
    end;
  finally
    frmReport.Free;
    Self.Show;
  end;
end;

procedure TfrmMain.DisableMenu(AMenu: TMenuItem);
var
  i: integer;
begin
  for i := 0 to AMenu.Count - 1 do
  begin
    AMenu[i].Enabled := false;
    DisableMenu(AMenu[i]);
  end;
end;

procedure TfrmMain.EnableMenu(AMenu: TMenuItem);
var
  i: integer;
begin
  for i := 0 to AMenu.Count - 1 do
  begin
    AMenu[i].Enabled := true;
    EnableMenu(AMenu[i]);
  end;
end;

end.


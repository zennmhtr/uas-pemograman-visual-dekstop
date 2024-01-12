unit uDataBarang;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, SQLDB, odbcconn, Forms, Controls, Graphics, Dialogs, uTambahBarang, uUpdateBarang,
  StdCtrls, DBCtrls, DBGrids;

type

  { TfrmDataBarang }

  TfrmDataBarang = class(TForm)
    btnCari: TButton;
    btnReset: TButton;
    btnTambah: TButton;
    btnUbah: TButton;
    btnHapus: TButton;
    DataSource1: TDataSource;
    DBGridDataBarang: TDBGrid;
    edtCari: TEdit;
    LJudul: TLabel;
    SQLConnector1: TSQLConnector;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    procedure btnCariClick(Sender: TObject);
    procedure btnHapusClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure btnTambahClick(Sender: TObject);
    procedure btnUbahClick(Sender: TObject);
    procedure DBGridDataBarangCellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public
    procedure AmbilDataBarang;
  end;

var
  frmDataBarang: TfrmDataBarang;
  idGrid: integer;

implementation

{$R *.lfm}

{ TfrmDataBarang }

procedure TfrmDataBarang.AmbilDataBarang;
begin
with SQLQuery1 do
  begin
    Close;
    SQL.Text := 'SELECT d.id, d.nama, k.nama as kategori, d.harga_beli, d.harga_jual, d.stok  FROM data_barang as d JOIN kategori as k ON k.id = d.kategori_id';
    Open;
  end;
end;

procedure TfrmDataBarang.FormCreate(Sender: TObject);
begin
  AmbilDataBarang;
end;

procedure TfrmDataBarang.btnCariClick(Sender: TObject);
begin
  with SQLQuery1 do
  begin
    Close;
    SQL.Text := 'SELECT d.id, d.nama, k.nama as kategori, d.harga_beli, d.harga_jual, d.stok  FROM data_barang as d JOIN kategori as k ON k.id = d.kategori_id WHERE d.nama LIKE :nama ';
    Params.ParamByName('nama').AsString := '%' + edtCari.Text + '%';
    Open;
  end;
end;

procedure TfrmDataBarang.btnHapusClick(Sender: TObject);
var
  Response: Integer;
begin
  if idGrid <> 0 then
  begin
       Response := MessageDlg('Anda yakin ingin menghapus?', mtConfirmation, mbYesNo, 0);
       if Response = mrYes then
       begin
       try
          with SQLQuery1 do
          begin
               Close;
               SQL.Text := 'DELETE FROM data_barang WHERE id = :id ';
               Params.ParamByName('id').AsString := IntToStr(idGrid);
               ExecSQL;
               SQLTransaction1.Commit;
               AmbilDataBarang;
          end;
       except
         on E: Exception do
         begin
            ShowMessage('Terjadi Kesalahan : ' + E.Message);
            SQLTransaction1.Rollback;
         end;
      end;
  end;
  end
  else
    ShowMessage('Klik data yang ingin dihapus terlebih dahulu');
end;

procedure TfrmDataBarang.btnResetClick(Sender: TObject);
begin
  edtCari.Text := '';
  AmbilDataBarang;
end;

procedure TfrmDataBarang.btnTambahClick(Sender: TObject);
var
  frmTambahBarang: TfrmTambahBarang;
begin
  try
    frmTambahBarang := TfrmTambahBarang.Create(Self);
    Self.Hide;
    if frmTambahBarang.ShowModal = mrOk then
    begin
       ModalResult := mrOk;
    end
    else
       Self.Show;
  finally
    frmTambahBarang.Free;
  end;
end;

procedure TfrmDataBarang.btnUbahClick(Sender: TObject);
var
  frmUpdateBarang: TfrmUpdateBarang;
begin
  try
    frmUpdateBarang := TfrmUpdateBarang.Create(Self);
    Self.Hide;
    if frmUpdateBarang.ShowModal = mrOk then
    begin
      ModalResult := mrOk;
    end
    else
      Self.Show;
  finally
    frmUpdateBarang.Free;
  end;
end;

procedure TfrmDataBarang.DBGridDataBarangCellClick(Column: TColumn);
begin
  idGrid := StrToInt(DBGridDataBarang.DataSource.DataSet.FieldByName('id').AsString);
end;

procedure TfrmDataBarang.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
   ModalResult := mrOk;
end;

end.


unit udbTambahBarang;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, SQLDB, odbcconn, Forms, Controls, Graphics, Dialogs,
  StdCtrls, DBCtrls;

type

  { TfrmTambahBarang }

  TfrmTambahBarang = class(TForm)
    btnSimpan: TButton;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DBLookupkategori: TDBLookupComboBox;
    edtJumlahStok: TEdit;
    edtHargaJual: TEdit;
    edtHargaBeli: TEdit;
    edtNama: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    SQLConnector1: TSQLConnector;
    SQLQuery1: TSQLQuery;
    SQLQuery2: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    procedure btnSimpanClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public
     add: boolean

  end;

var
  frmTambahBarang: TfrmTambahBarang;

implementation

{$R *.lfm}

{ TfrmTambahBarang }
procedure TfrmTambahBarang.btnSimpanClick(Sender: TObject);
begin
  try
    if SQLQuery2.Active then
      SQLQuery2.Close;

    with SQLQuery2 do
    begin
      SQL.Clear;
      SQL.Add('INSERT INTO data_barang (nama, kategori_id, harga_beli, harga_jual, stok)');
      SQL.Add('VALUES (:nama, :kategori_id, :harga_beli, :harga_jual, :stok)');
      Params.ParamByName('nama').AsString := edtNama.Text;
      Params.ParamByName('kategori_id').AsInteger := StrToInt(DBLookupkategori.KeyValue);
      Params.ParamByName('harga_beli').AsInteger := StrToInt(edtHargaBeli.Text);
      Params.ParamByName('harga_jual').AsInteger := StrToInt(edtHargaJual.Text);
      Params.ParamByName('stok').AsInteger := StrToInt(edtJumlahStok.Text);
      ExecSQL;
      SQLTransaction1.Commit;

      edtNama.Text := '';
      edtHargaBeli.Text := '';
      edtHargaJual.Text := '';
      edtJumlahStok.Text := '';
      add := True;

      ShowMessage('Berhasil Menambahkan Barang');
    end;

    if SQLQuery1.Active then
      SQLQuery1.Close;
  except
    on E: Exception do
      ShowMessage('Terjadi Kesalahan : ' + E.Message);
  end;
end;


procedure TfrmTambahBarang.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  if add = True then
  begin
      add := False;
      ModalResult:= mrOk;
  end
  else
      ModalResult:= mrCancel;
end;

procedure TfrmTambahBarang.FormCreate(Sender: TObject);
begin
  SQLQuery1.Open;
end;

end.


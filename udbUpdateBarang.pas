unit udbUpdateBarang;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, SQLDB, odbcconn, Forms, Controls, Graphics, Dialogs,
  StdCtrls, DBCtrls, Menus;

type

  { TfrmUpdateBarang }

  TfrmUpdateBarang = class(TForm)
    btnSimpan: TButton;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    DBLookupId: TDBLookupComboBox;
    DBLookupkategori: TDBLookupComboBox;
    edtJumlahStok: TEdit;
    edtHargaJual: TEdit;
    edtHargaBeli: TEdit;
    edtNama: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    SQLConnector1: TSQLConnector;
    SQLQuery1: TSQLQuery;
    SQLQuery2: TSQLQuery;
    SQLQuery3: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    procedure btnSimpanClick(Sender: TObject);
    procedure DBLookupIdChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public
    upd: boolean;

  end;

var
  frmUpdateBarang: TfrmUpdateBarang;

implementation

{$R *.lfm}

{ TfrmUpdateBarang }
procedure TfrmUpdateBarang.btnSimpanClick(Sender: TObject);
begin
  try
    if SQLQuery2.Active then
      SQLQuery2.Close;

    with SQLQuery2 do
    begin
      SQL.Clear;
      SQL.Add('UPDATE data_barang SET nama=:nama, kategori_id=:kategori_id, harga_beli=:harga_beli, harga_jual=:harga_jual, stok=:stok');
      SQL.Add('WHERE id = :id');
      Params.ParamByName('nama').AsString:=edtNama.Text;
      Params.ParamByName('kategori_id').AsInteger:=DBLookupkategori.KeyValue;
      Params.ParamByName('id').AsInteger:=DBLookupId.KeyValue;
      Params.ParamByName('harga_beli').AsInteger:=StrToInt(edtHargaBeli.Text);
      Params.ParamByName('harga_jual').AsInteger:=StrToInt(edtHargaJual.Text);
      Params.ParamByName('stok').AsInteger:=StrToInt(edtJumlahStok.Text);
      ExecSQL;
      SQLTransaction1.Commit;

      edtNama.Text:='';
      edtHargaBeli.Text:='';
      edtHargaJual.Text:='';
      edtJumlahStok.Text:='';
      upd := True;
      ShowMessage('Berhasil Mengupdate Barang');
    end;

    if SQLQuery1.Active then
      SQLQuery1.Close;
    if SQLQuery3.Active then
      SQLQuery3.Close;

    SQLQuery1.Open;
    SQLQuery3.Open;
  except
    on E: Exception do
      ShowMessage('Terjadi Kesalahan : ' + E.message);
  end;
end;


procedure TfrmUpdateBarang.DBLookupIdChange(Sender: TObject);
var
  id: string;
begin
  try
    SQLQuery3.SQL.Clear;
    SQLQuery3.Params.Clear;
    SQLQuery3.SQL.Add('SELECT * FROM data_barang WHERE id = :id');
    SQLQuery3.Params.ParamByName('id').AsInteger := DBLookupId.KeyValue;
    SQLQuery3.Close;
    SQLQuery3.Open;
    id := IntToStr(DBLookupId.KeyValue);

    edtNama.Text := SQLQuery3.FieldByName('nama').AsString;
    edtHargaJual.Text := SQLQuery3.FieldByName('harga_jual').AsString;
    edtHargaBeli.Text := SQLQuery3.FieldByName('harga_beli').AsString;
    edtJumlahStok.Text := SQLQuery3.FieldByName('stok').AsString;
    DBLookupkategori.ListSource := Datasource1;
    DBLookupkategori.ListField := 'nama';
    DBLookupkategori.KeyValue:=SQLQuery3.FieldByName('kategori_id').AsString;
  except
    on E: Exception do
      ShowMessage('Terjadi Kesalahan : ' + E.Message);
  end;

  try
    SQLQuery3.SQL.Clear;
    SQLQuery3.Params.Clear;
    SQLQuery3.SQL.Add('SELECT * FROM data_barang');
    SQLQuery3.Close;
    SQLQuery3.Open;
    DBLookupId.keyValue:= id;
  except
    on E: Exception do
      ShowMessage('Terjadi Kesalahan : ' + E.Message);
  end;
end;

procedure TfrmUpdateBarang.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  if upd = True then
  begin
       upd := False;
       ModalResult:= mrOk;
  end
  else
      ModalResult:= mrCancel;
end;

procedure TfrmUpdateBarang.FormCreate(Sender: TObject);
begin
  SQLQuery1.Open;
end;

end.


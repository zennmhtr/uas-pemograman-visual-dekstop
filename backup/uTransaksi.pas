unit uTransaksi;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, SQLDB, odbcconn, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls, DBGrids, Menus, ActnList, Buttons, MaskEdit, ComCtrls, DBCtrls, uTambahTransaksi;

type
  { TfrmTransaksi }

  TfrmTransaksi = class(TForm)
    btnCari: TButton;
    btnReset: TButton;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DBNavigator1: TDBNavigator;
    ECari: TEdit;
    Label1: TLabel;
    SQLConnector1: TSQLConnector;
    SQLQuery1: TSQLQuery;
    SQLQuery2: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    procedure btnCariClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure DBNavigator1Click(Sender: TObject; Button: TDBNavButtonType);
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private
    procedure CariData(customer: string; SQ: TSQLQuery);

  public
    procedure AmbilDataTransaksi;
    procedure AmbilDataDetailTransaksi;
  end;

var
  frmTransaksi: TfrmTransaksi;

implementation

{$R *.lfm}

procedure TfrmTransaksi.CariData(customer: string; SQ: TSQLQuery);
begin
   try
     if SQ = SQLQuery1 then
     begin
       with SQLQuery1 do
       begin
          Close;
          SQL.Text := 'SELECT dt.id, t.customer, t.tanggal as tanggal_transaksi, dt.jumlah, dt.diskon as diskon_beli_barang, t.diskon as diskon_transaksi, t.sub_total, t.total, db.harga_beli, db.harga_jual, db.nama as nama_barang, k.nama as kategori FROM detail_transaksi as dt JOIN data_barang as db ON db.id = dt.barang_id JOIN kategori as k ON k.id = db.kategori_id JOIN transaksi as t ON dt.transaksi_id = t.id WHERE t.customer LIKE :customer';
          Params.ParamByName('customer').AsString := '%' + ECari.Text + '%';
          Open;
       end;
     end
     else if SQ = SQLQuery2 then
     begin
      with SQLQuery2 do
      begin
        Close;
        SQL.Text := 'SELECT * FROM transaksi WHERE customer LIKE :customer';
        Params.ParamByName('customer').AsString := '%' + customer + '%';
        Open;
      end;
     end;
   except
    on E: Exception do
       ShowMessage('Terjadi Kesalahan : ' + E.message);
   end;
end;

procedure TfrmTransaksi.AmbilDataDetailTransaksi;
begin
with SQLQuery1 do
  begin
    Close;
    SQL.Text := 'SELECT dt.id, t.customer, t.tanggal as tanggal_transaksi, dt.jumlah, dt.diskon as diskon_beli_barang, t.diskon as diskon_transaksi, t.sub_total, t.total, db.harga_beli, db.harga_jual, db.nama as nama_barang, k.nama as kategori FROM detail_transaksi as dt JOIN data_barang as db ON db.id = dt.barang_id JOIN kategori as k ON k.id = db.kategori_id JOIN transaksi as t ON dt.transaksi_id = t.id';
    Open;
  end;
end;

procedure TfrmTransaksi.FormCreate(Sender: TObject);
begin
     AmbilDataDetailTransaksi;
     AmbilDataTransaksi;
end;

procedure TfrmTransaksi.Label1Click(Sender: TObject);
begin

end;

procedure TfrmTransaksi.btnCariClick(Sender: TObject);
begin
     CariData(ECari.Text, SQLQuery1);
     CariData(ECari.Text, SQLQuery2);
end;

procedure TfrmTransaksi.btnResetClick(Sender: TObject);
begin
    AmbilDataDetailTransaksi;
    AmbilDataTransaksi;
    ECari.Text := '';
end;

procedure TfrmTransaksi.DBNavigator1Click(Sender: TObject;
  Button: TDBNavButtonType);
var
   frmTambahTransaksi: TfrmTambahTransaksi;
begin
    if Button = nBInsert then
    begin
     try
      frmTambahTransaksi := TfrmTambahTransaksi.Create(Self);
      Self.Hide;
      if frmTambahTransaksi.ShowModal = mrOk then
      begin
        ModalResult := mrOk;
      end
      else
        Self.Show;
     finally
        frmTambahTransaksi.Free;
     end;
    end;
end;

procedure TfrmTransaksi.AmbilDataTransaksi;
begin
with SQLQuery2 do
  begin
    Close;
    SQL.Text := 'SELECT * FROM transaksi';
    Open;
  end;
end;

end.


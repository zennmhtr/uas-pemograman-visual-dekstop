unit uReport;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, SQLDB, Forms, Controls, Graphics, Dialogs, DBGrids,
  StdCtrls, EditBtn, ExtDlgs, LR_Class, LR_DBSet, DateUtils;

type

  { TTfrmReport }

  TTfrmReport = class(TForm)
    btnCari: TButton;
    btnReset: TButton;
    btnLaporan: TButton;
    DataSource1: TDataSource;
    DateEdit1: TDateEdit;
    DateEdit2: TDateEdit;
    DBGrid1: TDBGrid;
    ECari: TEdit;
    frDBDataSet1: TfrDBDataSet;
    frReport1: TfrReport;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    SQLConnector1: TSQLConnector;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    procedure btnCariClick(Sender: TObject);
    procedure btnLaporanClick(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    id: integer;

  public

  end;

var
  TfrmReport: TTfrmReport;

implementation

{$R *.lfm}

{ TTfrmReport }

procedure TTfrmReport.btnCariClick(Sender: TObject);
begin
  with SQLQuery1 do
  begin
     Close;
     SQL.Clear;
     SQL.Add('SELECT dt.id, t.customer, t.tanggal as tanggal_transaksi, dt.jumlah, dt.diskon as diskon_beli_barang, t.diskon as diskon_transaksi, t.sub_total, t.total, db.harga_beli, db.harga_jual, db.nama as nama_barang, k.nama as kategori FROM detail_transaksi as dt JOIN data_barang as db ON db.id = dt.barang_id JOIN kategori as k ON k.id = db.kategori_id JOIN transaksi as t ON dt.transaksi_id = t.id');
     if ECari.Text <> '' then
     begin
        SQL.Add('WHERE t.customer = :customer');
        Params.ParamByName('customer').AsString := ECari.Text;

        if (DateEdit1.Date <> 0) and (DateEdit2.Date <> 0) then
        begin
            SQL.Add('AND t.tanggal >= :date_from');
            SQL.Add('AND t.tanggal <= :date_to');

            Params.ParamByName('date_from').AsDate := DateEdit1.Date;
            Params.ParamByName('date_to').AsDate := DateEdit2.Date;
        end;
     end
     else
     begin
        if (DateEdit1.Date <> 0) and (DateEdit2.Date <> 0) then
        begin
             SQL.Add('AND t.tanggal >= :date_from');
             SQL.Add('AND t.tanggal <= :date_to');
             Params.ParamByName('date_from').AsDate := DateEdit1.Date;
             Params.ParamByName('date_to').AsDate := DateEdit2.Date;
        end;
     end;
     Open;
  end;
end;

procedure TTfrmReport.btnLaporanClick(Sender: TObject);
var
  s: string;
begin
  try
   if ECari.Text <> '' then
   begin
     s := extractfilepath(application.ExeName) + 'laporan.lrf';
   end
   else
   begin
     s := extractfilepath(application.ExeName) + 'report_all.lrf';
   end;

   frDBDataSet1.DataSet := SQLQuery1;
   frReport1.DataSet := frDBDataSet1;
   frReport1.LoadFromFile(s);
   frReport1.ShowReport;
  finally
   frReport1.Clear;
  end;
end;

procedure TTfrmReport.btnResetClick(Sender: TObject);
begin
  with SQLQuery1 do
  begin
     Close;
     SQL.Clear;
     SQL.Add('SELECT dt.id, t.customer, t.tanggal as tanggal_transaksi, dt.jumlah, dt.diskon as diskon_beli_barang, t.diskon as diskon_transaksi, t.sub_total, t.total, db.harga_beli, db.harga_jual, db.nama as nama_barang, k.nama as kategori FROM detail_transaksi as dt JOIN data_barang as db ON db.id = dt.barang_id JOIN kategori as k ON k.id = db.kategori_id JOIN transaksi as t ON dt.transaksi_id = t.id');
     Open;
  end;
  ECari.Text := '';
  DateEdit1.Date := 0;
  DateEdit1.Date := 0;
end;

procedure TTfrmReport.FormCreate(Sender: TObject);
begin

end;

end.


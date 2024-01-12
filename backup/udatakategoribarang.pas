unit uDataKategoriBarang;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, odbcconn, DB, Forms, Controls, Graphics, Dialogs,
  DBGrids, StdCtrls, uTambahKategori, uUpdateKategori;

type

  { TfrmDataKategoriBarang }

  TfrmDataKategoriBarang = class(TForm)
    BtnAddKategori: TButton;
    BtnReset: TButton;
    BtnDelete: TButton;
    BtnCari: TButton;
    DataSource1: TDataSource;
    DBGridKategori: TDBGrid;
    edtCari: TEdit;
    Label1: TLabel;
    SQLConnector1: TSQLConnector;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    procedure BtnAddKategoriClick(Sender: TObject);
    procedure BtnCariClick(Sender: TObject);
    procedure BtnDeleteClick(Sender: TObject);
    procedure BtnResetClick(Sender: TObject);
    procedure BtnUpdateClick(Sender: TObject);
    procedure DBGridKategoriCellClick(Column: TColumn);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    procedure AmbilKategori;

  public

  end;

var
  frmDataKategoriBarang: TfrmDataKategoriBarang;
  idGrid: integer;

implementation

{$R *.lfm}

{ TfrmDataKategoriBarang }

procedure TfrmDataKategoriBarang.AmbilKategori;
begin
with SQLQuery1 do
  begin
    Close;
    SQL.Text := 'SELECT * FROM kategori';
    Open;
  end;
end;

procedure TfrmDataKategoriBarang.FormCreate(Sender: TObject);
begin
end;

procedure TfrmDataKategoriBarang.BtnDeleteClick(Sender: TObject);
var
  Response: Integer;
begin
  if idGrid <> 0 then
  begin
    Response := MessageDlg('Apakah yakin menghapus ini?', mtConfirmation, mbYesNo, 0);
    if Response = mrYes then
    begin
      try
          with SQLQuery1 do
          begin
            Close;
            SQL.Text := 'DELETE FROM kategori WHERE id = :id ';
            Params.ParamByName('id').AsString := IntToStr(idGrid);
            ExecSQL;
            SQLTransaction1.Commit;
            AmbilKategori;
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

procedure TfrmDataKategoriBarang.BtnResetClick(Sender: TObject);
begin
   AmbilKategori;
   edtCari.Text:='';
end;

procedure TfrmDataKategoriBarang.BtnUpdateClick(Sender: TObject);
var
  frmUbahKategori: TfrmUbahKategori;
begin
  if idGrid <> 0 then
  begin
    try
      frmUbahKategori := TfrmUbahKategori.Create(Self);
      Self.Hide;
      frmUbahKategori.setId(idGrid);
      frmUbahKategori.setNama;
      if frmUbahKategori.ShowModal = mrOk then
      begin
         ModalResult := mrOk;
      end
      else
         Self.Show;
    finally
      frmUbahKategori.Free;
    end;
  end
  else
    ShowMessage('Error');
end;

procedure TfrmDataKategoriBarang.BtnCariClick(Sender: TObject);
begin
  with SQLQuery1 do
  begin
    Close;
    SQL.Text := 'SELECT * FROM kategori WHERE nama LIKE :nama ';
    Params.ParamByName('nama').AsString := '%' + edtCari.Text + '%';
    Open;
  end;
end;

procedure TfrmDataKategoriBarang.BtnAddKategoriClick(Sender: TObject);
var
  frmTambahKategori: TfrmTambahKategori;
begin
  try
    frmTambahKategori := TfrmTambahKategori.Create(Self);
    Self.Hide;
    if frmTambahKategori.ShowModal = mrOk then
    begin
       ModalResult := mrOk;
    end
    else
       Self.Show;
  finally
    frmTambahKategori.Free;
  end;
end;

procedure TfrmDataKategoriBarang.DBGridKategoriCellClick(Column: TColumn);
begin
   idGrid := StrToInt(DBGridKategori.DataSource.DataSet.FieldByName('id').AsString);
end;

procedure TfrmDataKategoriBarang.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
   ModalResult := mrOk;
end;

end.


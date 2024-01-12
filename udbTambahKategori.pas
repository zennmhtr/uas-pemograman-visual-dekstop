unit udbTambahKategori;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, DB, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TfrmTambahKategori }

  TfrmTambahKategori = class(TForm)
    BtnTambahKategori: TButton;
    DataSource1: TDataSource;
    edtKategori: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    SQLConnector1: TSQLConnector;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    procedure BtnTambahKategoriClick(Sender: TObject);
  private

  public

  end;

var
  frmTambahKategori: TfrmTambahKategori;

implementation

{$R *.lfm}

{ TfrmTambahKategori }

procedure TfrmTambahKategori.BtnTambahKategoriClick(Sender: TObject);
begin
  try
    if SQLQuery1.Active then
      SQLQuery1.Close;

    with SQLQuery1 do
    begin
      SQL.Clear;
      SQL.Add('INSERT INTO kategori (nama)');
      SQL.Add('VALUES (:nama)');
      Params.ParamByName('nama').AsString:=edtKategori.Text;
      ExecSQL;
      SQLTransaction1.Commit;

      edtKategori.Text:='';
      ShowMessage('Berhasil Menambahkan Kategori');
      ModalResult := mrOk;
    end;
  except
    on E: Exception do
       ShowMessage('Terjadi Kesalahan : ' + E.message);
  end;
end;


end.


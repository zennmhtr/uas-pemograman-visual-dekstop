unit uUpdateKategori;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, DB, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TfrmUbahKategori }

  TfrmUbahKategori = class(TForm)
    btnUpdate: TButton;
    DataSource1: TDataSource;
    edtKategori: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    SQLConnector1: TSQLConnector;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
    procedure btnUpdateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure AmbilKategori(id: Integer);

  public
    procedure setId(id_barang: Integer);
    procedure setNama;

  end;

var
  frmUbahKategori: TfrmUbahKategori;
  id_barang: Integer;

implementation

{$R *.lfm}

{ TfrmUbahKategori }

procedure TfrmUbahKategori.setId(id_barang: Integer);
begin
  id_barang := id_barang;
end;

procedure TfrmUbahKategori.setNama;
begin
  AmbilKategori(id_barang);
end;

procedure TfrmUbahKategori.AmbilKategori(id: Integer);
var
  nama: string;
begin
with SQLQuery1 do
  begin
    Close;
    SQL.Add('SELECT * FROM kategori WHERE id = :id');
    Params.ParamByName('id').AsInteger := id;
    Open;

    nama := FieldByName('nama').AsString;
    edtKategori.Text := nama;
  end;
end;

procedure TfrmUbahKategori.FormCreate(Sender: TObject);
begin
end;

procedure TfrmUbahKategori.btnUpdateClick(Sender: TObject);
begin
  try
    with SQLQuery1 do
    begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE kategori SET nama=:nama WHERE id =:id');
      SQL.Add('');
      Params.ParamByName('nama').AsString:=edtKategori.Text;
      Params.ParamByName('id').AsInteger := id_barang;
      ExecSQL;
      SQLTransaction1.Commit;
      ModalResult:= mrOk;
    end;
  except
    on E: Exception do
         ShowMessage('Terjadi Kesalahan : ' + E.message);
end;
end;

end.


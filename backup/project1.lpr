program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, uMain, udbLogin, udbTambahBarang, udbUpdateBarang, udbDataBarang, udbTransaksi,
  udbTambahTransaksi, udbTambahDetailTransaksi, udbReport, udbDataKategoriBarang,
udbTambahKategori, udbUpdateKategori
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.CreateForm(TfrmUpdateBarang, frmUpdateBarang);
  Application.CreateForm(TfrmTransaksi, frmTransaksi);
  Application.CreateForm(TfrmTambahTransaksi, frmTambahTransaksi);
  Application.CreateForm(TfrmTambahDetailTransaksi, frmTambahDetailTransaksi);
  Application.CreateForm(TTfrmReport, TfrmReport);
  Application.CreateForm(TfrmDataBarang, frmDataBarang);
  Application.CreateForm(TfrmTambahBarang, frmTambahBarang);
  Application.CreateForm(TfrmDataKategoriBarang, frmDataKategoriBarang);
  Application.CreateForm(TfrmTambahKategori, frmTambahKategori);
  Application.CreateForm(TfrmUbahKategori, frmUbahKategori);
  Application.CreateForm(TfrmLogin, frmLogin);
  Application.Run;
end.


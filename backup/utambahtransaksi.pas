unit uTambahTransaksi;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, uTambahDetailTransaksi;

type

  { TfrmTambahTransaksi }

  TfrmTambahTransaksi = class(TForm)
    btnTambahTransaksi: TButton;
    ECustomer: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure btnTambahTransaksiClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private

  public

  end;

var
  frmTambahTransaksi: TfrmTambahTransaksi;

implementation

{$R *.lfm}

{ TfrmTambahTransaksi }

procedure TfrmTambahTransaksi.btnTambahTransaksiClick(Sender: TObject);
var
  frmTambahDetailTransaksi: TfrmTambahDetailTransaksi;
begin

    if Length(ECustomer.Text) > 3 then
    begin
      try
      frmTambahDetailTransaksi := TfrmTambahDetailTransaksi.Create(Self);
      frmTambahDetailTransaksi.SetCustomer(ECustomer.Text);
      Self.Hide;
      if frmTambahDetailTransaksi.ShowModal = mrOk then
      begin
          ModalResult := mrOk;
      end
      else
          ModalResult := mrCancel;
      finally
          frmTambahDetailTransaksi.Free;
      end;
    end
    else
        ShowMessage('Nama customer tidak boleh kurang dari 3');
end;

procedure TfrmTambahTransaksi.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin

end;

end.


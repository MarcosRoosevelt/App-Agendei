unit UnitDetalheEmpresa;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.ListBox;

type
  TFrmDetalheEmpresa = class(TForm)
    img_foto: TImage;
    lbl_servico: TLabel;
    lbl_nome: TLabel;
    Line1: TLine;
    Label2: TLabel;
    Line2: TLine;
    lb_servico: TListBox;
    procedure FormShow(Sender: TObject);
  private
    procedure CarregarServicos;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDetalheEmpresa: TFrmDetalheEmpresa;

implementation

{$R *.fmx}

uses UnitFrameServico;

procedure TFrmDetalheEmpresa.CarregarServicos;
var
    i : integer;
    item : TListBoxItem;
    frame : TFrmServico;
begin
    lb_servico.Items.Clear;

    //Acessar o servirdor e buscar as categorias

    for i := 1 to 5 do
    begin
      item := TListBoxItem.Create(lbl_servico);
      item.Text := '';
      item.Height := 60;

      frame := TFrmServico.Create(item);
      frame.Parent := item;
      frame.Align := TAlignLayout.Client;

      lb_servico.AddObject(item);
    end;

end;

procedure TFrmDetalheEmpresa.FormShow(Sender: TObject);
begin
    //chamar a procedure
    CarregarServicos;
end;

end.

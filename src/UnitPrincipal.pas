unit UnitPrincipal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Layouts, FMX.TabControl, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Edit,
  FMX.ListBox;

type
  TFrmPrincipal = class(TForm)
    Layout1: TLayout;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    TabControl1: TTabControl;
    TabAba1: TTabItem;
    TabAba2: TTabItem;
    TabAba3: TTabItem;
    TabAba4: TTabItem;
    Layout2: TLayout;
    Image5: TImage;
    Layout3: TLayout;
    rect_cidade: TRectangle;
    edt_login_email: TEdit;
    Label1: TLabel;
    Image6: TImage;
    lb_categorias: TListBox;
    procedure FormShow(Sender: TObject);
  private
    procedure CarregarCategorias(cidade: string);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.fmx}

uses UnitFrameCategoria;

procedure TFrmPrincipal.CarregarCategorias(cidade : string);
var
    i : integer;
    item : TListBoxItem;
    frame : TFrameCategoria;
begin
    lb_categorias.Items.Clear;

    //Acessar o servirdor e buscar as categorias

    for i := 1 to 9 do
    begin
      item := TListBoxItem.Create(lb_categorias);
      item.Text := '';
      item.Width := Trunc(lb_categorias.Width  / 3);
      item.Height := 150;

      frame := TFrameCategoria.Create(item);
      frame.Parent := item;
      frame.Align := TAlignLayout.Client;

      lb_categorias.AddObject(item);
    end;

end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
    CarregarCategorias('');
end;

end.

unit Unit8;

interface

uses
  System.SysUtils, System.Classes, Vcl.Forms, Vcl.Controls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.StdCtrls;

type
  TFormImageZoom = class(TForm)
    ScrollBox: TScrollBox;
    ImageZoom: TImage;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    OriginalWidth, OriginalHeight: Integer; // Armazena o tamanho original da imagem
  public
    { Public declarations }
  end;

var
  FormImageZoom: TFormImageZoom;

implementation

{$R *.dfm}

procedure TFormImageZoom.FormShow(Sender: TObject);
begin
  // Armazena as dimensões originais da imagem ao abrir o formulário
  if Assigned(ImageZoom.Picture) and not ImageZoom.Picture.Graphic.Empty then
  begin
    OriginalWidth := ImageZoom.Picture.Width;
    OriginalHeight := ImageZoom.Picture.Height;
  end;

  // Define o valor inicial do TrackBar
end;




end.


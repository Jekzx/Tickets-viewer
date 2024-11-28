unit Unit8;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, 
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  TFormImageZoom = class(TForm)
    ImageZoom: TImage;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormImageZoom: TFormImageZoom;

implementation

{$R *.dfm}

end.

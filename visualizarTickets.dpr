program visualizarTickets;

uses
  Vcl.Forms,
  Unit7 in '..\Unit7.pas' {FormMain},
  Unit8 in '..\Unit8.pas' {FormImageZoom},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Tablet Dark');
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormImageZoom, FormImageZoom);
  Application.Run;
end.

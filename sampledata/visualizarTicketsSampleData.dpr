program visualizarTicketsSampleData;

uses
  Vcl.Forms,
  Unit7 in 'Unit7.pas' {FormTicketsViewer};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormTicketsViewer, FormTicketsViewer);
  Application.Run;
end.

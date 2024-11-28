program visualizarTicketsSampleData;

uses
  Vcl.Forms,
  Unit7 in 'Unit7.pas' {FormMain},
  Unit8 in 'Unit8.pas' {FormImageZoom},
  System.SysUtils,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Stan.ExprFuncs,
  FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client,
  FireDAC.Comp.UI;

{$R *.res}

procedure PopulateSampleData(Connection: TFDConnection);
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Connection;

    // Clear existing data
    Query.SQL.Text := 'DELETE FROM Tickets';
    Query.ExecSQL;
    Query.SQL.Text := 'DELETE FROM Messages';
    Query.ExecSQL;

    // Insert sample tickets matching the screenshot
    Query.SQL.Text := 'INSERT INTO Tickets (TicketID, Title, Status, Priority, CreatedAt, UpdatedAt) VALUES ' +
      '(1, "Problema com o Banco de Dados", "Em Andamento", "Alta", "2023-11-13 09:30:00", "2023-11-13 10:45:00"), ' +
      '(2, "Atualização de Software", "Aberto", "Média", "2023-11-12 14:20:00", "2023-11-13 09:15:00"), ' +
      '(3, "Erro de Configuração de Rede", "Fechado", "Baixa", "2023-11-10 08:45:00", "2023-11-12 16:30:00")';
    Query.ExecSQL;

    // Insert sample messages matching the screenshot context
    Query.SQL.Text := 'INSERT INTO Messages (MessageID, TicketID, SenderName, MessageText, CreatedAt, MediaPath) VALUES ' +
      '(1, 1, "João Silva", "Detectamos inconsistências nos registros do banco de dados principal.", "2023-11-13 09:30:00", ""), ' +
      '(2, 1, "Suporte TI", "Investigando o problema de integridade dos dados. Possível corrupção de índice.", "2023-11-13 10:00:00", ""), ' +
      '(3, 2, "Maria Souza", "Necessidade de atualizar o sistema para a versão mais recente.", "2023-11-12 14:20:00", ""), ' +
      '(4, 2, "Administrador", "Preparando pacote de atualização e verificando compatibilidade.", "2023-11-13 09:15:00", ""), ' +
      '(5, 3, "Carlos Eduardo", "Configurações de rede não estão sincronizando corretamente.", "2023-11-10 08:45:00", ""), ' +
      '(6, 3, "Técnico de Rede", "Problema de configuração resolvido. Ajustes finais concluídos.", "2023-11-12 16:30:00", "")';
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormImageZoom, FormImageZoom);

  // Populate sample data before showing the form
  if Assigned(FormMain.FDConnection1) then
    PopulateSampleData(FormMain.FDConnection1);

  Application.Run;
end.

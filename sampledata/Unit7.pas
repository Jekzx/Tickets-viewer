unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs, FireDAC.VCLUI.Wait,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet, System.IOUtils;

type
  TFormMain = class(TForm)
    PanelTop: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    labelNotification: TLabel;
    DBGridTickets: TDBGrid;
    DBGridMessages: TDBGrid;
    FDConnection1: TFDConnection;
    FDQueryTickets: TFDQuery;
    FDQueryMessages: TFDQuery;
    DataSourceTickets: TDataSource;
    DataSourceMessages: TDataSource;
    PanelMain: TPanel;
    PanelLeft: TPanel;
    Splitter1: TSplitter;
    PanelRight: TPanel;
    PanelTickets: TPanel;
    PanelMessage: TPanel;
    PanelMessageHeader: TPanel;
    MemoMessage: TMemo;
    PanelMessagesHeader: TPanel;
    LabelSender: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure DBGridTicketsCellClick(Column: TColumn);
    procedure DBGridMessagesCellClick(Column: TColumn);
  private
    procedure InitializeDatabase;
    procedure CreateDatabaseTables;
    procedure PopulateSampleData;
    procedure LoadTickets;
    procedure LoadMessages(TicketID: Integer);
    procedure DisplayMessage(const SenderName, MessageText: string);
  public
    { Public declarations }
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

procedure TFormMain.FormCreate(Sender: TObject);
begin
  try
    InitializeDatabase;
    CreateDatabaseTables;
    PopulateSampleData;
    LoadTickets;
    MemoMessage.Text := 'Selecione um ticket e uma mensagem para visualizar.';
    LabelSender.Caption := '';
  except
    on E: Exception do
      ShowMessage('Error initializing: ' + E.Message);
  end;
end;

procedure TFormMain.InitializeDatabase;
var
  DBPath: string;
begin
  // Get the path in the same directory as the executable
  DBPath := ExtractFilePath(Application.ExeName) + 'tickets.db';
  
  // Configure the connection
  FDConnection1.Connected := False;
  FDConnection1.Params.Clear;
  FDConnection1.Params.Add('DriverID=SQLite');
  FDConnection1.Params.Add('Database=' + DBPath);
  FDConnection1.LoginPrompt := False;
  
  try
    FDConnection1.Connected := True;
  except
    on E: Exception do
      raise Exception.Create('Database connection error: ' + E.Message);
  end;
end;

procedure TFormMain.CreateDatabaseTables;
begin
  if not FDConnection1.Connected then Exit;
  
  FDConnection1.ExecSQL(
    'CREATE TABLE IF NOT EXISTS Tickets (' +
    'TicketID INTEGER PRIMARY KEY AUTOINCREMENT,' +
    'Title VARCHAR(200) NOT NULL,' +
    'Status VARCHAR(50) NOT NULL,' +
    'Priority VARCHAR(50) NOT NULL,' +
    'CreatedAt DATETIME NOT NULL,' +
    'UpdatedAt DATETIME NOT NULL' +
    ')');

  FDConnection1.ExecSQL(
    'CREATE TABLE IF NOT EXISTS Messages (' +
    'MessageID INTEGER PRIMARY KEY AUTOINCREMENT,' +
    'TicketID INTEGER NOT NULL,' +
    'SenderName VARCHAR(100) NOT NULL,' +
    'MessageText TEXT NOT NULL,' +
    'CreatedAt DATETIME NOT NULL,' +
    'MediaPath VARCHAR(500),' +
    'FOREIGN KEY(TicketID) REFERENCES Tickets(TicketID)' +
    ')');
end;

procedure TFormMain.PopulateSampleData;
begin
  if not FDConnection1.Connected then Exit;
  
  try
    // Clear existing data
    FDConnection1.ExecSQL('DELETE FROM Messages');
    FDConnection1.ExecSQL('DELETE FROM Tickets');

    // Insert sample tickets
    FDConnection1.ExecSQL(
      'INSERT INTO Tickets (Title, Status, Priority, CreatedAt, UpdatedAt) VALUES ' +
      '("Problema com o Banco de Dados", "Em Andamento", "Alta", "2023-11-13 09:30:00", "2023-11-13 10:45:00"), ' +
      '("Atualização de Software", "Aberto", "Média", "2023-11-12 14:20:00", "2023-11-13 09:15:00"), ' +
      '("Erro de Configuração de Rede", "Fechado", "Baixa", "2023-11-10 08:45:00", "2023-11-12 16:30:00")');

    // Insert sample messages
    FDConnection1.ExecSQL(
      'INSERT INTO Messages (TicketID, SenderName, MessageText, CreatedAt, MediaPath) VALUES ' +
      '(1, "João Silva", "Detectamos inconsistências nos registros do banco de dados principal.", "2023-11-13 09:30:00", ""), ' +
      '(1, "Suporte TI", "Investigando o problema de integridade dos dados. Possível corrupção de índice.", "2023-11-13 10:00:00", ""), ' +
      '(2, "Maria Souza", "Necessidade de atualizar o sistema para a versão mais recente.", "2023-11-12 14:20:00", ""), ' +
      '(2, "Administrador", "Preparando pacote de atualização e verificando compatibilidade.", "2023-11-13 09:15:00", ""), ' +
      '(3, "Carlos Eduardo", "Configurações de rede não estão sincronizando corretamente.", "2023-11-10 08:45:00", ""), ' +
      '(3, "Técnico de Rede", "Problema de configuração resolvido. Ajustes finais concluídos.", "2023-11-12 16:30:00", "")');
  except
    on E: Exception do
      ShowMessage('Error populating data: ' + E.Message);
  end;
end;

procedure TFormMain.LoadTickets;
begin
  FDQueryTickets.Close;
  FDQueryTickets.SQL.Text := 'SELECT * FROM Tickets ORDER BY CreatedAt DESC';
  FDQueryTickets.Open;
end;

procedure TFormMain.LoadMessages(TicketID: Integer);
begin
  FDQueryMessages.Close;
  FDQueryMessages.SQL.Text := 'SELECT * FROM Messages WHERE TicketID = :ID ORDER BY CreatedAt';
  FDQueryMessages.ParamByName('ID').AsInteger := TicketID;
  FDQueryMessages.Open;
  
  MemoMessage.Text := 'Selecione uma mensagem para visualizar.';
  LabelSender.Caption := '';
end;

procedure TFormMain.DisplayMessage(const SenderName, MessageText: string);
var
  FormattedDate: string;
begin
  LabelSender.Caption := Format('%s - %s', [SenderName, 
    FormatDateTime('dd/mm/yyyy hh:nn', FDQueryMessages.FieldByName('CreatedAt').AsDateTime)]);
  MemoMessage.Text := MessageText;
end;

procedure TFormMain.DBGridTicketsCellClick(Column: TColumn);
begin
  if not FDQueryTickets.IsEmpty then
    LoadMessages(FDQueryTickets.FieldByName('TicketID').AsInteger);
end;

procedure TFormMain.DBGridMessagesCellClick(Column: TColumn);
begin
  if not FDQueryMessages.IsEmpty then
    DisplayMessage(
      FDQueryMessages.FieldByName('SenderName').AsString,
      FDQueryMessages.FieldByName('MessageText').AsString);
end;

end.

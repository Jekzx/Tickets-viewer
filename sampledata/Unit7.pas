unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.ExprFuncs,
  FireDAC.Phys.SQLiteWrapper.Stat, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB, Vcl.StdCtrls,
  Vcl.ExtCtrls, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids,
  Vcl.DBGrids;

type
  TFormTicketsViewer = class(TForm)
    FDConnectionTickets: TFDConnection;
    FDQueryTickets: TFDQuery;
    DataSourceTickets: TDataSource;
    FDQueryMessages: TFDQuery;
    DataSourceMessages: TDataSource;
    PanelHeader: TPanel;
    LabelHeader: TLabel;
    SplitterMain: TSplitter;
    PanelTickets: TPanel;
    PanelMessages: TPanel;
    PanelTicketsList: TPanel;
    LabelTickets: TLabel;
    DBGridTickets: TDBGrid;
    LabelMessages: TLabel;
    DBGridMessages: TDBGrid;
    SplitterTickets: TSplitter;
    PanelMessage: TPanel;
    PanelMessageHeader: TPanel;
    LabelMessage: TLabel;
    MemoMessage: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure DBGridTicketsCellClick(Column: TColumn);
    procedure DBGridMessagesCellClick(Column: TColumn);
  private
    procedure InitializeDatabase;
    procedure CreateTables;
    procedure PopulateSampleData;
    procedure DisplayMessage(const Sender, MessageText: string; CreatedAt: TDateTime);
  public
    { Public declarations }
  end;

var
  FormTicketsViewer: TFormTicketsViewer;

implementation

{$R *.dfm}

uses
  System.IOUtils;

procedure TFormTicketsViewer.FormCreate(Sender: TObject);
begin
  InitializeDatabase;
  FDQueryTickets.Open;
  MemoMessage.Lines.Add('Select a ticket to view messages...');
end;

procedure TFormTicketsViewer.InitializeDatabase;
var
  DBPath: string;
begin
  DBPath := TPath.Combine(TPath.GetDirectoryName(ParamStr(0)), 'tickets.db');
  
  FDConnectionTickets.Params.Clear;
  FDConnectionTickets.Params.Add('Database=' + DBPath);
  FDConnectionTickets.Params.Add('DriverID=SQLite');
  
  try
    FDConnectionTickets.Connected := True;
    CreateTables;
    
    // Check if we need to populate sample data
    FDQueryTickets.Close;
    FDQueryTickets.Open;
    if FDQueryTickets.IsEmpty then
      PopulateSampleData;
    FDQueryTickets.Close;
  except
    on E: Exception do
    begin
      CreateTables;
      PopulateSampleData;
    end;
  end;
end;

procedure TFormTicketsViewer.CreateTables;
begin
  FDConnectionTickets.ExecSQL(
    'CREATE TABLE IF NOT EXISTS Tickets (' +
    'TicketID INTEGER PRIMARY KEY AUTOINCREMENT,' +
    'Title VARCHAR(200),' +
    'Status VARCHAR(50),' +
    'Priority VARCHAR(50),' +
    'CreatedAt DATETIME,' +
    'UpdatedAt DATETIME)');

  FDConnectionTickets.ExecSQL(
    'CREATE TABLE IF NOT EXISTS Messages (' +
    'MessageID INTEGER PRIMARY KEY AUTOINCREMENT,' +
    'TicketID INTEGER,' +
    'SenderName VARCHAR(100),' +
    'MessageText TEXT,' +
    'CreatedAt DATETIME,' +
    'MediaPath VARCHAR(500),' +
    'FOREIGN KEY(TicketID) REFERENCES Tickets(TicketID))');
end;

procedure TFormTicketsViewer.PopulateSampleData;
begin
  // Sample Tickets
  FDConnectionTickets.ExecSQL(
    'INSERT INTO Tickets (Title, Status, Priority, CreatedAt, UpdatedAt) VALUES ' +
    '("Problema com impressora", "Aberto", "Alta", "2023-11-15 09:00:00", "2023-11-15 09:00:00"),' +
    '("Erro ao acessar sistema", "Em andamento", "Média", "2023-11-14 14:30:00", "2023-11-15 10:15:00"),' +
    '("Solicitação de novo equipamento", "Fechado", "Baixa", "2023-11-13 11:20:00", "2023-11-15 16:45:00")');

  // Sample Messages
  FDConnectionTickets.ExecSQL(
    'INSERT INTO Messages (TicketID, SenderName, MessageText, CreatedAt) VALUES ' +
    '(1, "João Silva", "A impressora não está respondendo após atualização do Windows.", "2023-11-15 09:00:00"),' +
    '(1, "Maria Suporte", "Por favor, tente reiniciar a impressora e o computador.", "2023-11-15 09:15:00"),' +
    '(1, "João Silva", "Já tentei reiniciar ambos, mas o problema persiste.", "2023-11-15 09:30:00"),' +
    '(2, "Ana Santos", "Não consigo fazer login no sistema desde hoje cedo.", "2023-11-14 14:30:00"),' +
    '(2, "Pedro Suporte", "Vou verificar se há algum problema com o servidor.", "2023-11-14 15:00:00"),' +
    '(3, "Carlos Lima", "Preciso de um novo monitor para minha estação de trabalho.", "2023-11-13 11:20:00"),' +
    '(3, "Julia Suporte", "Pedido aprovado. Será entregue até amanhã.", "2023-11-13 14:00:00")');
end;

procedure TFormTicketsViewer.DBGridTicketsCellClick(Column: TColumn);
begin
  if FDQueryTickets.FieldByName('TicketID').AsInteger > 0 then
  begin
    FDQueryMessages.Close;
    FDQueryMessages.ParamByName('ID').AsInteger := FDQueryTickets.FieldByName('TicketID').AsInteger;
    FDQueryMessages.Open;
    
    LabelMessage.Caption := 'Messages for Ticket #' + FDQueryTickets.FieldByName('TicketID').AsString;
    MemoMessage.Clear;
    MemoMessage.Lines.Add('Select a message to view details...');
  end;
end;

procedure TFormTicketsViewer.DBGridMessagesCellClick(Column: TColumn);
begin
  if not FDQueryMessages.IsEmpty then
  begin
    DisplayMessage(
      FDQueryMessages.FieldByName('SenderName').AsString,
      FDQueryMessages.FieldByName('MessageText').AsString,
      FDQueryMessages.FieldByName('CreatedAt').AsDateTime
    );
  end;
end;

procedure TFormTicketsViewer.DisplayMessage(const Sender, MessageText: string; CreatedAt: TDateTime);
begin
  LabelMessage.Caption := Format('From: %s - %s', [Sender, FormatDateTime('dd/mm/yyyy hh:nn', CreatedAt)]);
  MemoMessage.Lines.Clear;
  MemoMessage.Lines.Add(MessageText);
end;

end.

unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids,
  FireDAC.UI.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
  FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, Vcl.ExtCtrls,
  Vcl.StdCtrls, ShellAPI, System.Threading, System.Win.Registry;

type
  TFormMain = class(TForm)
    DBGridTickets: TDBGrid;
    DBGridMessages: TDBGrid;
    FDQueryTickets: TFDQuery;
    FDQueryMessages: TFDQuery;
    FDConnection1: TFDConnection;
    DataSourceTicket: TDataSource;
    DataSourceMessage: TDataSource;
    MemoMessage: TMemo;
    ImageMessage: TImage;
    Label2: TLabel;
    Label3: TLabel;
    EditSearchControl: TEdit;
    ButtonSearchControl: TButton;
    Label5: TLabel;
    TimerUpdate: TTimer;
    LabelNotification: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton; // Campo para notificações
    procedure DBGridTicketsCellClick(Column: TColumn);
    procedure DBGridMessagesCellClick(Column: TColumn);
    procedure ImageMessageClick(Sender: TObject);
    procedure ButtonSearchControlClick(Sender: TObject);
    procedure EditSearchControlKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TimerUpdateTimer(Sender: TObject);
  private
    FLastTicketID: Integer;  // Armazena o último ticket carregado
    FLastMessageID: Integer; // Armazena a última mensagem carregada
    procedure LoadMessagesAsync(TicketID: Integer);
    procedure PlayMedia(const MediaFile: string);
    function GetVLCPath: string;  // Função para obter o caminho do VLC
    procedure CheckForNewTickets;
    procedure CheckForNewMessages(TicketID: Integer);
  public
    constructor Create(AOwner: TComponent); override;
  end;

var
  FormMain: TFormMain;

implementation

{$R *.dfm}

uses Unit8;

constructor TFormMain.Create(AOwner: TComponent);
begin
  inherited;
  FLastTicketID := 0;
  FLastMessageID := 0;
end;

procedure TFormMain.ButtonSearchControlClick(Sender: TObject);
var
  TempControl: Integer;
begin
  // Reseta o filtro sempre que uma nova pesquisa for realizada
  FDQueryTickets.Filtered := False;

  // Inicializa o filtro com uma string vazia
  FDQueryTickets.Filter := '';

  // Se o campo de pesquisa não estiver vazio, realiza a pesquisa por número de controle ou nome
  if EditSearchControl.Text <> '' then
  begin
    // Se o valor inserido for numérico (número de controle)
    if TryStrToInt(EditSearchControl.Text, TempControl) then
    begin
      // Filtro para número de controle (exato)
      FDQueryTickets.Filter := 'CONTROLE = ' + EditSearchControl.Text;
    end
    else
    begin
      // Filtro para nome do técnico (insensível ao caso)
      FDQueryTickets.Filter := 'UPPER(TECNICO_NOME) LIKE ''%' + UpperCase(EditSearchControl.Text) + '%''';
    end;
  end;

  // Verifica o estado do RadioButton e aplica o filtro baseado na PENDENCIA
  if RadioButton1.Checked then
  begin
    // Filtro para tickets abertos (PENDENCIA = 'S')
    if FDQueryTickets.Filter <> '' then
      FDQueryTickets.Filter := FDQueryTickets.Filter + ' AND PENDENCIA = ''S'''
    else
      FDQueryTickets.Filter := 'PENDENCIA = ''S''';
  end
  else if RadioButton2.Checked then
  begin
    // Filtro para tickets fechados (PENDENCIA = 'N')
    if FDQueryTickets.Filter <> '' then
      FDQueryTickets.Filter := FDQueryTickets.Filter + ' AND PENDENCIA = ''N'''
    else
      FDQueryTickets.Filter := 'PENDENCIA = ''N''';
  end
  else if RadioButton3.Checked then
  begin
    // Filtro para todos os tickets (sem filtro de PENDENCIA)
    // Não adiciona filtro para a PENDENCIA
  end;

  // Aplica o filtro
  FDQueryTickets.Filtered := True;

  // Força a atualização da consulta, garantindo que os novos tickets sejam carregados
  FDQueryTickets.Refresh; // Força a atualização dos dados da consulta
end;





procedure TFormMain.DBGridTicketsCellClick(Column: TColumn);
begin
  Label3.Caption := 'Carregando mensagens...';
  LoadMessagesAsync(FDQueryTickets.FieldByName('CONTROLE').AsInteger);
end;

procedure TFormMain.LoadMessagesAsync(TicketID: Integer);
begin
  TTask.Run(procedure
  begin
    FDQueryMessages.Close;
    FDQueryMessages.ParamByName('TicketID').Value := TicketID;
    FDQueryMessages.Open;

    TThread.Synchronize(nil, procedure
    begin
      Label3.Caption := ''; // Remove a mensagem de "Carregando mensagens" após o carregamento
    end);
  end);
end;

procedure TFormMain.DBGridMessagesCellClick(Column: TColumn);
var
  MessageBlob: TStream;
  FilePath: string;
  TecnicoNome: string;
  ClienteNome: string;
  TecnicoCodigo: Integer;
  TecnicoWhatsApp: string;
    WhatsApp: String;
begin
  // Verifica se o MIME é de uma imagem
  if FDQueryMessages.FieldByName('MIME_TYPE').AsString = 'image/jpeg' then
  begin
    MemoMessage.Clear;
    ImageMessage.Visible := True;
    MemoMessage.Visible := False;
    MessageBlob := FDQueryMessages.CreateBlobStream(FDQueryMessages.FieldByName('MSG'), bmRead);
    try
      ImageMessage.Picture.LoadFromStream(MessageBlob);
    finally
      MessageBlob.Free;
    end;
  end
  // Verifica se o MIME é de um áudio
  else if FDQueryMessages.FieldByName('MIME_TYPE').AsString = 'audio/ogg' then
  begin
    MemoMessage.Clear;
    ImageMessage.Visible := False;
    MemoMessage.Visible := False;
    MessageBlob := FDQueryMessages.CreateBlobStream(FDQueryMessages.FieldByName('MSG'), bmRead);
    try
      FilePath := 'C:\temp_media\temp_audio.ogg';
      with TFileStream.Create(FilePath, fmCreate) do
      try
        CopyFrom(MessageBlob, 0);
      finally
        Free;
      end;
      PlayMedia(FilePath);
    finally
      MessageBlob.Free;
    end;
  end
  // Verifica se o MIME é de vídeo
  else if FDQueryMessages.FieldByName('MIME_TYPE').AsString = 'video/mp4' then
  begin
    MemoMessage.Clear;
    ImageMessage.Visible := False;
    MemoMessage.Visible := False;
    MessageBlob := FDQueryMessages.CreateBlobStream(FDQueryMessages.FieldByName('MSG'), bmRead);
    try
      FilePath := 'C:\temp_media\temp_video.mp4';
      with TFileStream.Create(FilePath, fmCreate) do
      try
        CopyFrom(MessageBlob, 0);
      finally
        Free;
      end;
      PlayMedia(FilePath);
    finally
      MessageBlob.Free;
    end;
  end
  else
  begin
    // Carregar o texto da mensagem no MemoMessage
    ImageMessage.Picture := nil;
    ImageMessage.Visible := False;
    MemoMessage.Visible := True;
      MessageBlob := FDQueryMessages.CreateBlobStream(FDQueryMessages.FieldByName('MSG'), bmRead);
  try
    MemoMessage.Lines.LoadFromStream(MessageBlob);
  finally
    MessageBlob.Free;
  end;

  // Adicionar o nome associado no início do Memo
  MemoMessage.Lines.Insert(0, 'Nome: ' + FDQueryMessages.FieldByName('NOME_ASSOCIADO').AsString);
end;
  end;


procedure TFormMain.EditSearchControlKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    ButtonSearchControlClick(Sender);
    Key := 0;
  end;
end;

procedure TFormMain.ImageMessageClick(Sender: TObject);
begin
  with TFormImageZoom.Create(Self) do
  try
    ImageZoom.Picture.Assign(ImageMessage.Picture);
    ShowModal;
  finally
    Free;
  end;
end;

procedure TFormMain.TimerUpdateTimer(Sender: TObject);
var
  MaxTicketID: Integer;
begin
  // Obter o maior CONTROLE diretamente do banco de dados
  with TFDQuery.Create(nil) do
  try
    Connection := FDConnection1;
    SQL.Text := 'SELECT MAX(CONTROLE) AS MaxTicketID FROM REQSERVS';
    Open;
    MaxTicketID := FieldByName('MaxTicketID').AsInteger;
  finally
    Free;
  end;

  // Verifica se há novos tickets
  if MaxTicketID > FLastTicketID then
  begin
    FLastTicketID := MaxTicketID;

    // Notifica o usuário sobre novos tickets
    ShowMessage('Novos tickets foram adicionados!');

    // Atualiza o grid de tickets
    FDQueryTickets.Close;
    FDQueryTickets.Open;
  end;
end;


procedure TFormMain.CheckForNewTickets;
var
  MaxTicketID: Integer;
begin
  with TFDQuery.Create(nil) do
  try
    Connection := FDConnection1;
    SQL.Text := 'SELECT MAX(CONTROLE) AS MaxTicketID FROM REQSERVS';
    Open;
    MaxTicketID := FieldByName('MaxTicketID').AsInteger;
  finally
    Free;
  end;

  if MaxTicketID > FLastTicketID then
  begin
    FLastTicketID := MaxTicketID;
    LabelNotification.Caption := 'Novos tickets disponíveis!';
    FDQueryTickets.Close;
    FDQueryTickets.Open;
  end
  else
    LabelNotification.Caption := '';
end;

procedure TFormMain.CheckForNewMessages(TicketID: Integer);
var
  MaxMessageID: Integer;
begin
  with TFDQuery.Create(nil) do
  try
    Connection := FDConnection1;
    SQL.Text := 'SELECT MAX(ID) AS MaxMessageID FROM WEB_MENSAGENS WHERE TICKET = :TicketID';
    ParamByName('TicketID').Value := TicketID;
    Open;
    MaxMessageID := FieldByName('MaxMessageID').AsInteger;
  finally
    Free;
  end;

  if MaxMessageID > FLastMessageID then
  begin
    FLastMessageID := MaxMessageID;
    ShowMessage('Novas mensagens recebidas!');
    LoadMessagesAsync(TicketID);
  end;
end;

// Função para obter o caminho do VLC no Registro do Windows
function TFormMain.GetVLCPath: string;
var
  Reg: TRegistry;
begin
  Result := '';
  Reg := TRegistry.Create(KEY_READ);
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;

    if Reg.OpenKeyReadOnly('SOFTWARE\WOW6432Node\VideoLAN\VLC') then
    begin
      if Reg.ValueExists('InstallDir') then
        Result := IncludeTrailingPathDelimiter(Reg.ReadString('InstallDir')) + 'vlc.exe';
      Reg.CloseKey;
    end;

    if Result = '' then
    begin
      if Reg.OpenKeyReadOnly('SOFTWARE\VideoLAN\VLC') then
      begin
        if Reg.ValueExists('InstallDir') then
          Result := IncludeTrailingPathDelimiter(Reg.ReadString('InstallDir')) + 'vlc.exe';
        Reg.CloseKey;
      end;
    end;
  finally
    Reg.Free;
  end;
end;

procedure TFormMain.PlayMedia(const MediaFile: string);
var
  VLCPath: string;
begin
  VLCPath := GetVLCPath;
  if VLCPath <> '' then
    ShellExecute(0, 'open', PChar(VLCPath), PChar(MediaFile), nil, SW_SHOWNORMAL)
  else
    ShowMessage('VLC Media Player não encontrado no sistema.');
end;

end.


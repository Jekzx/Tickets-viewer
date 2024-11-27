object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'Visualizar Ticket'
  ClientHeight = 628
  ClientWidth = 1134
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesigned
  TextHeight = 15
  object ImageMessage: TImage
    Left = 24
    Top = 268
    Width = 825
    Height = 344
    Center = True
    Proportional = True
    Stretch = True
    OnClick = ImageMessageClick
  end
  object Label2: TLabel
    Left = 32
    Top = 8
    Width = 106
    Height = 15
    Caption = 'Selecione seu ticket:'
  end
  object Label3: TLabel
    Left = 873
    Top = 5
    Width = 124
    Height = 15
    Caption = 'Selecione a mensagem:'
  end
  object Label5: TLabel
    Left = 24
    Top = 245
    Width = 62
    Height = 15
    Caption = 'Mensagem:'
  end
  object labelNotification: TLabel
    Left = 408
    Top = 8
    Width = 3
    Height = 15
  end
  object DBGridTickets: TDBGrid
    Left = 24
    Top = 29
    Width = 825
    Height = 207
    DataSource = DataSourceTicket
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnCellClick = DBGridTicketsCellClick
    Columns = <
      item
        Expanded = False
        FieldName = 'CONTROLE'
        Title.Caption = 'N'#176
        Width = 39
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ATEND_DATA'
        ImeName = 'Data'
        Title.Caption = 'Data'
        Width = 73
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TECNICO_NOME'
        Title.Caption = 'T'#233'cnico'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ASSUNTO'
        Title.Caption = 'Assunto'
        Width = 313
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PENDENCIA'
        Title.Caption = 'Pend'#234'ncia'
        Width = 74
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CLIENTE'
        Title.Caption = 'Cliente'
        Visible = True
      end>
  end
  object DBGridMessages: TDBGrid
    Left = 873
    Top = 26
    Width = 224
    Height = 586
    DataSource = DataSourceMessage
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnCellClick = DBGridMessagesCellClick
    Columns = <
      item
        Expanded = False
        FieldName = 'DATA_HORA'
        Title.Caption = 'Data e Hora'
        Width = 114
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MIME_TYPE'
        Title.Caption = 'tipo_arq'
        Width = 97
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'WHATSAPP'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME_ASSOCIADO'
        Visible = True
      end>
  end
  object MemoMessage: TMemo
    Left = 24
    Top = 266
    Width = 825
    Height = 344
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -21
    Font.Name = 'Dubai'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object EditSearchControl: TEdit
    Left = 176
    Top = 2
    Width = 121
    Height = 23
    TabOrder = 3
    OnKeyDown = EditSearchControlKeyDown
  end
  object ButtonSearchControl: TButton
    Left = 303
    Top = 1
    Width = 75
    Height = 25
    Caption = 'Pesquisar'
    TabOrder = 4
    OnClick = ButtonSearchControlClick
  end
  object RadioButton1: TRadioButton
    Left = 384
    Top = 6
    Width = 89
    Height = 17
    Caption = 'Abertos'
    TabOrder = 5
  end
  object RadioButton2: TRadioButton
    Left = 479
    Top = 6
    Width = 113
    Height = 17
    Caption = 'Fechados'
    TabOrder = 6
  end
  object RadioButton3: TRadioButton
    Left = 576
    Top = 6
    Width = 113
    Height = 17
    Caption = 'Todos'
    TabOrder = 7
  end
  object MainMenu1: TMainMenu
    Left = 24
    Top = 40
    object MenuConfig: TMenuItem
      Caption = 'Configurações'
      object MenuTheme: TMenuItem
        Caption = 'Tema'
        object MenuThemeDark: TMenuItem
          Caption = 'Escuro'
          OnClick = MenuThemeDarkClick
        end
        object MenuThemeLight: TMenuItem
          Caption = 'Claro'
          OnClick = MenuThemeLightClick
        end
      end
    end
  end
  object FDQueryTickets: TFDQuery
    Active = True
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT '
      '    r.CONTROLE,'
      '    r.ATEND_NUMERO,'
      '    r.ATEND_DATA,'
      '    r.ATEND_HORA,'
      '    r.NOME,  -- Agora o NOME vem de REQSERVS'
      '    r.TELEFONE,'
      '    r.ASSUNTO,'
      '    r.PENDENCIA,'
      '    t.NOME AS TECNICO_NOME,'
      
        '    r.NOME AS CLIENTE  -- Cliente agora vem de REQSERVS, n'#227'o mai' +
        's de CONTATS'
      'FROM '
      '    REQSERVS r'
      'JOIN '
      '    (SELECT '
      '        CONTREQ, '
      '        MAX(DATA_ENCAMIN) AS ULTIMA_DATA_ENCAMIN'
      '     FROM SERVS '
      '     GROUP BY CONTREQ) s_ultima'
      'ON r.CONTROLE = s_ultima.CONTREQ'
      'JOIN '
      
        '    SERVS s ON s.CONTREQ = s_ultima.CONTREQ AND s.DATA_ENCAMIN =' +
        ' s_ultima.ULTIMA_DATA_ENCAMIN'
      'JOIN '
      '    TECNICOS t ON s.TECNICO = t.CODIGO'
      'ORDER BY '
      '    r.CONTROLE DESC;'
      '')
    Left = 32
    Top = 8
  end
  object FDQueryMessages: TFDQuery
    Active = True
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT '
      '    wm.TICKET,'
      '    wm.TIPO,'
      '    wm.MSG,'
      '    wm.EXTENSAO,'
      '    wm.DATA_HORA,'
      '    wm.MIME_TYPE,'
      '    wm.WHATSAPP,'
      '    COALESCE(t.NOME, c.NOME) AS NOME_ASSOCIADO'
      'FROM '
      '    WEB_MENSAGENS wm'
      'LEFT JOIN '
      '    TECNICOS t ON wm.WHATSAPP = t.WHATSAPP'
      'LEFT JOIN '
      '    CONTATS c ON wm.WHATSAPP = c.WHATSAPP'
      'WHERE '
      '    wm.TICKET = :TicketID;'
      '')
    Left = 16
    Top = 264
    ParamData = <
      item
        Name = 'TICKETID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=D:/empresas/Artean/dados.fdb'
      'User_Name=SYSDBA'
      'Password=master'
      'Server=54.94.138.110'
      'Port=3053'
      'DriverID=FB')
    Connected = True
    LoginPrompt = False
    Left = 8
    Top = 128
  end
  object DataSourceTicket: TDataSource
    DataSet = FDQueryTickets
    Left = 8
    Top = 64
  end
  object DataSourceMessage: TDataSource
    DataSet = FDQueryMessages
    Left = 16
    Top = 344
  end
  object TimerUpdate: TTimer
    Interval = 30000
    OnTimer = TimerUpdateTimer
    Left = 640
    Top = 416
  end
end

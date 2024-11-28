object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'Visualizar Ticket - Dados de Exemplo'
  ClientHeight = 628
  ClientWidth = 1134
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 1134
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object Label2: TLabel
      Left = 16
      Top = 12
      Width = 106
      Height = 15
      Caption = 'Selecione seu ticket:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object labelNotification: TLabel
      Left = 408
      Top = 12
      Width = 3
      Height = 15
    end
  end
  object PanelMain: TPanel
    Left = 0
    Top = 41
    Width = 1134
    Height = 587
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 857
      Top = 0
      Height = 587
      Align = alRight
      ExplicitLeft = 632
      ExplicitTop = 240
      ExplicitHeight = 100
    end
    object PanelLeft: TPanel
      Left = 0
      Top = 0
      Width = 857
      Height = 587
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object PanelTickets: TPanel
        Left = 0
        Top = 0
        Width = 857
        Height = 250
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object DBGridTickets: TDBGrid
          AlignWithMargins = True
          Left = 8
          Top = 8
          Width = 841
          Height = 234
          Margins.Left = 8
          Margins.Top = 8
          Margins.Right = 8
          Margins.Bottom = 8
          Align = alClient
          DataSource = DataSourceTickets
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          TabOrder = 0
          OnCellClick = DBGridTicketsCellClick
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Segoe UI'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'TicketID'
              Title.Caption = 'ID'
              Width = 40
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Title'
              Title.Caption = 'T'#237'tulo'
              Width = 300
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Status'
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Priority'
              Title.Caption = 'Prioridade'
              Width = 80
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'CreatedAt'
              Title.Caption = 'Criado em'
              Width = 150
              Visible = True
            end>
        end
      end
      object PanelMessage: TPanel
        Left = 0
        Top = 250
        Width = 857
        Height = 337
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object PanelMessageHeader: TPanel
          Left = 0
          Top = 0
          Width = 857
          Height = 41
          Align = alTop
          BevelOuter = bvNone
          Color = clWhite
          ParentBackground = False
          TabOrder = 0
          object Label5: TLabel
            Left = 16
            Top = 12
            Width = 62
            Height = 15
            Caption = 'Mensagem:'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clGray
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = []
            ParentFont = False
          end
          object LabelSender: TLabel
            Left = 96
            Top = 12
            Width = 737
            Height = 15
            AutoSize = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clNavy
            Font.Height = -12
            Font.Name = 'Segoe UI'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
        object MemoMessage: TMemo
          AlignWithMargins = True
          Left = 8
          Top = 49
          Width = 841
          Height = 280
          Margins.Left = 8
          Margins.Top = 8
          Margins.Right = 8
          Margins.Bottom = 8
          Align = alClient
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 1
        end
      end
    end
    object PanelRight: TPanel
      Left = 860
      Top = 0
      Width = 274
      Height = 587
      Align = alRight
      BevelOuter = bvNone
      TabOrder = 1
      object PanelMessagesHeader: TPanel
        Left = 0
        Top = 0
        Width = 274
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        Color = clWhite
        ParentBackground = False
        TabOrder = 0
        object Label3: TLabel
          Left = 16
          Top = 12
          Width = 124
          Height = 15
          Caption = 'Selecione a mensagem:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
        end
      end
      object DBGridMessages: TDBGrid
        AlignWithMargins = True
        Left = 8
        Top = 49
        Width = 258
        Height = 530
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 8
        Margins.Bottom = 8
        Align = alClient
        DataSource = DataSourceMessages
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 1
        OnCellClick = DBGridMessagesCellClick
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'MessageID'
            Title.Caption = 'ID'
            Width = 40
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'SenderName'
            Title.Caption = 'Remetente'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CreatedAt'
            Title.Caption = 'Data'
            Width = 80
            Visible = True
          end>
      end
    end
  end
  object FDConnection1: TFDConnection
    LoginPrompt = False
    Left = 24
    Top = 40
  end
  object FDQueryTickets: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM Tickets')
    Left = 96
    Top = 40
  end
  object FDQueryMessages: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT * FROM Messages')
    Left = 96
    Top = 88
  end
  object DataSourceTickets: TDataSource
    DataSet = FDQueryTickets
    Left = 168
    Top = 40
  end
  object DataSourceMessages: TDataSource
    DataSet = FDQueryMessages
    Left = 168
    Top = 88
  end
end

object FormTicketsViewer: TFormTicketsViewer
  Left = 0
  Top = 0
  Caption = 'Tickets Viewer'
  ClientHeight = 661
  ClientWidth = 984
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 17
  object SplitterMain: TSplitter
    Left = 633
    Top = 41
    Height = 620
    Align = alRight
    Color = 15921906
    ParentColor = False
    ExplicitLeft = 632
    ExplicitTop = 0
    ExplicitHeight = 661
  end
  object PanelHeader: TPanel
    Left = 0
    Top = 0
    Width = 984
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Color = 4227327
    ParentBackground = False
    TabOrder = 0
    object LabelHeader: TLabel
      Left = 16
      Top = 8
      Width = 137
      Height = 25
      Caption = 'TICKETS VIEWER'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object PanelTickets: TPanel
    Left = 0
    Top = 41
    Width = 633
    Height = 620
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 1
    object SplitterTickets: TSplitter
      Left = 0
      Top = 321
      Width = 633
      Height = 3
      Cursor = crVSplit
      Align = alTop
      Color = 15921906
      ParentColor = False
      ExplicitTop = 297
      ExplicitWidth = 505
    end
    object PanelTicketsList: TPanel
      Left = 0
      Top = 0
      Width = 633
      Height = 321
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 0
      object LabelTickets: TLabel
        Left = 16
        Top = 6
        Width = 89
        Height = 25
        Caption = 'All Tickets'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 4227327
        Font.Height = -19
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object DBGridTickets: TDBGrid
        AlignWithMargins = True
        Left = 16
        Top = 37
        Width = 601
        Height = 268
        Margins.Left = 16
        Margins.Right = 16
        Margins.Bottom = 16
        Align = alClient
        BorderStyle = bsNone
        Color = clWhite
        DataSource = DataSourceTickets
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2894892
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = 4227327
        TitleFont.Height = -13
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = [fsBold]
        OnCellClick = DBGridTicketsCellClick
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
            Title.Caption = 'Title'
            Width = 250
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
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'CreatedAt'
            Title.Caption = 'Created'
            Width = 120
            Visible = True
          end>
      end
    end
    object PanelMessage: TPanel
      Left = 0
      Top = 324
      Width = 633
      Height = 296
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 1
      object PanelMessageHeader: TPanel
        Left = 0
        Top = 0
        Width = 633
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        Color = 15921906
        ParentBackground = False
        TabOrder = 0
        object LabelMessage: TLabel
          Left = 16
          Top = 8
          Width = 137
          Height = 25
          Caption = 'Message Details'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 4227327
          Font.Height = -19
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object MemoMessage: TMemo
        AlignWithMargins = True
        Left = 16
        Top = 57
        Width = 601
        Height = 223
        Margins.Left = 16
        Margins.Top = 16
        Margins.Right = 16
        Margins.Bottom = 16
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 2894892
        Font.Height = -15
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
      end
    end
  end
  object PanelMessages: TPanel
    Left = 636
    Top = 41
    Width = 348
    Height = 620
    Align = alRight
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 2
    object LabelMessages: TLabel
      Left = 16
      Top = 6
      Width = 92
      Height = 25
      Caption = 'Messages'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 4227327
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBGridMessages: TDBGrid
      AlignWithMargins = True
      Left = 16
      Top = 37
      Width = 316
      Height = 567
      Margins.Left = 16
      Margins.Right = 16
      Margins.Bottom = 16
      Align = alClient
      BorderStyle = bsNone
      Color = clWhite
      DataSource = DataSourceMessages
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2894892
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = 4227327
      TitleFont.Height = -13
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = [fsBold]
      OnCellClick = DBGridMessagesCellClick
      Columns = <
        item
          Expanded = False
          FieldName = 'SenderName'
          Title.Caption = 'From'
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CreatedAt'
          Title.Caption = 'Date'
          Width = 150
          Visible = True
        end>
    end
  end
  object FDConnectionTickets: TFDConnection
    Params.Strings = (
      'Database=tickets.db'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 40
    Top = 392
  end
  object FDQueryTickets: TFDQuery
    Connection = FDConnectionTickets
    SQL.Strings = (
      'SELECT * FROM Tickets')
    Left = 40
    Top = 448
  end
  object DataSourceTickets: TDataSource
    DataSet = FDQueryTickets
    Left = 40
    Top = 504
  end
  object FDQueryMessages: TFDQuery
    Connection = FDConnectionTickets
    SQL.Strings = (
      'SELECT * FROM Messages WHERE TicketID = :ID')
    Left = 120
    Top = 448
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object DataSourceMessages: TDataSource
    DataSet = FDQueryMessages
    Left = 120
    Top = 504
  end
end

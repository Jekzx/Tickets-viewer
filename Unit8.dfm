object FormImageZoom: TFormImageZoom
  Left = 0
  Top = 0
  Caption = 'Visualizar Imagem'
  ClientHeight = 510
  ClientWidth = 870
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  WindowState = wsMaximized
  TextHeight = 15
  object ScrollBox: TScrollBox
    Left = 0
    Top = 0
    Width = 870
    Height = 510
    Align = alClient
    TabOrder = 0
    object ImageZoom: TImage
      Left = 0
      Top = 0
      Width = 866
      Height = 506
      Align = alClient
      AutoSize = True
      Center = True
      Proportional = True
      Stretch = True
      ExplicitLeft = -3
      ExplicitTop = -3
    end
  end
end

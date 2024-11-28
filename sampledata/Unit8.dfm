object FormImageZoom: TFormImageZoom
  Left = 0
  Top = 0
  Caption = 'Zoom da Imagem'
  ClientHeight = 600
  ClientWidth = 800
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object ImageZoom: TImage
    Left = 0
    Top = 0
    Width = 800
    Height = 600
    Align = alClient
    Center = True
    Proportional = True
    Stretch = True
  end
end

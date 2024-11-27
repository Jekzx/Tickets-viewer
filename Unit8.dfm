object FormImageZoom: TFormImageZoom
  Left = 0
  Top = 0
  Caption = 'Image Viewer'
  ClientHeight = 442
  ClientWidth = 628
  Color = clBlack
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  WindowState = wsMaximized
  BorderStyle = bsNone
  KeyPreview = True
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnMouseWheel = FormMouseWheel
  TextHeight = 15
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 628
    Height = 442
    Align = alClient
    BorderStyle = bsNone
    Color = clBlack
    ParentColor = False
    TabOrder = 0
    object Image1: TImage
      Left = 0
      Top = 0
      Width = 628
      Height = 442
      Center = True
      Proportional = True
      Stretch = True
      OnMouseDown = Image1MouseDown
      OnMouseMove = Image1MouseMove
      OnMouseUp = Image1MouseUp
    end
  end
end

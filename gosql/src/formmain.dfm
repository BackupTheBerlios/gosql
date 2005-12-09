object FrmMain: TFrmMain
  Left = 192
  Top = 107
  Width = 696
  Height = 480
  Caption = 'goSQL'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ADOQuery: TADOQuery
    Parameters = <>
    Left = 8
    Top = 8
  end
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=MSDASQL.1;Persist Security Info=False;User ID=sa;Data S' +
      'ource=VismaBusiness;Initial Catalog=f0001'
    Provider = 'MSDASQL.1'
    Left = 8
    Top = 48
  end
end

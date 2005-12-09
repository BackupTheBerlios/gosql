unit formmain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB;

type
  TFrmMain = class(TForm)
    ADOQuery: TADOQuery;
    ADOConnection1: TADOConnection;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}

end.

Provider=MSDASQL.1;Persist Security Info=False;User ID=sa;Data Source=VismaBusiness;Initial Catalog=f0001


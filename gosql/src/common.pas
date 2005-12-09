unit common;

interface
var
	Provider: string = 'MSDASQL.1';
  PersistSecurityInfo: string = 'False';
  UserID: string = '=sa';
  DataSource: string = '=LocalServer';
  InitialCatalog: string = '=master';


function ConnectionString: string;

implementation
uses
	JclUnitVersioning,
  JTools;

{***
  funkcja zwraca ci�g definiuj�cy po��czenie do serwera bazy danych dla ADO
***}
function ConnectionString: string;
var
	dsn: string;
begin
	GetCmdSwitchValue( 'dsn', ['-', '/'], DataSource, true );
	GetCmdSwitchValue( 'user', ['-', '/'], UserID, true );
	GetCmdSwitchValue( 'catalog', ['-', '/'], InitialCatalog, true );
  result := 'Provider=MSDASQL.1;Persist Security Info=False;User ID' +UserID +';Data Source' +DataSource +';Initial Catalog' +InitialCatalog;
end;


end.

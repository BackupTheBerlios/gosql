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
	SysUtils,
	JclUnitVersioning,
  JTools;

{***
  funkcja zwraca ci¹g definiuj¹cy po³¹czenie do serwera bazy danych dla ADO
***}
function ConnectionString: string;
begin
	GetCmdSwitchValue( 'dsn', ['-', '/'], DataSource, true );
	GetCmdSwitchValue( 'user', ['-', '/'], UserID, true );
//	GetCmdSwitchValue( 'pwd', ['-', '/'], UserID, true );
	GetCmdSwitchValue( 'catalog', ['-', '/'], InitialCatalog, true );
//	result := 'Provider=MSDASQL.1;Persist Security Info=False;User ID' +UserID +';Data Source' +DataSource +';Initial Catalog' +InitialCatalog;

	result := format( 'Provider=SQLOLEDB.1;Persist Security Info=False;User ID=%s;Initial Catalog=%s;Data Source=%s;Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;Workstation ID=VMWARE2000;' +
		'Use Encryption for Data=False;Tag with column collation when possible=False',
		[UserID, InitialCatalog, DataSource] );
end;


end.

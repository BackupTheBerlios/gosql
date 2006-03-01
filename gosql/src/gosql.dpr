{******************************************************************************
	Program pozwlaj¹cy uruchomiæ dowolny skrypt SQL. Pod³¹czenie siê do serwera
  SQL natêpuje poprzez ODBC z wykorzystaniem MS ADO.

	@Author Norbert Dudek
	@Version 2005.11.25 Norbert Dudek
	@Version 2006.02.28 Norbert Dudek

******************************************************************************}

{$APPTYPE CONSOLE}

program gosql;

uses
  SysUtils,
  Dialogs,
  Forms,
  Classes,
  ADODB,
  JTools,
  common,
  LogFile;

procedure ShowHelp;
begin
	writeln( 'Usage:'#10 +
  	ExtractFileName(ParamStr(0)) +' [options] sqlfile:'#10 +
    ' -dsn=name     use ODBC DSN name'#10 +
    ' -user=name    default is "sa"'#10 +
//    ' -pwd=password default is blank'#10 +
//    ' -server=name  default is (local)'#10 +
    ' -catalog=name	use thus catalog to initiate connection'#10 +
    ' -o            output result to stdout'#10 +
    ' -timeout=time	timeout in s (default 15)'#10 +
		''#10 +
    ' -v            verbose output'#10 +
    ' -l            enable logging to file'#10 +
    ' -d            debuging mode'#10 +
    ' -version      print version information and exit'#10 +
    ' -help         print help (this message) and exit'
  );
end;

var
	SQLText: TStringList;
  ADOConnection: TADOConnection;
  ADOQuery: TADOQuery;
  FileSpecs: TStringlist;
  i: integer;
  Path: string;
  DoVerbose: boolean;
  Timeout: string;
begin
	Application.Initialize;
  if GetCmdSwitchValue( 'help', ['-', '/'], Path, true ) or (ParamCount < 1) then
  begin
  	ShowHelp;
    exit;
  end;

  if GetCmdSwitchValue( 'version', ['-', '/'], Path, true ) then
  begin
  	writeln(
    	'gosql 0.47 GNU GPL Copyright (C) 2005 Norbert Dudek'
      );
    exit;
  end;

	LogActive := GetCmdSwitchValue( 'l', ['-', '/'], Path, true );	// w³¹czenie zapisywania logu programu
	DoVerbose := GetCmdSwitchValue( 'v', ['-', '/'], Path, true );	 
  GetCmdSwitchValue( 'timeout', ['-', '/'], timeout, true );
  if timeout = '' then
  	timeout := '15';
	FileSpecs := TStringlist.Create;
  if not GetCmdSwitchValue('@', [], Path, true) then
  begin
  	for i := 1 to ParamCount do   // we must still read entire command line to find any filespecs
    	if not (ParamStr(i)[1] in ['-', '/', '@']) then
      	FileSpecs.Add(ParamStr(i));
  end;

  if FileSpecs.Count = 0 then
  begin
  	writeln('ERROR: no files specified');
    Halt(1);
  end;
  
  SQLText := TStringList.Create;
  try
  	try
	  	SQLText.LoadFromFile( ParamStr( ParamCount ) );
    except
    	on E: Exception do
      begin
      	writeln( errOutput, 'File ' +ParamStr( ParamCount ) +' not exists or not permission: '#13#10+E.Message );
				AddLog( 'Read file', E.Message, mtError );
        halt(10);
      end;
    end;
    ADOConnection := TADOConnection.Create(nil);
    ADOConnection.ConnectionString := ConnectionString;
    ADOConnection.ConnectionTimeout := StrToInt( Timeout );
    ADOQuery := TADOQuery.Create(nil);
    try
     	if DoVerbose then
      	writeln( Output, 'Run SQL command.' );
			AddLog( 'Execute SQL command', SQLText.Text, mtInformation );
    	ADOQuery.Connection := ADOConnection;
      ADOQuery.SQL.Assign( SQLText );
      try
        if GetCmdSwitchValue( 'o', ['-', '/'], Path, true ) then
        begin
          ADOQuery.Open;
          ADOQuery.First;
          while not ADOQuery.eof do
          begin
            for i := 0 to ADOQuery.Fields.count -1 do
              write( ADOQuery.fields[i].asstring, #9 );
            writeln;
  			   	if DoVerbose then
	            write( ErrOutput, 'Save to file ', IntToStr( ADOQuery.RecNo *100 div ADOQuery.RecordCount ), '%', #13 );
            ADOQuery.next;
          end;
        end
        else
					ADOQuery.ExecSQL;
      except
	    	on E: Exception do
  	    begin
        	ShowError( 'Error execute SQL command: ' +E.Message, [] ); 
					AddLog( 'Execute SQL command', 'Error: ' +E.Message, mtError );
          Halt(20);
        end;
      end;
			AddLog( 'Execute SQL command', 'Run correctly.', mtInformation );
    finally
    	ADOQuery.Free;
      ADOConnection.Free;
    end;
  finally
  	SQLText.Free;
  end;
  Halt(0);
end.

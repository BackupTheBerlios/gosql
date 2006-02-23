unit LogFile;

interface

uses
	Dialogs;

var
	LogFilename: string;
  LogActive: boolean;

procedure AddLog(Header, Message: string; DlgType: TMsgDlgType);

implementation
uses
	SysUtils;

procedure AddLog(Header, Message: string; DlgType: TMsgDlgType);
var
	OutFile: TextFile;
begin
	if LogActive then
  try
	  AssignFile( OutFile, LogFilename );
  	if FileExists( LogFilename ) then
    	Append( OutFile )
	  else
  		Rewrite( OutFile );
		try
  	  WriteLn( OutFile, DateToStr( now ) +#9 +TimeToStr( now ) +#9 +Header +#9 +Message );
	  finally
		  CloseFile( OutFile );
	  end;
	except
  end;
end;


initialization
	LogFilename := ChangeFileExt( ParamStr( 0 ), '.log' );
  LogActive := false;

end.

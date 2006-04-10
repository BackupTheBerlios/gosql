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
    	// replace #13 to #32
    	while pos( #13, Message ) > 0 do
      begin
      	insert( ' ', Message, pos( #13, Message ) );
        Delete( Message, pos( #13, Message ), 1 );
      end;
    	// replace #10 to #32
    	while pos( #10, Message ) > 0 do
      begin
      	insert( ' ', Message, pos( #10, Message ) );
        Delete( Message, pos( #10, Message ), 1 );
      end;
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

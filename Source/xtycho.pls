Response	DIM	2048
 
HostName	INIT	"tycho.usno.navy.mil"
 
ResourcePath	INIT	"/cgi-bin/timer.pl"
 
RichEdit	RICHEDITTEXT
 
	CREATE	RichEdit=1:25:5:75,BdrStyle=2,Scrollbar=1
 
	ACTIVATE	RichEdit
 
	HTTP	HostName:		  ;HTTP	cook mode default used!
		ResourcePath:
		*TRACE="tycho_trace.log": ;Requires 9.6C
		*Result=Response
 
	SETPROP	RichEdit,Text=Response
 
	LOOP
	 EVENTWAIT
	REPEAT
 

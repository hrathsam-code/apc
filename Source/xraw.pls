Response	DIM	2048
 
HostName	INIT	"tycho.usno.navy.mil"
 
ResourcePath	INIT	"/cgi-bin/timer.pl"
 
RichEdit	RICHEDITTEXT
 
FLAGS		INTEGER	4,"0x00000020"	 ;Receive result as RAW	data!
 
	CREATE	RichEdit=1:25:5:75,BdrStyle=2,Scrollbar=1
 
	ACTIVATE	RichEdit
 
	HTTP	HostName:
		ResourcePath:
		*Result=Response:
		*TRACE="xraw_trace.log":
		*FLAGS=FLAGS		 ;Raw result ONLY!
 
	SETPROP	RichEdit,Text=Response
 
	LOOP
	 EVENTWAIT
	REPEAT
 

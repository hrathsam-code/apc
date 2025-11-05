Response	DIM	2048
.
HostName	INIT	"tycho.usno.navy.mil"
.
ResourcePath	INIT	"/cgi-bin/timer.pl"
SendRaw		DIM	500
.
RichEdit	RICHEDITTEXT
.
FLAGS		INTEGER	4,"0x00000021"	 ;Raw send and raw receive!
.
CR		INIT  0x0D
LF		INIT  0x0A
.
...................................................................
.
	CREATE	RichEdit=1:25:5:75,BdrStyle=2,Scrollbar=1
 
	ACTIVATE	RichEdit
.
	PACK	SendRaw, "GET ",ResourcePath," HTTP/1.0",LF,LF
 
	HTTP	HostName:
		SendRaw:
		*Result=Response:
		*TRACE="xraw1_trace.log":    ;Requires 9.6C
		*FLAGS=FLAGS		     ;Raw data for send	& receive!
 
	SETPROP	RichEdit,Text=Response
 
	LOOP
	 EVENTWAIT
	REPEAT
 

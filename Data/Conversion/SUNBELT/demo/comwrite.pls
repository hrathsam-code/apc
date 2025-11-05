C	 COMFILE
MESSAGE	 DIM	   40
 
MSGSTAT	 RECORD
ConnectF FORM	   1
SendF	 FORM	   1
RecvF	 FORM	   1
ErrorF	 FORM	   1
ErrorC	 FORM	   8
ErrorN	 FORM	   8
	 RECORDEND
.
IPADDR	 INIT	   "192.168.000.003"
IPPORT	 INIT	   "502"
.
Ans	 DIM	   1
.
. The IP address is critical for an open connection.  This must	match the
. address where	the Socket has been created.
.
	 TRAP	   NOSOCKET NORESET IF IO
	 TRAP	   EXIT	IF ESCAPE
	 DISPLAY   *RD,"Connecting to ",IPADDR," using port ",IPPORT
	 LOOP
	   SETFLAG   NOT OVER
	   PACK	     MESSAGE,"S,O,",IPADDR,",",IPPORT,"C"
	   COMOPEN   C,MESSAGE
	 REPEAT	WHILE OVER
.
	 DISPLAY   "Waiting for	Connect	Status"
	 LOOP
	   COMSTAT   C,MESSAGE
	   UNPACK    MESSAGE INTO MSGSTAT
	   BREAK     IF	( MSGSTAT.ConnectF = 1 )
	   CALL	     SHOWERR IF	( MSGSTAT.ErrorF = 1 )
	 REPEAT
.
	 DISPLAY   "Waiting for	Send Ready Status"
	 LOOP
	   COMSTAT   C,MESSAGE
	   UNPACK    MESSAGE INTO MSGSTAT
	   BREAK     IF	( MSGSTAT.SendF	= 1 )
	   CALL	     SHOWERR IF	( MSGSTAT.ErrorF = 1 )
	 REPEAT
.
	 DISPLAY   "Sending Message"
	 COMWRITE  C;"Message 1"
.
	 DISPLAY   "Waiting for	Received Status"
	 LOOP
	   COMSTAT   C,MESSAGE
	   UNPACK    MESSAGE INTO MSGSTAT
	   BREAK     IF	( MSGSTAT.SendF	= 1 | MSGSTAT.Connectf = 0 )
	   CALL	     SHOWERR IF	( MSGSTAT.ErrorF = 1 )
	 REPEAT
.
	 KEYIN	   "Closing Connection",*T5,ANS
	 COMCLOSE C
	 Stop
NOSOCKET
	 PAUSE	   "1"
	 SETFLAG   OVER
	 RETURN
SHOWERR
	 KEYIN	   "  Error: ",*DV,MESSAGE,*T5,ANS
	 STOP
EXIT
	 KEYIN	   "Operator Aborted",*T5,ANS

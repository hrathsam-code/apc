C	 COMFILE
MESSAGE	 DIM	   40
.
MSGSTAT	 RECORD
ConnectF FORM	   1
SendF	 Form	   1
RecvF	 Form	   1
ErrorF	 Form	   1
ErrorC	 Form	   8
ErrorN	 Form	   8
	 RECORDEND
.
IPADDR	 INIT	   "192.168.000.003"
IPPORT	 INIT	   "502"
.
Ans	 Dim	   1
.
	 DISPLAY   *HD,"Creating Socket	to listen using	port ",IPPORT
.
. Note:	the IP Address is ignored but must be present for an open request.
.
	 PACK	   MESSAGE,"S,O,",IPADDR,",",IPPORT,"C"
	 COMOPEN   C,MESSAGE
.
	 DISPLAY   "Waiting for	connection"
	 Loop
	   COMSTAT   C,	MESSAGE
	   UNPACK    MESSAGE INTO MSGSTAT
	   Break     If	(MSGSTAT.ConnectF = 1)
	   CALL	     SHOWERR IF	(MSGSTAT.ErrorF	= 1)
	 Repeat
.
	 DISPLAY   "Waiting for	Message"
	 Loop
	   COMSTAT   C,	MESSAGE
	   UNPACK    MESSAGE INTO MSGSTAT
	   Break     If	(MSGSTAT.RecvF = 1)
	   CALL	     SHOWERR IF	(MSGSTAT.ErrorF	= 1)
	 Repeat
.
	 DISPLAY   "Reading Message"
	 COMREAD   C;MESSAGE
	 KEYIN	   *DV,MESSAGE,Ans
	 Comclose  C
	 Stop
ShowErr
	 DISPLAY   "  Error: ",MSGSTAT

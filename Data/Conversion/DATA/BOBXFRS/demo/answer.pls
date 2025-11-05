*........................................................................
. Example Program: ANSWER.PLS
.
.  This	program	is a simple answer program.  Typically,	ANSWER is the first
.  program executed in a PLB system.  It's purpose is to initalize any common
.  variables and CHAIN to the Master Program.  Most ANSWER programs also
.  provide security by requiring the user to log-in with a user	name and
.  a password.	Only after correctly entering the information will the 
.  program CHAIN to Master.  This simple ANSWER	program	does not provide
.  security.
.
. Copyright @ 1997-1999	Sunbelt	Computer Systems, Inc.
. All Rights Reserved.
.............................................................................
. Revision History
.
. 9-9-98 JSS: Test System Info for GUI environment, use	text based code
.	      if not GUI.
..........................................................................
.
PORT	  DIM	    2
TODAY	  DIM	    8
TIME	  DIM	    8
ISITGUI	  DIM	    1
.
DIM1	  DIM	    1
AST	  INIT	    "*"
 
PICTA	  PICT
PICT1	  INIT	    "ANSWER.BMP"
.
SYSINFO	  DIM	    600
SCRWIDE	  FORM	    4
SCRHIGH	  FORM	    4
HIGHF	  FORM	    4.2
WIDEF	  FORM	    4.2
 
W1	  WINDOW
ST1	  STATTEXT
NOTE	  DIM	    80
RESULT	  FORM	    9
B1	  BUTTON
ST2	  STATTEXT
ST3	  STATTEXT
ST4	  STATTEXT
*.........................................................................
.
.Do Not	Allow the Escape Key to	Terminate This Program
.
	  TRAP	    NOEXIT NORESET IF INTERRUPT
*
.Initialize Common Variables
.
	  CLOCK	    PORT,PORT
	  REPLACE   " 0" IN PORT
	  CLOCK	    DATE,TODAY
	  CLOCK	    TIME,TIME
*
. Determine RUNTIME, act accordingly
.
	  MOVE	    "N"	TO ISITGUI
	  GETMODE   *GUI=RESULT
	  COMPARE   "0"	TO RESULT
	  GOTO	    NOGUI IF EQUAL	   Use text based instructions
	  MOVE	    "Y"	TO ISITGUI
 
. Setup	screen,	ALLOW DEFAULT colors
. Eliminate KEYIN & DISPLAY
.
	  
	  WINHIDE
	  SETMODE   *SCREEN=OFF
*
. Create Picture
.
	  GETINFO   SYSTEM,SYSINFO
 
	  IF	    OVER
 
	    MOVE    "600",SCRWIDE
	    MOVE    "480",SCRHIGH
	    CREATE  W1=0:(SCRHIGH-20):0:SCRWIDE,TITLE="ANSWER PROGRAM"
	    ACTIVATE W1
	    ALERT   NOTE,"OVER ON SYSINFO",RESULT
	    DEACTIVATE W1
	  ELSE
 
	    RESET   SYSINFO,13
	    SETLPTR SYSINFO,16
	    MOVE    SYSINFO,SCRWIDE
	    RESET   SYSINFO,17
	    SETLPTR SYSINFO,20
	    MOVE    SYSINFO,SCRHIGH
	    PACK    NOTE WITH "WIDE=",SCRWIDE,"	HIGH=",SCRHIGH
	    DIVIDE  "600" INTO SCRWIDE GIVING WIDEF
	    DIV	    "480",SCRHIGH,HIGHF
	  ENDIF
 
	  CREATE    W1=0:(SCRHIGH-20):0:SCRWIDE,TITLE="ANSWER PROGRAM"
 
	  SETMODE   *PIXEL=ON
	  CREATE    W1;PICTA=1:(SCRHIGH-20):1:SCRWIDE,PICT1
	  ACTIVATE  PICTA
	  SETMODE   *PIXEL=OFF
 
	  CREATE    W1;ST1=(400*HIGHF):(400*HIGHF+20):10:300,"":
		    "FIXED(10,BOLD)"
	  ACTIVATE  ST1
	  SETITEM   ST1,0,NOTE
*
. Standard ANSWER program display
 
	  CREATE    W1;ST2=(170*HIGHF):(170*HIGHF+40):240:450:
		    "ANSWER Program","HELVETICA(12,BOLD)"
 
	  CREATE    W1;ST3=(220*HIGHF):(220*HIGHF+20):175:450,"":
			  "HELVETICA(10,BOLD)"
 
	  CREATE    W1;ST4=(250*HIGHF):(250*HIGHF+20):245:450,"":
			  "HELVETICA(10,BOLD)"
 
	  ACTIVATE  ST2
	  ACTIVATE  ST3
	  ACTIVATE  ST4
 
	  PACK	    NOTE WITH "Today is	'",TODAY,"' and	the time is '":
			      TIME,"'."
	  SETITEM   ST3,0,NOTE
 
	  PACK	    NOTE WITH "	You are	on Port	'",PORT,"'"
	  SETITEM   ST4,0,NOTE
 
*
. Button to exit to MASTER program
 
	  CREATE    W1;B1=330:380:260:355,"-> MASTER"
	  ACTIVATE  B1,EXIT,RESULT	 
	  ACTIVATE  W1
 
	  LOOP
	    WAITEVENT
	  REPEAT
*
.Execute the MASTER Program
.
EXIT
	  CHAIN	    "MASTER"
.
*
.Interrupt sequence
.
NOEXIT
	  RETURN
.
*..........................................................................
. TEXT BASED CODE
.
NOGUI
.
*
.Draw the Screen
.
	  DISPLAY  *ES:
		   *P11:13,AST:
		   *P27:14,AST:
		   *P62:14,AST:
		   *P64:06,AST:
		   *P53:12,AST:
		   *P65:14,AST:
		   *P34:14,AST:
		   *P20:07,AST:
		   *P22:14,AST:
		   *P45:13,AST:
		   *P36:14,AST:
		   *P67:09,AST:
		   *P42:16,"S":
		   *P49:11,AST:
		   *P69:12,AST:
		   *P16:10,AST:
		   *P32:10,AST:
		   *P58:12,AST:
		   *P57:13,AST:
		   *P46:14,AST:
		   *P66:09,AST:
		   *P31:16,"C":
		   *P62:06,AST:
		   *P45:07,AST:
		   *P27:11,AST:
		   *P50:14,AST:
		   *P69:07,AST:
		   *P58:10,AST:
		   *P43:10,AST:
		   *P21:12,AST:
		   *P17:05,AST:
		   *P30:12,AST:
		   *P61:09,AST:
		   *P54:14,AST:
		   *P42:10,AST:
		   *P38:16,"R":
		   *P16:14,AST:
		   *P25:13,AST:
		   *P57:11,AST:
		   *P50:13,AST:
		   *P42:14,AST:
		   *P65:11,AST:
		   *P49:16,"n":
		   *P34:16,"P":
		   *P51:10,AST:
		   *P39:13,AST:
		   *P46:12,AST:
		   *P60:10,AST:
		   *P40:16,"S":
		   *P15:07,AST:
		   *P29:13,AST:
		   *P64:05,AST:
		   *P43:09,AST:
		   *P36:16,"T":
		   *P17:12,AST:
		   *P28:10,AST:
		   *P63:07,AST:
		   *P14:14,AST:
		   *P37:11,AST:
		   *P60:08,AST:
		   *P69:09,AST:
		   *P54:11,AST:
		   *P67:14,AST:
		   *P32:16,"O":
		   *P23:10,AST:
		   *P17:11,AST:
		   *P35:13,AST:
		   *P56:13,AST:
		   *P57:12,AST:
		   *P51:16,".":
		   *P63:05,AST:
		   *P52:13,AST:
		   *P45:10,AST:
		   *P22:11,AST:
		   *P15:08,AST:
		   *P26:13,AST:
		   *P50:16,"c":
		   *P61:07,AST:
		   *P40:14,AST:
		   *P71:05,AST:
		   *P68:08,AST:
		   *P45:16,"M":
		   *P49:12,AST:
		   *P70:06,AST:
		   *P35:16,"U":
		   *P68:09,AST:
		   *P62:08,AST:
		   *P40:12,AST:
		   *P17:13,AST:
		   *P36:10,AST:
		   *P43:16,"T":
		   *P59:11,AST:
		   *P68:13,AST:
		   *P52:14,AST:
		   *P46:11,AST:
		   *P48:16,"I":
		   *P60:14,AST:
		   *P55:14,AST:
		   *P11:12,AST:
		   *P34:10,AST:
		   *P64:13,AST:
		   *P53:10,AST:
		   *P46:06,AST:
		   *P59:09,AST:
		   *P44:16,"E":
		   *P41:11,AST:
		   *P58:14,AST:
		   *P48:14,AST:
		   *P46:16,"S":
		   *P64:12,AST:
		   *P20:06,AST:
		   *P20:13,AST:
		   *P65:09,AST:
		   *P41:16,"Y":
		   *P47:05,AST:
		   *P24:14,AST:
		   *P15:09,AST:
		   *P31:11,AST:
		   *P39:16," ":
		   *P66:10,AST:
		   *P44:14,AST:
		   *P33:16,"M":
		   *P19:05,AST:
		   *P28:14,AST:
		   *P37:16,"E":
		   *P38:14,AST:
		   *P12:14,AST:
		   *P63:13,AST:
		   *P44:08,AST:
		   *P20:14,AST:
		   *P16:06,AST:
		   *P26:14,AST:
		   *P26:12,AST:
		   *P36:12,AST:
		   *P33:18,"ANSWER Program":
		   *P01:23,"Today is '",TODAY,"' and the time is '",TIME,"'.":
			   "  You are on Port '",*ZF,PORT,"'";
*
.Wait for a User Reponse
.
	  KEYIN	    *N,"Tap 'ENTER' to CHAIN to	the 'MASTER' Program ",DIM1:
		   *P33:18,"MASTER";
	  GOTO	    EXIT
...............................................................................

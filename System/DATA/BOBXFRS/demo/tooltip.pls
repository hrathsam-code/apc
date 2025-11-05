.
. Date:	7-20-1999
.
. Sample program to demonstrate	use of TOOLTIPHWND property to manipulate
. some attributes of a TOOLTIP window.
.
BUT1	 BUTTON
INFO	 DATALIST
BLUE	 COLOR
WHITE	 COLOR
.
	 CREATE	   BLUE=*BLUE
	 CREATE	   WHITE=*WHITE
.
	 CREATE	   BUT1=5:6:5:20,"TESTTIP",TOOLTIP="ToolTip for	BUTTON"
	 CREATE	   INFO=11:23:2:77,STYLE=4:
		   TOOLTIP="Data for TOOLTIP program sample!"
.
	 ACTIVATE  BUT1
	 ACTIVATE  INFO
.
	 CALL	   SetToolTipBkColor USING BLUE
	 CALL	   SetToolTipTextColor USING WHITE
	 CALL	   SetDelayTime_Autopop	USING "8000"   ;8 seconds
	 CALL	   SetToolTipMaxWidth USING "100"      ;100 pixels
.
	 LOOP
	  WAITEVENT
	 REPEAT
.
*............................................................................
.
lResult	  integer   ^	      ;return value depends on msg sent
hWnd	  integer   ^	      ;handle to window
uInt	  integer   ^	      ;the message
wParam	  integer   ^
lParam	  integer   ^
SendMessageAProfile   PROFILE	user32:		  ;the DLL
				SendMessageA:	  ;the entry point
				INT4:		  ;return value	(LRESULT)
				INT4:		  ;handle of destination windo
				INT2:		  ;code	of msg to send
				INT4:		  ;msg specific	data (WPARAM)
				INT4
SendMessage routine lResult,hWnd,uInt,wParam,lParam
	    WinApi  SendMessageAProfile	Giving lResult Using hWnd:
							     uInt:
							   wParam:
							   lParam
	  RETURN
*............................................................................
. Set TOOLTIP setup commands
.
XResult	    INTEGER   4
ToolTipHwnd INTEGER   4
XMsg	    INTEGER   2
XwParam	    INTEGER   4
XlParam	    INTEGER   4
.
. Work variables
.
#ClrObjPtr  COLOR     ^
#NewWidtH   INTEGER   4
#NewTime    INTEGER   4			  ;Time	in Milliseconds
#F10	    FORM      10
.......
.
SetDelayTime	INTEGER	 2,"0x403"  ;TTM_SETDELAYTIME
SetTipBkColor	INTEGER	 2,"0x413"  ;TTM_SETTIPBKCOLOR
SetTipTextColor	INTEGER	 2,"0x414"  ;TTM_SETTIPTEXTCOLOR
GetDelayTime	INTEGER	 2,"0x415"  ;TTM_GETDELAYTIME
SetMaxTipWidth	INTEGER	 2,"0x418"  ;TTM_SETMAXTIPWIDTH
.
SetupToolTip
	 GETPROP BUT1,TOOLTIPHWND=ToolTipHwnd
	 IF ( ToolTipHwnd != 0 )
...
. Provide some information about operation.
.
	  MOVE	   ToolTipHwnd,#F10
	  PACK	   S$CMDLIN,"TipHwnd:",#F10
	  MOVE	   XMsg,#F10
	  PACK	   S$CMDLIN,S$CMDLIN,"...Msg:",#F10
	  MOVE	   XwParam,#F10
	  PACK	   S$CMDLIN,S$CMDLIN,"...wParam:",#F10
	  MOVE	   XlParam,#F10
	  PACK	   S$CMDLIN,S$CMDLIN,"...lParam:",#F10
	  INFO.AddString USING S$CMDLIN
...
. Perform the SENDMESSAGE operation.
.
	  CALL	  SENDMESSAGE USING XResult,ToolTipHwnd,XMsg,XwParam,XlParam
	  MOVE	   XResult,#F10
...
. Give some result information about operation.
.
	  PACK	   S$CMDLIN,"Msg Result:",#F10
	  INFO.AddString USING S$CMDLIN
	 ELSE
	  INFO.AddString USING "ToolTip	Window Handle NOT AVAILABLE!"
	 ENDIF
	 RETURN
*..................
. TTM_SETDELAYTIME
.
.     Set various time delays for TOOLTIP window.
.
.	 TTDT_RESHOW  -	Length of time it takes	for subsequent TOOLTIP 
.			windows	to appear when the pointer is moved from
.			one object to another.
.
.	 TTDT_AUTOPOP -	Length of time for which the TOOLTIP popup window
.			remains	visible	if the pointer remains stationary
.			in the bounds of an object's window rectangle.
.
.	 TTDT_INITIAL -	Length of time for which the pointer must remain
.			stationary in an objects boundary rectangle before
.			the TOOLTIP window will	appear.
.
.     wParam  =	dwDuration ( 1 = TTDT_RESHOW,
.			     2 = TTDT_AUTOPOP,
.			     3 = TTDT_INITIAL )
.     lParam  =	Value in Milliseconds
.     Return  =	Not Used
.
SetDelayTime_Reshow LROUTINE #NewTime
	 MOVE	   "1",XwParam	       ;TTDT_RESHOW
	 GOTO	   SetDelayTime
SetDelayTime_Autopop LROUTINE #NewTime
	 MOVE	   "2",XwParam	       ;TTDT_AUTOPOP
	 GOTO	   SetDelayTime
SetDelayTime_Initial LROUTINE #NewTime
	 MOVE	   "3",XwParam	       ;TTDT_INITIAL
.
SetDelayTime
	 MOVE	   #NewTime,XlParam
	 MOVE	   SetDelayTime,XMsg   ;TTM_SETDELAYTIME
	 CALL	   SetupToolTip
	 RETURN
*..................
. TTM_SETTIPBKCOLOR
.
.     Set background color of TOOLTIP window.
.
.     wParam  =	Clr ( INT4 RGB value )
.     lParam  =	0
.     Return  =	Not Used
.
SetToolTipBkColor  LROUTINE #ClrObjPtr
	 GETITEM   #ClrObjPtr,0,XwParam	  ;Fetch RGG value
	 CLEAR	   XlParam		  ;Must	be zero
	 MOVE	   SetTipBkColor,XMsg	  ;TTM_SETTIPBKCOLOR
	 CALL	   SetupToolTip
	 RETURN
*..................
. TTM_SETTIPTEXTCOLOR
.
.     Set text color of	TOOLTIP	window.
.
.     wParam  =	Clr ( INT4 RGB value )
.     lParam  =	0
.     Return  =	Not Used
.
SetToolTipTextColor  LROUTINE #ClrObjPtr
	 GETITEM   #ClrObjPtr,0,XwParam	  ;Fetch RGG value
	 CLEAR	   XlParam		  ;Must	be zero
	 MOVE	   SetTipTextColor,XMsg	  ;TTM_SETTIPTEXTCOLOR
	 CALL	   SetupToolTip
	 RETURN
*..................
. TTM_SETMAXTIPWIDTH
.
.     Set maximum TOOLTIP window width in PIXELS.  This	allows Windows
.     to perform line wrapping.
.
.     wParam  =	0
.     lParam  =	Width value ( PIXELS )
.     Return  =	Previous Width value
.
SetToolTipMaxWidth LROUTINE #NewWidth
	 CLEAR	   XwParam		  ;Must	be zero
	 MOVE	   #NewWidth,XlParam	  ;TOOLTIP window width
	 MOVE	   SetMaxTipWidth,XMsg	  ;TTM_SETMAXTIPWIDTH
	 CALL	   SetupToolTip
	 RETURN

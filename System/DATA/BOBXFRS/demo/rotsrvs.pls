*
* Date:	5-1-2001
*						   
* This sample server task is pre-loaded	by the Sunbelt Automation Server
* task as a ROT	( Running Objects Table	) program object.  This	program
* has a	specific CLASS ID and a	PROG ID	which has been assigned	in the
* 'PLBROT.INI' file.
*
*      PROGID	 ==>  SUNBELT.ROT
*      CLASSID	 ==>  {B7DCD1EE-E34A-4448-BA0C-4C6398E0E16B}
*
* This sample ROT server task uses the Plbwin.ProgramNE	interface which
* requires immediate responses to an event input request.
*
* This program can ONLY	send results back to the CLIENT	by using SETPROP
* to set values	for internal VARIANT objects named *RESULT, *ARG1, and
* *ARG2.
*
* This program demonstrates the	SETMODE	*THREADRDY= control which
* indicates to the Automation Server when the program is ready to be
* connected to another client.
*
Timer	TIMER
Result	Form	1
Time	Dim	20
Button1	Button
Button2	Button
Button3	Button
Msg	Dim	70
Title	Dim	100
Arr	Dim	1(2)
Ndx	Form	1
Count	Form	5
EXIT	Form	1
ROTCNT	FORM	5
 
	Winshow
	SETWTITLE	"ROT Server"
	Display		*ES,*P1:1,"ROT Server Started"
 
	Create		Timer, 5
	Activate	Timer, ShowTime, Result
 
	Create		Button1=8:10:5:15,"Exit"
	Activate	Button1,Exit,Result
 
	Create		Button2=8:10:35:42,"Event"
	Activate	Button2,ShipEvent,Result
 
	Create		Button3=8:10:55:62,"Error"
	Activate	Button3,CauseError,Result
 
	Eventreg	*Client, 200, ShowMsg, ARG1=Msg, ARG2=Title
	Eventreg	*Client, 201, Exit
	Eventreg	*Client, 202, ShipEvent
	Eventreg	*Client, 203, Error
	Eventreg	*Client, 204, Stop
	Eventreg	*Client, 205, ShipThread
 
	Loop
	 Waitevent
	Repeat
.....
. Initiate program EXIT.
.
Exit
	Setprop		*RESULT,VARVALUE="Server Program Disconnected!"
....
. The SETMODE *THREADRDY=ON operation identifies that another client can
. now be attached to this program object.
.
	SETMODE		*THREADRDY=ON
	RETURN
 
.....
. STOP command identifies that this program object should STOP.
.
STOP
	Setprop		*RESULT,VARVALUE="Server Program terminating!"
	STOP
 
.....
. Set current Server Time.
.
ShowTime
	Clock		Time To	Time
	Display		*P1:3,"Time: ",Time
	Return
 
.....
. A message has	been received from a CLIENT to be processed.
.
ShowMsg
	Display		*P1:5,"Msg: ",Msg
	SETWTITLE	Title	   
	SETPROP		*ARG1,VARVALUE="Message	Received!"
	Add		"1",COUNT
	Setprop		*ARG2,VARVALUE=COUNT
	Return
 
.....
. A message event has been received from a CLIENT requesting the
. current time setting.
.
ShipEvent
	PACK		S$CMDLIN,"Server Time is:",Time
	SETPROP		*RESULT,VARVALUE=S$CMDLIN
	Return
.....
. A message event has been received from a CLIENT requesting the
. current thread number	setting.
.
XTHREAD	 FORM	   10
.
ShipThread
	GETMODE		*THREADID=XTHREAD
	PACK		S$CMDLIN,"Server Thread	#:",XTHREAD
	SETPROP		*RESULT,VARVALUE=S$CMDLIN
	Return
.....
. Force	non-trapped error.
.
Error
CauseError
	 MOVE		ARR(NDX),S$CMDLIN    ;F02 Error	expected!

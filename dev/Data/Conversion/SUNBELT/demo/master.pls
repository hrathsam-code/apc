*..........................................................................
.
.Example Program: MASTER.PLS
.
. This MASTER program is part of the ANSWER/MASTER package.  This program
.  will be executed immediately after the ANSWER program and anytime a
.  subsequent program executes a STOP statement.
.
.  Copyright @ 1997,1998, Sunbelt Computer Systems, Inc.
.  All Rights Reserved
............................................................................
.
. Revision History
.
. 9-9-98 JSS: GUI option based on COMMON variable from ANSWER
.
............................................................................
*
.Common Data Items
.
PORT      DIM       *2
TODAY     DIM       *8
TIME      DIM       *8
ISITGUI   DIM       *1
*
.Local Variable
.
DIM1      DIM       1
W1        WINDOW
ET1       EDITTEXT
NOTE      DIM       80
RESULT    FORM      9
B1        BUTTON
ST1       STATTEXT
ST2       STATTEXT
ST3       STATTEXT
ST4       STATTEXT
DATA      DIM       60
CB        COLOR
.
HEX7F     INIT      0x7F
MESSAGE   DIM       255
*............................................................................
.
. Re-Initialize Common Time Variables
.

START
                                                 
          CLOCK     DATE,TODAY
          CLOCK     TIME,TIME
.
. Prevent Interrupt Sequence
.
          TRAP      NOINT NORESET IF INTERRUPT
.
. Check Screen I/O interface
.
          MATCH     "N",ISITGUI
          GOTO      NOGUI IF EQUAL
 
          CREATE    W1=0:440:0:600,TITLE="MASTER PROGRAM"
          CREATE    CB=*LTGRAY
*
.
           
          CREATE    W1;ST2=170:210:240:450,"MASTER Program":
                              "HELVETICA(12,BOLD)"
          CREATE    W1;ST3=220:240:175:450,"","HELVETICA(10,BOLD)"
          CREATE    W1;ST4=250:270:245:450,"","HELVETICA(10,BOLD)"
          CREATE    W1;ST1=310:329:100:450,"Enter Command or Program:":
                        "HELVETICA(9)"
          CREATE    W1;ET1=330:350:100:500,EDITTYPE=5,BGCOLOR=CB
          CREATE    W1;B1=325:355:505:540,"GO"
 
          PACK      NOTE WITH "Today is '",TODAY,"' and the time is '":
                               TIME,"'."
          SETITEM   ST3,0,NOTE
 
          PACK      NOTE WITH " You are on Port '",PORT,"'"
          SETITEM   ST4,0,NOTE
 
          ACTIVATE  ST2
          ACTIVATE  ST3
          ACTIVATE  ST4
          ACTIVATE  ST1
          ACTIVATE  ET1
          ACTIVATE  B1,PROCESS,RESULT         
          ACTIVATE  W1
          EVENTREG  ET1,11,PROCESS
          SETFOCUS  ET1
 
          LOOP
            WAITEVENT
          REPEAT
.
PROCESS
          GETITEM   ET1,0,DATA
.
.Change to ANSWER if Requested
.
          MATCH     "ANSWER",DATA
          RETURN    IF EOS
          GOTO      DSCNCT IF EQUAL
*
.Terminate if Master Requested
.
                    
          MATCH     "MASTER",DATA
          STOP      IF EQUAL
*
.Execute Shutdown if Requested
.
          MATCH     "SHUTDOWN",DATA
          GOTO      SHUTDOWN IF EQUAL
*
.Chain to the Requested Program
.
          TRAP      NOPROG IF CFAIL
          CHAIN     DATA
          RETURN
NOPROG
          NORETURN
          PACK      MESSAGE WITH "Unable to CHAIN to '",DATA,HEX7F:
                             "' - Error: ",S$ERROR$," !!"
 
          ALERT     NOTE,MESSAGE,RESULT,"CHAIN FAILURE"
          SETITEM   ET1,0,""
          SETFOCUS  ET1
          RETURN
 
*........................................................................
. Text Based Instructions
 
NOGUI
 
.Signon
.
          
          DISPLAY   *P01:23,"Today is '",TODAY,"' and the time is '":
                    TIME,"'.  You are on Port '",*ZF,PORT,"'":
                    *N,*EL,"SUNBELT DATABUS MASTER PROGRAM  ";
*
.Catch Interrupt Keys and Chain Failures
.
 
          TRAP      CHAINERR NORESET IF CFAIL
*
.Get a Command
.
LOOP
          KEYIN     *N,*EL,"READY",*N,*EL,*UC,S$CMDLIN;
*
.Change to ANSWER if Requested
.
          MATCH     "ANSWER",S$CMDLIN
          GOTO      LOOP IF EOS
          GOTO      DSCNCT IF EQUAL
*
.Terminate if Master Requested
.
          MATCH     "MASTER",S$CMDLIN
          STOP      IF EQUAL
*
.Execute Shutdown if Requested
.
          MATCH     "SHUTDOWN",S$CMDLIN
          GOTO      SHUTDOWN IF EQUAL
*
.Chain to the Requested Program
.
          CHAIN     S$CMDLIN
          GOTO      LOOP
*............................................................................
.
.Chain to ANSWER Requested
.
DSCNCT    DSCNCT
*............................................................................
.
.Shutdown Requested
.
SHUTDOWN  SHUTDOWN
*............................................................................
.
.Error Chaining to Requested Program
.
CHAINERR
          DISPLAY   "  !! Unable to CHAIN to '",*+,S$CMDLIN,"' - Error: ":
                      *+,S$ERROR$," !!"
          RETURN
*............................................................................
.
. Do Not Allow the Interrupt Key
.
NOINT
          RETURN
............................................................................

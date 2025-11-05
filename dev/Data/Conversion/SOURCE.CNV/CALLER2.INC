.
.  CALLERR2  ERROR RETURN MODULE:  PLACE AT BEGINNING OF ALL PROGRAMS
.
.  3-10-2004 R. BACHARACH
.
.  BEGIN BY LOADING A PROGRAM TITLE INTO DIM FIELD "TITLTEXT"
.
+........................................................................
.
.     (  MOVE      SOMENAME  TO  TITLTEXT  )
.
         SETMODE   *LTGRAY=ON,*3D=ON 
         CREATE    D,DDATA
         DISPLAY   *BGCOLOR=*YELLOW,*ES,*BLUE:
                   *HON,*P05:01,TITLTEXT,*HOFF,*BLACK
         ACTIVATE  D,TESTIT,RESULT
         LOOP
         WAITEVENT
         REPEAT
         STOP
.
TESTIT   BRANCH    RESULT OF NULL,MAINLINE,INDXIT
.
NULL     RETURN
.
INDXIT   DISPLAY   *ES,*BLUE
         BEEP
         CHAIN     FROMPGM
. 
MAINLINE MOVE      " ",REPLY
         DEACTIVATE D
         DISPLAY   *BLUE
.
.......................................................................
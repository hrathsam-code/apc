ARR      DIM       4(3),("111"),("222"),("333")
A        INIT      "AAAA"
B        INIT      "BBBB"
C        INIT      "CCCC"
D        INIT      "DDDD"
.
F1       FORM      5
.
INT      INTEGER   4,"255"
.
VAR      VARLIST   ARR(2),B
NAMEARR  DIM       1(3):
NAME1              ("2"):
NAME0              ("1"):
NAME2              ("3")
.
FP       FORM      2
LL       FORM      2
.
	 TRAP      CERROR NORESET IF IO
	 KEYIN     *HD,*N,"SAMPLE EXTCALL FUNCTION TEST (HIT ENTER):",S$CMDLIN
.
. CALL C FUNCTION which does not exist.
. OVER flag should be set to reflect EXTCALL did not happen.
.
	 DISPLAY   *N,*HON,"EXPECT: OVER FLAG SET",*HOFF
	 EXTCALL   "2"
	 CALL      OVER

.
. CALL C FUNCTION dspNAME0 with 6 variables
.
	 DISPLAY   *N,*HON,"EXPECT: 6 VARIABLES",*HOFF
	 EXTCALL   NAME0,F1,A,B,C,D,F1
	 CALL      OVER
.
. CALL C FUNCTION dspNAME0 with 4 variables
. Use ARRAY.
.
	 DISPLAY   *N,*HON,"EXPECT: 4 VARIABLES",*HOFF
	 EXTCALL   NAME0,F1,ARR
	 CALL      OVER
.
. CALL C FUNCTION dspNAME0 with 3 variables
. Use VARLIST.
.
	 DISPLAY   *N,*HON,"EXPECT: 3 variables	with VARLIST (VAREND)",*HOFF
	 EXTCALL   NAME0,F1,VAR
	 CALL      OVER
.
. CALL C FUNCTION dspNAME0 with 5 variables
. Error caused by invalid index.
. An I98 error is generated since dspNAME0 returns a non-zero value.
.
	 DISPLAY   *N,*HON,"EXPECT: 2 VARIABLES	followed by I98	error.",*HOFF
	 EXTCALL   NAME0,F1,A,ARR(F1),B,C
	 CALL      OVER
.
. CALL C FUNCTION dspNAME0 with 2 variables using ARRAY for name.
.
	 MOVE      "2",F1
	 DISPLAY   *N,*HON,"EXPECT: 2 VARIABLES",*HOFF
	 EXTCALL   NAMEARR(F1),A,INT
	 CALL      OVER
.
. CALL C FUNCTION dspNAME0 with 0 variables
.
	 DISPLAY   *N,*HON,"EXPECT: 0 VARIABLES",*HOFF
	 EXTCALL   NAME0
	 CALL      OVER
.
. CALL C FUNCTION dspNAME0 with 1 NULL variable
.
	 DISPLAY   *N,*HON,"EXPECT: 1 NULL VARIABLE",*HOFF
	 CLEAR     S$CMDLIN
	 EXTCALL   "1",S$CMDLIN
	 CALL      OVER
.
. CALL C FUNCTION dspNAME1 with 1 variable.
.
	 DISPLAY   *N,*HON,"EXPECT: no action",*HOFF
	 EXTCALL   "2",F1
	 CALL      OVER
.
. CALL C FUNCTION dspNAME2 with 3 variable.
. The call generates an I98 error since dspNAME2 returns a non-zero value.
.
	 DISPLAY   *N,*HON,"EXPECT: I98	to occur.",*HOFF
	 EXTCALL   "3",A,B,C
	 CALL      OVER
.
. CALL C FUNCTION to change the FP & LL of a variable
.
	 SETLPTR   A,2
	 MOVEFPTR  A,FP
	 MOVELPTR  A,LL
	 DISPLAY   *N,*HON,"EXPECT: FP & LL to change. ",FP,LL,*HOFF
	 EXTCALL     "4",A
	 FSAVE
	 MOVEFPTR  A,FP
	 MOVELPTR  A,LL
	 DISPLAY   "FP=",FP,"   LL=",LL
	 FRESTORE
	 CALL      OVER
.
. CALL C FUNCTION which does not exist.
. OVER flag should be set to reflect EXTCALL did not happen.
.
	 DISPLAY   *N,*HON,"EXPECT: OVER FLAG SET",*HOFF
	 EXTCALL   "5"
	 CALL      OVER
.
. CALL C FUNCTION which does not exist.
. OVER flag should be set to reflect EXTCALL did not happen.
.
	 DISPLAY   *N,*HON,"EXPECT: OVER FLAG SET",*HOFF
	 EXTCALL   "NAME00",A,B,C
	 CALL      OVER
.
. CALL C FUNCTION which does not exist.
. OVER flag should be set to reflect EXTCALL did not happen.
.
	 DISPLAY   *N,*HON,"EXPECT: OVER FLAG SET",*HOFF
	 EXTCALL   "name0",A,B,C
	 CALL      OVER
.
	 STOP
.
OVER
	 IF OVER
	  DISPLAY  *N,*HON,"OVER FLAG SET: EXTCALL FUNCTION NOT FOUND!",*HOFF
	 ENDIF
	 KEYIN     *HD,*N,"HIT ENTER TO	CONTINUE:",S$CMDLIN
	 RETURN
.
CERROR
	 DISPLAY   "EXTCALL IO GENERATED: ",S$ERROR$
	 RETURN

. 
. APDUSCAN - PROGRAM SCANS A/P TRANSACTION FILE FOR VENDOR INVOICES WHICH
.            ARE 30 DAYS OLD OR OLDER ON A GIVEN INPUT DATE!
. 
         INC       COMMON

         INC       APTRANFD

         INC       APMASTFD
. 
APTRANFL IFILE     KEYL=19,UNCOMPRESSED
APMASTER IFILE     KEYL=6,UNCOMPRESSED
. 
TODMON   DIM       2
TODDAY   DIM       2
TODYEAR  DIM       2
. 
MON      DIM       2
DAY      DIM       2
YEAR     DIM       2
.
BYPASSED FORM      9.2
.
TOTLDUE  FORM      9.2
. 
MM       DIM       2
DD       DIM       2
YY       DIM       2
BKUPFLG  DIM       1
.
TEST2    FORM      2
FM       FORM      2
FD       FORM      2
FY       FORM      2
DATEDESC DIM       15
DATFLG   DIM       1
DATERROR DIM       1
REPLY    DIM       1
DUEDATE  DIM       8
TESTAMNT FORM      8.2
. 
         INCLUDE   APCALNDR
. 
ASTER20  INIT      "********************"
 
         INCLUDE   CALLERR1.INC
 
         MOVE      "PAYABLES AMOUNT DUE ON DATE" TO TITLTEXT
 
         INCLUDE   CALLERR2.INC
. 
         DISPLAY   *ES,*P20:01,*HON,"PAYABLES DUE ON SUPPLIED DATE",*HOFF
.
STARTUP  MOVE      " " TO REPLY
         KEYIN     *P1:10,*HON,"PRESS ENTER TO DETERMINE PAYABLES DUE, OR":
                               " PRESS F5 TO TERMINATE",*HOFF,REPLY
.
         GOTO      BAILOUT  IF  F5
         GOTO      STARTS
. 
BAILOUT  CHAIN     FROMPGM
.
STARTS   DISPLAY   *P1:10,*EF:
                   *P1:12,*HON,"ENTER PLANNED DATE OF PAYABLES CHECK RUN",*HOFF
.
A2       MOVE      "X",BKUPFLG
. 
         OPEN      APTRANFL,"APTRANFL.ISI"
         OPEN      APMASTER,"APMASTER.ISI"
.
         MOVE      "PAYMENT DATE"  TO  DATEDESC
         CALL      GETDATE
.
         MOVE      YY  TO  TYEAR
         MOVE      MM  TO  TMON
         MOVE      DD  TO  TDAY
.
         CLEAR     DUEDATE
         REP       " 0"  IN  MM
         APPEND    MM  TO  DUEDATE
         APPEND    "/" TO  DUEDATE
         APPEND    DD  TO  DUEDATE
         APPEND    "/" TO  DUEDATE
         APPEND    YY  TO  DUEDATE
         RESET     DUEDATE  TO  1
.
         CALL      CALCDATE
.
         MOVE      TESTDATE TO CURRDATE
.....         DISPLAY   *P1:8,*EL,"CURRENT DATE=",CURRDATE
.
...........................................................
.  NOTE  CURRDATE  ACTUALLY IS THE PLANNED PAYMENT DATE   .
...........................................................
. 
XX1      MOVE      "0000000000000000000",TRNKEY
.
         INC       APTRANRD
         GOTO      S1 IF NOT OVER
         BEEP
         DISPLAY   *P1:23,*HON,"NO HEADER ON A/P TRANSACT FILE",*W3
. 
         CHAIN     FROMPGM
. 
S1       TRAPCLR   PARITY (NOP)
.
         INC       APTRANKS
.
         GOTO      EOJ  IF  OVER
. 
................................................................
.  HERE WE MUST DETERMINE IF THIS IS AN AUTO-PAY  
.  IF SO, FORGET THE DATE CHECK  -  JUST GOTO ADDIT   
................................................................
.
         MOVE      TACCN  TO  ACCKEY
.
         INCLUDE   APMASTRD
.
         CMATCH    "X",FUT
         GOTO      ADDIT  IF  EQUAL  (TAKE ALL AUTOPAYS)
. 
. CALCULATE THE NUMERIC VALUE OF THE TRANSACTION DATE 
. FOR COMPARISON AGAINST CURRDATE VALUE
. 
         CALL      CALCDATE
.....         DISPLAY   *P1:9,*EL,"TESTDATE=",TESTDATE
.....         KEYIN     REPLY
.
         ADD       "30"  TO  TESTDATE
.
.  CALCDATE NOW HOLDS THE CALCULATED TRANSACTION DATE
.
         COMPARE   TESTDATE  TO  CURRDATE
         GOTO      ADDIT     IF  EQUAL
         GOTO      ADDIT  IF NOT LESS
.
         ADD       TAMT  TO  BYPASSED
         GOTO      S1
.
ADDIT    DISPLAY   *P50:23,*EL,TMON,"/",TDAY,"/",TYEAR,"  ",FUT," ",TAMT
.
         COMPARE   "9",SECURITY
         GOTO      BYPRT IF NOT EQUAL
.
.         PRINT     *1,TACCN," ",TMON,"/",TDAY,"/",TYEAR," ",FUT," ",TAMT
.
BYPRT    ADD       TAMT  TO  TOTLDUE
         GOTO      S1
.
.......................................................
.
EOJ      DISPLAY   *P1:10,*EF:
                   *HON:
                   *P20:10,ASTER20,ASTER20:
                   *P20:11,"**   PAYABLE ",DUEDATE,":  ":
                           TOTLDUE,"  **":
                   *P20:12,ASTER20,ASTER20:
                   *P20:13,"** NOT YET DUE          ",BYPASSED,"    ":
                   *P20:14,ASTER20,ASTER20,*HOFF
. 
EOJ1     MOVE      " " TO REPLY
         KEYIN     *P1:23,*EL,*HON,"PRESS  F1  TO TRY ANOTHER DATE ":
                   "OR  F5  TO  TERMINATE",*HOFF,REPLY
.
         GOTO      TRYMORE  IF  F1
.
         GOTO      EOJ1  IF  NOT  F5
.
         CHAIN     FROMPGM
.
         STOP
.
TRYMORE  MOVE      "0.00"  TO  TOTLDUE
         MOVE      "0.00"  TO  BYPASSED
.
         CLOSE     APMASTER
         CLOSE     APTRANFL
         GOTO      STARTS
.
         INCLUDE   GETDATE.TXT
.
         INCLUDE   APDATES.TXT
.
........................................................

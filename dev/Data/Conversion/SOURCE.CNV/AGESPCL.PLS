.......................................................................
. AGED RECEIVABLES REPORT PROGRAM:   MODULE NAME   "AGESPCL.DBS"
. 
. ACCESSES "ARFILEXX.ISI"  KEY SEQUENTIALLY 
. PRODUCING REPORT FOR ALL ACCOUNTS HAVING OPEN INVOICES/CREDITS
. 
. NOTE THAT ARFILEXX.ISI CONSISTS OF THE INVOICE HEADER RECORDS
. MODIFIED FOR RECEIVABLES PURPOSES AND INDEXED IN THE FOLLOWING MANNER
. 
. KEY COMPONENTS:
.                 MAJOR  IS  ACCOUNT  (INVCUST)  POSITIONS 9 - 12
.                 MINOR  IS  INVC NO. (INVKEY)   POSITIONS 1 - 5
.
.  TEST....   ADDING COMMENT TO SEE IF FILE IS LOCKED ON APCSERVER_2/TRADVOL1:10/22/05RB
.
. 
.......................................................................
. 
. WRITTEN  9/13/81 BY  R. BACHARACH
.                     MICRO SYSTEMS CONSULTANTS
.                     41 TEELE DRIVE
.                     CORAM, NEW YORK 11727
.                     (516) 698-5577
.......................................................................
. 
         INCLUDE   COMMON.TXT
. 
         INCLUDE   RCVBLES.TXT
. 
ARFILES  IFILE     KEYL=10,UNCOMPRESSED
ARFILEXX INIT      "ARFILEXX.ISI"
. 
         INCLUDE   DATE.685

         INCLUDE   APCALNDR.TXT
. 
CUSTFILE IFILE     KEYL=4,UNCOMPRESSED
CSTNAME  INIT      "ACCOUNTS.ISI"
. 
. 
         INCLUDE   CUSTMAST.TXT
. 
CURRACCT DIM       4
FIRSTSW  INIT      "1"
PAGEZ    FORM      3
LINEZ    FORM      2
RECCNT   FORM      "00"
RLIMIT   FORM      "71"
SHORTRUN DIM       1
REPLY    DIM       1
COMPANY  DIM       1
IOSW     DIM       1
STARTKEY DIM       8
NUMCUST  FORM      4
PDTOTL   FORM      6.2
CREDTOTL FORM      6.2
. 
ASTER45  INIT      "*********************************************"
MONX     DIM       2
DAYX     DIM       2
YEARX    DIM       2
. 
PTYPE    DIM       7
WKSUB    FORM      6.2
WKPRINT  FORM      6.2
NETBAL   FORM      6.2
UPFLAG   INIT      "N"
ZEROS    INIT      "000000.00"
TOTCURNT FORM      "0000000.00"
TOT130   FORM      "0000000.00"
TOT3160  FORM      "0000000.00"
TOT6190  FORM      "0000000.00"
TOTOV90  FORM      "0000000.00"
TOTNET   FORM      "00000000.00"
.
. ACCOUNT BYPASS TABLE
.
ACCT1    DIM       4
ACCT2    DIM       4 
ACCT3    DIM       4
ACCT4    DIM       4
ACCT5    DIM       4
ACCT6    DIM       4
ACCT7    DIM       4
ACCT8    DIM       4
ACCT9    DIM       4
ACCT10   DIM       4
ACCT11   DIM       4
ACCT12   DIM       4
ACCT13   DIM       4
ACCT14   DIM       4
ACCT15   DIM       4
ACCT16   DIM       4
ACCT17   DIM       4
ACCT18   DIM       4
ACCT19   DIM       4
ACCT20   DIM       4
ACCT21   DIM       4
ACCT22   DIM       4
ACCT23   DIM       4
ACCT24   DIM       4
ACCT25   DIM       4
ACCT26   DIM       4
ACCT27   DIM       4
ACCT28   DIM       4
ACCT29   DIM       4
ACCT30   DIM       4
ACCT31   DIM       4
ACCT32   DIM       4
ACCT33   DIM       4
ACCT34   DIM       4
ACCT35   DIM       4
ACCT36   DIM       4
ACCT37   DIM       4
ACCT38   DIM       4
ACCT39   DIM       4
ACCT40   DIM       4
.
ACCTINDX FORM      2
ACCTIN   DIM       4
BYPSW    DIM       1
ACCTLIMT FORM      2
ACCTARG  DIM       4
.
. 
COMPDISP INIT      "APC COMPONENTS, INC."

         INCLUDE   CALLERR1.INC
 
         MOVE      "A/R SPECIAL AGEING LIST"  TO  TITLTEXT
 
         INCLUDE   CALLERR2.INC
. 
INITIATE MOVE      "0",PAGEZ
         MOVE      "0",LINEZ
         MOVE      " ",REPLY
. 
         CALL      OPENCUST
. 
         TRAPCLR   IO
         TRAP      NOARFL IF IO
         OPEN      ARFILES,ARFILEXX
         GOTO      CLCRNT
. 
NOARFL   BEEP
         DISPLAY   *P1:24,*HON,"A/R FILE NOT AVAILABLE - ABORTING"
         GOTO      NOARFL
. 
. 
. FIRST CALCULATE THE AGEING DATE RANGES!
. 
CLCRNT   CLOCK     DATE  TO TODAY
         MOVE      TODAY TO MONX
         MOVE      MONX  TO TMON
         RESET     TODAY TO 4
         MOVE      TODAY TO DAYX
         MOVE      DAYX  TO TDAY
         RESET     TODAY TO 7
         MOVE      TODAY TO TYEAR
         RESET     TODAY TO 1
         CALL      CALCDATE

         MOVE      TESTDATE TO CURRDATE
         MOVE      CURRDATE TO DTCURNT
         MOVE      DTCURNT  TO DT130PD
         SUB       "30"   FROM DT130PD
         MOVE      DT130PD  TO DT3160PD
         SUB       "30"   FROM DT3160PD
         MOVE      DT3160PD TO DT6190PD
         SUB       "30"   FROM DT6190PD
         MOVE      DT6190PD TO DTOV90PD
         SUB       "30"   FROM DTOV90PD
.
         COMPARE   "9",SECURITY
         GOTO      NOPRT IF NOT EQUAL
.
         PRINT     *F,"CURRENT DATE = ",DTCURNT
         PRINT     *1,"P/D 1-30     = ",DT130PD
         PRINT     *1,"P/D 31-60    = ",DT3160PD
         PRINT     *1,"P/D 61-90    = ",DT6190PD
         PRINT     *1,"P/D OVR 90   = ",DTOV90PD
.
.
. 
NOPRT    DISPLAY   *ES,*HON,*P01:04,"AGED RECEIVABLES SUMMARY SPECIAL":
                   *P01:06,"YOU MAY ENTER UP TO 40 ACCOUNTS TO BYPASS! ":
                   *HOFF
         MOVE      " ",REPLY
         MOVE      "A",COMPANY
. 
OKAY     KEYIN     *P01:10,"PLEASE MOUNT STANDARD STOCK PAPER":
                   *P01:11,"....AND PRESS ENTER WHEN YOU ARE READY",REPLY
.
         MOVE      "00" TO ACCTINDX
         MOVE      "00" TO ACCTLIMT
.
KEYACCTS KEYIN     *P1:23,*EL,"ENTER ACCOUNT NUMBER TO BYPASS, OR PRESS F5":
                   " TO PRINT ",ACCTIN
         GOTO      RDLOOP IF F5
.
         ADD       "01" TO ACCTINDX
         COMPARE   "41" TO ACCTINDX
         GOTO      TOOMUCH IF EQUAL
.
         STORE     ACCTIN INTO ACCTINDX OF ACCT1,ACCT2,ACCT3,ACCT4,ACCT5:
                                           ACCT6,ACCT7,ACCT8,ACCT9,ACCT10:
                                           ACCT11,ACCT12,ACCT13,ACCT14,ACCT15:
                                           ACCT16,ACCT17,ACCT18,ACCT19,ACCT20:
                                           ACCT21,ACCT22,ACCT23,ACCT24,ACCT25:
                                           ACCT26,ACCT27,ACCT28,ACCT29,ACCT30:
                                           ACCT31,ACCT32,ACCT33,ACCT34,ACCT35:
                                           ACCT36,ACCT37,ACCT38,ACCT39,ACCT40
.
         ADD       "01" TO ACCTLIMT
         GOTO      KEYACCTS
.
TOOMUCH  BEEP
         DISPLAY   *P1:23,*EL,*HON,"YOU HAVE ENTERED 40 ACCOUNTS ALREADY! ":
                   *W3,*HOFF,*P1:23,*EL
.
RDLOOP   TRAPCLR   IO
         TRAP      RCVIOERR IF IO
         READKS    ARFILES;INVKEY,INVTYPE,INVCOMP,INVSTAT,INVCUST:
                           INVDATE,INVTOTL,IPMNTS:
                           IAMTPD1,IAMTPD2,IAMTPD3,IAMTPD4,IAMTPD5:
                           ICHK1,ICHK2,ICHK3,ICHK4,ICHK5:
                           IDTPD1,IDTPD2,IDTPD3,IDTPD4,IDTPD5:
                           IDOLSLFT,IPRGDTE
.
         GOTO      EOJ IF OVER
.
. 
. 
. BYPASS THE ZERO RECORD
. 
         MATCH     "00000" TO INVKEY
         GOTO      RDLOOP  IF EQUAL
.....................................
. 
. 
. BYPASS ITEM WHICH ARE:  PAID        (INVSTAT = "X")
.                         VOID        (INVSTAT = "V")
.                         WRITEOFF    (INVSTAT = "W")
. 
         CMATCH    "X",INVSTAT
         GOTO      RDLOOP IF EQUAL
         CMATCH    "W",INVSTAT
         GOTO      RDLOOP  IF EQUAL
         CMATCH    "V",INVSTAT
         GOTO      RDLOOP  IF EQUAL
. 
......................................................
RDLP1    CMATCH    "1",FIRSTSW
         CALL      FIRSTONE IF EQUAL
.
ACCTBYPS CALL      BYPACCT
         CMATCH    "B",BYPSW
         GOTO      RDLOOP IF EQUAL
.
. 
C1       MATCH     INVCUST,CURRACCT
         CALL      ACCTBRK  IF  NOT  EQUAL    (PRINT TRAILER/THEN NEW HEADER)
. 
         MOVE      INVDATE  TO  WKDATE6       (SET UP TO AGE THE ITEM)
         MOVE      INVTOTL  TO  IDOLSLFT
         CALL      CALCTOTL    (DETERMINE AMOUNT OUTSTANDING AND ITEM TYPE)
. 
.........C2       CALL      AGEIT      (AGEING BUCKETS ARE INCREMENTED HR)
.........C2       MOVE      WKDATE6 TO MONX
.
C2       MOVE      INVDATE TO MONX
         MOVE      MONX    TO TMON
.
         RESET     INVDATE TO 3
         MOVE      INVDATE TO DAYX
         MOVE      DAYX    TO TDAY
.
         RESET     INVDATE TO 5
         MOVE      INVDATE TO YEARX
         MOVE      YEARX   TO TYEAR
.
         CALL      CALCDATE
.
         MOVE      WORKFLD TO CMPDAYS
.
         CALL      CKOV90
.
. NOW THE CALCULATED NUMBER IS LOCATED IN "TESTDATE"
.
. 
C3       GOTO      RDLOOP
. 
. 
CALCTOTL MOVE      IDOLSLFT  TO  WKPRINT
         MOVE      "INVOICE"  TO  PTYPE
.
MOVE0    MOVE      "0"      TO  WKSUB
. 
         CMATCH    "C",INVTYPE             (IS IT A CREDIT ?)
         GOTO      CALCB1   IF  NOT  EQUAL
         MOVE      "CREDIT "    TO   PTYPE
         MULT      "-1"  BY  WKPRINT         (YES...REVERSE THE AMOUNT)
         ADD       WKPRINT  TO  CREDTOTL
. 
CALCB1   MOVE      WKPRINT  TO  WKAMT
CB1RTRN  RETURN
.
.......        INCLUDE   APDATES
.
BYPACCT  MOVE      "00" TO ACCTINDX
         MOVE      " "  TO BYPSW
BYP1     ADD       "01" TO ACCTINDX
         COMPARE   ACCTLIMT,ACCTINDX
         GOTO      CHEKIT IF LESS
         GOTO      CHEKIT IF EQUAL
.
. FALLTHRU MEANS END OF LIST
. 
         GOTO      CHEKEXIT
.
CHEKIT   MOVE      "0000"  TO   ACCTARG
         LOAD      ACCTARG FROM ACCTINDX OF ACCT1,ACCT2,ACCT3,ACCT4,ACCT5:
                                            ACCT6,ACCT7,ACCT8,ACCT9,ACCT10:
                                            ACCT11,ACCT12,ACCT13,ACCT14,ACCT15:
                                            ACCT16,ACCT17,ACCT18,ACCT19,ACCT20:
                                            ACCT21,ACCT22,ACCT23,ACCT24,ACCT25:
                                            ACCT26,ACCT27,ACCT28,ACCT29,ACCT30:
                                            ACCT31,ACCT32,ACCT33,ACCT34,ACCT35:
                                            ACCT36,ACCT37,ACCT38,ACCT39,ACCT40
.
         MATCH     ACCTARG TO INVCUST
         GOTO      SETBYP  IF EQUAL
         GOTO      BYP1
.
SETBYP   MOVE      "B" TO BYPSW
CHEKEXIT RETURN
.
. 
. 
. 
AGETOTS  ADD       AMTCURNT   TO  TOTCURNT
         ADD       AMT130P    TO  TOT130
         ADD       AMT3160P   TO  TOT3160
         ADD       AMT6190P   TO  TOT6190
         ADD       AMTOV90P   TO  TOTOV90
         RETURN
. 
PRINTDTL PRINT     *6,PTYPE,*18,INVKEY,*28,CCMON,"/",CCDAY,"/",CCYR:
                   *41,WKPRINT,*53,WKSUB,*66,WKAMT
         ADD       "1",LINEZ
         COMPARE   "55",LINEZ
         CALL      HDR  IF  NOT  LESS   
         RETURN
. 
FIRSTONE MOVE      INVCUST  TO  CUSTKEY
         CALL      GETCUST
         MOVE      INVCUST  TO  CURRACCT
         CALL      HDR
         MOVE      " ",FIRSTSW
         RETURN
. 
HDR      ADD       "1"  TO  PAGEZ
         PRINT     *F:
                   *51,"AGED ACCOUNTS RECEIVABLE REPORT":
                   *111,"AS OF ",TODAY
. 
LIBHEAD  PRINT     *55,"APC COMPONENTS, INC.",*111,"PAGE ",PAGEZ
         GOTO      TITPRNT
. 
REPHEAD  PRINT     *55,"XXXXXXXX XXXXXXXXX INC.",*111,"PAGE ",PAGEZ
. 
TITPRNT  PRINT     " "
         PRINT     *2,"ACCOUNT   NAME",*47,"CURRENT",*60,"PAST DUE":
                   *74,"PAST DUE",*88,"PAST DUE",*102,"PAST DUE":
                   *117,"ACCOUNT"
         PRINT     *2,"NUMBER",*48,"1-30",*62,"31-60",*76,"61-90":
                   *89,"91-120",*102,"OVER 120",*118,"TOTAL"                  
         MOVE      "6"  TO  LINEZ
         RETURN
. 
ACCTBRK  CALL      AGETOTS
         ADD       "1"       TO  RECCNT
         MOVE      AMT130P   TO  PDTOTL
         ADD       AMT3160P  TO  PDTOTL
         ADD       AMT6190P  TO  PDTOTL
         ADD       AMTOV90P  TO  PDTOTL
         MOVE      AMTCURNT  TO  NETBAL
         ADD       PDTOTL    TO  NETBAL
         ADD       NETBAL    TO  TOTNET
. 
. ...................................................................
. NOTE THAT CREDTOTL IS ALREADY NEGATIVE...HENCE ADD VICE SUBTRACT
. ...................................................................
....     ADD       CREDTOTL  TO  NETBAL
. ...................................................................
         PRINT     " "
         PRINT     *3,CUSTKEY,*10,CUSTNAME:
                   *44,AMTCURNT,*58,AMT130P,*72,AMT3160P,*86,AMT6190P:
                   *100,AMTOV90P,*115,NETBAL,*FLUSH
         MOVE      "0"  TO  PDTOTL
         MOVE      "0"  TO  NETBAL
         MOVE      "0"  TO  AMTCURNT
         MOVE      "0"  TO  AMT130P
         MOVE      "0"  TO  AMT3160P
         MOVE      "0"  TO  AMT6190P
         MOVE      "0"  TO  AMTOV90P
         MOVE      "0"  TO  CREDTOTL
         MOVE      "0"  TO  WKSUB
         MOVE      "0"  TO  WKAMT
         ADD       "2"  TO  LINEZ
         COMPARE   "58" TO  LINEZ                                             
         CALL      HDR  IF  NOT  LESS
         MOVE      INVCUST  TO  CUSTKEY
         CALL      GETCUST
         MOVE      CUSTKEY  TO  CURRACCT
         RETURN
. 
. NOTE.....MODIFY THIS IF YOU WANT TO PRINT DETAILS AND GET A
.          FINAL ACCOUNT TOTAL LINE !
. 
         INCLUDE   CUSTIO.TXT
. 
         INCLUDE   RCVBLSIO.TXT
. 
         INCLUDE   DATECALC.TXT

         INCLUDE   APDATES.TXT
. 
EOJ      CALL      ACCTBRK
         CALL      REPTOTS
         BEEP
         DISPLAY   *ES,*P01:04,"END OF AGED RECEIVABLES PRINT",*W5
         RELEASE
         CHAIN     FROMPGM
. 
INVCRTRN RETURN
. 
REPTOTS  COMPARE   "54",LINEZ
         CALL      HDR IF LESS
         PRINT     *L,*L
         PRINT     *1,ASTER45,ASTER45,ASTER45
         PRINT     " "
         PRINT     *10,"COMPANY TOTALS:"
         CMATCH    "R",COMPANY
         GOTO      RPT1 IF NOT EQUAL
         MOVE      "REPUBLIC FASTENERS INC."  TO  COMPDISP
RPT1     PRINT     *10,COMPDISP,*44,TOTCURNT,*58,TOT130,*72,TOT3160:
                   *86,TOT6190,*100,TOTOV90,*113,TOTNET
         PRINT     " "
         PRINT     *1,ASTER45,ASTER45,ASTER45,*FLUSH
         RETURN
. 

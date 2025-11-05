. A/R FILE UPDATE PROGRAM....MODIFIED 2/2/82 TO PERMIT MAINTENANCE TO
.                            THE AMOUNT PAID FIELDS FOR BOUNCED CHECKS
         INCLUDE   COMMON.TXT
. 
         INCLUDE   RCVBLES.TXT
. 
ARFILES  IFILE     KEYL=10,UNCOMPRESSED
ARFILEXX INIT      "ARFILEXX.ISI"
. 
IOSW     DIM       1
REPLY    DIM       1
KACCT    DIM       4
KINV     DIM       5
KINVN    FORM      5
STARTKEY DIM       10
TYPE     DIM       1
PASSWORD DIM       10
MONEY    INIT      "LAURA"
BOATS    INIT      "BOATS"
DAVID    INIT      "DAVID"

ROLLNAME INIT      "ROLLFILE/SYST"
MODSW    DIM       1
. 
. 
GETPSWD  KEYIN     *ES,*P01:04,"PLEASE ENTER YOUR PASSWORD !  ",*EOFF,PASSWORD
         MATCH     MONEY    TO  PASSWORD
         GOTO      OKAY     IF  EQUAL
         MATCH     BOATS    TO  PASSWORD
         GOTO      OKAY     IF  EQUAL
         MATCH     DAVID    TO  PASSWORD
         GOTO      OKAY     IF  EQUAL
         BEEP
         DISPLAY   *ES,*P01:04," * * *   S E C U R I T Y   V I O L A T I ":
                   "O N   * * * ":
                       *P01:06,"ONLY AUTHORIZED PERSONS MAY ALTER THE ":
                       "ACCOUNTS RECEIVABLE DATA !",*W3
         CHAIN     "ARMENU1 "
. 
OKAY     OPEN      ARFILES,ARFILEXX
         DISPLAY   *ES,*P25:01,"CORRECT THE RECEIVABLES FILE"
GETINVC  KEYIN     *P1:4,*EL,"ENTER DESIRED ACCOUNT ",*JR,*DE,KACCT
         MOVE      " "  TO  MODSW
         RESET     KACCT  TO  4
         GOTO      GETINVC IF EOS
         RESET     KACCT  TO  1
GETINV   KEYIN     *P40:04,*EL,"ENTER DESIRED INVOICE ",KINV
         RESET     KINV  TO  5
         GOTO      GETINV IF EOS
         RESET     KINV  TO  1
         MOVE      KINV  TO  KINVN
         MOVE      KINVN TO  KINV
.         REP       " 0"  IN  KINV
. 
GETTYPE  MOVE      " " TO TYPE
         KEYIN     *P1:6,*EL,"(I)nvoice or (C)redit ? ",TYPE
         CMATCH    "I",TYPE
         GOTO      TYPOK IF EQUAL
         CMATCH    "C",TYPE
         GOTO      TYPOK IF EQUAL
         BEEP
         DISPLAY   *P1:23,*EL,"INVALID CODE! ",*W3,*P1:23,*EL
         GOTO      GETTYPE
.
TYPOK    CLEAR     STARTKEY
         APPEND    KACCT TO STARTKEY
         APPEND    TYPE  TO STARTKEY
         APPEND    KINV   TO  STARTKEY
         RESET     STARTKEY  TO  10
         LENSET    STARTKEY
         RESET     STARTKEY
BBB      DISPLAY   *P60:23,*EL,"KEY IS ",STARTKEY,*W5
GETIT    TRAPCLR   IO
         TRAP      BUMREAD IF IO
         READ      ARFILES,STARTKEY;INVKEY,INVTYPE,INVCOMP,INVSTAT,INVCUST:
                                    INVDATE,INVTOTL,IPMNTS:
                                    IAMTPD1,IAMTPD2,IAMTPD3,IAMTPD4,IAMTPD5:
                                    ICHK1,ICHK2,ICHK3,ICHK4,ICHK5:
                                    IDTPD1,IDTPD2,IDTPD3,IDTPD4,IDTPD5:
                                    IDOLSLFT,IPRGDTE
         GOTO      SHUCKS IF OVER
         GOTO      DISP
. 
BUMREAD  BEEP
         DISPLAY   *P1:23,*EL,"UNABLE TO READ THE A/R FILE - JOB ABORTED":
                   *W4
         CHAIN     "ARMENU1"
DISP     DISPLAY   *P01:06,"KEY IS ",INVKEY," TYPE IS ",INVTYPE:
                   *P01:07,"STATUS IS ",*P25:07,INVSTAT:
                   *P01:08,"DATE IS ",*P25:08,INVDATE:
                   *P01:09,"INVTOTL IS ",*P25:09,INVTOTL:
                   *P01:10,"IDOLSLFT IS ",*P25:10,IDOLSLFT:
                   *P01:11,"ACCT IS ",*P25:11,INVCUST:
                   *P01:12,"COMPANY CODE IS ",*P25:12,INVCOMP:
                   *P01:13,"PAYMENT 1 AMT:  ",*P25:13,IAMTPD1:
                   *P01:14,"PAYMENT 2 AMT:  ",*P25:14,IAMTPD2:
                   *P01:15,"PAYMEMT 3 AMT:  ",*P25:15,IAMTPD3:
                   *P01:16,"PAYMENT 4 AMT:  ",*P25:16,IAMTPD4:
                   *P01:17,"PAYMENT 5 AMT:  ",*P25:17,IAMTPD5
. 
. 
         MOVE      " " TO REPLY
         KEYIN     *P01:23,*EL,*HON,"MAKE ANY CHANGES ? ",*HOFF,REPLY
         CMATCH    "Y",REPLY
         GOTO      MORE IF NOT EQUAL
         COMPARE   "9",SECURITY
         GOTO      KEYREST  IF  NOT  EQUAL
         KEYIN     *P25:06,*RV,INVKEY
. 
KEYREST  DISPLAY   *P1:23,*EL,*HON,"KEY -X- IN STATUS TO DELETE INVOICE",*HOFF
. 
         KEYIN     *P25:07,*RV,INVSTAT:
                   *P25:08,*RV,INVDATE:
                   *P25:09,*RV,INVTOTL:
                   *P25:10,*RV,IDOLSLFT:
                   *P25:11,*RV,INVCUST:
                   *P25:13,*RV,IAMTPD1:
                   *P25:14,*RV,IAMTPD2:
                   *P25:15,*RV,IAMTPD3:
                   *P25:16,*RV,IAMTPD4:
                   *P25:17,*RV,IAMTPD5
. 
. ADDED 2/4/84
. 
         CMATCH    "O",INVSTAT
         GOTO      STATOK IF EQUAL
         CMATCH    "P",INVSTAT
         GOTO      STATOK IF EQUAL
         CMATCH    "W",INVSTAT
         GOTO      STATOK IF EQUAL
         CMATCH    "X",INVSTAT
         GOTO      STATOK IF EQUAL
. 
         BEEP
         DISPLAY   *P1:23,*EL,*HON,"STATUS CODE INPUT NOT ACCEPTED - RE-":
                   "ENTER",*HOFF,*W2,*P1:23,*EL
         GOTO      KEYREST
. 
STATOK   CALL      PUTRCVB
         CALL      GETRCVB
         GOTO      DISP
. 
MORE     KEYIN     *P01:23,*EL,"MORE ? ",REPLY
         CMATCH    "Y",REPLY
         GOTO      GETINVC  IF  EQUAL
. 
         BEEP
ASKINDX  MOVE      " " TO REPLY
         KEYIN     *P1:22,*EF,*HON,"DO YOU WANT TO REINDEX THE A/R FILE ":
                   "AT THIS TIME ? (Y/N) ",*HOFF,REPLY
         CMATCH    "Y",REPLY
         GOTO      INDXIT IF EQUAL
         CMATCH    "N",REPLY
         GOTO      GETOUT IF EQUAL
         BEEP
         GOTO      ASKINDX
         DISPLAY   *P01:23,"WE WILL NOW RE-INDEX THE A/R FILE",*W2
. 
INDXIT   ROLLOUT   "F:\UTILS\ARINDX.BAT"
. 
GETOUT   CHAIN     "ARMENU1"
. 
SHUCKS   CMATCH    "X" TO MODSW
         GOTO      MORE  IF  EQUAL
         REPLACE   " 0" IN STARTKEY
         MOVE      "X" TO MODSW
         RESET     STARTKEY TO 5
         CMOVE     "C" TO STARTKEY
         RESET     STARTKEY TO 10
         LENSET    STARTKEY
         RESET     STARTKEY TO 1
         DISPLAY   *P01:23,*EL,"RECORD NOT FOUND",*W3
         GOTO      BBB
. 
         INCLUDE   ARFLXXIO.TXT
. 
INVCRTRN RETURN

. INVCSCRN/TXT - DISPLAY OPEN INVOICES/CREDITS FOR A GIVEN ACCOUNT
.                IN THE SAME FORMAT AS DISPLAYED IN THE CASH SCREEN
. 
. WRITTEN BY R BACHARACH, MICRO SYSTEMS CONSULTANTS
.                          41 TEELE DRIVE
.                          CORAM, NEW YORK 11727
.                          (516) 698-5577
. 
. WRITTEN  10/24/81 TO ACCESS NEWLY DESIGNED RECEIVABLES FILE
.                    WHOSE KEY IS:  ACCT 4/INVOICE 5
. 
         INCLUDE   COMMON.TXT
. 
.  WORK AREAS FOR CASH CALCULATIONS
. 
IPCHECK  DIM       6        CHECK NUMBER INPUT
IPDTPAY  DIM       6        DATE PAID (ie. CHECK RECEIVED)
IPCHKAMT FORM      6.2      CHECK AMOUNT  (MAY BE PAYMENT FOR MULTIPLE ITEMS)
IPACCT   DIM       4        CUSTOMER KEY
. 
DOLSPRGD FORM      6.2      DOLLARS KEYED OFF FROM CHECK
IPAID    FORM      6.2      DOLLARS PAID THIS INVOICE
ANSWER   DIM       1        RESPONSE FIELD  (Y OR N)
. 
INVC     INIT      "INVC"
CRED     INIT      "CRED"
. 
CTLSW    DIM       1
. 
INVCFILE IFILE     KEYL=10,UNCOMPRESSED
INVNAME  INIT      "ARFILEXX.ISI"
. 
. 
. 10/3/81    SUBSTITUTE THESE WORK FIELDS FOR 
.            THE PREVIOUS COPY OF "INVOICES/TXT"
. 
. INVORDNO DIM       10
. MOREORDR DIM       30
. INVSHIP  DIM       10
. INVBLNO  DIM       10
. INVFOB   DIM       1
. FRGTRATE FORM      2.2
. INVWGHT  FORM      6
. INVDTPAY DIM       6
. INVCHECK DIM       6
. IAMTRCVD FORM      6.2
. INVMESG  DIM       80
. 
         INCLUDE   RCVBLES.TXT
. 
ARFILEXX INIT      "ARFILEXX.ISI"
. 
. 
CUSTFILE IFILE     KEYL=4
CSTNAME  INIT      "ACCOUNTS.ISI"
. 
         INCLUDE   CUSTMAST.TXT
. 
SEQ      FORM      "-1"
. 
ROW      FORM      "06"    START DETAILS WITH SIXTH ROW ON THE SCREEN
. 
IOSW     DIM       1       I/O INDICATOR
. 
ZERO     FORM      "000000.00"
. 
ITEMCNT  FORM      2
TESTCNT  FORM      2.2
PT2      FORM      .2
D2       DIM       2
. 
WRKFLDS  DIM       1
. 
         INCLUDE   INVCTABL.TXT
. 
INVCKEYZ DIM       12      KEY TO SPECIAL ISI FILE (ACCT 4/INVOICE 5)
. 
IPCOMP   DIM       1
DSPCOMP  DIM       8
ITYPE    DIM       4
LINENUMB DIM       2
SELECTED FORM      2
CASHLEFT FORM      6.2
ICNTR    FORM      2
TOTBAL   FORM      7.2
DOLRWORK FORM      7.2
FORM6    FORM      6
STARTKEY DIM       12
PMTINDX  FORM      1
FULLPAGE DIM       1
REPLY    DIM       1
. 
+ .....................................................................
. PROCEDURE DIVISION FOR ALL YOU COBOL GUYS!
. .....................................................................
. 
OPENZ    CALL      OPENCUST
         TRAPCLR   IO
         OPEN      INVCFILE,ARFILEXX
. 
FIRSTDSP DISPLAY   *ES,*P24:01,*HON,"ACCOUNTS RECEIVABLE - OPEN ":
                   "ITEM INQUIRY",*P71:01,TODAY,*HOFF
IPACCT   DISPLAY   *P01:03,*EL
         KEYIN     *P01:02,"ENTER CUSTOMER NO.  ____",*P21:02,*DE,*JR,IPACCT
         DISPLAY   *P21:2,IPACCT
         CMATCH    " ",IPACCT
         GOTO      IPACCT IF EOS
         MOVE      IPACCT TO CUSTKEY
         CALL      GETCUST
         CMATCH    "H"    TO IOSW
         GOTO      DISPNAME  IF EQUAL
         BEEP
         GOTO      IPACCT
DISPNAME DISPLAY   *P31:02,"NAME  ",CUSTNAME
CUSTOKAY KEYIN     *P01:03,"CORRECT CUSTOMER ?  (Y or N) ",ANSWER
         CMATCH    "Y"  TO ANSWER
         GOTO      WHATCOMP  IF  EQUAL
         CMATCH    "N"  TO  ANSWER
         GOTO      IPACCT    IF   EQUAL
         BEEP
         GOTO      CUSTOKAY
. 
WHATCOMP MOVE      CUSTKEY  TO  FORM6
         DISPLAY   *P01:03,*EL
LIBIT    MOVE     "S"       TO  IPCOMP
. 
OKAYCOMP MOVE      "AMERICAN" TO DSPCOMP
SHOWCOMP DISPLAY   *P71:02,DSPCOMP
         MOVE      " "       TO  FULLPAGE     (INDICATE JUST STARTING)
. 
TITDISP  DISPLAY   *P30:04,"OPEN ITEMS THIS ACCOUNT":
                   *P01:05,"LN  INV.   INV DATE  TYPE  AMOUNT OPEN   LN  ":
                               "INV.   INV DATE  TYPE  AMOUNT OPEN"
         MOVE      "0"  TO  ITEMCNT
         MOVE      "5"  TO  ROW
         MOVE      "            " TO INVCKEYZ
         CLEAR     INVCKEYZ
         APPEND    CUSTKEY TO INVCKEYZ
         APPEND    "      " TO INVCKEYZ
         RESET     INVCKEYZ TO   1     POINT AT THE BEGINNING
. 
. READ THE RCVBLE FILE KEY SEQUENTIALLY
. 
         TRAPCLR   IO
         TRAP      RCVIOERR IF IO
.
. THE FOLLOWING INSTRUCTION IS AN AUTOMATIC RECORD NOT FOUND
. BUT POSITIONS THE FILE AT THE POSSIBLE BEGINNING OF THE SPECIFIED ACCOUNT
.
         MOVE      INVCKEYZ  TO  STARTKEY
         READ      INVCFILE,STARTKEY;INVKEY,INVTYPE,INVCOMP,INVCUST
. 
INVCLOOP TRAPCLR   IO
         TRAP      RCVIOERR IF IO
. 
. CONTROL THE AMOUNT OF DISPLAY TO 32 ITEMS, BUT PREVENT THE LOSS
. OF DISPLAY ITEMS ...(ie.  DONT READ FIRST!)
. 
. 
         ADD       "1"  TO  ITEMCNT
         COMPARE   "33" TO  ITEMCNT
         GOTO      NEWPAGE  IF  NOT  LESS
. 
         READKS    INVCFILE;INVKEY,INVTYPE,INVCOMP,INVSTAT,INVCUST:
                            INVDATE,INVTOTL,IPMNTS:
                            IAMTPD1,IAMTPD2,IAMTPD3,IAMTPD4,IAMTPD5:
                            ICHK1,ICHK2,ICHK3,ICHK4,ICHK5:
                            IDTPD1,IDTPD2,IDTPD3,IDTPD4,IDTPD5:
                            IDOLSLFT,IPRGDTE
. 
         GOTO      NOMORE IF OVER
. 
. CHECK FOR PROPER ACCOUNT
. 
         MATCH     CUSTKEY  TO  INVCUST
         GOTO      NOMORE  IF  NOT  EQUAL
. 
.  IS IT AN OPEN RECEIVABLE ?
. 
. 
         CMATCH    "P"  TO  INVSTAT
         GOTO      PRTBYP   IF  EQUAL
         CMATCH    "O"  TO  INVSTAT
         GOTO      PRTBYP   IF  EQUAL
. 
LOOPBACK SUBTRACT  "1"  FROM  ITEMCNT
         GOTO      INVCLOOP
. 
PRTBYP   TRAPCLR   PARITY  (NOP)
         MATCH     IPACCT   TO   INVCUST
         GOTO      NOMORE IF NOT EQUAL
.........       CMATCH    IPCOMP   TO   INVCOMP
.........       GOTO      INVCLOOP IF NOT EQUAL
. 
         CMATCH    "C"      TO   INVTYPE
         GOTO      NOTCRED  IF   NOT  EQUAL
         CALL      CREDDOLS
         GOTO      SETTYPE
. 
NOTCRED  CALL      DEBDOLS
. 
SETTYPE  MOVE      "INVC"   TO  ITYPE
         CMATCH    "C"      TO  INVTYPE
         GOTO      SHOWMORE IF  NOT EQUAL
         MOVE      "CRED"   TO  ITYPE
. 
SHOWMORE COMPARE   "05"    TO  ROW
         GOTO      INCRITEM  IF  NOT  EQUAL
YES6     DISPLAY  *P01:06,*EF
INCRITEM ADD       "0"   TO  ITEMCNT
. 
         STORE     INVKEY INTO ITEMCNT OF INVC1,INVC2,INVC3,INVC4,INVC5:
                                          INVC6,INVC7,INVC8,INVC9,INVC10:
                                          INVC11,INVC12,INVC13,INVC14,INVC15:
                                          INVC16,INVC17,INVC18,INVC19,INVC20:
                                          INVC21,INVC22,INVC23,INVC24,INVC25:
                                          INVC26,INVC27,INVC28,INVC29,INVC30:
                                          INVC31,INVC32,INVC33,INVC34
. 
         MOVE      ITEMCNT   TO  TESTCNT
         DIVIDE    "2"   INTO    TESTCNT
         MOVE      TESTCNT   TO  PT2
         CALL      SETDOLRS
         MOVE      ITEMCNT   TO  D2
         REP       " 0"      IN  D2
         COMPARE   ".00"     TO  PT2
         GOTO      LEFTSIDE  IF  NOT EQUAL
         GOTO      RITESIDE
. 
LEFTSIDE ADD       "1"  TO  ROW     (ONLY INCREMENT ON THE LEFT SIDE!!)
         DISPLAY   *P01:ROW,D2,"  ",INVKEY,"   ",INVDATE,"   ":
                   ITYPE,"   ",DOLRWORK
         GOTO      INVCLOOP
RITESIDE DISPLAY   *P42:ROW,D2,"  ",INVKEY,"   ",INVDATE,"   ":
                   ITYPE,"   ",DOLRWORK
         GOTO      INVCLOOP
. 
SETDOLRS MOVE      IDOLSLFT  TO  DOLRWORK
         CMATCH    "C"       TO  INVTYPE
         GOTO      SDLRTRN   IF  NOT EQUAL
         MULTIPLY  "-1"      BY  DOLRWORK
SDLRTRN  RETURN
. 
NEWPAGE  MOVE      "X"       TO  FULLPAGE
         MOVE      "0"       TO  ITEMCNT
         MOVE      "05"      TO  ROW
. 
NOMORE   CALL      DISPDOLS
         DISPLAY  *P01:23,*EF
         CMATCH    "X",FULLPAGE
         GOTO      EOJ  IF  NOT  EQUAL
         MOVE      " ",REPLY
         MOVE      " ",FULLPAGE
FULLKEYN KEYIN    *P01:23," * * ADDITIONAL  INVOICES  * * ":
                          "   DO YOU WISH TO SEE THEM ? (Y/N) ",REPLY
         CMATCH    "Y",REPLY
         GOTO      INVCLOOP  IF  EQUAL
         GOTO      EOJ
. 
. 
CREDDOLS MOVE      IDOLSLFT TO DOLRWORK
         MULT      "-1"     BY DOLRWORK
         ADD       DOLRWORK TO TOTBAL
         RETURN
. 
DEBDOLS  ADD       IDOLSLFT TO TOTBAL
         MOVE      IDOLSLFT TO DOLRWORK
         RETURN
. 
INVCRTRN RETURN
. 
DISPDOLS DISPLAY   *P01:22,*EL,*P01:22,"OPEN BALANCE = $",TOTBAL
         RETURN
. 
DRITE    MOVE      TESTCNT  TO ROW
         ADD       "5"      TO ROW
         DISPLAY   *P51:ROW,"*"
         RETURN
DLEFT    MOVE      TESTCNT  TO ROW
         ADD       "5"      TO ROW
         DISPLAY   *P11:ROW,"*"
         RETURN
. 
EOJ      KEYIN    *P01:23,*EL,"DISPLAY MORE ACCOUNTS ?  (Y/N) ",ANSWER
         CMATCH   "N",ANSWER
         GOTO     ENDIT  IF  EQUAL
. 
         MOVE     "0"  TO  ITEMCNT
         MOVE     "0"  TO  TESTCNT
         MOVE     "0"  TO  PT2
         MOVE     "0"  TO  TOTBAL
         MOVE     "0"  TO  DOLRWORK
         MOVE     "0"  TO  ICNTR
         MOVE     "06" TO  ROW
         GOTO     FIRSTDSP           (GO DO IT   A G A I N !)
. 
ENDIT    CHAIN     "ARMENU1"
. 
         INCLUDE   CUSTIO.TXT

         INCLUDE   RCVBLSIO.TXT
. 
CANTREAD BEEP
         DISPLAY   *ES,*P01:12,"CANT READ THE SPECIAL ACCT/INVC/ISI FILE"
         BEEP
         GOTO      CANTREAD
. 
         STOP

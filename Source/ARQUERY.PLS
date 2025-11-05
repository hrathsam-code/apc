. ARQUERY/TXT  -  DISPLAY UNKNOWN CUSTOMER IF INVOICE KNOWN
. 
. WRITTEN BY R BACHARACH,  MICRO SYSTEMS CONSULTANTS
.                          41 TEELE DRIVE
.                          CORAM, NEW YORK 11727
.                          (516) 698-5577
. WRITTEN 7/7/84
. 
         INCLUDE   COMMON.TXT
.
NAME     INIT      "ARFILE.ISI"
INPUT    IFILE     KEYL=5,UNCOMPRESSED    (ISAM INPUT )
. 
. 
REPLY    DIM       1
SWMR     FORM      "0"         '1'=MATCHING RECORD
SW1P     FORM      "1"         '1'=FIRST CYCLE
LINECT   FORM      "000"           LINE COUNTER
PAGE     FORM      3           PAGE NUMBER
RID01    FORM      "0"         RECORD TYPE 01
LR       FORM      "0"         '1'=LAST RECORD PENDING
LRTOT    FORM      5            GRAND TOTAL
VOIDS    FORM      5
PAIDS    FORM      5
CRDTS    FORM      5
ORDRTOTS FORM      7.2
. 
IOSW     DIM       1
COMP     DIM       1
. 
. 
         INCLUDE   CUSTMAST.TXT
. 
CUSTFILE IFILE     KEYL=4
CSTNAME  INIT      "ACCOUNTS.ISI"
. 
         INCLUDE   RCVBLES.TXT
. 
COMPVAR  DIM       27
. 
MM       DIM       2
DD       DIM       2
YY       DIM       2
DATE8    DIM       8
. 
STATUS   DIM       8
STARTKEY DIM       5
+............................................................
. MAINLINE FOLLOWS
.
. FILE OPENING SEQUENCE
         DISPLAY   *ES,*P20:01,*HON,"ACCOUNTS RECEIVABLE INVOICE QUERY",*HOFF
. 
         GOTO      CONT1
. 
NOARFILE BEEP
         DISPLAY   *P01:23,*EL,"ACCOUNTS RECEIVABLE FILE NOT ON LINE",*W2
         GOTO       NOARFILE
. 
CONT1    TRAPCLR   IO
         TRAP      NOARFILE IF IO
         OPEN      RCVBFILE,RCVBNAME
.
         TRAPCLR   IO
         CALL      OPENCUST
         CMATCH    "H"  TO  IOSW
         GOTO      NOFILE   IF NOT EQUAL
         GOTO      GETCOMP
. 
NOFILE   BEEP
         DISPLAY   *P01:12,*EL,"ACCOUNT FILE NOT MOUNTED - ":
                               "JOB ABORTING",*W
         GOTO      CHAINOUT
. 
GETCOMP  TRAPCLR   PARITY    (NOP)
. 
*............................................................
GETINVC  MOVE      " " TO REPLY
. 
         DISPLAY   *P1:4,*EF,"ENTER INVOICE NUMBER TO DETERMINE IDENTITY":
                          " OF CUSTOMER "
. 
         CLEAR     STARTKEY
         KEYIN     *P56:04,*EL,*HON,*DE,STARTKEY,*HOFF
.
         INCLUDE   ARREAD.TXT
. 
         GOTO      RCVNTFD  IF  OVER
         GOTO      MOVEDATA
. 
RCVNTFD  BEEP
         DISPLAY   *P1:23,*EL,*HON,"INVOICE ",STARTKEY," NOT ON FILE! ":
                   *HOFF,*W3,*P1:23,*EL
         GOTO      MORE
. 
*............................................................
. 
MOVEDATA TRAPCLR   PARITY   (NOP)
         MOVE      INVCUST TO CUSTKEY
         CMATCH    "O" TO INVSTAT
         GOTO      CHKCLS IF NOT EQUAL
         MOVE      "OPEN " TO STATUS
         GOTO      TRAPS
CHKCLS   CMATCH    "P" TO INVSTAT
         GOTO      MAKCANC IF NOT EQUAL
         MOVE      "PARTIAL" TO STATUS
         GOTO      TRAPS
MAKCANC  CMATCH    "V"    TO  INVSTAT
         GOTO      MKC1   IF  NOT   EQUAL
         MOVE      "VOID"     TO    STATUS
         GOTO      TRAPS
MKC1     CMATCH    "X"    TO  INVSTAT
         GOTO      MKC2   IF  NOT   EQUAL
         MOVE      "PAID"     TO    STATUS
         GOTO      TRAPS
MKC2     CMATCH    "C"    TO  INVSTAT
         GOTO      MKC3   IF  NOT  EQUAL
         MOVE      "CRDT"     TO   STATUS
         GOTO      TRAPS
MKC3     MOVE      "DEL."     TO   STATUS
TRAPS    TRAPCLR   IO
         CALL      GETCUST
         CMATCH    "H"    TO IOSW
         GOTO      SETDATE   IF  EQUAL
PNOVEND  MOVE      "*ACCOUNT NOT ON FILE*" TO CUSTNAME
*............................................................
. CLEAR OUT ACCUMULATORS (DETAIL TIME)
.
SETDATE  TRAPCLR   IO
         MOVE      INVDATE TO DATE8
         MOVE      DATE8  TO MM
         RESET     DATE8  TO 3
         MOVE      DATE8  TO DD
         RESET     DATE8  TO 5
         MOVE      DATE8  TO YY
         RESET     DATE8
         CMATCH    "C"    TO INVTYPE
         GOTO      DETCALC IF NOT EQUAL
         MULT      "-1"   BY INVTOTL
         MULT      "-1"   BY IDOLSLFT
. 
DETCALC  ADD       "1" TO LRTOT
         ADD       IDOLSLFT TO ORDRTOTS
*............................................................
.
         DISPLAY   *P1:5,*EF,*P1:6,"ACCOUNT NO. ",CUSTKEY:
                   *P20:6,CUSTNAME:
                   *P20:7,CUSTADDR:
                   *P20:8,CUSTCITY,"  ",CUSTSTAT,"  ",CUSTZIP:
                   *P1:10,"INVOICE ",STARTKEY:
                          " (",INVSTAT,")":
                   *P20:10,"DATE ",INVDATE,"  ORIG. AMT. ",INVTOTL:
                           "  OPEN AMT. ",IDOLSLFT
. 
MORE     MOVE      " " TO REPLY
         KEYIN     *P1:23,*EL,"DISPLAY MORE INVOICES? (Y/N) ",REPLY
         CMATCH    "Y",REPLY
         GOTO      GETINVC IF EQUAL
         CMATCH    "N",REPLY
         GOTO      EOJ IF EQUAL
         BEEP
         GOTO      MORE
. 
*............................................................
         INCLUDE   CUSTIO.TXT
*............................................................
.
EOJ      DISPLAY   *ES

CHAINOUT CHAIN     "ARMENU1 "

. NCLINVCP  - PRINT NCL INVOICES/CREDITS
. 
. WRITTEN BY R BACHARACH,  MICRO SYSTEMS CONSULTANTS
.                          41 TEELE DRIVE
.                          CORAM, NEW YORK 11727
.                          (516) 698-5577
         INCLUDE   COMMON
. 
PRTCOMP  DIM       *1
NAME     INIT      "NCLINVHD/ISAM"
INPUT    IFILE     (ISAM INPUT )
. 
DETAILS  INIT      "NCLINVDT/ISAM"
DETFILE  IFILE
. 
PARTNAME INIT      "NCLINVNT/ISAM:NCLINVNT"
PARTFL   IFILE
. 
CUSTFILE IFILE
CSTNAME  INIT      "NCLACCTS/ISAM"
. 
REPLY    DIM       1
SWMR     FORM      "0"         '1'=MATCHING RECORD
SW1P     FORM      "1"         '1'=FIRST CYCLE
LINECT   FORM      3           LINE COUNTER
DETAILZ  FORM      2
ZIPX     DIM       5
INVYCOST FORM      6.2
PROFIT   FORM      6.2
PCTG     FORM      2.1
. 
PAGE     FORM      3           PAGE NUMBER
RID01    FORM      "0"         RECORD TYPE 01
LR       FORM      "0"         '1'=LAST RECORD PENDING
LRTOT    FORM      5            GRAND TOTAL
ORDRTOTS FORM      7.2
PN3      FORM      3
FOBCOD   DIM       7
. 
        INCLUDE    NCLCUST
        INCLUDE    INVOICES
        INCLUDE    NCLIVDTL
. 
. 
COMPVAR  DIM       24
. 
MM       DIM       2
DD       DIM       2
YY       DIM       2
DATE8    DIM       8
. 
NETINVC  FORM       7.2
TOTCOST  FORM       6.2
TOTPROF  FORM       5.2
BIGPCTG  FORM       6.2
FRTALLOW FORM      4.2
PKGQTYSV FORM       6
DIVISOR  FORM       6.6
ONEPT6   FORM       "001.000000"
STATUS   DIM       4
. 
KEGQTY   FORM      8
CALCFLD  FORM      8.3
LINECOST FORM      6.2
TOTDOLS  FORM      7.2
RUNDOLS  FORM      8.2
TSTKEGS  FORM      6
. 
COSTTOTL FORM      6.2
*............................................................
. 
         INCLUDE   NCLPTPO
. 
POKEY    DIM       7
RDPONO   FORM      5
RDPOKEY  DIM       7
. 
POKGSORD FORM      4
POKGSHPD FORM      4
POKGSRCD FORM      4
. 
IOSW     DIM       1
TYPE     DIM       3
PODOC    DIM       3
TOTPCS   FORM      9
. 
DIM7     DIM       7
FORM3PT3 FORM      3.3
. 
INVCN    FORM      5
INVCN1   FORM      5
TOTALKEG FORM      "00000"
. 
PASSCOMP DIM       1
KGSAVAIL FORM      6
PRTUOM   DIM       1
. 
         INCLUDE   NCLBARFD
. 
         INCLUDE   FORMSFLD
. 
+............................................................
. MAINLINE FOLLOWS
.
. FILE OPENING SEQUENCE
. 
         RELEASE
         DISPLAY   *ES,*HON,*P01:12,"PRINT NCL STUDS INVOICES":
                   *P01:14,"NOTE..THIS PROGRAM USES PURCHASE/INVOICE FORMS":
                   *W,*W,*W
         MOVE      "N" TO PRTCOMP
         MATCH     "L" TO PRTCOMP
         CALL      MOVLIB IF EQUAL
         MATCH     "N" TO PRTCOMP
         CALL      MOVREP IF EQUAL
         RESET     COMPVAR TO 24
         LENSET    COMPVAR
         RESET     COMPVAR
         MOVE      "00"    TO  DETAILZ
         BEEP
         DISPLAY *ES,*P01:24,"PLEASE FOLLOW THESE INSTRUCTIONS...CAREFULLY":
                   *C,*R,"FIRST CHANGE THE PRINT CHAIN - LOAD THE ONE WITH":
                         " THE WHITE DOT (DOT OUT)":
                   *C,*R," ":
                   *HON:
                   *C,*R,"NOW LOAD ":
                   *R,COMPVAR:
                   *R," FORMS ON THE PRINTER":
                   *HOFF:
                   *C,*R," ":
                   *C,*R,"NOW FEED THE INVOICE FORMS UP INTO THE PRINTER":
                 *C,*R,"MAKE SURE YOU COME UP BETWEEN THE TWO PLATES WITH THE":
                      " FINGERS AND THE HOLES"
         KEYIN     *C,*R,"......HIT ENTER FOR YOUR ":
                   "NEXT INSTRUCTIONS",REPLY
         KEYIN     *ES,*P01:24,"OKAY NOW...... WE`RE ALMOST THERE!":
                   *C,*R,"WE WILL NOW POSITION THE FORMS......":
                   *C,*R,*HON,"SET LEFT EDGE OF FORM  4  LINES TO THE RIGHT ":
                              "OF MINUS 10",*HOFF:
                   *C,*R,"NOW LOCK THE PAPER FEEDERS":
                         " (lower the black levers)":
                   *C,*R,"NOW RESET THE FORMS THICKNESS LEVER TO SETTING 3":
                 *C,*R,"NOW PUSH THE ROUND KNOB ON THE PAPER FEEDER SHAFT IN":
                 *C,*R,"AND ROTATE IT CLOCKWISE UNTIL THE PERFORATION IS JUST":
                   *C,*R,"SLIGHTLY ABOVE (1/8 INCH) OF THE PRINT HEAD":
                *C,*R,"NOW CLOSE THE PRINTER COVER AND HIT THE ENTER KEY",REPLY
. 
. 
         INCLUDE  FORMSCTL
. 
PROCEED  TRAPCLR   IO
         MOVE      "0"  TO TOTPCS
         TRAP      NOFILE IF IO
         OPEN      INPUT,NAME
. 
         TRAPCLR   IO
         TRAP      NOPARTS IF IO
         OPEN      PARTFL,PARTNAME
. 
         TRAPCLR   IO
         TRAP      NOFILE IF IO
         OPEN      DETFILE,DETAILS
.
         TRAPCLR   IO
         TRAP      NOVEND IF IO
         CALL      OPENCUST
.
         MOVE      " " TO REPLY
..       READ      INPUT,REPLY;REPLY;
         GOTO      SETTITL
NOFILE   BEEP
         DISPLAY   *P01:12,*EL,"PURCHASE DISK NOT MOUNTED - ":
                               "JOB ABORTING",*W
         GOTO      CHAINOUT
. 
NOPARTS  BEEP
         DISPLAY   *ES,*P01:12,"INVENTORY DISK NOT MOUNTED - ":
                               "JOB ABORTING",*W
         GOTO      CHAINOUT
NOVEND   BEEP
         DISPLAY   *P01:12,*EL,"ACCOUNTS DISK NOT MOUNTED - ":
                               "JOB ABORTING",*W
         GOTO      CHAINOUT
. 
MOVLIB   MOVE      "LIBERTY FASTENERS INC.  " TO  COMPVAR
         RETURN
. 
MOVREP   MOVE      "N C L   S T U D S   INC." TO  COMPVAR
         RETURN
. 
SETTITL  TRAPCLR      IO
         TRAP      RDERROR  IF  IO
*............................................................
. READ A RECORD FROM THE FILE JUST PROC'D
. AT START: READ RECORD FROM EACH FILE
.
READ     READKS    INPUT;INVKEY,INVTYPE,INVCOMP,INVSTAT,INVCUST,INVDATE:
                         INVTOTL,INVORDNO,MOREORDER,INVSHIP,INVBLNO,INVFOB:
                         FRGTRATE,INVWGHT,INVDTPAY,INVCHECK:
                         IAMTRCVD,IDOLSLFT,INVMESG
*............................................................
. TEST FOR END OF FILE
. IF END OF FILE: TURN ON LR AND L1-L9
.
         GOTO      SELMATCH IF NOT OVER
         CALL      SETLR
         GOTO      TOTCALC
*............................................................
. TURN ON LEVEL-INDICATOR SWITCHES
.
SETLR    MOVE      "1" TO LR
         RETURN
*............................................................
. SEE IF MATCHING FIELDS SPECIFIED
. IF SO: SELECT RECORD WITH HIGH PRIORITY
.
SELMATCH GOTO      RIDON  (NOP)
*............................................................
. TURN ON RECORD-IDENTIFYING INDICATOR
.
RIDON    MOVE      "1" TO RID01
. 
. CHECK THE COMPANY CODE FOR MATCH TO TERMINAL INPUT
         MATCH     PRTCOMP TO INVCOMP
         GOTO      READ IF NOT EQUAL
. 
. BYPASS A ZERO DOLLAR INVOICE 
. 
         COMPARE  "0.00"  TO  INVTOTL
         GOTO      READ  IF  EQUAL
. 
. 
. BOBS SPECIAL BYPASS
. 
         COMPARE "9"  TO  SECURITY
         GOTO   TESTFC  IF  EQUAL
         MATCH     "O" TO INVSTAT
         GOTO      READ IF NOT EQUAL
*............................................................
. SEE IF FIRST CYCLE
. IF SO: BYPASS TOTAL CALCS / OUPTUT
.
TESTFC   BRANCH    SW1P OF TESTLR
+............................................................
. TOTAL CALCULATIONS
.
TOTCALC  TRAPCLR   PARITY  (NOP)
TOTCLX   TRAPCLR   PARITY  (NOP)
         CALL      TOTOUT
*............................................................
. SEE IF LR INDICATOR IS ON
. IF SO: END JOB
.
TESTLR   BRANCH    LR OF EOJ
*............................................................
. SEE IF OVERFLOW IS ON
. IF SO: PERFORM OVERFLOW OUTPUT
.
TESTOF   GOTO      MOVEDATA  (NOP)
*............................................................
. MOVE DATA FROM INPUT AREA TO FIELDS
.
MOVEDATA PI        1 (NOP)
         MOVE      INVCUST  TO  CUSTKEY
TRAPS    TRAPCLR   IO
         CALL      GETCUST
         CMATCH    "M"  TO  IOSW
         GOTO      PNOVEND  IF  EQUAL
. 
.  PRINT THE HEADER NOW THAT YOU HAVE THE CUSTOMER DATA
. 
         MOVE      CUSTZIP  TO  ZIPX
         REPLACE   " 0"     IN  ZIPX        (ZERO FILL)
         MOVE      "COLLECT"  TO  FOBCOD
         CMATCH    "P"   TO   INVFOB
         GOTO       TPS1 IF NOT EQUAL
         MOVE      "PREPAID"  TO  FOBCOD
TPS1     TRAPCLR   PARITY  (NOP)
         GOTO      CALLHDR
PNOVEND  MOVE      "*ACCOUNT NOT ON FILE*" TO CUSTNAME
*............................................................
. CLEAR OUT ACCUMULATORS (DETAIL TIME)
.
CALLHDR  TRAPCLR   IO
         MOVE      INVDATE TO DATE8
         MOVE      DATE8  TO MM
         RESET     DATE8  TO 3
         MOVE      DATE8  TO DD
         RESET     DATE8  TO 5
         MOVE      DATE8  TO YY
         RESET     DATE8
         CALL      HEADER
*............................................................
. SEE IF MATCHING RECORD (SET MR)
.
SEEMR    MOVE      "1" TO SWMR
*............................................................
.
. NOW READKS THE DETAIL FILE TO LIST THE DETAILS
. 
DETOUT   RESET     INVKEY
         MOVE      INVKEY  TO  POKEY
         RESET     POKEY TO 5
         APPEND    "00" TO POKEY
         RESET     POKEY
...      DISPLAY   *P60:23,POKEY
         READ      DETFILE,POKEY;INVDNUMB,INVDLINE    POSITION FILE AT FIRST RE
...      DISPLAY   *P70:23,INVDNUMB,INVDLINE
         TRAPCLR   IO
DETREAD  READKS    DETFILE;INVDNUMB,INVDLINE,INVDSTAT,INVDPT3,INVDPT4:
                           INVDKEGS,INVDKPCS,PCSORD,INVDPRC:
                           LINECOST,PASSCOMP,KGSAVAIL,FABQTY:
                           BARFEET,BARCOST,STUDQTY,STUDCOST:
                           NUTQTY,NUTCOST,FABFLAG
         GOTO      ENDPO IF OVER
         CMATCH    "D" TO INVDSTAT          IS IT A DELETED/COMPLETED LINE
         GOTO      DETREAD IF EQUAL
         MATCH     INVDNUMB  TO  INVKEY
         GOTO      ENDPO  IF NOT  EQUAL
PROCESS  TRAPCLR   PARITY
. 
         MOVE      PCSORD  TO  TSTKEGS
         COMPARE   "0"       TO TSTKEGS
         GOTO      DETREAD   IF   EQUAL      BYPASS PRINT OF 0 KEG LINES
         MOVE      INVDPRC   TO  LINEPRC
         MOVE      INVDKEGS  TO  KEGSORD
         MOVE      INVDPT3 TO PARTNO
         RESET     PARTNO TO 3
         APPEND    INVDPT4 TO PARTNO
         RESET     PARTNO
. 
         CALL      GETPART
. 
         MATCH     "H" TO IOSW
         GOTO      DETREAD IF NOT EQUAL
         MOVE      INVDPT3 TO PN3
. 
. 3/19/83 MODIFICATIONS DUE TO CARRYING OF COST IN DETAIL RECORD
. 
. NOW CALCULATE THE EXTENSIONS FOR SELLING PRICE AND INVENTORY COST
. 
         CMATCH    "F" TO FABFLAG        (DID WE FABRICATE ANYTHING?)
         GOTO      FABRICST IF EQUAL     (YES - USE A DIFFERENT ROUTINE)
. 
. NO! FALLTHRU AND USE THE USUAL ROUTINE
. 
. 
         MOVE      PNYCOST  TO  LINEPRC
         CMATCH    "L"   TO  INVCOMP
         GOTO      PSS1  IF  EQUAL
         MOVE      PTXCOST  TO  LINEPRC
PSS1     CALL      EXTEND
         MOVE      LINECOST TO  INVYCOST
         CALL      EXTEND                 (THIS TIME FOR INVENTORY COST)
. 
. 
.    NOW RESET THE FIELDS TO EXTEND THE SELLING PRICE
. 
SELNGPRC MOVE      INVDPRC  TO  LINEPRC
         CALL      EXTEND
         GOTO      PROFITA
. 
. END OF ORIGINAL COSTING ROUTINE !
. ...................................................
. 
. ..............................................
. NEW COSTING ROUTINE FOR THE FABRICATION SYSTEM
. ..............................................
FABRICST MOVE      PTXCOST  TO  CALCFLD
         MULTIPLY  KGSAVAIL BY  CALCFLD    (GET INVY COST OF AVAIL. STOCK ITEM)
         MOVE      CALCFLD  TO  INVYCOST
. 
         MOVE      BARCOST  TO  CALCFLD
         MULTIPLY  BARFEET  BY  CALCFLD    (GET INVY COST OF BAR USED - IF ANY)
         ADD       CALCFLD  TO  INVYCOST
. 
         MOVE      STUDCOST TO  CALCFLD    (COST PER HUNDRED OF STUDS)
         MULTIPLY  STUDQTY  BY  CALCFLD    (THIS IS INFLATED COST)
         DIVIDE    "100"  INTO  CALCFLD    (THIS IS CORRECT COST OF STUDS USED)
         ADD       CALCFLD  TO  INVYCOST
. 
         MOVE      NUTCOST  TO  CALCFLD    (COST PER HUNDRED OF NUTS)
         MULTIPLY  NUTQTY   BY  CALCFLD
         DIVIDE    "100"  INTO  CALCFLD    (THIS IS CORRECT COST OF NUTS USED)
         ADD       CALCFLD  TO  INVYCOST   (TOTAL COST RESIDES HERE NOW)
. 
. INVYCOST NOW HAS THE SUM OF COSTS AS FOLLOWS*
. 
.  - COST OF ANY STOCK MATERIAL USED
.  - COST OF ANY STUDS USED FOR FABRICATION
.  - COST OF ANY BAR STOCK USED FOR FABRICATION
.  - COST OF ANY NUTS USED FOR FABRICATION
. 
. NOW CALCULATE THE EXTENDED SELLING PRICE
. 
         GOTO       SELNGPRC
...............................................................
. 
PROFITA  MOVE      INVYCOST TO  DIVISOR      (START CALCULATED PROFIT/PCTG)
         DIVIDE    LINECOST INTO  DIVISOR
         MOVE      "001.000000"   TO  ONEPT6
         SUBTRACT  DIVISOR  FROM  ONEPT6
         MULT      "100"    BY    ONEPT6
         MOVE      ONEPT6   TO    PCTG
. 
         ADD       INVYCOST TO  TOTCOST
         MOVE      LINECOST TO  PROFIT
         SUBTRACT  INVYCOST FROM  PROFIT      
         ADD       PROFIT   TO  TOTPROF
         ADD       "1"      TO  DETAILZ
         COMPARE   "43" TO LINECT
         CALL      OVERFLOW IF EQUAL
         ADD       "1"  TO LINECT
. 
         MOVE      PUOM  TO  PRTUOM
. 
         MOVE      PCSORD  TO  DIM7
         CMATCH    "D",FABFLAG
         GOTO      PRFA1 IF NOT EQUAL
         MOVE      PCSORD  TO  FORM3PT3
         ADD       BARFEET TO  FORM3PT3
         MOVE      FORM3PT3 TO DIM7
. 
PRFA1    CMATCH    "P"   TO  PRTUOM
         GOTO      PRFNXT  IF  NOT  EQUAL
         MOVE      "C"   TO  PRTUOM
. 
PRFNXT   PRINT     *1," ",*ZF,PN3,"-",INVDPT4," ",INVDKEGS," ",INVDKPCS," ":
                   " ",DIM7,"  ",PSIZE," ",PDESC,INVDPRC," ",PRTUOM:
                   " ",LINECOST,"  ",INVYCOST,PROFIT," ",PCTG
. 
NXTDTL   TRAPCLR   PARITY     (NOP - BRANCH ADDRESS)
         ADD       KEGSORD TO POKGSORD
         ADD       LINECOST TO TOTDOLS
         ADD       PCSORD TO TOTPCS
*............................................................
. TURN OFF R.I.D. & ALL L-INDICATORS
.
TURNOFF  MOVE      "0" TO SW1P
         MOVE      "0" TO RID01
         GOTO      DETREAD
*............................................................
OVERFLOW CALL      TRAILER
         CALL      HEADER
         RETURN
. 
         INCLUDE   NCLPTIO
         INCLUDE   NCLEXTND
         RETURN
. 
. 
ENDPO    COMPARE   "39" TO LINECT
         CALL      OVERFLOW IF NOT LESS
         MOVE      FRGTRATE  TO  CALCFLD
         MULT      INVWGHT   BY  CALCFLD
         DIVIDE    "100"     INTO  CALCFLD
         MOVE      CALCFLD   TO  FRTALLOW
. 
. ALLOW FOR SPECIALS WITH NO DETAILS HERE
. 
         CMATCH    "S"       TO  INVTYPE
         GOTO      SBYPASS   IF  NOT  EQUAL
. 
.  FALLTHRU IS A SPECIAL SO MOVE INVTOTL TO TOTDOLS
. 
         MOVE      INVTOTL   TO  TOTDOLS
SBYPASS  TRAPCLR   PARITY        (NOP)
         COMPARE   "0"       TO  TOTDOLS
         GOTO      BYP00     IF  NOT  EQUAL
.  
.  GOT AN OLD ONE HERE...WITH NO DETAILS......
.   SO SAVE THE DOLLARS PLEASE!
. 
         MOVE      INVTOTL  TO  TOTDOLS
BYP00    MOVE      TOTDOLS   TO  NETINVC
         MOVE      "001.000000"  TO  ONEPT6
         SUBTRACT  FRTALLOW  FROM  NETINVC
         MOVE      TOTCOST   TO  DIVISOR
         DIVIDE    TOTDOLS   INTO  DIVISOR
         SUBTRACT  DIVISOR   FROM  ONEPT6
         MULT      "100"     BY    ONEPT6
         MOVE      ONEPT6    TO    PCTG
         PRINT     *C:
                   "--------------------------------------------------":
                   "--------------------":
                   "------------":
                   "    -----------------------"
. 
. DIFFERENT PRINT LINE FOR SPECIALS HERE
. 
         CMATCH   "S"  TO  INVTYPE
         GOTO     PRTPCS   IF  NOT  EQUAL
         PRINT    *C,INVMESG,*74,INVTOTL
         GOTO     COMPFRT
PRTPCS   PRINT    *C:
                   *10,POKGSORD,*21,TOTPCS,*32,"SUBTOTAL":
                   *73,TOTDOLS,*85,TOTCOST,*95,TOTPROF," ",PCTG
COMPFRT  COMPARE   "0"    TO  FRTALLOW
         GOTO      LINE2  IF  EQUAL
         PRINT     *32,"LESS FREIGHT ALLOWANCE",*76,FRTALLOW
LINE2    PRINT     *C:
                   "--------------------------------------------------":
                   "--------------------":
                   "------------":
                   "    -----------------------"
. 
.  ALLOW DIFFERENT MESSAGE IF ITS A CREDIT
. 
         CMATCH    "C"  TO  INVTYPE
         GOTO      DEBPRT   IF  NOT  EQUAL
         PRINT     *32,"CREDITED TO YOUR ACCOUNT",*73,NETINVC
         GOTO      BMPTOT
. 
DEBPRT   PRINT     *32,"PLEASE PAY THIS AMOUNT",*73,NETINVC
.        CMATCH    "N" TO TESTTWO
.        GOTO      EOJ IF EQUAL
BMPTOT   ADD       "1" TO LRTOT
         MOVE      "0"  TO  TOTPCS
. 
. NOW DETERMINE IF CREDIT OR INVOICE TO PROPERLY INCREMENT ACCUMULATORS
.       3/13/82
. 
         CMATCH    "C"  TO  INVTYPE
         GOTO      ADDRUN   IF  NOT  EQUAL
         MULTIPLY  "-1" BY  NETINVC
         MULTIPLY  "-1" BY  POKGSORD
         MULTIPLY  "-1" BY  TOTCOST
. 
. 
ADDRUN   ADD       NETINVC TO RUNDOLS
. 
.  ONLY UPDATE THE INVSTAT FIELD WITH "P"  FOR PRINTED
.  DO NOT CHANGE ANY DOLLAR FIELDS ON THE RECORDS PLEASE
. 
         MOVE      "P"     TO INVSTAT
. 
         TRAPCLR   IO
         TRAP      BADIPTUD IF IO
         UPDATE    INPUT;INVKEY,INVTYPE,INVCOMP,INVSTAT,INVCUST,INVDATE:
                         INVTOTL,INVORDNO,MOREORDR,INVSHIP,INVBLNO,INVFOB:
                         FRGTRATE,INVWGHT,INVDTPAY,INVCHECK:
                         IAMTRCVD,IDOLSLFT,INVMESG
         MOVE      "0"     TO TOTDOLS
. 
. MODIFIED  3/9/82 TO KEEP A RUNNING TOTAL OF THE COST FACTOR 
.           OF ALL INVOICES
. 
         ADD       TOTCOST  TO  COSTTOTL
         ADD       POKGSORD TO  TOTALKEG
. 
. ...................................................................
         MOVE      "0"     TO TOTCOST
         MOVE      "0"     TO POKGSORD
. ...................................................................
         MOVE      "0"     TO TOTPROF
         ADD       "6"     TO LINECT
         COMPARE   "0"     TO FRTALLOW
         GOTO       BB1    IF  NOT  EQUAL
         SUBTRACT  "1"     FROM  LINECT
BB1      TRAPCLR    PARITY                (NOP)
         CALL      TRAILER
         MOVE      "0"  TO PAGE
         GOTO      READ
BADIPTUD BEEP
RDERROR  BEEP
         DISPLAY   *ES,*P01:12,"UNABLE TO READ/UPDATE INV HDR RECORD ",INVKEY:
                       *P01:14," JOB  A B O R T I N G!",*W,*W,*W
         BEEP
         CHAIN     "INVCMNU1"
. 
*............................................................
. PAGE HEADING ROUTINE
.
HEADER   ADD       "1" TO PAGE
HD2      TRAPCLR   PARITY      (NOP)
. 
. DIFFERENTIATE BETWEEN INVOICES AND CREDITS
. 
         CMATCH    "C" TO INVTYPE
         GOTO      DEBHD  IF  NOT  EQUAL
         PRINT     *F,*C,*L:
                   *63,"CREDIT NO.",*75,INVKEY
         GOTO      HDCNT
. 
DEBHD    PRINT     *F,*C,*L:
                   *63,"INVOICE NO.",*75,INVKEY
HDCNT    PRINT      *63,"DATE      ",*72,MM,"/",DD,"/",YY
         PRINT      *88,"DO NOT MAIL THIS SIDE"
         PRINT      *88,"TO YOUR CUSTOMER"
         PRINT      " "
         PRINT     *C,*L,*3,"SOLD TO:   ",*15,CUSTNAME,*50,"SHIP TO:      SAME"
         PRINT      *15,CUSTADDR
         PRINT      *15,CUSTCITY,*36,CUSTSTAT,*40,ZIPX
         PRINT      " "
         CMATCH     "R"   TO   INVCOMP
         GOTO       REPHDR1    IF  EQUAL
         PRINT     *C,*L,*L,*L,*1,INVORDNO,*13,INVSHIP,*26,INVBLNO,*38,FOBCOD:
                   *47,INVWGHT,*54,FRGTRATE,*60," 30 DAYS AFTER INV DATE"
         GOTO      RESETMOR
REPHDR1  PRINT     *C:
                   *1,"** REMIT TO NCL STUDS INC., P.O. BOX 6887, ":
                      "HOUSTON, TX. 77265 **"
         PRINT     " "
         PRINT     *C,*L,*1,INVORDNO,*13,INVSHIP,*26,INVBLNO,*38,FOBCOD:
                   *47,INVWGHT,*54,FRGTRATE,*60," 30 DAYS AFTER INV DATE"
RESETMOR RESET     MOREORDR
         GOTO      SPACEDN  IF  EOS
         CMATCH    " "      TO  MOREORDR
         GOTO      SPACEDN  IF  EQUAL
         PRINT     *C,*L,*L,"ADDITIONAL PURCHASE ORDER NUMBERS: ",MOREORDR
         GOTO      SETCT
SPACEDN  PRINT     *C,*L
         MOVE      "18"  TO  LINECT
         GOTO      INVMSGS
 
SETCT    MOVE      "19" TO LINECT
. 
INVMSGS  CMATCH    "S"  TO  INVTYPE
         GOTO      STCTRTRN  IF  EQUAL     (THAT IS BYPASS THE PRINT
.                                            AS YOU WILL PRINT ON NEXT LINE!)
         CMATCH    " "  TO  INVMESG
         GOTO      STCTRTRN  IF  EQUAL
         PRINT     *1,INVMESG
         ADD       "1" TO LINECT
. 
STCTRTRN RETURN
*............................................................
. PAGE TRAILER ROUTINE
TRAILER  COMPARE   "44"  TO LINECT
         GOTO      TRLR IF NOT LESS
         PRINT     " "
         ADD       "1" TO LINECT
         GOTO      TRAILER
TRLR     PRINT     *C,*L,*1,"NO RETURNS FOR CREDIT WITHOUT OUR PERMISSION - ":
                    "ABOVE MATERIAL FOR RESALE ONLY"
         PRINT     "CLAIMS FOR LOSS OR SHORTAGE MUST BE FILED WITHIN TEN ":
                   "DAYS FROM DATE OF SHIPMENT"
         PRINT      *C,*L,*37,"PAGE ",PAGE
         RETURN
. TOTAL OUTPUT
.
TOTOUT   TRAPCLR   PARITY  (NOP)
         COMPARE   "1" TO LR
         RETURN    IF NOT EQUAL
         MOVE      "** FINAL TOTALS **" TO CUSTNAME
         CLEAR     CUSTADDR
         CLEAR     CUSTCITY
         CLEAR     CUSTSTAT
         MOVE      "0"  TO  CUSTZIP
         CLEAR     INVBLNO
         CLEAR     INVSHIP
         CLEAR     INVORDNO
         CLEAR     FOBCOD
         MOVE      "0"  TO  INVWGHT
         MOVE      "0"  TO  FRGTRATE
         MOVE      " "  TO  ZIPX
         MOVE      "0"  TO  INVORDNO
. 
         PRINT     *F,*63,"DATE PRINTED ",TODAY
         PRINT     *C,*L,*L,*L,*L,*L,*L,*L,*L,*L,*L
         PRINT     *L,*L,*L,*L,*L,*L,*L,*L,*L,*L,*L
         PRINT     *1,"TOTAL KEGS SHIPPED ",TOTALKEG
. 
         PRINT     *5,LRTOT," INVOICES/CREDITS PRINTED FOR FOR ",COMPVAR:
                   *66,RUNDOLS,"***",*85,COSTTOTL,*C,*L
         ADD       "2" TO LINECT
         RETURN
. 
         INCLUDE   CUSTIO
. 
*............................................................
. END OF JOB
.
EOJ      PRINT     *F
. 
CHAINOUT CMATCH    "F"  TO  FORMRESP
         GOTO      CHNOUT  IF  NOT  EQUAL
         PRINT     023     (RESET THE FORMS LENGTH)
CHNOUT   RELEASE
         CHAIN     "NCLINVC1"
. 

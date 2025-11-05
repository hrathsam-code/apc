. 
. WRITTEN BY R BACHARACH,  MICRO SYSTEMS CONSULTANTS
.			   41 TEELE DRIVE
.			   CORAM, NEW YORK 11727
.			   (516) 698-5577
	 INCLUDE   COMMON
. 
NAME	 INIT	   "NCLINVHD/ISI:NCLPURCH" (FILE NAME)
INPUT	 IFILE	   (ISAM INPUT )
. 
. 
REPLY	 DIM	   1
SWMR	 FORM	   "0"	       '1'=MATCHING RECORD
SW1P	 FORM	   "1"	       '1'=FIRST CYCLE
LINECT	 FORM	   3	       LINE COUNTER
PAGE	 FORM	   3	       PAGE NUMBER
RID01	 FORM	   "0"	       RECORD TYPE 01
LR	 FORM	   "0"	       '1'=LAST	RECORD PENDING
LRTOT	 FORM	   5		GRAND TOTAL
VOIDS	 FORM	   5
PAIDS	 FORM	   5
CRDTS	 FORM	   5
ORDRTOTS FORM	   7.2
. 
IOSW	 DIM	   1
. 
. 
	 INCLUDE   NCLCUST
. 
CUSTFILE IFILE
CSTNAME	 INIT	   "NCLACCTS/ISI"
. 
. 
. 
COMPVAR	 DIM	   24
. 
MM	 DIM	   2
DD	 DIM	   2
YY	 DIM	   2
DATE8	 DIM	   8
. 
STATUS	 DIM	   4
*............................................................
. 
	 INCLUDE   INVOICES
. 
+............................................................
. MAINLINE FOLLOWS
.
. FILE OPENING SEQUENCE
	 DISPLAY   *ES,*HON, *P01:12,"PRINT NCL	STUDS INVOICE MASTER LIST":
		   *P01:14,"NOTE..THIS REPORT MAY BE PRINTED ON	NARROW PAPER"
	 TRAPCLR   IO
	 TRAP	   NOFILE IF IO
	 OPEN	   INPUT,NAME
.
	 TRAPCLR   IO
	 CALL	   OPENCUST
	 CMATCH	   "H"	TO  IOSW
	 GOTO	   NOVEND   IF NOT EQUAL
	 GOTO	   GETCOMP
. 
NOFILE	 BEEP
	 DISPLAY   *P01:12,*EL,"PURCHASE DISK NOT MOUNTED - ":
			       "JOB ABORTING",*W
	 GOTO	   CHAINOUT
NOVEND	 BEEP
	 DISPLAY   *P01:12,*EL,"INVENTORY DISK NOT MOUNTED - ":
			       "JOB ABORTING",*W
	 GOTO	   CHAINOUT
GETCOMP	 TRAPCLR   PARITY    (NOP)
. 
MOVREP	 MOVE	   "N C	L   S T	U D S	INC." TO  COMPVAR
SETTITL	 CALL	   HEADER
*............................................................
. READ A RECORD	FROM THE FILE JUST PROC'D
. AT START: READ RECORD	FROM EACH FILE
.
READ	 READKS	   INPUT;INVKEY,INVTYPE,INVCOMP,INVSTAT,INVCUST,INVDATE:
			 INVTOTL,INVORDNO,MOREORDR,INVSHIP,INVBLNO,INVFOB:
			 FRGTRATE,INVWGHT,INVDTPAY,INVCHECK:
			 IAMTRCVD,IDOLSLFT,INVMESG
*............................................................
. TEST FOR END OF FILE
. IF END OF FILE: TURN ON LR AND L1-L9
.
	 GOTO	   SELMATCH IF NOT OVER
	 CALL	   SETLR
	 GOTO	   TOTCALC
*............................................................
. TURN ON LEVEL-INDICATOR SWITCHES
.
SETLR	 MOVE	   "1" TO LR
	 RETURN
*............................................................
. SEE IF MATCHING FIELDS SPECIFIED
. IF SO: SELECT	RECORD WITH HIGH PRIORITY
.
SELMATCH GOTO	   RIDON  (NOP)
*............................................................
. TURN ON RECORD-IDENTIFYING INDICATOR
.
RIDON	 MOVE	   "1" TO RID01
. 
*............................................................
. SEE IF FIRST CYCLE
. IF SO: BYPASS	TOTAL CALCS / OUPTUT
.
TESTFC	 BRANCH	   SW1P	OF TESTLR
+............................................................
. TOTAL	CALCULATIONS
.
TOTCALC	 TRAPCLR   PARITY  (NOP)
TOTCLX	 TRAPCLR   PARITY  (NOP)
	 CALL	   TOTOUT
*............................................................
. SEE IF LR INDICATOR IS ON
. IF SO: END JOB
.
TESTLR	 BRANCH	   LR OF EOJ
*............................................................
. SEE IF OVERFLOW IS ON
. IF SO: PERFORM OVERFLOW OUTPUT
.
TESTOF	 GOTO	   MOVEDATA  (NOP)
*............................................................
. MOVE DATA FROM INPUT AREA TO FIELDS
.
MOVEDATA PI	   1 (NOP)
	 MOVE	   INVCUST TO CUSTKEY
	 CMATCH	   "O" TO INVSTAT
	 GOTO	   CHKCLS IF NOT EQUAL
	 MOVE	   "NEW	" TO STATUS
	 GOTO	   TRAPS
CHKCLS	 CMATCH	   "P" TO INVSTAT
	 GOTO	   MAKCANC IF NOT EQUAL
	 MOVE	   "SENT" TO STATUS
	 GOTO	   TRAPS
MAKCANC	 CMATCH	   "V"	  TO  INVSTAT
	 GOTO	   MKC1	  IF  NOT   EQUAL
	 MOVE	   "VOID"     TO    STATUS
	 GOTO	   TRAPS
MKC1	 CMATCH	   "X"	  TO  INVSTAT
	 GOTO	   MKC2	  IF  NOT   EQUAL
	 MOVE	   "PAID"     TO    STATUS
	 GOTO	   TRAPS
MKC2	 CMATCH	   "C"	  TO  INVSTAT
	 GOTO	   MKC3	  IF  NOT  EQUAL
	 MOVE	   "CRDT"     TO   STATUS
	 GOTO	   TRAPS
MKC3	 MOVE	   "DEL."     TO   STATUS
TRAPS	 TRAPCLR   IO
	 CALL	   GETCUST
	 CMATCH	   "H"	  TO IOSW
	 GOTO	   SETDATE   IF	 EQUAL
PNOVEND	 MOVE	   "*ACCOUNT NOT ON FILE*" TO CUSTNAME
*............................................................
. CLEAR	OUT ACCUMULATORS (DETAIL TIME)
.
SETDATE	 TRAPCLR   IO
	 MOVE	   INVDATE TO DATE8
	 MOVE	   DATE8  TO MM
	 RESET	   DATE8  TO 3
	 MOVE	   DATE8  TO DD
	 RESET	   DATE8  TO 5
	 MOVE	   DATE8  TO YY
	 RESET	   DATE8
	 CMATCH	   "C"	  TO INVTYPE
	 GOTO	   SEEMR IF NOT	EQUAL
	 MULT	   "-1"	  BY INVTOTL
	 MULT	   "-1"	  BY IDOLSLFT
*............................................................
. SEE IF MATCHING RECORD (SET MR)
.
SEEMR	 MOVE	   "1" TO SWMR
*............................................................
. DETAIL CALCULATIONS
.
DETCALC	 CMATCH	   "D" TO INVSTAT
	 GOTO	   DETOUT IF  EQUAL
	 CMATCH	   "V" TO INVSTAT
	 GOTO	   DETOUT IF  EQUAL
	 CMATCH	   "X" TO INVSTAT	 (BYPASS THE ADD IF PAID)
	 GOTO	   DETOUT IF  EQUAL
	 ADD	   "1" TO LRTOT
	 ADD	   IDOLSLFT TO ORDRTOTS
*............................................................
. HEADING AND DETAIL OUTPUT
.
DETOUT	 COMPARE   "50"	TO LINECT
	 CALL	   HEADER IF NOT LESS
*............................................................
	 PRINT	   *3,INVKEY:
		   *9,MM,"/",DD,"/",YY:
		   *19,CUSTNAME:
		   *50,STATUS:
		   *57,INVTOTL:
		   *67,IDOLSLFT
. 
	 ADD	   "1" TO LINECT
*............................................................
. TURN OFF R.I.D. & ALL	L-INDICATORS
.
TURNOFF	 MOVE	   "0" TO SW1P
	 MOVE	   "0" TO RID01
*............................................................
. GO READ ANOTHER RECORD
.
	 GOTO	   READ
*............................................................
. 
	 INCLUDE   CUSTIO
. PAGE HEADING ROUTINE
.
HEADER	 ADD	   "1" TO PAGE
	 PRINT	   *F,*C,*L,*L:
		   *21,"INVOICE	MASTER LISTING":
		   *56,"A/O ",TODAY:
		   *70,"PG ",PAGE
	 PRINT	   *21,COMPVAR,*C,*L
	 MOVE	   "0" TO LINECT
	 PRINT	   *3,"INV.":
		   *11,"INV.":
		   *19,"ACCOUNT	NAME":
		   *49,"STATUS":
		   *59,"INVOICE":
		   *71,"OPEN"
	 PRINT	   *2,"NUMBER":
		   *11,"DATE":
		   *60,"TOTAL":
		   *71,"TOTAL":
		   *C,*L
	 RETURN
*............................................................
. TOTAL	OUTPUT
.
TOTOUT	 TRAPCLR   PARITY  (NOP)
	 COMPARE   "1" TO LR
	 RETURN	   IF NOT EQUAL
	 PRINT	   *C,*L,*L
	 PRINT	   *5,LRTOT," OPEN INVOICES FOR	",COMPVAR:
		   *66,ORDRTOTS,"***",*C,*L
	 PRINT	   *C,*L,"NOTE:	THE TOTALS REFLECT OPEN	INVOICE/CREDIT ":
			 "AMOUNTS"
	 PRINT	   *7,"WHICH HAVE NOT YET BEEN ADDED TO	THE ACCOUNTS ":
		      "RECEIVABLE FILE"
	 RETURN
*............................................................
. END OF JOB
.
EOJ	 PRINT	   *F
	 RELEASE
CHAINOUT CHAIN	   "NCLINVC1"

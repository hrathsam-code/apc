. ARMENU1 - ACCOUNTS RECEIVABLE	PROCESSING FUNCTIONS
.
.  WRITTEN BY R. BACHARACH, MICRO SYSTEMS CONSULTANTS
.			    41 TEELE DRIVE
.			    CORAM, NEW YORK 11727
.			    (516) 698-9648
.
. COMPILING THIS PROGRAM REQUIRES THAT THE FILES:  "COMMON/TXT",
. "LOGDATA/TXT"	AND "LOGIO/TXT"	EXIST ON ANY DRIVE WHICH IS ON-
. LINE.	 THESE INCLUSION FILES CONTAIN THE INFORMATION COMMON TO
. ALL OF THE SYSTEM PROGRAMS.
.
	 INCLUDE   COMMON.TXT
.
INDEX	 FORM	   2		       USER SELECTION VARIABLE
TIME	 INIT	   "hh:mm:ss"	       hours:minutes:seconds
ROLLNAME INIT	   "ROLLFILE.TXT"
DPORT	 DIM	   8
PORTX	 DIM	   8
+................................................................
. MAINLINE
.
*................................................................
.
*................................................................
. DISPLAY THE MENU
.
CLOCK	 CLOCK	   TIME	TO TIME

         MOVE      "ARMENU1"  TO  FROMPGM

	 DISPLAY   *ES:
		   *HON:
		   *P1:1,"V.2004 ":
		   "ACCOUNTS RECEIVABLE	PROCESSING FUNCTIONS":
		   *P51:1,"Today is ",TODAY:
			  " Time ",TIME:
		   *HOFF:
		   *P01:03,"( 1) ":
		   "ENTER  C A S H   REMITTANCES":
		   *P01:04,"( 2) ":
		   "CASH LEDGER	PROCESSING MENU":
		   *P01:05,"( 3) ":
		   "PRINT AGED RECEIVABLE DETAILS BY ACCOUNT":
		   *P01:06,"( 4) ":
		   "PRINT AGED RECEIVABLE SUMMARY REPORT":
		   *P01:07,"( 5) ":
		   "PRINT MONTH-END STATEMENTS FOR ALL ACCOUNTS":
		   *P01:08,"( 6) ":
		   "DISPLAY AGED ACCOUNTS RECEIVABLE INQUIRY":
		   *P01:09,"( 7) ":
		   "ENTER  I N V O I C E S / C R E D I T S":
		   *P01:10,"( 8) ":
		   "PRINT OPEN RECEIVABLES LISTING - BY	INVOICE	NUMBER":
		   *P01:11,"( 9) ":
		   "DISPLAY  **	OPEN ITEMS BY ACCOUNT ** ":
		   *P01:12,"(10) ":
		   "ADJUST A/R BALANCE FORWARD ":
		   *P01:13,"(11) ":
		   "ADJUST A/R FILE DETAIL DATA	":
		   *P01:14,"(12) ":
		   "IDENTIFY UNKNOWN ACCOUNT VIA INVOICE NUMBER":
		   *P01:15,"(13) ":
		   "INDEX ALL ACCOUNTS RECEIVABLES FILES":
		   *P01:16,"(14) ":
		   "DISPLAY  **	PAID ITEMS BY ACCOUNT ** ":
		   *P01:17,"(15) ":
		   "PRINT  S P E C I A L   AGEING SUMMARY ":
		   *P01:18,"(16) ":
		   "AGE	CUSTOMER FILE WITH INVOICES (NO	PRINT)":
		   *P01:19,"(17) ":
		   "PRINT COMMISSIONS REPORT FOR  P A I	D  INVOICES":
		   *P01:20,"(18) ":
		   "PRINT MAILER STATEMENTS":
		   *P01:21,"(19) ":
		   "SELECT NEW PROCESSING SYSTEM":
		   *EL
*................................................................
. GET THE PROGRAM'S INDEX
.
GETINDEX KEYIN	   *P1:23,*EL,"Selection by number":
		   *P25:23,"__",*P25:23,INDEX
	 COMPARE   "1" TO INDEX
	 GOTO	   GETINDEX IF LESS
	 COMPARE   "20"	TO INDEX
	 GOTO	   GETINDEX IF NOT LESS
*................................................................
. BRANCH TO THE	ROUTINE	INDICATED BY THE INDEX
.
	 TRAP	   BADCHAIN IF CFAIL
	 CLOCK	   TIME	TO TIME
	 BRANCH	   INDEX OF CASHNTRY:  ENTER CASH REMITTANCES
			    CASHLDGR:  CASH LEDGER MENU
			    AGEDTLS:   LIST AGED DETAILS BY ACCOUNT
			    AGELIST:   LIST AGED SUMMARY FOR ALL ACCTS
			    STATEMNT:  LIST MONTH-END STATEMENTS ALL ACCTS
			    ARINQ:     DISPLAY AGED INQUIRY BY ACCT
			    CREDITS:   ENTER CREDITS
			    ARLIST:    LIST OPEN RECEIVABLES BY	INVOICE	NUMBER
			    OPENITEM:  DISPLAY	OPEN ITEMS BY ACCOUNT
			    BALFUPDT:  MODIFY A/R BALANCES BY COMPANY
			    ARFLUPDT:  MODIFY A/R DETAIL ITEMS
			    ARQUERY:   IDENTIFY	UNKNOWN	ACCT VIA INVCNO
			    ARINDEX:   INDEX THE A/R FILES
			    ARCLOSD:   DISPLAY CLOSED ITEMS
			    AGESPCL:	SPECIAL	AGEING SUMMARY
			    AGEING:    AGE CUSTOMERS WITH NO PRINT
			    COMMAR80:  PRINT COMMISS RPRT FOR PAID INVOICES
			    MLRSTATE:  PRINT MAILER STATEMNTS
			    LIBMENU1   SELECT NEW PROCESSING SYST
	 GOTO	   GETINDEX
*................................................................
. PROGRAM DOES NOT EXIST.
.
BADCHAIN BEEP
	 DISPLAY   *P1:23,*EL,*HON,"INVALID SELECTION",*HOFF:
		   *W2,*P1:23,*EL
	 GOTO	   GETINDEX
*................................................................
. CHAIN	INSTRUCTIONS
*................................................................
. ENTER	CASH REMITTANCES
.
CASHNTRY CHAIN	   "CASHNTRY"
	 GOTO	   GETINDEX
*................................................................
. CASH LEDGER MENU
.
CASHLDGR CHAIN	   "CASHLDGR"
	 GOTO	   GETINDEX
*................................................................
. PRINT	AGED DETAILS BY	ACCOUNT
.
AGEDTLS	 CHAIN	   "AGEDTLS "
	 GOTO	   GETINDEX
*................................................................
. PRINT	AGED SUMMARY REPORT FOR	ALL ACCTS
.
AGELIST	 CHAIN	   "AGELIST "
	 GOTO	   GETINDEX
*................................................................
. PRINT	MONTH-END STATEMENTS
.
STATEMNT CHAIN	   "STATEMNT"
	 GOTO	   GETINDEX
*................................................................
. A/R AGED RCVBLS INQUIRY BY ACCOUNT
.
ARINQ	 CHAIN	   "ARINQ   "
	 GOTO	   GETINDEX
*.................................................................
.  ENTER CREDIT	MEMOS
CREDITS	 CHAIN	   "INVCNTRY"
	 GOTO	   GETINDEX
*................................................................
. LIST OPEN RECEIVABLES	BY INVOICE NUMBER
ARLIST	 CHAIN	   "ARLIST  "
	 GOTO	   GETINDEX
*................................................................
OPENITEM CHAIN	   "INVCSCRN"
	 GOTO	   GETINDEX
. 
................................................................
BALFUPDT CHAIN	   "BALFUPDT"
	 GOTO	   GETINDEX
...............................................................
ARFLUPDT CHAIN	   "ARFLUPDT"
	 GOTO	   GETINDEX
...............................................................
ARQUERY	 CHAIN	   "ARQUERY"
	 GOTO	   GETINDEX
...........................................
ARINDEX	 
.
.
CHAINAR	 ROLLOUT  "F:\UTILS\ARINDX.BAT"
         DISPLAY  *P1:23,*EL,"ALL A/R FILES INDEXED",*W3,*P1:23,*EL

	 GOTO	   GETINDEX
.
.........
.
ARCLOSD	 CHAIN	   "ARCLOSD"
	 GOTO	   GETINDEX
.
........
AGESPCL	 CHAIN	   "AGESPCL"
	 GOTO	   GETINDEX
.
.
...........................................
. 
AGEING	 CHAIN	   "AGEING"
	 GOTO	   GETINDEX
.
............................................
MLRSTATE CHAIN     "NWSTMNT1"
	 GOTO	   GETINDEX
.
COMMAR80 CHAIN	   "COMMAR80"
	 GOTO	   GETINDEX
............................................
. 
. SELECT NEW PROCESSING	SYSTEM
. 
LIBMENU1 CHAIN	   "NEWMASTR"
	 GOTO	   GETINDEX
.
.............................................
. 
YOUCANT	 BEEP
	 DISPLAY   *P01:23,"YOU	MAY NOT	REQUEST	REPORTS	TO PRINT!",*W3:
		   *P01:23,*EL
	 GOTO	   GETINDEX
. 
YOUWONT	 BEEP
	 DISPLAY   *P01:23,"ONLY THE CONSOLE MAY DO A/R	MAINTENANCE !":
		   *P01:23,*EL
	 GOTO	   GETINDEX

. APPINVC1 - ORDER ENTRY PROCESSING FUNCTIONS
.
	 INCLUDE   MSCBRAG.TXT
.
	 INCLUDE   COMMON.TXT
. 
PRTCOMP	 DIM	   1
INDEX	 FORM	   2		       USER SELECTION VARIABLE
TIME	 INIT	   "hh:mm:ss"	       hours:minutes:seconds
. 
+................................................................
. MAINLINE
.
*................................................................
. DISPLAY THE MENU
.
	 CLOCK	   TIME	TO TIME
	 DISPLAY   *ES:
		   *HON:
		   "ORDER ENTRY	PROCESSING FUNCTIONS":
		   *P51:1,"Today is ",TODAY:
			  " Time: ",TIME:
		   *HOFF:
		   *P01:03,"( 1) ":
		   "ENTER NEW INVOICES/CREDITS":
		   *P01:04,"( 2) ":
		   "SELECT NEW PROCESSING SYSTEM",*EL

*................................................................
. GET THE PROGRAM'S INDEX
.
GETINDEX KEYIN	   *P1:20,*EL,*HON,"Selection by number":
		   *P25:20,"__",*HOFF,*P25:20,INDEX
	 COMPARE   "1" TO INDEX
	 GOTO	   GETINDEX IF LESS
	 COMPARE   "3" TO INDEX
	 GOTO	   GETINDEX IF NOT LESS
*................................................................
. BRANCH TO THE	ROUTINE	INDICATED BY THE INDEX
.
	 TRAP	   BADCHAIN IF CFAIL
	 CLOCK	   TIME	TO TIME
	 BRANCH	   INDEX OF NCLINVCS:  ENTER A NEW ORDER
			    LIBMENU1
.
	 GOTO	   GETINDEX
*................................................................
. PROGRAM DOES NOT EXIST.
.
BADCHAIN RETURN
*................................................................
SOENTRY	 CHAIN	   "SOENTRY"
	 GOTO	   GETINDEX
.
SOPRINT	 MOVE	   " " TO TESTONE
	 CHAIN	   "SOPRINT"
	 GOTO	   GETINDEX
.
SOINVPRT CHAIN	   "SOINVPRT"
	 GOTO	   GETINDEX
.
SOUPDATE CHAIN	   "SOUPDATE"
	 GOTO	   GETINDEX
.
. ENTER	A NEW ORDER
.
NCLINVCS CHAIN	   "APPINVCS"
	 GOTO	   GETINDEX
*................................................................
. PRINT	NCL STUDS INVOICES
.
LIBINVPT CHAIN	   "APPINVCP"
	 GOTO	   GETINDEX
*................................................................
. LIST	NCL STUDS OPEN INVOICES
.
LIBLIST	 CHAIN	   "APPINVCL"
	 GOTO	   GETINDEX
*................................................................
DARLIST	 CHAIN	   "DARLIST"
	 GOTO	   GETINDEX
*...............................................................
ALFARLST CHAIN	   "ALFARLST"
	 GOTO	   GETINDEX
................................................................
. SELECT NEW PROCESSING	SYSTEM
.
LIBMENU1 CHAIN	   "NEWMASTR"
	 GOTO	   GETINDEX
. 

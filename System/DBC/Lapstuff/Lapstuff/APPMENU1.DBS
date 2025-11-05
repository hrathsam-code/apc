. APPMENU1 -
.
	 INCLUDE   MSCBRAG.TXT
.
	 INCLUDE   COMMON.TXT
.
INDEX	 FORM	   2		       USER SELECTION VARIABLE
TIME	 INIT	   "hh:mm:ss"	       hours:minutes:seconds
DPORT	 DIM	   8
.
ROLLNAME INIT	   "C:\DBC\ROLLFILE.SYS"
REPLY	 DIM	   1
.
	 INCLUDE   LOGDATA.TXT
+................................................................
. MAINLINE
.
*................................................................
. THIS MENU REQUIRES A SECURITY	CLEARANCE OF AT	LEAST 1
.
	 COMPARE   "1" TO SECURITY
	 STOP	   IF LESS
.
*................................................................
. DISPLAY THE MENU
.
	 DISPLAY   *ES:
		   *HON:
		   " * PRECISE COMPONENTS FUNCTIONS  * ":
		   *P61:1,"Today is ",TODAY:
		   *HOFF:
		   *P01:03,"( 1) ":
		   "CUSTOMER FILE MAINTENANCE":
		   *P01:04,"( 2) ":
		   "ORDER PROCESSING":
		   *P01:05,"( 3) ":
		   "ACCOUNTS RECEIVABLE	PROCESSING":
		   *P01:06,"( 4) ":
		   "ACCOUNTS PAYABLE	PROCESSING":
		   *P01:07,"( 5) ":
		   "VENDOR   FILE MAINTENANCE":
		   *P01:08,"( 6) ":
		   "INVENTORY HISTORY PROCESSING":
		   *P01:09,"( 7) ":
		   "END	OF DAY PROCESSING":
		   *P01:10,"( 8) ":
		   "CORPORATE EDP CONTROLS":
		   *P01:11,"( 9) ":
		   "PRINT GULL & NORDEN	PART LISTS":
		   *P01:12,"(10) ":
		   "BACK UP DATA FILES TO REMOVABLE DISK":
		   *HON:
		   *P01:13,"(11) ":
		   "R E	P R I N	T   INVOICE MAILERS":
		   *P01:14,"(12) ":
		   "R E	P R I N	T   PACKING LISTS":
		   *HOFF:
		   *EL
*................................................................
. GET THE PROGRAM'S INDEX
.
GETINDEX KEYIN	   *P1:20,*EF,"Selection by number":
		   *P41:20,"Enter (99) to leave	this menu.":
		   *P25:20,"__",*P25:20,INDEX
	 COMPARE   "1" TO INDEX
	 GOTO	   GETINDEX IF LESS
	 COMPARE   "99"	TO INDEX
	 STOP	   IF EQUAL
	 COMPARE   "13"	TO INDEX
	 GOTO	   GETINDEX IF NOT LESS
*................................................................
. BRANCH TO THE	ROUTINE	INDICATED BY THE INDEX
.
	 TRAP	   BADCHAIN IF CFAIL
	 CLOCK	   TIME	TO TIME
	 BRANCH	   INDEX OF ACCTMNU1:  CUSTOMER	FILE MAINTENANCE
			    APPINVC1:  ORDER PROCESSING	MENU
			    ARMENU1:  ACCOUNTS RECEIVABLE PROCESS
			    APMENU1:  ACCOUNTS PAYABLE	  PROCESS
			    VENDMNU1:  VENDOR	FILE MAINTENANCE
			    MSHISTRY:  INVENTORY HISTORY PROCESSING
			    DAILYEOJ:  END OF DAY PROCESSING
			    CORPCTLS:	CORPORATE EDP CONTROLS
			    GULLPART:	PRINT GULL & NORDEN PART LISTS
			    BACKUP:
			    RPRTINVC:	REPRINT	INVOICE	MAILERS
			    SOPRINT	REPRINT	PKG LIST (SET RPRT FLAG!)
	 GOTO	   GETINDEX
*................................................................
. PROGRAM DOES NOT EXIST.
.
BADCHAIN RETURN
*................................................................
. CHAIN	INSTRUCTIONS
*................................................................
. CUSTOMER FILE	MAINTENANCE
.
ACCTMNU1 MOVE	   "PROGRAM" TO	LOGTYPE
	 CHAIN	   "ACCTMNU1"
	 GOTO	   GETINDEX
.................................................................
GULLPART CHAIN	   "GULLPART"
	 GOTO	   GETINDEX
.
.................................................................
RPRTINVC CHAIN	   "RPRTINVC"
	 GOTO	   GETINDEX
.
.................................................................
SOPRINT	 MOVE	   "R"	TO  TESTONE
	 CHAIN	   "SOPRINT"	     (REPRINT FLAG SET ON!)
	 GOTO	   GETINDEX
.................................................................
. ORDER	PROCESSING MENU
. 
APPINVC1 MOVE	   "PROGRAM" TO	LOGTYPE
	 CHAIN	   "APPINVC1"
	 GOTO	   GETINDEX
*................................................................
. ACCOUNTS RECEIVABLE PROCESSING
.
ARMENU1	 MOVE	   "PROGRAM" TO	LOGTYPE
	 CHAIN	   "ARMENU1"
	 GOTO	   GETINDEX
*................................................................
. ACCOUNTS PAYABLE    PROCESSING
.
APMENU1	 MOVE	   "PROGRAM" TO	LOGTYPE
	 CHAIN	   "APMENU1"
	 GOTO	   GETINDEX
*................................................................
. VENDOR   FILE	MAINTENANCE
.
VENDMNU1 MOVE	   "PROGRAM" TO	LOGTYPE
	 CHAIN 	   "APMAINT"
	 GOTO	   GETINDEX
*................................................................
. END OF DAY PROCESSING
.
DAILYEOJ MOVE	   "PROGRAM" TO	LOGTYPE
	 BEEP
	 MOVE	   " " TO REPLY
	 KEYIN	   *P1:23,*EL,*HON,"DO YOU REALLY WANT TO RUN END-OF-DAY? ":
		   "(Y/N) ",*HOFF,REPLY
	 DISPLAY   *P1:23,*EL
	 CMATCH	   "Y",REPLY
	 GOTO	   GETINDEX IF NOT EQUAL
.
	 RESET	   PORTN TO 2
	 MOVE	   PORTN TO DPORT
	 RESET	   PORTN TO 1
	 DISPLAY   *P1:22,DPORT,*W3
	 MATCH	   "TERM0" TO DPORT
	 GOTO	   CANT	IF NOT EQUAL
	 ROLLOUT   "CHAIN EOJ.CHN"
.....	     CHAIN     "DAILYEOJ"
	 GOTO	   GETINDEX
....................................................................
CANT	 BEEP
	 DISPLAY   *P1:23,*EL,*HON,"THE	END-OF-DAY MAY ONLY BE CALLED ":
		   "BY THE CONSOLE!",*HOFF,*W4,*P1:23,*EL
	 GOTO	   GETINDEX
.....................................................................
MSHISTRY MOVE	   "PROGRAM" TO	LOGTYPE
	 CHAIN	   "MSHISTRY"
	 GOTO	   GETINDEX
*................................................................
. CORPORATE EDP	CONTROLS
.
CORPCTLS MOVE	   "PROGRAM" TO	LOGTYPE
	 CHAIN	   "CORPCTLS"
	 GOTO	   GETINDEX
*....................................................................
BACKUP	 RESET	   PORTN TO 2
	 MOVE	   PORTN TO DPORT
	 RESET	   PORTN TO 1
	 MATCH	   "TERM0" TO DPORT
	 GOTO	   CANT	IF NOT EQUAL
	 ROLLOUT   "CHAIN BACKUP.CHN"
	 GOTO	   GETINDEX
.
.

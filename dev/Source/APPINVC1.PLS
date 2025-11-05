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
                                          "SELECT NEW PROCESSING SYSTEM":
                                          *P01:07,"( 3) ":
                                          "**** NEW INVOICE ENTRY ****":
                                          *P01:08,"( 4) ":
                                          "**** NEW CUSTOMER MAINT ****":
                                          *P01:09,"( 5) ":
                                          "**** NEW CASH ENTRY SYSTEM ****":
                                          *P01:10,"( 6) ":
                                          "**** NEW CUSTOMER INQUIRY ****":
                                         *P01:11,"( 7) ":
                                         "**** NEW BATCH ENTRY PROGRAM ****":
                                         *P01:12,"( 8) ":
                                         "****PRINT NEW CUSTOMER STATEMENTS****":
                                         *P01:13,"( 9) ":
                                         "****PRINT NEW CASH LEDGER (BATCH REPORT) ****":
                                         *P01:14,"(10) ":
                                         "****PRINT NEW INVOICE TOTAL REPORT ****":
                                         *P01:15,"(11) ":
                                         "****PRINT NEW AGING REPORT OPEN RECEIVABLES ****":
                                         *P01:16,"(12) ":
                                         "****Delete Invoices from System ****":
                                         *P01:17,"(13) ":
                                         "****Ledger Card Display ****":
                                         *EL

*................................................................
. GET THE PROGRAM'S INDEX
.
GETINDEX KEYIN	   *P1:20,*EL,*HON,"Selection by number":
		   *P25:20,"__",*HOFF,*P25:20,INDEX
	 COMPARE   "1" TO INDEX
	 GOTO	   GETINDEX IF LESS
                     COMPARE   "14" TO INDEX
	 GOTO	   GETINDEX IF NOT LESS
*................................................................
. BRANCH TO THE	ROUTINE	INDICATED BY THE INDEX
.
	 TRAP	   BADCHAIN IF CFAIL
	 CLOCK	   TIME	TO TIME
	 BRANCH	   INDEX OF NCLINVCS:  ENTER A NEW ORDER
                                            LIBMENU1:
                                            ORDERENTRY:
                                            CUSTMAINT:
                                            CashEnt:
                                            CustInq:
                                            BatchEntry:
                                            PrtStmt:
                                            PrtBatches:
                                            PrtInvoiceRpt:
                                            AgingReport:
                                            DeleteInvoices:
                                            LedgerCard
.
	 GOTO	   GETINDEX
*................................................................
. PROGRAM DOES NOT EXIST.
.
BADCHAIN RETURN
;==========================================================================================================
DeleteInvoices       CHAIN                "DeleteInvoices"
                     GOTO                 GETINDEX
;==========================================================================================================
LedgerCard           CHAIN                "LedgerCard"
                     GOTO                 GETINDEX
;==========================================================================================================
AgingReport          CHAIN                "PrtAgeAR"
                     GOTO                 GETINDEX
;==========================================================================================================
PrtInvoiceRpt        CHAIN                "PrtInvRp"
                     GOTO                 GETINDEX
;==========================================================================================================
PrtBatches           CHAIN                "PrtBatches"
                     GOTO                 GETINDEX
;==========================================================================================================
BatchEntry           CHAIN                "BatchEntry"
                     GOTO                 GETINDEX
;==========================================================================================================
CustInq              CHAIN                "Cinq"
                     GOTO                 GETINDEX
;==========================================================================================================
ORDERENTRY           CHAIN                "OrderEntry"
                     GOTO                 GETINDEX
;==========================================================================================================
PrtStmt           CHAIN                "PrtStmt"
                     GOTO                 GETINDEX
;==========================================================================================================
CashEnt              CHAIN                "CashEnt"
                     GOTO                 GETINDEX
;==========================================================================================================
CustMaint
                    chain              "Cust"
                    goto               GetIndex


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

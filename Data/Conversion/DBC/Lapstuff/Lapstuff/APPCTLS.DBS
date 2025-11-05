. NCLCTLS - NCL STUDSINC. CORPORATE EDP CONTROLS
.
.  WRITTEN BY R BACHARACH, MICRO SYSTEMS CONSULTANTS
.                          41 TEELE DRIVE
.                          CORAM, NEW YORK 11727
.                          (516) 698-5577
. 
. COMPILING THIS PROGRAM REQUIRES THAT THE FILES:  "COMMON/TXT",
. "LOGDATA/TXT" AND "LOGIO/TXT" EXIST ON ANY DRIVE WHICH IS ON-
. LINE.  THESE INCLUSION FILES CONTAIN THE INFORMATION COMMON TO
. ALL OF THE SYSTEM PROGRAMS.
.
         INCLUDE   COMMON/TXT
INDEX    FORM      2                   USER SELECTION VARIABLE
TIME     INIT      "hh:mm:ss"          hours:minutes:seconds
. 
         INCLUDE   LOGDATA/TXT
. 
+................................................................
. MAINLINE
.
*................................................................
. THIS MENU REQUIRES A SECURITY CLEARANCE OF AT LEAST 7
. 
         CLOCK     TIME TO TIME
. 
         INCLUDE   LOGIO/TXT
. 
.
         COMPARE   "6" TO SECURITY
         STOP      IF LESS
*................................................................
. DISPLAY THE MENU
.
         DISPLAY   *ES:
                   "N C L  S T U D S  I N C.  CORPORATE EDP CONTROLS":
                   *P51:01,"Date: ",TODAY,"  Time: ",TIME:
                   *P01:03,"( 1) ":
                   "UPDATE NCL CORPORATE CONTROL RECORDS":
                   *P01:04,"( 2) ":
                   "INQUIRY OF NCL CORPORATE EDP CONTROLS":
                   *P01:05,"( 3) ":
                   "SELECT NEW PROCESSING SYSTEM":
                   *EL
*................................................................
. GET THE PROGRAM'S INDEX
.
GETINDEX KEYIN     *P1:12,*EL,"Selection by number":
                   *P25:12,"__",*P25:12,INDEX
         COMPARE   "1" TO INDEX
         GOTO      GETINDEX IF LESS
         COMPARE   "04" TO INDEX
         GOTO      GETINDEX IF NOT LESS
*................................................................
. BRANCH TO THE ROUTINE INDICATED BY THE INDEX
.
         TRAP      BADCHAIN IF CFAIL
         CLOCK     TIME TO TIME
         BRANCH    INDEX OF CTLUDPGM:  UPDATE CORPORATE CONTROL R
                            CTLINQ:  INQUIRY OF CORPORATE EDP CON
                            LIBMENU1   SELECT NEW PROCESSING SYST
         GOTO      GETINDEX
*................................................................
. PROGRAM DOES NOT EXIST.
.
BADCHAIN MOVE      "NCLCTLS" TO LOGINFO
         MOVE      "CHN-FAIL" TO LOGTYPE
         CALL      LOGWRITE
         RETURN
*................................................................
. CHAIN INSTRUCTIONS
*................................................................
. UPDATE CORPORATE CONTROL RECORDS
.
CTLUDPGM CHAIN     "NCLCTLUD"
         GOTO      GETINDEX
*................................................................
. INQUIRY OF CORPORATE EDP CONTROLS
.
CTLINQ   CHAIN     "NCLCTLIQ"
         GOTO      GETINDEX
*................................................................
. PRINT CORPORATE EDP CONTROL REPORT
.
CTLPRINT CHAIN     "CTLPRINT"
         GOTO      GETINDEX
*................................................................
. SELECT NEW PROCESSING SYSTEM
.
LIBMENU1 CHAIN     "NCLMENU1"
         GOTO      GETINDEX
. 

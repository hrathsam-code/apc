. =========================================================================
. APDATES/TXT - THIS ROUTINE IS USED TO DETERMINE THE AGEING OF INVOICES
.               IN THE ACCOUNTS PAYABLE SYSTEM - TO ENABLE THE SELECTION
.               OF INVOICES THAT ARE 30 DAYS OLD OR OLDER FOR PAYMENT
. 
.    NOTE...THIS ROUTINE REQUIRES THAT THE MODULE - 
. 
.                   APCALNDR/TXT
. 
.           BE INCLUDED IN THE WORKING STORAGE SECTION OF THE PROGRAM
. 
CALCDATE TRAPCLR   PARITY
         MOVE      "0"  TO  CALSET
         MOVE      "0"  TO  CALINDX
         MOVE      "0"  TO  WORKFLD
         MOVE      "0"  TO  TESTDATE
. 
GETYEAR  MOVE      TYEAR   TO  YEARN    (SET THE YEAR FOR MULTIPLICATION)
         COMPARE   "99"    TO  YEARN
         GOTO      SET1900 IF  EQUAL
         GOTO      SETY2K  

MULTWORK
         MULTIPLY  "365"  BY  WORKFLD    (YIELDS YEAR IN DAYS)
         COMPARE   "9"    TO  SECURITY
         GOTO      SCANMON    IF NOT EQUAL
.....    DISPLAY   *P75:24,*HON,WORKFLD
. 
SCANMON  MOVE      TMON   TO  CALINDX
         MOVE      "000"  TO  CALSET
. 
         LOAD      CALSET FROM CALINDX OF JAN,FEB,MAR,APR,MAY,JUN:
                                          JUL,AUG,SEP,OCT,NOV,DEC
. 
         ADD       CALSET TO  WORKFLD    (YIELDS YEARS + MON)
         COMPARE   "9"    TO  SECURITY
         GOTO      BBPASS IF  NOT EQUAL
. 
.....    DISPLAY   *P75:24,*HON,WORKFLD
. 
BBPASS   MOVE      TDAY   TO  DAYN
         ADD       DAYN   TO  WORKFLD     (YIELDS FINAL CALCULATED DAYS)
         COMPARE   "9"    TO  SECURITY
         GOTO      DTRTRN IF  NOT EQUAL
.....    DISPLAY   *P75:24,*HON,WORKFLD
. 
DTRTRN   MOVE      WORKFLD  TO  TESTDATE
         RETURN
................................................
SETY2K   MOVE      "2000"  TO  WORKFLD
         ADD       YEARN   TO  WORKFLD
         GOTO      MULTWORK
.
SET1900  MOVE      "1900"  TO  WORKFLD
         ADD       YEARN   TO  WORKFLD
         GOTO      MULTWORK


. 
. =========================================================================
. 
. 

. =============================================================================
. 
.   SYSTEM:          ACCOUNTS PAYABLE
.   FILE ID:         APMASTER
.   FILE NAME:       ACCOUNTS PAYABLE MASTER FILE
.   FILE ORGAN:      ISAM     (ACCNO,  1-6)
.   SPACE COMP:      NO
. 
ACCKEY   DIM       6                FIELD USED AS RECORD KEY
APOVRFLG DIM       1                APMASTER READ OVER FLAG
. 
. 
ACCNO    DIM       6                ACCOUNT NUMBER
NAME     DIM       25               ACCOUNT NAME
ADD1     DIM       20               ADDRESS LINE 1
ADD2     DIM       20               ADDRESS LINE 2
CITY     DIM       14               CITY
STATE    DIM       2                STATE
ZIP      DIM       5                ZIP CODE
TAXC     DIM       1                TAX CODE
ACCST    DIM       1                ACCOUNT STATUS
CRDRAT   DIM       1                CREDIT RATING
OVR90    FORM      7.2              AMOUNT DUE OVER 90 DAYS
OVR60    FORM      7.2              AMOUNT DUE OVER 60 DAYS
OVR30    FORM      7.2              AMOUNT DUE OVER 30 DAYS
CURR     FORM      7.2              AMOUNT CURRENTLY DUE
MTDD     FORM      7.2              MONTH TO DATE DEBITS
MTDC     FORM      7.2              MONTH TO DATE CREDITS
TOTDUE   FORM      7.2              TOTAL AMOUNT DUE
MMON     DIM       2                MONTH      -|  LAST
MDAY     DIM       2                DAY         |  PURCHASE
MYEAR    DIM       2                YEAR       -|  DATE
LPAT     FORM      6.2              LAST PURCHASE AMOUNT
EXT      DIM       5                EXPANSION AREA
DIVNO    DIM       2                DIVISION NUMBER
CONT     DIM       3                CONTACT PERSON
TELEFONE DIM       12               TELEFONE NUMBER
FUT      DIM       1                EXPANSION AREA
. 
. 
.    HEADER RECORD FIELDS
. 
APCONTRL FORM      10.2             A/P CONTROL TOTAL
LPAGE    FORM      4                LAST PAGE OF POSTING JOURNAL
. 
. =============================================================================
. 

. 
. CUSTOMER MASTER FILE DEFINITION   SOURCE NAME CUSTMAST/TXT  9/29/79
. 
. RECORD LENGTH IS 225 BYTES: (INCLUDES AGEING CATEGORIES)
. 
. KEY LOCATED POSITION 1 FOR A LENGTH OF 4 BYTES
. 
CUSTKEY  DIM       4
CUSTSTTS DIM       1         STATUS OF ACCT: A=OPEN, C=MODIFIED, D=DELETED
CUSTNAME DIM       30
CUSTADDR DIM       25
CUSTADR2 DIM       25
CUSTCITY DIM       20
CUSTSTAT DIM       2
CUSTZIP  FORM      5
CUSTCRED FORM      6         CREDIT LIMIT IN DOLLARS
CUSTCATG DIM       1         PAYMENT CATEGORY: P=POOR, OTHERWISE OK
. . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 
.  MOST CURRENT SALES AND PAYMENT ACTIVITY         
.  . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . 
LSTSALDT DIM       6         LAST SALE DATE
LSTPAYDT DIM       6         LAST PAYMENT DATE
LSTSALPR FORM      5.2       LAST INVOICE AMOUNT
LSTPAYPR FORM      5.2       LAST PAYMENT AMOUNT
. ......................................................................
COMMCODE DIM       4         COMMISSION CODE
. ......................................................................
.  . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.  ACCOUNTS RECEIVABLES SYSTEM - AGEING CATEGORIES
.  . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
CURNTDUE FORM      6.2       CURRENT DUE AMOUNT    (1-30 DAYS OLD)
PD01TO30 FORM      6.2       PAST DUE 1-30         (31-60 DAYS OLD)
PD31TO60 FORM      6.2       PAST DUE 31-60        (61-90 DAYS OLD)
PD61TO90 FORM      6.2       PAST DUE 61-90        (91-120 DAYS OLD)
PDOVR90  FORM      6.2       PAST DUE 91+          (121+   DAYS OLD)
.  . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
.  MONTH TO DATE CASH PROCESSED AND CREDITS ISSUED TO ACCT
.  . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
MTDCASH  FORM      6.2
MTDCRED  FORM      5.2
. 
........TELEFONE DIM       12
.
. 

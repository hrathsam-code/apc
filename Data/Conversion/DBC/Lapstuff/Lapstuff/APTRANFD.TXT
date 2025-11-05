. =============================================================================
. 
.   SYSTEM:      ACCOUNTS PAYABLE
.   FILE NAME:   TRANSACTION FILE
.   FILE ID:     APTRANFL
.   FILE ORGAN:  ISAM   (1-19)
.   SPACE COMP:  NO
. 
TRNKEY   DIM       19             TRANSACTION KEY
TRNKEY2  DIM       19             TEST TRANSACTION KEY
. 
TACCN    DIM       6              TRANSACTION ACCOUNT NUMBER   (RECORD KEY)
TYEAR    DIM       2              TRANSACTION YEAR             (RECORD KEY)
TMON     DIM       2              TRANSACTION MONTH            (RECORD KEY)
TDAY     DIM       2              TRANSACTION DAY              (RECORD KEY)
TINVNO   DIM       6              INVOICE NUMBER               (RECORD KEY)
TCNT     FORM      1              INVOICE COUNTER              (RECORD KEY)
TDESC    DIM       20             DESCRIPTION
TAMT     FORM      6.2            TRANSACTION AMOUNT
TLDDAY   DIM       8              LAST DISCOUNT DAY 
TDISA    FORM      4.2            DISCOUNT AMOUNT
TDCODE   DIM       6              DISTRIBUTION CODE (PRIMARY)
. 
. =============================================================================
. 

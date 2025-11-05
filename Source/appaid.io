;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    4 NORFOLK LANE                                           ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    APPaid.IO                                                      ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    02/28/2005 AT 10:55PM                                          ;
;                                                                             ;
;  PURPOSE:    Accounts Payable Paid History                                  ;
;                                                                             ;
; REVISION:    VER     DATE     INIT       DETAILS                            ;
;                                                                             ;
;              1.0   02/28/2005   HOR     INITIAL VERSION                     ;
;                                                                             ;
;=============================================================================;
.
           %IFNDEF           $APPaidVAR
             INCLUDE           APPaidER.FD
           %ENDIF
.
           %IFNDEF           $APPaidIO
$APPaidIO    EQUATE            1
.
. Test Read for PRIMARY Index
.
TSTAPPaid
           READ              APPaidFL,APPaidKY;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPPaid
           READ              APPaidFL,APPaidKY;APPaid
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPPaidLK
           READLK            APPaidFL,APPaidKY;APPaid
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPPaid
           READKS            APPaidFL;APPaid
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPPaidLK

           READKSLK          APPaidFL;APPaid
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPPaid
          READKP             APPaidFL;APPaid
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPPaidLK

           READKPLK          APPaidFL;APPaid
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.=============================================================================
. Secondary file I/O operations
.
           %IFDEF            APPaidKY2
TSTAPPaid2
           READ              APPaidFL2,APPaidKY2;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPPaid2
           READ              APPaidFL2,APPaidKY2;APPaid
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPPaid2LK
           READLK            APPaidFL2,APPaidKY2;APPaid
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPPaid2
           READKS            APPaidFL2;APPaid
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPPaid2LK

           READKSLK          APPaidFL2;APPaid
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPPaid2
          READKP             APPaidFL2;APPaid
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPPaid2LK
           READKPLK          APPaidFL2;APPaid
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Third file I/O operations
.
           %IFDEF            APPaidKY3
.
TSTAPPaid3
           READ              APPaidFL3,APPaidKY3;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPPaid3
           READ              APPaidFL3,APPaidKY3;APPaid
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPPaid3LK
           READLK            APPaidFL3,APPaidKY3;APPaid
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPPaid3
           READKS            APPaidFL3;APPaid
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPPaid3LK

           READKSLK          APPaidFL3;APPaid
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPPaid3
          READKP             APPaidFL3;APPaid
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPPaid3LK

           READKPLK          APPaidFL3;APPaid
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fourth file I/O operations
.
           %IFDEF            APPaidKY4
.
TSTAPPaid4
           READ              APPaidFL4,APPaidKY4;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPPaid4
           READ              APPaidFL4,APPaidKY4;APPaid
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPPaid4LK
           READLK            APPaidFL4,APPaidKY4;APPaid
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPPaid4
           READKS            APPaidFL4;APPaid
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPPaid4LK

           READKSLK          APPaidFL4;APPaid
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPPaid4
          READKP             APPaidFL4;APPaid
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPPaid4LK

           READKPLK          APPaidFL4;APPaid
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fifth file I/O operations
.
           %IFDEF            APPaidKY5
.
TSTAPPaid5
           READ              APPaidFL5,APPaidKY5;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPPaid5
           READ              APPaidFL5,APPaidKY5;APPaid
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPPaid5LK
           READLK            APPaidFL5,APPaidKY5;APPaid
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPPaid5
           READKS            APPaidFL5;APPaid
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPPaid5LK

           READKSLK          APPaidFL5;APPaid
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPPaid5
          READKP             APPaidFL5;APPaid
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPPaid5LK

           READKPLK          APPaidFL5;APPaid
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Sixth file I/O operations
.
           %IFDEF            APPaidKY6
.
TSTAPPaid6
           READ              APPaidFL6,APPaidKY6;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPPaid6
           READ              APPaidFL6,APPaidKY6;APPaid
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPPaid6LK
           READLK            APPaidFL6,APPaidKY6;APPaid
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPPaid6
           READKS            APPaidFL6;APPaid
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPPaid6LK

           READKSLK          APPaidFL6;APPaid
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPPaid6
          READKP             APPaidFL6;APPaid
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPPaid6LK

           READKPLK          APPaidFL6;APPaid
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Seventh file I/O operations
.
           %IFDEF            APPaidKY7
.
TSTAPPaid7
           READ              APPaidFL7,APPaidKY7;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPPaid7
           READ              APPaidFL7,APPaidKY7;APPaid
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPPaid7LK
           READLK            APPaidFL7,APPaidKY7;APPaid
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPPaid7
           READKS            APPaidFL7;APPaid
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPPaid7LK

           READKSLK          APPaidFL7;APPaid
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPPaid7
          READKP             APPaidFL7;APPaid
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPPaid7LK

           READKPLK          APPaidFL7;APPaid
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Eighth file I/O operations
.
           %IFDEF            APPaidKY8
.
TSTAPPaid8
           READ              APPaidFL8,APPaidKY8;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPPaid8
           READ              APPaidFL8,APPaidKY8;APPaid
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPPaid8LK
           READLK            APPaidFL8,APPaidKY8;APPaid
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPPaid8
           READKS            APPaidFL8;APPaid
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPPaid8LK

           READKSLK          APPaidFL8;APPaid
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPPaid8
          READKP             APPaidFL8;APPaid
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPPaid8LK

           READKPLK          APPaidFL8;APPaid
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Ninth file I/O operations
.
           %IFDEF            APPaidKY9
.
. Third set of File I/O operations
.
TSTAPPaid9
           READ              APPaidFL9,APPaidKY9;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPPaid9
           READ              APPaidFL9,APPaidKY9;APPaid
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPPaid9LK
           READLK            APPaidFL9,APPaidKY9;APPaid
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPPaid9
           READKS            APPaidFL9;APPaid
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPPaid9LK

           READKSLK          APPaidFL9;APPaid
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPPaid9
          READKP             APPaidFL9;APPaid
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPPaid9LK

           READKPLK          APPaidFL9;APPaid
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.
.=============================================================================
.
. Deletion for PRIMARY Index
.
DELAPPaid
           READ              APPaidFL,APPaidKY;;
           GOTO              #ERROR IF OVER
DELAPPaidLK
           DELETE            APPaidFLST
           GOTO              #VALID
.
. Update I/O operation
.
UPDAPPaid
.           READ              APPaidFL,APPaidKY;;
.           GOTO              #ERROR IF OVER
UPDAPPaidLK
           UPDATE            APPaidFLST;APPaid
           GOTO              #VALID
.
. Write I/O operation
.
WRTAPPaid
           WRITE             APPaidFLST;APPaid
           GOTO              #VALID
.
. Preparation of APPaider Transaction Files
.
PREPAPPaid
           %IFDEF            APPaidKY
             PREPARE           APPaidFL,APPaidTXTNM,APPaidISI1NM,APPaidI1DEF,APPaidFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APPaidKY2
             PREPARE           APPaidFL2,APPaidTXTNM,APPaidISI2NM,APPaidI2DEF,APPaidFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APPaidKY3
             PREPARE           APPaidFL3,APPaidTXTNM,APPaidISI3NM,APPaidI3DEF,APPaidFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APPaidKY4
             PREPARE           APPaidFL4,APPaidTXTNM,APPaidISI4NM,APPaidI4DEF,APPaidFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APPaidKY5
             PREPARE           APPaidFL5,APPaidTXTNM,APPaidISI5NM,APPaidI5DEF,APPaidFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APPaidKY6
             PREPARE           APPaidFL6,APPaidTXTNM,APPaidISI6NM,APPaidI6DEF,APPaidFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APPaidKY7
             PREPARE           APPaidFL7,APPaidTXTNM,APPaidISI7NM,APPaidI7DEF,APPaidFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APPaidKY8
             PREPARE           APPaidFL8,APPaidTXTNM,APPaidISI8NM,APPaidI8DEF,APPaidFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APPaidKY9
             PREPARE           APPaidFL9,APPaidTXTNM,APPaidISI9NM,APPaidI9DEF,APPaidFSIZE,EXCLUSIVE
           %ENDIF
           RETURN

.
. Opening of Check Register Transaction File
.
OPENAPPaid
           GETFILE           APPaidFL
           RETURN            IF ZERO
           OPEN              APPaidFLST,SHARE,LOCKMANUAL,SINGLE,NOWAIT
           RETURN
.
. Standard Return Values for I/O Include
.
#ERROR
           MOVE              "1" TO RETURNFL
           RETURN
#LOCKED
           MOVE              "2" TO RETURNFL
           RETURN
#VALID
           MOVE              "0" TO RETURNFL
           RETURN

           %ENDIF


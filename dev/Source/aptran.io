;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    4 NORFOLK LANE                                           ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    APTran.IO                                                      ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    02/28/2005 AT 10:55PM                                          ;
;                                                                             ;
;  PURPOSE:    Accounts Payable Open Inquiry                                  ;
;                                                                             ;
; REVISION:    VER     DATE     INIT       DETAILS                            ;
;                                                                             ;
;              1.0   02/28/2005   HOR     INITIAL VERSION                     ;
;                                                                             ;
;=============================================================================;
.
           %IFNDEF           $APTranVAR
             INCLUDE           APTranER.FD
           %ENDIF
.
           %IFNDEF           $APTranIO
$APTranIO    EQUATE            1
.
. Test Read for PRIMARY Index
.
TSTAPTran
           READ              APTranFL,APTranKY;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPTran
           READ              APTranFL,APTranKY;APTran
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPTranLK
           READLK            APTranFL,APTranKY;APTran
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPTran
           READKS            APTranFL;APTran
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPTranLK

           READKSLK          APTranFL;APTran
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPTran
          READKP             APTranFL;APTran
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPTranLK

           READKPLK          APTranFL;APTran
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.=============================================================================
. Secondary file I/O operations
.
           %IFDEF            APTranKY2
TSTAPTran2
           READ              APTranFL2,APTranKY2;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPTran2
           READ              APTranFL2,APTranKY2;APTran
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPTran2LK
           READLK            APTranFL2,APTranKY2;APTran
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPTran2
           READKS            APTranFL2;APTran
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPTran2LK

           READKSLK          APTranFL2;APTran
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPTran2
          READKP             APTranFL2;APTran
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPTran2LK
           READKPLK          APTranFL2;APTran
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Third file I/O operations
.
           %IFDEF            APTranKY3
.
TSTAPTran3
           READ              APTranFL3,APTranKY3;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPTran3
           READ              APTranFL3,APTranKY3;APTran
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPTran3LK
           READLK            APTranFL3,APTranKY3;APTran
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPTran3
           READKS            APTranFL3;APTran
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPTran3LK

           READKSLK          APTranFL3;APTran
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPTran3
          READKP             APTranFL3;APTran
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPTran3LK

           READKPLK          APTranFL3;APTran
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fourth file I/O operations
.
           %IFDEF            APTranKY4
.
TSTAPTran4
           READ              APTranFL4,APTranKY4;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPTran4
           READ              APTranFL4,APTranKY4;APTran
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPTran4LK
           READLK            APTranFL4,APTranKY4;APTran
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPTran4
           READKS            APTranFL4;APTran
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPTran4LK

           READKSLK          APTranFL4;APTran
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPTran4
          READKP             APTranFL4;APTran
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPTran4LK

           READKPLK          APTranFL4;APTran
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fifth file I/O operations
.
           %IFDEF            APTranKY5
.
TSTAPTran5
           READ              APTranFL5,APTranKY5;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPTran5
           READ              APTranFL5,APTranKY5;APTran
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPTran5LK
           READLK            APTranFL5,APTranKY5;APTran
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPTran5
           READKS            APTranFL5;APTran
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPTran5LK

           READKSLK          APTranFL5;APTran
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPTran5
          READKP             APTranFL5;APTran
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPTran5LK

           READKPLK          APTranFL5;APTran
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Sixth file I/O operations
.
           %IFDEF            APTranKY6
.
TSTAPTran6
           READ              APTranFL6,APTranKY6;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPTran6
           READ              APTranFL6,APTranKY6;APTran
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPTran6LK
           READLK            APTranFL6,APTranKY6;APTran
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPTran6
           READKS            APTranFL6;APTran
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPTran6LK

           READKSLK          APTranFL6;APTran
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPTran6
          READKP             APTranFL6;APTran
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPTran6LK

           READKPLK          APTranFL6;APTran
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Seventh file I/O operations
.
           %IFDEF            APTranKY7
.
TSTAPTran7
           READ              APTranFL7,APTranKY7;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPTran7
           READ              APTranFL7,APTranKY7;APTran
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPTran7LK
           READLK            APTranFL7,APTranKY7;APTran
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPTran7
           READKS            APTranFL7;APTran
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPTran7LK

           READKSLK          APTranFL7;APTran
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPTran7
          READKP             APTranFL7;APTran
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPTran7LK

           READKPLK          APTranFL7;APTran
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Eighth file I/O operations
.
           %IFDEF            APTranKY8
.
TSTAPTran8
           READ              APTranFL8,APTranKY8;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPTran8
           READ              APTranFL8,APTranKY8;APTran
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPTran8LK
           READLK            APTranFL8,APTranKY8;APTran
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPTran8
           READKS            APTranFL8;APTran
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPTran8LK

           READKSLK          APTranFL8;APTran
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPTran8
          READKP             APTranFL8;APTran
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPTran8LK

           READKPLK          APTranFL8;APTran
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Ninth file I/O operations
.
           %IFDEF            APTranKY9
.
. Third set of File I/O operations
.
TSTAPTran9
           READ              APTranFL9,APTranKY9;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPTran9
           READ              APTranFL9,APTranKY9;APTran
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPTran9LK
           READLK            APTranFL9,APTranKY9;APTran
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPTran9
           READKS            APTranFL9;APTran
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPTran9LK

           READKSLK          APTranFL9;APTran
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPTran9
          READKP             APTranFL9;APTran
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPTran9LK

           READKPLK          APTranFL9;APTran
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.
.=============================================================================
.
. Deletion for PRIMARY Index
.
DELAPTran
           READ              APTranFL,APTranKY;;
           GOTO              #ERROR IF OVER
DELAPTranLK
           DELETE            APTranFLST
           GOTO              #VALID
.
. Update I/O operation
.
UPDAPTran
.           READ              APTranFL,APTranKY;;
.           GOTO              #ERROR IF OVER
UPDAPTranLK
           UPDATE            APTranFLST;APTran
           GOTO              #VALID
.
. Write I/O operation
.
WRTAPTran
           WRITE             APTranFLST;APTran
           GOTO              #VALID
.
. Preparation of APTraner Transaction Files
.
PREPAPTran
           %IFDEF            APTranKY
             PREPARE           APTranFL,APTranTXTNM,APTranISI1NM,APTranI1DEF,APTranFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APTranKY2
             PREPARE           APTranFL2,APTranTXTNM,APTranISI2NM,APTranI2DEF,APTranFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APTranKY3
             PREPARE           APTranFL3,APTranTXTNM,APTranISI3NM,APTranI3DEF,APTranFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APTranKY4
             PREPARE           APTranFL4,APTranTXTNM,APTranISI4NM,APTranI4DEF,APTranFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APTranKY5
             PREPARE           APTranFL5,APTranTXTNM,APTranISI5NM,APTranI5DEF,APTranFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APTranKY6
             PREPARE           APTranFL6,APTranTXTNM,APTranISI6NM,APTranI6DEF,APTranFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APTranKY7
             PREPARE           APTranFL7,APTranTXTNM,APTranISI7NM,APTranI7DEF,APTranFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APTranKY8
             PREPARE           APTranFL8,APTranTXTNM,APTranISI8NM,APTranI8DEF,APTranFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APTranKY9
             PREPARE           APTranFL9,APTranTXTNM,APTranISI9NM,APTranI9DEF,APTranFSIZE,EXCLUSIVE
           %ENDIF
           RETURN

.
. Opening of Check Register Transaction File
.
OPENAPTran
           GETFILE           APTranFL
           RETURN            IF ZERO
           OPEN              APTranFLST,SHARE,LOCKMANUAL,SINGLE,NOWAIT
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


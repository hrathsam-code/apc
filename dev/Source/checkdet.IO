;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    4 NORFOLK LANE                                           ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    CheckDet.IO                                                    ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    06/01/2005 AT 10:55AM                                          ;
;                                                                             ;
;  PURPOSE:    Check Detail I/O Routines                                      ;
;                                                                             ;
; REVISION:    VER     DATE     INIT       DETAILS                            ;
;                                                                             ;
;              1.0   02/28/2005   HOR     INITIAL VERSION                     ;
;                                                                             ;
;=============================================================================;
.
           %IFNDEF           $CheckDetailVAR
             INCLUDE           CheckDetailER.FD
           %ENDIF
.
           %IFNDEF           $CheckDetailIO
$CheckDetailIO    EQUATE            1
.
. Test Read for PRIMARY Index
.
TSTCheckDetail
           READ              CheckDetailFL,CheckDetailKY;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCheckDetail
           READ              CheckDetailFL,CheckDetailKY;CheckDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCheckDetailLK
           READLK            CheckDetailFL,CheckDetailKY;CheckDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCheckDetail
           READKS            CheckDetailFL;CheckDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCheckDetailLK

           READKSLK          CheckDetailFL;CheckDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCheckDetail
          READKP             CheckDetailFL;CheckDetail
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCheckDetailLK

           READKPLK          CheckDetailFL;CheckDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.=============================================================================
. Secondary file I/O operations
.
           %IFDEF            CheckDetailKY2
TSTCheckDetail2
           READ              CheckDetailFL2,CheckDetailKY2;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCheckDetail2
           READ              CheckDetailFL2,CheckDetailKY2;CheckDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCheckDetail2LK
           READLK            CheckDetailFL2,CheckDetailKY2;CheckDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCheckDetail2
           READKS            CheckDetailFL2;CheckDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCheckDetail2LK

           READKSLK          CheckDetailFL2;CheckDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCheckDetail2
          READKP             CheckDetailFL2;CheckDetail
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCheckDetail2LK
           READKPLK          CheckDetailFL2;CheckDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Third file I/O operations
.
           %IFDEF            CheckDetailKY3
.
TSTCheckDetail3
           READ              CheckDetailFL3,CheckDetailKY3;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCheckDetail3
           READ              CheckDetailFL3,CheckDetailKY3;CheckDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCheckDetail3LK
           READLK            CheckDetailFL3,CheckDetailKY3;CheckDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCheckDetail3
           READKS            CheckDetailFL3;CheckDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCheckDetail3LK

           READKSLK          CheckDetailFL3;CheckDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCheckDetail3
          READKP             CheckDetailFL3;CheckDetail
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCheckDetail3LK

           READKPLK          CheckDetailFL3;CheckDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fourth file I/O operations
.
           %IFDEF            CheckDetailKY4
.
TSTCheckDetail4
           READ              CheckDetailFL4,CheckDetailKY4;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCheckDetail4
           READ              CheckDetailFL4,CheckDetailKY4;CheckDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCheckDetail4LK
           READLK            CheckDetailFL4,CheckDetailKY4;CheckDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCheckDetail4
           READKS            CheckDetailFL4;CheckDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCheckDetail4LK

           READKSLK          CheckDetailFL4;CheckDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCheckDetail4
          READKP             CheckDetailFL4;CheckDetail
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCheckDetail4LK

           READKPLK          CheckDetailFL4;CheckDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fifth file I/O operations
.
           %IFDEF            CheckDetailKY5
.
TSTCheckDetail5
           READ              CheckDetailFL5,CheckDetailKY5;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCheckDetail5
           READ              CheckDetailFL5,CheckDetailKY5;CheckDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCheckDetail5LK
           READLK            CheckDetailFL5,CheckDetailKY5;CheckDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCheckDetail5
           READKS            CheckDetailFL5;CheckDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCheckDetail5LK

           READKSLK          CheckDetailFL5;CheckDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCheckDetail5
          READKP             CheckDetailFL5;CheckDetail
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCheckDetail5LK

           READKPLK          CheckDetailFL5;CheckDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Sixth file I/O operations
.
           %IFDEF            CheckDetailKY6
.
TSTCheckDetail6
           READ              CheckDetailFL6,CheckDetailKY6;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCheckDetail6
           READ              CheckDetailFL6,CheckDetailKY6;CheckDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCheckDetail6LK
           READLK            CheckDetailFL6,CheckDetailKY6;CheckDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCheckDetail6
           READKS            CheckDetailFL6;CheckDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCheckDetail6LK

           READKSLK          CheckDetailFL6;CheckDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCheckDetail6
          READKP             CheckDetailFL6;CheckDetail
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCheckDetail6LK

           READKPLK          CheckDetailFL6;CheckDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Seventh file I/O operations
.
           %IFDEF            CheckDetailKY7
.
TSTCheckDetail7
           READ              CheckDetailFL7,CheckDetailKY7;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCheckDetail7
           READ              CheckDetailFL7,CheckDetailKY7;CheckDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCheckDetail7LK
           READLK            CheckDetailFL7,CheckDetailKY7;CheckDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCheckDetail7
           READKS            CheckDetailFL7;CheckDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCheckDetail7LK

           READKSLK          CheckDetailFL7;CheckDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCheckDetail7
          READKP             CheckDetailFL7;CheckDetail
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCheckDetail7LK

           READKPLK          CheckDetailFL7;CheckDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Eighth file I/O operations
.
           %IFDEF            CheckDetailKY8
.
TSTCheckDetail8
           READ              CheckDetailFL8,CheckDetailKY8;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCheckDetail8
           READ              CheckDetailFL8,CheckDetailKY8;CheckDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCheckDetail8LK
           READLK            CheckDetailFL8,CheckDetailKY8;CheckDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCheckDetail8
           READKS            CheckDetailFL8;CheckDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCheckDetail8LK

           READKSLK          CheckDetailFL8;CheckDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCheckDetail8
          READKP             CheckDetailFL8;CheckDetail
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCheckDetail8LK

           READKPLK          CheckDetailFL8;CheckDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Ninth file I/O operations
.
           %IFDEF            CheckDetailKY9
.
. Third set of File I/O operations
.
TSTCheckDetail9
           READ              CheckDetailFL9,CheckDetailKY9;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCheckDetail9
           READ              CheckDetailFL9,CheckDetailKY9;CheckDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCheckDetail9LK
           READLK            CheckDetailFL9,CheckDetailKY9;CheckDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCheckDetail9
           READKS            CheckDetailFL9;CheckDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCheckDetail9LK

           READKSLK          CheckDetailFL9;CheckDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCheckDetail9
          READKP             CheckDetailFL9;CheckDetail
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCheckDetail9LK

           READKPLK          CheckDetailFL9;CheckDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.
.=============================================================================
.
. Deletion for PRIMARY Index
.
DELCheckDetail
.           READ              CheckDetailFL,CheckDetailKY;;
.           GOTO              #ERROR IF OVER
DELCheckDetailLK
           DELETE            CheckDetailFLST
           GOTO              #VALID
.
. Update I/O operation
.
UPDCheckDetail
.           READ              CheckDetailFL,CheckDetailKY;;
.           GOTO              #ERROR IF OVER
UPDCheckDetailLK
           UPDATE            CheckDetailFLST;CheckDetail
           GOTO              #VALID
.
. Write I/O operation
.
WRTCheckDetail
           WRITE             CheckDetailFLST;CheckDetail
           GOTO              #VALID
.
. Preparation of CheckDetailer Transaction Files
.
PREPCheckDetail
           %IFDEF            CheckDetailKY
             PREPARE           CheckDetailFL,CheckDetailTXTNM,CheckDetailISI1NM,CheckDetailI1DEF,CheckDetailFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CheckDetailKY2
             PREPARE           CheckDetailFL2,CheckDetailTXTNM,CheckDetailISI2NM,CheckDetailI2DEF,CheckDetailFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CheckDetailKY3
             PREPARE           CheckDetailFL3,CheckDetailTXTNM,CheckDetailISI3NM,CheckDetailI3DEF,CheckDetailFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CheckDetailKY4
             PREPARE           CheckDetailFL4,CheckDetailTXTNM,CheckDetailISI4NM,CheckDetailI4DEF,CheckDetailFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CheckDetailKY5
             PREPARE           CheckDetailFL5,CheckDetailTXTNM,CheckDetailISI5NM,CheckDetailI5DEF,CheckDetailFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CheckDetailKY6
             PREPARE           CheckDetailFL6,CheckDetailTXTNM,CheckDetailISI6NM,CheckDetailI6DEF,CheckDetailFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CheckDetailKY7
             PREPARE           CheckDetailFL7,CheckDetailTXTNM,CheckDetailISI7NM,CheckDetailI7DEF,CheckDetailFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CheckDetailKY8
             PREPARE           CheckDetailFL8,CheckDetailTXTNM,CheckDetailISI8NM,CheckDetailI8DEF,CheckDetailFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CheckDetailKY9
             PREPARE           CheckDetailFL9,CheckDetailTXTNM,CheckDetailISI9NM,CheckDetailI9DEF,CheckDetailFSIZE,EXCLUSIVE
           %ENDIF
           RETURN

.
. Opening of Check Register Transaction File
.
OPENCheckDetail
           GETFILE           CheckDetailFL
           RETURN            IF ZERO
           OPEN              CheckDetailFLST,SHARE,LOCKMANUAL,SINGLE,NOWAIT
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

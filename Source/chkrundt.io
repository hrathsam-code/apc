;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    4 NORFOLK LANE                                           ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    ChkRunDT.IO                                                    ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    06/01/2005 AT 10:55AM                                          ;
;                                                                             ;
;  PURPOSE:    Check Run Detail I/O Routines                                  ;
;                                                                             ;
; REVISION:    VER     DATE     INIT       DETAILS                            ;
;                                                                             ;
;              1.0   02/28/2005   HOR     INITIAL VERSION                     ;
;                                                                             ;
;=============================================================================;
.
           %IFNDEF           $CheckRunDetailVAR
             INCLUDE           CheckRunDetailER.FD
           %ENDIF
.
           %IFNDEF           $CheckRunDetailIO
$CheckRunDetailIO    EQUATE            1
.
. Test Read for PRIMARY Index
.
TSTCheckRunDetail
           READ              CheckRunDetailFL,CheckRunDetailKY;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCheckRunDetail
           READ              CheckRunDetailFL,CheckRunDetailKY;CheckRunDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCheckRunDetailLK
           READLK            CheckRunDetailFL,CheckRunDetailKY;CheckRunDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCheckRunDetail
           READKS            CheckRunDetailFL;CheckRunDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCheckRunDetailLK

           READKSLK          CheckRunDetailFL;CheckRunDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCheckRunDetail
          READKP             CheckRunDetailFL;CheckRunDetail
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCheckRunDetailLK

           READKPLK          CheckRunDetailFL;CheckRunDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.=============================================================================
. Secondary file I/O operations
.
           %IFDEF            CheckRunDetailKY2
TSTCheckRunDetail2
           READ              CheckRunDetailFL2,CheckRunDetailKY2;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCheckRunDetail2
           READ              CheckRunDetailFL2,CheckRunDetailKY2;CheckRunDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCheckRunDetail2LK
           READLK            CheckRunDetailFL2,CheckRunDetailKY2;CheckRunDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCheckRunDetail2
           READKS            CheckRunDetailFL2;CheckRunDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCheckRunDetail2LK

           READKSLK          CheckRunDetailFL2;CheckRunDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCheckRunDetail2
          READKP             CheckRunDetailFL2;CheckRunDetail
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCheckRunDetail2LK
           READKPLK          CheckRunDetailFL2;CheckRunDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Third file I/O operations
.
           %IFDEF            CheckRunDetailKY3
.
TSTCheckRunDetail3
           READ              CheckRunDetailFL3,CheckRunDetailKY3;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCheckRunDetail3
           READ              CheckRunDetailFL3,CheckRunDetailKY3;CheckRunDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCheckRunDetail3LK
           READLK            CheckRunDetailFL3,CheckRunDetailKY3;CheckRunDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCheckRunDetail3
           READKS            CheckRunDetailFL3;CheckRunDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCheckRunDetail3LK

           READKSLK          CheckRunDetailFL3;CheckRunDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCheckRunDetail3
          READKP             CheckRunDetailFL3;CheckRunDetail
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCheckRunDetail3LK

           READKPLK          CheckRunDetailFL3;CheckRunDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fourth file I/O operations
.
           %IFDEF            CheckRunDetailKY4
.
TSTCheckRunDetail4
           READ              CheckRunDetailFL4,CheckRunDetailKY4;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCheckRunDetail4
           READ              CheckRunDetailFL4,CheckRunDetailKY4;CheckRunDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCheckRunDetail4LK
           READLK            CheckRunDetailFL4,CheckRunDetailKY4;CheckRunDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCheckRunDetail4
           READKS            CheckRunDetailFL4;CheckRunDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCheckRunDetail4LK

           READKSLK          CheckRunDetailFL4;CheckRunDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCheckRunDetail4
          READKP             CheckRunDetailFL4;CheckRunDetail
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCheckRunDetail4LK

           READKPLK          CheckRunDetailFL4;CheckRunDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fifth file I/O operations
.
           %IFDEF            CheckRunDetailKY5
.
TSTCheckRunDetail5
           READ              CheckRunDetailFL5,CheckRunDetailKY5;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCheckRunDetail5
           READ              CheckRunDetailFL5,CheckRunDetailKY5;CheckRunDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCheckRunDetail5LK
           READLK            CheckRunDetailFL5,CheckRunDetailKY5;CheckRunDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCheckRunDetail5
           READKS            CheckRunDetailFL5;CheckRunDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCheckRunDetail5LK

           READKSLK          CheckRunDetailFL5;CheckRunDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCheckRunDetail5
          READKP             CheckRunDetailFL5;CheckRunDetail
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCheckRunDetail5LK

           READKPLK          CheckRunDetailFL5;CheckRunDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Sixth file I/O operations
.
           %IFDEF            CheckRunDetailKY6
.
TSTCheckRunDetail6
           READ              CheckRunDetailFL6,CheckRunDetailKY6;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCheckRunDetail6
           READ              CheckRunDetailFL6,CheckRunDetailKY6;CheckRunDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCheckRunDetail6LK
           READLK            CheckRunDetailFL6,CheckRunDetailKY6;CheckRunDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCheckRunDetail6
           READKS            CheckRunDetailFL6;CheckRunDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCheckRunDetail6LK

           READKSLK          CheckRunDetailFL6;CheckRunDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCheckRunDetail6
          READKP             CheckRunDetailFL6;CheckRunDetail
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCheckRunDetail6LK

           READKPLK          CheckRunDetailFL6;CheckRunDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Seventh file I/O operations
.
           %IFDEF            CheckRunDetailKY7
.
TSTCheckRunDetail7
           READ              CheckRunDetailFL7,CheckRunDetailKY7;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCheckRunDetail7
           READ              CheckRunDetailFL7,CheckRunDetailKY7;CheckRunDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCheckRunDetail7LK
           READLK            CheckRunDetailFL7,CheckRunDetailKY7;CheckRunDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCheckRunDetail7
           READKS            CheckRunDetailFL7;CheckRunDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCheckRunDetail7LK

           READKSLK          CheckRunDetailFL7;CheckRunDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCheckRunDetail7
          READKP             CheckRunDetailFL7;CheckRunDetail
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCheckRunDetail7LK

           READKPLK          CheckRunDetailFL7;CheckRunDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Eighth file I/O operations
.
           %IFDEF            CheckRunDetailKY8
.
TSTCheckRunDetail8
           READ              CheckRunDetailFL8,CheckRunDetailKY8;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCheckRunDetail8
           READ              CheckRunDetailFL8,CheckRunDetailKY8;CheckRunDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCheckRunDetail8LK
           READLK            CheckRunDetailFL8,CheckRunDetailKY8;CheckRunDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCheckRunDetail8
           READKS            CheckRunDetailFL8;CheckRunDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCheckRunDetail8LK

           READKSLK          CheckRunDetailFL8;CheckRunDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCheckRunDetail8
          READKP             CheckRunDetailFL8;CheckRunDetail
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCheckRunDetail8LK

           READKPLK          CheckRunDetailFL8;CheckRunDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Ninth file I/O operations
.
           %IFDEF            CheckRunDetailKY9
.
. Third set of File I/O operations
.
TSTCheckRunDetail9
           READ              CheckRunDetailFL9,CheckRunDetailKY9;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCheckRunDetail9
           READ              CheckRunDetailFL9,CheckRunDetailKY9;CheckRunDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCheckRunDetail9LK
           READLK            CheckRunDetailFL9,CheckRunDetailKY9;CheckRunDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCheckRunDetail9
           READKS            CheckRunDetailFL9;CheckRunDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCheckRunDetail9LK

           READKSLK          CheckRunDetailFL9;CheckRunDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCheckRunDetail9
          READKP             CheckRunDetailFL9;CheckRunDetail
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCheckRunDetail9LK

           READKPLK          CheckRunDetailFL9;CheckRunDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.
.=============================================================================
.
. Deletion for PRIMARY Index
.
DELCheckRunDetail
..           READ              CheckRunDetailFL,CheckRunDetailKY;;
..           GOTO              #ERROR IF OVER
DELCheckRunDetailLK
           DELETE            CheckRunDetailFLST
           GOTO              #VALID
.
. Update I/O operation
.
UPDCheckRunDetail
.           READ              CheckRunDetailFL,CheckRunDetailKY;;
.           GOTO              #ERROR IF OVER
UPDCheckRunDetailLK
           UPDATE            CheckRunDetailFLST;CheckRunDetail
           GOTO              #VALID
.
. Write I/O operation
.
WRTCheckRunDetail
           WRITE             CheckRunDetailFLST;CheckRunDetail
           GOTO              #VALID
.
. Preparation of CheckRunDetailer Transaction Files
.
PREPCheckRunDetail
           %IFDEF            CheckRunDetailKY
             PREPARE           CheckRunDetailFL,CheckRunDetailTXTNM,CheckRunDetailISI1NM,CheckRunDetailI1DEF,CheckRunDetailFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CheckRunDetailKY2
             PREPARE           CheckRunDetailFL2,CheckRunDetailTXTNM,CheckRunDetailISI2NM,CheckRunDetailI2DEF,CheckRunDetailFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CheckRunDetailKY3
             PREPARE           CheckRunDetailFL3,CheckRunDetailTXTNM,CheckRunDetailISI3NM,CheckRunDetailI3DEF,CheckRunDetailFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CheckRunDetailKY4
             PREPARE           CheckRunDetailFL4,CheckRunDetailTXTNM,CheckRunDetailISI4NM,CheckRunDetailI4DEF,CheckRunDetailFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CheckRunDetailKY5
             PREPARE           CheckRunDetailFL5,CheckRunDetailTXTNM,CheckRunDetailISI5NM,CheckRunDetailI5DEF,CheckRunDetailFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CheckRunDetailKY6
             PREPARE           CheckRunDetailFL6,CheckRunDetailTXTNM,CheckRunDetailISI6NM,CheckRunDetailI6DEF,CheckRunDetailFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CheckRunDetailKY7
             PREPARE           CheckRunDetailFL7,CheckRunDetailTXTNM,CheckRunDetailISI7NM,CheckRunDetailI7DEF,CheckRunDetailFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CheckRunDetailKY8
             PREPARE           CheckRunDetailFL8,CheckRunDetailTXTNM,CheckRunDetailISI8NM,CheckRunDetailI8DEF,CheckRunDetailFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CheckRunDetailKY9
             PREPARE           CheckRunDetailFL9,CheckRunDetailTXTNM,CheckRunDetailISI9NM,CheckRunDetailI9DEF,CheckRunDetailFSIZE,EXCLUSIVE
           %ENDIF
           RETURN

.
. Opening of Check Register Transaction File
.
OPENCheckRunDetail
           GETFILE           CheckRunDetailFL
           RETURN            IF ZERO
           OPEN              CheckRunDetailFLST,SHARE,LOCKMANUAL,SINGLE,NOWAIT
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

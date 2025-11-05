;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    4 NORFOLK LANE                                           ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    ARDist.IO                                                      ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    02/28/2005 AT 10:55PM                                          ;
;                                                                             ;
;  PURPOSE:    Accounts Receivable GL Distribution I/O Routines               ;
;                                                                             ;
; REVISION:    VER     DATE     INIT       DETAILS                            ;
;                                                                             ;
;              1.0   02/28/2005   HOR     INITIAL VERSION                     ;
;                                                                             ;
;=============================================================================;
.
           %IFNDEF           $ARDistVAR
             INCLUDE           ARDistER.FD
           %ENDIF
.
           %IFNDEF           $ARDistIO
$ARDistIO    EQUATE            1
.
. Test Read for PRIMARY Index
.
TSTARDist
           READ              ARDistFL,ARDistKY;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDARDist
           READ              ARDistFL,ARDistKY;ARDist
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDARDistLK
           READLK            ARDistFL,ARDistKY;ARDist
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSARDist
           READKS            ARDistFL;ARDist
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSARDistLK

           READKSLK          ARDistFL;ARDist
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPARDist
          READKP             ARDistFL;ARDist
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPARDistLK

           READKPLK          ARDistFL;ARDist
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.=============================================================================
. Secondary file I/O operations
.
           %IFDEF            ARDistKY2
TSTARDist2
           READ              ARDistFL2,ARDistKY2;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDARDist2
           READ              ARDistFL2,ARDistKY2;ARDist
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDARDist2LK
           READLK            ARDistFL2,ARDistKY2;ARDist
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSARDist2
           READKS            ARDistFL2;ARDist
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSARDist2LK

           READKSLK          ARDistFL2;ARDist
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPARDist2
          READKP             ARDistFL2;ARDist
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPARDist2LK
           READKPLK          ARDistFL2;ARDist
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Third file I/O operations
.
           %IFDEF            ARDistKY3
.
TSTARDist3
           READ              ARDistFL3,ARDistKY3;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDARDist3
           READ              ARDistFL3,ARDistKY3;ARDist
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDARDist3LK
           READLK            ARDistFL3,ARDistKY3;ARDist
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSARDist3
           READKS            ARDistFL3;ARDist
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSARDist3LK

           READKSLK          ARDistFL3;ARDist
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPARDist3
          READKP             ARDistFL3;ARDist
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPARDist3LK

           READKPLK          ARDistFL3;ARDist
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fourth file I/O operations
.
           %IFDEF            ARDistKY4
.
TSTARDist4
           READ              ARDistFL4,ARDistKY4;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDARDist4
           READ              ARDistFL4,ARDistKY4;ARDist
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDARDist4LK
           READLK            ARDistFL4,ARDistKY4;ARDist
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSARDist4
           READKS            ARDistFL4;ARDist
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSARDist4LK

           READKSLK          ARDistFL4;ARDist
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPARDist4
          READKP             ARDistFL4;ARDist
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPARDist4LK

           READKPLK          ARDistFL4;ARDist
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fifth file I/O operations
.
           %IFDEF            ARDistKY5
.
TSTARDist5
           READ              ARDistFL5,ARDistKY5;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDARDist5
           READ              ARDistFL5,ARDistKY5;ARDist
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDARDist5LK
           READLK            ARDistFL5,ARDistKY5;ARDist
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSARDist5
           READKS            ARDistFL5;ARDist
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSARDist5LK

           READKSLK          ARDistFL5;ARDist
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPARDist5
          READKP             ARDistFL5;ARDist
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPARDist5LK

           READKPLK          ARDistFL5;ARDist
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Sixth file I/O operations
.
           %IFDEF            ARDistKY6
.
TSTARDist6
           READ              ARDistFL6,ARDistKY6;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDARDist6
           READ              ARDistFL6,ARDistKY6;ARDist
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDARDist6LK
           READLK            ARDistFL6,ARDistKY6;ARDist
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSARDist6
           READKS            ARDistFL6;ARDist
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSARDist6LK

           READKSLK          ARDistFL6;ARDist
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPARDist6
          READKP             ARDistFL6;ARDist
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPARDist6LK

           READKPLK          ARDistFL6;ARDist
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Seventh file I/O operations
.
           %IFDEF            ARDistKY7
.
TSTARDist7
           READ              ARDistFL7,ARDistKY7;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDARDist7
           READ              ARDistFL7,ARDistKY7;ARDist
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDARDist7LK
           READLK            ARDistFL7,ARDistKY7;ARDist
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSARDist7
           READKS            ARDistFL7;ARDist
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSARDist7LK

           READKSLK          ARDistFL7;ARDist
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPARDist7
          READKP             ARDistFL7;ARDist
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPARDist7LK

           READKPLK          ARDistFL7;ARDist
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Eighth file I/O operations
.
           %IFDEF            ARDistKY8
.
TSTARDist8
           READ              ARDistFL8,ARDistKY8;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDARDist8
           READ              ARDistFL8,ARDistKY8;ARDist
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDARDist8LK
           READLK            ARDistFL8,ARDistKY8;ARDist
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSARDist8
           READKS            ARDistFL8;ARDist
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSARDist8LK

           READKSLK          ARDistFL8;ARDist
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPARDist8
          READKP             ARDistFL8;ARDist
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPARDist8LK

           READKPLK          ARDistFL8;ARDist
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Ninth file I/O operations
.
           %IFDEF            ARDistKY9
.
. Third set of File I/O operations
.
TSTARDist9
           READ              ARDistFL9,ARDistKY9;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDARDist9
           READ              ARDistFL9,ARDistKY9;ARDist
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDARDist9LK
           READLK            ARDistFL9,ARDistKY9;ARDist
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSARDist9
           READKS            ARDistFL9;ARDist
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSARDist9LK

           READKSLK          ARDistFL9;ARDist
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPARDist9
          READKP             ARDistFL9;ARDist
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPARDist9LK

           READKPLK          ARDistFL9;ARDist
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.
.=============================================================================
.
. Deletion for PRIMARY Index
.
DELARDist
           READ              ARDistFL,ARDistKY;;
           GOTO              #ERROR IF OVER
DELARDistLK
           DELETE            ARDistFLST
           GOTO              #VALID
.
. Update I/O operation
.
UPDARDist
.           READ              ARDistFL,ARDistKY;;
.           GOTO              #ERROR IF OVER
UPDARDistLK
           UPDATE            ARDistFLST;ARDist
           GOTO              #VALID
.
. Write I/O operation
.
WRTARDist
           WRITE             ARDistFLST;ARDist
           GOTO              #VALID
.
. Preparation of ARDister Transaction Files
.
PREPARDist
           %IFDEF            ARDistKY
             PREPARE           ARDistFL,ARDistTXTNM,ARDistISI1NM,ARDistI1DEF,ARDistFileSize,EXCLUSIVE
           %ENDIF
           %IFDEF            ARDistKY2
             PREPARE           ARDistFL2,ARDistTXTNM,ARDistISI2NM,ARDistI2DEF,ARDistFileSize,EXCLUSIVE
           %ENDIF
           %IFDEF            ARDistKY3
             PREPARE           ARDistFL3,ARDistTXTNM,ARDistISI3NM,ARDistI3DEF,ARDistFileSize,EXCLUSIVE
           %ENDIF
           %IFDEF            ARDistKY4
             PREPARE           ARDistFL4,ARDistTXTNM,ARDistISI4NM,ARDistI4DEF,ARDistFileSize,EXCLUSIVE
           %ENDIF
           %IFDEF            ARDistKY5
             PREPARE           ARDistFL5,ARDistTXTNM,ARDistISI5NM,ARDistI5DEF,ARDistFileSize,EXCLUSIVE
           %ENDIF
           %IFDEF            ARDistKY6
             PREPARE           ARDistFL6,ARDistTXTNM,ARDistISI6NM,ARDistI6DEF,ARDistFileSize,EXCLUSIVE
           %ENDIF
           %IFDEF            ARDistKY7
             PREPARE           ARDistFL7,ARDistTXTNM,ARDistISI7NM,ARDistI7DEF,ARDistFileSize,EXCLUSIVE
           %ENDIF
           %IFDEF            ARDistKY8
             PREPARE           ARDistFL8,ARDistTXTNM,ARDistISI8NM,ARDistI8DEF,ARDistFileSize,EXCLUSIVE
           %ENDIF
           %IFDEF            ARDistKY9
             PREPARE           ARDistFL9,ARDistTXTNM,ARDistISI9NM,ARDistI9DEF,ARDistFileSize,EXCLUSIVE
           %ENDIF
           RETURN

.
. Opening of Check Register Transaction File
.
OPENARDist
           GETFILE           ARDistFL
           RETURN            IF ZERO
           OPEN              ARDistFLST,SHARE,LOCKMANUAL,SINGLE,NOWAIT
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

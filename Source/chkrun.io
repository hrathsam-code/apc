;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    4 NORFOLK LANE                                           ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    ChkRun.IO                                                      ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    07/14/2005 AT 1:55PM                                          ;
;                                                                             ;
;  PURPOSE:    Check Run file I/O Routines                                    ;
;                                                                             ;
; REVISION:    VER     DATE     INIT       DETAILS                            ;
;                                                                             ;
;              1.0   02/28/2005   HOR     INITIAL VERSION                     ;
;                                                                             ;
;=============================================================================;
.
.
           %IFNDEF           $CheckRunVAR
             INCLUDE           CheckRun.FD
           %ENDIF
.
           %IFNDEF           $CheckRunIO
$CheckRunIO    EQUATE            1
.
. Test Read for PRIMARY Index
.
TSTCheckRun
           READ              CheckRunFL,CheckRunKY;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCheckRun
           READ              CheckRunFL,CheckRunKY;CheckRun
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCheckRunLK
           READLK            CheckRunFL,CheckRunKY;CheckRun
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCheckRun
           READKS            CheckRunFL;CheckRun
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCheckRunLK

           READKSLK          CheckRunFL;CheckRun
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCheckRun
          READKP             CheckRunFL;CheckRun
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCheckRunLK

           READKPLK          CheckRunFL;CheckRun
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.=============================================================================
. Secondary file I/O operations
.
           %IFDEF            CheckRunKY2
TSTCheckRun2
           READ              CheckRunFL2,CheckRunKY2;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCheckRun2
           READ              CheckRunFL2,CheckRunKY2;CheckRun
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCheckRun2LK
           READLK            CheckRunFL2,CheckRunKY2;CheckRun
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCheckRun2
           READKS            CheckRunFL2;CheckRun
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCheckRun2LK

           READKSLK          CheckRunFL2;CheckRun
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCheckRun2
          READKP             CheckRunFL2;CheckRun
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCheckRun2LK
           READKPLK          CheckRunFL2;CheckRun
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Third file I/O operations
.
           %IFDEF            CheckRunKY3
.
TSTCheckRun3
           READ              CheckRunFL3,CheckRunKY3;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCheckRun3
           READ              CheckRunFL3,CheckRunKY3;CheckRun
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCheckRun3LK
           READLK            CheckRunFL3,CheckRunKY3;CheckRun
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCheckRun3
           READKS            CheckRunFL3;CheckRun
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCheckRun3LK

           READKSLK          CheckRunFL3;CheckRun
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCheckRun3
          READKP             CheckRunFL3;CheckRun
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCheckRun3LK

           READKPLK          CheckRunFL3;CheckRun
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fourth file I/O operations
.
           %IFDEF            CheckRunKY4
.
TSTCheckRun4
           READ              CheckRunFL4,CheckRunKY4;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCheckRun4
           READ              CheckRunFL4,CheckRunKY4;CheckRun
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCheckRun4LK
           READLK            CheckRunFL4,CheckRunKY4;CheckRun
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCheckRun4
           READKS            CheckRunFL4;CheckRun
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCheckRun4LK

           READKSLK          CheckRunFL4;CheckRun
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCheckRun4
          READKP             CheckRunFL4;CheckRun
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCheckRun4LK

           READKPLK          CheckRunFL4;CheckRun
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fifth file I/O operations
.
           %IFDEF            CheckRunKY5
.
TSTCheckRun5
           READ              CheckRunFL5,CheckRunKY5;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCheckRun5
           READ              CheckRunFL5,CheckRunKY5;CheckRun
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCheckRun5LK
           READLK            CheckRunFL5,CheckRunKY5;CheckRun
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCheckRun5
           READKS            CheckRunFL5;CheckRun
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCheckRun5LK

           READKSLK          CheckRunFL5;CheckRun
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCheckRun5
          READKP             CheckRunFL5;CheckRun
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCheckRun5LK

           READKPLK          CheckRunFL5;CheckRun
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Sixth file I/O operations
.
           %IFDEF            CheckRunKY6
.
TSTCheckRun6
           READ              CheckRunFL6,CheckRunKY6;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCheckRun6
           READ              CheckRunFL6,CheckRunKY6;CheckRun
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCheckRun6LK
           READLK            CheckRunFL6,CheckRunKY6;CheckRun
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCheckRun6
           READKS            CheckRunFL6;CheckRun
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCheckRun6LK

           READKSLK          CheckRunFL6;CheckRun
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCheckRun6
          READKP             CheckRunFL6;CheckRun
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCheckRun6LK

           READKPLK          CheckRunFL6;CheckRun
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Seventh file I/O operations
.
           %IFDEF            CheckRunKY7
.
TSTCheckRun7
           READ              CheckRunFL7,CheckRunKY7;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCheckRun7
           READ              CheckRunFL7,CheckRunKY7;CheckRun
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCheckRun7LK
           READLK            CheckRunFL7,CheckRunKY7;CheckRun
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCheckRun7
           READKS            CheckRunFL7;CheckRun
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCheckRun7LK

           READKSLK          CheckRunFL7;CheckRun
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCheckRun7
          READKP             CheckRunFL7;CheckRun
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCheckRun7LK

           READKPLK          CheckRunFL7;CheckRun
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Eighth file I/O operations
.
           %IFDEF            CheckRunKY8
.
TSTCheckRun8
           READ              CheckRunFL8,CheckRunKY8;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCheckRun8
           READ              CheckRunFL8,CheckRunKY8;CheckRun
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCheckRun8LK
           READLK            CheckRunFL8,CheckRunKY8;CheckRun
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCheckRun8
           READKS            CheckRunFL8;CheckRun
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCheckRun8LK

           READKSLK          CheckRunFL8;CheckRun
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCheckRun8
          READKP             CheckRunFL8;CheckRun
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCheckRun8LK

           READKPLK          CheckRunFL8;CheckRun
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Ninth file I/O operations
.
           %IFDEF            CheckRunKY9
.
. Third set of File I/O operations
.
TSTCheckRun9
           READ              CheckRunFL9,CheckRunKY9;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCheckRun9
           READ              CheckRunFL9,CheckRunKY9;CheckRun
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCheckRun9LK
           READLK            CheckRunFL9,CheckRunKY9;CheckRun
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCheckRun9
           READKS            CheckRunFL9;CheckRun
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCheckRun9LK

           READKSLK          CheckRunFL9;CheckRun
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCheckRun9
          READKP             CheckRunFL9;CheckRun
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCheckRun9LK

           READKPLK          CheckRunFL9;CheckRun
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.
.=============================================================================
.
. Deletion for PRIMARY Index
.
DELCheckRun
.           READ              CheckRunFL,CheckRunKY;;
.           GOTO              #ERROR IF OVER
DELCheckRunLK
           DELETE            CheckRunFLST
           GOTO              #VALID
.
. Update I/O operation
.
UPDCheckRun
.           READ              CheckRunFL,CheckRunKY;;
.           GOTO              #ERROR IF OVER
UPDCheckRunLK
           UPDATE            CheckRunFLST;CheckRun
           GOTO              #VALID
.
. Write I/O operation
.
WRTCheckRun
           WRITE             CheckRunFLST;CheckRun
           GOTO              #VALID
.
. Preparation of CheckRuner Transaction Files
.
PREPCheckRun
           %IFDEF            CheckRunKY
             PREPARE           CheckRunFL,CheckRunTXTNM,CheckRunISI1NM,CheckRunI1DEF,CheckRunFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CheckRunKY2
             PREPARE           CheckRunFL2,CheckRunTXTNM,CheckRunISI2NM,CheckRunI2DEF,CheckRunFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CheckRunKY3
             PREPARE           CheckRunFL3,CheckRunTXTNM,CheckRunISI3NM,CheckRunI3DEF,CheckRunFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CheckRunKY4
             PREPARE           CheckRunFL4,CheckRunTXTNM,CheckRunISI4NM,CheckRunI4DEF,CheckRunFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CheckRunKY5
             PREPARE           CheckRunFL5,CheckRunTXTNM,CheckRunISI5NM,CheckRunI5DEF,CheckRunFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CheckRunKY6
             PREPARE           CheckRunFL6,CheckRunTXTNM,CheckRunISI6NM,CheckRunI6DEF,CheckRunFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CheckRunKY7
             PREPARE           CheckRunFL7,CheckRunTXTNM,CheckRunISI7NM,CheckRunI7DEF,CheckRunFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CheckRunKY8
             PREPARE           CheckRunFL8,CheckRunTXTNM,CheckRunISI8NM,CheckRunI8DEF,CheckRunFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CheckRunKY9
             PREPARE           CheckRunFL9,CheckRunTXTNM,CheckRunISI9NM,CheckRunI9DEF,CheckRunFSIZE,EXCLUSIVE
           %ENDIF
           RETURN

.
. Opening of CheckRun Register Transaction File
.
OPENCheckRun
           GETFILE           CheckRunFL
           RETURN            IF ZERO
           OPEN              CheckRunFLST,SHARE,LOCKMANUAL,SINGLE,NOWAIT
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

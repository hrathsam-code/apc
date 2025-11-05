......................................................................
.    Chiron Software & Services, Inc.
.    4 Norfolk Lane
.    Bethpage, Ny  11714
.    (516) 935-0196
.
.
. Program Created On : 02/15/02 At 3:00:am
.
           %IFNDEF           $GLMastVAR
             INCLUDE           GLMastER.FD
           %ENDIF
.
           %IFNDEF           $GLMastIO
$GLMastIO    EQUATE            1
.
. Test Read for PRIMARY Index
.
TSTGLMast
           READ              GLMastFL,GLMastKY;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDGLMast
           READ              GLMastFL,GLMastKY;GLMast
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDGLMastLK
           READLK            GLMastFL,GLMastKY;GLMast
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSGLMast
           READKS            GLMastFL;GLMast
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSGLMastLK

           READKSLK          GLMastFL;GLMast
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPGLMast
          READKP             GLMastFL;GLMast
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPGLMastLK

           READKPLK          GLMastFL;GLMast
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.=============================================================================
. Secondary file I/O operations
.
           %IFDEF            GLMastKY2
TSTGLMast2
           READ              GLMastFL2,GLMastKY2;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDGLMast2
           READ              GLMastFL2,GLMastKY2;GLMast
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDGLMast2LK
           READLK            GLMastFL2,GLMastKY2;GLMast
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSGLMast2
           READKS            GLMastFL2;GLMast
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSGLMast2LK

           READKSLK          GLMastFL2;GLMast
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPGLMast2
          READKP             GLMastFL2;GLMast
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPGLMast2LK
           READKPLK          GLMastFL2;GLMast
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Third file I/O operations
.
           %IFDEF            GLMastKY3
.
TSTGLMast3
           READ              GLMastFL3,GLMastKY3;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDGLMast3
           READ              GLMastFL3,GLMastKY3;GLMast
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDGLMast3LK
           READLK            GLMastFL3,GLMastKY3;GLMast
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSGLMast3
           READKS            GLMastFL3;GLMast
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSGLMast3LK

           READKSLK          GLMastFL3;GLMast
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPGLMast3
          READKP             GLMastFL3;GLMast
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPGLMast3LK

           READKPLK          GLMastFL3;GLMast
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fourth file I/O operations
.
           %IFDEF            GLMastKY4
.
TSTGLMast4
           READ              GLMastFL4,GLMastKY4;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDGLMast4
           READ              GLMastFL4,GLMastKY4;GLMast
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDGLMast4LK
           READLK            GLMastFL4,GLMastKY4;GLMast
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSGLMast4
           READKS            GLMastFL4;GLMast
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSGLMast4LK

           READKSLK          GLMastFL4;GLMast
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPGLMast4
          READKP             GLMastFL4;GLMast
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPGLMast4LK

           READKPLK          GLMastFL4;GLMast
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fifth file I/O operations
.
           %IFDEF            GLMastKY5
.
TSTGLMast5
           READ              GLMastFL5,GLMastKY5;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDGLMast5
           READ              GLMastFL5,GLMastKY5;GLMast
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDGLMast5LK
           READLK            GLMastFL5,GLMastKY5;GLMast
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSGLMast5
           READKS            GLMastFL5;GLMast
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSGLMast5LK

           READKSLK          GLMastFL5;GLMast
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPGLMast5
          READKP             GLMastFL5;GLMast
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPGLMast5LK

           READKPLK          GLMastFL5;GLMast
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Sixth file I/O operations
.
           %IFDEF            GLMastKY6
.
TSTGLMast6
           READ              GLMastFL6,GLMastKY6;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDGLMast6
           READ              GLMastFL6,GLMastKY6;GLMast
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDGLMast6LK
           READLK            GLMastFL6,GLMastKY6;GLMast
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSGLMast6
           READKS            GLMastFL6;GLMast
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSGLMast6LK

           READKSLK          GLMastFL6;GLMast
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPGLMast6
          READKP             GLMastFL6;GLMast
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPGLMast6LK

           READKPLK          GLMastFL6;GLMast
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Seventh file I/O operations
.
           %IFDEF            GLMastKY7
.
TSTGLMast7
           READ              GLMastFL7,GLMastKY7;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDGLMast7
           READ              GLMastFL7,GLMastKY7;GLMast
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDGLMast7LK
           READLK            GLMastFL7,GLMastKY7;GLMast
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSGLMast7
           READKS            GLMastFL7;GLMast
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSGLMast7LK

           READKSLK          GLMastFL7;GLMast
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPGLMast7
          READKP             GLMastFL7;GLMast
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPGLMast7LK

           READKPLK          GLMastFL7;GLMast
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Eighth file I/O operations
.
           %IFDEF            GLMastKY8
.
TSTGLMast8
           READ              GLMastFL8,GLMastKY8;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDGLMast8
           READ              GLMastFL8,GLMastKY8;GLMast
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDGLMast8LK
           READLK            GLMastFL8,GLMastKY8;GLMast
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSGLMast8
           READKS            GLMastFL8;GLMast
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSGLMast8LK

           READKSLK          GLMastFL8;GLMast
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPGLMast8
          READKP             GLMastFL8;GLMast
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPGLMast8LK

           READKPLK          GLMastFL8;GLMast
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Ninth file I/O operations
.
           %IFDEF            GLMastKY9
.
. Third set of File I/O operations
.
TSTGLMast9
           READ              GLMastFL9,GLMastKY9;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDGLMast9
           READ              GLMastFL9,GLMastKY9;GLMast
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDGLMast9LK
           READLK            GLMastFL9,GLMastKY9;GLMast
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSGLMast9
           READKS            GLMastFL9;GLMast
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSGLMast9LK

           READKSLK          GLMastFL9;GLMast
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPGLMast9
          READKP             GLMastFL9;GLMast
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPGLMast9LK

           READKPLK          GLMastFL9;GLMast
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.
.=============================================================================
.
. Deletion for PRIMARY Index
.
DELGLMast
           READ              GLMastFL,GLMastKY;;
           GOTO              #ERROR IF OVER
DELGLMastLK
           DELETE            GLMastFLST
           GOTO              #VALID
.
. Update I/O operation
.
UPDGLMast
.           READ              GLMastFL,GLMastKY;;
.           GOTO              #ERROR IF OVER
UPDGLMastLK
           UPDATE            GLMastFLST;GLMast
           GOTO              #VALID
.
. Write I/O operation
.
WRTGLMast
           WRITE             GLMastFLST;GLMast
           GOTO              #VALID
.
. Preparation of GLMaster Transaction Files
.
PREPGLMast
           %IFDEF            GLMastKY
             PREPARE           GLMastFL,GLMastTXTNM,GLMastISI1NM,GLMastI1DEF,GLMastFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            GLMastKY2
             PREPARE           GLMastFL2,GLMastTXTNM,GLMastISI2NM,GLMastI2DEF,GLMastFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            GLMastKY3
             PREPARE           GLMastFL3,GLMastTXTNM,GLMastISI3NM,GLMastI3DEF,GLMastFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            GLMastKY4
             PREPARE           GLMastFL4,GLMastTXTNM,GLMastISI4NM,GLMastI4DEF,GLMastFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            GLMastKY5
             PREPARE           GLMastFL5,GLMastTXTNM,GLMastISI5NM,GLMastI5DEF,GLMastFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            GLMastKY6
             PREPARE           GLMastFL6,GLMastTXTNM,GLMastISI6NM,GLMastI6DEF,GLMastFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            GLMastKY7
             PREPARE           GLMastFL7,GLMastTXTNM,GLMastISI7NM,GLMastI7DEF,GLMastFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            GLMastKY8
             PREPARE           GLMastFL8,GLMastTXTNM,GLMastISI8NM,GLMastI8DEF,GLMastFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            GLMastKY9
             PREPARE           GLMastFL9,GLMastTXTNM,GLMastISI9NM,GLMastI9DEF,GLMastFSIZE,EXCLUSIVE
           %ENDIF
           RETURN

.
. Opening of Check Register Transaction File
.
OPENGLMast
           GETFILE           GLMastFL
           RETURN            IF ZERO
           OPEN              GLMastFLST,SHARE,LOCKMANUAL,SINGLE,NOWAIT
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

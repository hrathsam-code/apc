......................................................................
.    Chiron Software & Services, Inc.
.    4 Norfolk Lane
.    Bethpage, Ny  11714
.    (516) 935-0196
.
.
. Program Created On : 02/15/02 At 3:00:am
.

           %IFNDEF           $ARDepVAR
             INCLUDE           ARDep.FD
           %ENDIF
.
           %IFNDEF           $ARDepIO
$ARDepIO    EQUATE            1
.
. Test Read for PRIMARY Index
.
TSTARDep
           READ              ARDepFL,ARDepKY;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDARDep
           READ              ARDepFL,ARDepKY;ARDepREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDARDepLK
           READLK            ARDepFL,ARDepKY;ARDepREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSARDep
           READKS            ARDepFL;ARDepREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSARDepLK

           READKSLK          ARDepFL;ARDepREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPARDep
          READKP             ARDepFL;ARDepREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPARDepLK

           READKPLK          ARDepFL;ARDepREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.=============================================================================
. Secondary file I/O operations
.
           %IFDEF            ARDepKY2
TSTARDep2
           READ              ARDepFL2,ARDepKY2;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDARDep2
           READ              ARDepFL2,ARDepKY2;ARDepREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDARDep2LK
           READLK            ARDepFL2,ARDepKY2;ARDepREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSARDep2
           READKS            ARDepFL2;ARDepREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSARDep2LK

           READKSLK          ARDepFL2;ARDepREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPARDep2
          READKP             ARDepFL2;ARDepREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPARDep2LK
           READKPLK          ARDepFL2;ARDepREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Third file I/O operations
.
           %IFDEF            ARDepKY3
.
TSTARDep3
           READ              ARDepFL3,ARDepKY3;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDARDep3
           READ              ARDepFL3,ARDepKY3;ARDepREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDARDep3LK
           READLK            ARDepFL3,ARDepKY3;ARDepREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSARDep3
           READKS            ARDepFL3;ARDepREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSARDep3LK

           READKSLK          ARDepFL3;ARDepREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPARDep3
          READKP             ARDepFL3;ARDepREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPARDep3LK

           READKPLK          ARDepFL3;ARDepREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fourth file I/O operations
.
           %IFDEF            ARDepKY4
.
TSTARDep4
           READ              ARDepFL4,ARDepKY4;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDARDep4
           READ              ARDepFL4,ARDepKY4;ARDepREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDARDep4LK
           READLK            ARDepFL4,ARDepKY4;ARDepREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSARDep4
           READKS            ARDepFL4;ARDepREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSARDep4LK

           READKSLK          ARDepFL4;ARDepREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPARDep4
          READKP             ARDepFL4;ARDepREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPARDep4LK

           READKPLK          ARDepFL4;ARDepREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fifth file I/O operations
.
           %IFDEF            ARDepKY5
.
TSTARDep5
           READ              ARDepFL5,ARDepKY5;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDARDep5
           READ              ARDepFL5,ARDepKY5;ARDepREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDARDep5LK
           READLK            ARDepFL5,ARDepKY5;ARDepREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSARDep5
           READKS            ARDepFL5;ARDepREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSARDep5LK

           READKSLK          ARDepFL5;ARDepREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPARDep5
          READKP             ARDepFL5;ARDepREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPARDep5LK

           READKPLK          ARDepFL5;ARDepREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Sixth file I/O operations
.
           %IFDEF            ARDepKY6
.
TSTARDep6
           READ              ARDepFL6,ARDepKY6;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDARDep6
           READ              ARDepFL6,ARDepKY6;ARDepREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDARDep6LK
           READLK            ARDepFL6,ARDepKY6;ARDepREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSARDep6
           READKS            ARDepFL6;ARDepREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSARDep6LK

           READKSLK          ARDepFL6;ARDepREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPARDep6
          READKP             ARDepFL6;ARDepREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPARDep6LK

           READKPLK          ARDepFL6;ARDepREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Seventh file I/O operations
.
           %IFDEF            ARDepKY7
.
TSTARDep7
           READ              ARDepFL7,ARDepKY7;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDARDep7
           READ              ARDepFL7,ARDepKY7;ARDepREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDARDep7LK
           READLK            ARDepFL7,ARDepKY7;ARDepREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSARDep7
           READKS            ARDepFL7;ARDepREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSARDep7LK

           READKSLK          ARDepFL7;ARDepREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPARDep7
          READKP             ARDepFL7;ARDepREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPARDep7LK

           READKPLK          ARDepFL7;ARDepREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Eighth file I/O operations
.
           %IFDEF            ARDepKY8
.
TSTARDep8
           READ              ARDepFL8,ARDepKY8;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDARDep8
           READ              ARDepFL8,ARDepKY8;ARDepREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDARDep8LK
           READLK            ARDepFL8,ARDepKY8;ARDepREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSARDep8
           READKS            ARDepFL8;ARDepREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSARDep8LK

           READKSLK          ARDepFL8;ARDepREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPARDep8
          READKP             ARDepFL8;ARDepREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPARDep8LK

           READKPLK          ARDepFL8;ARDepREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Ninth file I/O operations
.
           %IFDEF            ARDepKY9
.
. Third set of File I/O operations
.
TSTARDep9
           READ              ARDepFL9,ARDepKY9;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDARDep9
           READ              ARDepFL9,ARDepKY9;ARDepREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDARDep9LK
           READLK            ARDepFL9,ARDepKY9;ARDepREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSARDep9
           READKS            ARDepFL9;ARDepREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSARDep9LK

           READKSLK          ARDepFL9;ARDepREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPARDep9
          READKP             ARDepFL9;ARDepREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPARDep9LK

           READKPLK          ARDepFL9;ARDepREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.
.=============================================================================
.
. Deletion for PRIMARY Index
.
DELARDep
           READ              ARDepFL,ARDepKY;;
           GOTO              #ERROR IF OVER
DELARDepLK
           DELETE            ARDepFLST
           GOTO              #VALID
.
. Update I/O operation
.
UPDARDep
.           READ              ARDepFL,ARDepKY;;
.           GOTO              #ERROR IF OVER
UPDARDepLK
           UPDATE            ARDepFLST;ARDepREC
           GOTO              #VALID
.
. Write I/O operation
.
WRTARDep
           WRITE             ARDepFLST;ARDepREC
           GOTO              #VALID
.
. Preparation of ARDeper Transaction Files
.
PREPARDep
           %IFDEF            ARDepKY
             PREPARE           ARDepFL,ARDepTXTNM,ARDepISI1NM,ARDepI1DEF,ARDepFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            ARDepKY2
             PREPARE           ARDepFL2,ARDepTXTNM,ARDepISI2NM,ARDepI2DEF,ARDepFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            ARDepKY3
             PREPARE           ARDepFL3,ARDepTXTNM,ARDepISI3NM,ARDepI3DEF,ARDepFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            ARDepKY4
             PREPARE           ARDepFL4,ARDepTXTNM,ARDepISI4NM,ARDepI4DEF,ARDepFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            ARDepKY5
             PREPARE           ARDepFL5,ARDepTXTNM,ARDepISI5NM,ARDepI5DEF,ARDepFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            ARDepKY6
             PREPARE           ARDepFL6,ARDepTXTNM,ARDepISI6NM,ARDepI6DEF,ARDepFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            ARDepKY7
             PREPARE           ARDepFL7,ARDepTXTNM,ARDepISI7NM,ARDepI7DEF,ARDepFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            ARDepKY8
             PREPARE           ARDepFL8,ARDepTXTNM,ARDepISI8NM,ARDepI8DEF,ARDepFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            ARDepKY9
             PREPARE           ARDepFL9,ARDepTXTNM,ARDepISI9NM,ARDepI9DEF,ARDepFSIZE,EXCLUSIVE
           %ENDIF
           RETURN

.
. Opening of Check Register Transaction File
.
OPENARDep
           GETFILE           ARDepFL
           RETURN            IF ZERO
           OPEN              ARDepFLST,SHARE,LOCKMANUAL,SINGLE,NOWAIT
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

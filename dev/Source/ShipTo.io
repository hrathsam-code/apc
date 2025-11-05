......................................................................
.    Chiron Software & Services, Inc.
.    4 Norfolk Lane
.    Bethpage, Ny  11714
.    (516) 935-0196
.
.
. Program Created On : 02/15/02 At 3:00:am
.
           %IFNDEF           $ShipTo
             INCLUDE           ShipTo.FD
           %ENDIF
.
           %IFNDEF           $ShipToIO
$ShipToIO    EQUATE            1
.
. Test Read for PRIMARY Index
.
TSTShipTo
           READ              ShipToFL,ShipToKY;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDShipTo
           READ              ShipToFL,ShipToKY;ShipTo
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDShipToLK
           READLK            ShipToFL,ShipToKY;ShipTo
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSShipTo
           READKS            ShipToFL;ShipTo
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSShipToLK

           READKSLK          ShipToFL;ShipTo
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPShipTo
          READKP             ShipToFL;ShipTo
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPShipToLK

           READKPLK          ShipToFL;ShipTo
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.=============================================================================
. Secondary file I/O operations
.
           %IFDEF            ShipTo2KY
TSTShipTo2
           READ              ShipTo2FL,ShipTo2KY;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDShipTo2
           READ              ShipTo2FL,ShipTo2KY;ShipTo
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDShipTo2LK
           READLK            ShipTo2FL,ShipTo2KY;ShipTo
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSShipTo2
           READKS            ShipTo2FL;ShipTo
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSShipTo2LK

           READKSLK          ShipTo2FL;ShipTo
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPShipTo2
          READKP             ShipTo2FL;ShipTo
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPShipTo2LK
           READKPLK          ShipTo2FL;ShipTo
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Third file I/O operations
.
           %IFDEF            ShipTo3KY
.
TSTShipTo3
           READ              ShipTo3FL,ShipTo3KY;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDShipTo3
           READ              ShipTo3FL,ShipTo3KY;ShipTo
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDShipTo3LK
           READLK            ShipTo3FL,ShipTo3KY;ShipTo
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSShipTo3
           READKS            ShipTo3FL;ShipTo
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSShipTo3LK

           READKSLK          ShipTo3FL;ShipTo
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPShipTo3
          READKP             ShipTo3FL;ShipTo
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPShipTo3LK

           READKPLK          ShipTo3FL;ShipTo
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fourth file I/O operations
.
           %IFDEF            ShipTo4KY
.
TSTShipTo4
           READ              ShipTo4FL,ShipTo4KY;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDShipTo4
           READ              ShipTo4FL,ShipTo4KY;ShipTo
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDShipTo4LK
           READLK            ShipTo4FL,ShipTo4KY;ShipTo
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSShipTo4
           READKS            ShipTo4FL;ShipTo
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSShipTo4LK

           READKSLK          ShipTo4FL;ShipTo
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPShipTo4
          READKP             ShipTo4FL;ShipTo
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPShipTo4LK

           READKPLK          ShipTo4FL;ShipTo
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fifth file I/O operations
.
           %IFDEF            ShipTo5KY
.
TSTShipTo5
           READ              ShipTo5FL,ShipTo5KY;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDShipTo5
           READ              ShipTo5FL,ShipTo5KY;ShipTo
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDShipTo5LK
           READLK            ShipTo5FL,ShipTo5KY;ShipTo
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSShipTo5
           READKS            ShipTo5FL;ShipTo
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSShipTo5LK

           READKSLK          ShipTo5FL;ShipTo
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPShipTo5
          READKP             ShipTo5FL;ShipTo
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPShipTo5LK
           READKPLK          ShipTo5FL;ShipTo
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Sixth file I/O operations
.
           %IFDEF            ShipTo6KY
.
TSTShipTo6
           READ              ShipTo6FL,ShipTo6KY;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDShipTo6
           READ              ShipTo6FL,ShipTo6KY;ShipTo
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDShipTo6LK
           READLK            ShipTo6FL,ShipTo6KY;ShipTo
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSShipTo6
           READKS            ShipTo6FL;ShipTo
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSShipTo6LK

           READKSLK          ShipTo6FL;ShipTo
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPShipTo6
          READKP             ShipTo6FL;ShipTo
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPShipTo6LK

           READKPLK          ShipTo6FL;ShipTo
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Seventh file I/O operations
.
           %IFDEF            ShipTo7KY
.
TSTShipTo7
           READ              ShipTo7FL,ShipTo7KY;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDShipTo7
           READ              ShipTo7FL,ShipTo7KY;ShipTo
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDShipTo7LK
           READLK            ShipTo7FL,ShipTo7KY;ShipTo
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSShipTo7
           READKS            ShipTo7FL;ShipTo
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSShipTo7LK

           READKSLK          ShipTo7FL;ShipTo
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPShipTo7
          READKP             ShipTo7FL;ShipTo
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPShipTo7LK

           READKPLK          ShipTo7FL;ShipTo
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Eighth file I/O operations
.
           %IFDEF            ShipTo8KY
.
TSTShipTo8
           READ              ShipTo8FL,ShipTo8KY;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDShipTo8
           READ              ShipTo8FL,ShipTo8KY;ShipTo
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDShipTo8LK
           READLK            ShipTo8FL,ShipTo8KY;ShipTo
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSShipTo8
           READKS            ShipTo8FL;ShipTo
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSShipTo8LK

           READKSLK          ShipTo8FL;ShipTo
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPShipTo8
          READKP             ShipTo8FL;ShipTo
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPShipTo8LK

           READKPLK          ShipTo8FL;ShipTo
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Ninth file I/O operations
.
           %IFDEF            ShipTo9KY
.
. Third set of File I/O operations
.
TSTShipTo9
           READ              ShipTo9FL,ShipTo9KY;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDShipTo9
           READ              ShipTo9FL,ShipTo9KY;ShipTo
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDShipTo9LK
           READLK            ShipTo9FL,ShipTo9KY;ShipTo
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSShipTo9
           READKS            ShipTo9FL;ShipTo
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSShipTo9LK

           READKSLK          ShipTo9FL;ShipTo
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPShipTo9
          READKP             ShipTo9FL;ShipTo
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPShipTo9LK

           READKPLK          ShipTo9FL;ShipTo
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.
.=============================================================================
.
. Deletion for PRIMARY Index
.
DELShipTo
           READ              ShipToFL,ShipToKY;;
           GOTO              #ERROR IF OVER
DELShipToLK
           DELETE            ShipToFLST
           GOTO              #VALID
.
. Update I/O operation
.
UPDShipTo
.HR 6/21/2005           MOVE              ShipTo.ShipToomerID,ShipToKY
.HR 6/21/2005           READ              ShipToFL,ShipToKY;;
.HR 6/21/2005           GOTO              #ERROR IF OVER
UPDShipToLK
           UPDATE               ShipToFLST;ShipTo
           GOTO                 #VALID
.
. Write I/O operation
.
WRTShipTo
           WRITE                ShipToFLST;ShipTo
           GOTO                 #VALID
.
. Preparation of ShipToer Transaction Files
.
PREPShipTo
           %IFDEF            ShipToKY
             PREPARE           ShipToFL,ShipToTXTNM,ShipToISI1NM,ShipToI1DEF,ShipToFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            ShipTo2KY
             PREPARE           ShipTo2FL,ShipToTXTNM,ShipToISI2NM,ShipToI2DEF,ShipToFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            ShipTo3KY
             PREPARE           ShipTo3FL,ShipToTXTNM,ShipToISI3NM,ShipToI3DEF,ShipToFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            ShipTo4KY
             PREPARE           ShipTo4FL,ShipToTXTNM,ShipToISI4NM,ShipToI4DEF,ShipToFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            ShipTo5KY
             PREPARE           ShipTo5FL,ShipToTXTNM,ShipToISI5NM,ShipToI5DEF,ShipToFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            ShipTo6KY
             PREPARE           ShipTo6FL,ShipToTXTNM,ShipToISI6NM,ShipToI6DEF,ShipToFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            ShipTo7KY
             PREPARE           ShipTo7FL,ShipToTXTNM,ShipToISI7NM,ShipToI7DEF,ShipToFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            ShipTo8KY
             PREPARE           ShipTo8FL,ShipToTXTNM,ShipToISI8NM,ShipToI8DEF,ShipToFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            ShipTo9KY
             PREPARE           ShipTo9FL,ShipToTXTNM,ShipToISI9NM,ShipToI9DEF,ShipToFSIZE,EXCLUSIVE
           %ENDIF
           RETURN

.
. Opening of Check Register Transaction File
.
OPENShipTo
           GETFILE           ShipToFL
           RETURN            IF ZERO
           OPEN              ShipToFLST,SHARE,LOCKMANUAL,SINGLE,NOWAIT
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
           MOVE                 "0" TO RETURNFL
...           INCLUDE             SETSTAT2.INC

           RETURN
;=============================================================================
           %ENDIF

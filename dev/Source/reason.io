......................................................................
.    Chiron Software & Services, Inc.
.    4 Norfolk Lane
.    Bethpage, Ny  11714
.    (516) 935-0196
.
.
. Program Created On : 02/15/02 At 3:00:am
.

           %IFNDEF           $ReasonVAR
             INCLUDE           Reason.FD
           %ENDIF
.
           %IFNDEF           $ReasonIO
$ReasonIO    EQUATE            1
.
. Test Read for PRIMARY Index
.
TSTReason
           READ              ReasonFL,ReasonKY;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDReason
           READ              ReasonFL,ReasonKY;ReasonREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDReasonLK
           READLK            ReasonFL,ReasonKY;ReasonREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSReason
           READKS            ReasonFL;ReasonREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSReasonLK

           READKSLK          ReasonFL;ReasonREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPReason
          READKP             ReasonFL;ReasonREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPReasonLK

           READKPLK          ReasonFL;ReasonREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.=============================================================================
. Secondary file I/O operations
.
           %IFDEF            ReasonKY2
TSTReason2
           READ              ReasonFL2,ReasonKY2;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDReason2
           READ              ReasonFL2,ReasonKY2;ReasonREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDReason2LK
           READLK            ReasonFL2,ReasonKY2;ReasonREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSReason2
           READKS            ReasonFL2;ReasonREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSReason2LK

           READKSLK          ReasonFL2;ReasonREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPReason2
          READKP             ReasonFL2;ReasonREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPReason2LK
           READKPLK          ReasonFL2;ReasonREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Third file I/O operations
.
           %IFDEF            ReasonKY3
.
TSTReason3
           READ              ReasonFL3,ReasonKY3;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDReason3
           READ              ReasonFL3,ReasonKY3;ReasonREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDReason3LK
           READLK            ReasonFL3,ReasonKY3;ReasonREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSReason3
           READKS            ReasonFL3;ReasonREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSReason3LK

           READKSLK          ReasonFL3;ReasonREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPReason3
          READKP             ReasonFL3;ReasonREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPReason3LK

           READKPLK          ReasonFL3;ReasonREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fourth file I/O operations
.
           %IFDEF            ReasonKY4
.
TSTReason4
           READ              ReasonFL4,ReasonKY4;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDReason4
           READ              ReasonFL4,ReasonKY4;ReasonREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDReason4LK
           READLK            ReasonFL4,ReasonKY4;ReasonREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSReason4
           READKS            ReasonFL4;ReasonREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSReason4LK

           READKSLK          ReasonFL4;ReasonREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPReason4
          READKP             ReasonFL4;ReasonREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPReason4LK

           READKPLK          ReasonFL4;ReasonREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fifth file I/O operations
.
           %IFDEF            ReasonKY5
.
TSTReason5
           READ              ReasonFL5,ReasonKY5;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDReason5
           READ              ReasonFL5,ReasonKY5;ReasonREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDReason5LK
           READLK            ReasonFL5,ReasonKY5;ReasonREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSReason5
           READKS            ReasonFL5;ReasonREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSReason5LK

           READKSLK          ReasonFL5;ReasonREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPReason5
          READKP             ReasonFL5;ReasonREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPReason5LK

           READKPLK          ReasonFL5;ReasonREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Sixth file I/O operations
.
           %IFDEF            ReasonKY6
.
TSTReason6
           READ              ReasonFL6,ReasonKY6;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDReason6
           READ              ReasonFL6,ReasonKY6;ReasonREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDReason6LK
           READLK            ReasonFL6,ReasonKY6;ReasonREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSReason6
           READKS            ReasonFL6;ReasonREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSReason6LK

           READKSLK          ReasonFL6;ReasonREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPReason6
          READKP             ReasonFL6;ReasonREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPReason6LK

           READKPLK          ReasonFL6;ReasonREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Seventh file I/O operations
.
           %IFDEF            ReasonKY7
.
TSTReason7
           READ              ReasonFL7,ReasonKY7;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDReason7
           READ              ReasonFL7,ReasonKY7;ReasonREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDReason7LK
           READLK            ReasonFL7,ReasonKY7;ReasonREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSReason7
           READKS            ReasonFL7;ReasonREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSReason7LK

           READKSLK          ReasonFL7;ReasonREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPReason7
          READKP             ReasonFL7;ReasonREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPReason7LK

           READKPLK          ReasonFL7;ReasonREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Eighth file I/O operations
.
           %IFDEF            ReasonKY8
.
TSTReason8
           READ              ReasonFL8,ReasonKY8;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDReason8
           READ              ReasonFL8,ReasonKY8;ReasonREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDReason8LK
           READLK            ReasonFL8,ReasonKY8;ReasonREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSReason8
           READKS            ReasonFL8;ReasonREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSReason8LK

           READKSLK          ReasonFL8;ReasonREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPReason8
          READKP             ReasonFL8;ReasonREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPReason8LK

           READKPLK          ReasonFL8;ReasonREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Ninth file I/O operations
.
           %IFDEF            ReasonKY9
.
. Third set of File I/O operations
.
TSTReason9
           READ              ReasonFL9,ReasonKY9;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDReason9
           READ              ReasonFL9,ReasonKY9;ReasonREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDReason9LK
           READLK            ReasonFL9,ReasonKY9;ReasonREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSReason9
           READKS            ReasonFL9;ReasonREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSReason9LK

           READKSLK          ReasonFL9;ReasonREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPReason9
          READKP             ReasonFL9;ReasonREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPReason9LK

           READKPLK          ReasonFL9;ReasonREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.
.=============================================================================
.
. Deletion for PRIMARY Index
.
DELReason
           READ              ReasonFL,ReasonKY;;
           GOTO              #ERROR IF OVER
DELReasonLK
           DELETE            ReasonFLST
           GOTO              #VALID
.
. Update I/O operation
.
UPDReason
.           READ              ReasonFL,ReasonKY;;
.           GOTO              #ERROR IF OVER
UPDReasonLK
           UPDATE            ReasonFLST;ReasonREC
           GOTO              #VALID
.
. Write I/O operation
.
WRTReason
           WRITE             ReasonFLST;ReasonREC
           GOTO              #VALID
.
. Preparation of Reasoner Transaction Files
.
PREPReason
           %IFDEF            ReasonKY
             PREPARE           ReasonFL,ReasonTXTNM,ReasonISI1NM,ReasonI1DEF,ReasonFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            ReasonKY2
             PREPARE           ReasonFL2,ReasonTXTNM,ReasonISI2NM,ReasonI2DEF,ReasonFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            ReasonKY3
             PREPARE           ReasonFL3,ReasonTXTNM,ReasonISI3NM,ReasonI3DEF,ReasonFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            ReasonKY4
             PREPARE           ReasonFL4,ReasonTXTNM,ReasonISI4NM,ReasonI4DEF,ReasonFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            ReasonKY5
             PREPARE           ReasonFL5,ReasonTXTNM,ReasonISI5NM,ReasonI5DEF,ReasonFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            ReasonKY6
             PREPARE           ReasonFL6,ReasonTXTNM,ReasonISI6NM,ReasonI6DEF,ReasonFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            ReasonKY7
             PREPARE           ReasonFL7,ReasonTXTNM,ReasonISI7NM,ReasonI7DEF,ReasonFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            ReasonKY8
             PREPARE           ReasonFL8,ReasonTXTNM,ReasonISI8NM,ReasonI8DEF,ReasonFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            ReasonKY9
             PREPARE           ReasonFL9,ReasonTXTNM,ReasonISI9NM,ReasonI9DEF,ReasonFSIZE,EXCLUSIVE
           %ENDIF
           RETURN

.
. Opening of Check Register Transaction File
.
OPENReason
           GETFILE           ReasonFL
           RETURN            IF ZERO
           OPEN              ReasonFLST,SHARE,LOCKMANUAL,SINGLE,NOWAIT
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

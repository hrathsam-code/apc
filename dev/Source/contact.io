......................................................................
.    Chiron Software & Services, Inc.
.    4 Norfolk Lane
.    Bethpage, Ny  11714
.    (516) 935-0196
.
.
. Program Created On : 02/15/02 At 3:00:am
.
           %IFNDEF           $ContactVAR
             INCLUDE           ContactER.FD
           %ENDIF
.
           %IFNDEF           $ContactIO
$ContactIO    EQUATE            1
.
. Test Read for PRIMARY Index
.
TSTContact
           READ              ContactFL,ContactKY;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDContact
           READ              ContactFL,ContactKY;ContactREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDContactLK
           READLK            ContactFL,ContactKY;ContactREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSContact
           READKS            ContactFL;ContactREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSContactLK

           READKSLK          ContactFL;ContactREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPContact
          READKP             ContactFL;ContactREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPContactLK

           READKPLK          ContactFL;ContactREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.=============================================================================
. Secondary file I/O operations
.
           %IFDEF            ContactKY2
TSTContact2
           READ              ContactFL2,ContactKY2;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDContact2
           READ              ContactFL2,ContactKY2;ContactREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDContact2LK
           READLK            ContactFL2,ContactKY2;ContactREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSContact2
           READKS            ContactFL2;ContactREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSContact2LK

           READKSLK          ContactFL2;ContactREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPContact2
          READKP             ContactFL2;ContactREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPContact2LK
           READKPLK          ContactFL2;ContactREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Third file I/O operations
.
           %IFDEF            ContactKY3
.
TSTContact3
           READ              ContactFL3,ContactKY3;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDContact3
           READ              ContactFL3,ContactKY3;ContactREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDContact3LK
           READLK            ContactFL3,ContactKY3;ContactREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSContact3
           READKS            ContactFL3;ContactREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSContact3LK

           READKSLK          ContactFL3;ContactREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPContact3
          READKP             ContactFL3;ContactREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPContact3LK

           READKPLK          ContactFL3;ContactREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fourth file I/O operations
.
           %IFDEF            ContactKY4
.
TSTContact4
           READ              ContactFL4,ContactKY4;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDContact4
           READ              ContactFL4,ContactKY4;ContactREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDContact4LK
           READLK            ContactFL4,ContactKY4;ContactREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSContact4
           READKS            ContactFL4;ContactREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSContact4LK

           READKSLK          ContactFL4;ContactREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPContact4
          READKP             ContactFL4;ContactREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPContact4LK

           READKPLK          ContactFL4;ContactREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fifth file I/O operations
.
           %IFDEF            ContactKY5
.
TSTContact5
           READ              ContactFL5,ContactKY5;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDContact5
           READ              ContactFL5,ContactKY5;ContactREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDContact5LK
           READLK            ContactFL5,ContactKY5;ContactREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSContact5
           READKS            ContactFL5;ContactREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSContact5LK

           READKSLK          ContactFL5;ContactREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPContact5
          READKP             ContactFL5;ContactREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPContact5LK

           READKPLK          ContactFL5;ContactREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Sixth file I/O operations
.
           %IFDEF            ContactKY6
.
TSTContact6
           READ              ContactFL6,ContactKY6;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDContact6
           READ              ContactFL6,ContactKY6;ContactREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDContact6LK
           READLK            ContactFL6,ContactKY6;ContactREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSContact6
           READKS            ContactFL6;ContactREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSContact6LK

           READKSLK          ContactFL6;ContactREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPContact6
          READKP             ContactFL6;ContactREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPContact6LK

           READKPLK          ContactFL6;ContactREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Seventh file I/O operations
.
           %IFDEF            ContactKY7
.
TSTContact7
           READ              ContactFL7,ContactKY7;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDContact7
           READ              ContactFL7,ContactKY7;ContactREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDContact7LK
           READLK            ContactFL7,ContactKY7;ContactREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSContact7
           READKS            ContactFL7;ContactREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSContact7LK

           READKSLK          ContactFL7;ContactREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPContact7
          READKP             ContactFL7;ContactREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPContact7LK

           READKPLK          ContactFL7;ContactREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Eighth file I/O operations
.
           %IFDEF            ContactKY8
.
TSTContact8
           READ              ContactFL8,ContactKY8;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDContact8
           READ              ContactFL8,ContactKY8;ContactREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDContact8LK
           READLK            ContactFL8,ContactKY8;ContactREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSContact8
           READKS            ContactFL8;ContactREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSContact8LK

           READKSLK          ContactFL8;ContactREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPContact8
          READKP             ContactFL8;ContactREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPContact8LK

           READKPLK          ContactFL8;ContactREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Ninth file I/O operations
.
           %IFDEF            ContactKY9
.
. Third set of File I/O operations
.
TSTContact9
           READ              ContactFL9,ContactKY9;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDContact9
           READ              ContactFL9,ContactKY9;ContactREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDContact9LK
           READLK            ContactFL9,ContactKY9;ContactREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSContact9
           READKS            ContactFL9;ContactREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSContact9LK

           READKSLK          ContactFL9;ContactREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPContact9
          READKP             ContactFL9;ContactREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPContact9LK

           READKPLK          ContactFL9;ContactREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.
.=============================================================================
.
. Deletion for PRIMARY Index
.
DELContact
..HR 11/26/2006           READ              ContactFL,ContactKY;;
..HR 11/26/2006           GOTO              #ERROR IF OVER
DELContactLK
           DELETE            ContactFLST
           GOTO              #VALID
.
. Update I/O operation
.
UPDContact
.           READ              ContactFL,ContactKY;;
.           GOTO              #ERROR IF OVER
UPDContactLK
           UPDATE            ContactFLST;ContactREC
           GOTO              #VALID
.
. Write I/O operation
.
WRTContact
           WRITE             ContactFLST;ContactREC
           GOTO              #VALID
.
. Preparation of Contacter Transaction Files
.
PREPContact
           %IFDEF            ContactKY
             PREPARE           ContactFL,ContactTXTNM,ContactISI1NM,ContactI1DEF,ContactFileSize,EXCLUSIVE
           %ENDIF
           %IFDEF            ContactKY2
             PREPARE           ContactFL2,ContactTXTNM,ContactISI2NM,ContactI2DEF,ContactFileSize,EXCLUSIVE
           %ENDIF
           %IFDEF            ContactKY3
             PREPARE           ContactFL3,ContactTXTNM,ContactISI3NM,ContactI3DEF,ContactFileSize,EXCLUSIVE
           %ENDIF
           %IFDEF            ContactKY4
             PREPARE           ContactFL4,ContactTXTNM,ContactISI4NM,ContactI4DEF,ContactFileSize,EXCLUSIVE
           %ENDIF
           %IFDEF            ContactKY5
             PREPARE           ContactFL5,ContactTXTNM,ContactISI5NM,ContactI5DEF,ContactFileSize,EXCLUSIVE
           %ENDIF
           %IFDEF            ContactKY6
             PREPARE           ContactFL6,ContactTXTNM,ContactISI6NM,ContactI6DEF,ContactFileSize,EXCLUSIVE
           %ENDIF
           %IFDEF            ContactKY7
             PREPARE           ContactFL7,ContactTXTNM,ContactISI7NM,ContactI7DEF,ContactFileSize,EXCLUSIVE
           %ENDIF
           %IFDEF            ContactKY8
             PREPARE           ContactFL8,ContactTXTNM,ContactISI8NM,ContactI8DEF,ContactFileSize,EXCLUSIVE
           %ENDIF
           %IFDEF            ContactKY9
             PREPARE           ContactFL9,ContactTXTNM,ContactISI9NM,ContactI9DEF,ContactFileSize,EXCLUSIVE
           %ENDIF
           RETURN

.
. Opening of Check Register Transaction File
.
OPENContact
           GETFILE           ContactFL
           RETURN            IF ZERO
           OPEN              ContactFLST,SHARE,LOCKMANUAL,SINGLE,NOWAIT
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

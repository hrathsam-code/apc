......................................................................
.    Chiron Software & Services, Inc.
.    4 Norfolk Lane
.    Bethpage, Ny  11714
.    (516) 935-0196
.
.
. Program Created On : 02/15/02 At 3:00:am
.
           GOTO                 #End
           %IFNDEF           $PrintVAR
             INCLUDE           PrintER.FD
           %ENDIF
.
           %IFNDEF           $PrintIO
$PrintIO    EQUATE            1
.
. Test Read for PRIMARY Index
.
TSTPrint
           READ              PrintFL,PrintKY;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDPrint
           READ              PrintFL,PrintKY;PrintREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDPrintLK
           READLK            PrintFL,PrintKY;PrintREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSPrint
           READKS            PrintFL;PrintREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSPrintLK

           READKSLK          PrintFL;PrintREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPPrint
          READKP             PrintFL;PrintREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPPrintLK

           READKPLK          PrintFL;PrintREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.=============================================================================
. Secondary file I/O operations
.
           %IFDEF            PrintKY2
TSTPrint2
           READ              PrintFL2,PrintKY2;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDPrint2
           READ              PrintFL2,PrintKY2;PrintREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDPrint2LK
           READLK            PrintFL2,PrintKY2;PrintREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSPrint2
           READKS            PrintFL2;PrintREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSPrint2LK

           READKSLK          PrintFL2;PrintREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPPrint2
          READKP             PrintFL2;PrintREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPPrint2LK
           READKPLK          PrintFL2;PrintREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Third file I/O operations
.
           %IFDEF            PrintKY3
.
TSTPrint3
           READ              PrintFL3,PrintKY3;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDPrint3
           READ              PrintFL3,PrintKY3;PrintREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDPrint3LK
           READLK            PrintFL3,PrintKY3;PrintREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSPrint3
           READKS            PrintFL3;PrintREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSPrint3LK

           READKSLK          PrintFL3;PrintREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPPrint3
          READKP             PrintFL3;PrintREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPPrint3LK

           READKPLK          PrintFL3;PrintREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fourth file I/O operations
.
           %IFDEF            PrintKY4
.
TSTPrint4
           READ              PrintFL4,PrintKY4;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDPrint4
           READ              PrintFL4,PrintKY4;PrintREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDPrint4LK
           READLK            PrintFL4,PrintKY4;PrintREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSPrint4
           READKS            PrintFL4;PrintREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSPrint4LK

           READKSLK          PrintFL4;PrintREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPPrint4
          READKP             PrintFL4;PrintREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPPrint4LK

           READKPLK          PrintFL4;PrintREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fifth file I/O operations
.
           %IFDEF            PrintKY5
.
TSTPrint5
           READ              PrintFL5,PrintKY5;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDPrint5
           READ              PrintFL5,PrintKY5;PrintREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDPrint5LK
           READLK            PrintFL5,PrintKY5;PrintREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSPrint5
           READKS            PrintFL5;PrintREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSPrint5LK

           READKSLK          PrintFL5;PrintREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPPrint5
          READKP             PrintFL5;PrintREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPPrint5LK

           READKPLK          PrintFL5;PrintREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Sixth file I/O operations
.
           %IFDEF            PrintKY6
.
TSTPrint6
           READ              PrintFL6,PrintKY6;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDPrint6
           READ              PrintFL6,PrintKY6;PrintREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDPrint6LK
           READLK            PrintFL6,PrintKY6;PrintREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSPrint6
           READKS            PrintFL6;PrintREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSPrint6LK

           READKSLK          PrintFL6;PrintREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPPrint6
          READKP             PrintFL6;PrintREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPPrint6LK

           READKPLK          PrintFL6;PrintREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Seventh file I/O operations
.
           %IFDEF            PrintKY7
.
TSTPrint7
           READ              PrintFL7,PrintKY7;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDPrint7
           READ              PrintFL7,PrintKY7;PrintREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDPrint7LK
           READLK            PrintFL7,PrintKY7;PrintREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSPrint7
           READKS            PrintFL7;PrintREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSPrint7LK

           READKSLK          PrintFL7;PrintREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPPrint7
          READKP             PrintFL7;PrintREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPPrint7LK

           READKPLK          PrintFL7;PrintREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Eighth file I/O operations
.
           %IFDEF            PrintKY8
.
TSTPrint8
           READ              PrintFL8,PrintKY8;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDPrint8
           READ              PrintFL8,PrintKY8;PrintREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDPrint8LK
           READLK            PrintFL8,PrintKY8;PrintREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSPrint8
           READKS            PrintFL8;PrintREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSPrint8LK

           READKSLK          PrintFL8;PrintREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPPrint8
          READKP             PrintFL8;PrintREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPPrint8LK

           READKPLK          PrintFL8;PrintREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Ninth file I/O operations
.
           %IFDEF            PrintKY9
.
. Third set of File I/O operations
.
TSTPrint9
           READ              PrintFL9,PrintKY9;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDPrint9
           READ              PrintFL9,PrintKY9;PrintREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDPrint9LK
           READLK            PrintFL9,PrintKY9;PrintREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSPrint9
           READKS            PrintFL9;PrintREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSPrint9LK

           READKSLK          PrintFL9;PrintREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPPrint9
          READKP             PrintFL9;PrintREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPPrint9LK

           READKPLK          PrintFL9;PrintREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.
.=============================================================================
.
. Deletion for PRIMARY Index
.
DELPrint
           READ              PrintFL,PrintKY;;
           GOTO              #ERROR IF OVER
DELPrintLK
           DELETE            PrintFLST
           GOTO              #VALID
.
. Update I/O operation
.
UPDPrint
.           READ              PrintFL,PrintKY;;
.           GOTO              #ERROR IF OVER
UPDPrintLK
           UPDATE            PrintFLST;PrintREC
           GOTO              #VALID
.
. Write I/O operation
.
WRTPrint
           WRITE             PrintFLST;PrintREC
           GOTO              #VALID
.
. Preparation of Printer Transaction Files
.
PREPPrint
           %IFDEF            PrintKY
             PREPARE           PrintFL,PrintTXTNM,PrintISI1NM,PrintI1DEF,PrintFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            PrintKY2
             PREPARE           PrintFL2,PrintTXTNM,PrintISI2NM,PrintI2DEF,PrintFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            PrintKY3
             PREPARE           PrintFL3,PrintTXTNM,PrintISI3NM,PrintI3DEF,PrintFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            PrintKY4
             PREPARE           PrintFL4,PrintTXTNM,PrintISI4NM,PrintI4DEF,PrintFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            PrintKY5
             PREPARE           PrintFL5,PrintTXTNM,PrintISI5NM,PrintI5DEF,PrintFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            PrintKY6
             PREPARE           PrintFL6,PrintTXTNM,PrintISI6NM,PrintI6DEF,PrintFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            PrintKY7
             PREPARE           PrintFL7,PrintTXTNM,PrintISI7NM,PrintI7DEF,PrintFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            PrintKY8
             PREPARE           PrintFL8,PrintTXTNM,PrintISI8NM,PrintI8DEF,PrintFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            PrintKY9
             PREPARE           PrintFL9,PrintTXTNM,PrintISI9NM,PrintI9DEF,PrintFSIZE,EXCLUSIVE
           %ENDIF
           RETURN

.
. Opening of Check Register Transaction File
.
OPENPrint
           GETFILE           PrintFL
           RETURN            IF ZERO
           OPEN              PrintFLST,SHARE,LOCKMANUAL,SINGLE,NOWAIT
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
#End

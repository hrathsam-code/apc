......................................................................
.    Chiron Software & Services, Inc.
.    4 Norfolk Lane
.    Bethpage, Ny  11714
.    (516) 935-0196
.
.
. Program Created On : 02/15/02 At 3:00:am
.
         goto              #End
           %IFNDEF           $BankVAR
             INCLUDE           Bank.FD
           %ENDIF
.
           %IFNDEF           $BankIO
$BankIO    EQUATE            1
.
. Test Read for PRIMARY Index
.
TSTBank
           READ              BankFL,BankKY;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDBank
           READ              BankFL,BankKY;BankREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDBankLK
           READLK            BankFL,BankKY;BankREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSBank
           READKS            BankFL;BankREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSBankLK

           READKSLK          BankFL;BankREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPBank
          READKP             BankFL;BankREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPBankLK

           READKPLK          BankFL;BankREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.=============================================================================
. Secondary file I/O operations
.
           %IFDEF            BankKY2
TSTBank2
           READ              BankFL2,BankKY2;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDBank2
           READ              BankFL2,BankKY2;BankREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDBank2LK
           READLK            BankFL2,BankKY2;BankREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSBank2
           READKS            BankFL2;BankREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSBank2LK

           READKSLK          BankFL2;BankREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPBank2
          READKP             BankFL2;BankREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPBank2LK
           READKPLK          BankFL2;BankREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Third file I/O operations
.
           %IFDEF            BankKY3
.
TSTBank3
           READ              BankFL3,BankKY3;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDBank3
           READ              BankFL3,BankKY3;BankREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDBank3LK
           READLK            BankFL3,BankKY3;BankREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSBank3
           READKS            BankFL3;BankREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSBank3LK

           READKSLK          BankFL3;BankREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPBank3
          READKP             BankFL3;BankREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPBank3LK

           READKPLK          BankFL3;BankREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fourth file I/O operations
.
           %IFDEF            BankKY4
.
TSTBank4
           READ              BankFL4,BankKY4;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDBank4
           READ              BankFL4,BankKY4;BankREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDBank4LK
           READLK            BankFL4,BankKY4;BankREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSBank4
           READKS            BankFL4;BankREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSBank4LK

           READKSLK          BankFL4;BankREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPBank4
          READKP             BankFL4;BankREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPBank4LK

           READKPLK          BankFL4;BankREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fifth file I/O operations
.
           %IFDEF            BankKY5
.
TSTBank5
           READ              BankFL5,BankKY5;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDBank5
           READ              BankFL5,BankKY5;BankREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDBank5LK
           READLK            BankFL5,BankKY5;BankREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSBank5
           READKS            BankFL5;BankREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSBank5LK

           READKSLK          BankFL5;BankREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPBank5
          READKP             BankFL5;BankREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPBank5LK

           READKPLK          BankFL5;BankREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Sixth file I/O operations
.
           %IFDEF            BankKY6
.
TSTBank6
           READ              BankFL6,BankKY6;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDBank6
           READ              BankFL6,BankKY6;BankREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDBank6LK
           READLK            BankFL6,BankKY6;BankREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSBank6
           READKS            BankFL6;BankREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSBank6LK

           READKSLK          BankFL6;BankREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPBank6
          READKP             BankFL6;BankREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPBank6LK

           READKPLK          BankFL6;BankREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Seventh file I/O operations
.
           %IFDEF            BankKY7
.
TSTBank7
           READ              BankFL7,BankKY7;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDBank7
           READ              BankFL7,BankKY7;BankREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDBank7LK
           READLK            BankFL7,BankKY7;BankREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSBank7
           READKS            BankFL7;BankREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSBank7LK

           READKSLK          BankFL7;BankREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPBank7
          READKP             BankFL7;BankREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPBank7LK

           READKPLK          BankFL7;BankREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Eighth file I/O operations
.
           %IFDEF            BankKY8
.
TSTBank8
           READ              BankFL8,BankKY8;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDBank8
           READ              BankFL8,BankKY8;BankREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDBank8LK
           READLK            BankFL8,BankKY8;BankREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSBank8
           READKS            BankFL8;BankREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSBank8LK

           READKSLK          BankFL8;BankREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPBank8
          READKP             BankFL8;BankREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPBank8LK

           READKPLK          BankFL8;BankREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Ninth file I/O operations
.
           %IFDEF            BankKY9
.
. Third set of File I/O operations
.
TSTBank9
           READ              BankFL9,BankKY9;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDBank9
           READ              BankFL9,BankKY9;BankREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDBank9LK
           READLK            BankFL9,BankKY9;BankREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSBank9
           READKS            BankFL9;BankREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSBank9LK

           READKSLK          BankFL9;BankREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPBank9
          READKP             BankFL9;BankREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPBank9LK

           READKPLK          BankFL9;BankREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.
.=============================================================================
.
. Deletion for PRIMARY Index
.
DELBank
           READ              BankFL,BankKY;;
           GOTO              #ERROR IF OVER
DELBankLK
           DELETE            BankFLST
           GOTO              #VALID
.
. Update I/O operation
.
UPDBank
.           READ              BankFL,BankKY;;
.           GOTO              #ERROR IF OVER
UPDBankLK
           UPDATE            BankFLST;BankREC
           GOTO              #VALID
.
. Write I/O operation
.
WRTBank
           WRITE             BankFLST;BankREC
           GOTO              #VALID
.
. Preparation of Banker Transaction Files
.
PREPBank
           %IFDEF            BankKY
             PREPARE           BankFL,BankTXTNM,BankISI1NM,BankI1DEF,BankFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            BankKY2
             PREPARE           BankFL2,BankTXTNM,BankISI2NM,BankI2DEF,BankFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            BankKY3
             PREPARE           BankFL3,BankTXTNM,BankISI3NM,BankI3DEF,BankFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            BankKY4
             PREPARE           BankFL4,BankTXTNM,BankISI4NM,BankI4DEF,BankFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            BankKY5
             PREPARE           BankFL5,BankTXTNM,BankISI5NM,BankI5DEF,BankFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            BankKY6
             PREPARE           BankFL6,BankTXTNM,BankISI6NM,BankI6DEF,BankFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            BankKY7
             PREPARE           BankFL7,BankTXTNM,BankISI7NM,BankI7DEF,BankFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            BankKY8
             PREPARE           BankFL8,BankTXTNM,BankISI8NM,BankI8DEF,BankFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            BankKY9
             PREPARE           BankFL9,BankTXTNM,BankISI9NM,BankI9DEF,BankFSIZE,EXCLUSIVE
           %ENDIF
           RETURN

.
. Opening of Check Register Transaction File
.
OPENBank
           GETFILE           BANKFL
           RETURN            IF ZERO
           OPEN              BankFLST,SHARE,LOCKMANUAL,SINGLE,NOWAIT
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
#exit
           %ENDIF
#end

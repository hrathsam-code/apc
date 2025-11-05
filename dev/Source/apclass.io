......................................................................
.    Chiron Software & Services, Inc.
.    4 Norfolk Lane
.    Bethpage, Ny  11714
.    (516) 935-0196
.
.
. Program Created On : 02/15/02 At 3:00:am
.
           %IFNDEF           $APClassVAR
             INCLUDE           APClassER.FD
           %ENDIF
.
           %IFNDEF           $APClassIO
$APClassIO    EQUATE            1
.
. Test Read for PRIMARY Index
.
TSTAPClass
           READ              APClassFL,APClassKY;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPClass
           READ              APClassFL,APClassKY;APClass
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPClassLK
           READLK            APClassFL,APClassKY;APClass
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPClass
           READKS            APClassFL;APClass
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPClassLK

           READKSLK          APClassFL;APClass
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPClass
          READKP             APClassFL;APClass
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPClassLK

           READKPLK          APClassFL;APClass
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.=============================================================================
. Secondary file I/O operations
.
           %IFDEF            APClassKY2
TSTAPClass2
           READ              APClassFL2,APClassKY2;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPClass2
           READ              APClassFL2,APClassKY2;APClass
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPClass2LK
           READLK            APClassFL2,APClassKY2;APClass
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPClass2
           READKS            APClassFL2;APClass
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPClass2LK

           READKSLK          APClassFL2;APClass
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPClass2
          READKP             APClassFL2;APClass
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPClass2LK
           READKPLK          APClassFL2;APClass
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Third file I/O operations
.
           %IFDEF            APClassKY3
.
TSTAPClass3
           READ              APClassFL3,APClassKY3;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPClass3
           READ              APClassFL3,APClassKY3;APClass
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPClass3LK
           READLK            APClassFL3,APClassKY3;APClass
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPClass3
           READKS            APClassFL3;APClass
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPClass3LK

           READKSLK          APClassFL3;APClass
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPClass3
          READKP             APClassFL3;APClass
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPClass3LK

           READKPLK          APClassFL3;APClass
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fourth file I/O operations
.
           %IFDEF            APClassKY4
.
TSTAPClass4
           READ              APClassFL4,APClassKY4;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPClass4
           READ              APClassFL4,APClassKY4;APClass
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPClass4LK
           READLK            APClassFL4,APClassKY4;APClass
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPClass4
           READKS            APClassFL4;APClass
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPClass4LK

           READKSLK          APClassFL4;APClass
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPClass4
          READKP             APClassFL4;APClass
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPClass4LK

           READKPLK          APClassFL4;APClass
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fifth file I/O operations
.
           %IFDEF            APClassKY5
.
TSTAPClass5
           READ              APClassFL5,APClassKY5;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPClass5
           READ              APClassFL5,APClassKY5;APClass
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPClass5LK
           READLK            APClassFL5,APClassKY5;APClass
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPClass5
           READKS            APClassFL5;APClass
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPClass5LK

           READKSLK          APClassFL5;APClass
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPClass5
          READKP             APClassFL5;APClass
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPClass5LK

           READKPLK          APClassFL5;APClass
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Sixth file I/O operations
.
           %IFDEF            APClassKY6
.
TSTAPClass6
           READ              APClassFL6,APClassKY6;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPClass6
           READ              APClassFL6,APClassKY6;APClass
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPClass6LK
           READLK            APClassFL6,APClassKY6;APClass
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPClass6
           READKS            APClassFL6;APClass
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPClass6LK

           READKSLK          APClassFL6;APClass
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPClass6
          READKP             APClassFL6;APClass
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPClass6LK

           READKPLK          APClassFL6;APClass
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Seventh file I/O operations
.
           %IFDEF            APClassKY7
.
TSTAPClass7
           READ              APClassFL7,APClassKY7;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPClass7
           READ              APClassFL7,APClassKY7;APClass
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPClass7LK
           READLK            APClassFL7,APClassKY7;APClass
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPClass7
           READKS            APClassFL7;APClass
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPClass7LK

           READKSLK          APClassFL7;APClass
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPClass7
          READKP             APClassFL7;APClass
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPClass7LK

           READKPLK          APClassFL7;APClass
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Eighth file I/O operations
.
           %IFDEF            APClassKY8
.
TSTAPClass8
           READ              APClassFL8,APClassKY8;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPClass8
           READ              APClassFL8,APClassKY8;APClass
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPClass8LK
           READLK            APClassFL8,APClassKY8;APClass
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPClass8
           READKS            APClassFL8;APClass
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPClass8LK

           READKSLK          APClassFL8;APClass
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPClass8
          READKP             APClassFL8;APClass
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPClass8LK

           READKPLK          APClassFL8;APClass
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Ninth file I/O operations
.
           %IFDEF            APClassKY9
.
. Third set of File I/O operations
.
TSTAPClass9
           READ              APClassFL9,APClassKY9;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPClass9
           READ              APClassFL9,APClassKY9;APClass
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPClass9LK
           READLK            APClassFL9,APClassKY9;APClass
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPClass9
           READKS            APClassFL9;APClass
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPClass9LK

           READKSLK          APClassFL9;APClass
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPClass9
          READKP             APClassFL9;APClass
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPClass9LK

           READKPLK          APClassFL9;APClass
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.
.=============================================================================
.
. Deletion for PRIMARY Index
.
DELAPClass
           READ              APClassFL,APClassKY;;
           GOTO              #ERROR IF OVER
DELAPClassLK
           DELETE            APClassFLST
           GOTO              #VALID
.
. Update I/O operation
.
UPDAPClass
.           READ              APClassFL,APClassKY;;
.           GOTO              #ERROR IF OVER
UPDAPClassLK
           UPDATE            APClassFLST;APClass
           GOTO              #VALID
.
. Write I/O operation
.
WRTAPClass
           WRITE             APClassFLST;APClass
           GOTO              #VALID
.
. Preparation of APClasser Transaction Files
.
PREPAPClass
           %IFDEF            APClassKY
             PREPARE           APClassFL,APClassTXTNM,APClassISI1NM,APClassI1DEF,APClassFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APClassKY2
             PREPARE           APClassFL2,APClassTXTNM,APClassISI2NM,APClassI2DEF,APClassFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APClassKY3
             PREPARE           APClassFL3,APClassTXTNM,APClassISI3NM,APClassI3DEF,APClassFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APClassKY4
             PREPARE           APClassFL4,APClassTXTNM,APClassISI4NM,APClassI4DEF,APClassFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APClassKY5
             PREPARE           APClassFL5,APClassTXTNM,APClassISI5NM,APClassI5DEF,APClassFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APClassKY6
             PREPARE           APClassFL6,APClassTXTNM,APClassISI6NM,APClassI6DEF,APClassFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APClassKY7
             PREPARE           APClassFL7,APClassTXTNM,APClassISI7NM,APClassI7DEF,APClassFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APClassKY8
             PREPARE           APClassFL8,APClassTXTNM,APClassISI8NM,APClassI8DEF,APClassFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APClassKY9
             PREPARE           APClassFL9,APClassTXTNM,APClassISI9NM,APClassI9DEF,APClassFSIZE,EXCLUSIVE
           %ENDIF
           RETURN

.
. Opening of Check Register Transaction File
.
OPENAPClass
           GETFILE           APClassFL
           RETURN            IF ZERO
           OPEN              APClassFLST,SHARE,LOCKMANUAL,SINGLE,NOWAIT
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

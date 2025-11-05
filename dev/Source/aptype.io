;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    4 NORFOLK LANE                                           ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    APType.IO                                                      ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    07/21/2005 AT 12:53AM                                          ;
;                                                                             ;
;  PURPOSE:    A/P Type Master File I/O Routines                              ;
;                                                                             ;
; REVISION:    VER     DATE     INIT       DETAILS                            ;
;                                                                             ;
;              1.0   07/21/2005   HOR     INITIAL VERSION                     ;
;                                                                             ;
;=============================================================================;
.
           %IFNDEF           $APTypeVAR
             INCLUDE           APTypeER.FD
           %ENDIF
.
           %IFNDEF           $APTypeIO
$APTypeIO    EQUATE            1
.
. Test Read for PRIMARY Index
.
TSTAPType
           READ              APTypeFL,APTypeKY;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPType
           READ              APTypeFL,APTypeKY;APType
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPTypeLK
           READLK            APTypeFL,APTypeKY;APType
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPType
           READKS            APTypeFL;APType
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPTypeLK

           READKSLK          APTypeFL;APType
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPType
          READKP             APTypeFL;APType
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPTypeLK

           READKPLK          APTypeFL;APType
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.=============================================================================
. Secondary file I/O operations
.
           %IFDEF            APTypeKY2

TSTAPType2
           READ              APTypeFL2,APTypeKY2;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPType2
           READ              APTypeFL2,APTypeKY2;APType
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPType2LK
           READLK            APTypeFL2,APTypeKY2;APType
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPType2
           READKS            APTypeFL2;APType
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPType2LK

           READKSLK          APTypeFL2;APType
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPType2
          READKP             APTypeFL2;APType
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPType2LK
           READKPLK          APTypeFL2;APType
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Third file I/O operations
.
           %IFDEF            APTypeKY3
.
TSTAPType3
           READ              APTypeFL3,APTypeKY3;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPType3
           READ              APTypeFL3,APTypeKY3;APType
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPType3LK
           READLK            APTypeFL3,APTypeKY3;APType
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPType3
           READKS            APTypeFL3;APType
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPType3LK

           READKSLK          APTypeFL3;APType
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPType3
          READKP             APTypeFL3;APType
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPType3LK

           READKPLK          APTypeFL3;APType
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fourth file I/O operations
.
           %IFDEF            APTypeKY4
.
TSTAPType4
           READ              APTypeFL4,APTypeKY4;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPType4
           READ              APTypeFL4,APTypeKY4;APType
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPType4LK
           READLK            APTypeFL4,APTypeKY4;APType
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPType4
           READKS            APTypeFL4;APType
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPType4LK

           READKSLK          APTypeFL4;APType
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPType4
          READKP             APTypeFL4;APType
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPType4LK

           READKPLK          APTypeFL4;APType
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fifth file I/O operations
.
           %IFDEF            APTypeKY5
.
TSTAPType5
           READ              APTypeFL5,APTypeKY5;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPType5
           READ              APTypeFL5,APTypeKY5;APType
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPType5LK
           READLK            APTypeFL5,APTypeKY5;APType
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPType5
           READKS            APTypeFL5;APType
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPType5LK

           READKSLK          APTypeFL5;APType
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPType5
          READKP             APTypeFL5;APType
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPType5LK

           READKPLK          APTypeFL5;APType
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Sixth file I/O operations
.
           %IFDEF            APTypeKY6
.
TSTAPType6
           READ              APTypeFL6,APTypeKY6;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPType6
           READ              APTypeFL6,APTypeKY6;APType
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPType6LK
           READLK            APTypeFL6,APTypeKY6;APType
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPType6
           READKS            APTypeFL6;APType
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPType6LK

           READKSLK          APTypeFL6;APType
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPType6
          READKP             APTypeFL6;APType
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPType6LK

           READKPLK          APTypeFL6;APType
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Seventh file I/O operations
.
           %IFDEF            APTypeKY7
.
TSTAPType7
           READ              APTypeFL7,APTypeKY7;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPType7
           READ              APTypeFL7,APTypeKY7;APType
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPType7LK
           READLK            APTypeFL7,APTypeKY7;APType
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPType7
           READKS            APTypeFL7;APType
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPType7LK

           READKSLK          APTypeFL7;APType
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPType7
          READKP             APTypeFL7;APType
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPType7LK

           READKPLK          APTypeFL7;APType
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Eighth file I/O operations
.
           %IFDEF            APTypeKY8
.
TSTAPType8
           READ              APTypeFL8,APTypeKY8;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPType8
           READ              APTypeFL8,APTypeKY8;APType
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPType8LK
           READLK            APTypeFL8,APTypeKY8;APType
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPType8
           READKS            APTypeFL8;APType
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPType8LK

           READKSLK          APTypeFL8;APType
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPType8
          READKP             APTypeFL8;APType
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPType8LK

           READKPLK          APTypeFL8;APType
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Ninth file I/O operations
.
           %IFDEF            APTypeKY9
.
. Third set of File I/O operations
.
TSTAPType9
           READ              APTypeFL9,APTypeKY9;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPType9
           READ              APTypeFL9,APTypeKY9;APType
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPType9LK
           READLK            APTypeFL9,APTypeKY9;APType
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPType9
           READKS            APTypeFL9;APType
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPType9LK

           READKSLK          APTypeFL9;APType
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPType9
          READKP             APTypeFL9;APType
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPType9LK

           READKPLK          APTypeFL9;APType
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.
.=============================================================================
.
. Deletion for PRIMARY Index
.
DELAPType
           READ              APTypeFL,APTypeKY;;
           GOTO              #ERROR IF OVER
DELAPTypeLK
           DELETE            APTypeFLST
           GOTO              #VALID
.
. Update I/O operation
.
UPDAPType
.           READ              APTypeFL,APTypeKY;;
.           GOTO              #ERROR IF OVER
UPDAPTypeLK
           UPDATE            APTypeFLST;APType
           GOTO              #VALID
.
. Write I/O operation
.
WRTAPType
           WRITE             APTypeFLST;APType
           GOTO              #VALID
.
. Preparation of APTypeer Transaction Files
.
PREPAPType
           %IFDEF            APTypeKY1
             PREPARE           APTypeFL,APTypeTXTNM,APTypeISI1NM,APTypeI1DEF,APTypeFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APTypeKY2
             PREPARE           APTypeFL2,APTypeTXTNM,APTypeISI2NM,APTypeI2DEF,APTypeFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APTypeKY3
             PREPARE           APTypeFL3,APTypeTXTNM,APTypeISI3NM,APTypeI3DEF,APTypeFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APTypeKY4
             PREPARE           APTypeFL4,APTypeTXTNM,APTypeISI4NM,APTypeI4DEF,APTypeFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APTypeKY5
             PREPARE           APTypeFL5,APTypeTXTNM,APTypeISI5NM,APTypeI5DEF,APTypeFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APTypeKY6
             PREPARE           APTypeFL6,APTypeTXTNM,APTypeISI6NM,APTypeI6DEF,APTypeFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APTypeKY7
             PREPARE           APTypeFL7,APTypeTXTNM,APTypeISI7NM,APTypeI7DEF,APTypeFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APTypeKY8
             PREPARE           APTypeFL8,APTypeTXTNM,APTypeISI8NM,APTypeI8DEF,APTypeFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APTypeKY9
             PREPARE           APTypeFL9,APTypeTXTNM,APTypeISI9NM,APTypeI9DEF,APTypeFSIZE,EXCLUSIVE
           %ENDIF
           RETURN

.
. Opening of Check Register Transaction File
.
OPENAPType
           GETFILE           APTypeFL
           RETURN            IF ZERO
           OPEN              APTypeFLST,SHARE,LOCKMANUAL,SINGLE,NOWAIT

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

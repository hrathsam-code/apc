;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    4 NORFOLK LANE                                           ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    Users.IO                                                       ;
;                                                                             ;
;   AUTHOR:                                                                   ;
;                                                                             ;
;     DATE:    02/28/2005 AT 10:55PM                                          ;
;                                                                             ;
;  PURPOSE:                                                                   ;
;                                                                             ;
; REVISION:    VER     DATE     INIT       DETAILS                            ;
;                                                                             ;
;              1.0   02/28/2005   HOR     INITIAL VERSION                     ;
;                                                                             ;
;=============================================================================;

                   %IFNDEF           $UsersVAR
                     INCLUDE           UsersER.FD
                   %ENDIF
.
                   %IFNDEF           $UsersIO

                   goto              #S

$UsersIO           EQUATE            1
;==========================================================================================================
; Test Read for PRIMARY Index

TSTUsers
                   READ              UsersFL,UsersKY;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDUsers
                   READ              UsersFL,UsersKY;UsersREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDUsersLK
                   READLK            UsersFL,UsersKY;UsersREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSUsers
                   READKS            UsersFL;UsersREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSUsersLK
                   READKSLK          UsersFL;UsersREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPUsers
                   READKP             UsersFL;UsersREC
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPUsersLK
                   READKPLK          UsersFL;UsersREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
;==========================================================================================================
. Secondary file I/O operations
.
                   %IFDEF            UsersKY2
TSTUsers2
                   READ              UsersFL2,UsersKY2;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDUsers2
                   READ              UsersFL2,UsersKY2;UsersREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDUsers2LK
                   READLK            UsersFL2,UsersKY2;UsersREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSUsers2
                   READKS            UsersFL2;UsersREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSUsers2LK
                   READKSLK          UsersFL2;UsersREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPUsers2
                   READKP             UsersFL2;UsersREC
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPUsers2LK
                   READKPLK          UsersFL2;UsersREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Third file I/O operations
.
                   %IFDEF            UsersKY3
.
TSTUsers3
                   READ              UsersFL3,UsersKY3;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDUsers3
                   READ              UsersFL3,UsersKY3;UsersREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDUsers3LK
                   READLK            UsersFL3,UsersKY3;UsersREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSUsers3
                   READKS            UsersFL3;UsersREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSUsers3LK
                   READKSLK          UsersFL3;UsersREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPUsers3
                   READKP             UsersFL3;UsersREC
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPUsers3LK
                   READKPLK          UsersFL3;UsersREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Fourth file I/O operations
.
                   %IFDEF            UsersKY4
.
TSTUsers4
                   READ              UsersFL4,UsersKY4;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDUsers4
                   READ              UsersFL4,UsersKY4;UsersREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDUsers4LK
                   READLK            UsersFL4,UsersKY4;UsersREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSUsers4
                   READKS            UsersFL4;UsersREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSUsers4LK
                   READKSLK          UsersFL4;UsersREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPUsers4
                   READKP             UsersFL4;UsersREC
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPUsers4LK
                   READKPLK          UsersFL4;UsersREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Fifth file I/O operations
.
                   %IFDEF            UsersKY5
.
TSTUsers5
                   READ              UsersFL5,UsersKY5;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDUsers5
                   READ              UsersFL5,UsersKY5;UsersREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDUsers5LK
                   READLK            UsersFL5,UsersKY5;UsersREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSUsers5
                   READKS            UsersFL5;UsersREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSUsers5LK
                   READKSLK          UsersFL5;UsersREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPUsers5
                   READKP             UsersFL5;UsersREC
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPUsers5LK
                   READKPLK          UsersFL5;UsersREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Sixth file I/O operations
.
                   %IFDEF            UsersKY6
.
TSTUsers6
                   READ              UsersFL6,UsersKY6;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDUsers6
                   READ              UsersFL6,UsersKY6;UsersREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDUsers6LK
                   READLK            UsersFL6,UsersKY6;UsersREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSUsers6
                   READKS            UsersFL6;UsersREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSUsers6LK
                   READKSLK          UsersFL6;UsersREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPUsers6
                   READKP             UsersFL6;UsersREC
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPUsers6LK

                   READKPLK          UsersFL6;UsersREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Seventh file I/O operations
.
                   %IFDEF            UsersKY7
.
TSTUsers7
                   READ              UsersFL7,UsersKY7;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDUsers7
                   READ              UsersFL7,UsersKY7;UsersREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDUsers7LK
                   READLK            UsersFL7,UsersKY7;UsersREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSUsers7
                   READKS            UsersFL7;UsersREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSUsers7LK
                   READKSLK          UsersFL7;UsersREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPUsers7
                   READKP             UsersFL7;UsersREC
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPUsers7LK

                   READKPLK          UsersFL7;UsersREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Eighth file I/O operations
.
                   %IFDEF            UsersKY8
.
TSTUsers8
                   READ              UsersFL8,UsersKY8;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDUsers8
                   READ              UsersFL8,UsersKY8;UsersREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDUsers8LK
                   READLK            UsersFL8,UsersKY8;UsersREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSUsers8
                   READKS            UsersFL8;UsersREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSUsers8LK
                   READKSLK          UsersFL8;UsersREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPUsers8
                   READKP             UsersFL8;UsersREC
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPUsers8LK
                   READKPLK          UsersFL8;UsersREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Ninth file I/O operations
.
                   %IFDEF            UsersKY9
.
. Third set of File I/O operations
.
TSTUsers9
                   READ              UsersFL9,UsersKY9;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDUsers9
                   READ              UsersFL9,UsersKY9;UsersREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDUsers9LK
                   READLK            UsersFL9,UsersKY9;UsersREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSUsers9
                   READKS            UsersFL9;UsersREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSUsers9LK
                   READKSLK          UsersFL9;UsersREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPUsers9
                   READKP             UsersFL9;UsersREC
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPUsers9LK
                   READKPLK          UsersFL9;UsersREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Deletion for PRIMARY Index
.
DELUsers
                   READ              UsersFL,UsersKY;;
                   GOTO              #ERROR IF OVER
DELUsersLK
                   DELETE            UsersFLST
                   GOTO              #VALID
;==========================================================================================================
; Update I/O operation

UPDUsers
UPDUsersLK
                   UPDATE            UsersFLST;UsersREC
                   GOTO              #VALID
;==========================================================================================================
; Write I/O operation

WRTUsers
                   WRITE             UsersFLST;UsersREC
                   GOTO              #VALID
;==========================================================================================================
; Preparation of Userser Transaction Files
;
PREPUsers
                   %IFDEF            UsersKY
                     PREPARE           UsersFL,UsersTXTNM,UsersISI1NM,UsersI1DEF,UsersFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            UsersKY2
                     PREPARE           UsersFL2,UsersTXTNM,UsersISI2NM,UsersI2DEF,UsersFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            UsersKY3
                     PREPARE           UsersFL3,UsersTXTNM,UsersISI3NM,UsersI3DEF,UsersFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            UsersKY4
                     PREPARE           UsersFL4,UsersTXTNM,UsersISI4NM,UsersI4DEF,UsersFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            UsersKY5
                     PREPARE           UsersFL5,UsersTXTNM,UsersISI5NM,UsersI5DEF,UsersFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            UsersKY6
                     PREPARE           UsersFL6,UsersTXTNM,UsersISI6NM,UsersI6DEF,UsersFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            UsersKY7
                     PREPARE           UsersFL7,UsersTXTNM,UsersISI7NM,UsersI7DEF,UsersFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            UsersKY8
                     PREPARE           UsersFL8,UsersTXTNM,UsersISI8NM,UsersI8DEF,UsersFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            UsersKY9
                     PREPARE           UsersFL9,UsersTXTNM,UsersISI9NM,UsersI9DEF,UsersFileSize,EXCLUSIVE
                   %ENDIF
                   RETURN
;==========================================================================================================
. Opening of UsersX File
.
OPENUsers
                   GETFILE           UsersFL
                   RETURN            IF ZERO
                   OPEN              UsersFLST,SHARE,LOCKMANUAL,SINGLE,NOWAIT
                   RETURN
;==========================================================================================================
; Standard Return Values for I/O Include
;
#ERROR
                   MOVE              "1" TO RETURNFL
                   RETURN
#LOCKED
                   MOVE              "2" TO RETURNFL
                   RETURN
#VALID
                   MOVE              "0" TO RETURNFL
                   RETURN
#S
                   %ENDIF

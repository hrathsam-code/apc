;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    4 NORFOLK LANE                                           ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    XXXXX.IO                                                       ;
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
.
                   %IFNDEF           $xxxxxVAR
                     INCLUDE           xxxxxER.FD
                   %ENDIF
.
                   %IFNDEF           $xxxxxIO

                   goto              #S

$xxxxxIO           EQUATE            1
;==========================================================================================================
; Test Read for PRIMARY Index

TSTxxxxx
                   READ              xxxxxFL,xxxxxKY;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDxxxxx
                   READ              xxxxxFL,xxxxxKY;xxxxx
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDxxxxxLK
                   READLK            xxxxxFL,xxxxxKY;xxxxx
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSxxxxx
                   READKS            xxxxxFL;xxxxx
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSxxxxxLK
                   READKSLK          xxxxxFL;xxxxx
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPxxxxx
                   READKP             xxxxxFL;xxxxx
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPxxxxxLK
                   READKPLK          xxxxxFL;xxxxx
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
;==========================================================================================================
. Secondary file I/O operations
.
                   %IFDEF            xxxxxKY2
TSTxxxxx2
                   READ              xxxxxFL2,xxxxxKY2;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDxxxxx2
                   READ              xxxxxFL2,xxxxxKY2;xxxxx
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDxxxxx2LK
                   READLK            xxxxxFL2,xxxxxKY2;xxxxx
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSxxxxx2
                   READKS            xxxxxFL2;xxxxx
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSxxxxx2LK
                   READKSLK          xxxxxFL2;xxxxx
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPxxxxx2
                   READKP             xxxxxFL2;xxxxx
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPxxxxx2LK
                   READKPLK          xxxxxFL2;xxxxx
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Third file I/O operations
.
                   %IFDEF            xxxxxKY3
.
TSTxxxxx3
                   READ              xxxxxFL3,xxxxxKY3;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDxxxxx3
                   READ              xxxxxFL3,xxxxxKY3;xxxxx
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDxxxxx3LK
                   READLK            xxxxxFL3,xxxxxKY3;xxxxx
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSxxxxx3
                   READKS            xxxxxFL3;xxxxx
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSxxxxx3LK
                   READKSLK          xxxxxFL3;xxxxx
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPxxxxx3
                   READKP             xxxxxFL3;xxxxx
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPxxxxx3LK
                   READKPLK          xxxxxFL3;xxxxx
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Fourth file I/O operations
.
                   %IFDEF            xxxxxKY4
.
TSTxxxxx4
                   READ              xxxxxFL4,xxxxxKY4;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDxxxxx4
                   READ              xxxxxFL4,xxxxxKY4;xxxxx
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDxxxxx4LK
                   READLK            xxxxxFL4,xxxxxKY4;xxxxx
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSxxxxx4
                   READKS            xxxxxFL4;xxxxx
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSxxxxx4LK
                   READKSLK          xxxxxFL4;xxxxx
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPxxxxx4
                   READKP             xxxxxFL4;xxxxx
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPxxxxx4LK
                   READKPLK          xxxxxFL4;xxxxx
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Fifth file I/O operations
.
                   %IFDEF            xxxxxKY5
.
TSTxxxxx5
                   READ              xxxxxFL5,xxxxxKY5;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDxxxxx5
                   READ              xxxxxFL5,xxxxxKY5;xxxxx
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDxxxxx5LK
                   READLK            xxxxxFL5,xxxxxKY5;xxxxx
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSxxxxx5
                   READKS            xxxxxFL5;xxxxx
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSxxxxx5LK
                   READKSLK          xxxxxFL5;xxxxx
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPxxxxx5
                   READKP             xxxxxFL5;xxxxx
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPxxxxx5LK
                   READKPLK          xxxxxFL5;xxxxx
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Sixth file I/O operations
.
                   %IFDEF            xxxxxKY6
.
TSTxxxxx6
                   READ              xxxxxFL6,xxxxxKY6;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDxxxxx6
                   READ              xxxxxFL6,xxxxxKY6;xxxxx
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDxxxxx6LK
                   READLK            xxxxxFL6,xxxxxKY6;xxxxx
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSxxxxx6
                   READKS            xxxxxFL6;xxxxx
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSxxxxx6LK
                   READKSLK          xxxxxFL6;xxxxx
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPxxxxx6
                   READKP             xxxxxFL6;xxxxx
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPxxxxx6LK

                   READKPLK          xxxxxFL6;xxxxx
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Seventh file I/O operations
.
                   %IFDEF            xxxxxKY7
.
TSTxxxxx7
                   READ              xxxxxFL7,xxxxxKY7;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDxxxxx7
                   READ              xxxxxFL7,xxxxxKY7;xxxxx
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDxxxxx7LK
                   READLK            xxxxxFL7,xxxxxKY7;xxxxx
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSxxxxx7
                   READKS            xxxxxFL7;xxxxx
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSxxxxx7LK
                   READKSLK          xxxxxFL7;xxxxx
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPxxxxx7
                   READKP             xxxxxFL7;xxxxx
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPxxxxx7LK

                   READKPLK          xxxxxFL7;xxxxx
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Eighth file I/O operations
.
                   %IFDEF            xxxxxKY8
.
TSTxxxxx8
                   READ              xxxxxFL8,xxxxxKY8;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDxxxxx8
                   READ              xxxxxFL8,xxxxxKY8;xxxxx
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDxxxxx8LK
                   READLK            xxxxxFL8,xxxxxKY8;xxxxx
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSxxxxx8
                   READKS            xxxxxFL8;xxxxx
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSxxxxx8LK
                   READKSLK          xxxxxFL8;xxxxx
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPxxxxx8
                   READKP             xxxxxFL8;xxxxx
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPxxxxx8LK
                   READKPLK          xxxxxFL8;xxxxx
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Ninth file I/O operations
.
                   %IFDEF            xxxxxKY9
.
. Third set of File I/O operations
.
TSTxxxxx9
                   READ              xxxxxFL9,xxxxxKY9;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDxxxxx9
                   READ              xxxxxFL9,xxxxxKY9;xxxxx
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDxxxxx9LK
                   READLK            xxxxxFL9,xxxxxKY9;xxxxx
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSxxxxx9
                   READKS            xxxxxFL9;xxxxx
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSxxxxx9LK
                   READKSLK          xxxxxFL9;xxxxx
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPxxxxx9
                   READKP             xxxxxFL9;xxxxx
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPxxxxx9LK
                   READKPLK          xxxxxFL9;xxxxx
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Deletion for PRIMARY Index
.
DELxxxxx
..HR 6.6.2016                   READ              xxxxxFL,xxxxxKY;;
..HR 6.6.2016                   GOTO              #ERROR IF OVER
DELxxxxxLK
                   DELETE            xxxxxFLST
                   GOTO              #VALID
;==========================================================================================================
; Update I/O operation

UPDxxxxx
UPDxxxxxLK
                   UPDATE            xxxxxFLST;xxxxx
                   GOTO              #VALID
;==========================================================================================================
; Write I/O operation

WRTxxxxx
                   WRITE             xxxxxFLST;xxxxx
                   GOTO              #VALID
;==========================================================================================================
; Preparation of xxxxxer Transaction Files
;
PREPxxxxx
                   %IFDEF            xxxxxKY
                     PREPARE           xxxxxFL,xxxxxTXTNM,xxxxxISI1NM,xxxxxI1DEF,xxxxxFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            xxxxxKY2
                     PREPARE           xxxxxFL2,xxxxxTXTNM,xxxxxISI2NM,xxxxxI2DEF,xxxxxFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            xxxxxKY3
                     PREPARE           xxxxxFL3,xxxxxTXTNM,xxxxxISI3NM,xxxxxI3DEF,xxxxxFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            xxxxxKY4
                     PREPARE           xxxxxFL4,xxxxxTXTNM,xxxxxISI4NM,xxxxxI4DEF,xxxxxFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            xxxxxKY5
                     PREPARE           xxxxxFL5,xxxxxTXTNM,xxxxxISI5NM,xxxxxI5DEF,xxxxxFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            xxxxxKY6
                     PREPARE           xxxxxFL6,xxxxxTXTNM,xxxxxISI6NM,xxxxxI6DEF,xxxxxFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            xxxxxKY7
                     PREPARE           xxxxxFL7,xxxxxTXTNM,xxxxxISI7NM,xxxxxI7DEF,xxxxxFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            xxxxxKY8
                     PREPARE           xxxxxFL8,xxxxxTXTNM,xxxxxISI8NM,xxxxxI8DEF,xxxxxFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            xxxxxKY9
                     PREPARE           xxxxxFL9,xxxxxTXTNM,xxxxxISI9NM,xxxxxI9DEF,xxxxxFileSize,EXCLUSIVE
                   %ENDIF
                   RETURN
;==========================================================================================================
. Opening of XXXXXX File
.
OPENxxxxx
                   GETFILE           xxxxxFL
                   RETURN            IF ZERO
                   OPEN              xxxxxFLST,SHARE,LOCKMANUAL,SINGLE,NOWAIT
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

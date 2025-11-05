;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    4 NORFOLK LANE                                           ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    KitHeader.IO                                                       ;
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
                   %IFNDEF           $KitHeaderVAR
                     INCLUDE           KitHeaderER.FD
                   %ENDIF
.
                   %IFNDEF           $KitHeaderIO

                   goto              #S

$KitHeaderIO           EQUATE            1
;==========================================================================================================
; Test Read for PRIMARY Index

TSTKitHeader
                   READ              KitHeaderFL,KitHeaderKY;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDKitHeader
                   READ              KitHeaderFL,KitHeaderKY;KitHeaderREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDKitHeaderLK
                   READLK            KitHeaderFL,KitHeaderKY;KitHeaderREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSKitHeader
                   READKS            KitHeaderFL;KitHeaderREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSKitHeaderLK
                   READKSLK          KitHeaderFL;KitHeaderREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPKitHeader
                   READKP             KitHeaderFL;KitHeaderREC
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPKitHeaderLK
                   READKPLK          KitHeaderFL;KitHeaderREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
;==========================================================================================================
. Secondary file I/O operations
.
                   %IFDEF            KitHeaderKY2
TSTKitHeader2
                   READ              KitHeaderFL2,KitHeaderKY2;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDKitHeader2
                   READ              KitHeaderFL2,KitHeaderKY2;KitHeaderREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDKitHeader2LK
                   READLK            KitHeaderFL2,KitHeaderKY2;KitHeaderREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSKitHeader2
                   READKS            KitHeaderFL2;KitHeaderREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSKitHeader2LK
                   READKSLK          KitHeaderFL2;KitHeaderREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPKitHeader2
                   READKP             KitHeaderFL2;KitHeaderREC
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPKitHeader2LK
                   READKPLK          KitHeaderFL2;KitHeaderREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Third file I/O operations
.
                   %IFDEF            KitHeaderKY3
.
TSTKitHeader3
                   READ              KitHeaderFL3,KitHeaderKY3;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDKitHeader3
                   READ              KitHeaderFL3,KitHeaderKY3;KitHeaderREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDKitHeader3LK
                   READLK            KitHeaderFL3,KitHeaderKY3;KitHeaderREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSKitHeader3
                   READKS            KitHeaderFL3;KitHeaderREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSKitHeader3LK
                   READKSLK          KitHeaderFL3;KitHeaderREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPKitHeader3
                   READKP             KitHeaderFL3;KitHeaderREC
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPKitHeader3LK
                   READKPLK          KitHeaderFL3;KitHeaderREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Fourth file I/O operations
.
                   %IFDEF            KitHeaderKY4
.
TSTKitHeader4
                   READ              KitHeaderFL4,KitHeaderKY4;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDKitHeader4
                   READ              KitHeaderFL4,KitHeaderKY4;KitHeaderREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDKitHeader4LK
                   READLK            KitHeaderFL4,KitHeaderKY4;KitHeaderREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSKitHeader4
                   READKS            KitHeaderFL4;KitHeaderREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSKitHeader4LK
                   READKSLK          KitHeaderFL4;KitHeaderREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPKitHeader4
                   READKP             KitHeaderFL4;KitHeaderREC
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPKitHeader4LK
                   READKPLK          KitHeaderFL4;KitHeaderREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Fifth file I/O operations
.
                   %IFDEF            KitHeaderKY5
.
TSTKitHeader5
                   READ              KitHeaderFL5,KitHeaderKY5;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDKitHeader5
                   READ              KitHeaderFL5,KitHeaderKY5;KitHeaderREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDKitHeader5LK
                   READLK            KitHeaderFL5,KitHeaderKY5;KitHeaderREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSKitHeader5
                   READKS            KitHeaderFL5;KitHeaderREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSKitHeader5LK
                   READKSLK          KitHeaderFL5;KitHeaderREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPKitHeader5
                   READKP             KitHeaderFL5;KitHeaderREC
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPKitHeader5LK
                   READKPLK          KitHeaderFL5;KitHeaderREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Sixth file I/O operations
.
                   %IFDEF            KitHeaderKY6
.
TSTKitHeader6
                   READ              KitHeaderFL6,KitHeaderKY6;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDKitHeader6
                   READ              KitHeaderFL6,KitHeaderKY6;KitHeaderREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDKitHeader6LK
                   READLK            KitHeaderFL6,KitHeaderKY6;KitHeaderREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSKitHeader6
                   READKS            KitHeaderFL6;KitHeaderREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSKitHeader6LK
                   READKSLK          KitHeaderFL6;KitHeaderREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPKitHeader6
                   READKP             KitHeaderFL6;KitHeaderREC
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPKitHeader6LK

                   READKPLK          KitHeaderFL6;KitHeaderREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Seventh file I/O operations
.
                   %IFDEF            KitHeaderKY7
.
TSTKitHeader7
                   READ              KitHeaderFL7,KitHeaderKY7;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDKitHeader7
                   READ              KitHeaderFL7,KitHeaderKY7;KitHeaderREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDKitHeader7LK
                   READLK            KitHeaderFL7,KitHeaderKY7;KitHeaderREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSKitHeader7
                   READKS            KitHeaderFL7;KitHeaderREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSKitHeader7LK
                   READKSLK          KitHeaderFL7;KitHeaderREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPKitHeader7
                   READKP             KitHeaderFL7;KitHeaderREC
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPKitHeader7LK

                   READKPLK          KitHeaderFL7;KitHeaderREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Eighth file I/O operations
.
                   %IFDEF            KitHeaderKY8
.
TSTKitHeader8
                   READ              KitHeaderFL8,KitHeaderKY8;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDKitHeader8
                   READ              KitHeaderFL8,KitHeaderKY8;KitHeaderREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDKitHeader8LK
                   READLK            KitHeaderFL8,KitHeaderKY8;KitHeaderREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSKitHeader8
                   READKS            KitHeaderFL8;KitHeaderREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSKitHeader8LK
                   READKSLK          KitHeaderFL8;KitHeaderREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPKitHeader8
                   READKP             KitHeaderFL8;KitHeaderREC
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPKitHeader8LK
                   READKPLK          KitHeaderFL8;KitHeaderREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Ninth file I/O operations
.
                   %IFDEF            KitHeaderKY9
.
. Third set of File I/O operations
.
TSTKitHeader9
                   READ              KitHeaderFL9,KitHeaderKY9;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDKitHeader9
                   READ              KitHeaderFL9,KitHeaderKY9;KitHeaderREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDKitHeader9LK
                   READLK            KitHeaderFL9,KitHeaderKY9;KitHeaderREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSKitHeader9
                   READKS            KitHeaderFL9;KitHeaderREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSKitHeader9LK
                   READKSLK          KitHeaderFL9;KitHeaderREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPKitHeader9
                   READKP             KitHeaderFL9;KitHeaderREC
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPKitHeader9LK
                   READKPLK          KitHeaderFL9;KitHeaderREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Deletion for PRIMARY Index
.
DELKitHeader
..HR 6.6.2016                   READ              KitHeaderFL,KitHeaderKY;;
..HR 6.6.2016                   GOTO              #ERROR IF OVER
DELKitHeaderLK
                   DELETE            KitHeaderFLST
                   GOTO              #VALID
;==========================================================================================================
; Update I/O operation

UPDKitHeader
UPDKitHeaderLK
                   UPDATE            KitHeaderFLST;KitHeaderREC
                   GOTO              #VALID
;==========================================================================================================
; Write I/O operation

WRTKitHeader
                   WRITE             KitHeaderFLST;KitHeaderREC
                   GOTO              #VALID
;==========================================================================================================
; Preparation of KitHeaderer Transaction Files
;
PREPKitHeader
                   %IFDEF            KitHeaderKY
                     PREPARE           KitHeaderFL,KitHeaderTXTNM,KitHeaderISI1NM,KitHeaderI1DEF,KitHeaderFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            KitHeaderKY2
                     PREPARE           KitHeaderFL2,KitHeaderTXTNM,KitHeaderISI2NM,KitHeaderI2DEF,KitHeaderFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            KitHeaderKY3
                     PREPARE           KitHeaderFL3,KitHeaderTXTNM,KitHeaderISI3NM,KitHeaderI3DEF,KitHeaderFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            KitHeaderKY4
                     PREPARE           KitHeaderFL4,KitHeaderTXTNM,KitHeaderISI4NM,KitHeaderI4DEF,KitHeaderFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            KitHeaderKY5
                     PREPARE           KitHeaderFL5,KitHeaderTXTNM,KitHeaderISI5NM,KitHeaderI5DEF,KitHeaderFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            KitHeaderKY6
                     PREPARE           KitHeaderFL6,KitHeaderTXTNM,KitHeaderISI6NM,KitHeaderI6DEF,KitHeaderFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            KitHeaderKY7
                     PREPARE           KitHeaderFL7,KitHeaderTXTNM,KitHeaderISI7NM,KitHeaderI7DEF,KitHeaderFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            KitHeaderKY8
                     PREPARE           KitHeaderFL8,KitHeaderTXTNM,KitHeaderISI8NM,KitHeaderI8DEF,KitHeaderFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            KitHeaderKY9
                     PREPARE           KitHeaderFL9,KitHeaderTXTNM,KitHeaderISI9NM,KitHeaderI9DEF,KitHeaderFileSize,EXCLUSIVE
                   %ENDIF
                   RETURN
;==========================================================================================================
. Opening of KitHeaderX File
.
OPENKitHeader
                   GETFILE           KitHeaderFL
                   RETURN            IF ZERO
                   OPEN              KitHeaderFLST,SHARE,LOCKMANUAL,SINGLE,NOWAIT
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

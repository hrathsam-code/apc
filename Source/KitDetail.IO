;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    4 NORFOLK LANE                                           ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    KitDetail.IO                                                       ;
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
                   %IFNDEF           $KitDetailVAR
                     INCLUDE           KitDetailER.FD
                   %ENDIF
.
                   %IFNDEF           $KitDetailIO

                   goto              #S

$KitDetailIO           EQUATE            1
;==========================================================================================================
; Test Read for PRIMARY Index

TSTKitDetail
                   READ              KitDetailFL,KitDetailKY;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDKitDetail
                   READ              KitDetailFL,KitDetailKY;KitDetailREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDKitDetailLK
                   READLK            KitDetailFL,KitDetailKY;KitDetailREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSKitDetail
                   READKS            KitDetailFL;KitDetailREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSKitDetailLK
                   READKSLK          KitDetailFL;KitDetailREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPKitDetail
                   READKP             KitDetailFL;KitDetailREC
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPKitDetailLK
                   READKPLK          KitDetailFL;KitDetailREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
;==========================================================================================================
. Secondary file I/O operations
.
                   %IFDEF            KitDetailKY2
TSTKitDetail2
                   READ              KitDetailFL2,KitDetailKY2;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDKitDetail2
                   READ              KitDetailFL2,KitDetailKY2;KitDetailREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDKitDetail2LK
                   READLK            KitDetailFL2,KitDetailKY2;KitDetailREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSKitDetail2
                   READKS            KitDetailFL2;KitDetailREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSKitDetail2LK
                   READKSLK          KitDetailFL2;KitDetailREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPKitDetail2
                   READKP             KitDetailFL2;KitDetailREC
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPKitDetail2LK
                   READKPLK          KitDetailFL2;KitDetailREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Third file I/O operations
.
                   %IFDEF            KitDetailKY3
.
TSTKitDetail3
                   READ              KitDetailFL3,KitDetailKY3;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDKitDetail3
                   READ              KitDetailFL3,KitDetailKY3;KitDetailREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDKitDetail3LK
                   READLK            KitDetailFL3,KitDetailKY3;KitDetailREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSKitDetail3
                   READKS            KitDetailFL3;KitDetailREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSKitDetail3LK
                   READKSLK          KitDetailFL3;KitDetailREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPKitDetail3
                   READKP             KitDetailFL3;KitDetailREC
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPKitDetail3LK
                   READKPLK          KitDetailFL3;KitDetailREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Fourth file I/O operations
.
                   %IFDEF            KitDetailKY4
.
TSTKitDetail4
                   READ              KitDetailFL4,KitDetailKY4;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDKitDetail4
                   READ              KitDetailFL4,KitDetailKY4;KitDetailREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDKitDetail4LK
                   READLK            KitDetailFL4,KitDetailKY4;KitDetailREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSKitDetail4
                   READKS            KitDetailFL4;KitDetailREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSKitDetail4LK
                   READKSLK          KitDetailFL4;KitDetailREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPKitDetail4
                   READKP             KitDetailFL4;KitDetailREC
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPKitDetail4LK
                   READKPLK          KitDetailFL4;KitDetailREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Fifth file I/O operations
.
                   %IFDEF            KitDetailKY5
.
TSTKitDetail5
                   READ              KitDetailFL5,KitDetailKY5;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDKitDetail5
                   READ              KitDetailFL5,KitDetailKY5;KitDetailREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDKitDetail5LK
                   READLK            KitDetailFL5,KitDetailKY5;KitDetailREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSKitDetail5
                   READKS            KitDetailFL5;KitDetailREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSKitDetail5LK
                   READKSLK          KitDetailFL5;KitDetailREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPKitDetail5
                   READKP             KitDetailFL5;KitDetailREC
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPKitDetail5LK
                   READKPLK          KitDetailFL5;KitDetailREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Sixth file I/O operations
.
                   %IFDEF            KitDetailKY6
.
TSTKitDetail6
                   READ              KitDetailFL6,KitDetailKY6;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDKitDetail6
                   READ              KitDetailFL6,KitDetailKY6;KitDetailREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDKitDetail6LK
                   READLK            KitDetailFL6,KitDetailKY6;KitDetailREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSKitDetail6
                   READKS            KitDetailFL6;KitDetailREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSKitDetail6LK
                   READKSLK          KitDetailFL6;KitDetailREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPKitDetail6
                   READKP             KitDetailFL6;KitDetailREC
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPKitDetail6LK

                   READKPLK          KitDetailFL6;KitDetailREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Seventh file I/O operations
.
                   %IFDEF            KitDetailKY7
.
TSTKitDetail7
                   READ              KitDetailFL7,KitDetailKY7;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDKitDetail7
                   READ              KitDetailFL7,KitDetailKY7;KitDetailREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDKitDetail7LK
                   READLK            KitDetailFL7,KitDetailKY7;KitDetailREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSKitDetail7
                   READKS            KitDetailFL7;KitDetailREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSKitDetail7LK
                   READKSLK          KitDetailFL7;KitDetailREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPKitDetail7
                   READKP             KitDetailFL7;KitDetailREC
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPKitDetail7LK

                   READKPLK          KitDetailFL7;KitDetailREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Eighth file I/O operations
.
                   %IFDEF            KitDetailKY8
.
TSTKitDetail8
                   READ              KitDetailFL8,KitDetailKY8;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDKitDetail8
                   READ              KitDetailFL8,KitDetailKY8;KitDetailREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDKitDetail8LK
                   READLK            KitDetailFL8,KitDetailKY8;KitDetailREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSKitDetail8
                   READKS            KitDetailFL8;KitDetailREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSKitDetail8LK
                   READKSLK          KitDetailFL8;KitDetailREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPKitDetail8
                   READKP             KitDetailFL8;KitDetailREC
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPKitDetail8LK
                   READKPLK          KitDetailFL8;KitDetailREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Ninth file I/O operations
.
                   %IFDEF            KitDetailKY9
.
. Third set of File I/O operations
.
TSTKitDetail9
                   READ              KitDetailFL9,KitDetailKY9;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDKitDetail9
                   READ              KitDetailFL9,KitDetailKY9;KitDetailREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDKitDetail9LK
                   READLK            KitDetailFL9,KitDetailKY9;KitDetailREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSKitDetail9
                   READKS            KitDetailFL9;KitDetailREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSKitDetail9LK
                   READKSLK          KitDetailFL9;KitDetailREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPKitDetail9
                   READKP             KitDetailFL9;KitDetailREC
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPKitDetail9LK
                   READKPLK          KitDetailFL9;KitDetailREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Deletion for PRIMARY Index
.
DELKitDetail
..HR 6.6.2016                   READ              KitDetailFL,KitDetailKY;;
..HR 6.6.2016                   GOTO              #ERROR IF OVER
DELKitDetailLK
                   DELETE            KitDetailFLST
                   GOTO              #VALID
;==========================================================================================================
; Update I/O operation

UPDKitDetail
UPDKitDetailLK
                   UPDATE            KitDetailFLST;KitDetailREC
                   GOTO              #VALID
;==========================================================================================================
; Write I/O operation

WRTKitDetail
                   WRITE             KitDetailFLST;KitDetailREC
                   GOTO              #VALID
;==========================================================================================================
; Preparation of KitDetailer Transaction Files
;
PREPKitDetail
                   %IFDEF            KitDetailKY
                     PREPARE           KitDetailFL,KitDetailTXTNM,KitDetailISI1NM,KitDetailI1DEF,KitDetailFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            KitDetailKY2
                     PREPARE           KitDetailFL2,KitDetailTXTNM,KitDetailISI2NM,KitDetailI2DEF,KitDetailFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            KitDetailKY3
                     PREPARE           KitDetailFL3,KitDetailTXTNM,KitDetailISI3NM,KitDetailI3DEF,KitDetailFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            KitDetailKY4
                     PREPARE           KitDetailFL4,KitDetailTXTNM,KitDetailISI4NM,KitDetailI4DEF,KitDetailFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            KitDetailKY5
                     PREPARE           KitDetailFL5,KitDetailTXTNM,KitDetailISI5NM,KitDetailI5DEF,KitDetailFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            KitDetailKY6
                     PREPARE           KitDetailFL6,KitDetailTXTNM,KitDetailISI6NM,KitDetailI6DEF,KitDetailFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            KitDetailKY7
                     PREPARE           KitDetailFL7,KitDetailTXTNM,KitDetailISI7NM,KitDetailI7DEF,KitDetailFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            KitDetailKY8
                     PREPARE           KitDetailFL8,KitDetailTXTNM,KitDetailISI8NM,KitDetailI8DEF,KitDetailFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            KitDetailKY9
                     PREPARE           KitDetailFL9,KitDetailTXTNM,KitDetailISI9NM,KitDetailI9DEF,KitDetailFileSize,EXCLUSIVE
                   %ENDIF
                   RETURN
;==========================================================================================================
. Opening of KitDetailX File
.
OPENKitDetail
                   GETFILE           KitDetailFL
                   RETURN            IF ZERO
                   OPEN              KitDetailFLST,SHARE,LOCKMANUAL,SINGLE,NOWAIT
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

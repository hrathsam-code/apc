;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    4 NORFOLK LANE                                           ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    PhoneType.IO                                                       ;
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
                   %IFNDEF           $PhoneTypeVAR
                     INCLUDE           PhoneTypeER.FD
                   %ENDIF
.
                   %IFNDEF           $PhoneTypeIO

                   goto              #S

$PhoneTypeIO           EQUATE            1
;==========================================================================================================
; Test Read for PRIMARY Index

TSTPhoneType
                   READ              PhoneTypeFL,PhoneTypeKY;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDPhoneType
                   READ              PhoneTypeFL,PhoneTypeKY;PhoneType
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDPhoneTypeLK
                   READLK            PhoneTypeFL,PhoneTypeKY;PhoneType
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSPhoneType
                   READKS            PhoneTypeFL;PhoneType
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSPhoneTypeLK
                   READKSLK          PhoneTypeFL;PhoneType
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPPhoneType
                   READKP             PhoneTypeFL;PhoneType
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPPhoneTypeLK
                   READKPLK          PhoneTypeFL;PhoneType
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
;==========================================================================================================
. Secondary file I/O operations
.
                   %IFDEF            PhoneTypeKY2
TSTPhoneType2
                   READ              PhoneTypeFL2,PhoneTypeKY2;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDPhoneType2
                   READ              PhoneTypeFL2,PhoneTypeKY2;PhoneType
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDPhoneType2LK
                   READLK            PhoneTypeFL2,PhoneTypeKY2;PhoneType
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSPhoneType2
                   READKS            PhoneTypeFL2;PhoneType
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSPhoneType2LK
                   READKSLK          PhoneTypeFL2;PhoneType
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPPhoneType2
                   READKP             PhoneTypeFL2;PhoneType
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPPhoneType2LK
                   READKPLK          PhoneTypeFL2;PhoneType
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Third file I/O operations
.
                   %IFDEF            PhoneTypeKY3
.
TSTPhoneType3
                   READ              PhoneTypeFL3,PhoneTypeKY3;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDPhoneType3
                   READ              PhoneTypeFL3,PhoneTypeKY3;PhoneType
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDPhoneType3LK
                   READLK            PhoneTypeFL3,PhoneTypeKY3;PhoneType
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSPhoneType3
                   READKS            PhoneTypeFL3;PhoneType
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSPhoneType3LK
                   READKSLK          PhoneTypeFL3;PhoneType
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPPhoneType3
                   READKP             PhoneTypeFL3;PhoneType
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPPhoneType3LK
                   READKPLK          PhoneTypeFL3;PhoneType
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Fourth file I/O operations
.
                   %IFDEF            PhoneTypeKY4
.
TSTPhoneType4
                   READ              PhoneTypeFL4,PhoneTypeKY4;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDPhoneType4
                   READ              PhoneTypeFL4,PhoneTypeKY4;PhoneType
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDPhoneType4LK
                   READLK            PhoneTypeFL4,PhoneTypeKY4;PhoneType
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSPhoneType4
                   READKS            PhoneTypeFL4;PhoneType
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSPhoneType4LK
                   READKSLK          PhoneTypeFL4;PhoneType
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPPhoneType4
                   READKP             PhoneTypeFL4;PhoneType
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPPhoneType4LK
                   READKPLK          PhoneTypeFL4;PhoneType
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Fifth file I/O operations
.
                   %IFDEF            PhoneTypeKY5
.
TSTPhoneType5
                   READ              PhoneTypeFL5,PhoneTypeKY5;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDPhoneType5
                   READ              PhoneTypeFL5,PhoneTypeKY5;PhoneType
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDPhoneType5LK
                   READLK            PhoneTypeFL5,PhoneTypeKY5;PhoneType
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSPhoneType5
                   READKS            PhoneTypeFL5;PhoneType
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSPhoneType5LK
                   READKSLK          PhoneTypeFL5;PhoneType
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPPhoneType5
                   READKP             PhoneTypeFL5;PhoneType
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPPhoneType5LK
                   READKPLK          PhoneTypeFL5;PhoneType
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Sixth file I/O operations
.
                   %IFDEF            PhoneTypeKY6
.
TSTPhoneType6
                   READ              PhoneTypeFL6,PhoneTypeKY6;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDPhoneType6
                   READ              PhoneTypeFL6,PhoneTypeKY6;PhoneType
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDPhoneType6LK
                   READLK            PhoneTypeFL6,PhoneTypeKY6;PhoneType
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSPhoneType6
                   READKS            PhoneTypeFL6;PhoneType
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSPhoneType6LK
                   READKSLK          PhoneTypeFL6;PhoneType
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPPhoneType6
                   READKP             PhoneTypeFL6;PhoneType
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPPhoneType6LK

                   READKPLK          PhoneTypeFL6;PhoneType
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Seventh file I/O operations
.
                   %IFDEF            PhoneTypeKY7
.
TSTPhoneType7
                   READ              PhoneTypeFL7,PhoneTypeKY7;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDPhoneType7
                   READ              PhoneTypeFL7,PhoneTypeKY7;PhoneType
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDPhoneType7LK
                   READLK            PhoneTypeFL7,PhoneTypeKY7;PhoneType
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSPhoneType7
                   READKS            PhoneTypeFL7;PhoneType
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSPhoneType7LK
                   READKSLK          PhoneTypeFL7;PhoneType
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPPhoneType7
                   READKP             PhoneTypeFL7;PhoneType
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPPhoneType7LK

                   READKPLK          PhoneTypeFL7;PhoneType
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Eighth file I/O operations
.
                   %IFDEF            PhoneTypeKY8
.
TSTPhoneType8
                   READ              PhoneTypeFL8,PhoneTypeKY8;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDPhoneType8
                   READ              PhoneTypeFL8,PhoneTypeKY8;PhoneType
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDPhoneType8LK
                   READLK            PhoneTypeFL8,PhoneTypeKY8;PhoneType
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSPhoneType8
                   READKS            PhoneTypeFL8;PhoneType
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSPhoneType8LK
                   READKSLK          PhoneTypeFL8;PhoneType
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPPhoneType8
                   READKP             PhoneTypeFL8;PhoneType
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPPhoneType8LK
                   READKPLK          PhoneTypeFL8;PhoneType
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Ninth file I/O operations
.
                   %IFDEF            PhoneTypeKY9
.
. Third set of File I/O operations
.
TSTPhoneType9
                   READ              PhoneTypeFL9,PhoneTypeKY9;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDPhoneType9
                   READ              PhoneTypeFL9,PhoneTypeKY9;PhoneType
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDPhoneType9LK
                   READLK            PhoneTypeFL9,PhoneTypeKY9;PhoneType
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSPhoneType9
                   READKS            PhoneTypeFL9;PhoneType
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSPhoneType9LK
                   READKSLK          PhoneTypeFL9;PhoneType
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPPhoneType9
                   READKP             PhoneTypeFL9;PhoneType
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPPhoneType9LK
                   READKPLK          PhoneTypeFL9;PhoneType
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Deletion for PRIMARY Index
.
DELPhoneType
..HR 6.6.2016                   READ              PhoneTypeFL,PhoneTypeKY;;
..HR 6.6.2016                   GOTO              #ERROR IF OVER
DELPhoneTypeLK
                   DELETE            PhoneTypeFLST
                   GOTO              #VALID
;==========================================================================================================
; Update I/O operation

UPDPhoneType
UPDPhoneTypeLK
                   UPDATE            PhoneTypeFLST;PhoneType
                   GOTO              #VALID
;==========================================================================================================
; Write I/O operation

WRTPhoneType
                   WRITE             PhoneTypeFLST;PhoneType
                   GOTO              #VALID
;==========================================================================================================
; Preparation of PhoneTypeer Transaction Files
;
PREPPhoneType
                   %IFDEF            PhoneTypeKY
                     PREPARE           PhoneTypeFL,PhoneTypeTXTNM,PhoneTypeISI1NM,PhoneTypeI1DEF,PhoneTypeFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            PhoneTypeKY2
                     PREPARE           PhoneTypeFL2,PhoneTypeTXTNM,PhoneTypeISI2NM,PhoneTypeI2DEF,PhoneTypeFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            PhoneTypeKY3
                     PREPARE           PhoneTypeFL3,PhoneTypeTXTNM,PhoneTypeISI3NM,PhoneTypeI3DEF,PhoneTypeFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            PhoneTypeKY4
                     PREPARE           PhoneTypeFL4,PhoneTypeTXTNM,PhoneTypeISI4NM,PhoneTypeI4DEF,PhoneTypeFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            PhoneTypeKY5
                     PREPARE           PhoneTypeFL5,PhoneTypeTXTNM,PhoneTypeISI5NM,PhoneTypeI5DEF,PhoneTypeFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            PhoneTypeKY6
                     PREPARE           PhoneTypeFL6,PhoneTypeTXTNM,PhoneTypeISI6NM,PhoneTypeI6DEF,PhoneTypeFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            PhoneTypeKY7
                     PREPARE           PhoneTypeFL7,PhoneTypeTXTNM,PhoneTypeISI7NM,PhoneTypeI7DEF,PhoneTypeFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            PhoneTypeKY8
                     PREPARE           PhoneTypeFL8,PhoneTypeTXTNM,PhoneTypeISI8NM,PhoneTypeI8DEF,PhoneTypeFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            PhoneTypeKY9
                     PREPARE           PhoneTypeFL9,PhoneTypeTXTNM,PhoneTypeISI9NM,PhoneTypeI9DEF,PhoneTypeFileSize,EXCLUSIVE
                   %ENDIF
                   RETURN
;==========================================================================================================
. Opening of PhoneTypeX File
.
OPENPhoneType
                   GETFILE           PhoneTypeFL
                   RETURN            IF ZERO
                   OPEN              PhoneTypeFLST,SHARE,LOCKMANUAL,SINGLE,NOWAIT
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

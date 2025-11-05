;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    4 NORFOLK LANE                                           ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    Phone.IO                                                       ;
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
                   %IFNDEF           $PhoneVAR
                     INCLUDE           PhoneER.FD
                   %ENDIF
.
                   %IFNDEF           $PhoneIO

                   goto              #S

$PhoneIO           EQUATE            1
;==========================================================================================================
; Test Read for PRIMARY Index

TSTPhone
                   READ              PhoneFL,PhoneKY;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDPhone
                   READ              PhoneFL,PhoneKY;PhoneREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDPhoneLK
                   READLK            PhoneFL,PhoneKY;PhoneREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSPhone
                   READKS            PhoneFL;PhoneREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSPhoneLK
                   READKSLK          PhoneFL;PhoneREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPPhone
                   READKP             PhoneFL;PhoneREC
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPPhoneLK
                   READKPLK          PhoneFL;PhoneREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
;==========================================================================================================
. Secondary file I/O operations
.
                   %IFDEF            PhoneKY2
TSTPhone2
                   READ              PhoneFL2,PhoneKY2;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDPhone2
                   READ              PhoneFL2,PhoneKY2;PhoneREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDPhone2LK
                   READLK            PhoneFL2,PhoneKY2;PhoneREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSPhone2
                   READKS            PhoneFL2;PhoneREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSPhone2LK
                   READKSLK          PhoneFL2;PhoneREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPPhone2
                   READKP             PhoneFL2;PhoneREC
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPPhone2LK
                   READKPLK          PhoneFL2;PhoneREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Third file I/O operations
.
                   %IFDEF            PhoneKY3
.
TSTPhone3
                   READ              PhoneFL3,PhoneKY3;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDPhone3
                   READ              PhoneFL3,PhoneKY3;PhoneREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDPhone3LK
                   READLK            PhoneFL3,PhoneKY3;PhoneREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSPhone3
                   READKS            PhoneFL3;PhoneREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSPhone3LK
                   READKSLK          PhoneFL3;PhoneREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPPhone3
                   READKP             PhoneFL3;PhoneREC
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPPhone3LK
                   READKPLK          PhoneFL3;PhoneREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Fourth file I/O operations
.
                   %IFDEF            PhoneKY4
.
TSTPhone4
                   READ              PhoneFL4,PhoneKY4;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDPhone4
                   READ              PhoneFL4,PhoneKY4;PhoneREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDPhone4LK
                   READLK            PhoneFL4,PhoneKY4;PhoneREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSPhone4
                   READKS            PhoneFL4;PhoneREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSPhone4LK
                   READKSLK          PhoneFL4;PhoneREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPPhone4
                   READKP             PhoneFL4;PhoneREC
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPPhone4LK
                   READKPLK          PhoneFL4;PhoneREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Fifth file I/O operations
.
                   %IFDEF            PhoneKY5
.
TSTPhone5
                   READ              PhoneFL5,PhoneKY5;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDPhone5
                   READ              PhoneFL5,PhoneKY5;PhoneREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDPhone5LK
                   READLK            PhoneFL5,PhoneKY5;PhoneREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSPhone5
                   READKS            PhoneFL5;PhoneREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSPhone5LK
                   READKSLK          PhoneFL5;PhoneREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPPhone5
                   READKP             PhoneFL5;PhoneREC
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPPhone5LK
                   READKPLK          PhoneFL5;PhoneREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Sixth file I/O operations
.
                   %IFDEF            PhoneKY6
.
TSTPhone6
                   READ              PhoneFL6,PhoneKY6;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDPhone6
                   READ              PhoneFL6,PhoneKY6;PhoneREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDPhone6LK
                   READLK            PhoneFL6,PhoneKY6;PhoneREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSPhone6
                   READKS            PhoneFL6;PhoneREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSPhone6LK
                   READKSLK          PhoneFL6;PhoneREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPPhone6
                   READKP             PhoneFL6;PhoneREC
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPPhone6LK

                   READKPLK          PhoneFL6;PhoneREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Seventh file I/O operations
.
                   %IFDEF            PhoneKY7
.
TSTPhone7
                   READ              PhoneFL7,PhoneKY7;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDPhone7
                   READ              PhoneFL7,PhoneKY7;PhoneREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDPhone7LK
                   READLK            PhoneFL7,PhoneKY7;PhoneREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSPhone7
                   READKS            PhoneFL7;PhoneREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSPhone7LK
                   READKSLK          PhoneFL7;PhoneREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPPhone7
                   READKP             PhoneFL7;PhoneREC
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPPhone7LK

                   READKPLK          PhoneFL7;PhoneREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Eighth file I/O operations
.
                   %IFDEF            PhoneKY8
.
TSTPhone8
                   READ              PhoneFL8,PhoneKY8;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDPhone8
                   READ              PhoneFL8,PhoneKY8;PhoneREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDPhone8LK
                   READLK            PhoneFL8,PhoneKY8;PhoneREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSPhone8
                   READKS            PhoneFL8;PhoneREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSPhone8LK
                   READKSLK          PhoneFL8;PhoneREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPPhone8
                   READKP             PhoneFL8;PhoneREC
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPPhone8LK
                   READKPLK          PhoneFL8;PhoneREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Ninth file I/O operations
.
                   %IFDEF            PhoneKY9
.
. Third set of File I/O operations
.
TSTPhone9
                   READ              PhoneFL9,PhoneKY9;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDPhone9
                   READ              PhoneFL9,PhoneKY9;PhoneREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDPhone9LK
                   READLK            PhoneFL9,PhoneKY9;PhoneREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSPhone9
                   READKS            PhoneFL9;PhoneREC
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSPhone9LK
                   READKSLK          PhoneFL9;PhoneREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPPhone9
                   READKP             PhoneFL9;PhoneREC
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPPhone9LK
                   READKPLK          PhoneFL9;PhoneREC
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Deletion for PRIMARY Index
.
DELPhone
                   READ              PhoneFL,PhoneKY;;
                   GOTO              #ERROR IF OVER
DELPhoneLK
                   DELETE            PhoneFLST
                   GOTO              #VALID
;==========================================================================================================
; Update I/O operation

UPDPhone
UPDPhoneLK
                   UPDATE            PhoneFLST;PhoneREC
                   GOTO              #VALID
;==========================================================================================================
; Write I/O operation

WRTPhone
                   WRITE             PhoneFLST;PhoneREC
                   GOTO              #VALID
;==========================================================================================================
; Preparation of Phoneer Transaction Files
;
PREPPhone
                   %IFDEF            PhoneKY
                     PREPARE           PhoneFL,PhoneTXTNM,PhoneISI1NM,PhoneI1DEF,PhoneFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            PhoneKY2
                     PREPARE           PhoneFL2,PhoneTXTNM,PhoneISI2NM,PhoneI2DEF,PhoneFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            PhoneKY3
                     PREPARE           PhoneFL3,PhoneTXTNM,PhoneISI3NM,PhoneI3DEF,PhoneFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            PhoneKY4
                     PREPARE           PhoneFL4,PhoneTXTNM,PhoneISI4NM,PhoneI4DEF,PhoneFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            PhoneKY5
                     PREPARE           PhoneFL5,PhoneTXTNM,PhoneISI5NM,PhoneI5DEF,PhoneFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            PhoneKY6
                     PREPARE           PhoneFL6,PhoneTXTNM,PhoneISI6NM,PhoneI6DEF,PhoneFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            PhoneKY7
                     PREPARE           PhoneFL7,PhoneTXTNM,PhoneISI7NM,PhoneI7DEF,PhoneFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            PhoneKY8
                     PREPARE           PhoneFL8,PhoneTXTNM,PhoneISI8NM,PhoneI8DEF,PhoneFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            PhoneKY9
                     PREPARE           PhoneFL9,PhoneTXTNM,PhoneISI9NM,PhoneI9DEF,PhoneFileSize,EXCLUSIVE
                   %ENDIF
                   RETURN
;==========================================================================================================
. Opening of PhoneX File
.
OPENPhone
                   GETFILE           PhoneFL
                   RETURN            IF ZERO
                   OPEN              PhoneFLST,SHARE,LOCKMANUAL,SINGLE,NOWAIT
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

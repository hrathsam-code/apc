;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    4 NORFOLK LANE                                           ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    ARFile.IO                                                       ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    06/06/2005 AT 12:35PM                                          ;
;                                                                             ;
;  PURPOSE:    AP Header Transaction Record Routines                          ;
;                                                                             ;
; REVISION:    VER     DATE     INIT       DETAILS                            ;
;                                                                             ;
;              1.0   06/01/2005   HOR     INITIAL VERSION                     ;
;                                                                             ;
;=============================================================================;

           %IFNDEF           $ARFileVAR
             INCLUDE           ARFile.FD
           %ENDIF
.
           %IFNDEF           $ARFileIO
$ARFileIO    EQUATE            1
.
. Test Read for PRIMARY Index
.
TSTARFile
           READ              ARFileFL,ARFileKY;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDARFile
           READ              ARFileFL,ARFileKY;ARFile
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDARFileLK
           READLK            ARFileFL,ARFileKY;ARFile
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSARFile
           READKS            ARFileFL;ARFile
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSARFileLK

           READKSLK          ARFileFL;ARFile
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPARFile
          READKP             ARFileFL;ARFile
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPARFileLK

           READKPLK          ARFileFL;ARFile
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.=============================================================================
. Secondary file I/O operations
.
           %IFDEF            ARFileKY2
TSTARFile2
           READ              ARFileFL2,ARFileKY2;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDARFile2
           READ              ARFileFL2,ARFileKY2;ARFile
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDARFile2LK
           READLK            ARFileFL2,ARFileKY2;ARFile
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSARFile2
           READKS            ARFileFL2;ARFile
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSARFile2LK

           READKSLK          ARFileFL2;ARFile
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPARFile2
          READKP             ARFileFL2;ARFile
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPARFile2LK
           READKPLK          ARFileFL2;ARFile
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Third file I/O operations
.
           %IFDEF            ARFileKY3
.
TSTARFile3
           READ              ARFileFL3,ARFileKY3;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDARFile3
           READ              ARFileFL3,ARFileKY3;ARFile
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDARFile3LK
           READLK            ARFileFL3,ARFileKY3;ARFile
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSARFile3
           READKS            ARFileFL3;ARFile
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSARFile3LK

           READKSLK          ARFileFL3;ARFile
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPARFile3
          READKP             ARFileFL3;ARFile
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPARFile3LK

           READKPLK          ARFileFL3;ARFile
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fourth file I/O operations
.
           %IFDEF            ARFileKY4
.
TSTARFile4
           READ              ARFileFL4,ARFileKY4;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDARFile4
           READ              ARFileFL4,ARFileKY4;ARFile
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDARFile4LK
           READLK            ARFileFL4,ARFileKY4;ARFile
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSARFile4
           READKS            ARFileFL4;ARFile
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSARFile4LK

           READKSLK          ARFileFL4;ARFile
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPARFile4
          READKP             ARFileFL4;ARFile
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPARFile4LK

           READKPLK          ARFileFL4;ARFile
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fifth file I/O operations
.
           %IFDEF            ARFileKY5
.
TSTARFile5
           READ              ARFileFL5,ARFileKY5;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDARFile5
           READ              ARFileFL5,ARFileKY5;ARFile
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDARFile5LK
           READLK            ARFileFL5,ARFileKY5;ARFile
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSARFile5
           READKS            ARFileFL5;ARFile
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSARFile5LK

           READKSLK          ARFileFL5;ARFile
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPARFile5
          READKP             ARFileFL5;ARFile
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPARFile5LK

           READKPLK          ARFileFL5;ARFile
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Sixth file I/O operations
.
           %IFDEF            ARFileKY6
.
TSTARFile6
           READ              ARFileFL6,ARFileKY6;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDARFile6
           READ              ARFileFL6,ARFileKY6;ARFile
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDARFile6LK
           READLK            ARFileFL6,ARFileKY6;ARFile
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSARFile6
           READKS            ARFileFL6;ARFile
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSARFile6LK

           READKSLK          ARFileFL6;ARFile
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPARFile6
          READKP             ARFileFL6;ARFile
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPARFile6LK

           READKPLK          ARFileFL6;ARFile
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Seventh file I/O operations
.
           %IFDEF            ARFileKY7
.
TSTARFile7
           READ              ARFileFL7,ARFileKY7;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDARFile7
           READ              ARFileFL7,ARFileKY7;ARFile
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDARFile7LK
           READLK            ARFileFL7,ARFileKY7;ARFile
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSARFile7
           READKS            ARFileFL7;ARFile
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSARFile7LK

           READKSLK          ARFileFL7;ARFile
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPARFile7
          READKP             ARFileFL7;ARFile
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPARFile7LK

           READKPLK          ARFileFL7;ARFile
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Eighth file I/O operations
.
           %IFDEF            ARFileKY8
.
TSTARFile8
           READ              ARFileFL8,ARFileKY8;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDARFile8
           READ              ARFileFL8,ARFileKY8;ARFile
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDARFile8LK
           READLK            ARFileFL8,ARFileKY8;ARFile
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSARFile8
           READKS            ARFileFL8;ARFile
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSARFile8LK

           READKSLK          ARFileFL8;ARFile
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPARFile8
          READKP             ARFileFL8;ARFile
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPARFile8LK

           READKPLK          ARFileFL8;ARFile
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Ninth file I/O operations
.
           %IFDEF            ARFileKY9
.
. Third set of File I/O operations
.
TSTARFile9
           READ              ARFileFL9,ARFileKY9;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDARFile9
           READ              ARFileFL9,ARFileKY9;ARFile
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDARFile9LK
           READLK            ARFileFL9,ARFileKY9;ARFile
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSARFile9
           READKS            ARFileFL9;ARFile
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSARFile9LK

           READKSLK          ARFileFL9;ARFile
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPARFile9
          READKP             ARFileFL9;ARFile
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPARFile9LK

           READKPLK          ARFileFL9;ARFile
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.
.=============================================================================
.
. Deletion for PRIMARY Index
.
DELARFile
           READ              ARFileFL,ARFileKY;;
           GOTO              #ERROR IF OVER
DELARFileLK
           DELETE            ARFileFLST
           GOTO              #VALID
.
. Update I/O operation
.
UPDARFile
.           READ              ARFileFL,ARFileKY;;
.           GOTO              #ERROR IF OVER
UPDARFileLK
           UPDATE            ARFileFLST;ARFile
           GOTO              #VALID
.
. Write I/O operation
.
WRTARFile
           WRITE             ARFileFLST;ARFile
           GOTO              #VALID
.
. Preparation of ARFileer Transaction Files
.
PREPARFile
           %IFDEF            ARFileKY
             PREPARE           ARFileFL,ARFileTXTNM,ARFileISI1NM,ARFileI1DEF,ARFileFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            ARFileKY2
             PREPARE           ARFileFL2,ARFileTXTNM,ARFileISI2NM,ARFileI2DEF,ARFileFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            ARFileKY3
             PREPARE           ARFileFL3,ARFileTXTNM,ARFileISI3NM,ARFileI3DEF,ARFileFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            ARFileKY4
             PREPARE           ARFileFL4,ARFileTXTNM,ARFileISI4NM,ARFileI4DEF,ARFileFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            ARFileKY5
             PREPARE           ARFileFL5,ARFileTXTNM,ARFileISI5NM,ARFileI5DEF,ARFileFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            ARFileKY6
             PREPARE           ARFileFL6,ARFileTXTNM,ARFileISI6NM,ARFileI6DEF,ARFileFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            ARFileKY7
             PREPARE           ARFileFL7,ARFileTXTNM,ARFileISI7NM,ARFileI7DEF,ARFileFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            ARFileKY8
             PREPARE           ARFileFL8,ARFileTXTNM,ARFileISI8NM,ARFileI8DEF,ARFileFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            ARFileKY9
             PREPARE           ARFileFL9,ARFileTXTNM,ARFileISI9NM,ARFileI9DEF,ARFileFSIZE,EXCLUSIVE
           %ENDIF
           RETURN

.
. Opening of Check Register Transaction File
.
OPENARFile
           GETFILE           ARFileFL
           RETURN            IF ZERO
           OPEN              ARFileFLST,SHARE,LOCKMANUAL,SINGLE,NOWAIT
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

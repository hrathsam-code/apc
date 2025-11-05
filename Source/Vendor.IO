;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    4 NORFOLK LANE                                           ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    Vendor.IO                                                      ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
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
           %IFNDEF           $VendorVAR
             INCLUDE           VendorER.FD
           %ENDIF
.
           GOTO                 #s

           %IFNDEF           $VendorIO
$VendorIO    EQUATE            1
.
. Test Read for PRIMARY Index
.
TSTVendor
           READ              VendorFL,VendorKY;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDVendor
           READ              VendorFL,VendorKY;Vendor
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDVendorLK
           READLK            VendorFL,VendorKY;Vendor
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSVendor
           READKS            VendorFL;Vendor
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSVendorLK

           READKSLK          VendorFL;Vendor
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPVendor
          READKP             VendorFL;Vendor
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPVendorLK

           READKPLK          VendorFL;Vendor
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.=============================================================================
. Secondary file I/O operations
.
           %IFDEF            VendorKY2
TSTVendor2
           READ              VendorFL2,VendorKY2;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDVendor2
           READ              VendorFL2,VendorKY2;Vendor
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDVendor2LK
           READLK            VendorFL2,VendorKY2;Vendor
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSVendor2
           READKS            VendorFL2;Vendor
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSVendor2LK

           READKSLK          VendorFL2;Vendor
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPVendor2
          READKP             VendorFL2;Vendor
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPVendor2LK
           READKPLK          VendorFL2;Vendor
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Third file I/O operations
.
           %IFDEF            VendorKY3
.
TSTVendor3
           READ              VendorFL3,VendorKY3;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDVendor3
           READ              VendorFL3,VendorKY3;Vendor
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDVendor3LK
           READLK            VendorFL3,VendorKY3;Vendor
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSVendor3
           READKS            VendorFL3;Vendor
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSVendor3LK

           READKSLK          VendorFL3;Vendor
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPVendor3
          READKP             VendorFL3;Vendor
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPVendor3LK

           READKPLK          VendorFL3;Vendor
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fourth file I/O operations
.
           %IFDEF            VendorKY4
.
TSTVendor4
           READ              VendorFL4,VendorKY4;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDVendor4
           READ              VendorFL4,VendorKY4;Vendor
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDVendor4LK
           READLK            VendorFL4,VendorKY4;Vendor
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSVendor4
           READKS            VendorFL4;Vendor
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSVendor4LK

           READKSLK          VendorFL4;Vendor
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPVendor4
          READKP             VendorFL4;Vendor
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPVendor4LK

           READKPLK          VendorFL4;Vendor
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fifth file I/O operations
.
           %IFDEF            VendorKY5
.
TSTVendor5
           READ              VendorFL5,VendorKY5;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDVendor5
           READ              VendorFL5,VendorKY5;Vendor
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDVendor5LK
           READLK            VendorFL5,VendorKY5;Vendor
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSVendor5
           READKS            VendorFL5;Vendor
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSVendor5LK

           READKSLK          VendorFL5;Vendor
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPVendor5
          READKP             VendorFL5;Vendor
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPVendor5LK

           READKPLK          VendorFL5;Vendor
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Sixth file I/O operations
.
           %IFDEF            VendorKY6
.
TSTVendor6
           READ              VendorFL6,VendorKY6;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDVendor6
           READ              VendorFL6,VendorKY6;Vendor
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDVendor6LK
           READLK            VendorFL6,VendorKY6;Vendor
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSVendor6
           READKS            VendorFL6;Vendor
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSVendor6LK

           READKSLK          VendorFL6;Vendor
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPVendor6
          READKP             VendorFL6;Vendor
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPVendor6LK

           READKPLK          VendorFL6;Vendor
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Seventh file I/O operations
.
           %IFDEF            VendorKY7
.
TSTVendor7
           READ              VendorFL7,VendorKY7;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDVendor7
           READ              VendorFL7,VendorKY7;Vendor
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDVendor7LK
           READLK            VendorFL7,VendorKY7;Vendor
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSVendor7
           READKS            VendorFL7;Vendor
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSVendor7LK

           READKSLK          VendorFL7;Vendor
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPVendor7
          READKP             VendorFL7;Vendor
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPVendor7LK

           READKPLK          VendorFL7;Vendor
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Eighth file I/O operations
.
           %IFDEF            VendorKY8
.
TSTVendor8
           READ              VendorFL8,VendorKY8;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDVendor8
           READ              VendorFL8,VendorKY8;Vendor
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDVendor8LK
           READLK            VendorFL8,VendorKY8;Vendor
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSVendor8
           READKS            VendorFL8;Vendor
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSVendor8LK

           READKSLK          VendorFL8;Vendor
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPVendor8
          READKP             VendorFL8;Vendor
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPVendor8LK

           READKPLK          VendorFL8;Vendor
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Ninth file I/O operations
.
           %IFDEF            VendorKY9
.
. Third set of File I/O operations
.
TSTVendor9
           READ              VendorFL9,VendorKY9;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDVendor9
           READ              VendorFL9,VendorKY9;Vendor
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDVendor9LK
           READLK            VendorFL9,VendorKY9;Vendor
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSVendor9
           READKS            VendorFL9;Vendor
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSVendor9LK

           READKSLK          VendorFL9;Vendor
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPVendor9
          READKP             VendorFL9;Vendor
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPVendor9LK

           READKPLK          VendorFL9;Vendor
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.
.=============================================================================
.
. Deletion for PRIMARY Index
.
DELVendor
.           READ              VendorFL,VendorKY;;
           GOTO              #ERROR IF OVER
DELVendorLK
           DELETE            VendorFLST
           GOTO              #VALID
.
. Update I/O operation
.
UPDVendor
.           READ              VendorFL,VendorKY;;
.           GOTO              #ERROR IF OVER
UPDVendorLK
           UPDATE            VendorFLST;Vendor
           GOTO              #VALID
.
. Write I/O operation
.
WRTVendor
           WRITE             VendorFLST;Vendor
           GOTO              #VALID
.
. Preparation of Vendorer Transaction Files
.
PREPVendor
           %IFDEF            VendorKY
             PREPARE           VendorFL,VendorTXTNM,VendorISI1NM,VendorI1DEF,VendorFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            VendorKY2
             PREPARE           VendorFL2,VendorTXTNM,VendorISI2NM,VendorI2DEF,VendorFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            VendorKY3
             PREPARE           VendorFL3,VendorTXTNM,VendorISI3NM,VendorI3DEF,VendorFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            VendorKY4
             PREPARE           VendorFL4,VendorTXTNM,VendorISI4NM,VendorI4DEF,VendorFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            VendorKY5
             PREPARE           VendorFL5,VendorTXTNM,VendorISI5NM,VendorI5DEF,VendorFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            VendorKY6
             PREPARE           VendorFL6,VendorTXTNM,VendorISI6NM,VendorI6DEF,VendorFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            VendorKY7
             PREPARE           VendorFL7,VendorTXTNM,VendorISI7NM,VendorI7DEF,VendorFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            VendorKY8
             PREPARE           VendorFL8,VendorTXTNM,VendorISI8NM,VendorI8DEF,VendorFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            VendorKY9
             PREPARE           VendorFL9,VendorTXTNM,VendorISI9NM,VendorI9DEF,VendorFSIZE,EXCLUSIVE
           %ENDIF
           RETURN

.
. Opening of Check Register Transaction File
.
OPENVendor
           GETFILE           VendorFL
           RETURN            IF ZERO
           OPEN              VendorFLST,SHARE,LOCKMANUAL,SINGLE,NOWAIT
           RETURN
;=============================================================================
.
. Test Read for PRIMARY Index
.
TSTVendorGL
           READ              VendorGLFL,VendorGLKY;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDVendorGL
           READ              VendorGLFL,VendorGLKY;VendorGL
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDVendorGLLK
           READLK            VendorGLFL,VendorGLKY;VendorGL
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSVendorGL
           READKS            VendorGLFL;VendorGL
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSVendorGLLK

           READKSLK          VendorGLFL;VendorGL
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPVendorGL
          READKP             VendorGLFL;VendorGL
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPVendorGLLK

           READKPLK          VendorGLFL;VendorGL
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.=============================================================================
. Secondary file I/O operations
.
           %IFDEF            VendorGLKY2
TSTVendorGL2
           READ              VendorGLFL2,VendorGLKY2;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDVendorGL2
           READ              VendorGLFL2,VendorGLKY2;VendorGL
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDVendorGL2LK
           READLK            VendorGLFL2,VendorGLKY2;VendorGL
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSVendorGL2
           READKS            VendorGLFL2;VendorGL
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSVendorGL2LK

           READKSLK          VendorGLFL2;VendorGL
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPVendorGL2
          READKP             VendorGLFL2;VendorGL
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPVendorGL2LK
           READKPLK          VendorGLFL2;VendorGL
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Third file I/O operations
.
           %IFDEF            VendorGLKY3
.
TSTVendorGL3
           READ              VendorGLFL3,VendorGLKY3;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDVendorGL3
           READ              VendorGLFL3,VendorGLKY3;VendorGL
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDVendorGL3LK
           READLK            VendorGLFL3,VendorGLKY3;VendorGL
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSVendorGL3
           READKS            VendorGLFL3;VendorGL
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSVendorGL3LK

           READKSLK          VendorGLFL3;VendorGL
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPVendorGL3
          READKP             VendorGLFL3;VendorGL
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPVendorGL3LK

           READKPLK          VendorGLFL3;VendorGL
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fourth file I/O operations
.
           %IFDEF            VendorGLKY4
.
TSTVendorGL4
           READ              VendorGLFL4,VendorGLKY4;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDVendorGL4
           READ              VendorGLFL4,VendorGLKY4;VendorGL
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDVendorGL4LK
           READLK            VendorGLFL4,VendorGLKY4;VendorGL
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSVendorGL4
           READKS            VendorGLFL4;VendorGL
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSVendorGL4LK

           READKSLK          VendorGLFL4;VendorGL
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPVendorGL4
          READKP             VendorGLFL4;VendorGL
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPVendorGL4LK

           READKPLK          VendorGLFL4;VendorGL
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fifth file I/O operations
.
           %IFDEF            VendorGLKY5
.
TSTVendorGL5
           READ              VendorGLFL5,VendorGLKY5;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDVendorGL5
           READ              VendorGLFL5,VendorGLKY5;VendorGL
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDVendorGL5LK
           READLK            VendorGLFL5,VendorGLKY5;VendorGL
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSVendorGL5
           READKS            VendorGLFL5;VendorGL
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSVendorGL5LK

           READKSLK          VendorGLFL5;VendorGL
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPVendorGL5
          READKP             VendorGLFL5;VendorGL
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPVendorGL5LK

           READKPLK          VendorGLFL5;VendorGL
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Sixth file I/O operations
.
           %IFDEF            VendorGLKY6
.
TSTVendorGL6
           READ              VendorGLFL6,VendorGLKY6;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDVendorGL6
           READ              VendorGLFL6,VendorGLKY6;VendorGL
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDVendorGL6LK
           READLK            VendorGLFL6,VendorGLKY6;VendorGL
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSVendorGL6
           READKS            VendorGLFL6;VendorGL
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSVendorGL6LK

           READKSLK          VendorGLFL6;VendorGL
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPVendorGL6
          READKP             VendorGLFL6;VendorGL
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPVendorGL6LK

           READKPLK          VendorGLFL6;VendorGL
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Seventh file I/O operations
.
           %IFDEF            VendorGLKY7
.
TSTVendorGL7
           READ              VendorGLFL7,VendorGLKY7;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDVendorGL7
           READ              VendorGLFL7,VendorGLKY7;VendorGL
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDVendorGL7LK
           READLK            VendorGLFL7,VendorGLKY7;VendorGL
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSVendorGL7
           READKS            VendorGLFL7;VendorGL
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSVendorGL7LK

           READKSLK          VendorGLFL7;VendorGL
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPVendorGL7
          READKP             VendorGLFL7;VendorGL
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPVendorGL7LK

           READKPLK          VendorGLFL7;VendorGL
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Eighth file I/O operations
.
           %IFDEF            VendorGLKY8
.
TSTVendorGL8
           READ              VendorGLFL8,VendorGLKY8;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDVendorGL8
           READ              VendorGLFL8,VendorGLKY8;VendorGL
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDVendorGL8LK
           READLK            VendorGLFL8,VendorGLKY8;VendorGL
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSVendorGL8
           READKS            VendorGLFL8;VendorGL
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSVendorGL8LK

           READKSLK          VendorGLFL8;VendorGL
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPVendorGL8
          READKP             VendorGLFL8;VendorGL
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPVendorGL8LK

           READKPLK          VendorGLFL8;VendorGL
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Ninth file I/O operations
.
           %IFDEF            VendorGLKY9
.
. Third set of File I/O operations
.
TSTVendorGL9
           READ              VendorGLFL9,VendorGLKY9;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDVendorGL9
           READ              VendorGLFL9,VendorGLKY9;VendorGL
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDVendorGL9LK
           READLK            VendorGLFL9,VendorGLKY9;VendorGL
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSVendorGL9
           READKS            VendorGLFL9;VendorGL
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSVendorGL9LK

           READKSLK          VendorGLFL9;VendorGL
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPVendorGL9
          READKP             VendorGLFL9;VendorGL
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPVendorGL9LK

           READKPLK          VendorGLFL9;VendorGL
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.
.=============================================================================
.
. Deletion for PRIMARY Index
.
DELVendorGL
.           READ              VendorGLFL,VendorGLKY;;
           GOTO              #ERROR IF OVER
DELVendorGLLK
           DELETE            VendorGLFLST
           GOTO              #VALID
.
. Update I/O operation
.
UPDVendorGL
.           READ              VendorGLFL,VendorGLKY;;
.           GOTO              #ERROR IF OVER
UPDVendorGLLK
           UPDATE            VendorGLFLST;VendorGL
           GOTO              #VALID
.
. Write I/O operation
.
WRTVendorGL
           WRITE             VendorGLFLST;VendorGL
           GOTO              #VALID
.
. Preparation of VendorGLer Transaction Files
.
PREPVendorGL
           %IFDEF            VendorGLKY
             PREPARE           VendorGLFL,VendorGLTXTNM,VendorGLISI1NM,VendorGLI1DEF,VendorGLFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            VendorGLKY2
             PREPARE           VendorGLFL2,VendorGLTXTNM,VendorGLISI2NM,VendorGLI2DEF,VendorGLFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            VendorGLKY3
             PREPARE           VendorGLFL3,VendorGLTXTNM,VendorGLISI3NM,VendorGLI3DEF,VendorGLFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            VendorGLKY4
             PREPARE           VendorGLFL4,VendorGLTXTNM,VendorGLISI4NM,VendorGLI4DEF,VendorGLFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            VendorGLKY5
             PREPARE           VendorGLFL5,VendorGLTXTNM,VendorGLISI5NM,VendorGLI5DEF,VendorGLFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            VendorGLKY6
             PREPARE           VendorGLFL6,VendorGLTXTNM,VendorGLISI6NM,VendorGLI6DEF,VendorGLFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            VendorGLKY7
             PREPARE           VendorGLFL7,VendorGLTXTNM,VendorGLISI7NM,VendorGLI7DEF,VendorGLFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            VendorGLKY8
             PREPARE           VendorGLFL8,VendorGLTXTNM,VendorGLISI8NM,VendorGLI8DEF,VendorGLFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            VendorGLKY9
             PREPARE           VendorGLFL9,VendorGLTXTNM,VendorGLISI9NM,VendorGLI9DEF,VendorGLFSIZE,EXCLUSIVE
           %ENDIF
           RETURN

.
. Opening of Check Register Transaction File
.
OPENVendorGL
           GETFILE           VendorGLFL
           RETURN            IF ZERO
           OPEN              VendorGLFLST,SHARE,LOCKMANUAL,SINGLE,NOWAIT
           RETURN
.
;=============================================================================
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
#s

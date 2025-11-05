;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    4 NORFOLK LANE                                           ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    Customer.IO                                                       ;
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
                   %IFNDEF           $CustomerVAR
                     INCLUDE           Customer.FD
                   %ENDIF
.
                   %IFNDEF           $CustomerIO

                   goto              #S

$CustomerIO           EQUATE            1
;==========================================================================================================
; Test Read for PRIMARY Index

TSTCustomer
                   READ              CustomerFL,CustomerKY;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCustomer
                   READ              CustomerFL,CustomerKY;Customer
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCustomerLK
                   READLK            CustomerFL,CustomerKY;Customer
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCustomer
                   READKS            CustomerFL;Customer
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCustomerLK
                   READKSLK          CustomerFL;Customer
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCustomer
                   READKP             CustomerFL;Customer
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCustomerLK
                   READKPLK          CustomerFL;Customer
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
;==========================================================================================================
. Secondary file I/O operations
.
                   %IFDEF            CustomerKY2
TSTCustomer2
                   READ              CustomerFL2,CustomerKY2;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCustomer2
                   READ              CustomerFL2,CustomerKY2;Customer
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCustomer2LK
                   READLK            CustomerFL2,CustomerKY2;Customer
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCustomer2
                   READKS            CustomerFL2;Customer
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCustomer2LK
                   READKSLK          CustomerFL2;Customer
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCustomer2
                   READKP             CustomerFL2;Customer
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCustomer2LK
                   READKPLK          CustomerFL2;Customer
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Third file I/O operations
.
                   %IFDEF            CustomerKY3
.
TSTCustomer3
                   READ              CustomerFL3,CustomerKY3;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCustomer3
                   READ              CustomerFL3,CustomerKY3;Customer
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCustomer3LK
                   READLK            CustomerFL3,CustomerKY3;Customer
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCustomer3
                   READKS            CustomerFL3;Customer
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCustomer3LK
                   READKSLK          CustomerFL3;Customer
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCustomer3
                   READKP             CustomerFL3;Customer
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCustomer3LK
                   READKPLK          CustomerFL3;Customer
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Fourth file I/O operations
.
                   %IFDEF            CustomerKY4
.
TSTCustomer4
                   READ              CustomerFL4,CustomerKY4;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCustomer4
                   READ              CustomerFL4,CustomerKY4;Customer
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCustomer4LK
                   READLK            CustomerFL4,CustomerKY4;Customer
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCustomer4
                   READKS            CustomerFL4;Customer
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCustomer4LK
                   READKSLK          CustomerFL4;Customer
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCustomer4
                   READKP             CustomerFL4;Customer
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCustomer4LK
                   READKPLK          CustomerFL4;Customer
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Fifth file I/O operations
.
                   %IFDEF            CustomerKY5
.
TSTCustomer5
                   READ              CustomerFL5,CustomerKY5;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCustomer5
                   READ              CustomerFL5,CustomerKY5;Customer
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCustomer5LK
                   READLK            CustomerFL5,CustomerKY5;Customer
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCustomer5
                   READKS            CustomerFL5;Customer
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCustomer5LK
                   READKSLK          CustomerFL5;Customer
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCustomer5
                   READKP             CustomerFL5;Customer
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCustomer5LK
                   READKPLK          CustomerFL5;Customer
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Sixth file I/O operations
.
                   %IFDEF            CustomerKY6
.
TSTCustomer6
                   READ              CustomerFL6,CustomerKY6;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCustomer6
                   READ              CustomerFL6,CustomerKY6;Customer
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCustomer6LK
                   READLK            CustomerFL6,CustomerKY6;Customer
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCustomer6
                   READKS            CustomerFL6;Customer
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCustomer6LK
                   READKSLK          CustomerFL6;Customer
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCustomer6
                   READKP             CustomerFL6;Customer
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCustomer6LK

                   READKPLK          CustomerFL6;Customer
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Seventh file I/O operations
.
                   %IFDEF            CustomerKY7
.
TSTCustomer7
                   READ              CustomerFL7,CustomerKY7;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCustomer7
                   READ              CustomerFL7,CustomerKY7;Customer
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCustomer7LK
                   READLK            CustomerFL7,CustomerKY7;Customer
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCustomer7
                   READKS            CustomerFL7;Customer
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCustomer7LK
                   READKSLK          CustomerFL7;Customer
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCustomer7
                   READKP             CustomerFL7;Customer
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCustomer7LK

                   READKPLK          CustomerFL7;Customer
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Eighth file I/O operations
.
                   %IFDEF            CustomerKY8
.
TSTCustomer8
                   READ              CustomerFL8,CustomerKY8;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCustomer8
                   READ              CustomerFL8,CustomerKY8;Customer
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCustomer8LK
                   READLK            CustomerFL8,CustomerKY8;Customer
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCustomer8
                   READKS            CustomerFL8;Customer
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCustomer8LK
                   READKSLK          CustomerFL8;Customer
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCustomer8
                   READKP             CustomerFL8;Customer
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCustomer8LK
                   READKPLK          CustomerFL8;Customer
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Ninth file I/O operations
.
                   %IFDEF            CustomerKY9
.
. Third set of File I/O operations
.
TSTCustomer9
                   READ              CustomerFL9,CustomerKY9;;
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCustomer9
                   READ              CustomerFL9,CustomerKY9;Customer
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCustomer9LK
                   READLK            CustomerFL9,CustomerKY9;Customer
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCustomer9
                   READKS            CustomerFL9;Customer
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCustomer9LK
                   READKSLK          CustomerFL9;Customer
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCustomer9
                   READKP             CustomerFL9;Customer
                   GOTO               #ERROR IF OVER
                   GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCustomer9LK
                   READKPLK          CustomerFL9;Customer
                   GOTO              #LOCKED IF LESS
                   GOTO              #ERROR IF OVER
                   GOTO              #VALID
                   %ENDIF
;==========================================================================================================
. Deletion for PRIMARY Index
.
DELCustomer
..HR 6.6.2016                   READ              CustomerFL,CustomerKY;;
..HR 6.6.2016                   GOTO              #ERROR IF OVER
DELCustomerLK
                   DELETE            CustomerFLST
                   GOTO              #VALID
;==========================================================================================================
; Update I/O operation

UPDCustomer
UPDCustomerLK
                   UPDATE            CustomerFLST;Customer
                   GOTO              #VALID
;==========================================================================================================
; Write I/O operation

WRTCustomer
                   WRITE             CustomerFLST;Customer
                   GOTO              #VALID
;==========================================================================================================
; Preparation of Customerer Transaction Files
;
PREPCustomer
                   %IFDEF            CustomerKY
                     PREPARE           CustomerFL,CustomerTXTNM,CustomerISI1NM,CustomerI1DEF,CustomerFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            CustomerKY2
                     PREPARE           CustomerFL2,CustomerTXTNM,CustomerISI2NM,CustomerI2DEF,CustomerFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            CustomerKY3
                     PREPARE           CustomerFL3,CustomerTXTNM,CustomerISI3NM,CustomerI3DEF,CustomerFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            CustomerKY4
                     PREPARE           CustomerFL4,CustomerTXTNM,CustomerISI4NM,CustomerI4DEF,CustomerFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            CustomerKY5
                     PREPARE           CustomerFL5,CustomerTXTNM,CustomerISI5NM,CustomerI5DEF,CustomerFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            CustomerKY6
                     PREPARE           CustomerFL6,CustomerTXTNM,CustomerISI6NM,CustomerI6DEF,CustomerFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            CustomerKY7
                     PREPARE           CustomerFL7,CustomerTXTNM,CustomerISI7NM,CustomerI7DEF,CustomerFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            CustomerKY8
                     PREPARE           CustomerFL8,CustomerTXTNM,CustomerISI8NM,CustomerI8DEF,CustomerFileSize,EXCLUSIVE
                   %ENDIF

                   %IFDEF            CustomerKY9
                     PREPARE           CustomerFL9,CustomerTXTNM,CustomerISI9NM,CustomerI9DEF,CustomerFileSize,EXCLUSIVE
                   %ENDIF
                   RETURN
;==========================================================================================================
. Opening of CustomerX File
.
OPENCustomer
                   GETFILE           CustomerFL
                   RETURN            IF ZERO
                   OPEN              CustomerFLST,SHARE,LOCKMANUAL,SINGLE,NOWAIT
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

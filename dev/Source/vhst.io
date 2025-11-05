;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    4 NORFOLK LANE                                           ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    VHST.IO                                                        ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    06/09/2005 AT 10:47PM                                          ;
;                                                                             ;
;  PURPOSE:    Vendor History records                                         ;
;                                                                             ;
; REVISION:    VER     DATE     INIT       DETAILS                            ;
;                                                                             ;
;              1.0   06/09/2005   HOR     INITIAL VERSION                     ;
;                                                                             ;
;=============================================================================;
.
           %IFNDEF           $VHSTVAR
             INCLUDE           VHST.FD
           %ENDIF
.
           %IFNDEF           $VHSTIO
$VHSTIO    EQUATE            1
.
. Test Read for PRIMARY Index
.
TSTVHST
           READ              VHSTFL,VHSTKY;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDVHST
           READ              VHSTFL,VHSTKY;VendorHistory
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDVHSTLK
           READLK            VHSTFL,VHSTKY;VendorHistory
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSVHST
           READKS            VHSTFL;VendorHistory
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSVHSTLK

           READKSLK          VHSTFL;VendorHistory
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPVHST
          READKP             VHSTFL;VendorHistory
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPVHSTLK

           READKPLK          VHSTFL;VendorHistory
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.=============================================================================
. Secondary file I/O operations
.
           %IFDEF            VHSTKY2
TSTVHST2
           READ              VHSTFL2,VHSTKY2;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDVHST2
           READ              VHSTFL2,VHSTKY2;VendorHistory
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDVHST2LK
           READLK            VHSTFL2,VHSTKY2;VendorHistory
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSVHST2
           READKS            VHSTFL2;VendorHistory
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSVHST2LK

           READKSLK          VHSTFL2;VendorHistory
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPVHST2
          READKP             VHSTFL2;VendorHistory
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPVHST2LK
           READKPLK          VHSTFL2;VendorHistory
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Third file I/O operations
.
           %IFDEF            VHSTKY3
.
TSTVHST3
           READ              VHSTFL3,VHSTKY3;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDVHST3
           READ              VHSTFL3,VHSTKY3;VendorHistory
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDVHST3LK
           READLK            VHSTFL3,VHSTKY3;VendorHistory
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSVHST3
           READKS            VHSTFL3;VendorHistory
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSVHST3LK

           READKSLK          VHSTFL3;VendorHistory
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPVHST3
          READKP             VHSTFL3;VendorHistory
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPVHST3LK

           READKPLK          VHSTFL3;VendorHistory
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fourth file I/O operations
.
           %IFDEF            VHSTKY4
.
TSTVHST4
           READ              VHSTFL4,VHSTKY4;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDVHST4
           READ              VHSTFL4,VHSTKY4;VendorHistory
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDVHST4LK
           READLK            VHSTFL4,VHSTKY4;VendorHistory
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSVHST4
           READKS            VHSTFL4;VendorHistory
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSVHST4LK

           READKSLK          VHSTFL4;VendorHistory
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPVHST4
          READKP             VHSTFL4;VendorHistory
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPVHST4LK

           READKPLK          VHSTFL4;VendorHistory
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fifth file I/O operations
.
           %IFDEF            VHSTKY5
.
TSTVHST5
           READ              VHSTFL5,VHSTKY5;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDVHST5
           READ              VHSTFL5,VHSTKY5;VendorHistory
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDVHST5LK
           READLK            VHSTFL5,VHSTKY5;VendorHistory
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSVHST5
           READKS            VHSTFL5;VendorHistory
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSVHST5LK

           READKSLK          VHSTFL5;VendorHistory
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPVHST5
          READKP             VHSTFL5;VendorHistory
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPVHST5LK

           READKPLK          VHSTFL5;VendorHistory
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Sixth file I/O operations
.
           %IFDEF            VHSTKY6
.
TSTVHST6
           READ              VHSTFL6,VHSTKY6;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDVHST6
           READ              VHSTFL6,VHSTKY6;VendorHistory
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDVHST6LK
           READLK            VHSTFL6,VHSTKY6;VendorHistory
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSVHST6
           READKS            VHSTFL6;VendorHistory
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSVHST6LK

           READKSLK          VHSTFL6;VendorHistory
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPVHST6
          READKP             VHSTFL6;VendorHistory
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPVHST6LK

           READKPLK          VHSTFL6;VendorHistory
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Seventh file I/O operations
.
           %IFDEF            VHSTKY7
.
TSTVHST7
           READ              VHSTFL7,VHSTKY7;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDVHST7
           READ              VHSTFL7,VHSTKY7;VendorHistory
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDVHST7LK
           READLK            VHSTFL7,VHSTKY7;VendorHistory
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSVHST7
           READKS            VHSTFL7;VendorHistory
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSVHST7LK

           READKSLK          VHSTFL7;VendorHistory
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPVHST7
          READKP             VHSTFL7;VendorHistory
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPVHST7LK

           READKPLK          VHSTFL7;VendorHistory
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Eighth file I/O operations
.
           %IFDEF            VHSTKY8
.
TSTVHST8
           READ              VHSTFL8,VHSTKY8;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDVHST8
           READ              VHSTFL8,VHSTKY8;VendorHistory
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDVHST8LK
           READLK            VHSTFL8,VHSTKY8;VendorHistory
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSVHST8
           READKS            VHSTFL8;VendorHistory
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSVHST8LK

           READKSLK          VHSTFL8;VendorHistory
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPVHST8
          READKP             VHSTFL8;VendorHistory
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPVHST8LK

           READKPLK          VHSTFL8;VendorHistory
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Ninth file I/O operations
.
           %IFDEF            VHSTKY9
.
. Third set of File I/O operations
.
TSTVHST9
           READ              VHSTFL9,VHSTKY9;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDVHST9
           READ              VHSTFL9,VHSTKY9;VendorHistory
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDVHST9LK
           READLK            VHSTFL9,VHSTKY9;VendorHistory
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSVHST9
           READKS            VHSTFL9;VendorHistory
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSVHST9LK

           READKSLK          VHSTFL9;VendorHistory
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPVHST9
          READKP             VHSTFL9;VendorHistory
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPVHST9LK

           READKPLK          VHSTFL9;VendorHistory
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.
.=============================================================================
.
. Deletion for PRIMARY Index
.
DELVHST
           READ              VHSTFL,VHSTKY;;
           GOTO              #ERROR IF OVER
DELVHSTLK
           DELETE            VHSTFLST
           GOTO              #VALID
.
. Update I/O operation
.
UPDVHST
.           READ              VHSTFL,VHSTKY;;
.           GOTO              #ERROR IF OVER
UPDVHSTLK
           UPDATE            VHSTFLST;VendorHistory
           GOTO              #VALID
.
. Write I/O operation
.
WRTVHST
           WRITE             VHSTFLST;VendorHistory
           GOTO              #VALID
.
. Preparation of VHSTer Transaction Files
.
PREPVHST
           %IFDEF            VHSTKY
             PREPARE           VHSTFL,VHSTTXTNM,VHSTISI1NM,VHSTI1DEF,VHSTFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            VHSTKY2
             PREPARE           VHSTFL2,VHSTTXTNM,VHSTISI2NM,VHSTI2DEF,VHSTFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            VHSTKY3
             PREPARE           VHSTFL3,VHSTTXTNM,VHSTISI3NM,VHSTI3DEF,VHSTFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            VHSTKY4
             PREPARE           VHSTFL4,VHSTTXTNM,VHSTISI4NM,VHSTI4DEF,VHSTFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            VHSTKY5
             PREPARE           VHSTFL5,VHSTTXTNM,VHSTISI5NM,VHSTI5DEF,VHSTFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            VHSTKY6
             PREPARE           VHSTFL6,VHSTTXTNM,VHSTISI6NM,VHSTI6DEF,VHSTFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            VHSTKY7
             PREPARE           VHSTFL7,VHSTTXTNM,VHSTISI7NM,VHSTI7DEF,VHSTFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            VHSTKY8
             PREPARE           VHSTFL8,VHSTTXTNM,VHSTISI8NM,VHSTI8DEF,VHSTFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            VHSTKY9
             PREPARE           VHSTFL9,VHSTTXTNM,VHSTISI9NM,VHSTI9DEF,VHSTFSIZE,EXCLUSIVE
           %ENDIF
           RETURN

.
. Opening of Check Register Transaction File
.
OPENVHST
           GETFILE           VHSTFL
           RETURN            IF ZERO
           OPEN              VHSTFLST,SHARE,LOCKMANUAL,SINGLE,NOWAIT
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

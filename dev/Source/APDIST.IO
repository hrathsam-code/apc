;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    4 NORFOLK LANE                                           ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    APDIST.IO                                                      ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    02/28/2005 AT 10:55PM                                          ;
;                                                                             ;
;  PURPOSE:    Accounts Payable GL Distribution I/O Routines                  ;
;                                                                             ;
; REVISION:    VER     DATE     INIT       DETAILS                            ;
;                                                                             ;
;              1.0   02/28/2005   HOR     INITIAL VERSION                     ;
;                                                                             ;
;=============================================================================;
.
           %IFNDEF           $APDISTVAR
             INCLUDE           APDISTER.FD
           %ENDIF
.
           %IFNDEF           $APDISTIO
$APDISTIO    EQUATE            1
.
. Test Read for PRIMARY Index
.
TSTAPDIST
           READ              APDISTFL,APDISTKY;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPDIST
           READ              APDISTFL,APDISTKY;APDIST
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPDISTLK
           READLK            APDISTFL,APDISTKY;APDIST
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPDIST
           READKS            APDISTFL;APDIST
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPDISTLK

           READKSLK          APDISTFL;APDIST
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPDIST
          READKP             APDISTFL;APDIST
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPDISTLK

           READKPLK          APDISTFL;APDIST
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.=============================================================================
. Secondary file I/O operations
.
           %IFDEF            APDISTKY2
TSTAPDIST2
           READ              APDISTFL2,APDISTKY2;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPDIST2
           READ              APDISTFL2,APDISTKY2;APDIST
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPDIST2LK
           READLK            APDISTFL2,APDISTKY2;APDIST
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPDIST2
           READKS            APDISTFL2;APDIST
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPDIST2LK

           READKSLK          APDISTFL2;APDIST
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPDIST2
          READKP             APDISTFL2;APDIST
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPDIST2LK
           READKPLK          APDISTFL2;APDIST
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Third file I/O operations
.
           %IFDEF            APDISTKY3
.
TSTAPDIST3
           READ              APDISTFL3,APDISTKY3;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPDIST3
           READ              APDISTFL3,APDISTKY3;APDIST
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPDIST3LK
           READLK            APDISTFL3,APDISTKY3;APDIST
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPDIST3
           READKS            APDISTFL3;APDIST
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPDIST3LK

           READKSLK          APDISTFL3;APDIST
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPDIST3
          READKP             APDISTFL3;APDIST
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPDIST3LK

           READKPLK          APDISTFL3;APDIST
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fourth file I/O operations
.
           %IFDEF            APDISTKY4
.
TSTAPDIST4
           READ              APDISTFL4,APDISTKY4;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPDIST4
           READ              APDISTFL4,APDISTKY4;APDIST
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPDIST4LK
           READLK            APDISTFL4,APDISTKY4;APDIST
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPDIST4
           READKS            APDISTFL4;APDIST
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPDIST4LK

           READKSLK          APDISTFL4;APDIST
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPDIST4
          READKP             APDISTFL4;APDIST
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPDIST4LK

           READKPLK          APDISTFL4;APDIST
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fifth file I/O operations
.
           %IFDEF            APDISTKY5
.
TSTAPDIST5
           READ              APDISTFL5,APDISTKY5;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPDIST5
           READ              APDISTFL5,APDISTKY5;APDIST
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPDIST5LK
           READLK            APDISTFL5,APDISTKY5;APDIST
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPDIST5
           READKS            APDISTFL5;APDIST
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPDIST5LK

           READKSLK          APDISTFL5;APDIST
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPDIST5
          READKP             APDISTFL5;APDIST
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPDIST5LK

           READKPLK          APDISTFL5;APDIST
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Sixth file I/O operations
.
           %IFDEF            APDISTKY6
.
TSTAPDIST6
           READ              APDISTFL6,APDISTKY6;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPDIST6
           READ              APDISTFL6,APDISTKY6;APDIST
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPDIST6LK
           READLK            APDISTFL6,APDISTKY6;APDIST
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPDIST6
           READKS            APDISTFL6;APDIST
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPDIST6LK

           READKSLK          APDISTFL6;APDIST
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPDIST6
          READKP             APDISTFL6;APDIST
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPDIST6LK

           READKPLK          APDISTFL6;APDIST
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Seventh file I/O operations
.
           %IFDEF            APDISTKY7
.
TSTAPDIST7
           READ              APDISTFL7,APDISTKY7;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPDIST7
           READ              APDISTFL7,APDISTKY7;APDIST
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPDIST7LK
           READLK            APDISTFL7,APDISTKY7;APDIST
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPDIST7
           READKS            APDISTFL7;APDIST
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPDIST7LK

           READKSLK          APDISTFL7;APDIST
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPDIST7
          READKP             APDISTFL7;APDIST
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPDIST7LK

           READKPLK          APDISTFL7;APDIST
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Eighth file I/O operations
.
           %IFDEF            APDISTKY8
.
TSTAPDIST8
           READ              APDISTFL8,APDISTKY8;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPDIST8
           READ              APDISTFL8,APDISTKY8;APDIST
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPDIST8LK
           READLK            APDISTFL8,APDISTKY8;APDIST
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPDIST8
           READKS            APDISTFL8;APDIST
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPDIST8LK

           READKSLK          APDISTFL8;APDIST
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPDIST8
          READKP             APDISTFL8;APDIST
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPDIST8LK

           READKPLK          APDISTFL8;APDIST
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Ninth file I/O operations
.
           %IFDEF            APDISTKY9
.
. Third set of File I/O operations
.
TSTAPDIST9
           READ              APDISTFL9,APDISTKY9;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPDIST9
           READ              APDISTFL9,APDISTKY9;APDIST
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPDIST9LK
           READLK            APDISTFL9,APDISTKY9;APDIST
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPDIST9
           READKS            APDISTFL9;APDIST
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPDIST9LK

           READKSLK          APDISTFL9;APDIST
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPDIST9
          READKP             APDISTFL9;APDIST
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPDIST9LK

           READKPLK          APDISTFL9;APDIST
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.
.=============================================================================
.
. Deletion for PRIMARY Index
.
DELAPDIST
           READ              APDISTFL,APDISTKY;;
           GOTO              #ERROR IF OVER
DELAPDISTLK
           DELETE            APDISTFLST
           GOTO              #VALID
.
. Update I/O operation
.
UPDAPDIST
.           READ              APDISTFL,APDISTKY;;
.           GOTO              #ERROR IF OVER
UPDAPDISTLK
           UPDATE            APDISTFLST;APDIST
           GOTO              #VALID
.
. Write I/O operation
.
WRTAPDIST
           WRITE             APDISTFLST;APDIST
           GOTO              #VALID
.
. Preparation of APDISTer Transaction Files
.
PREPAPDIST
           %IFDEF            APDISTKY
             PREPARE           APDISTFL,APDISTTXTNM,APDISTISI1NM,APDISTI1DEF,APDISTFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APDISTKY2
             PREPARE           APDISTFL2,APDISTTXTNM,APDISTISI2NM,APDISTI2DEF,APDISTFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APDISTKY3
             PREPARE           APDISTFL3,APDISTTXTNM,APDISTISI3NM,APDISTI3DEF,APDISTFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APDISTKY4
             PREPARE           APDISTFL4,APDISTTXTNM,APDISTISI4NM,APDISTI4DEF,APDISTFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APDISTKY5
             PREPARE           APDISTFL5,APDISTTXTNM,APDISTISI5NM,APDISTI5DEF,APDISTFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APDISTKY6
             PREPARE           APDISTFL6,APDISTTXTNM,APDISTISI6NM,APDISTI6DEF,APDISTFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APDISTKY7
             PREPARE           APDISTFL7,APDISTTXTNM,APDISTISI7NM,APDISTI7DEF,APDISTFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APDISTKY8
             PREPARE           APDISTFL8,APDISTTXTNM,APDISTISI8NM,APDISTI8DEF,APDISTFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APDISTKY9
             PREPARE           APDISTFL9,APDISTTXTNM,APDISTISI9NM,APDISTI9DEF,APDISTFSIZE,EXCLUSIVE
           %ENDIF
           RETURN

.
. Opening of Check Register Transaction File
.
OPENAPDIST
           GETFILE           APDISTFL
           RETURN            IF ZERO
           OPEN              APDISTFLST,SHARE,LOCKMANUAL,SINGLE,NOWAIT
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

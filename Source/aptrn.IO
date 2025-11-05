;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    4 NORFOLK LANE                                           ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    APTRN.IO                                                       ;
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

           %IFNDEF           $APTRNVAR
             INCLUDE           APTRN.FD
           %ENDIF
.
           %IFNDEF           $APTRNIO
$APTRNIO    EQUATE            1
.
. Test Read for PRIMARY Index
.
TSTAPTRN
           READ              APTRNFL,APTRNKY;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPTRN
           READ              APTRNFL,APTRNKY;APTRN
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPTRNLK
           READLK            APTRNFL,APTRNKY;APTRN
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPTRN
           READKS            APTRNFL;APTRN
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPTRNLK

           READKSLK          APTRNFL;APTRN
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPTRN
          READKP             APTRNFL;APTRN
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPTRNLK

           READKPLK          APTRNFL;APTRN
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.=============================================================================
. Secondary file I/O operations
.
           %IFDEF            APTRNKY2
TSTAPTRN2
           READ              APTRNFL2,APTRNKY2;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPTRN2
           READ              APTRNFL2,APTRNKY2;APTRN
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPTRN2LK
           READLK            APTRNFL2,APTRNKY2;APTRN
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPTRN2
           READKS            APTRNFL2;APTRN
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPTRN2LK

           READKSLK          APTRNFL2;APTRN
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPTRN2
          READKP             APTRNFL2;APTRN
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPTRN2LK
           READKPLK          APTRNFL2;APTRN
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Third file I/O operations
.
           %IFDEF            APTRNKY3
.
TSTAPTRN3
           READ              APTRNFL3,APTRNKY3;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPTRN3
           READ              APTRNFL3,APTRNKY3;APTRN
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPTRN3LK
           READLK            APTRNFL3,APTRNKY3;APTRN
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPTRN3
           READKS            APTRNFL3;APTRN
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPTRN3LK

           READKSLK          APTRNFL3;APTRN
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPTRN3
          READKP             APTRNFL3;APTRN
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPTRN3LK

           READKPLK          APTRNFL3;APTRN
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fourth file I/O operations
.
           %IFDEF            APTRNKY4
.
TSTAPTRN4
           READ              APTRNFL4,APTRNKY4;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPTRN4
           READ              APTRNFL4,APTRNKY4;APTRN
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPTRN4LK
           READLK            APTRNFL4,APTRNKY4;APTRN
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPTRN4
           READKS            APTRNFL4;APTRN
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPTRN4LK

           READKSLK          APTRNFL4;APTRN
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPTRN4
          READKP             APTRNFL4;APTRN
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPTRN4LK

           READKPLK          APTRNFL4;APTRN
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fifth file I/O operations
.
           %IFDEF            APTRNKY5
.
TSTAPTRN5
           READ              APTRNFL5,APTRNKY5;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPTRN5
           READ              APTRNFL5,APTRNKY5;APTRN
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPTRN5LK
           READLK            APTRNFL5,APTRNKY5;APTRN
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPTRN5
           READKS            APTRNFL5;APTRN
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPTRN5LK

           READKSLK          APTRNFL5;APTRN
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPTRN5
          READKP             APTRNFL5;APTRN
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPTRN5LK

           READKPLK          APTRNFL5;APTRN
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Sixth file I/O operations
.
           %IFDEF            APTRNKY6
.
TSTAPTRN6
           READ              APTRNFL6,APTRNKY6;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPTRN6
           READ              APTRNFL6,APTRNKY6;APTRN
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPTRN6LK
           READLK            APTRNFL6,APTRNKY6;APTRN
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPTRN6
           READKS            APTRNFL6;APTRN
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPTRN6LK

           READKSLK          APTRNFL6;APTRN
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPTRN6
          READKP             APTRNFL6;APTRN
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPTRN6LK

           READKPLK          APTRNFL6;APTRN
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Seventh file I/O operations
.
           %IFDEF            APTRNKY7
.
TSTAPTRN7
           READ              APTRNFL7,APTRNKY7;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPTRN7
           READ              APTRNFL7,APTRNKY7;APTRN
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPTRN7LK
           READLK            APTRNFL7,APTRNKY7;APTRN
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPTRN7
           READKS            APTRNFL7;APTRN
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPTRN7LK

           READKSLK          APTRNFL7;APTRN
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPTRN7
          READKP             APTRNFL7;APTRN
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPTRN7LK

           READKPLK          APTRNFL7;APTRN
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Eighth file I/O operations
.
           %IFDEF            APTRNKY8
.
TSTAPTRN8
           READ              APTRNFL8,APTRNKY8;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPTRN8
           READ              APTRNFL8,APTRNKY8;APTRN
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPTRN8LK
           READLK            APTRNFL8,APTRNKY8;APTRN
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPTRN8
           READKS            APTRNFL8;APTRN
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPTRN8LK

           READKSLK          APTRNFL8;APTRN
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPTRN8
          READKP             APTRNFL8;APTRN
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPTRN8LK

           READKPLK          APTRNFL8;APTRN
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Ninth file I/O operations
.
           %IFDEF            APTRNKY9
.
. Third set of File I/O operations
.
TSTAPTRN9
           READ              APTRNFL9,APTRNKY9;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPTRN9
           READ              APTRNFL9,APTRNKY9;APTRN
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPTRN9LK
           READLK            APTRNFL9,APTRNKY9;APTRN
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPTRN9
           READKS            APTRNFL9;APTRN
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPTRN9LK

           READKSLK          APTRNFL9;APTRN
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPTRN9
          READKP             APTRNFL9;APTRN
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPTRN9LK

           READKPLK          APTRNFL9;APTRN
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.
.=============================================================================
.
. Deletion for PRIMARY Index
.
DELAPTRN
           READ              APTRNFL,APTRNKY;;
           GOTO              #ERROR IF OVER
DELAPTRNLK
           DELETE            APTRNFLST
           GOTO              #VALID
.
. Update I/O operation
.
UPDAPTRN
.           READ              APTRNFL,APTRNKY;;
.           GOTO              #ERROR IF OVER
UPDAPTRNLK
           UPDATE            APTRNFLST;APTRN
           GOTO              #VALID
.
. Write I/O operation
.
WRTAPTRN
           WRITE             APTRNFLST;APTRN
           GOTO              #VALID
.
. Preparation of APTRNer Transaction Files
.
PREPAPTRN
           %IFDEF            APTRNKY
             PREPARE           APTRNFL,APTRNTXTNM,APTRNISI1NM,APTRNI1DEF,APTRNFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APTRNKY2
             PREPARE           APTRNFL2,APTRNTXTNM,APTRNISI2NM,APTRNI2DEF,APTRNFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APTRNKY3
             PREPARE           APTRNFL3,APTRNTXTNM,APTRNISI3NM,APTRNI3DEF,APTRNFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APTRNKY4
             PREPARE           APTRNFL4,APTRNTXTNM,APTRNISI4NM,APTRNI4DEF,APTRNFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APTRNKY5
             PREPARE           APTRNFL5,APTRNTXTNM,APTRNISI5NM,APTRNI5DEF,APTRNFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APTRNKY6
             PREPARE           APTRNFL6,APTRNTXTNM,APTRNISI6NM,APTRNI6DEF,APTRNFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APTRNKY7
             PREPARE           APTRNFL7,APTRNTXTNM,APTRNISI7NM,APTRNI7DEF,APTRNFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APTRNKY8
             PREPARE           APTRNFL8,APTRNTXTNM,APTRNISI8NM,APTRNI8DEF,APTRNFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APTRNKY9
             PREPARE           APTRNFL9,APTRNTXTNM,APTRNISI9NM,APTRNI9DEF,APTRNFSIZE,EXCLUSIVE
           %ENDIF
           RETURN

.
. Opening of Check Register Transaction File
.
OPENAPTRN
           GETFILE           APTRNFL
           RETURN            IF ZERO
           OPEN              APTRNFLST,SHARE,LOCKMANUAL,SINGLE,NOWAIT
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

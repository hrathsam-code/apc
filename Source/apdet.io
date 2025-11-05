;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    4 NORFOLK LANE                                           ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    APDET.IO                                                       ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    06/06/2005 AT 12:35PM                                          ;
;                                                                             ;
;  PURPOSE:    AP Detail Record I/O Routines                                  ;
;                                                                             ;
; REVISION:    VER     DATE     INIT       DETAILS                            ;
;                                                                             ;
;              1.0   06/01/2005   HOR     INITIAL VERSION                     ;
;                                                                             ;
;=============================================================================;
.
           %IFNDEF           $APDETVAR
             INCLUDE           APDETER.FD
           %ENDIF
.
           %IFNDEF           $APDETIO
$APDETIO    EQUATE            1
.
. Test Read for PRIMARY Index
.
TSTAPDET
           READ              APDETFL,APDETKY;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPDET
           READ              APDETFL,APDETKY;APDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPDETLK
           READLK            APDETFL,APDETKY;APDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPDET
           READKS            APDETFL;APDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPDETLK

           READKSLK          APDETFL;APDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPDET
          READKP             APDETFL;APDetail
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPDETLK

           READKPLK          APDETFL;APDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.=============================================================================
. Secondary file I/O operations
.
           %IFDEF            APDETKY2
TSTAPDET2
           READ              APDETFL2,APDETKY2;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPDET2
           READ              APDETFL2,APDETKY2;APDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPDET2LK
           READLK            APDETFL2,APDETKY2;APDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPDET2
           READKS            APDETFL2;APDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPDET2LK

           READKSLK          APDETFL2;APDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPDET2
          READKP             APDETFL2;APDetail
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPDET2LK
           READKPLK          APDETFL2;APDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Third file I/O operations
.
           %IFDEF            APDETKY3
.
TSTAPDET3
           READ              APDETFL3,APDETKY3;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPDET3
           READ              APDETFL3,APDETKY3;APDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPDET3LK
           READLK            APDETFL3,APDETKY3;APDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPDET3
           READKS            APDETFL3;APDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPDET3LK

           READKSLK          APDETFL3;APDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPDET3
          READKP             APDETFL3;APDetail
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPDET3LK

           READKPLK          APDETFL3;APDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fourth file I/O operations
.
           %IFDEF            APDETKY4
.
TSTAPDET4
           READ              APDETFL4,APDETKY4;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPDET4
           READ              APDETFL4,APDETKY4;APDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPDET4LK
           READLK            APDETFL4,APDETKY4;APDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPDET4
           READKS            APDETFL4;APDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPDET4LK

           READKSLK          APDETFL4;APDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPDET4
          READKP             APDETFL4;APDetail
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPDET4LK

           READKPLK          APDETFL4;APDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fifth file I/O operations
.
           %IFDEF            APDETKY5
.
TSTAPDET5
           READ              APDETFL5,APDETKY5;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPDET5
           READ              APDETFL5,APDETKY5;APDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPDET5LK
           READLK            APDETFL5,APDETKY5;APDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPDET5
           READKS            APDETFL5;APDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPDET5LK

           READKSLK          APDETFL5;APDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPDET5
          READKP             APDETFL5;APDetail
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPDET5LK
           READKPLK          APDETFL5;APDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Sixth file I/O operations
.
           %IFDEF            APDETKY6
.
TSTAPDET6
           READ              APDETFL6,APDETKY6;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPDET6
           READ              APDETFL6,APDETKY6;APDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPDET6LK
           READLK            APDETFL6,APDETKY6;APDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPDET6
           READKS            APDETFL6;APDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPDET6LK

           READKSLK          APDETFL6;APDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPDET6
          READKP             APDETFL6;APDetail
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPDET6LK

           READKPLK          APDETFL6;APDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Seventh file I/O operations
.
           %IFDEF            APDETKY7
.
TSTAPDET7
           READ              APDETFL7,APDETKY7;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPDET7
           READ              APDETFL7,APDETKY7;APDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPDET7LK
           READLK            APDETFL7,APDETKY7;APDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPDET7
           READKS            APDETFL7;APDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPDET7LK

           READKSLK          APDETFL7;APDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPDET7
          READKP             APDETFL7;APDetail
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPDET7LK

           READKPLK          APDETFL7;APDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Eighth file I/O operations
.
           %IFDEF            APDETKY8
.
TSTAPDET8
           READ              APDETFL8,APDETKY8;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPDET8
           READ              APDETFL8,APDETKY8;APDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPDET8LK
           READLK            APDETFL8,APDETKY8;APDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPDET8
           READKS            APDETFL8;APDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPDET8LK

           READKSLK          APDETFL8;APDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPDET8
          READKP             APDETFL8;APDetail
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPDET8LK

           READKPLK          APDETFL8;APDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Ninth file I/O operations
.
           %IFDEF            APDETKY9
.
. Third set of File I/O operations
.
TSTAPDET9
           READ              APDETFL9,APDETKY9;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDAPDET9
           READ              APDETFL9,APDETKY9;APDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDAPDET9LK
           READLK            APDETFL9,APDETKY9;APDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSAPDET9
           READKS            APDETFL9;APDetail
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSAPDET9LK

           READKSLK          APDETFL9;APDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPAPDET9
          READKP             APDETFL9;APDetail
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPAPDET9LK

           READKPLK          APDETFL9;APDetail
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.
.=============================================================================
.
. Deletion for PRIMARY Index
.
DELAPDET
           READ              APDETFL,APDETKY;;
           GOTO              #ERROR IF OVER
DELAPDETLK
           DELETE            APDETFLST
           GOTO              #VALID
.
. Update I/O operation
.
UPDAPDET
.           READ              APDETFL,APDETKY;;
.           GOTO              #ERROR IF OVER
UPDAPDETLK
           UPDATE            APDETFLST;APDetail
           GOTO              #VALID
.
. Write I/O operation
.
WRTAPDET
           WRITE             APDETFLST;APDetail
           GOTO              #VALID
.
. Preparation of APDETer Transaction Files
.
PREPAPDET
           %IFDEF            APDETKY
             PREPARE           APDETFL,APDETTXTNM,APDETISI1NM,APDETI1DEF,APDETFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APDETKY2
             PREPARE           APDETFL2,APDETTXTNM,APDETISI2NM,APDETI2DEF,APDETFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APDETKY3
             PREPARE           APDETFL3,APDETTXTNM,APDETISI3NM,APDETI3DEF,APDETFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APDETKY4
             PREPARE           APDETFL4,APDETTXTNM,APDETISI4NM,APDETI4DEF,APDETFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APDETKY5
             PREPARE           APDETFL5,APDETTXTNM,APDETISI5NM,APDETI5DEF,APDETFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APDETKY6
             PREPARE           APDETFL6,APDETTXTNM,APDETISI6NM,APDETI6DEF,APDETFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APDETKY7
             PREPARE           APDETFL7,APDETTXTNM,APDETISI7NM,APDETI7DEF,APDETFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APDETKY8
             PREPARE           APDETFL8,APDETTXTNM,APDETISI8NM,APDETI8DEF,APDETFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            APDETKY9
             PREPARE           APDETFL9,APDETTXTNM,APDETISI9NM,APDETI9DEF,APDETFSIZE,EXCLUSIVE
           %ENDIF
           RETURN

.
. Opening of Check Register Transaction File
.
OPENAPDET
           GETFILE           APDETFL
           RETURN            IF ZERO
           OPEN              APDETFLST,SHARE,LOCKMANUAL,SINGLE,NOWAIT
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

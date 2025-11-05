......................................................................
.    Chiron Software & Services, Inc.
.    4 Norfolk Lane
.    Bethpage, Ny  11714
.    (516) 935-0196
.
.
. Program Created On : 02/15/02 At 3:00:am
.
           %IFNDEF           $ARTRMVAR
             INCLUDE           ARTRMER.FD
           %ENDIF
.
           %IFNDEF           $ARTRMIO
$ARTRMIO    EQUATE            1
.
. Test Read for PRIMARY Index
.
TSTARTRM
           READ              ARTRMFL,ARTRMKY;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDARTRM
           READ              ARTRMFL,ARTRMKY;ARTRM
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDARTRMLK
           READLK            ARTRMFL,ARTRMKY;ARTRM
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSARTRM
           READKS            ARTRMFL;ARTRM
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSARTRMLK

           READKSLK          ARTRMFL;ARTRM
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPARTRM
          READKP             ARTRMFL;ARTRM
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPARTRMLK

           READKPLK          ARTRMFL;ARTRM
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.=============================================================================
. Secondary file I/O operations
.
           %IFDEF            ARTRMKY2
TSTARTRM2
           READ              ARTRMFL2,ARTRMKY2;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDARTRM2
           READ              ARTRMFL2,ARTRMKY2;ARTRM
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDARTRM2LK
           READLK            ARTRMFL2,ARTRMKY2;ARTRM
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSARTRM2
           READKS            ARTRMFL2;ARTRM
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSARTRM2LK

           READKSLK          ARTRMFL2;ARTRM
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPARTRM2
          READKP             ARTRMFL2;ARTRM
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPARTRM2LK
           READKPLK          ARTRMFL2;ARTRM
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Third file I/O operations
.
           %IFDEF            ARTRMKY3
.
TSTARTRM3
           READ              ARTRMFL3,ARTRMKY3;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDARTRM3
           READ              ARTRMFL3,ARTRMKY3;ARTRM
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDARTRM3LK
           READLK            ARTRMFL3,ARTRMKY3;ARTRM
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSARTRM3
           READKS            ARTRMFL3;ARTRM
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSARTRM3LK

           READKSLK          ARTRMFL3;ARTRM
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPARTRM3
          READKP             ARTRMFL3;ARTRM
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPARTRM3LK

           READKPLK          ARTRMFL3;ARTRM
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fourth file I/O operations
.
           %IFDEF            ARTRMKY4
.
TSTARTRM4
           READ              ARTRMFL4,ARTRMKY4;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDARTRM4
           READ              ARTRMFL4,ARTRMKY4;ARTRM
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDARTRM4LK
           READLK            ARTRMFL4,ARTRMKY4;ARTRM
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSARTRM4
           READKS            ARTRMFL4;ARTRM
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSARTRM4LK

           READKSLK          ARTRMFL4;ARTRM
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPARTRM4
          READKP             ARTRMFL4;ARTRM
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPARTRM4LK

           READKPLK          ARTRMFL4;ARTRM
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fifth file I/O operations
.
           %IFDEF            ARTRMKY5
.
TSTARTRM5
           READ              ARTRMFL5,ARTRMKY5;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDARTRM5
           READ              ARTRMFL5,ARTRMKY5;ARTRM
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDARTRM5LK
           READLK            ARTRMFL5,ARTRMKY5;ARTRM
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSARTRM5
           READKS            ARTRMFL5;ARTRM
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSARTRM5LK

           READKSLK          ARTRMFL5;ARTRM
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPARTRM5
          READKP             ARTRMFL5;ARTRM
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPARTRM5LK

           READKPLK          ARTRMFL5;ARTRM
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Sixth file I/O operations
.
           %IFDEF            ARTRMKY6
.
TSTARTRM6
           READ              ARTRMFL6,ARTRMKY6;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDARTRM6
           READ              ARTRMFL6,ARTRMKY6;ARTRM
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDARTRM6LK
           READLK            ARTRMFL6,ARTRMKY6;ARTRM
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSARTRM6
           READKS            ARTRMFL6;ARTRM
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSARTRM6LK

           READKSLK          ARTRMFL6;ARTRM
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPARTRM6
          READKP             ARTRMFL6;ARTRM
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPARTRM6LK

           READKPLK          ARTRMFL6;ARTRM
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Seventh file I/O operations
.
           %IFDEF            ARTRMKY7
.
TSTARTRM7
           READ              ARTRMFL7,ARTRMKY7;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDARTRM7
           READ              ARTRMFL7,ARTRMKY7;ARTRM
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDARTRM7LK
           READLK            ARTRMFL7,ARTRMKY7;ARTRM
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSARTRM7
           READKS            ARTRMFL7;ARTRM
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSARTRM7LK

           READKSLK          ARTRMFL7;ARTRM
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPARTRM7
          READKP             ARTRMFL7;ARTRM
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPARTRM7LK

           READKPLK          ARTRMFL7;ARTRM
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Eighth file I/O operations
.
           %IFDEF            ARTRMKY8
.
TSTARTRM8
           READ              ARTRMFL8,ARTRMKY8;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDARTRM8
           READ              ARTRMFL8,ARTRMKY8;ARTRM
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDARTRM8LK
           READLK            ARTRMFL8,ARTRMKY8;ARTRM
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSARTRM8
           READKS            ARTRMFL8;ARTRM
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSARTRM8LK

           READKSLK          ARTRMFL8;ARTRM
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPARTRM8
          READKP             ARTRMFL8;ARTRM
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPARTRM8LK

           READKPLK          ARTRMFL8;ARTRM
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Ninth file I/O operations
.
           %IFDEF            ARTRMKY9
.
. Third set of File I/O operations
.
TSTARTRM9
           READ              ARTRMFL9,ARTRMKY9;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDARTRM9
           READ              ARTRMFL9,ARTRMKY9;ARTRM
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDARTRM9LK
           READLK            ARTRMFL9,ARTRMKY9;ARTRM
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSARTRM9
           READKS            ARTRMFL9;ARTRM
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSARTRM9LK

           READKSLK          ARTRMFL9;ARTRM
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPARTRM9
          READKP             ARTRMFL9;ARTRM
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPARTRM9LK

           READKPLK          ARTRMFL9;ARTRM
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.
.=============================================================================
.
. Deletion for PRIMARY Index
.
DELARTRM
           READ              ARTRMFL,ARTRMKY;;
           GOTO              #ERROR IF OVER
DELARTRMLK
           DELETE            ARTRMFLST
           GOTO              #VALID
.
. Update I/O operation
.
UPDARTRM
.           READ              ARTRMFL,ARTRMKY;;
.           GOTO              #ERROR IF OVER
UPDARTRMLK
           UPDATE            ARTRMFLST;ARTRM
           GOTO              #VALID
.
. Write I/O operation
.
WRTARTRM
           WRITE             ARTRMFLST;ARTRM
           GOTO              #VALID
.
. Preparation of ARTRMer Transaction Files
.
PREPARTRM
           %IFDEF            ARTRMKY
             PREPARE           ARTRMFL,ARTRMTXTNM,ARTRMISI1NM,ARTRMI1DEF,ARTRMFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            ARTRMKY2
             PREPARE           ARTRMFL2,ARTRMTXTNM,ARTRMISI2NM,ARTRMI2DEF,ARTRMFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            ARTRMKY3
             PREPARE           ARTRMFL3,ARTRMTXTNM,ARTRMISI3NM,ARTRMI3DEF,ARTRMFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            ARTRMKY4
             PREPARE           ARTRMFL4,ARTRMTXTNM,ARTRMISI4NM,ARTRMI4DEF,ARTRMFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            ARTRMKY5
             PREPARE           ARTRMFL5,ARTRMTXTNM,ARTRMISI5NM,ARTRMI5DEF,ARTRMFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            ARTRMKY6
             PREPARE           ARTRMFL6,ARTRMTXTNM,ARTRMISI6NM,ARTRMI6DEF,ARTRMFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            ARTRMKY7
             PREPARE           ARTRMFL7,ARTRMTXTNM,ARTRMISI7NM,ARTRMI7DEF,ARTRMFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            ARTRMKY8
             PREPARE           ARTRMFL8,ARTRMTXTNM,ARTRMISI8NM,ARTRMI8DEF,ARTRMFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            ARTRMKY9
             PREPARE           ARTRMFL9,ARTRMTXTNM,ARTRMISI9NM,ARTRMI9DEF,ARTRMFSIZE,EXCLUSIVE
           %ENDIF
           RETURN
.
. Opening of Check Register Transaction File
.
OPENARTRM
           GETFILE           ARTRMFL
           RETURN            IF ZERO
           OPEN              ARTRMFLST,SHARE,LOCKMANUAL,SINGLE,NOWAIT
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

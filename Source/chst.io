......................................................................
.    Chiron Software & Services, Inc.
.    4 Norfolk Lane
.    Bethpage, Ny  11714
.    (516) 935-0196
.
.
. Program Created On : 02/15/02 At 3:00:am
.
           %IFNDEF           $CHSTVAR
             INCLUDE           CHST.FD
           %ENDIF
.
           %IFNDEF           $CHSTIO
$CHSTIO    EQUATE            1
.
. Test Read for PRIMARY Index
.
TSTCHST
           READ              CHSTFL,CHSTKY;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCHST
           READ              CHSTFL,CHSTKY;Chst
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCHSTLK
           READLK            CHSTFL,CHSTKY;Chst
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCHST
           READKS            CHSTFL;Chst
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCHSTLK

           READKSLK          CHSTFL;Chst
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCHST
          READKP             CHSTFL;Chst
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCHSTLK

           READKPLK          CHSTFL;Chst
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.=============================================================================
. Secondary file I/O operations
.
           %IFDEF            CHSTKY2
TSTCHST2
           READ              CHSTFL2,CHSTKY2;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCHST2
           READ              CHSTFL2,CHSTKY2;Chst
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCHST2LK
           READLK            CHSTFL2,CHSTKY2;Chst
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCHST2
           READKS            CHSTFL2;Chst
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCHST2LK

           READKSLK          CHSTFL2;Chst
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCHST2
          READKP             CHSTFL2;Chst
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCHST2LK
           READKPLK          CHSTFL2;Chst
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Third file I/O operations
.
           %IFDEF            CHSTKY3
.
TSTCHST3
           READ              CHSTFL3,CHSTKY3;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCHST3
           READ              CHSTFL3,CHSTKY3;Chst
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCHST3LK
           READLK            CHSTFL3,CHSTKY3;Chst
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCHST3
           READKS            CHSTFL3;Chst
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCHST3LK

           READKSLK          CHSTFL3;Chst
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCHST3
          READKP             CHSTFL3;Chst
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCHST3LK

           READKPLK          CHSTFL3;Chst
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fourth file I/O operations
.
           %IFDEF            CHSTKY4
.
TSTCHST4
           READ              CHSTFL4,CHSTKY4;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCHST4
           READ              CHSTFL4,CHSTKY4;Chst
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCHST4LK
           READLK            CHSTFL4,CHSTKY4;Chst
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCHST4
           READKS            CHSTFL4;Chst
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCHST4LK

           READKSLK          CHSTFL4;Chst
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCHST4
          READKP             CHSTFL4;Chst
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCHST4LK

           READKPLK          CHSTFL4;Chst
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fifth file I/O operations
.
           %IFDEF            CHSTKY5
.
TSTCHST5
           READ              CHSTFL5,CHSTKY5;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCHST5
           READ              CHSTFL5,CHSTKY5;Chst
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCHST5LK
           READLK            CHSTFL5,CHSTKY5;Chst
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCHST5
           READKS            CHSTFL5;Chst
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCHST5LK

           READKSLK          CHSTFL5;Chst
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCHST5
          READKP             CHSTFL5;Chst
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCHST5LK

           READKPLK          CHSTFL5;Chst
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Sixth file I/O operations
.
           %IFDEF            CHSTKY6
.
TSTCHST6
           READ              CHSTFL6,CHSTKY6;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCHST6
           READ              CHSTFL6,CHSTKY6;Chst
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCHST6LK
           READLK            CHSTFL6,CHSTKY6;Chst
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCHST6
           READKS            CHSTFL6;Chst
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCHST6LK

           READKSLK          CHSTFL6;Chst
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCHST6
          READKP             CHSTFL6;Chst
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCHST6LK

           READKPLK          CHSTFL6;Chst
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Seventh file I/O operations
.
           %IFDEF            CHSTKY7
.
TSTCHST7
           READ              CHSTFL7,CHSTKY7;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCHST7
           READ              CHSTFL7,CHSTKY7;Chst
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCHST7LK
           READLK            CHSTFL7,CHSTKY7;Chst
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCHST7
           READKS            CHSTFL7;Chst
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCHST7LK

           READKSLK          CHSTFL7;Chst
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCHST7
          READKP             CHSTFL7;Chst
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCHST7LK

           READKPLK          CHSTFL7;Chst
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Eighth file I/O operations
.
           %IFDEF            CHSTKY8
.
TSTCHST8
           READ              CHSTFL8,CHSTKY8;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCHST8
           READ              CHSTFL8,CHSTKY8;Chst
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCHST8LK
           READLK            CHSTFL8,CHSTKY8;Chst
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCHST8
           READKS            CHSTFL8;Chst
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCHST8LK

           READKSLK          CHSTFL8;Chst
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCHST8
          READKP             CHSTFL8;Chst
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCHST8LK

           READKPLK          CHSTFL8;Chst
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Ninth file I/O operations
.
           %IFDEF            CHSTKY9
.
. Third set of File I/O operations
.
TSTCHST9
           READ              CHSTFL9,CHSTKY9;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCHST9
           READ              CHSTFL9,CHSTKY9;Chst
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCHST9LK
           READLK            CHSTFL9,CHSTKY9;Chst
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCHST9
           READKS            CHSTFL9;Chst
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCHST9LK

           READKSLK          CHSTFL9;Chst
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCHST9
          READKP             CHSTFL9;Chst
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCHST9LK

           READKPLK          CHSTFL9;Chst
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.
.=============================================================================
.
. Deletion for PRIMARY Index
.
DELCHST
           READ              CHSTFL,CHSTKY;;
           GOTO              #ERROR IF OVER
DELCHSTLK
           DELETE            CHSTFLST
           GOTO              #VALID
.
. Update I/O operation
.
UPDCHST
.           READ              CHSTFL,CHSTKY;;
.           GOTO              #ERROR IF OVER
UPDCHSTLK
           UPDATE            CHSTFLST;Chst
           GOTO              #VALID
.
. Write I/O operation
.
WRTCHST
           WRITE             CHSTFLST;Chst
           GOTO              #VALID
.
. Preparation of CHSTer Transaction Files
.
PREPCHST
           %IFDEF            CHSTKY
             PREPARE           CHSTFL,CHSTTXTNM,CHSTISI1NM,CHSTI1DEF,CHSTFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CHSTKY2
             PREPARE           CHSTFL2,CHSTTXTNM,CHSTISI2NM,CHSTI2DEF,CHSTFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CHSTKY3
             PREPARE           CHSTFL3,CHSTTXTNM,CHSTISI3NM,CHSTI3DEF,CHSTFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CHSTKY4
             PREPARE           CHSTFL4,CHSTTXTNM,CHSTISI4NM,CHSTI4DEF,CHSTFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CHSTKY5
             PREPARE           CHSTFL5,CHSTTXTNM,CHSTISI5NM,CHSTI5DEF,CHSTFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CHSTKY6
             PREPARE           CHSTFL6,CHSTTXTNM,CHSTISI6NM,CHSTI6DEF,CHSTFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CHSTKY7
             PREPARE           CHSTFL7,CHSTTXTNM,CHSTISI7NM,CHSTI7DEF,CHSTFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CHSTKY8
             PREPARE           CHSTFL8,CHSTTXTNM,CHSTISI8NM,CHSTI8DEF,CHSTFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CHSTKY9
             PREPARE           CHSTFL9,CHSTTXTNM,CHSTISI9NM,CHSTI9DEF,CHSTFSIZE,EXCLUSIVE
           %ENDIF
           RETURN

.
. Opening of Check Register Transaction File
.
OPENCHST
           GETFILE           CHSTFL
           RETURN            IF ZERO
           OPEN              CHSTFLST,SHARE,LOCKMANUAL,SINGLE,NOWAIT
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

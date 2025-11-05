......................................................................
.    Chiron Software & Services, Inc.
.    4 Norfolk Lane
.    Bethpage, Ny  11714
.    (516) 935-0196
.
.
. Program Created On : 02/15/02 At 3:00:am
.
           %IFNDEF           $PYMNTVAR
             INCLUDE           PYMNTER.FD
           %ENDIF
.
           %IFNDEF           $PYMNTIO
$PYMNTIO    EQUATE            1
.
. Test Read for PRIMARY Index
.
TSTPYMNT
           READ              PYMNTFL,PYMNTKY;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDPYMNT
           READ              PYMNTFL,PYMNTKY;PYMNTREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDPYMNTLK
           READLK            PYMNTFL,PYMNTKY;PYMNTREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSPYMNT
           READKS            PYMNTFL;PYMNTREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSPYMNTLK

           READKSLK          PYMNTFL;PYMNTREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPPYMNT
          READKP             PYMNTFL;PYMNTREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPPYMNTLK

           READKPLK          PYMNTFL;PYMNTREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.=============================================================================
. Secondary file I/O operations
.
           %IFDEF            PYMNTKY2
TSTPYMNT2
           READ              PYMNTFL2,PYMNTKY2;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDPYMNT2
           READ              PYMNTFL2,PYMNTKY2;PYMNTREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDPYMNT2LK
           READLK            PYMNTFL2,PYMNTKY2;PYMNTREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSPYMNT2
           READKS            PYMNTFL2;PYMNTREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSPYMNT2LK

           READKSLK          PYMNTFL2;PYMNTREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPPYMNT2
          READKP             PYMNTFL2;PYMNTREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPPYMNT2LK
           READKPLK          PYMNTFL2;PYMNTREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Third file I/O operations
.
           %IFDEF            PYMNTKY3
.
TSTPYMNT3
           READ              PYMNTFL3,PYMNTKY3;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDPYMNT3
           READ              PYMNTFL3,PYMNTKY3;PYMNTREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDPYMNT3LK
           READLK            PYMNTFL3,PYMNTKY3;PYMNTREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSPYMNT3
           READKS            PYMNTFL3;PYMNTREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSPYMNT3LK

           READKSLK          PYMNTFL3;PYMNTREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPPYMNT3
          READKP             PYMNTFL3;PYMNTREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPPYMNT3LK

           READKPLK          PYMNTFL3;PYMNTREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fourth file I/O operations
.
           %IFDEF            PYMNTKY4
.
TSTPYMNT4
           READ              PYMNTFL4,PYMNTKY4;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDPYMNT4
           READ              PYMNTFL4,PYMNTKY4;PYMNTREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDPYMNT4LK
           READLK            PYMNTFL4,PYMNTKY4;PYMNTREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSPYMNT4
           READKS            PYMNTFL4;PYMNTREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSPYMNT4LK

           READKSLK          PYMNTFL4;PYMNTREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPPYMNT4
          READKP             PYMNTFL4;PYMNTREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPPYMNT4LK

           READKPLK          PYMNTFL4;PYMNTREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fifth file I/O operations
.
           %IFDEF            PYMNTKY5
.
TSTPYMNT5
           READ              PYMNTFL5,PYMNTKY5;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDPYMNT5
           READ              PYMNTFL5,PYMNTKY5;PYMNTREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDPYMNT5LK
           READLK            PYMNTFL5,PYMNTKY5;PYMNTREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSPYMNT5
           READKS            PYMNTFL5;PYMNTREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSPYMNT5LK

           READKSLK          PYMNTFL5;PYMNTREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPPYMNT5
          READKP             PYMNTFL5;PYMNTREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPPYMNT5LK
           READKPLK          PYMNTFL5;PYMNTREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Sixth file I/O operations
.
           %IFDEF            PYMNTKY6
.
TSTPYMNT6
           READ              PYMNTFL6,PYMNTKY6;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDPYMNT6
           READ              PYMNTFL6,PYMNTKY6;PYMNTREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDPYMNT6LK
           READLK            PYMNTFL6,PYMNTKY6;PYMNTREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSPYMNT6
           READKS            PYMNTFL6;PYMNTREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSPYMNT6LK

           READKSLK          PYMNTFL6;PYMNTREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPPYMNT6
          READKP             PYMNTFL6;PYMNTREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPPYMNT6LK

           READKPLK          PYMNTFL6;PYMNTREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Seventh file I/O operations
.
           %IFDEF            PYMNTKY7
.
TSTPYMNT7
           READ              PYMNTFL7,PYMNTKY7;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDPYMNT7
           READ              PYMNTFL7,PYMNTKY7;PYMNTREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDPYMNT7LK
           READLK            PYMNTFL7,PYMNTKY7;PYMNTREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSPYMNT7
           READKS            PYMNTFL7;PYMNTREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSPYMNT7LK

           READKSLK          PYMNTFL7;PYMNTREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPPYMNT7
          READKP             PYMNTFL7;PYMNTREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPPYMNT7LK

           READKPLK          PYMNTFL7;PYMNTREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Eighth file I/O operations
.
           %IFDEF            PYMNTKY8
.
TSTPYMNT8
           READ              PYMNTFL8,PYMNTKY8;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDPYMNT8
           READ              PYMNTFL8,PYMNTKY8;PYMNTREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDPYMNT8LK
           READLK            PYMNTFL8,PYMNTKY8;PYMNTREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSPYMNT8
           READKS            PYMNTFL8;PYMNTREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSPYMNT8LK

           READKSLK          PYMNTFL8;PYMNTREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPPYMNT8
          READKP             PYMNTFL8;PYMNTREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPPYMNT8LK

           READKPLK          PYMNTFL8;PYMNTREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Ninth file I/O operations
.
           %IFDEF            PYMNTKY9
.
. Third set of File I/O operations
.
TSTPYMNT9
           READ              PYMNTFL9,PYMNTKY9;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDPYMNT9
           READ              PYMNTFL9,PYMNTKY9;PYMNTREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDPYMNT9LK
           READLK            PYMNTFL9,PYMNTKY9;PYMNTREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSPYMNT9
           READKS            PYMNTFL9;PYMNTREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSPYMNT9LK

           READKSLK          PYMNTFL9;PYMNTREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPPYMNT9
          READKP             PYMNTFL9;PYMNTREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPPYMNT9LK

           READKPLK          PYMNTFL9;PYMNTREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.
.=============================================================================
.
. Deletion for PRIMARY Index
.
DELPYMNT
           READ              PYMNTFL,PYMNTKY;;
           GOTO              #ERROR IF OVER
DELPYMNTLK
           DELETE            PYMNTFLST
           GOTO              #VALID
.
. Update I/O operation
.
UPDPYMNT
.           READ              PYMNTFL,PYMNTKY;;
.           GOTO              #ERROR IF OVER
UPDPYMNTLK
           UPDATE            PYMNTFLST;PYMNTREC
           GOTO              #VALID
.
. Write I/O operation
.
WRTPYMNT
           WRITE             PYMNTFLST;PYMNTREC
           GOTO              #VALID
.
. Preparation of PYMNTer Transaction Files
.
PREPPYMNT
           %IFDEF            PYMNTKY
             PREPARE           PYMNTFL,PYMNTTXTNM,PYMNTISI1NM,PYMNTI1DEF,PYMNTFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            PYMNTKY2
             PREPARE           PYMNTFL2,PYMNTTXTNM,PYMNTISI2NM,PYMNTI2DEF,PYMNTFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            PYMNTKY3
             PREPARE           PYMNTFL3,PYMNTTXTNM,PYMNTISI3NM,PYMNTI3DEF,PYMNTFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            PYMNTKY4
             PREPARE           PYMNTFL4,PYMNTTXTNM,PYMNTISI4NM,PYMNTI4DEF,PYMNTFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            PYMNTKY5
             PREPARE           PYMNTFL5,PYMNTTXTNM,PYMNTISI5NM,PYMNTI5DEF,PYMNTFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            PYMNTKY6
             PREPARE           PYMNTFL6,PYMNTTXTNM,PYMNTISI6NM,PYMNTI6DEF,PYMNTFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            PYMNTKY7
             PREPARE           PYMNTFL7,PYMNTTXTNM,PYMNTISI7NM,PYMNTI7DEF,PYMNTFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            PYMNTKY8
             PREPARE           PYMNTFL8,PYMNTTXTNM,PYMNTISI8NM,PYMNTI8DEF,PYMNTFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            PYMNTKY9
             PREPARE           PYMNTFL9,PYMNTTXTNM,PYMNTISI9NM,PYMNTI9DEF,PYMNTFSIZE,EXCLUSIVE
           %ENDIF
           RETURN

.
. Opening of Check Register Transaction File
.
OPENPYMNT
           GETFILE           PYMNTFL
           RETURN            IF ZERO
           OPEN              PYMNTFLST,SHARE,LOCKMANUAL,SINGLE,NOWAIT
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

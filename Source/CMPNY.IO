......................................................................
.    Chiron Software & Services, Inc.
.    4 Norfolk Lane
.    Bethpage, Ny  11714
.    (516) 935-0196
.
.
. Program Created On : 02/15/02 At 3:00:am
.
           %IFNDEF           $CMPNYVAR
             INCLUDE           CMPNYER.FD
           %ENDIF
.
           %IFNDEF           $CMPNYIO
$CMPNYIO    EQUATE            1
.
. Test Read for PRIMARY Index
.
TSTCMPNY
           READ              CMPNYFL,CMPNYKY;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCMPNY
           READ              CMPNYFL,CMPNYKY;CMPNYREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCMPNYLK
           READLK            CMPNYFL,CMPNYKY;CMPNYREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCMPNY
           READKS            CMPNYFL;CMPNYREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCMPNYLK

           READKSLK          CMPNYFL;CMPNYREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCMPNY
          READKP             CMPNYFL;CMPNYREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCMPNYLK

           READKPLK          CMPNYFL;CMPNYREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.=============================================================================
. Secondary file I/O operations
.
           %IFDEF            CMPNYKY2
TSTCMPNY2
           READ              CMPNYFL2,CMPNYKY2;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCMPNY2
           READ              CMPNYFL2,CMPNYKY2;CMPNYREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCMPNY2LK
           READLK            CMPNYFL2,CMPNYKY2;CMPNYREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCMPNY2
           READKS            CMPNYFL2;CMPNYREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCMPNY2LK

           READKSLK          CMPNYFL2;CMPNYREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCMPNY2
          READKP             CMPNYFL2;CMPNYREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCMPNY2LK
           READKPLK          CMPNYFL2;CMPNYREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Third file I/O operations
.
           %IFDEF            CMPNYKY3
.
TSTCMPNY3
           READ              CMPNYFL3,CMPNYKY3;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCMPNY3
           READ              CMPNYFL3,CMPNYKY3;CMPNYREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCMPNY3LK
           READLK            CMPNYFL3,CMPNYKY3;CMPNYREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCMPNY3
           READKS            CMPNYFL3;CMPNYREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCMPNY3LK

           READKSLK          CMPNYFL3;CMPNYREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCMPNY3
          READKP             CMPNYFL3;CMPNYREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCMPNY3LK

           READKPLK          CMPNYFL3;CMPNYREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fourth file I/O operations
.
           %IFDEF            CMPNYKY4
.
TSTCMPNY4
           READ              CMPNYFL4,CMPNYKY4;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCMPNY4
           READ              CMPNYFL4,CMPNYKY4;CMPNYREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCMPNY4LK
           READLK            CMPNYFL4,CMPNYKY4;CMPNYREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCMPNY4
           READKS            CMPNYFL4;CMPNYREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCMPNY4LK

           READKSLK          CMPNYFL4;CMPNYREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCMPNY4
          READKP             CMPNYFL4;CMPNYREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCMPNY4LK

           READKPLK          CMPNYFL4;CMPNYREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fifth file I/O operations
.
           %IFDEF            CMPNYKY5
.
TSTCMPNY5
           READ              CMPNYFL5,CMPNYKY5;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCMPNY5
           READ              CMPNYFL5,CMPNYKY5;CMPNYREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCMPNY5LK
           READLK            CMPNYFL5,CMPNYKY5;CMPNYREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCMPNY5
           READKS            CMPNYFL5;CMPNYREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCMPNY5LK

           READKSLK          CMPNYFL5;CMPNYREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCMPNY5
          READKP             CMPNYFL5;CMPNYREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCMPNY5LK

           READKPLK          CMPNYFL5;CMPNYREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Sixth file I/O operations
.
           %IFDEF            CMPNYKY6
.
TSTCMPNY6
           READ              CMPNYFL6,CMPNYKY6;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCMPNY6
           READ              CMPNYFL6,CMPNYKY6;CMPNYREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCMPNY6LK
           READLK            CMPNYFL6,CMPNYKY6;CMPNYREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCMPNY6
           READKS            CMPNYFL6;CMPNYREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCMPNY6LK

           READKSLK          CMPNYFL6;CMPNYREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCMPNY6
          READKP             CMPNYFL6;CMPNYREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCMPNY6LK

           READKPLK          CMPNYFL6;CMPNYREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Seventh file I/O operations
.
           %IFDEF            CMPNYKY7
.
TSTCMPNY7
           READ              CMPNYFL7,CMPNYKY7;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCMPNY7
           READ              CMPNYFL7,CMPNYKY7;CMPNYREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCMPNY7LK
           READLK            CMPNYFL7,CMPNYKY7;CMPNYREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCMPNY7
           READKS            CMPNYFL7;CMPNYREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCMPNY7LK

           READKSLK          CMPNYFL7;CMPNYREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCMPNY7
          READKP             CMPNYFL7;CMPNYREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCMPNY7LK

           READKPLK          CMPNYFL7;CMPNYREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Eighth file I/O operations
.
           %IFDEF            CMPNYKY8
.
TSTCMPNY8
           READ              CMPNYFL8,CMPNYKY8;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCMPNY8
           READ              CMPNYFL8,CMPNYKY8;CMPNYREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCMPNY8LK
           READLK            CMPNYFL8,CMPNYKY8;CMPNYREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCMPNY8
           READKS            CMPNYFL8;CMPNYREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCMPNY8LK

           READKSLK          CMPNYFL8;CMPNYREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCMPNY8
          READKP             CMPNYFL8;CMPNYREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCMPNY8LK

           READKPLK          CMPNYFL8;CMPNYREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Ninth file I/O operations
.
           %IFDEF            CMPNYKY9
.
. Third set of File I/O operations
.
TSTCMPNY9
           READ              CMPNYFL9,CMPNYKY9;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDCMPNY9
           READ              CMPNYFL9,CMPNYKY9;CMPNYREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCMPNY9LK
           READLK            CMPNYFL9,CMPNYKY9;CMPNYREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSCMPNY9
           READKS            CMPNYFL9;CMPNYREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCMPNY9LK

           READKSLK          CMPNYFL9;CMPNYREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPCMPNY9
          READKP             CMPNYFL9;CMPNYREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCMPNY9LK

           READKPLK          CMPNYFL9;CMPNYREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.
.=============================================================================
.
. Deletion for PRIMARY Index
.
DELCMPNY
           READ              CMPNYFL,CMPNYKY;;
           GOTO              #ERROR IF OVER
DELCMPNYLK
           DELETE            CMPNYFLST
           GOTO              #VALID
.
. Update I/O operation
.
UPDCMPNY
.           READ              CMPNYFL,CMPNYKY;;
.           GOTO              #ERROR IF OVER
UPDCMPNYLK
           UPDATE            CMPNYFLST;CMPNYREC
           GOTO              #VALID
.
. Write I/O operation
.
WRTCMPNY
           WRITE             CMPNYFLST;CMPNYREC
           GOTO              #VALID
.
. Preparation of CMPNYer Transaction Files
.
PREPCMPNY
           %IFDEF            CMPNYKY
             PREPARE           CMPNYFL,CMPNYTXTNM,CMPNYISI1NM,CMPNYI1DEF,CMPNYFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CMPNYKY2
             PREPARE           CMPNYFL2,CMPNYTXTNM,CMPNYISI2NM,CMPNYI2DEF,CMPNYFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CMPNYKY3
             PREPARE           CMPNYFL3,CMPNYTXTNM,CMPNYISI3NM,CMPNYI3DEF,CMPNYFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CMPNYKY4
             PREPARE           CMPNYFL4,CMPNYTXTNM,CMPNYISI4NM,CMPNYI4DEF,CMPNYFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CMPNYKY5
             PREPARE           CMPNYFL5,CMPNYTXTNM,CMPNYISI5NM,CMPNYI5DEF,CMPNYFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CMPNYKY6
             PREPARE           CMPNYFL6,CMPNYTXTNM,CMPNYISI6NM,CMPNYI6DEF,CMPNYFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CMPNYKY7
             PREPARE           CMPNYFL7,CMPNYTXTNM,CMPNYISI7NM,CMPNYI7DEF,CMPNYFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CMPNYKY8
             PREPARE           CMPNYFL8,CMPNYTXTNM,CMPNYISI8NM,CMPNYI8DEF,CMPNYFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CMPNYKY9
             PREPARE           CMPNYFL9,CMPNYTXTNM,CMPNYISI9NM,CMPNYI9DEF,CMPNYFSIZE,EXCLUSIVE
           %ENDIF
           RETURN

.
. Opening of Check Register Transaction File
.
OPENCMPNY
           GETFILE           CMPNYFL
           RETURN            IF ZERO
           OPEN              CMPNYFLST,SHARE,LOCKMANUAL,SINGLE,NOWAIT
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

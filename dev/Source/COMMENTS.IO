......................................................................
.    Chiron Software & Services, Inc.
.    4 Norfolk Lane
.    Bethpage, Ny  11714
.    (516) 935-0196
.
.
. Program Created On : 02/15/02 At 3:00:am
.
           %IFNDEF           $CommentsVAR
             INCLUDE           CommentsER.FD
           %ENDIF
.
           %IFNDEF           $CommentsIO
$CommentsIO    EQUATE            1
              GOTO              #S
.
. Test Read for PRIMARY Index
.
TSTComments
           READ              CommentsFL,CommentsKY;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDComments
           READ              CommentsFL,CommentsKY;CommentsREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDCommentsLK
           READLK            CommentsFL,CommentsKY;CommentsREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSComments
           READKS            CommentsFL;CommentsREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSCommentsLK

           READKSLK          CommentsFL;CommentsREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPComments
          READKP             CommentsFL;CommentsREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPCommentsLK

           READKPLK          CommentsFL;CommentsREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.=============================================================================
. Secondary file I/O operations
.
           %IFDEF            CommentsKY2
TSTComments2
           READ              CommentsFL2,CommentsKY2;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDComments2
           READ              CommentsFL2,CommentsKY2;CommentsREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDComments2LK
           READLK            CommentsFL2,CommentsKY2;CommentsREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSComments2
           READKS            CommentsFL2;CommentsREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSComments2LK

           READKSLK          CommentsFL2;CommentsREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPComments2
          READKP             CommentsFL2;CommentsREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPComments2LK
           READKPLK          CommentsFL2;CommentsREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Third file I/O operations
.
           %IFDEF            CommentsKY3
.
TSTComments3
           READ              CommentsFL3,CommentsKY3;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDComments3
           READ              CommentsFL3,CommentsKY3;CommentsREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDComments3LK
           READLK            CommentsFL3,CommentsKY3;CommentsREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSComments3
           READKS            CommentsFL3;CommentsREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSComments3LK

           READKSLK          CommentsFL3;CommentsREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPComments3
          READKP             CommentsFL3;CommentsREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPComments3LK

           READKPLK          CommentsFL3;CommentsREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fourth file I/O operations
.
           %IFDEF            CommentsKY4
.
TSTComments4
           READ              CommentsFL4,CommentsKY4;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDComments4
           READ              CommentsFL4,CommentsKY4;CommentsREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDComments4LK
           READLK            CommentsFL4,CommentsKY4;CommentsREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSComments4
           READKS            CommentsFL4;CommentsREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSComments4LK

           READKSLK          CommentsFL4;CommentsREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPComments4
          READKP             CommentsFL4;CommentsREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPComments4LK

           READKPLK          CommentsFL4;CommentsREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Fifth file I/O operations
.
           %IFDEF            CommentsKY5
.
TSTComments5
           READ              CommentsFL5,CommentsKY5;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDComments5
           READ              CommentsFL5,CommentsKY5;CommentsREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDComments5LK
           READLK            CommentsFL5,CommentsKY5;CommentsREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSComments5
           READKS            CommentsFL5;CommentsREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSComments5LK

           READKSLK          CommentsFL5;CommentsREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPComments5
          READKP             CommentsFL5;CommentsREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPComments5LK

           READKPLK          CommentsFL5;CommentsREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Sixth file I/O operations
.
           %IFDEF            CommentsKY6
.
TSTComments6
           READ              CommentsFL6,CommentsKY6;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDComments6
           READ              CommentsFL6,CommentsKY6;CommentsREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDComments6LK
           READLK            CommentsFL6,CommentsKY6;CommentsREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSComments6
           READKS            CommentsFL6;CommentsREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSComments6LK

           READKSLK          CommentsFL6;CommentsREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPComments6
          READKP             CommentsFL6;CommentsREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPComments6LK

           READKPLK          CommentsFL6;CommentsREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Seventh file I/O operations
.
           %IFDEF            CommentsKY7
.
TSTComments7
           READ              CommentsFL7,CommentsKY7;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDComments7
           READ              CommentsFL7,CommentsKY7;CommentsREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDComments7LK
           READLK            CommentsFL7,CommentsKY7;CommentsREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSComments7
           READKS            CommentsFL7;CommentsREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSComments7LK

           READKSLK          CommentsFL7;CommentsREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPComments7
          READKP             CommentsFL7;CommentsREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPComments7LK

           READKPLK          CommentsFL7;CommentsREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Eighth file I/O operations
.
           %IFDEF            CommentsKY8
.
TSTComments8
           READ              CommentsFL8,CommentsKY8;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDComments8
           READ              CommentsFL8,CommentsKY8;CommentsREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDComments8LK
           READLK            CommentsFL8,CommentsKY8;CommentsREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSComments8
           READKS            CommentsFL8;CommentsREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSComments8LK

           READKSLK          CommentsFL8;CommentsREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPComments8
          READKP             CommentsFL8;CommentsREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPComments8LK

           READKPLK          CommentsFL8;CommentsREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.=============================================================================
. Ninth file I/O operations
.
           %IFDEF            CommentsKY9
.
. Third set of File I/O operations
.
TSTComments9
           READ              CommentsFL9,CommentsKY9;;
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Read for PRIMARY Index
.
RDComments9
           READ              CommentsFL9,CommentsKY9;CommentsREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Random Locked Read for PRIMARY Index
.
RDComments9LK
           READLK            CommentsFL9,CommentsKY9;CommentsREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Sequential Read for PRIMARY Index
.
KSComments9
           READKS            CommentsFL9;CommentsREC
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Locked Sequential Read for PRIMARY Index
.
KSComments9LK

           READKSLK          CommentsFL9;CommentsREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
.
. Key Previous Read for PRIMARY Index
.
KPComments9
          READKP             CommentsFL9;CommentsREC
          GOTO               #ERROR IF OVER
          GOTO               #VALID
.
. Key Locked Previous Read for PRIMARY Index
.
KPComments9LK

           READKPLK          CommentsFL9;CommentsREC
           GOTO              #LOCKED IF LESS
           GOTO              #ERROR IF OVER
           GOTO              #VALID
           %ENDIF
.
.=============================================================================
.
. Deletion for PRIMARY Index
.
DELComments
           READ              CommentsFL,CommentsKY;;
           GOTO              #ERROR IF OVER
DELCommentsLK
           DELETE            CommentsFLST
           GOTO              #VALID
.
. Update I/O operation
.
UPDComments
.           READ              CommentsFL,CommentsKY;;
.           GOTO              #ERROR IF OVER
UPDCommentsLK
           UPDATE            CommentsFLST;CommentsREC
           GOTO              #VALID
.
. Write I/O operation
.
WRTComments
           WRITE             CommentsFLST;CommentsREC
           GOTO              #VALID
.
. Preparation of Commentser Transaction Files
.
PREPComments
           %IFDEF            CommentsKY
             PREPARE           CommentsFL,CommentsTXTNM,CommentsISI1NM,CommentsI1DEF,CommentsFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CommentsKY2
             PREPARE           CommentsFL2,CommentsTXTNM,CommentsISI2NM,CommentsI2DEF,CommentsFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CommentsKY3
             PREPARE           CommentsFL3,CommentsTXTNM,CommentsISI3NM,CommentsI3DEF,CommentsFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CommentsKY4
             PREPARE           CommentsFL4,CommentsTXTNM,CommentsISI4NM,CommentsI4DEF,CommentsFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CommentsKY5
             PREPARE           CommentsFL5,CommentsTXTNM,CommentsISI5NM,CommentsI5DEF,CommentsFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CommentsKY6
             PREPARE           CommentsFL6,CommentsTXTNM,CommentsISI6NM,CommentsI6DEF,CommentsFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CommentsKY7
             PREPARE           CommentsFL7,CommentsTXTNM,CommentsISI7NM,CommentsI7DEF,CommentsFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CommentsKY8
             PREPARE           CommentsFL8,CommentsTXTNM,CommentsISI8NM,CommentsI8DEF,CommentsFSIZE,EXCLUSIVE
           %ENDIF
           %IFDEF            CommentsKY9
             PREPARE           CommentsFL9,CommentsTXTNM,CommentsISI9NM,CommentsI9DEF,CommentsFSIZE,EXCLUSIVE
           %ENDIF
           RETURN

.
. Opening of Check Register Transaction File
.
OPENComments
           GETFILE           CommentsFL
           RETURN            IF ZERO
           OPEN              CommentsFLST,SHARE,LOCKMANUAL,SINGLE,NOWAIT
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
#S

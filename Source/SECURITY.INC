#RESULT    FORM              1
.
. This routine does nothing more than check to see if the user is logged onto the system.
. If the Logged On flag is not properly set, than the user is NOT properly logged into
. the system.  If it is set to Zero, then the user is properly logged into the system
. and we can continue without any problems.
.
           IF                ($LoggedOn = 1)     .User is not properly logged into the system
             ALERT             STOP,"User not logged into system.  Please login before continuing",#RESULT
             RETURN
           ENDIF

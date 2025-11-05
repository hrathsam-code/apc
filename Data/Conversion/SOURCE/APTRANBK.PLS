. --------BAD TRANSACTION FILE KEY---------------------------------------------
APTRANBK BEEP
         DISPLAY   *R,*R,*P1:24,"THE TRANSACTION FILE MUST BE RE-INDEXED"
         DISPLAY   *R,*P1:24,"KILL ALL COPIES OF APTRANFL/ISI BEFORE ":
                             "PROCEEDING"
         KEYIN     *R,*P1:24,"HIT ENTER TO END PROGRAM",TACCN
         STOP
. -----------------------------------------------------------------------------

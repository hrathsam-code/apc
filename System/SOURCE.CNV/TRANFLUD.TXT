. TRANFLUD/TXT - UPDATE THE A/P TRAN FILE
. 
. THIS PROGRAM WILL PERMIT THE UPDATE OF THE G/L CODE, DESCRIPTION, CHECK NO
. 
. 
         INCLUDE   NCOMMON.TXT
. 
         INCLUDE   APTRANFD.TXT
. 
APTRANFL IFILE     KEYL=19,UNCOMPRESSED
APTRANNM INIT      "F:\DATA\APTRANFL.ISI"
. 
         INCLUDE   APMASTFD.TXT
. 
APMASTER IFILE     KEYL=6,UNCOMPRESSED
APMASTNM INIT      "F:\DATA\APMASTER.ISI"
. 
APDISTFL IFILE     KEYL=6,UNCOMPRESSED
APDISTNM INIT      "F:\DATA\APDISTFL.ISI"
. 
DCODE    DIM       6
DESC2    DIM       20
. 
. 
REPLY    DIM       1
. 
BUILDKEY DIM       19
UPDATESW DIM       1
. 
NMON     FORM      2
LOOPTIME FORM      "0"
LASTCMD  INIT      "G"
. 
ROLLNAME  INIT      "F:\DATA\ROLLFILE.SYS"
         ROLLOUT  "APINDX2.BAT"
         DISPLAY   *ES,*P01:01,*HON,"MODIFY A/P TRANSACTION MASTER FILE":
                   *P01:03,"THIS PROGRAM WILL ALLOW YOU TO CHANGE THE FOLL":
                           "OWING (OR DELETE RECORD)":
                   *P01:04,"DESCRIPTION, AMOUNT OR G/L DISTRIBUTION ":
                           "CODE",*HOFF
. 
         OPEN      APTRANFL,APTRANNM
         OPEN      APMASTER,APMASTNM
         OPEN      APDISTFL,APDISTNM
. 
LOOPIT   DISPLAY   *P01:22,*EL
         KEYIN     *P01:23,"(G)et record, (U)pdate, (D)elete record, ":
                           "(E)nd ",REPLY
. 
         MOVE      "0" TO LOOPTIME
         CMATCH    "G" TO REPLY
         GOTO      READIT IF EQUAL
. 
         CMATCH    "U" TO REPLY
         GOTO      UPDATEIT IF EQUAL
. 
         CMATCH    "E" TO REPLY
         GOTO      EOJ IF EQUAL
.
         CMATCH    "D" TO REPLY
         GOTO      DELETE IF EQUAL
. 
         BEEP
         GOTO      LOOPIT
. 
DELETE   CMATCH    "X",UPDATESW
         GOTO      KILLIT IF EQUAL
         BEEP
         DISPLAY   *P1:23,*EL,*HON,"YOU MUST FIRST GET A RECORD ! ",*W3:
                   *HOFF,*P1:23,*EL
         GOTO      LOOPIT
.
.
READIT   MOVE      " " TO UPDATESW
. 
         MOVE      "G" TO LASTCMD
. 
         DISPLAY   *P1:5,*EF
         KEYIN     *P1:6,"ENTER VENDOR NUMBER ",*DE,TACCN
         KEYIN     *P1:7,"ENTER INVOICE NUMBER ",*JR,TINVNO
         KEYIN     *P1:8,"ENTER INVOICE DATE  (MM/DD/YY) ":
                         *+,*DE,TMON,"/",*+,*DE,TDAY,"/",*-,*DE,TYEAR
         REPLACE   " 0" IN TMON
. 
         MOVE      TACCN TO ACCKEY
. 
         INCLUDE   APMASTRD.TXT
. 
. 
SETUP    MOVE      "                   "  TO  TRNKEY
         CLEAR     TRNKEY
. 
         APPEND    TACCN TO TRNKEY
         RESET     TRNKEY  TO  6
. 
         APPEND    TYEAR TO TRNKEY
         APPEND    TMON  TO TRNKEY
         APPEND    TDAY  TO TRNKEY
         APPEND    TINVNO TO TRNKEY
         APPEND    "0"    TO TRNKEY
. 
         RESET     TRNKEY TO 19
         LENSET    TRNKEY
         RESET     TRNKEY TO 1
         RESET     TRNKEY
. 
         DISPLAY   *P60:23,*HON,TRNKEY,*HOFF
         TRAPCLR   IO
         TRAP      NOTFND IF IO
. 
         ADD       "1" TO LOOPTIME
. 
         INCLUDE   APTRANRD.TXT
. 
         GOTO      NOTFND IF OVER
. 
         READ      APDISTFL,TDCODE;DCODE,DESC2
. 
DISPVAR  DISPLAY   *P41:6,NAME:
                   *P1:10,"DESCRIPTION    ",TDESC:
                   *P1:11,"TRANS AMOUNT   ",TAMT:
                   *P1:12,"G/L DIST CODE  ",TDCODE:
                   *P16:13,DESC2
. 
         MOVE      "X" TO UPDATESW        (PREPARE TO WRITE IT BACK!)
. 
         GOTO      LOOPIT
. 
NOTFND   COMPARE   "1" TO LOOPTIME
         GOTO      BEEPIT IF NOT EQUAL
         MOVE      TMON TO NMON
         MOVE      NMON TO TMON
         ADD       "1" TO LOOPTIME
         GOTO      SETUP
. 
BUMGLCD  BEEP
         DISPLAY   *P1:22,*HON,"BAD G/L CODE ENTERED - RETRY !",*HOFF,*W2
         DISPLAY   *P1:22,*EL
         GOTO      UPDATEIT
. 
BEEPIT   BEEP
         DISPLAY   *P1:23,*HON,"RECORD NOT FOUND",*W3,*HOFF,*P1:23,*EL
         MOVE      "0" TO LOOPTIME
         GOTO      LOOPIT
. 
UPDATEIT CMATCH    "X" TO UPDATESW
         GOTO      LOOPIT IF NOT EQUAL  (THERE HAD BETTER BE A RECORD!)
. 
         MOVE      "U" TO LASTCMD
. 
KILLIT   MOVE      " "  TO  REPLY
         KEYIN     *P01:22,*HON,"DELETE THIS RECORD ? (Y/N) ",*HOFF,REPLY
         CMATCH    "Y" TO REPLY
         GOTO      KILLS IF EQUAL
         CMATCH    "N" TO REPLY
         GOTO      UDCONT IF EQUAL
         BEEP
         GOTO      KILLIT
. 
KILLS    DELETE    APTRANFL,TRNKEY
. 
         DISPLAY   *P01:22,*EL,*HON,"RECORD DELETED ",*HOFF,*W2
         DISPLAY   *P01:22,*EL
         GOTO      UDOUT
. 
. 
UDCONT   KEYIN     *P41:10,*RV,TDESC:
                   *P41:11,*RV,TAMT:
                   *P41:12,*RV,TDCODE
. 
         MOVE      "BAD G/L CODE" TO DESC2
. 
         TRAPCLR   IO
         TRAP      NOTFND IF IO
. 
         READ      APDISTFL,TDCODE;DCODE,DESC2
         GOTO      BUMGLCD IF OVER
. 
         DISPLAY   *P56:13,*HON,DESC2,*HOFF,*W2
. 
         UPDATE    APTRANFL;TACCN,TYEAR,TMON,TDAY,TINVNO,TCNT:
                            TDESC,TAMT,TLDDAY,TDISA,TDCODE
. 
         BEEP
         DISPLAY   *P1:23,*HON,"UPDATE SUCCESSFUL",*HOFF,*W2
UDOUT    MOVE      " " TO UPDATESW
         MOVE      "G" TO LASTCMD    (DONT WRITE IT AGAIN!)
         GOTO      LOOPIT
. 
EOJ      CMATCH    "G" TO LASTCMD
         GOTO      UPDATEIT IF NOT EQUAL
.
EOJ1     KEYIN     *P1:23,*EL,"DO YOU WISH TO INDEX TRANSACTIONS AT ":
                   "THIS TIME? (Y/N) ",REPLY
         CMATCH    "Y",REPLY
         GOTO      CHAINOUT IF NOT EQUAL
.
. 
. 
....        ROLLOUT   "CHAIN APINDX3/CHN",ROLLNAME
          ROLLOUT  "APINDX2.BAT"
          DISPLAY   *P1:20,*EF,*P1:22,*HON,"A/P FILES HAVE BEEN":
                                " REINDEXED ",*HOFF,*W2
. 
CHAINOUT CHAIN     "APMENU1"
. 

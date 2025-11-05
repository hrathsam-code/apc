.  NCL STUDS INC - EDP CONTROLS INQUIRY
. 
. WRITTEN BY R BACHARACH, MICRO SYSTEMS CONSULTANTS
.                         41 TEELE DRIVE
.                         CORAM, NEW YORK 11727
.                         (516) 698-9648
. 
         INCLUDE   COMMON
NAME     INIT      "NCLCTRLS/ISI:NCLRES"
REPLY    DIM       1
LASTCMD  INIT      " "  (LAST COMMAND EXECUTED)
INPUT    IFILE     (ISAM INPUT )
SWITCH   FORM      1 (ONE-SHOT)
PRIMEKEY DIM       3
*............................................................
.FIELD   TYPE      LENGTH    FROM-TO   DESCRIPTION
.-----   ----      ------    -------   -----------
FIELD01  DIM        3          1-  3   COMPANY ISAM KEY
FIELD02  DIM        8          4- 11   DATE OF LAST UPDATE
NFIELD03 FORM       5                  (NUMERIC WORK FIELD)
FIELD03  DIM        5         12- 16   NEXT INVOICE NUMBER        5.0
NFIELD04 FORM       4                  (NUMERIC WORK FIELD)
FIELD04  DIM        4         17- 20   NEXT P.O. NUMBER           4.0
NFIELD05 FORM       7.2                (NUMERIC WORK FIELD)
FIELD05  DIM       10         21- 30   DAILY INVENTORY $ RECEIVED 7.2
NFIELD06 FORM       7.2                (NUMERIC WORK FIELD)
FIELD06  DIM       10         31- 40   DAILY INVENTORY $ SOLD     7.2
NFIELD07 FORM       7.2                (NUMERIC WORK FIELD)
FIELD07  DIM       10         41- 50   DAILY CASH RECEIVED/PROCES 7.2
NFIELD08 FORM       7.2                (NUMERIC WORK FIELD)
FIELD08  DIM       10         51- 60   MTD INVENTORY $ RECEIVED   7.2
NFIELD09 FORM       7.2                (NUMERIC WORK FIELD)
FIELD09  DIM       10         61- 70   MTD INVENTORY $ SOLD       7.2
NFIELD10 FORM       7.2                (NUMERIC WORK FIELD)
FIELD10  DIM       10         71- 80   MTD CASH RECEIVED/PROCESSE 7.2
NFIELD11 FORM       8.2                (NUMERIC WORK FIELD)
FIELD11  DIM       11         81- 91   YTD INVENTORY VALUE RECEIV 8.2
NFIELD12 FORM       8.2                (NUMERIC WORK FIELD)
FIELD12  DIM       11         92-102   YTD INVENTORY VALUE SOLD   8.2
NFIELD13 FORM       8.2                (NUMERIC WORK FIELD)
FIELD13  DIM       11        103-113   YTD CASH RECEIVED/PROCESSE 8.2
WORK03   DIM        3
WORK04   DIM        4
WORK05   DIM        5
WORK08   DIM        8
WORK10   DIM       10
WORK11   DIM       11
SAVE     DIM       11
+............................................................
. MAINLINE FOLLOWS
. FILE OPENING SEQUENCE
*............................................................
. OPEN INPUT FILE
         TRAP      NOFILE IF IO
         OPEN      INPUT,NAME
         GOTO      OPENED
NOFILE   BEEP
         DISPLAY   *ES,*P01:12,"WARNING! WARNING! WARNING!":
                   *N,"THE EDP CONTROLS FILE IS MISSING":
                   *N,"NOTIFY R. BACHARACH, MICRO SYSTEMS CONSULTANTS":
                      " IMMEDIATELY - TEL. NO. 698-5577",*W,*W
         GOTO      NOFILE
. 
OPENED   TRAPCLR   IO
*............................................................
. INITIAL SCREEN DISPLAY SEQUENCE
LOOP     DISPLAY   *ES:
                   *P16:01,"CORPORATE CONTROL DATA FOR NCL STUDS INC.":
                   *P01:03,"COMPANY: NCL   DATE: ________   NEXT INVOICE## ":
                   "_____   NEXT P.O.## ____":
                   *P24:05,"DAILY CONTROL INFORMATION":
                   *P16:07,"INVENTORY VALUE RECEIVED:   __________":
                   *P16:08,"INVENTORY VALUE SOLD:       __________":
                   *P16:09,"CASH RECEIVED/PROCESSED:    __________":
                   *P18:11,"MONTH-TO-DATE CONTROL INFORMATION":
                   *P16:13,"INVENTORY VALUE RECEIVED:   __________":
                   *P16:14,"INVENTORY VALUE SOLD:       __________":
                   *P16:15,"CASH RECEIVED/PROCESSED:    __________":
                   *P19:17,"YEAR-TO-DATE CONTROL INFORMATION":
                   *P16:19,"INVENTORY VALUE RECEIVED:   ___________":
                   *P16:20,"INVENTORY VALUE SOLD:       ___________":
                   *P16:21,"CASH RECEIVED/PROCESSED:    ___________":
                   *EL
*............................................................
. GET COMMAND
         TABPAGE   ****
*............................................................
. GET A RECORD
...GET      KEYIN     *P01:23,"GIVE ME THE COMPANY KEY PLEASE..":
....                       "(LIB) OR (REP) ",PRIMEKEY
GET      MOVE      "NCL" TO PRIMEKEY
         CMATCH    " " TO PRIMEKEY
         GOTO      EOJ IF  EOS
. 
.   CHECK THE KEY VALUE FOR DISPLAY TITLE
. 
         MATCH     "LIB" TO PRIMEKEY
         CALL      MOVLIB IF EQUAL
         MATCH     "REP" TO PRIMEKEY
         CALL      MOVREP IF EQUAL
GET1     READ      INPUT,PRIMEKEY;FIELD01:
                   FIELD02:
                   FIELD03:
                   FIELD04:
                   FIELD05:
                   FIELD06:
                   FIELD07:
                   FIELD08:
                   FIELD09:
                   FIELD10:
                   FIELD11:
                   FIELD12:
                   FIELD13
         GOTO      DISPVAR IF NOT OVER
         BEEP
         DISPLAY   *P63:24,"RECORD NOT FOUND",*W,*W
         MOVE      " " TO LASTCMD
         GOTO      LOOP
MOVLIB   DISPLAY   *P43:01,"LIBERTY FASTENERS INC.  "
         RETURN
MOVREP   DISPLAY   *P43:01,"REPUBLIC FASTENERS INC. "
         RETURN
*............................................................
. DISPLAY VARIABLES
DISPVAR  DISPLAY   *P63:24,*EL:
                   *P10:03,FIELD01:
                   *P22:03,FIELD02:
                   *P47:03,FIELD03:
                   *P66:03,FIELD04:
                   *P44:07,FIELD05:
                   *P44:08,FIELD06:
                   *P44:09,FIELD07:
                   *P44:13,FIELD08:
                   *P44:14,FIELD09:
                   *P44:15,FIELD10:
                   *P44:19,FIELD11:
                   *P44:20,FIELD12:
                   *P44:21,FIELD13:
                   *P10:24,"PRESS ENTER KEY TO TERMINATE THIS PROGRAM"
         KEYIN     REPLY
*............................................................
. END OF JOB
EOJ      CHAIN     "NCLCTLS"
. 

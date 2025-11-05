@ECHO OFF
REM The DRDOSBEG and DRDOSEND labels tell the SETUP program which
REM statements it should process. Put any additional statements for
REM DR DOS between these two labels. Any other statements e.g. for
REM other operating systems should be placed outside the labels.
:DRDOSBEG
CLS
PROMPT $P$G
PATH C:\;C:\DRDOS;C:\DBC;C:\CC
TYPE INSTR.TXT
VERIFY OFF
PROMPT $P$G
DATE
TIME
CD \CC
CC
CD \
CD \DBC
DBC.BAT
CLS
C:\
TYPE MENU.TXT
:DRDOSEND


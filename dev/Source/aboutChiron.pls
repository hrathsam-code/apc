;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    4 NORFOLK LANE                                           ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    ABOUTChiron.PLS                                                ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    12/10/2004 AT 3:23AM                                           ;
;                                                                             ;
;  PURPOSE:    Provides information about this program and others             ;
;                                                                             ;
; REVISION:    VER     DATE     INIT       DETAILS                            ;
;                                                                             ;
;              1.0   05/07/2015   HOR     INITIAL VERSION                     ;
;                                                                             ;
;=============================================================================;

              INCLUDE           Workvar.inc
VersionInfo   DIM               40

Version       RECORD
Library       DIM               5
Blank1        DIM               1
RunTime       DIM               8
Blank2        DIM               1
SystemID      DIM               2
Blank3        DIM               1
ClientName    DIM               8
ClientVersion DIM               5
              RECORDEND

VersionText   DIM               14
#ProgramName   DIM               ^
#ProgramStamp  DIM               ^
#ProgramSerial DIM               ^
#ProgramVer    DIM               ^
#CompileDate   DIM               ^


AboutForm     PLFORM            AboutChiron.PLF

STARTPGM      ROUTINE

              INCLUDE           ErrorLib.INC

              FORMLOAD          AboutForm

              SETPROP           WAbout,Visible=1

              RETURN

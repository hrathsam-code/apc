;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    4 NORFOLK LANE                                           ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    ABOUT.PLS                                                      ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    12/10/2004 AT 3:23AM                                           ;
;                                                                             ;
;  PURPOSE:    Provides information about this program and others             ;
;                                                                             ;
; REVISION:    VER     DATE     INIT       DETAILS                            ;
;                                                                             ;
;              1.0   12/10/2004   HOR     INITIAL VERSION                     ;
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


AboutForm     PLFORM            About.PLF

STARTPGM      ROUTINE           #ProgramName,#ProgramStamp,#ProgramVer,#ProgramSerial

              INCLUDE           ErrorLib.INC

              FORMLOAD          AboutForm

              CLOCK             Version,VersionInfo
              UNPACK            VersionInfo into Version
              chop              Version.RunTime,Version.RunTime

              PACK              VersionText FROM Version.RunTime," - ",Version.Library

.              getmode           *ProgName=ProgramName

.              getmode           *ProgSerial=ProgramSerial
.              getmode           *ProgStamp=ProgramStamp
.              getmode           *ProgVer=ProgramVer

              UPPERCASE         #ProgramName

              UNPACK            #ProgramStamp,CC,YY,MM,DD,Hours,Minutes,Seconds
              PACK              #ProgramStamp,MM,"/",DD,"/",YY," - ",Hours,":",Minutes,":",Seconds

              setprop           ECompileInfo,text=#ProgramStamp
              setprop           ERunTime,text=VersionText
              setprop           EModule,text=#ProgramName
              setprop           SETAboutVersion,text=#ProgramSerial

              SETPROP           WAbout,Visible=1

.              LOOP
.                WAITEVENT
.              REPEAT

              RETURN

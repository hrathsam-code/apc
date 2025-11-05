;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    4 NORFOLK LANE                                           ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    ERRORLIB.INC                                                   ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    01/16/2005 AT 11:29PM                                          ;
;                                                                             ;
;  PURPOSE:    Designed to capture any Errors created during Program          ;
;              operation.                                                     ;
;                                                                             ;
;                                                                             ;
; REVISION:    VER     DATE     INIT       DETAILS                            ;
;                                                                             ;
;              1.0   01/16/2005   HOR     INITIAL VERSION                     ;
;                                                                             ;
;=============================================================================;
#ErrorMessage DIM               100
#ErrorFile    FILE
#ErrorDisplay DIM               156
#ErrorTime2   DIM               18
#ErrorTime    DIM               30
#ErrorProgram DIM               15
#ProgramStamp DIM               25

ErrorCode    DIM               5
ErrorAddress DIM               12
ErrorSubCode DIM               15

              EXCEPTSET         ProgramException IF IO
              EXCEPTSET         ProgramException IF CFail
              EXCEPTSET         ProgramException IF DBFail
              EXCEPTSET         ProgramException IF Format
              EXCEPTSET         ProgramException IF Object
              EXCEPTSET         ProgramException IF Parity
              EXCEPTSET         ProgramException IF Range
              EXCEPTSET         ProgramException IF Spool
              EXCEPTSET         ProgramException IF User

              GOTO              #End

ProgramException
              CLOCK             TimeStamp,#ErrorTime

              getmode           *ProgName=#ErrorProgram
              getmode           *ProgStamp=#ProgramStamp
              getmode           *ProgVer=ProgramVer

              UPPERCASE         #ErrorProgram

              UNPACK            #ErrorTime,CC,YY,MM,DD,Hours,Minutes,Seconds
              PACK              #ErrorTime2,MM,"/",DD,"/",YY," - ",Hours,":",Minutes

              explode           s$error$ into " ",ErrorCode,ErrorAddress
              squeeze           s$error$,s$error$
              MOVE              s$error$,ErrorSubCode

              SQUEEZE           ErrorCode,ErrorCode
              SQUEEZE           ErrorAddress,ErrorAddress

              PACK              #ErrorDisplay FROM "An Error has occured at ",AlertReturn:
                                                   AlertReturn:
                                                   "Address   :   ",ErrorAddress,AlertReturn:
                                                   "Error        :   ",ErrorCode,AlertReturn:
.                                                   "SubCode  :   ",ErrorSubCode:
                                                   AlertReturn:
                                                   "Please Record this error for Chiron Tech Support Services"

              alert             stop,#ErrorDisplay,result,"CSM Program Error"

              ExceptClear       ALL

              TRAP              NoErrorFile if IO
              OPEN              #ErrorFile,"ErrorLogFile.Log"
              WRITE             #ErrorFile,SEQEof;*CDFON,#ErrorTime2,#ErrorProgram:
                                                         #ProgramStamp,ProgramVer:
                                                         ErrorAddress,ErrorCode:
                                                         ErrorSubCode:
                                                         *CDFOFF
              WEOF              #ErrorFile,SEQEof
              CLOSE             #ErrorFile
              STOP

NoErrorFile
              PREP              #ErrorFile,"ErrorLogFile.Log",Exclusive
              RETURN
#End

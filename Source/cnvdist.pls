;=============================================================================;
;       created by:  chiron software & services, inc.                         ;
;                    4 norfolk lane                                           ;
;                    bethpage, ny  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  program:    cnvdist                                                   ;
;                                                                             ;
;   author:    harry rathsam                                                  ;
;                                                                             ;
;     date:    01/28/2019 at 12:28pm                                             ;
;                                                                             ;
;  purpose:                                                                   ;
;                                                                             ;
; revision:    ver     date     init       details                            ;
;                                                                             ;
;              1.0   01/28/2019   hor     initial version                     ;
;                                                                             ;
;                                                                             ;
;=============================================================================;

              INCLUDE           Workvar.INC

              INCLUDE           CMPNY.FD         //HR 6/21/2003
              INCLUDE           Cntry.FD
              INCLUDE           Sequence.FD

              INCLUDE           GLMast.FD

OldGLMSTFL    FILE
APPaidFL      FILE

OldDist       RECORD
CODE          DIM               6
DESCription   DIM               20
              RECORDEND


              OPEN              OldGLMSTFL,"APDISTFL",READ

              CALL              OpenCMPNY
              CALL              OpenGLMast

              LOOP
              READ              OldGLMSTFL,SEQ;OldDist
              UNTIL             over
                SQUEEZE           OldDist.Code,OldDist.Code
                MOVE              OldDist.Description,GLMAst.Desc
                MOVE              OlDDist.Description,GLMast.FSDesc
                MOVE              OldDist.Code,GLMast.Account
                CALL              WrtGLMast
              REPEAT






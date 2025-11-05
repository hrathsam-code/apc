;=============================================================================;
;       created by:  chiron software & services, inc.                         ;
;                    4 norfolk lane                                           ;
;                    bethpage, ny  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  program:    fixtestdata                                                   ;
;                                                                             ;
;   author:    harry rathsam                                                  ;
;                                                                             ;
;     date:    08/06/2019 at 10:20am                                             ;
;                                                                             ;
;  purpose:                                                                   ;
;                                                                             ;
; revision:    ver     date     init       details                            ;
;                                                                             ;
;              1.0   08/06/2019   hor     initial version                     ;
;                                                                             ;
;                                                                             ;
;=============================================================================;

                    include            WorkVar.inc
                    include            BatchChecks.FD

                    call               OpenBatchChecks

                    move               " ",BatchChecksKY
                    call               RDBatchChecks

                    loop
                      call               KSBatchChecks
                    until (ReturnFl = 1)
                    squeeze            BatchChecks.CustomerID,BatchChecks.CustomerID
                    continue           if (BatchChecks.CustomerID != "1016")
                    call               DelBatchChecks
                    repeat

;=============================================================================;
;       created by:  chiron software & services, inc.                         ;
;                    4 norfolk lane                                           ;
;                    bethpage, ny  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  program:    fixbatchchecks2                                                   ;
;                                                                             ;
;   author:    harry rathsam                                                  ;
;                                                                             ;
;     date:    09/24/2019 at 3:31pm                                             ;
;                                                                             ;
;  purpose:                                                                   ;
;                                                                             ;
; revision:    ver     date     init       details                            ;
;                                                                             ;
;              1.0   09/24/2019   hor     initial version                     ;
;                                                                             ;
;                                                                             ;
;=============================================================================;

                   include           WorkVar.inc
                   include           BatchChecks.fd

                   call              OpenBatchChecks

                   packkey            BatchChecksKY from $Entity
                   call               RDBatchChecks

                   loop
                     call               KSBatchChecks
                   until              (ReturnFl = 1 or BatchChecks.BatchPosted = 1)
                     continue           if (BatchChecks.Amount != 0)
                     call              DelBatchChecks
                   repeat


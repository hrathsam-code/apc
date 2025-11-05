;=============================================================================;
;       created by:  chiron software & services, inc.                         ;
;                    4 norfolk lane                                           ;
;                    bethpage, ny  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  program:    fixardet                                                   ;
;                                                                             ;
;   author:    harry rathsam                                                  ;
;                                                                             ;
;     date:    08/05/2019 at 8:32am                                             ;
;                                                                             ;
;  purpose:                                                                   ;
;                                                                             ;
; revision:    ver     date     init       details                            ;
;                                                                             ;
;              1.0   08/05/2019   hor     initial version                     ;
;                                                                             ;
;                                                                             ;
;=============================================================================;

                    include            Workvar.inc
                    include            ARDet.fd

                    call               OpenARDet

                    move               " ",ARDetKY
                    call               RDARDet

                    loop
                      call               KSARDet
                    until (ReturnFl = 1)
                      MOVE              ARDet.TransDate,ARDet.EntryDate
                      MOVE              ARDet.TransDate,ARDet.BillDate
                      MOVE              ARDet.TransDate,ARDet.DiscDate
                      MOVE              ARDet.TransDate,ARDet.PostDate
                      call               UPDARDet
                    repeat

;=============================================================================;
;       created by:  chiron software & services, inc.                         ;
;                    4 norfolk lane                                           ;
;                    bethpage, ny  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  program:    killbatches                                                   ;
;                                                                             ;
;   author:    harry rathsam                                                  ;
;                                                                             ;
;     date:    07/31/2019 at 5:12pm                                             ;
;                                                                             ;
;  purpose:                                                                   ;
;                                                                             ;
; revision:    ver     date     init       details                            ;
;                                                                             ;
;              1.0   07/31/2019   hor     initial version                     ;
;                                                                             ;
;                                                                             ;
;=============================================================================;

                    include            WorkVar.inc
                    include            Batch.fd
                    include            BatchDetails.fd
                    include            BatchChecks.fd

                    call               OpenBatch
                    call               OpenBatchDetails
                    call               OpenBatchChecks

OldBatch            form               9
NewBatch            form               9

                    loop
                      keyin              *P10:10,"Enter Old Batch Number to Rename : ",OldBatch
                    until (escape)
                      keyin              *P10:10,"Enter New Batch Number to Rename : ",NewBatch

                      move               "APC",Batch.Entity
                      packkey            BatchKY from Batch.Entity,OldBatch
                      call               RDBatch
                      if                 (ReturnFl = 1)
                        transaction        rollback
                        beep
                        alert              note,"Unable to locate the Batch",result,"BATCH UNAVAILABLE"
                        continue
                      endif
                      move               NewBatch,Batch.BatchID
                      call               UPDBatch
                    repeat

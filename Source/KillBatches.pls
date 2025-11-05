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

BatchEntered        form               9

                    loop
                      keyin              *P10:10,"Enter Batch Number to Delete : ",BatchEntered
                    until (escape)
                      move               "APC",Batch.Entity
                      packkey            BatchKY from Batch.Entity,BatchEntered
                      call               RDBatch
                      if                 (ReturnFl = 1)
                        transaction        rollback
                        beep
                        alert              note,"Unable to locate the Batch",result,"BATCH UNAVAILABLE"
                        continue
                      endif

                      packkey                BatchDetailsKY from $Entity,"  ",Batch.SeqNo
                      call                   RDBatchDetails
                      loop
                        call               KSBatchDetails
                      until (ReturnFl = 1 or BatchDetails.SeqNo != Batch.SeqNo)

                        packkey          BatchChecksKY2 from $Entity,BatchDetails.BatchCheckSeqNo
                        call             RDBatchChecks2
                        if                 (ReturnFl = 1)
                          transaction        rollback
                          beep
                          alert              note,"Unable to locate the Batch",result,"BATCH UNAVAILABLE"
                          continue
                        else
                          call           DelBatchChecks
                        endif
                        call               DelBatchDetails
                      repeat
                      call               DelBatch
                    repeat

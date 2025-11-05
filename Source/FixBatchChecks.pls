;=============================================================================;
;       created by:  chiron software & services, inc.                         ;
;                    4 norfolk lane                                           ;
;                    bethpage, ny  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  program:    fixbatchchecks                                                   ;
;                                                                             ;
;   author:    harry rathsam                                                  ;
;                                                                             ;
;     date:    08/05/2019 at 11:07am                                             ;
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
                    include            ARDet.FD
                    include            BatchChecks.FD
                    include            Sequence.FD

CustomerID          dim                6
InvoiceNo           dim                19

                    call               OpenARDet
                    call               OpenBatchChecks
                    call               OpenSequence

                    loop
                      keyin              *ES,*P10:10,"Enter Customer Number : ",BatchChecks.CustomerID
                    until            (Escape)
                      keyin              *P10:12,"    Enter Check No : ",BatchChecks.Checkno
                      keyin              *P10:13,"  Enter Check Date : ",BatchChecks.CheckDate
                      keyin              *P10:14,"Enter Check Amount : ",BatchChecks.Amount
                      keyin              *P10:15,"  Enter Check Type : ",BatchChecks.Type

                      move               $Entity,BatchChecks.Entity
                      GetNextSeq         BatChk
                      move               Sequence.SeqNo,BatchChecks.SeqNo
                      call               WrtBatchChecks
                    repeat


;=============================================================================;
;       created by:  chiron software & services, inc.                         ;
;                    4 norfolk lane                                           ;
;                    bethpage, ny  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  program:    cnvbatches                                                   ;
;                                                                             ;
;   author:    harry rathsam                                                  ;
;                                                                             ;
;     date:    07/18/2019 at 2:58pm                                             ;
;                                                                             ;
;  purpose:                                                                   ;
;                                                                             ;
; revision:    ver     date     init       details                            ;
;                                                                             ;
;              1.0   07/18/2019   hor     initial version                     ;
;                                                                             ;
;                                                                             ;
;=============================================================================;

                    include            WorkVar.inc

                    include            Sequence.FD
;==========================================================================================================
BATCHKEY DIM       5
.
BSTATUS  DIM       1       ("B" BALANCED, "U" UNBALANCED, "C" CANCELED)
BCHECKS  FORM      2
BATCHTOT FORM      7.2
BTCHDATE DIM       6       (YYMMDD)
.
ACCTARG  DIM       4
BACCT1   DIM       4
BACCT2   DIM       4
BACCT3   DIM       4
BACCT4   DIM       4
BACCT5   DIM       4
BACCT6   DIM       4
BACCT7   DIM       4
BACCT8   DIM       4
BACCT9   DIM       4
BACCT10  DIM       4
BACCT11  DIM       4
BACCT12  DIM       4
BACCT13  DIM       4
BACCT14  DIM       4
BACCT15  DIM       4
BACCT16  DIM       4
BACCT17  DIM       4
BACCT18  DIM       4
BACCT19  DIM       4
BACCT20  DIM       4
.
BCHKNO1  DIM       6
BCHKNO2  DIM       6
BCHKNO3  DIM       6
BCHKNO4  DIM       6
BCHKNO5  DIM       6
BCHKNO6  DIM       6
BCHKNO7  DIM       6
BCHKNO8  DIM       6
BCHKNO9  DIM       6
BCHKNO11 DIM       6
BCHKNO12 DIM       6
BCHKNO13 DIM       6
BCHKNO14 DIM       6
BCHKNO15 DIM       6
BCHKNO16 DIM       6
BCHKNO17 DIM       6
BCHKNO18 DIM       6
BCHKNO19 DIM       6
BCHKNO20 DIM       6
.
BDTPD1   DIM       6
BDTPD2   DIM       6
BDTPD3   DIM       6
BDTPD4   DIM       6
BDTPD5   DIM       6
BDTPD6   DIM       6
BDTPD7   DIM       6
BDTPD8   DIM       6
BDTPD9   DIM       6
BDTPD10  DIM       6
BDTPD11  DIM       6
BDTPD12  DIM       6
BDTPD13  DIM       6
BDTPD14  DIM       6
BDTPD15  DIM       6
BDTPD16  DIM       6
BDTPD17  DIM       6
BDTPD18  DIM       6
BDTPD19  DIM       6
BDTPD20  DIM       6
.
CHECKAMT FORM      6.2
BCAMT1   FORM      6.2
BCAMT2   FORM      6.2
BCAMT3   FORM      6.2
BCAMT4   FORM      6.2
BCAMT5   FORM      6.2
BCAMT6   FORM      6.2
BCAMT7   FORM      6.2
BCAMT8   FORM      6.2
BCAMT9   FORM      6.2
BCAMT10  FORM      6.2
BCAMT11  FORM      6.2
BCAMT12  FORM      6.2
BCAMT13  FORM      6.2
BCAMT14  FORM      6.2
BCAMT15  FORM      6.2
BCAMT16  FORM      6.2
BCAMT17  FORM      6.2
BCAMT18  FORM      6.2
BCAMT19  FORM      6.2
BCAMT20  FORM      6.2
.
BCSTAT1  DIM       1
BCSTAT2  DIM       1
BCSTAT3  DIM       1
BCSTAT4  DIM       1
BCSTAT5  DIM       1
BCSTAT6  DIM       1
BCSTAT7  DIM       1
BCSTAT8  DIM       1
BCSTAT9  DIM       1
BCSTAT10 DIM       1
BCSTAT11 DIM       1
BCSTAT12 DIM       1
BCSTAT13 DIM       1
BCSTAT14 DIM       1
BCSTAT15 DIM       1
BCSTAT16 DIM       1
BCSTAT17 DIM       1
BCSTAT18 DIM       1
BCSTAT19 DIM       1
BCSTAT20 DIM       1
.
.....................
.
BTCHRDKY DIM       11     (YYMMDD&BATCH#)
BATCH5   DIM       5
LASTBTCH DIM       5
THISBTCH DIM       5
BTCHINDX FORM      2
CURRCHK  FORM      2

;==========================================================================================================
InputFile           file
InputCounter        form               7

Dim2                dim                2
X                   form               3

                    include            Batch.fd
                    include            BatchChecks.fd
                    include            BatchDetails.fd

                    call               OpenSequence
                    call               OpenBatch
                    call               OpenBatchChecks
                    call               OpenBatchDetails
                    open               InputFile,"BatchFL",READ

                    transaction        start,BatchFLST,BatchChecksFLST,SequenceFLST,BatchDetailsFLST

                    loop
                      read               InputFile,seq;BATCHKEY,BSTATUS,BCHECKS,BATCHTOT:
                                                       BTCHDATE:
                                                       BACCT1,BACCT2,BACCT3,BACCT4,BACCT5,BACCT6:
                                                       BACCT7,BACCT8,BACCT9,BACCT10,BACCT11,BACCT12:
                                                       BACCT13,BACCT14,BACCT15,BACCT16,BACCT17,BACCT18:
                                                       BACCT19,BACCT20:
                                                       BCAMT1,BCAMT2,BCAMT3,BCAMT4,BCAMT5,BCAMT6,BCAMT7:
                                                       BCAMT8,BCAMT9,BCAMT10,BCAMT11,BCAMT12,BCAMT13:
                                                       BCAMT14,BCAMT15,BCAMT16,BCAMT17,BCAMT18,BCAMT19:
                                                       BCAMT20
                    until (over)
                      incr               InputCounter
                      display          *P10:10,"Input Counter : ",InputCounter
                      move               BtchDate,Dim2
                      continue           if (Dim2 >= "90")
;
; Let's create the Batch Record first
;
..                    debug
                      move               $Entity,Batch.Entity
                      squeeze            BATCHKEY,BatchKey
                      move               BatchKey,Batch.BatchID
                      CONTINUE           if (Batch.BatchID = 0)

                      move               Batch.BatchID,Batch.SeqNo
                      packkey            Batch.BatchDate from "20",BtchDate
                      move               BatchTot,Batch.BatchTotal
                      move               "1",Batch.PostedFlag
                      move               Batch.BatchDate,Batch.PostedDate
.                      call               WRtBatch
;
; Now let's work on the Batch Checks
;
                      move               Batch.Entity,BatchChecks.Entity
                      move               Batch.BatchDate,BatchChecks.CheckDate
                      move               "100",BatchChecks.CheckNo
                      move               "1",BatchChecks.BatchPosted
                      move               "1",BatchChecks.Type
                      move               Batch.SeqNo,BatchChecks.BatchSeqNo

                      for                 BtchIndx from "1" to BChecks using "1"
                        call               LoadBatches

                        move             Batch.BatchDate,BatchDetails.BatchDate
                        move             Batch.Entity,BatchDetails.Entity
                        move             Batch.SeqNo,BatchDetails.SeqNo
                        move             Batch.Entity,BatchDetails.Entity
                        move             Batch.SubEntity,BatchDetails.SubEntity
                        move             "100",BatchDetails.Reference
                        move             BatchChecks.Amount,BatchDetails.CheckAmt
                        move             "1",BatchDetails.PostedFlag
                        move             BatchChecks.CustomerID,BatchDetails.CustomerID


                        GetNextSeq         BatChk
                        move               Sequence.SeqNo,BatchChecks.SeqNo

                        move             Batch.BatchDate,BatchDetails.PostedDate
                        move             BatchChecks.SeqNo,BatchDetails.BatchCheckSeqNo
                        call             WRTBatchDetails





.                        call               WrtBatchChecks
                      repeat
                    repeat
                    transaction        commit

;==========================================================================================================
LoadBatches         LOAD      BatchChecks.CustomerID FROM BTCHINDX OF BACCT1:
                              BACCT2,BACCT3,BACCT4,BACCT5:
                              BACCT6,BACCT7,BACCT8,BACCT9,BACCT10:
                              BACCT11,BACCT12,BACCT13,BACCT14,BACCT15:
                              BACCT16,BACCT17,BACCT18,BACCT19,BACCT20

                    LOAD      BatchChecks.Amount FROM BTCHINDX OF BCAMT1:
                              BCAMT2,BCAMT3,BCAMT4,BCAMT5:
                              BCAMT6,BCAMT7,BCAMT8,BCAMT9,BCAMT10:
                              BCAMT11,BCAMT12,BCAMT13,BCAMT14,BCAMT15:
                              BCAMT16,BCAMT17,BCAMT18,BCAMT19,BCAMT20
                    RETURN












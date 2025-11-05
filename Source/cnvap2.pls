;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    4 NORFOLK LANE                                           ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    CNVAP.PLS                                                      ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    07/12/2005 AT 3:29AM                                           ;
;                                                                             ;
;  PURPOSE:    Convert older A/P Transaction files                            ;
;                                                                             ;
; REVISION:    VER     DATE     INIT       DETAILS                            ;
;                                                                             ;
;              1.0   07/12/2005   HOR     INITIAL VERSION                     ;
;                                                                             ;
;=============================================================================;

              INCLUDE           Workvar.INC

              INCLUDE           Cntry.FD
              INCLUDE           APPaid.FD
              INCLUDE           Bank.FD
              INCLUDE           Check.FD
              INCLUDE           APDist.FD
              INCLUDE           CheckDet.FD
              INCLUDE           VHST.FD
              INCLUDE           Sequence.FD

              INCLUDE           APDET.FD
              INCLUDE           APTRN.FD
              INCLUDE           APTran.FD

Dim1          DIM               1
InputCounter  FORM              8
Days                form               9

APOldTranFL   FILE
APOldPaidFL   FILE

                    OPEN              APOldPaidFL,"APPaid.Fubar",READ

                    call               OpenAPDet
                    call               OpenCheck
                    call               OpenAPDist
                    call               OpenCheckDetail
                    call               OpenAPTrn
                    call               OpenVHST
                    call               OpenSequence
;=============================================================================
.Now read in the Paid file information which is going to need to update/create
.   an APDET transaction
CreatePaidTransactions
                    LOOP
                      READ              APOldPaidFL,SEQ;APPaid
                    UNTIL             (over)
                      MOVE              APPaid.AccountNumber,APTRN.Vendor
                      CONTINUE        IF (APPaid.AccountNumber = "000000")

                      ADD             "1",InputCounter
                      DISPLAY         *P10:10,"Input Counter ",InputCounter

                      IF                (APPaid.TransYear < "50")
                        MOVE              "20",CC
                      ELSE
                        MOVE              "19",CC
                      ENDIF

                      PACKKEY           APTRN.TransDate FROM CC,APPaid.TransYear,APPaid.TransMonth,APPaid.TransDay
                      REPLACE           " 0",APTRN.TransDate

                      MOVE              APPaid.Invoice,APTRN.Invoice
                      MOVE              APPaid.Description,APTRN.Memo
                      MOVE              APPaid.Amount,APTRN.OrigAmt
                      MOVE              APTRn.OrigAmt,APTRN.Balance
                      MOVE              APPaid.DiscountAmt,APTRN.DiscAmt

                      UNPACK            APPaid.LastDiscDay into MM,dim1,DD,dim1,YY
                      IF                (YY < "50")
                        MOVE              "20",CC
                      ELSE
                        MOVE              "19",CC
                      ENDIF

                      PACKKEY           APTRN.DiscDate FROM CC,YY,MM,DD
                      REPLACE           " 0",APTRN.DiscDate

                      CALL              ConvDateToDays using APTrn.TransDate,Days
                      add               "30",Days
                      CALL              ConvDaysToDate using Days,APTrn.DueDate

                      MOVE              $Entity,APTRN.Entity
                      MOVE              $Entity,APTRN.SubEntity
                      MOVE              "C",APTRN.ClosedFlag
                      MOVE              APTRN.TransDate,APTRN.EntryDate
                      MOVE              "0",APTRN.DiscPct
                      MOVE              "0",APTRN.NonDiscAmt
                      MOVE              "0",APTRN.HoldFlag
                      MOVE              "    ",APTRN.PO
                      MOVE              "    ",APTRN.Receipt
                      MOVE              "0",APTRN.Release
                      MOVE              APTRN.Vendor,APTRN.FromVendor
                      MOVE              "    ",APTRN.ReceiptDate
                      MOVE              "    ",APTRN.APAccount
                      MOVE              "0",APTRN.Form1099

                      GetNextSeq             APTRN

                      MOVE              Sequence.SeqNo,APTRN.SeqMajor
                      MOVE              Sequence.SeqNo,APTRN.Voucher
                      CALL              WrtAPTRN

                      MOVE              APTRN.Entity,APDetail.Entity
                      MOVE              APTRN.SubEntity,APDetail.SubEntity
                      MOVE              APTRN.Vendor,APDetail.Vendor
                      MOVE              "0",APDetail.TransCode
                      MOVE              APTRN.SeqMajor,APDetail.SeqMajor
                      ADD               "1",APDetail.SeqMinor
                      MOVE              APTRN.TransDate,APDetail.TransDate
                      MOVE              APTRN.EntryDate,APDetail.PostDate

                      UNPACK            APTRN.EntryDate,YYYY,MM,DD
                      MOVE              YYYY,APDetail.Year
                      MOVE              MM,APDetail.Month
                      MOVE              APTRN.Invoice,APDetail.ReferenceNo
                      MOVE              APPaid.Description,APDetail.Memo
                      MOVE              "    ",APDetail.APAccount
                      MOVE              APTRN.OrigAmt,APDetail.Amount
                      CALL              WriteVendorHistory
                      CALL              WrtAPDET
.
. AP Distribution Records
.
                    MOVE              APDetail.Entity,APDist.Entity
                    MOVE              APDetail.SubEntity,APDist.SubEntity
                    MOVE              APTRN.Vendor,APDist.Vendor
                    MOVE              "1",APDist.PostedToGL
                    MOVE              APDetail.TransDate,APDist.TransDate
                    MOVE              "3",APDist.TransCode
                    MOVE              APPaid.GLCode,APDist.GLCode
                    MOVE              APDetail.SeqMajor,APDist.SeqMajor
                    MOVE              APTRN.Voucher,APDist.Voucher
                    MOVE              APDetail.Year,APDist.Year
                    MOVE              APDetail.Month,APDist.Month
                    MOVE              APDetail.SeqMinor,APDist.SeqMinor
                    PACK              APDist.Description FROM "Invoice : ",APTRN.Invoice," for Vendor : ",APTRN.Vendor
                    MOVE              "0",APDist.CheckNo
                    MOVE              APDetail.Amount,APDist.DebitAmount
                    CALL              WrtAPDist
.
. Now let's write out the Check information
.
                    MOVE              APTRN.Entity,APDetail.Entity
                    MOVE              APTRN.SubEntity,APDetail.SubEntity
                    MOVE              APTRN.Vendor,APDetail.Vendor
                    MOVE              "7",APDetail.TransCode
                    MOVE              APTRN.SeqMajor,APDetail.SeqMajor
                    ADD               "1",APDetail.SeqMinor

                    UNPACK            APPaid.PaidDate into MM,DD,YY
                    IF                (YY < "50")
                      MOVE              "20",CC
                    ELSE
                      MOVE              "19",CC
                    ENDIF

                    PACKKEY           APDetail.TransDate,CC,YY,MM,DD
                    PACKKEY           APDetail.PostDate,CC,YY,MM,DD

                    REPLACE           " 0",APTRN.TransDate

                    UNPACK            APDetail.TransDate,YYYY,MM,DD
                    MOVE              YYYY,APDetail.Year
                    MOVE              MM,APDetail.Month
                    MOVE              APPaid.CheckNumber,APDetail.ReferenceNo
                    MOVE              APPaid.Description,APDetail.Memo
                    MOVE              "    ",APDetail.APAccount
                    CALL                WriteCheckDetails
                    CALL              WriteVendorHistory
.
.Write out APDetail
.
                    MULTIPLY          "-1",APDetail.Amount
                    MOVE              APTRN.OrigAmt,APDetail.Amount
                    CALL              WrtAPDET
.
                    REPEAT
                    keyin             *P1:24,"Finished",ANS
                    STOP
;=============================================================================
WriteCheckDetails
              MOVE              "1",BankREC.Code
              squeeze           APPaid.CheckNumber,APPaid.CheckNumber
              MOVE              APPaid.CheckNumber,Check.CheckNo

              PACKKEY           CheckKY FROM APTRN.Entity,BankREC.Code,Check.CheckNo
              CALL              RDCheck
              IF                (ReturnFL = 1)
                MOVE              APTRN.Entity,Check.Entity
                MOVE              APTRN.SubEntity,Check.SubEntity
                MOVE              APTRN.Vendor,Check.Vendor
                MOVE              BankREC.Code,Check.BankCode
                MOVE              APPaid.CheckNumber,Check.CheckNo
                MOVE              "A",Check.CheckFlag
                MOVE              "1",Check.Printed
                MOVE              APDetail.Year,Check.Year
                MOVE              APDetail.Month,Check.Month
                MOVE              APDetail.TransDate,Check.CheckDate
                MOVE              APPaid.DiscountAmt,Check.DiscAmt
                MOVE              APPaid.Amount,Check.GrossAmount
                CALC              Check.CheckAmount = Check.GrossAmount - Check.DiscAmt
                MOVE              "    ",Check.VoidedDate
                MOVE              Check.CheckDate,Check.TransDate

                GetNextSeq        Check
                MOVE              Sequence.SeqNo,Check.SeqMajor
                CALL                WrtCheck
              ELSE
                ADD               APPaid.DiscountAmt,Check.DiscAmt
                ADD               APPaid.Amount,Check.GrossAmount
                CALC              Check.CheckAmount = Check.CheckAmount + (APPaid.Amount - APPaid.DiscountAmt)
                CALL              UpdCheck
              ENDIF

              MOVE              Check.Entity,CheckDetail.Entity
              MOVE              Check.SubEntity,CheckDetail.SubEntity
              MOVE              Check.BankCode,CheckDetail.BankCode
              MOVE              Check.Vendor,CheckDetail.Vendor
              MOVE              Check.CheckNo,CheckDetail.CheckNo
              MOVE              Check.SeqMajor,CheckDetail.SeqMajor
              MOVE              APTRN.SeqMajor,CheckDetail.Voucher

              MOVE              APPaid.DiscountAmt,CheckDetail.DiscAmt
              MOVE              APPaid.Amount,CheckDetail.GrossAmount
              CALC              CheckDetail.NetAmount = CheckDetail.GrossAmount - CheckDetail.DiscAmt
              ADD               "1",CheckDetail.SeqMinor
              CALL              WrtCheckDetail
              RETURN
;=============================================================================
WriteVendorHistory
              UNPACK            APDetail.TransDate,CC,YY,MM,DD
              MOVE              MM,MMF
              RETURN            IF (MMF > 12 or MMF = 0)


              PACKKEY           VHSTKY FROM APDetail.Entity,APDetail.Vendor,CC,YY
              CALL              RDVHST                                                 //Read the Vendor History record
              IF                (ReturnFL = 1)                                         //Vendor History record not found, add it!!!
                CLEAR             VendorHistory
                MOVE              APDetail.Entity,VendorHistory.Entity
                MOVE              APDetail.Vendor,VendorHistory.Vendor
                PACKKEY           VendorHistory.Year FROM CC,YY

                IF                (APDetail.TransCode = 0)
                  ADD               "1",VendorHistory.PurchTotal(MMF)
                  ADD               "1",VendorHistory.PurchTotal(13)
                  MOVE              APDetail.Amount,VendorHistory.PurchAmt(MMF)
                  MOVE              APDetail.Amount,VendorHistory.PurchAmt(13)
                  MOVE              APTRN.Invoice,VendorHistory.LastInvoice
                  MOVE              APTRN.TransDate,VendorHistory.LastInvDate
                ELSE
                  ADD               "1",VendorHistory.PaidTotal(MMF)
                  ADD               "1",VendorHistory.PaidTotal(13)
                  MOVE              APDetail.Amount,VendorHistory.PaidAmt(MMF)
                  MOVE              APDetail.Amount,VendorHistory.PaidAmt(13)
                  MOVE              APDetail.TransDate,VendorHistory.LastPayDt
                  MOVE              APDetail.Amount,VendorHistory.LastPayAmt
                ENDIF

                CALL              WrtVHST
              ELSE
..HR 7/26/2005                ADD               APDetail.Amount,VendorHistory.PurchAmt(MMF)
..HR 7/26/2005                ADD               APDetail.Amount,VendorHistory.PurchAmt(13)
                MOVE              APTRN.Invoice,VendorHistory.LastInvoice
                MOVE              APDetail.TransDate,VendorHistory.LastInvDate
                IF                (APDetail.TransCode = 0)
                  ADD               "1",VendorHistory.PurchTotal(MMF)
                  ADD               "1",VendorHistory.PurchTotal(13)
                  ADD               APDetail.Amount,VendorHistory.PurchAmt(MMF)
                  ADD               APDetail.Amount,VendorHistory.PurchAmt(13)
                  MOVE              APTRN.Invoice,VendorHistory.LastInvoice
                  MOVE              APTRN.TransDate,VendorHistory.LastInvDate
                ELSE
                  ADD               "1",VendorHistory.PaidTotal(MMF)
                  ADD               "1",VendorHistory.PaidTotal(13)
                  ADD               APDetail.Amount,VendorHistory.PaidAmt(MMF)
                  ADD               APDetail.Amount,VendorHistory.PaidAmt(13)
                  MOVE              APDetail.TransDate,VendorHistory.LastPayDt
                  MOVE              APDetail.Amount,VendorHistory.LastPayAmt
                ENDIF
                CALL              UpdVHST
              ENDIF
              RETURN



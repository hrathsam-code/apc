;=============================================================================;
;       created by:  chiron software & services, inc.                         ;
;                    4 norfolk lane                                           ;
;                    bethpage, ny  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  program:    addARTran.inc                                                  ;
;                                                                             ;
;   author:    Harry Rathsam                                                  ;
;                                                                             ;
;     date:    08/29/2018 at 10:03am                                          ;
;                                                                             ;
;  purpose:    Routine to add Invoice transaction to A/R module               ;
;                                                                             ;
; revision:    ver     date     init       details                            ;
;                                                                             ;
;              1.0   08/29/2018   hor     initial version                     ;
;                                                                             ;
;                                                                             ;
;=============================================================================;

;==========================================================================================================
CreateInvoice
                    clear              ARTrn
                    move               "I",ARTrn.InvCredit
                    call               AddARTran
                    return
;==========================================================================================================
CreateCreditMemo
                    clear              ARTrn
                    move               "C",ARTrn.InvCredit
                    call               AddARTran
                    return
;==========================================================================================================
CreateDebitMemo
                    clear              ARTrn
                    move               "D",ARTrn.InvCredit
                    call               AddARTran
                    return
;==========================================================================================================
AddARTran
                    move               Invoices.Entity,ARTrn.Entity
                    move               Invoices.BillCust,ARTrn.CustomerID
                    squeeze            Invoices.Reference,ARTrn.Reference                   //HR 2019.7.10 Changed from "Move"
                    move               Invoices.CustomerPO,ARTrn.CustomerPO
                    move               Invoices.TransDate,ARTrn.TransDate
                    move               Invoices.BillDate,ARTrn.BillDate
                    clock              TimeStamp,ARTrn.EntryDate
                    move               Invoices.InvoiceAmt,ARTrn.OrigAmt
                    move               Invoices.InvoiceAmt,ARTrn.Balance
                    if                 (ARTrn.Balance != 0)
                      move               "O",ARTrn.ClosedFlag
                    else
                      move               "C",ARTrn.ClosedFlag
                    endif
                    move               Invoices.OrderNumber,ARTrn.OrderNumber
                    move               Invoices.SalesAmt,ARTrn.SalesAmt
                    move               Default.ARAcct,ARTrn.ARAccount
                    clear              ARTrn.AgainstInv
                    clear              ARTrn.NonDiscAmt
                    move               Invoices.TaxableAmt,ARTrn.TaxAmount

                    GetNextSeq         ARTRN
                    move               Sequence.SeqNo,ARTrn.SeqMajor

                    clear              ARTrn.DiscDate
;
; Calculate the Due Date
;
..HR 2019.7.12                    move               Cust.TermCode,ARTRMKY
                    debug
                    move               Invoices.TermCode,ARTRMKY
                    call               RDARTRM
                    if                 (ReturnFl = 1)
                      MOVE              "30",AgingDays
                      MOVE              "15",DiscountDays
                      MOVE              "2",DiscountPercent

.                      transaction        rollback
.                      beep
.                      alert              stop,"Default AR Term Code does not exist",result,"ERROR: INVALID DEFAULT TERM CODE"
.                      return
                    else                                      //We got a winner!!!!
                      move               ARTrm.DiscDays,DiscountDays
                      move               ARTrm.NetDays,AgingDays
                      move               ARTrm.DiscPerc,DiscountPercent
                    endif

                    call               ConvDateToDays using ARTrn.EntryDate,TodayDays
                    add                AgingDays,TodayDays
                    call               ConvDaysToDate using TodayDays,ARTrn.DueDate
;
; Calculate the Discount Amount
;
                    call               ConvDateToDays using ARTrn.EntryDate,TodayDays
                    add                DiscountDays,TodayDays
                    call               ConvDaysToDate using TodayDays,ARTrn.DiscDate
;
; That's why...It seems that there's transactions out there without an Invoice Amount
;

             SWITCH            ARTrn.InvCredit

             CASE              "C"
               MULTIPLY          "-1",ARTrn.OrigAmt
               MULTIPLY          "-1",ARTrn.Balance
             CASE              "I"
               MOVE              DiscountPercent,ARTrn.DiscPct
               CALC              ARTrn.DiscAmt = ARTrn.OrigAmt * (DiscountPercent / 100)
             CASE              "D"
               MOVE              DiscountPercent,ARTrn.DiscPct
               CALC              ARTrn.DiscAmt = ARTrn.OrigAmt * (DiscountPercent / 100)
             ENDSWITCH
.
. Modified to properly update the Sales amounts
.
.             %IF                  EntryProgramType = 1                 //Credit Memo Entry      //HR 1/3/2006
.               CALC              ARTrn.SalesAmt = ARTrn.OrigAmt + FreightTemp
.             %ELSEIF              EntryProgramType = 2                 //Debit Memo Entry
.               CALC              ARTrn.SalesAmt = ARTrn.OrigAmt - FreightTemp
.             %ELSEIF              EntryProgramType = 0                 //Invoice Entry
.               CALC              ARTrn.SalesAmt = ARTrn.OrigAmt - FreightTemp
.             %ENDIF

.             FILEPI            3;ARSEQFL
.             READ              ARSEQFL,ZEROSEQ;SEQMAJOR
.             ADD               "1",SeqMajor
.             WRITE             ARSEQFL,ZEROSEQ;SEQMAJOR
                    call               WrtARTrn


                    return

.=============================================================================
ViewHistoryByOptions
                    return
.=============================================================================
UpdateCustomerBalance
                    packkey           CustDKY FROM ARTrn.Entity,ARTrn.CustomerID
                    call              RDCustD
                    if                (Returnfl = 1)       //None exists, create one!!
                      move              ARTrn.Entity,CustD.Entity
                      move              ARTrn.CustomerID,CustD.CustomerID
                      move              "  ",CustD.LastPayDt
                      move              "0",CustD.LastPayAmt
                      move              "   ",CustD.LastCheck

                      move              ARTrn.OrigAmt,CustD.Balance
                      move              ARTrn.TransDate,CustD.LastInvoiceDt
                      move              ARTrn.Reference,CustD.LastInvoice
                      move              ARTrn.OrigAmt,CustD.LastInvoiceAmt
                      call              WRTCustD
                    else
                      add               ARTrn.OrigAmt,CustD.Balance
                      if                (ARTrn.TransDate >= CustD.LastInvoiceDt)
                        move              ARTrn.TransDate,CustD.LastInvoiceDt
                        move              ARTrn.OrigAmt,CustD.LastInvoiceAmt
                        move              ARTrn.Reference,CustD.LastInvoice
                      endif
                      call              UPDCustD
                    endif
                    return



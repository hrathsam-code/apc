;=============================================================================;
;       created by:  chiron software & services, inc.                         ;
;                    4 norfolk lane                                           ;
;                    bethpage, ny  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  program:    deleteinvoices                                                 ;
;                                                                             ;
;   author:    harry rathsam                                                  ;
;                                                                             ;
;     date:    08/15/2019 at 3:16pm                                           ;
;                                                                             ;
;  purpose:                                                                   ;
;                                                                             ;
; revision:    ver     date     init       details                            ;
;                                                                             ;
;              1.0   08/15/2019   hor     initial version                     ;
;                                                                             ;
;                                                                             ;
;=============================================================================;

                    include            NCommon.txt
                    include            WorkVar.inc
                    include            Cust.FD
                    include            Parts.FD
                    include            OrderDetails.fd

                    include            Invoices.fd
                    include            InvDetails.fd
                    include            ARTRN.fd
                    include            ARDet.FD

DeleteInv           plform             OrderEntry4.plf
                    formload           DeleteInv


                    call               OpenInvoices
                    call               OpenInvDetails
                    call               OpenARTRN
                    call               OpenARDet
                    setfocus           EDeleteInvoice

                    loop
                      waitevent
                    repeat

;==========================================================================================================
DeleteInvoice
;
; Delete the Invoice here
;
InvoiceToDelete     dim                9
InvoiceFoundFlag    form               1

                    debug
                    getprop            EDeleteInvoice,text=InvoiceToDelete
                    squeeze            InvoiceToDelete,InvoiceToDelete
                    move               InvoiceToDelete,Invoices.Reference
                    pack               AlertString from "Are you sure you wish to delete Invoice : ",InvoiceToDelete," ?"
                    alert              plain,AlertString,result,"OK TO DELETE?"
                    return             if (result != 1)

                    transaction        start,InvoicesFLST,InvDetailsFLST,ARTrnFLST,ARDetFLST

                    if                 (Invoices.Reference > 35000)
                      PACKKEY           InvoicesKY FROM $Entity,Invoices.Reference
                      CALL              RDInvoices
                      IF                (ReturnFL = 1)
                         transaction       rollback
                        ALERT             stop,"Invoice Number is missing...Please report error ",result,"ERROR!"
                        return
                      ENDIF

                      move               Invoices.BillCust,Cust.CustomerID
                    endif
;
; Find the AR Transaction Files first
;
                    clear              InvoiceFoundFlag
                    squeeze            Invoices.Reference,ARTRN.Reference
                    packkey            ARTRNKY2 from $Entity,"99999999"               //Cust.CustomerID,ARTRN.Reference
                    call               RDARTrn2

                    loop
                      call               KPARTrn2
                    until              (ReturnFl = 1 )
                      squeeze            ARTRN.Reference,ARTRN.Reference
                      continue           if (ARTRN.Reference != InvoiceToDelete)         //Did we find the invoice yet???
                      set                InvoiceFoundFlag
                      break
                    repeat
                    if                (InvoiceFoundFlag = 0)
                      transaction       rollback
                      ALERT             stop,"Unable to find the AR Transaction...Please report error ",result,"ERROR: NONEXISTENT AR TRAN"
                      setfocus           EDeleteInvoice
                      return
                    endif
;
; Let's make sure there's no AR Detail transactions
;
                      PACKKEY           ARDETKY,$Entity,ARTrn.SeqMajor,"   "
                      SETLPTR             ARDETky
                      CALL              RDARDET
                      CALL              KSARDET
                      if                 (RETURNFL = 0 and ARTrn.SeqMajor = ARDet.SeqMajor)
                        transaction       rollback
                        ALERT             stop,"AR Details exist, unable to delete this Invoice.",result,"ERROR: UNABLE TO DELETE"
                        return
                      ENDIF
;
; Delete the Invoice Details first
;
                    if                 (Invoices.Reference > 35000)
                      PACKKEY           InvDetailsKY3 FROM Invoices.Entity,Invoices.SeqMajor
                      CALL              RDInvDetails3
                      LOOP
                        CALL              KSInvDetails3
                      UNTIL             (Invoices.SeqMajor != InvDetails.SeqMajor or ReturnFL = 1)
                        call               DelInvDetails
                      repeat
;
; Delete the Invoice Header now
;
                      call               DelInvoices
                    endif
;
; Now finish it off by deleting the A/R Trans record
;
                    call               DelARTRN
                    transaction        commit
                    beep
                    alert              note,"Invoice has been deleted",result,"TRANSACTION DELETED"
                    setprop            EDeleteInvoice,text=""
                    setfocus           EDeleteInvoice
                    return
;==========================================================================================================
OnClickCancelDelete
                    set                CancelFlag
                    DESTROY         WMAIN      . Get rid of the Bank Window
                    winshow
                    CHAIN             FROMPGM

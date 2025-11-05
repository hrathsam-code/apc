;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    4 NORFOLK LANE                                           ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    PRTINVRP.PLS                                                   ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    10/18/2005 AT 10:06PM                                          ;
;                                                                             ;
;  PURPOSE:    Program to print out report totals by Invoice/Date             ;
;                                                                             ;
; REVISION:    VER     DATE     INIT       DETAILS                            ;
;                                                                             ;
;              1.0   10/18/2005   HOR     INITIAL VERSION                     ;
;              1.1   03/21                                                    ;
;                                                                             ;
;=============================================================================;

                    INCLUDE           NCOMMON.TXT
                    INCLUDE           WORKVAR.INC
.
FromDate            DIM               8
ToDate              DIM               8
PrtDate             DIM               8
TransType           DIM               10
Totals              FORM              10.2
PrintFromDate       dim                10
PrintToDate         dim                10
              GOTO              #s

              INCLUDE           Sequence.FD
              INCLUDE           CUST.FD
              INCLUDE           PrintRtn.inc
#s
.
Main          PLFORM            PrtInvRp.PLF

              INCLUDE           Cntry.FD
              INCLUDE           Invoices.FD

              CALL              OpenCntry

              CALL              OpenInvoices
              CALL              OpenCust

              INCLUDE           Temporary.INC

              FORMLOAD          Main
              CLOCK                TimeStamp,TODAY8
              setprop           DTFromDate,text=Today8
              setprop           DTToDate,text=Today8


              LOOP
                WAITEVENT
              REPEAT
              STOP
;=============================================================================
StartPrint
              MOVE              "Invoice Totals Detail Report",ReportTitle

              CALL              PrintPreviewInit

              getprop           DTFromDate,text=FromDate
              getprop           DTToDate,text=ToDate
              unpack                   FromDate into yyyy,mm,dd
              packkey                  PrintFromDate from mm,"-",dd,"-",yyyy

              unpack                   ToDate into yyyy,mm,dd
              packkey                  PrintToDate from mm,"-",dd,"-",yyyy

              CALL              PrintHeader
              PACKKEY           InvoicesKY2 FROM $Entity,FromDate,"             "
              CALL              RDInvoices2
              LOOP
                CALL              KSInvoices2
              UNTIL             (ReturnFl = 1 or Invoices.TransDate > ToDate)
              CALL              PrintDetail
              REPEAT
.
              ADD               DoubleLine,PrintLineCnt

              PRTPAGE           P;*BoldOn:
                                *alignment=*left:
                                *P=100:PrintLineCnt,"Grand Totals : ":
                                *alignment=*decimal:
                                *p=680:PrintLineCnt,Totals:
                                *alignment=*left:
                                *BoldOff

              CALL              PrintClose
              chain             FromPGM
              STOP
;=============================================================================
PrintDetail
              UNPACK            Invoices.TransDate into CC,YY,MM,DD
              PACK              PrtDate FROM MM,"-",DD,"-",YY
              MOVE              Invoices.BillCust,CustKY
              CALL              RDCust
              IF                (ReturnFl = 1)
                ALERT             stop,"Customer Number does not exist",result,"Invalid Customer Number"
                RETURN
              ENDIF

              IF                (Invoices.InvCredit = "I")
                MOVE              "Inv",TransType
              ELSE
                IF                (Invoices.InvCredit = "D")
                  MOVE              "Debit",TransType
                ELSE
                  MOVE              "Credit",TransType
                  MULTIPLY          "-1",Invoices.InvoiceAmt
                ENDIF
              ENDIF

              add                Invoices.InvoiceAmt,Totals

              EndOfPage

              PrtPage           P;*alignment=*left:
                                *font=SubLineFont:
                                *p=020:PrintLineCnt,Invoices.Reference:
                                *p=100:PrintLineCnt,Transtype:
                                *p=150:PrintLineCnt,PrtDate:
                                *p=230:PrintLineCnt,Invoices.BillCust:
                                *p=270:PrintLineCnt,Cust.Name:
                                *alignment=*decimal:
                                *p=680:PrintLineCnt,Invoices.InvoiceAmt:
                                *alignment=*left
              ADD               SubSingleLine,PrintLineCnt
              RETURN
;=============================================================================
PrintCustomHeader
              PRTPAGE           P;*alignment=*left:
                                *font=SubLineFont:
                                *boldon:
                                *p=270:PrintLineCnt,"Date Range : ",PrintFromDate:
                                "  through  ",PrintToDate:
                                *boldoff:
                                *p=028:(PrintLineCnt+SingleLine),"Invoice":
                                *P=096:(PrintLineCnt+SingleLine),"Type":
                                *p=148:(PrintLineCnt+SingleLine),"Inv. Date":
                                *p=240:(PrintLineCnt+SingleLine),"Customer":
                                *p=650:(PrintLineCnt+SingleLine),"Amount"
              ADD               (SingleLine * 2),PrintLineCnt
              RETURN

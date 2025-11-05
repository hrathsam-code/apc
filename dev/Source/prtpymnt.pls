;=============================================================================;
;       created by:  chiron software & services, inc.                         ;
;                    4 norfolk lane                                           ;
;                    bethpage, ny  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    PRTPYMNT.PLS                                                   ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     date:    09/13/2018 at 4:21pm                                           ;
;                                                                             ;
;  purpose:                                                                   ;
;                                                                             ;
; REVISION:    VER     DATE     INIT       DETAILS                            ;
;                                                                             ;
;              1.0   01/14/2005   HOR     INITIAL VERSION                     ;
;                                                                             ;
; Prints out the Payments that have been received in a specific               ;
; time frame.  The report looks at the AR Details first and then              ;
; goes through to the AR Open Items records for any detailed information      ;
; such as Invoice Number, Invoice Date, etc                                   ;
;                                                                             ;
;  HR 06/24/2003  Modified to reverse the Write Off amounts due to the fact   ;
; that they're already negative within the system.                            ;
;                                                                             ;
; HR Added LockBox Totals information and proper Header information to        ;
; report                                                                      ;
;                                                                             ;
; HR 8/8/2003                                                                 ;
; Modified to use the "Net" Amount Vs. the Gross Amount  DUH!!! What was      ;
; I thinking???                                                               ;
;                                                                             ;
; HR 10/21/2003                                                               ;
; Modified to fix bug within program where the LockBoxID Length Pointer was   ;
; not reset.  It then didn't produce any information                          ;
;                                                                             ;
; HR 11/19/2003                                                               ;
; Added "Non A/R" description to Non A/R report                               ;
;                                                                             ;
; HR 01/15/2005                                                               ;
; Modified to properly print out Payment Transaction Type                     ;
; Program WAS only showing CHECK as valid Payment Type                        ;
.=============================================================================
           INCLUDE           WORKVAR.INC

ItemCount  FORM              6
TransDate  DIM               8
DueDate    DIM               8
..today      DIM                8
ToDate     DIM               8
FromDate   DIM               8
DiscDate   DIM               8
HoldFlag   DIM               1
EntryDate  DIM               8
AgingDays  FORM              3
CityState  DIM               42
VDiscTotal Form              10.2
GTDiscTotal Form             10.2
PaymentType   DIM               8
GrossAmt      FORM              10.2
NetAmt        FORM              10.2
PrintDetails  FORM              1           //HR 8/28/2003

LockBoxID     DIM               14          //HR 7/22/2003
LockBoxSelected DIM             1           //HR 7/22/2003

CustomerGross FORM              10.2
CustomerNet   FORM              10.2
CustomerDisc  FORM              10.2

OrigAmtEdt          dim                13
AmountEdt           dim                13
DiscAmtEdt          dim                13
NetAmtEdt           dim                13

CustomerGrossEdt    dim                13
CustomerNetEdt      dim                13
CustomerDiscEdt     dim                13

ReferencGross       FORM              10.2
ReferencNet         FORM              10.2
ReferencDisc        FORM              10.2

ReferencGrossEdt    dim                13
ReferencNetEdt      dim                13
ReferencDiscEdt     dim                13

PaymentDesc   DIM               10
.
DiscountTotal FORM              10.2
GrossTotal    form             10.2
NetTotal      FORM              10.2

DiscountTotalEdt    dim                13
GrossTotalEdt       dim                13
NetTotalEdt         dim                13


AllCustFlag   FORM              1
FromCustomer  DIM               6
ToCustomer    DIM               6
SelectedType  FORM              2
SavedCustomer DIM               6
SavedReference DIM              10
SavedLockBoxID DIM              14
..HR 1/15/2005   MMF           FORM              2
..HR 1/15/2005   DDF           FORM              2
LockBoxTotals FORM              10.2(250)
LockBoxIDTot  DIM               14(250)
.
WriteOffTotal FORM              10.2
NonARTotal    FORM              10.2
X             FORM              3

..           MOVE                 "ARMENU1",fROMpgm
                    GOTO               #S
                    include            Sequence.FD
                    INCLUDE            ARTRN.FD
                    INCLUDE            ARDET.FD
                    INCLUDE            CMPNY.FD
                    INCLUDE            CUST.FD
                    INCLUDE            CHST.FD
                    INCLUDE            PrintRtn.INC
PRTPYMNT            PLFORM             PRTPYMNT.PLF
#S
STARTPGM            routine
                    WINHIDE
                    OPEN               CustFLST,READ
                    OPEN               ARTRNFLST,READ
                    OPEN               ARDETFLST,READ
.fuckup                    CALL               OPENCMPNY

                    FORMLOAD           PRTPYMNT
                    CLOCK              TimeStamp,Date10
..HR 2017.10.4           SETPROP              DTFromDate,*Value=TODAY8
..HR 2017.10.4           SETPROP              DTToDate,*Value=TODAY8
           SETPROP              DTFromDate,text=Date10
           SETPROP              DTToDate,text=Date10

.           DTFromDate.CurrentDate

.           DTToDate.CurrentDate
           LOOP
             WAITEVENT
           REPEAT

           GOTO                 ExitProgram
.
. We'll never get to this spot!!
.....................................................
StartPrint
           SETMODE              *MCURSOR=*Wait
           MOVE              "Accounts Receivable Payment Entry Report",ReportTitle

              CALL              PrintPreviewInit
              return               if (printInitFailed = "N")

              MOVE              " ",ARDETKY5
              GETITEM           RAllCustomers,0,AllCustFlag
              IF                (AllCustFlag = 0)
                GETITEM           EFromCustomer,0,FromCustomer
                GETITEM           EToCustomer,0,ToCustomer
                JustifyCust       FromCustomer
                JustifyCust       ToCustomer
              ENDIF

              GETITEM           CBPrintOptions,0,PrintDetails

              GETITEM           ELockBoxID,0,LockBoxID
              COUNT             CharCount,LockBoxID

              IF                (CharCount != 0)
                MOVE              "Y",LockBoxSelected
                SETLPTR           LockBoxID
              ELSE
                MOVE              "N",LockBoxSelected
              ENDIF

              debug
              GETITEM           CBPaymentType,0,SelectedType

              gETPROP              DTFromDate,text=FromDate
              REPLACE           " 0",FromDate

              GETPROP           DTToDate,text=ToDate
              REPLACE           " 0",ToDate

              MOVE              "Y",FirstFlag

...           PACKKEY           ARDETKY4,$Entity,"5",FromDate                 //Payment Code Type
...           PACKKEY           ARDETKY5,$Entity,EntryDate"5",FromDate                 //Payment Code Type
           PACKKEY           ARDETKY5,$Entity,FromDate                  //Payment Code Type

           CALL              RDARDET5

           CALL              PrintHeader
           LOOP
             CALL               KSARDET5
           UNTIL             (Returnfl = 1 or ARDet.EntryDate > ToDate)
             CONTINUE          IF (ARDet.Amount = 0)
.
. HR 7/22/2003 Added to provide for a specific LockBox ID
.
             CONTINUE          IF (ARDet.LockBoxID != LockBoxID and LockBoxSelected = "Y")
.
. Ignore specific customers if a range of customers have been selected
.
             CONTINUE          IF (AllCustFlag = 0 and (ARDet.CustomerID < FromCustomer or:
                                                       ARDet.CustomerID > ToCustomer))
.
. Ignore specific Payment Types
.
..HR 7/8/2005             CONTINUE          IF (SelectedType != 1)   //1 = ALL Types

              CONTINUE          IF (SelectedType = 6 and ARDet.TransCode != 8)

              CONTINUE          IF (SelectedType = 3 and ARDet.TransSubCode != 3)   //Credit Card Payments
              CONTINUE          IF (SelectedType = 4 and ARDet.TransSubCode != 5)   //Letter of Credit
              CONTINUE          IF (SelectedType = 5 and ARDet.TransSubCode != 4)   //Wire Transfers
.
. This option is for all Negative Amounts.  This is the modification for Allan based
. upon incidents in A/R
.
              CONTINUE          IF ((SelectedType = 7) and :
                                    ((ARDet.Amount < 0 and ARDet.TransCode != 8)))   //or :
.                                     ARDet.TransCode != 8))

              MOVE              ARDet.CustomerID,CustKY
              PACK              DataLine FROM ARDet.EntryDate,ARDet.TransCode

              IF              (FirstFlag != "Y" and ARDet.Reference != SavedReference)
                CALL              PrintCheckTotals
                MOVE              "0",ReferencGross
                MOVE              "0",ReferencNet
                MOVE              "0",ReferencDisc
                MOVE              ARDet.Reference,SavedReference
                MOVE              ARDet.LockBoxID,SavedLockBoxID
              ENDIF

              IF                (ARDet.CustomerID != SavedCustomer or FirstFlag = "Y")
                CALL              RDCust
                MOVE              "N",FirstFlag
                MOVE              "0",CustomerGross
                MOVE              "0",CustomerNet
                MOVE              "0",CustomerDisc
                MOVE              ARDet.Reference,SavedReference
                MOVE              ARDet.LockBoxID,SavedLockBoxID
                MOVE              ARDet.CustomerID,SavedCustomer
               CALL              PrintLine
              ENDIF

              PACKKEY           ARTRNKY2,$Entity,ARDet.SeqMajor
              CALL              RDARTRN2
              CALL              PrintDetails
.
. 7/31/2003
. Calculate the Total LockBox information for later on down on the report
.
              FOR               X FROM "1" TO "250" USING "1"
                IF                (ARDet.LockBoxID = LockBoxIDTot(X))    //HR 8/8/2003
                  ADD               NetAmt,LockBoxTotals(X)
                  BREAK
                ENDIF

                IF                (LockBoxIDTot(X) = "")
                  MOVE              ARDet.LockBoxID,LockBoxIDTot(X)
                  MOVE              NetAmt,LockBoxTotals(X)                 //HR 8/8/2003
                  BREAK
                ENDIF
              REPEAT

             ADD               "1",ItemCount
           REPEAT

           CALL              PrintCheckTotals
           CALL              PrintTotals
           CALL              PrintClose
           SETMODE              *MCURSOR=*Arrow

              GOTO              ExitProgram

PrintLine
           CHOP              Cust.City,Cust.City
           PACK              CityState,Cust.City,", ",Cust.St,"  ",Cust.Zip

           IF                   (PrintDetails = 1)   //Report Details!!!
             EndOfPage
             PrtPage           P;*font=DetailFont:
                               *alignment=*left:
                               *boldon:
                               *p=020:PrintLineCnt,Cust.CustomerID:
                               *p=125:PrintLineCnt,Cust.Name:
                               *alignment=*decimal:
                               *font=SubLineFont:
                               *boldoff

             ADD               SingleLine,PrintLineCnt
           ENDIF
           RETURN

PrintDetails
.
. Read through all of the Transactions looking for 'Open' transactions
. only.  'Open' transactions are records that don't have a Zero balance.
.
           unpack            ARDet.EntryDate,CC,YY,MM,DD
           PACK              EntryDate FROM MM,"/",DD,"/",YY

           unpack            ARTRN.TransDate,CC,YY,MM,DD
           PACK              TransDate FROM MM,"/",DD,"/",YY


.
. This is only for Write Off Amounts only.  For Write offs, the amount is already negative
.
              IF                (ARDet.TransCode != 8)                //HR 6/24/2003
..HR 2018.10.3                MULTIPLY          "-1",ARDet.Amount
..HR 2018.10.3                MULTIPLY          "-1",ARDet.DiscAmt
                MOVE              "  ",PaymentDesc
              ELSE
                MOVE              "Write-Off",PaymentDesc
                CALC              WriteOffTotal = WriteOffTotal - (ARDet.Amount)   //HR 1/6/2004..What was it?
              ENDIF
.
           Add                ARDet.Amount,GrossTotal

           Add                ARDet.DiscAmt,DiscountTotal
           calc               NetTotal = NetTotal + (ARDet.Amount - ARDet.DiscAmt)
           SUBTRACT           ARDet.DiscAmt,ARDet.Amount,NetAmt

              IF                (ARDet.NonARFlag = "Y")
                MOVE              "Non A/R",PaymentDesc
                Add                ARDet.Amount,NonARTotal
              ENDIF

           EndOfPage
.
. HR 1/15/2005
.
              SWITCH            ARDet.TransSubCode
              CASE              1
                MOVE              "Check:",PaymentType
              CASE              2
                MOVE              "Cash:",PaymentType
              CASE              3
                MOVE              "Credit Card:",PaymentType
              CASE              4
                MOVE              "Wire Transferk:",PaymentType
              CASE              5
                MOVE              "Letter of Credit:",PaymentType
              CASE              6
                MOVE              "Toucher Details:",PaymentType
              CASE              7
                MOVE              "Money Order:",PaymentType
              CASE              8
                MOVE              "Electronic Wire:",PaymentType
              DEFAULT
                MOVE              "Check:",PaymentType
              ENDSWITCH

.             IF                (ARDet.TransSubCode = 1)        //Payment = Check
.               MOVE              "Check:",PaymentType
.             ENDIF

           IF                   (PrintDetails = 1)   //Report Details!!!
             edit               ARTrn.OrigAmt,OrigAmtEdt,Mask="$Z,ZZZ,ZZ9.99",Align=1
             edit               ARDet.Amount,AmountEdt,Mask="$Z,ZZZ,ZZ9.99",Align=1
             edit               ARDet.DiscAmt,DiscAmtEdt,Mask="$Z,ZZZ,ZZ9.99",Align=1
             edit               NetAmt,NetAmtEdt,Mask="$Z,ZZZ,ZZ9.99",Align=1

             PrtPage           P;*alignment=*left:
                               *font=SubLineFont:
                               *p=40:PrintLineCnt,ARTrn.Reference:           //12
                               *p=140:PrintLineCnt,ARTrn.CustomerPO:          //12
...                             *p=330:PrintLineCnt,ARTrn.Reference:
                               *alignment=*left:
                               *p=260:PrintLineCnt,TransDate:
                               *alignment=*left:
                               *boldon:
                               *p=320:PrintLineCnt,PaymentDesc:
                               *boldoff:
                               *alignment=*decimal:
                               *p=500:PrintLineCnt,OrigAmtEdt:
                               *p=580:PrintLineCnt,AmountEdt:
                               *p=660:PrintLineCnt,DiscAmtEdt:
                               *p=740:PrintLineCnt,NetAmtEdt
             ADD               SingleLine,PrintLineCnt
           ENDIF

           ADD               ARDet.DiscAmt,ReferencDisc

           if                (ARDet.TransCode = 8)                //HR 6/24/2003
             sub               ARDet.Amount,ReferencGross
             sub               NetAmt,ReferencNet
           else
             ADD               ARDet.Amount,ReferencGross
             ADD               NetAmt,ReferencNet
           endif

           RETURN

.=============================================================================
. Print the Reference/Check Totals for this Customer
.=============================================================================
PrintCheckTotals
                    edit               ReferencNet,ReferencGrossEdt,Mask="$Z,ZZZ,ZZ9.99",Align=1
                    edit               ReferencDisc,ReferencDiscEdt,Mask="$Z,ZZZ,ZZ9.99",Align=1
                    edit               ReferencNet,ReferencNetEdt,Mask="$Z,ZZZ,ZZ9.99",Align=1


              IF                   (PrintDetails = 1)   //Report Details!!!
                PRTPAGE           P;*font=SubLineFont:
                                  *alignment=*left:
                                  *Pensize=1:
                                  *p=300:(PrintLineCnt - 2):
                                  *Line=760:(PrintLineCnt - 2):
                                  *alignment=*left:
                                  *font=SubLineFont:
                                  *p=090:PrintLineCnt:
                                  "LockBox ID: ":
                                  SavedLockBoxID:
                                  *P=300:PrintLineCnt:
..HR 2019.7.28                                  PaymentType,"  ":
..HR 2019.7.28                                  SavedReference:           //12
                                  *alignment=*left:
                                  *p=460:PrintLineCnt,EntryDate:
                                  *alignment=*decimal:
                                  *p=580:PrintLineCnt,ReferencGrossEdt:
                                  *p=660:PrintLineCnt,ReferencDiscEdt:
                                  *p=740:PrintLineCnt,ReferencNetEdt

                ADD               DoubleLine,PrintLineCnt
              ENDIF
              RETURN

.=============================================================================
. Print the Totals for each Customer
.=============================================================================
PrintCustomerTotals
              IF                   (PrintDetails = 1)   //Report Details!!!
                PRTPAGE           P;*font=SubLineFont:
                                  *alignment=*left:
                                  *Pensize=1:
                                  *p=30:(PrintLineCnt - 2):
                                  *Line=760:(PrintLineCnt - 2)

                CHOP              Cust.CustomerID,Cust.CustomerID
                PrtPage           P;*font=SubLineFont:
                                  *alignment=*left:
                                  *p=155:PrintLineCnt,"Totals for ":
                                  *ha=10:
                                  *boldon:
                                  *LL:
                                  Cust.CustomerID:
                                  ":":
                                  *alignment=*decimal:
                                  *p=581:PrintLineCnt,VDiscTotal:
                                  *boldon:
.                                  *p=701:PrintLineCnt,VStatRec.Balance:
                                  *boldoff
.
                ADD               DoubleLine,PrintLineCnt
              ENDIF
              RETURN
.=============================================================================
PrintTotals
                CALL              PrintHeader
                    edit               GrossTotal,GrossTotalEdt,Mask="$Z,ZZZ,ZZ9.99",Align=1
                    edit               DiscountTotal,DiscountTotalEdt,Mask="$Z,ZZZ,ZZ9.99",Align=1
                    edit               NetTotal,NetTotalEdt,Mask="$Z,ZZZ,ZZ9.99",Align=1

                PRTPAGE           P;*font=SubLineFont:
                                 *alignment=*left:
                                 *Pensize=1:
                                 *p=30:(PrintLineCnt - 2):
                                 *Line=760:(PrintLineCnt - 2):
                                 *p=30:(PrintLineCnt - 4):
                                 *Line=760:(PrintLineCnt - 4):
                                 *font=SubLineFont:
                                 *alignment=*left:
                                 *boldon:
                                 *p=155:PrintLineCnt,"A/R Payment Totals :":
                                 *alignment=*decimal:
                                 *boldon:
                                 *p=559:PrintLineCnt,GrossTotalEdt:
                                 *p=649:PrintLineCnt,DiscountTotalEdt:
                                 *p=739:PrintLineCnt,NetTotalEdt:
                                 *boldoff

              ADD               (SingleLine),PrintLineCnt

              ADD               (DoubleLine * 2),PrintLineCnt
              PRTPAGE           P;*font=DetailFont,*boldon:
                                "Total Invoices Processed :":                        //HR 6/5/2003
                                *alignment=*left:
                                ItemCount:
                                *boldoff

              ADD               DoubleLine,PrintLineCnt

                    edit               GrossTotal,GrossTotalEdt,Mask="$Z,ZZZ,ZZ9.99",Align=1
                    edit               DiscountTotal,DiscountTotalEdt,Mask="$Z,ZZZ,ZZ9.99",Align=1
                    edit               NetTotal,NetTotalEdt,Mask="$Z,ZZZ,ZZ9.99",Align=1

              PRTPAGE           P;*font=DetailFont:
                                *boldon:
                                *p=10:PrintLineCnt:
                                "Total Gross Amount Recorded = ",GrossTotalEdt:
                                *p=10:(PrintLineCnt + SingleLine):
                                "Total Discounts Recorded = ",DiscountTotalEdt:
                                *p=10:(PrintLineCnt + (2 * SingleLine)):
                                "Write-Off Amounts Recorded = ",WriteOffTotal:
                                *p=10:(PrintLineCnt + (3 * SingleLine)):
                                "Non A/R Amounts Recorded = ",NonARTotal:
                                *p=10:(PrintLineCnt + (4 * SingleLine)):
                                "Net Total Amounts Recorded = ",NetTotal

              ADD               DoubleLine,PrintLineCnt
              ADD               DoubleLine,PrintLineCnt
              ADD               DoubleLine,PrintLineCnt
              ADD               DoubleLine,PrintLineCnt

.
. HR 8/2/2003
. Print LockBox Information Totals on a new Page
.
..HR 1/8/2004 Moved to Totals area              CALL              PrintHeader

              FOR               X FROM "1" TO "250" USING "1"
                BREAK IF      (LockBoxIDTot(X) = "")

                EndOfPage
                PRTPAGE           P;*font=DetailFont:
                                  *alignment=*left:
                                  *boldon:
                                  *p=40:PrintLineCnt:
                                  "LockBox ID :":
                                  *alignment=*decimal:
                                  LockBoxIDTot(X):
                                  *p=240:PrintLineCnt:
                                  LockBoxTotals(X):
                                  *alignment=*left

                ADD             SingleLine,PrintLineCnt

              REPEAT
            RETURN
.
ExitProgram
..FUCKUP              NORETURN
..FUCKUP              NORETURN
              winshow
              return

...              CHAIN             FROMPGM
              STOP
.=============================================================================
PrintCustomHeader
              PRTPAGE           P;*alignment=*left:
                                *font=SubLineFont:
                                *p=028:PrintLineCnt,"Code":
                                *P=125:PrintLineCnt,"Customer Name":
                                *p=255:PrintLineCnt,"Trans Date":
                                *p=472:PrintLineCnt,"Orig. Amt":
                                *p=552:PrintLineCnt,"Amount":
                                *p=632:PrintLineCnt,"Disc. Amt":
                                *p=712:PrintLineCnt,"Net Amt"
              ADD               SingleLine,PrintLineCnt

              RETURN





;=============================================================================;
;       created by:  chiron software & services, inc.                         ;
;                    4 norfolk lane                                           ;
;                    bethpage, ny  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  program:    prtbatchr                                                      ;
;                                                                             ;
;   author:    harry rathsam                                                  ;
;                                                                             ;
;     date:    05/07/2019 at 10:13am                                          ;
;                                                                             ;
;  purpose:                                                                   ;
;                                                                             ;
; revision:    ver     date     init       details                            ;
;                                                                             ;
;              1.0   05/07/2019   hor     initial version                     ;
;                                                                             ;
;                                                                             ;
;=============================================================================;
              INCLUDE           NCOMMON.TXT
              INCLUDE           WORKVAR.INC

ItemCount     FORM              6
TransDate     DIM               8
DueDate       DIM               8
ToDate        DIM               8
FromDate      DIM               8
DiscDate      DIM               8
HoldFlag      DIM               1
PostDate      DIM               8
AgingDays     FORM              3
CityState     DIM               42
VDiscTotals   FORM              10.2
VNetTotals    FORM              10.2
VGrossTotals  FORM              10.2
GTDiscTotal   FORM              10.2
PaymentType   DIM               8
GrossAmt      FORM              10.2
NetAmt        FORM              10.2
PrintDetails  FORM              1           //HR 8/28/2003
TransactionTotals FORM          6
CustomerPrinted DIM               1
PrintGLInfo   FORM              1
PrtEntity     DIM               2
GLAmount      FORM              7.2
GLType        DIM               2
IOSW                 DIM                  1
PrtFromDate         dim                8
PrtToDate           dim                8


CustomerGross   FORM              10.2
CustomerNet     FORM              10.2
CustomerDisc    FORM              10.2

ReferencGross FORM              10.2
ReferencNet   FORM              10.2
ReferencDisc  FORM              10.2
PaymentDesc   DIM               10
.
BatchTotals         form               10.2
DiscountTotal FORM              10.2
GrossTotal    form             10.2
NetTotal      FORM              10.2
AllCustomerFlag FORM              1
FromCustomer    DIM               6
ToCustomer      DIM               6
SelectedType  FORM              2
SavedCustomer    DIM               6
SavedReferenceNo DIM              10
SaveDate            dim                6
DateTotals          form               10.2
RunningTotals       form               10.2
BatchDate           dim                8
PrintDate           dim                8
.
X             FORM              3

              GOTO              #S
              INCLUDE           APTRN.FD
              INCLUDE           APDET.FD
              INCLUDE           CMPNY.FD
              INCLUDE           GLMast.FD
              INCLUDE           APDist.FD
              INCLUDE           Customer.FD
              INCLUDE           VHST.FD
              include           Sequence.FD
              INCLUDE           BATCHFD2.TXT
              INCLUDE           PrintRtn.INC
PrtCashBatch  PLFORM            PrtCashBatch.PLF
#S
STARTPGM      routine

              WINHIDE

              OPEN              CustomerFLST,READ
              OPEN              APDETFLST,READ
              call              BTCHOPEN
              INCLUDE           Temporary.inc

              FORMLOAD          PRTCashBatch
              CLOCK             TimeStamp,Date8
              SETITEM           CBPrintOptions,0,1

              setprop                DTFromDate,text=Date8
              setprop                DTToDate,text=Date8

              LOOP
                WAITEVENT
              REPEAT

              GOTO              ExitProgram
.
. We'll never get to this spot!!
.....................................................
StartPrint
                    move               "Y",FirstFlag
              MOVE              "Accounts Receivable System - Cash Ledger",ReportTitle

              clear             DateTotals
              clear             RunningTotals

              CALL              PrintPreviewInit
              return               if (printInitFailed = "N")

              call              PrintLandScapeMode

              SETMODE           *MCURSOR=*Wait
              MOVE              " ",APDETKY4
              GETITEM           RAllCustomer,0,AllCustomerFlag
              IF                (AllCustomerFlag = 0)
                GETITEM           EFromCustomer,0,FromCustomer
                GETITEM           EToCustomer,0,ToCustomer
              ENDIF

              GETITEM           CBPrintOptions,0,PrintDetails

              getprop                DTFromDate,text=FromDate
              getprop                DTToDate,text=ToDate
              REPLACE           " 0",FromDate
              REPLACE           " 0",ToDate

              unpack            FromDate into cc,yy,mm,dd
              packkey                  PrtFromDate from mm,"-",dd,"-",yy

              unpack            ToDate into cc,yy,mm,dd
              packkey                  PrtToDate from mm,"-",dd,"-",yy

              MOVE              "Y",FirstFlag

              GETITEM           RAllCustomer,0,AllCustomerFlag
              IF                (AllCustomerFlag = 0)
                GETITEM           EFromCustomer,0,FromCustomer
                MOVE              "      ",ToCustomer
                GETITEM           EToCustomer,0,ToCustomer
                SETLPTR           ToCustomer,6
              ENDIF

              IF                (AllCustomerFlag = 1)
                MOVE              " ",CustomerKY
              ELSE
                MOVE              FromCustomer,CustomerKY
              ENDIF

              CALL              PrintHeader
              unpack                   FromDate into CC,YY,MM,DD


              packkey                 BatchKey from yy,mm,dd
              read                    BatchFL,BatchKey;;

              LOOP
                READKS    BATCHFL;BATCHKEY,BSTATUS,BCHECKS,BATCHTOT:
                                  BTCHDATE:
                                  BACCT1,BACCT2,BACCT3,BACCT4,BACCT5,BACCT6:
                                  BACCT7,BACCT8,BACCT9,BACCT10,BACCT11,BACCT12:
                                  BACCT13,BACCT14,BACCT15,BACCT16,BACCT17,BACCT18:
                                  BACCT19,BACCT20:
                                  BCAMT1,BCAMT2,BCAMT3,BCAMT4,BCAMT5,BCAMT6,BCAMT7:
                                  BCAMT8,BCAMT9,BCAMT10,BCAMT11,BCAMT12,BCAMT13:
                                  BCAMT14,BCAMT15,BCAMT16,BCAMT17,BCAMT18,BCAMT19:
                                  BCAMT20

              UNTIL             (over or BatchKey = "00000" or (AllCustomerFlag = 0 and Customer.Account > ToCustomer))

                    if                 (SaveDate = "")
                      move               BtchDate,SaveDate
                    endif

                    if                 (BtchDate != SaveDate)
                      call               DateTotals
                      clear              DateTotals
                      add                BatchTot,DateTotals
                    else
                      add                BatchTot,DateTotals
                    endif
                    call               PrintDetails if (PrintDetails <= 2)


                ADD               "1",TransactionTotals

                CALL              PrintLine if (CustomerPrinted = "N")

                MOVE              "Y",CustomerPrinted
                ADD               "1",ItemCount

              REPEAT
              call               DateTotals

              CALL              PrintTotals
              CALL              PrintClose
              SETMODE           *MCURSOR=*Arrow

              GOTO              ExitProgram
;==========================================================================================================
PrintDetails
                    unpack             BTCHDATE into yy,mm,dd
                    Packkey            BatchDate from mm,"-",dd,"-",yy
                    EndOfPage
                    if                     (FirstFlag != "Y")
                      PRTPAGE           P;*font=SubLineFont:
                                        *alignment=*left:
                                        *Pensize=1:
                                        *p=30:(PrintLineCnt - 2):
                                        *Line=760:(PrintLineCnt - 2)
                    else
                      move                   "N",FirstFlag
                    endif

                    PrtPage            P;*font=DetailFont:
                                       *alignment=*left:
                                       *boldon:
                                       *p=035:PrintLineCnt,"Batch # ",BATCHKEY:
                                       *p=430:PrintLineCnt,BatchDate:
                                       *boldoff

                    if                 (PrintDetails <= 2)
                      PrtPage            P;*font=DetailFont:
                                         *boldon:
                                         *alignment=*decimal:
                                         *p=600:PrintLineCnt,BatchTot:
                                         *boldoff
                    endif

                    ADD                SingleLine,PrintLineCnt
                    for                BtchIndx from "1" to BChecks using "1"
                      call               LoadBtch
                      call               PrintLine
                    repeat

                    return
;==========================================================================================================
DateTotals
                CHOP              Customer.Account,Customer.Account
                unpack            SaveDate into yy,mm,dd
                packkey           PrintDate from mm,"-",dd,"-",yy
                add                DateTotals,RunningTotals

.                      PRTPAGE           P;*font=SubLineFont:
.                                        *alignment=*left:
.                                        *Pensize=1:
.                                        *p=30:(PrintLineCnt - 2):
.                                        *Line=760:(PrintLineCnt - 2)

...                add               SingleLine,PrintLineCnt

                    if                 (PrintDetails != 4)
                PrtPage           P;*font=DetailFont:
                                  *alignment=*left:
                                  *boldon:
                                  *p=155:PrintLineCnt,"Total Deposits for ":
                                  *ha=10:
                                  *LL:
                                  PrintDate:
                                  ":":
                                  *alignment=*decimal:
                                  *p=600:PrintLineCnt,DateTotals:
                                  *p=720:PrintLineCnt,RunningTotals:
                                  *boldoff
                    add                SingleLine,PrintLineCnt

                    if                 (PrintDetails != 3)
                    PRTPAGE           P;*font=SubLineFont:
                                      *alignment=*left:
                                      *Pensize=3:
                                      *p=30:(PrintLineCnt - 2):
                                      *Line=760:(PrintLineCnt - 2)
                    endif
                    endif
                    move               "Y",FirstFlag
..                    add                SingleLine,PrintLineCnt
                    move               BtchDate,SaveDate
                    return
;==========================================================================================================
PrintLine
              return            if (PrintDetails != 1)
              move              ACCTARG,CustomerKY
              call              RDCustomer

              CHOP              Customer.City,Customer.City
              PACK              CityState,Customer.City,", ",Customer.State,"  ",Customer.Zip

               EndOfPage
               PrtPage           P;*font=DetailFont:
                                 *alignment=*left:
                                 *p=045:PrintLineCnt,Customer.Account:
                                 *p=110:PrintLineCnt,Customer.Name:
                                 *alignment=*decimal:
                                 *p=600:PrintLineCnt,CHECKAMT

               ADD               SingleLine,PrintLineCnt
           RETURN
;==========================================================================================================
. Print the Totals for each Customer
.=============================================================================
PrintCustomerTotals
              RETURN            if (CustomerPrinted = "N")

              CALC              VNetTotals = VNetTotals + VGrossTotals - VDiscTotals

              IF                   (PrintDetails = 1)   //Report Details!!!
                PRTPAGE           P;*font=SubLineFont:
                                  *alignment=*left:
                                  *Pensize=1:
                                  *p=30:(PrintLineCnt - 2):
                                  *Line=760:(PrintLineCnt - 2)

                CHOP              Customer.Account,Customer.Account
                PrtPage           P;*font=SubLineFont:
                                  *alignment=*left:
                                  *p=155:PrintLineCnt,"Totals for ":
                                  *ha=10:
                                  *boldon:
                                  *LL:
                                  Customer.Account:
                                  ":":
                                  *alignment=*decimal:
                                  *p=427:PrintLineCnt,VGrossTotals:
                                  *p=502:PrintLineCnt,VDiscTotals:
                                  *p=737:PrintLineCnt,VNetTotals:
                                  *boldon:
                                  *boldoff
.
                ADD               DoubleLine,PrintLineCnt
              ENDIF
              RETURN
;=============================================================================
PrintTotals
                    EndOfPage
                    if                 (PrintDetails = 3)
                    PRTPAGE           P;*font=SubLineFont:
                                      *alignment=*left:
                                      *Pensize=3:
                                      *p=30:(PrintLineCnt - 2):
                                      *Line=760:(PrintLineCnt - 2)
                    endif
                    pack               DataLine from "Total Cash Processed for period of     ",PrtFromDate,"   To   ",PrtToDate
                    ADD               (DoubleLine),PrintLineCnt

                PrtPage           P;*font=DetailFont:
                                  *alignment=*left:
                                  *boldon:
                                  *p=170:PrintLineCnt,DataLine:
                                  *alignment=*decimal:
                                  *p=720:PrintLineCnt,RunningTotals:
                                  *alignment=*Left:
                                  *boldoff

                    ADD               (DoubleLine),PrintLineCnt
                    PRTPAGE           P;*font=DetailFont,*boldon:
                                      *p=170:PrintLineCnt,"Total Check Batches Printed :":                        //HR 6/5/2003
                                      *alignment=*left:
                                      ItemCount:
                                      *boldoff

                    RETURN
;==========================================================================================================
ExitProgram
              winshow
              CHAIN             FROMPGM
              STOP
.=============================================================================
PrintCustomHeader
              PRTPAGE           P;*alignment=*left:
                                *font=SubLineFont:
                                *p=420:PrintLineCnt,"For Reporting Period      ",PrtFromDate,"   To   ",PrtToDate
              ADD               DoubleLine,PrintLineCnt

              PRTPAGE           P;*alignment=*left:
                                *font=SubLineFont:
                                *p=048:PrintLineCnt,"Customer No.":
                                *p=145:PrintLineCnt,"Customer Name":                           //255
                                *p=432:PrintLineCnt,"Entered On":
                                *p=575:PrintLineCnt,"Total":
                                *p=685:PrintLineCnt,"Running Totals"
              ADD               SingleLine,PrintLineCnt

              RETURN
;==========================================================================================================
                     INCLUDE   BATCHIO.TXT
                     INCLUDE   STDIOERR.TXT
                     INCLUDE   STDPARER.TXT
                     INCLUDE   STDFMTER.TXT
                     INCLUDE   STDRANGE.TXT

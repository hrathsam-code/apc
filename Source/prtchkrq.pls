;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    4 NORFOLK LANE                                           ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    PRTCHKRQ.PLS                                                   ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    07/05/2005 AT 1:12PM                                           ;
;                                                                             ;
;  PURPOSE:    Print Check/Cash Requirements Report                           ;
;                                                                             ;
; REVISION:    VER     DATE     INIT       DETAILS                            ;
;                                                                             ;
;              1.0   07/05/2005  HOR     INITIAL VERSION                      ;
;                                                                             ;
.=============================================================================
              INCLUDE           NCOMMON.TXT
              INCLUDE           WORKVAR.INC

ItemCount     FORM              6
TransDate     DIM               8
DueDate       DIM               8
..today      DIM                8
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
PrintDetails  FORM              1
TransactionTotals FORM          6
VendorPrinted DIM               1
PrintGLInfo   FORM              1
PrtEntity     DIM               2
GLAmount      FORM              7.2
GLType        DIM               2

VendorGross   FORM              10.2
VendorNet     FORM              10.2
VendorDisc    FORM              10.2

ReferencGross FORM              10.2
ReferencNet   FORM              10.2
ReferencDisc  FORM              10.2
PaymentDesc   DIM               10
.
DiscountTotal FORM              10.2
GrossTotal    form             10.2
NetTotal      FORM              10.2
AllVendorFlag FORM              1
FromVendor    DIM               6
ToVendor      DIM               6
SelectedType  FORM              2
SavedVendor    DIM               6
SavedReferenceNo DIM              10
.
X             FORM              3

              GOTO              #S

              INCLUDE           APTRN.FD
              INCLUDE           CMPNY.FD
              INCLUDE           GLMast.FD
              INCLUDE           APDist.FD
              INCLUDE           Sequence.FD
              INCLUDE           Vendor.FD
              INCLUDE           VHST.FD
              INCLUDE           Bank.FD
              INCLUDE           ChkRun.FD
              INCLUDE           ChkRunDT.FD
              INCLUDE           PrintRtn.INC
PRTCHKRQ      PLFORM            PRTCHKRQ.PLF
#S
STARTPGM      routine
              WINHIDE
.           CALL              OPENVendor
              OPEN              VendorFLST,READ
..           CALL              OPENVSTAT
.           CALL              OPENAPTRN
              OPEN                 APTRNFLST,READ
..           CALL              OPENAPDET
              CALL              OPENCMPNY
              CALL              OpenCheckRun
              CALL              OpenCheckRunDetail
              OPEN              GLMastFLST,READ
              OPEN              APDistFLST,READ
              INCLUDE           Temporary.inc

              FORMLOAD          PRTCHKRQ
              CLOCK             DATE,TODAY8

              LOOP
                WAITEVENT
              REPEAT

              GOTO              ExitProgram
.
. We'll never get to this spot!!
.....................................................
StartPrint
              MOVE              "Accounts Payable Cash Requirements Report",ReportTitle

              CALL              PrintPreviewInit                      //HR 11.3.2014
              return               if (printInitFailed = "N")

              SETMODE           *MCURSOR=*Wait
              MOVE              "Y",FirstFlag
              MOVE              " ",CheckRunKY
              MOVE              "0",ItemCount

              GETITEM           CBPrintOptions,0,PrintDetails

              CALL              PrintHeader
              CALL              RDCheckRun
              LOOP
                CALL              KSCheckRun
              UNTIL             (ReturnFL = 1)
                MOVE              "0",VDiscTotals
                MOVE              "0",VGrossTotals
                MOVE              "0",VNetTotals
                ADD               "1",ItemCount

                MOVE              CheckRun.Vendor,VendorKY
                CALL              RDVendor

..Why????                CALL              RDCheckRunDetail

                CALL              PrintVendorLine

...                PACKKEY           CheckRunDetailKY2 FROM $Entity,CheckRun.BankCode,CheckRun.Vendor
                PACKKEY           CheckRunDetailKY2 FROM $Entity,CheckRun.Vendor
                CALL              RDCheckRunDetail2
                LOOP
                  CALL              KSCheckRunDetail2
                UNTIL             (ReturnFl = 1 or Vendor.AccountNumber != CheckRunDetail.Vendor)
                  CALL              PrintCheckDetails
                REPEAT
              CALL              PrintCheckLine if (PrintDetails = 1)

              REPEAT

              CALL              PrintTotals
              CALL              PrintClose
              SETMODE           *MCURSOR=*Arrow

              GOTO              ExitProgram
;=============================================================================
PrintCheckLine
              CHOP              Vendor.City,Vendor.City
              PACK              CityState,Vendor.City,", ",Vendor.State,"  ",Vendor.Zip

              IF                   (PrintDetails != 3)   //Report Totals Only (Code = 3)
              EndOfPage

              IF                (PrintDetails = 1)                  //Print a Vendor Totals Line first before printing Totals
..HR 8/2/2005                PrtPage             P;*p=10:(PrintLineCnt - 2):
..HR 8/2/2005                                    *Line=760:(PrintLineCnt - 2)
                PrtPage             P;*Pensize=1:
                                    *p=400:(PrintLineCnt - 2):
                                    *Line=760:(PrintLineCnt - 2)
              ENDIF

              PrtPage           P;*font=DetailFont:
                                *alignment=*left:
                                *boldon:
.                                *p=020:PrintLineCnt,Vendor.AccountNumber:
.                                *p=110:PrintLineCnt,Vendor.Name:
                                *p=430:PrintLineCnt,"Check Amt.":
                                *boldoff:
                                *alignment=*decimal:
                                *p=560:PrintLineCnt,CheckRun.GrossAmount:
                                *p=640:PrintLineCnt,CheckRun.DiscAmt:
                                *p=740:PrintLineCnt,CheckRun.CheckAmount

.              ADD               SingleLine,PrintLineCnt

                IF                (PrintDetails = 1)
..                  ADD               DoubleLine,PrintLineCnt
                  ADD               SingleLine,PrintLineCnt
                ENDIF
              ENDIF
              RETURN
;=============================================================================
PrintVendorLine
              CHOP              Vendor.City,Vendor.City
              PACK              CityState,Vendor.City,", ",Vendor.State,"  ",Vendor.Zip

              IF                   (PrintDetails != 3)   //Report Totals Only (Code = 3)
                EndOfPage

                PrtPage           P;*font=DetailFont:
                                  *alignment=*left:
                                  *boldon:
                                  *p=020:PrintLineCnt,Vendor.AccountNumber:
                                  *p=110:PrintLineCnt,Vendor.Name:
                                  *boldoff

                IF                   (PrintDetails = 2)   //Report Details!!!
                  CALL              PrintCheckLine
                ENDIF

                ADD               SingleLine,PrintLineCnt
              ENDIF
              RETURN
;=============================================================================
PrintCheckDetails
              PACKKEY            APTRNKY2,$Entity,CheckRunDetail.Voucher
              CALL               RDAPTRN2

              unpack            APTRN.TransDate,CC,YY,MM,DD
              PACK              TransDate FROM MM,"/",DD,"/",YY

              UNPACK            APTRN.DiscDate,CC,YY,MM,DD
              PACK              DiscDate FROM MM,"/",DD,"/",YY

              UNPACK            APTRN.DueDate,CC,YY,MM,DD
              PACK              DueDate FROM MM,"/",DD,"/",YY

              ADD                CheckRunDetail.GrossAmount,GrossTotal
              ADD                CheckRunDetail.DiscAmt,DiscountTotal
              ADD                CheckRunDetail.NetAmount,NetTotal

              EndOfPage

              IF                   (PrintDetails = 1)   //Report Details!!!
                PrtPage           P;*alignment=*left:
                                  *font=DetailFont:
                                  *p=80:PrintLineCnt,APTRN.Invoice:               //12
                                  *alignment=*left:
                                  *p=315:PrintLineCnt,TransDate:
                                  *p=405:PrintLineCnt,DueDate:
                                  *alignment=*decimal:
                                  *p=560:PrintLineCnt,CheckRunDetail.GrossAmount:
                                  *p=640:PrintLineCnt,CheckRunDetail.DiscAmt:
                                  *p=740:PrintLineCnt,CheckRunDetail.NetAmount

                ADD               SingleLine,PrintLineCnt
              ENDIF
              RETURN
.=============================================================================
PrintTotals
                EndOfPage

                PRTPAGE           P;*font=SubLineFont:
                                 *alignment=*left:
                                 *Pensize=1:
                                 *p=10:(PrintLineCnt - 2):
                                 *Line=760:(PrintLineCnt - 2):
                                 *p=10:(PrintLineCnt - 4):
                                 *Line=760:(PrintLineCnt - 4):
                                 *font=SubLineFont:
                                 *alignment=*left:
                                 *boldon:
                                 *p=155:PrintLineCnt,"Cash Requirements for Check Run Totals :":
                                 *boldoff:
                                 *font=DetailFont:
                                 *alignment=*decimal:
                                 *p=560:PrintLineCnt,GrossTotal:
                                 *p=640:PrintLineCnt,DiscountTotal:
                                 *p=740:PrintLineCnt,NetTotal

              ADD               (SingleLine),PrintLineCnt
              ADD               (DoubleLine * 2),PrintLineCnt
              PRTPAGE           P;*font=DetailFont,*boldon:
                                "Total Checks to be Processed :":
                                *alignment=*left:
                                ItemCount:
                                *boldoff

              ADD               DoubleLine,PrintLineCnt
            RETURN
.
ExitProgram
              winshow
              CHAIN             FROMPGM
              STOP
.=============================================================================
PrintCustomHeader
              PRTPAGE           P;*alignment=*left:
                                *font=SubLineFont:
                                *p=018:PrintLineCnt,"Vendor":
                                *p=088:PrintLineCnt,"Invoice":
                                *p=313:PrintLineCnt,"Invoice Date":
                                *p=407:PrintLineCnt,"Due Date":
                                *p=527:PrintLineCnt,"Gross Amt":
                                *p=608:PrintLineCnt,"Disc. Amt":
                                *p=702:PrintLineCnt,"Net Amount"
              ADD               SingleLine,PrintLineCnt

              RETURN

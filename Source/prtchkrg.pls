;=============================================================================;
;       created by:  chiron software & services, inc.                         ;
;                    4 norfolk lane                                           ;
;                    bethpage, ny  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  program:    prtchkrg                                                       ;
;                                                                             ;
;   author:    harry rathsam                                                  ;
;                                                                             ;
;     date:    01/28/2019 at 8:46am                                           ;
;                                                                             ;
;  purpose:                                                                   ;
;                                                                             ;
; revision:    ver     date     init       details                            ;
;                                                                             ;
;              1.0   01/28/2019   hor     initial version                     ;
;                                                                             ;
;                                                                             ;
;=============================================================================;
              INCLUDE           NCOMMON.TXT
              INCLUDE           WORKVAR.INC

SortedBy      FORM              1


PrintCheckDate DIM              10
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
CheckType     FORM              1
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
              INCLUDE           Sequence.FD
              INCLUDE           CMPNY.FD
              INCLUDE           GLMAST.FD
              INCLUDE           APDist.FD
              INCLUDE           Vendor.FD
              INCLUDE           VHST.FD
              INCLUDE           Bank.FD
              INCLUDE           Check.FD
              INCLUDE           CheckDet.FD
              INCLUDE           PrintRtn.INC
PRTCHKRG      PLFORM            PRTCHKRG.PLF
#S
STARTPGM      routine
              WINHIDE
              OPEN              VendorFLST,READ
              OPEN              APTRNFLST,READ
              CALL              OPENCMPNY
              CALL              OpenCheck
              CALL              OpenCheckDetail
              OPEN              GLMastFLST,READ
              OPEN              APDistFLST,READ
.              INCLUDE           Temporary.inc

              FORMLOAD          PRTCHKRG
              CLOCK             DATE,TODAY8

              SETITEM           CBCheckType,0,3              //HR 7/16/2009

              SETITEM           CBPrintOptions,0,1
              CLOCK             TimeStamp,Date8

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
                    MOVE              "Accounts Payable Check Register Report",ReportTitle

                    CALL              PrintPreviewInit
                    return               if (printInitFailed = "N")

                    SETMODE           *MCURSOR=*Wait

                    GETITEM           RAllVendor,0,AllVendorFlag
                    IF                (AllVendorFlag = 0)
                      GETITEM           EFromVendor,0,FromVendor
                      GETITEM           EToVendor,0,ToVendor
                    ENDIF

                    GETITEM           CBCheckType,0,CheckType
                    GETITEM           CBSortedBy,0,SortedBy

                    GETITEM           CBPrintOptions,0,PrintDetails

                    getprop                DTFromDate,text=FromDate
                    getprop                DTToDate,text=ToDate

                    MOVE              "Y",FirstFlag

                    GETITEM           RAllVendor,0,AllVendorFlag
                    IF                (AllVendorFlag = 0)
                      GETITEM           EFromVendor,0,FromVendor
                      MOVE              "      ",ToVendor
                      GETITEM           EToVendor,0,ToVendor
                      SETLPTR           ToVendor,6
                    ENDIF

                    IF                (AllVendorFlag = 1)
                      MOVE              " ",VendorKY
                    ELSE
                      MOVE              FromVendor,VendorKY
                    ENDIF

                    CALL              PrintHeader

                    if                 (SortedBy = 1)                 //By Vendor Name, By Check Number
                      move              " ",VendorKY2
                      call              RDVendor2
                      loop
                        call               KSVendor2
                      until              (ReturnFl = 1)
                        PACKKEY           CheckKY2 FROM $Entity,Vendor.AccountNumber,FromDate,"   "
                        call              RDCheck2
                        LOOP
                          CALL              KSCheck2
                        UNTIL             (ReturnFL = 1 or Check.CheckDate > ToDate or Vendor.AccountNumber != Check.Vendor)
                          continue          if (Check.VoidedFlag = 1)                          //HR 2019.3.21
                          call             ContinueProcessing
                        repeat
                      repeat
                    else
                      packkey           CheckKY3 FROM $Entity,FromDate,"   "
                      call              RDCheck3
                      LOOP
                        CALL              KSCheck3
                      UNTIL             (ReturnFL = 1 or Check.CheckDate > ToDate)
                        continue          if (Check.VoidedFlag = 1)                            //HR 2019.3.21
                        call              ContinueProcessing
                      repeat
                    endif

                    CALL              PrintTotals
                    CALL              PrintClose
                    SETMODE           *MCURSOR=*Arrow

                    GOTO              ExitProgram
;==========================================================================================================
ContinueProcessing
..HR 2019.3.4                      CONTINUE          if (CheckType = 1 and Check.CheckFlag != "M")   //Manual option, Ignore all others
..HR 2019.3.4                      CONTINUE          if (CheckType = 2 and Check.CheckFlag != "A")   //Automatic option, Ignore all others
                      return          if (CheckType = 1 and Check.CheckFlag != "M")   //Manual option, Ignore all others
                      return          if (CheckType = 2 and Check.CheckFlag != "A")   //Automatic option, Ignore all others

                      ADD               "1",ItemCount

                      ADD                Check.GrossAmount,GrossTotal
                      ADD                Check.DiscAmt,DiscountTotal
                      ADD                Check.CheckAmount,NetTotal

                      MOVE              Check.Vendor,VendorKY

                      if                (SortedBy != 1)            //We've already got the vendor
                        CALL              RDVendor
                      endif

                      PACKKEY           CheckDetailKY FROM $Entity,Check.BankCode,Check.CheckNo,Check.SeqMajor
                      CALL              RDCheckDetail
                      LOOP
                        CALL              KSCheckDetail
                      UNTIL             (ReturnFl = 1 or Check.CheckNo != CheckDetail.CheckNo)

                        CALL              PrintCheckDetails
                      REPEAT
                      CALL              PrintCheckLine
                    return
;==========================================================================================================

PrintCheckLine
              CHOP              Vendor.City,Vendor.City
              PACK              CityState,Vendor.City,", ",Vendor.State,"  ",Vendor.Zip

              IF                   (PrintDetails != 3)   //Report Totals Only (Code = 3)
                EndOfPage

                UNPACK            Check.CheckDate into CC,YY,MM,DD
                PACKKEY           PrintCheckDate FROM MM,"/",DD,"/",YY

                PrtPage           P;*font=DetailFont:
                                  *alignment=*left:
                                  *boldon:
                                  *p=020:PrintLineCnt,Vendor.AccountNumber:
                                  *p=090:PrintLineCnt,Vendor.Name:
                                  *boldoff:
                                  *alignment=*left:
                                  *p=365:PrintLineCnt,Check.CheckNo:
                                  *p=438:PrintLineCnt,PrintCheckDate:
                                  *alignment=*decimal:
                                  *p=560:PrintLineCnt,Check.GrossAmount:
                                  *p=640:PrintLineCnt,Check.DiscAmt:
                                  *p=740:PrintLineCnt,Check.CheckAmount


                IF                (PrintDetails = 1)                  //Add another blank line when Printing the Details
                  ADD               SingleLine,PrintLineCnt

                  IF                (PrintDetails = 1)                  //Print a Vendor Totals Line first before printing Totals
                    PrtPage             P;*p=10:(PrintLineCnt - 2):
                                        *Line=760:(PrintLineCnt - 2)
                  ENDIF


                ENDIF

                ADD               SingleLine,PrintLineCnt
              ENDIF
              RETURN
;=============================================================================
PrintCheckDetails
              PACKKEY            APTRNKY2,$Entity,CheckDetail.Voucher
              CALL               RDAPTRN2

              unpack            APTRN.TransDate,CC,YY,MM,DD
              PACK              TransDate FROM MM,"/",DD,"/",YY

              UNPACK            APTRN.DiscDate,CC,YY,MM,DD
              PACK              DiscDate FROM MM,"/",DD,"/",YY

              UNPACK            APTRN.DueDate,CC,YY,MM,DD
              PACK              DueDate FROM MM,"/",DD,"/",YY

              EndOfPage

              IF                   (PrintDetails = 1)   //Report Details!!!
                PrtPage           P;*alignment=*left:
                                  *font=DetailFont:
                                  *p=80:PrintLineCnt,APTRN.Invoice:               //12
                                  *alignment=*left:
                                  *p=315:PrintLineCnt,TransDate:
                                  *p=405:PrintLineCnt,DiscDate:
                                  *alignment=*decimal:
                                  *p=560:PrintLineCnt,CheckDetail.GrossAmount:
                                  *p=640:PrintLineCnt,CheckDetail.DiscAmt:
                                  *p=740:PrintLineCnt,CheckDetail.NetAmount

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
                                 *p=155:PrintLineCnt,"Check Register Report Totals :":
                                 *boldoff:
                                 *font=DetailFont:
                                 *alignment=*decimal:
                                 *p=560:PrintLineCnt,GrossTotal:
                                 *p=640:PrintLineCnt,DiscountTotal:
                                 *p=740:PrintLineCnt,NetTotal

              ADD               (SingleLine),PrintLineCnt
              ADD               (DoubleLine * 2),PrintLineCnt
              PRTPAGE           P;*font=DetailFont,*boldon:
                                "Total Checks Printed :":
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
                                *p=988:PrintLineCnt,"Name":
                                *p=370:PrintLineCnt,"Check No.":
                                *p=438:PrintLineCnt,"Check Date":
                                *p=527:PrintLineCnt,"Gross Amt":
                                *p=608:PrintLineCnt,"Disc. Amt":
                                *p=702:PrintLineCnt,"Check Amount"
              ADD               SingleLine,PrintLineCnt

              RETURN

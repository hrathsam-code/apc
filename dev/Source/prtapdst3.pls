;=============================================================================;
;       created by:  chiron software & services, inc.                         ;
;                    4 norfolk lane                                           ;
;                    bethpage, ny  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  program:    prtapdst                                                       ;
;                                                                             ;
;   author:    harry rathsam                                                  ;
;                                                                             ;
;     date:    01/28/2019 at 12:07pm                                          ;
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


APDistTemp          ifile

PrintCheckDate DIM              10

TotalType           dim                2
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
NetAmt        FORM              7.2
PrintDetails  FORM              1           //HR 8/28/2003
TransactionTotals FORM          6
VendorPrinted DIM               1
PrintGLInfo   FORM              1
PrtEntity     DIM               2
GLAmount      FORM              7.2
GLType        DIM               2
SubEntityTotalCr FORM             10.2
SubEntityTotalDb FORM             10.2
SubEntityTotalNet FORM             10.2
GLTotalsCR    FORM              10.2
GLTotalsDb    FORM              10.2
GLTotalsNet   FORM              10.2           //HR 11/15/2005
ReportTotalsCr FORM             10.2
ReportTotalsDb FORM             10.2
ReportTotalsNet FORM            10.2           //HR 10/15/2005

SubEntityCount FORM             7
ValidGLCode   DIM               1

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
AllGLCodeFlag FORM              1
FromGLCode    DIM               6
ToGLCode      DIM               6
SelectedType  FORM              2
SavedGLCode   DIM               6
SavedReferenceNo DIM              10
SameGLCode    DIM               1
SubEntity     DIM               8
TestDate      DIM               8
PrtFromDAte   DIM               8
PrtToDate     DIM               8
Phase               form               1

CheckTotals         form               9.2

X             FORM              3

              GOTO              #S
              INCLUDE           APTRN.FD
              INCLUDE           APDET.FD
              include           Sequence.FD
              INCLUDE           CMPNY.FD
              INCLUDE           GLMast.FD
              INCLUDE           APDist.FD

              include                  Check.FD
              include                  CheckDet.FD
              INCLUDE           Vendor.FD
              INCLUDE           VHST.FD
              INCLUDE           PrintRtn.INC
PRTAPDST      PLFORM            PRTAPDST.PLF
#S
STARTPGM      routine
              WINHIDE
              OPEN              VendorFLST,READ
              OPEN                 APTRNFLST,READ
              OPEN              APDETFLST,READ
              CALL              OPENCMPNY
              OPEN              GLMastFLST,READ
              OPEN              APDistFLST,READ
              open                     CheckFLST,READ
              open                     CheckDetailFLST,READ
              open                     VendorFLST,read


              FORMLOAD          PRTAPDST
              CLOCK             TimeStamp,TODAY8
              SETPROP           DTFromDate,text=TODAY8
              SETPROP           DTToDate,text=TODAY8

              LOOP
                WAITEVENT
              REPEAT

              GOTO              ExitProgram
.
. We'll never get to this spot!!
.....................................................
StartPrint
              clear                    CheckTotals
              move                     "1",Phase
              MOVE              "Accounts Payable PAID Distribution Report",ReportTitle

              CALL              PrintPreviewInit
              return               if (printInitFailed = "N")

              SETMODE           *MCURSOR=*Wait
              MOVE              " ",APDETKY4
              GETITEM           RAllGLCode,0,AllGLCodeFlag
              IF                (AllGLCodeFlag = 0)
                GETITEM           EFromGLCode,0,FromGLCode
                GETITEM           EToGLCode,0,ToGLCode
              ENDIF

              GETITEM           CBPrintOptions,0,PrintDetails

              GETPROP           DTFromDate,text=FromDate
              UNPACK            FromDate into CC,YY,MM,DD
              PACKKEY           PrtFromDate FROM MM,Slash,DD,Slash,YY
              GETPROP           DTToDate,text=ToDate
              UNPACK            ToDate into CC,YY,MM,DD
              PACK              PrtToDate FROM MM,Slash,DD,Slash,YY

              MOVE              "Y",FirstFlag

              GETITEM           RAllGLCode,0,AllGLCodeFlag
              IF                (AllGLCodeFlag = 0)
                GETITEM           EFromGLCode,0,FromGLCode
                MOVE              "      ",ToGLCode
                GETITEM           EToGLCode,0,ToGLCode
                SETLPTR           ToGLCode,6
              ENDIF

              call                CreateTempAPDist
..              open               APDistFL2,"APDistTemp",READ

..              CALL              PrintHeader
              CALL              RDGLMast

              MOVE              "0",ReportTotalsDb
              MOVE              "0",ReportTotalsCr
              MOVE              "0",ReportTotalsNet

                    LOOP
                      CALL            KSGLMast
                    UNTIL             (ReturnFl = 1)

                      MOVE              "0",GLTotalsDb
                      MOVE              "0",GLTotalsCr
                      MOVE              "0",GLTotalsNet
                      MOVE              "N",ValidGLCode

                      MOVE              "N",FirstFlag
                      MOVE              "0",TransactionTotals
                      MOVE              "N",VendorPrinted
                      MOVE              "Y",SameGLCode
.
                      MOVE              FromDate,TestDate
                      clear             SavedGLCode
                      move              "Y",FirstFlag

                      PACKKEY           APDistKY2 FROM $Entity,GLMast.Account   //Read the first Entity
..                      CALL              RDAPDist2
                      read              APDistTemp,APDistKY2;;
                      LOOP
                        readks            APDistTemp;APDist
..                        call                   KSAPDist2
                      UNTIL             (APDist.GLCode != GLMast.Account or over)
harry123
                        CALL              PrintLine if (FirstFlag = "Y")

                        move              "N",FirstFlag
                        MOVE              "Y",ValidGLCode
                        ADD               "1",SubEntityCount
                        ADD               "1",TransactionTotals
                        ADD               APDist.CreditAmount,SubEntityTotalCR
                        ADD               APDist.DebitAmount,SubEntityTotalDb

                        ADD               APDist.CreditAmount,SubEntityTotalNet       //HR 11/15/2005
                        ADD               APDist.DebitAmount,SubEntityTotalNet        //HR 11/15/2005

                        ADD               APDist.CreditAmount,GLTotalsCR
                        ADD               APDist.DebitAmount,GLTotalsDb
                        CALC              GLTotalsNet = GLTotalsNet + (APDist.DebitAmount - APDist.CreditAmount)

                        ADD               APDist.CreditAmount,ReportTotalsCR
                        ADD               APDist.DebitAmount,ReportTotalsDb
                        CALC              ReportTotalsNet = ReportTotalsNet + (APDist.DebitAmount - APDist.CreditAmount)

                        MOVE              "Y",VendorPrinted
                        ADD               "1",ItemCount

                        CALL              PrintDetails
                      REPEAT
                      CALL              PrintGLTotals if (ValidGLCode = "Y")
                    REPEAT

                    CALL              PrintTotals

                    ADD               DoubleLine,PrintLineCnt
                    call               PrintCheckRecap

                    CALL              PrintClose
                    SETMODE           *MCURSOR=*Arrow

                    GOTO              ExitProgram

;==========================================================================================================
PrintLine
              CHOP              Vendor.City,Vendor.City
              PACK              CityState,Vendor.City,", ",Vendor.State,"  ",Vendor.Zip

           IF                   (PrintDetails = 1)   //Report Details!!!
             EndOfPage
             PrtPage           P;*font=DetailFont:
                               *alignment=*left:
                               *boldon:
                               *p=020:PrintLineCnt,GLMast.Account:
                               *p=150:PrintLineCnt,GLMast.Desc:
                               *font=SubLineFont:
                               *boldoff

             ADD               SingleLine,PrintLineCnt
           ENDIF
           RETURN
;=============================================================================
PrintGLSubEntityTotals
              RETURN            if (SubEntityCount = 0)     //Don't print em' if there's nothing to print!!!!

              IF                (PrintDetails = 1)          //Print SubTotal lines only when printing Details
              PRTPAGE           P;*font=SubLineFont:
                                *alignment=*left:
                                *Pensize=1:
                                *p=30:(PrintLineCnt - 2):
                                *Line=800:(PrintLineCnt - 2)

              ENDIF

              CHOP              SubEntity
              CHOP              GLMast.Desc

              PrtPage           P;*font=SubLineFont:
                                *alignment=*left:
                                *p=030:(PrintLineCnt):
                                *ha=10:
                                *boldon:
                                *LL:
                                GLMast.Account," - ",GLMast.Desc:
                                "  Entity - (",*LL,SubEntity,")":
                                ":":
                                *alignment=*decimal

             if                (SubEntityTotalNet < 0)
               multiply                  "-1",SubEntityTotalNet
               move                      "Cr",TotalType
             else
               clear                     TotalType
             endif

              PrtPage           P;*alignment=*left:
                                *font=SubLineFont:
                                *alignment=*decimal:
                                *BlankOn:
                                *p=555:(PrintLineCnt),SubEntityTotalDb:
                                *p=635:(PrintLineCnt),SubEntityTotalCr:
                                *p=715:(PrintLineCnt),SubEntityTotalNet:
                                *alignment=*left:
                                *p=729:PrintLineCnt,TotalType:
                                *BlankOff
              ADD               SingleLine,PrintLineCnt
              RETURN
;=============================================================================
PrintDetails
           unpack            APDist.TransDate,CC,YY,MM,DD
           PACK              TransDate FROM MM,"/",DD,"/",YY

           UNPACK            APTRN.DiscDate,CC,YY,MM,DD
           PACK              DiscDate FROM MM,"/",DD,"/",YY

           UNPACK            APTRN.DueDate,CC,YY,MM,DD
           PACK              DueDate FROM MM,"/",DD,"/",YY

           Add                APDetail.Amount,GrossTotal

           Add                APTRN.DiscAmt,DiscountTotal
           calc               NetTotal = NetTotal + (APDetail.Amount - APTRN.DiscAmt)
...              ADD               APDist.DebitAmount,APDist.CreditAmount,NetAmt
              subtract                 APDist.CreditAmount,APDist.DebitAmount,NetAmt
           EndOfPage

           IF                   (PrintDetails = 1)   //Report Details!!!

             PACKKEY           APTRNKY2,$Entity,APDist.Voucher
             CALL              RDAPTRN2

             move                      APTRN.Vendor,VendorKY
             call                      RDVendor

             move              APDist.SubEntity,PrtEntity
             if                (NetAmt < 0)
               multiply                  "-1",NetAmt
               move                      "Cr",TotalType
             else
               clear                     TotalType
             endif

             PrtPage           P;*alignment=*left:
                               *font=SubLineFont:
                               *p=40:PrintLineCnt,APTRN.Vendor:
                               *p=080:PrintLineCnt,APDist.CheckNo:
                               *p=150:PrintLineCnt,Vendor.Name:
                               *p=440:PrintLineCnt,TransDate:
                               *alignment=*decimal:
                               *BlankOn:
                               *Overlayon:
                               *p=555:PrintLineCnt,APDist.DebitAmount:
                               *p=635:PrintLineCnt,APDist.CreditAmount:
                               *p=715:PrintLineCnt,NetAmt:
                               *alignment=*left:
                               *p=729:PrintLineCnt,TotalType:
                               *OverLayOff:
                               *BlankOff:
                               *p=750:PrintLineCnt,PrtEntity


             ADD               SubSingleLine,PrintLineCnt
           ENDIF

           ADD               APTRN.DiscAmt,ReferencDisc
           ADD               APDetail.Amount,ReferencGross
           ADD               NetAmt,ReferencNet
           RETURN
.=============================================================================
. Print the Totals for each Vendor
.=============================================================================
PrintGLTotals
              RETURN            if (VendorPrinted = "N")

              CALC              VNetTotals = VNetTotals + VGrossTotals - VDiscTotals

              IF                   (PrintDetails = 1)   //Report Details!!!
                PRTPAGE           P;*font=SubLineFont:
                                  *alignment=*left:
                                  *Pensize=1:
                                  *p=30:(PrintLineCnt - 2):
                                  *Line=800:(PrintLineCnt - 2):
                                  *p=30:(PrintLineCnt):
                                  *Line=800:(PrintLineCnt)
              ENDIF
              if                (GLTotalsNet < 0)
                multiply                  "-1",GLTotalsNet
                move                      "Cr",TotalType
              else
                clear                     TotalType
              endif

              PrtPage           P;*font=SubLineFont:
                                *alignment=*left:
                                *p=055:(PrintLineCnt + 5),*boldon,"Totals for ":
                                *ha=10:
                                *LL:
                                GLMast.Account," - ",GLMast.Desc:
                                ":":
                                *boldoff:
                                *alignment=*decimal:
                                *BlankOn:
                                *p=555:(PrintLineCnt + 5),GLTotalsDb:
                                *p=635:(PrintLineCnt + 5),GLTotalsCr:
                                *p=715:(PrintLineCnt + 5),GLTotalsNet:
                                *p=739:(PrintLineCnt + 5),TotalType:
                                *BlankOff:
                                *boldon:
                                *boldoff

.
              ADD               DoubleLine,PrintLineCnt
              RETURN
.=============================================================================
PrintTotals
                EndOfPage
              if                (ReportTotalsNet < 0)
                multiply                  "-1",ReportTotalsNet
                move                      "Cr",TotalType
              else
                clear                     TotalType
              endif

                PRTPAGE           P;*font=SubLineFont:
                                 *alignment=*left:
                                 *Pensize=1:
                                 *p=30:(PrintLineCnt - 2):
                                 *Line=800:(PrintLineCnt - 2):
                                 *p=30:(PrintLineCnt - 4):
                                 *Line=800:(PrintLineCnt - 4):
                                 *font=SubLineFont:
                                 *alignment=*left:
                                 *boldon:
                                 *p=155:PrintLineCnt,"A/P Distribution Totals :":
                                 *alignment=*decimal:
                                 *BlankOn:
                                 *boldon:
                                 *p=555:(PrintLineCnt),ReportTotalsDb:
                                 *p=635:(PrintLineCnt),ReportTotalsCr:
                                 *p=715:(PrintLineCnt),ReportTotalsNet:
                                 *p=743:(PrintLineCnt),TotalType:
                                 *boldoff

              ADD               (SingleLine),PrintLineCnt

              ADD               (DoubleLine * 2),PrintLineCnt
              PRTPAGE           P;*font=DetailFont,*boldon:
                                "Total A/P Distributions Processed :":                        //HR 6/5/2003
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
                                  *font=DetailFont:
                                  *BoldOn:
                                  *p=170:PrintLineCnt,"Report Parameters : ":
                                  "Date Range - ",PrtFromDate," - ":
                                  PrtToDate:
                                  *BoldOff
                ADD               SingleLine,PrintLineCnt

              if                       (Phase = 1)
                IF                (PrintDetails = 1)
                  PRTPAGE           P;*alignment=*left:
                                    *font=SubLineFont:
                                    *p=035:PrintLineCnt,"Vendor":
                                    *p=090:PrintLineCnt,"Check":
                                    *p=160:PrintLineCnt,"Vendor Name":
                                    *p=425:PrintLineCnt,"Check Date":
                                    *p=515:PrintLineCnt,"Debit Amt":
                                    *p=600:PrintLineCnt,"Credit Amt":
                                    *p=685:PrintLineCnt,"Net Amt"
                  ADD               SingleLine,PrintLineCnt
              ELSE
                  PRTPAGE           P;*alignment=*left:
                                    *font=SubLineFont:
                                    *p=030:PrintLineCnt,"G/L Code":
                                    *p=115:PrintLineCnt,"G/L Description":
                                    *p=425:PrintLineCnt,"Check Date":
                                    *p=515:PrintLineCnt,"Debit Amt":
                                    *p=600:PrintLineCnt,"Credit Amt":
                                    *p=685:PrintLineCnt,"Net Amt"
                  ADD               SingleLine,PrintLineCnt
                ENDIF
              else
                PRTPAGE           P;*alignment=*left:
                                  *font=SubLineFont:
                                  *p=040:PrintLineCnt,"Check No":
                                  *p=120:PrintLineCnt,"Vendor Name":
                                  *p=400:PrintLineCnt,"Vendor No":
                                  *p=495:PrintLineCnt,"Check Date":
                                  *p=702:PrintLineCnt,"Check Amt"
                ADD               SingleLine,PrintLineCnt
              endif

              RETURN
;==========================================================================================================
CreateTempAPDist
                    prep               APDistTemp,"APDistTemp.txt","APDistTemp.ISI","1-8,31-38,9-16,23-30,40-46,171-173","190"
                    open               APDistTemp,"APDistTemp.isi",Exclusive
                    PACKKEY           CheckKY3 FROM $Entity,FromDate,"   "
                    CALL              PrintHeader
                    CALL              RDCheck3
                    LOOP
                      CALL              KSCheck3
                    UNTIL             (ReturnFL = 1 or Check.CheckDate > ToDate)

                      continue          if (Check.VoidedFlag = 1)                            //HR 2019.3.13
                      PACKKEY           CheckDetailKY FROM $Entity,Check.BankCode,Check.CheckNo,Check.SeqMajor
                      CALL              RDCheckDetail
                      LOOP
                        CALL              KSCheckDetail
                      UNTIL             (ReturnFl = 1 or Check.CheckNo != CheckDetail.CheckNo)
                        continue           if (Check.Vendor != CheckDetail.Vendor)

                        packkey            APDistKY3 from Check.Entity,CheckDetail.Voucher
                        call               RDAPDist3
                        loop
                          call               KSAPDist3
                        until              (ReturnFl = 1 or APDist.SeqMajor != CheckDetail.Voucher)
                        continue             if (APDist.GLCode = "2101    " or:
                                                 APDist.GLCode = "1101    " or:
                                                 APDist.GLCode = "2401    ")

                          move               Check.CheckNo,APDist.CheckNo
                          move               Check.CheckDate,APDist.TransDate
                          write              APDistTemp;APDist
                        repeat
                      repeat
                    repeat
                    return
;==========================================================================================================
PrintCheckRecap
CheckTemp           ifile
CheckTempKey        dim                10

                    move               "2",Phase
                    prep               CheckTemp,"CheckTmp.txt","CheckTmp.isi","-d,29-38","190",Exclusive
                    call               PrintHeader
                    packkey           CheckKY3 FROM $Entity,FromDate,"   "
                    call              RDCheck3
                    LOOP
                      CALL              KSCheck3
                    UNTIL             (ReturnFL = 1 or Check.CheckDate > ToDate)
                      continue          if (Check.VoidedFlag = 1)                            //HR  2019.3.13

                      write              CheckTemp;Check
                    repeat

                    move               " ",CheckTempKey
                    read               CheckTemp,CheckTempKey;;
                    loop
                      readks             CheckTemp;Check
                    until (over)
                      call               PrintCheckInfo
                    repeat
;
;  Print Check Totals
                    PRTPAGE           P;*alignment=*left:
                                      *Pensize=1:
                                      *p=30:(PrintLineCnt - 2):
                                      *Line=800:(PrintLineCnt - 2):
                                      *font=DetailFont:
                                      *boldon:
                                      *p=500:(PrintLineCnt),"Check Totals: ":
                                      *alignment=*decimal:
                                      *p=740:PrintLineCnt,CheckTotals
                    return

;==========================================================================================================
PrintCheckInfo
                    MOVE              Check.Vendor,VendorKY

                    CALL              RDVendor

                    CHOP               Vendor.City,Vendor.City
                    PACK               CityState,Vendor.City,", ",Vendor.State,"  ",Vendor.Zip

                    EndOfPage

                    add                Check.CheckAmount,CheckTotals
                    UNPACK             Check.CheckDate into CC,YY,MM,DD
                    PACKKEY            PrintCheckDate FROM MM,"/",DD,"/",YY

                    PrtPage            P;*font=DetailFont:
                                       *boldon:
                                       *alignment=*decimal:
                                       *p=090:PrintLineCnt,Check.CheckNo:                  //Vendor.AccountNumber:
                                       *alignment=*left:
                                       *p=120:PrintLineCnt,Vendor.Name:
                                       *boldoff:
                                       *alignment=*left:
...                                       *p=365:PrintLineCnt,Check.CheckNo:
                                       *p=415:PrintLineCnt,Vendor.AccountNumber:
                                       *p=498:PrintLineCnt,PrintCheckDate:
                                       *alignment=*decimal:
.                                       *p=560:PrintLineCnt,Check.GrossAmount:
.                                       *p=640:PrintLineCnt,Check.DiscAmt:
                                       *p=740:PrintLineCnt,Check.CheckAmount
                    ADD                SingleLine,PrintLineCnt
                    return




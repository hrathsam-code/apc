;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    4 NORFOLK LANE                                           ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    PRTVHST.PLS                                                    ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    01/03/2006 AT 12:15PM                                          ;
;                                                                             ;
;  PURPOSE:    Print Vendor Purchase Analysis                                 ;
;                                                                             ;
; REVISION:    VER     DATE     INIT       DETAILS                            ;
;                                                                             ;
;              1.0   01/03/2006   HOR     INITIAL VERSION                     ;
;                                                                             ;
;=============================================================================;
.

ToDate        DIM               8
FromDate      DIM               8
ItemCount     FORM              6
TransDate     DIM               8
DueDate       DIM               8
DiscDate      DIM               8
HoldFlag      DIM               1
SearchMethod  FORM              1
DispDate      DIM               8

PrintFromDate DIM               8          //HR 1/7/2005
PrintToDate   DIM               8          //HR 1/7/2005


AgingDays     FORM              3
CityState     DIM               42
VDiscTotal    Form              10.2
GTDiscTotal   Form              10.2
GTBalance     form              10.2
...GTPurchAmt     FORM              10.02
GTPurchAmt     FORM              10.2
GTPaidAmt    FORM              10.2
GTDiscAmt    FORM               10.2

GTPaidAmtD    DIM               15
GTPurchAmtD   DIM               15
GTDiscAmtD    DIM               15

AtLeastOne    DIM               1
AllCustFlag   FORM              1
FromVendor  DIM               6
SavedVendor DIM               6
SortedBy      FORM              1
PrintDetails  FORM              1
VendorOrigAmt   FORM              8.2
VendorBalance   FORM              8.2
VendorPaymentCount FORM           6
VendorInvoiceCount FORM           6
VendorDiscountCount FORM          6

VendorPaymentTotal FORM           6
VendorInvoiceTotal FORM           6
VendorDiscountTotal FORM          6

VendorPurchAmt  FORM              8.2
VendorPaidAmt   FORM              8.2
VendorDiscAmt   FORM              8.2

PurchAmt           DIM               13
PaidAmt            DIM               13
DiscAmt            DIM               13

ExcelFilePath      DIM               100
ExcelFileName      DIM               50
ExcelFile          DIM               200

ExcelRow           FORM              7
Excel              AUTOMATION
WorkBooks          AUTOMATION
WorkBook           AUTOMATION
WorkBookSheet      AUTOMATION
ExcelWorkSheet     AUTOMATION


AllCollection COLLECTION


           GOTO              #S
           INCLUDE           WORKVAR.INC
           INCLUDE           APDet.FD
           INCLUDE           APCTL.FD
           INCLUDE           CMPNY.FD
           INCLUDE           StateTbl.TXT
           INCLUDE           CUST.FD

           INCLUDE              Vendor.FD
.           INCLUDE           VSTAT.FD
           INCLUDE           PrintRtn.INC
PRTVHST    PLFORM            PRTVHST.PLF
#S
STARTPGM      routine
           WINHIDE

;
; Create the Excel object
;
                     Create            Excel,Class="Excel.Application"
                     GetProp           Excel,*Workbooks=WorkBooks

                     WorkBooks.Add     Giving WorkBook

                     SETPROP           WorkBook.WorkSheets(1).Columns("A:B"),*Numberformat="@"
                     SETPROP           WorkBook.WorkSheets(1).Columns("C:C"),*Numberformat="###0.00"

                     SETPROP           WorkBook.Worksheets(1).Cells(1,"A"),*Value="Vendor ID"
                     SETPROP           WorkBook.Worksheets(1).Cells(1,"B"),*Value="Vendor Name"
                     SETPROP           WorkBook.Worksheets(1).Cells(1,"C"),*Value="Purchases"
                     SETPROP           WorkBook.Worksheets(1).Cells(1,"D"),*Value="Payments"

.                     SETPROP           WorkBook.Worksheets(1).Cells(1,"D"),*Value="Customer Source"
.                     PACK              AlertString FROM YearlyBucket(1)," Sales"
.                     SETPROP           WorkBook.Worksheets(1).Cells(1,"E"),*Value=AlertString
.                     PACK              AlertString FROM YearlyBucket(2)," Sales"
.                     SETPROP           WorkBook.Worksheets(1).Cells(1,"E"),*Value=AlertString
.                     SETPROP           WorkBook.Worksheets(1).Cells(1,"F"),*Value="Percentage Change"
.                     SETPROP           WorkBook.Worksheets(1).Cells(1,"G"),*Value="Dollar Change"
.                     PACK              AlertString FROM YearlyBucket(3)," Sales"
.                     SETPROP           WorkBook.Worksheets(1).Cells(1,"H"),*Value=AlertString
.                     SETPROP           WorkBook.Worksheets(1).Cells(1,"I"),*Value="New Customer?"
                     MOVE              "1",ExcelRow


           LISTINS           AllCollection,EVendor,BVendor

           FORMLOAD          PRTVHST

           SETITEM           CBPrintBy,0,2

           CLOCK                DATE,TODAY8
           SETPROP              DTFromDate,text=Today8
           SETPROP              DTToDate,text=TODAY8

           SETITEM           CBPrintOptions,0,2

           LOOP
             WAITEVENT
           REPEAT
           STOP
.
. We'll never get to this spot!!
.....................................................
StartPrint
;
; Create the Excel object
;
                     Create            Excel,Class="Excel.Application"
                     GetProp           Excel,*Workbooks=WorkBooks

                     WorkBooks.Add     Giving WorkBook

                     SETPROP           WorkBook.WorkSheets(1).Columns("A:B"),*Numberformat="@"
                     SETPROP           WorkBook.WorkSheets(1).Columns("C:E"),*Numberformat="###0.00"
                     SETPROP           WorkBook.WorkSheets(1).Columns("F:G"),*Numberformat="###0"

                     SETPROP           WorkBook.Worksheets(1).Cells(1,"A"),*Value="Vendor Code"
                     SETPROP           WorkBook.Worksheets(1).Cells(1,"B"),*Value="Vendor Name"
                     SETPROP           WorkBook.Worksheets(1).Cells(1,"C"),*Value="Purchases"
                     SETPROP           WorkBook.Worksheets(1).Cells(1,"D"),*Value="Payments"
                     SETPROP           WorkBook.Worksheets(1).Cells(1,"E"),*Value="Discounts"
                     SETPROP           WorkBook.Worksheets(1).Cells(1,"F"),*Value="# of Invoices"
                     SETPROP           WorkBook.Worksheets(1).Cells(1,"G"),*Value="# of Checks"

                     MOVE              "1",ExcelRow


                   MOVE              "Accounts Payble History Report",ReportTitle

                   GETITEM           CBPrintBy,0,SearchMethod
                   GETITEM           CBPrintOptions,0,PrintDetails

                   getprop              DTFromDate,text=FromDate
                   UNPACK               FromDate,CC,YY,MM,DD

                   PACKKEY              PrintFromDate FROM MM,slash,DD,slash,YY
                   REPLACE              " 0",PrintFromDate

                   getprop              DTToDate,text=ToDate
                   UNPACK               ToDate,CC,YY,MM,DD

                   PACKKEY            PrintToDate FROM MM,slash,DD,slash,YY

                   OPEN                 VendorFLST,READ
                   OPEN                 APDetFLST,READ

                   CALL              OPENCMPNY
                   CALL              OpenAPCTL
                   INCLUDE           Temporary.inc

                   CALL              PrintInit
                   return               if (printInitFailed = "N")

                   MOVE              "",VendorKY

                   GETITEM           EVendor,0,VendorKY

                   IF                (SearchMethod = 1)           //By Vendor ID
                     CALL              RDVendor
                   ELSE
                     PACKKEY           VendorKY FROM "          "     //By Vendor Name
                   CALL              RDVendor2
                   ENDIF

                   CALL              PrintHeader
                   LOOP
                     IF                (SearchMethod = 2)           //By Vendor Name
                       CALL              KSVendor2
                     ELSE
                       IF               (VendorKY != "")
                       ELSE
                         CALL               KSVendor
                       ENDIF
                     ENDIF
                   UNTIL             (Returnfl = 1)
                     MOVE               "0",VendorOrigAmt
                     MOVE               "0",VendorBalance
                     MOVE               "0",VendorPaymentCount
                     MOVE               "0",VendorInvoiceCount
                     MOVE               "0",VendorDiscountCount
                     MOVE               "0",VendorPurchAmt
                     MOVE               "0",VendorDiscAmt

                     Move              "0",VDiscTotal
                      CALL              PrintDetails
                      IF                (AtLeastOne = "Y")         //Nothing open..Don't print totals
                        CALL              PrintVendorTotals
                        ADD               "1",ItemCount
                      ENDIF
                      BREAK             IF (SearchMethod = 1)       //Only do a single Vendor
                   REPEAT

                   CALL              PrintTotals
                   CALL              PrintClose

                   GETFNAME                 PREP,"Select Excel Output Filename to Create":
                                            ExcelFileName,ExcelFilePath
                   IF                       NOT OVER
                     PACK                     ExcelFile FROM ExcelFilePath,ExcelFileName
                     WorkBook.SaveAs          Using ExcelFile
                   ENDIF
                   Excel.Quit

                   GOTO              ExitProgram

PrintLine
           if                   (PrintDetails != "3" and PrintDetails != 2)

             CHOP              Vendor.City,Vendor.City
             PACK              CityState,Vendor.City,", ",Vendor.State,"  ",Vendor.Zip
             EndOfPage

             PrtPage           P;*font=DetailFont:
                               *alignment=*left:
                               *boldon:
                               *p=020:PrintLineCnt,Vendor.AccountNumber:
                               *p=150:PrintLineCnt,Vendor.Name:
                               *alignment=*decimal:
                               *font=SubLineFont:
                               *boldon:
                               *boldoff

             ADD               SingleLine,PrintLineCnt
..HR 4/30/03           CALL              PrintDetails
              ENDIF

           RETURN

PrintDetails
           MOVE              "N",AtLeastOne

           PACKKEY           APDetKY4,$Entity,Vendor.AccountNumber,FromDate
.           RESET             APDetKY2
.
. Read through all of the Transactions looking for 'Open' transactions
. only.  'Open' transactions are records that don't have a Zero balance.
.
           CALL              RDAPDet4
           LOOP
             CALL              KSAPDet4
           UNTIL             (Returnfl = 1 or APDetail.Vendor != Vendor.AccountNumber or APDetail.PostDate > ToDate)
.             CONTINUE           IF (APDet.APDetDate > ToDate or APDet.APDetDate < FromDate) //HR 4/15/2005  Added FromDate Logic)

             CONTINUE           if (APDetail.TransCode != 7 and APDetail.TransCode != 0 and APDetail.TransCode != 6)

             SWITCH             APDetail.TransCode

             CASE               7                                      //Check Code
               ADD                "1",VendorPaymentCount
               ADD                "1",VendorPaymentTotal
               add                APDetail.Amount,GTPaidAmt
               ADD                APDetail.Amount,VendorOrigAmt
             CASE              0                                       //Invoice Code
               ADD                "1",VendorInvoiceCount
               ADD                "1",VendorInvoiceTotal
               add                APDetail.Amount,GTPurchAmt
               ADD                APDetail.Amount,VendorPurchAmt
             CASE              6                                       //Discount Code
               ADD                "1",VendorDiscountCount
               ADD                "1",VendorDiscountTotal
               add                APDetail.Amount,GTDiscAmt
               ADD                APDetail.Amount,VendorDiscAmt
             ENDSWITCH

             IF                (AtLeastOne = "N")
               CALL              PrintLine
               MOVE              "Y",AtLeastOne
             ENDIF


.           unpack            APDet.DueDate,CC,YY,MM,DD
.           PACK              DueDate FROM MM,"/",DD,"/",YY

.           unpack            APDet.DiscDate,CC,YY,MM,DD
.           IF                (APDet.DiscDate = "        ")
.             MOVE              "     ",DiscDate
.           ELSE
.             PACK              DiscDate FROM MM,"/",DD,"/",YY
.           ENDIF

           MOVE              " ",HoldFlag

.           Add                APDetail.DiscAmt,VDiscTotal
.           Add                APDetail.DiscAmt,GTDiscTotal
.           add                APDet.Balance,GTBalance

.           ADD                APDet.Balance,VendorBalance

           if                   (PrintDetails = "1")
.             IF                 (AtleastOne = "Y")
.               CALL              PrintLine
.             ENDIF

             EndOfPage

.             UNPACK             APDet.EntryDate into CC,YY,MM,DD
             PACKKEY            DispDate FROM MM,"/",DD,"/",YY

             PrtPage           P;*alignment=*left:
                               *font=SubLineFont:
                               *p=040:PrintLineCnt,APDetail.ReferenceNo:           //12
.                               *p=165:PrintLineCnt,APDetail.PO:          //12
                               *alignment=*decimal:
                               *p=540:PrintLineCnt,APDetail.Amount:
                               *alignment=*left:
                               *p=605:PrintLineCnt,APDetail.PostDate:
                               *alignment=*decimal:
.                               *p=700:PrintLineCnt,APDetail.Balance:
                               *p=740:PrintLineCnt,"   ":
                               *alignment=*left:
                               *boldon:
                               *p=750:PrintLineCnt,HoldFlag:
                               *boldoff

             ADD               SingleLine,PrintLineCnt
           ENDIF

           REPEAT
           RETURN

.=============================================================================
. Print the Totals for each Vendor
.=============================================================================
PrintVendorTotals
                   CHOP              Vendor.AccountNumber,Vendor.AccountNumber
                   MOVE                 VendorOrigAmt,VendorPaidAmt
                   SUBTRACT             VendorBalance,VendorPaidAmt

                   IF                   (VendorPurchAmt != 0)
                     EDIT                 VendorPurchAmt,PurchAmt,Mask="$Z,ZZZ,ZZZ.99"
                   ELSE
                     CLEAR                PurchAmt
                   ENDIF

                   IF                   (VendorOrigAmt != 0)
                     EDIT                 VendorOrigAmt,PaidAmt,Mask="$Z,ZZZ,ZZZ.99"
                   ELSE
                     CLEAR               PaidAmt
                   ENDIF

                   IF                   (VendorDiscAmt != 0)
                     EDIT                 VendorDiscAmt,DiscAmt,Mask="$Z,ZZZ,ZZZ.99"
                   ELSE
                     CLEAR              DiscAmt
                   ENDIF

                   INCR              ExcelRow
                   SETPROP           WorkBook.Worksheets(1).Cells(ExcelRow,"A"),*Value=Vendor.AccountNumber
                   SETPROP           WorkBook.Worksheets(1).Cells(ExcelRow,"B"),*Value=Vendor.Name
                   SETPROP           WorkBook.Worksheets(1).Cells(ExcelRow,"C"),*Value=VendorPurchAmt
                   SETPROP           WorkBook.Worksheets(1).Cells(ExcelRow,"D"),*Value=VendorOrigAmt
                   SETPROP           WorkBook.Worksheets(1).Cells(ExcelRow,"E"),*Value=DiscAmt
                   SETPROP           WorkBook.Worksheets(1).Cells(ExcelRow,"F"),*Value=VendorInvoiceCount
                   SETPROP           WorkBook.Worksheets(1).Cells(ExcelRow,"G"),*Value=VendorPaymentCount

                   RETURN               IF (PrintDetails = 3)      //Report Grand Totals Only!!!

                   IF                (PrintDetails = 1)
                     PRTPAGE           P;*font=SubLineFont:
                                       *alignment=*left:
                                       *Pensize=1:
                                       *p=30:(PrintLineCnt - 2):
                                       *Line=760:(PrintLineCnt - 2)
                   ENDIF


                   EndOfPage
                   PrtPage           P;*font=SubLineFont:
                                     *alignment=*left:
                                     *p=20:PrintLineCnt,Vendor.AccountNumber:
                                     *p=80:PrintLineCnt,Vendor.Name:
                                     *alignment=*decimal:
                                     *p=410:PrintLineCnt,VendorInvoiceCount:
                                     *p=480:PrintLineCnt,VendorPaymentCount:
                                     *p=560:PrintLineCnt,PurchAmt:
                                     *p=640:PrintLineCnt,PaidAmt:
                                     *p=720:PrintLineCnt,DiscAmt
....                             *p=640:PrintLineCnt,VendorPurchAmt:
....                             *p=720:PrintLineCnt,VendorOrigAmt
.
                   IF                (PrintDetails != 2)
                     ADD               DoubleLine,PrintLineCnt
                   ELSE
                     ADD               SingleLine,PrintLineCnt
                   ENDIF
                   RETURN

PrintTotals
                   IF                   (GTPurchAmt != 0)
                     EDIT                 GTPurchAmt,GTPurchAmtD,Mask="$ZZZ,ZZZ,ZZZ.99"
                   ELSE
                     CLEAR                GTPurchAmtD
                   ENDIF

                   IF                   (GTPaidAmt != 0)
                     EDIT                 GTPaidAmt,GTPaidAmtD,Mask="$ZZZ,ZZZ,ZZZ.99"
                   ELSE
                     CLEAR               GTPaidAmtD
                   ENDIF

                   IF                   (GTDiscAmt != 0)
                     EDIT                 GTDiscAmt,GTDiscAmtD,Mask="$ZZZ,ZZZ,ZZZ.99"
                   ELSE
                     CLEAR              GTDiscAmtD
                   ENDIF

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
                                     *p=155:PrintLineCnt,"Report Totals :":
                                     *alignment=*decimal:
                                     *boldoff:
                                     *p=410:PrintLineCnt,VendorInvoiceTotal:
                                     *p=480:PrintLineCnt,VendorPaymentTotal:
                                     *p=560:PrintLineCnt,GTPurchAmtD:
                                     *p=640:PrintLineCnt,GTPaidAmtD:
                                     *p=720:PrintLineCnt,GTDiscAmtD
.                             *p=640:PrintLineCnt,GTPurchAmt:
.                             *p=720:PrintLineCnt,GTPaidAmt

                   ADD               (SingleLine),PrintLineCnt

                   ADD               (DoubleLine * 2),PrintLineCnt
                   PRTPAGE           P;*font=DetailFont,*boldon:
                                     *HA=40,"Total Vendors Printed :":
                                     *alignment=*left:
                                     ItemCount:
                                     *boldoff
                   RETURN
.
ExitProgram
..fuckup              NORETURN
..fuckup              NORETURN
                   winshow
...FUBAR              CHAIN             FROMPGM
                   STOP
.=============================================================================
PrintCustomHeader
              PRTPAGE           P;*alignment=*left:
                                *font=SubLineFont:
                                *p=018:PrintLineCnt,"Code":
                                *P=105:PrintLineCnt,"Vendor Name":
                                *boldon:
                                *p=200:PrintLineCnt,"Date Range : ",*BoldOff,PrintFromDate:
                                *boldoff:
                                " - ",PrintToDate:
                                *p=375:PrintLineCnt,"Invoices":
                                *p=448:PrintLineCnt,"Checks":
                                *p=530:PrintLineCnt,"Purchases":
                                *p=610:PrintLineCnt,"Payments":
                                *p=690:PrintLineCnt,"Discounts"
              ADD               SingleLine,PrintLineCnt
              RETURN

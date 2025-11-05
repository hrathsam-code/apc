;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    4 NORFOLK LANE                                           ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    PRTAGEAP.PLS                                                   ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    07/01/2005 AT 1:28PM                                           ;
;                                                                             ;
;  PURPOSE:    Print Accounts Payable Aging Report                            ;
;                                                                             ;
; REVISION:    VER     DATE     INIT       DETAILS                            ;
;                                                                             ;
;              1.0   07/01/2005   HOR     INITIAL VERSION                     ;
;              1.4   04/05/2006   HOR     Modified Aging Dates in PLF         ;
;              1.4   04/06/2006   HOR     Re-Modified Aging Dates in PLF      ;
;                                                                             ;
;=============================================================================;
.
              INCLUDE           NCOMMON.TXT
              INCLUDE           WORKVAR.INC

..HR 2017.4.24 PLBWebServer  EQUATE            1
ItemCount  FORM              6
TransDate  DIM               8
DueDate    DIM               8
DiscDate   DIM               8
HoldFlag   DIM               8       //HR 3/24/2008  Was 1
AgingDays  FORM              3
AGINGDAYSD dim               3
CityState  DIM               42
Days       FORM              10
....  TodayDays  FORM              10
AgingDaysW FORM              10
Bucket     FORM              1
BucketDays FORM                 3(7)
BucketDaysD DIM                 3
AgingAmt   FORM              7.2(7)            //Buckets 1 - 4, 5 = Totals for Vendors
MinBalanceD   DIM               10
MinBalance    FORM              7.2
SortedBy      FORM              1
AtleastOne    DIM               1
VendorPrinted   DIM               1
ASTER45  INIT      "*********************************************"

AutoPayFlag         dim                3
Heading       DIM               12(7)
StartingDays  FORM              2
EndingDays    FORM              2

AllVendFlag   FORM              1
FromVendor  DIM               6
ToVendor    DIM               6
PrintDetails  FORM              1

AgingTotals FORM             10.2(7)   1=Current, 2=30-59, 3=60-89, 4=90 +
CustAging  FORM              10.2(7)          //1 = Details, 2 = Cust Totals, 3 = Report Totals Only
TempFile   IFILE
Aging
AllCollection COLLECTION

X                   form               6
VendorCount       form               6
VendExcludeKY       dim                6
VendorAcct          dim                6

VendExcludeFile     ifile

.
           GOTO              #S
           INCLUDE           APTRN.FD
           INCLUDE           CMPNY.FD
           INCLUDE           Vendor.FD
           include           Sequence.FD
           INCLUDE           VHST.FD
           INCLUDE           PrintRtn.INC

PrtAgeAP      PLFORM            PrtAgeAP
FSelectCustomers    plform             PrtAgeAR2.PLF
IgnoreVendors       form               1

#S
STARTPGM      routine
              winhide
              LISTINS           AllCollection,EFromVendor,EToVendor,BVendorFrom,BVendorTo
              MOVE              "Y",PrintGuiMode

              FORMLOAD          PrtAgeAP
                    formload                 FSelectCustomers

.              open                     VendExcludeFile,"VendExclude"

.                    read               VendExcludeFile,VendExcludeKY;;
.                    loop
.                      readks             VendExcludeFile;VendorAcct
.                    until (over)
.                      move              VendorAcct,VendorKY
.                      call              RDVendor
.                      pack              DataLine from VendorAcct,";",Vendor.Name
.                      LVCustList.SetItemTextAll using *Index=0,*Text=DataLine,*Delimiter=";"
.                    repeat


              SETITEM           CBPrintOptions,0,1

              LOOP
                WAITEVENT
              REPEAT
              STOP
.
. We never get to this point above
.......................................

StartPrint
              SETMODE           *MCURSOR=*Wait

           MOVE              "Y",FirstFlag
           MOVE              "Accounts Payable Aging Report",ReportTitle

           CLOCK             timestamp to DATE8
           CALL              ConvDateToDays using DATE8,TodayDays


              OPEN              VendorFLST,READ
              OPEN              VHSTFLST,READ
              OPEN              APTRNFLST,READ
           CALL              OPENCMPNY

           CALL               PrintPreviewInit

           RETURN             IF (printInitFailed = "N")
           CALL               PrintLandScapeMode

           GETITEM              EBucket1,0,BucketDaysD
           MOVE                 BucketDaysD,BucketDays(1)

           GETITEM              EBucket2,0,BucketDaysD
           MOVE                 BucketDaysD,BucketDays(2)

           GETITEM              EBucket3,0,BucketDaysD
           MOVE                 BucketDaysD,BucketDays(3)

.          GETITEM              EBucket4,0,BucketDaysD
.          MOVE                 BucketDaysD,BucketDays(4)

.          GETITEM              EBucket5,0,BucketDaysD
.          MOVE                 BucketDaysD,BucketDays(5)

           GETITEM              EMinimumBalance,0,MinBalanceD
           MOVE                 MinBalanceD,MinBalance

              GETITEM           CBSortedBy,0,SortedBy
              GETITEM           CBPrintOptions,0,PrintDetails

              MOVE              BucketDays(1),EndingDays

              PACKKEY           Heading(1),"1"," - ",EndingDays," Days"

              MOVE              BucketDays(1),StartingDays
              ADD               "1",StartingDays
              MOVE              BucketDays(2),EndingDays

              PACKKEY           Heading(2),StartingDays," - ",EndingDays," Days"

              MOVE              BucketDays(2),StartingDays
              ADD               "1",StartingDays
              MOVE              BucketDays(3),EndingDays

              PACKKEY           Heading(3),StartingDays," - ",EndingDays," Days"

              MOVE              BucketDays(3),StartingDays
              ADD               "1",StartingDays
.             MOVE              BucketDays(4),EndingDays

.             PACKKEY           Heading(4),StartingDays," - ",EndingDays," Days"

.             MOVE              BucketDays(4),StartingDays
.             ADD               "1",StartingDays
.             MOVE              BucketDays(5),EndingDays

.             PACKKEY           Heading(5),StartingDays," - ",EndingDays," Days"

.             MOVE              BucketDays(5),EndingDays
              SUBTRACT          "1",EndingDays

              PACKKEY           Heading(4),"Over",BucketDays(3)," Days"

              MOVE              "Totals",Heading(5)

           GETITEM           RAllVendors,0,AllVendFlag
           IF                (AllVendFlag = 0)
             GETITEM           EFromVendor,0,FromVendor
             GETITEM           EToVendor,0,ToVendor

           ENDIF
           MOVE              " ",VendorKY

           IF                  (AllVendFlag = 0)
             MOVE                 FromVendor,VendorKY
           ENDIF

              IF                (SortedBy = 2)           //By Vendor ID
                CALL              RDVendor
              ELSE
                MOVE              "        ",VendorKY2     //By Vendor Name
                CALL              RDVendor2
              ENDIF

           IF                   (PrintGuiMode = "Y")
             CALL              PrintHeader
           ELSE
             CALL              PrintTextHeader
           ENDIF


           LOOP
             IF                (SortedBy = 2)           //Vendor ID
               IF               (ReturnFL = 1 or FirstFlag = "N")
                 CALL              KSVendor
               ENDIF
             ELSE
               CALL              KSVendor2
             ENDIF
           UNTIL             (Returnfl = 1)
             if                 (Vendor.AutoDisburse = 1)
               move               "Yes",AutoPayFlag
             else
               clear              AutoPayFlag
             endif

             BREAK              IF (AllVendFlag = 0 AND SortedBy = 2 AND Vendor.AccountNumber > ToVendor)
             CONTINUE           IF (AllVendFlag = 0 and SortedBy = 1 and Vendor.AccountNumber > ToVendor)

.             move               Vendor.AccountNumber,VendExcludeKY
.             read               VendExcludeFile,VendExcludeKY;;
.             continue           if (not over AND IgnoreVendors = 1)         //W've found a Customer Number, ignore it as per David????


             MOVE               "N",VendorPrinted
             MOVE               "N",FirstFlag
             MOVE              "0",CUSTAging
             PACKKEY           VHSTKY,$Entity,Vendor.AccountNumber
             CALL              RDVHST

             CALL              PrintDetails
           REPEAT

           CALL              PrintTotals
           SETMODE           *MCURSOR=*Wait

           IF                (PrintGuiMode = "Y")
             CALL              PrintClose
           ENDIF


           GOTO                 ExitProgram
;==========================================================================================================
PrintLine
           IF                   (VendorPrinted = "N")
             CHOP              Vendor.City,Vendor.City
             PACK              CityState,Vendor.City,", ",Vendor.State,"  ",Vendor.Zip
             IF                 (PrintGuiMode = "Y")

               EndOfPage

               PrtPage           P;*font=DetailFont:
                                 *alignment=*left:
                                 *boldon:
                                 *p=020:PrintLineCnt,Vendor.AccountNumber:
                                 *p=110:PrintLineCnt,Vendor.Name:
                                 *alignment=*decimal


               ADD               SingleLine,PrintLineCnt
             ENDIF

             MOVE              "Y",VendorPrinted
           ENDIF

           RETURN
;==========================================================================================================
SelectCustomers
                    setfocus           ECustCode
                    setprop            WCustList,visible=1

                    return
;==========================================================================================================
MainSaveCust

                    move               " ",VendExcludeKY
                    read               VendExcludeFile,VendExcludeKY;;
                    loop
                      readks             VendExcludeFile;VendorAcct
                    until (over)
                      delete             VendExcludeFile
                    repeat

                    display            "Got here"
                    LVCustList.GetItemCount giving VendorCount
                    if                 (VendorCount > 0)
                      for                 X from "0" to (VendorCount - 1) using "1"
                        LVCustList.GetItemText giving VendorAcct using *Index=X
                        display            "CustomerID : ",VendorAcct
                        move               VendorAcct,VendExcludeKY
                        read               VendExcludeFile,VendExcludeKY;;
                        if                 (over)
                          write              VendExcludeFile,VendExcludeKY;VendorAcct
                        endif
                      repeat
                    endif

                    setprop            WCustList,visible=0
                    return
;==========================================================================================================
MainExit2
                    setprop            WCustList,visible=0
                    return
;==========================================================================================================
SaveCustomer
                    getprop            ECustCode,text=VendorKY
                    return             if (VendorKY = "")
                    call               RDVendor
                    if                 (ReturnFl = 1)
                      beep
                      alert              stop,"Invalid Vendor Number Entered",result,"ERROR: INVALID VENDOR"
                    else
                      pack               DataLine from Vendor.AccountNumber,";",Vendor.Name
                      LVCUstList.SetItemTextAll using *Index=9999:
                                                      *Text=DataLine:
                                                      *Delimiter=";"
                    endif
                    setprop            EcustCode,text=""
                    setfocus           ECustCode
                    return
;==========================================================================================================
OnClickSelectCustomers
                    IfChecked          CXSelectCustomers
                      setprop            CXSelectCustomers,value=0
                      setprop            BSelect,visible=0
                    else
                      setprop            CXSelectCustomers,value=1
                      setprop            BSelect,visible=1
                    endif
                    return
;==========================================================================================================
Change_ECustCode
                    READAHEAD          ECustCode,Vendor,AccountNumber
                    RETURN
.===============================================================================
KeyPress_ECustCode
                    F2SEARCH           ECustCode,Vendor
                    IF                  (PassedVar = "Y")

                    ENDIF
                    RETURN
;==========================================================================================================
ClearCustList
                    alert              Plain,"Are you sure you want to delete this list",result,"DELETE VENDORS?"
                    if                 (result = 1)
                      LVCustList.DeleteAllItems
                    endif
                    return
;==========================================================================================================

.=============================================================================
. Calculate the Proper Aging Buckets
.
CalculateAging
.
           MOVE              "0",AgingAmt
           unpack            APTRN.TransDate,CC,YY,MM,DD
           PACK              DATE8,CC,YY,MM,DD
                    CALL              ConvDateToDays using DATE8,Days

                    SUBTRACT          Days,TodayDays,AgingDaysW

           IF                (AgingDaysW <= BucketDays(1))
             MOVE              "1",Bucket
           ENDIF

           IF                (AgingDaysW >= (BucketDays(1) + 1) and AgingDaysW <= BucketDays(2))
             MOVE              "2",Bucket
           ENDIF

           IF                (AgingDaysW >= (BucketDays(2) + 1) and AgingDaysW <= BucketDays(3))
             MOVE              "3",Bucket
           ENDIF

.          IF                (AgingDaysW >= (BucketDays(3) + 1) and AgingDaysW <= BucketDays(4))
.            MOVE              "4",Bucket
.          ENDIF

.          IF                (AgingDaysW >= (BucketDays(4) + 1) and AgingDaysW <= BucketDays(5))
.            MOVE              "5",Bucket
.          ENDIF

           IF                (AgingDaysW > BucketDays(3))
             MOVE              "4",Bucket
           ENDIF

           MOVE              APTRN.Balance,AgingAmt(Bucket)
           ADD               APTRN.Balance,AgingTotals(Bucket)
           ADD               APTRN.Balance,CUSTAging(Bucket)
.
           ADD               APTRN.Balance,AgingTotals(5)
           ADD               APTRN.Balance,CUSTAging(5)


           IF                (AgingDaysW < 0)
             MOVE              "0",AgingDays
           ELSE
             MOVE              AgingDaysW,AgingDays
           ENDIF
           RETURN

.=============================================================================
PrintDetails
           MOVE              "N",AtLeastOne
           PACKKEY           APTRNKY3,$Entity,Vendor.AccountNumber,"O"   //Open Only!!!!!
           RESET             APTRNKY3
.
. Read through all of the Transactions looking for 'Open' transactions
. only.  'Open' transactions are records that don't have a Zero balance.
.
           CALL              RDAPTRN3
           LOOP
             CALL              KSAPTRN3
           UNTIL             (Returnfl = 1 or APTRN.Vendor != Vendor.AccountNumber or APTRN.ClosedFlag != "O"))
             IF                (APTRN.Balance = 0)            // or APTRN.Balance < MinBalance)
               CONTINUE
             ENDIF

           CALL              CalculateAging

           unpack            APTRN.DueDate,CC,YY,MM,DD,CC
           PACK              DueDate FROM MM,"/",DD,"/",YY

           unpack            APTRN.TransDate,CC,YY,MM,DD,CC
           PACK              TransDate FROM MM,"/",DD,"/",YY

           IF                (APTRN.DiscDate != "        ")
             unpack            APTRN.DiscDate,CC,YY,MM,DD
             PACK              DiscDate FROM MM,"/",DD,"/",YY
           ELSE
             MOVE                 "        ",DiscDate
           ENDIF

          MOVE              " ",HoldFlag                                          //HR 3/24/2008  Re-added
          LOAD              HoldFlag FROM APTRN.HoldFlag of "On Hold"             //HR 3/24/2008

           IF                   (PrintGuiMode = "Y")

           EndOfPage

           move              agingdays,agingdaysD
           if                (APTRN.Balance = 0)
             move               "   ",AgingDaysD
           endif

           MOVE                 "Y",AtLeastOne
           if                   (PrintDetails = "1")
             IF                 (AtleastOne = "Y")
               CALL              PrintLine
             ENDIF

             PrtPage           P;*alignment=*left:
                               *font=SubLineFont:
                               *p=040:PrintLineCnt,APTRN.Invoice:           //12
.                               *p=040:PrintLineCnt,"MMMMMMMMMMMM":
                               *p=155:PrintLineCnt,APTRN.PO:                  //12
.                               *p=155:PrintLineCnt,"MMMMMMMMMMMM":
                               *p=270:PrintLineCnt,TransDate:
                               *alignment=*left:
                               *p=340:PrintLineCnt,DueDate:
                               *alignment=*decimal:
                               *p=455:PrintLineCnt,AgingAmt(1):
                               *p=535:PrintLineCnt,AgingAmt(2):
                               *p=615:PrintLineCnt,AgingAmt(3):
                               *p=695:PrintLineCnt,AgingAmt(4):
.                              *p=775:PrintLineCnt,AgingAmt(5):
.                              *p=855:PrintLineCnt,AgingAmt(6):
                               *alignment=*left:
                               *BoldOn:                               //HR 3/24/2008
                               *P=0985:PrintLineCnt,HoldFlag:         //HR 3/24/2008
                               *boldoff
             ADD               SubSingleLine,PrintLineCnt
             endif
           ENDIF         //PrintGuiMode = "Y"


           REPEAT

           IF                (AtLeastOne = "Y")
             CALL              PrintVendorTotals
           ENDIF
           RETURN
.=============================================================================
. Print the Totals for each Vendor
.=============================================================================
PrintVendorTotals
           IF                   (CustAging(1) = 0 and CustAging(2) = 0 and:
                                 CustAging(3) = 0 and CustAging(4) = 0 and:
                                 CustAging(5) = 0 and CustAging(6) = 0)
              RETURN
           ENDIF

           ADD               "1",ItemCount


           RETURN               IF (PrintDetails = 3)      //Report Grand Totals Only!!!

             IF                (PrintDetails = "1")    //Print ONLY when details

               PRTPAGE           P;*font=SubLineFont:
                                 *alignment=*left:
                                 *Pensize=1:
                                 *p=40:(PrintLineCnt - 2):
                                 *Line=380:(PrintLineCnt - 2):
                                 *p=402:(PrintLineCnt - 2):
                                 *Line=468:(PrintLineCnt - 2):
                                 *p=482:(PrintLineCnt - 2):
                                 *Line=548:(PrintLineCnt - 2):
                                 *p=562:(PrintLineCnt - 2):
                                 *Line=628:(PrintLineCnt - 2):
                                 *p=642:(PrintLineCnt - 2):
                                 *Line=708:(PrintLineCnt - 2):
                                 *p=722:(PrintLineCnt - 2):
                                 *Line=788:(PrintLineCnt - 2)
.                                 *p=802:(PrintLineCnt - 2):
.                                 *Line=868:(PrintLineCnt - 2):
.                                 *p=882:(PrintLineCnt - 2):
.                                 *Line=948:(PrintLineCnt - 2)
             ENDIF

             CHOP              Vendor.AccountNumber,Vendor.AccountNumber
             if                (CustAging(7) > MinBalance)

             PrtPage           P;*font=SubLineFont:
                               *alignment=*left:
                               *p=40:PrintLineCnt,"Totals ":
                               *ha=10:
                               *boldon:
                               *LL:
                               Vendor.AccountNumber:
                               " :  ":
                               Vendor.Name:
                               *alignment=*decimal:
                               *boldon:
                               *p=456:PrintLineCnt,CUSTAging(1):
                               *p=536:PrintLineCnt,CUSTAging(2):
                               *p=616:PrintLineCnt,CUSTAging(3):
                               *p=696:PrintLineCnt,CUSTAging(4):
                               *p=776:PrintLineCnt,CUSTAging(5):
.                              *p=856:PrintLineCnt,CustAging(6):
.                              *p=936:PrintLineCnt,CustAging(7):
                               *alignment=*left:
                               *p=840:PrintLineCnt,AutoPayFlag:
                               *boldoff
                ADD               SingleLine,PrintLineCnt
              else
                subtract          CustAging(1),AgingTotals(1)             //Remove these from the Grand Totals
                subtract          CustAging(2),AgingTotals(2)             //Remove these from the Grand Totals
                subtract          CustAging(3),AgingTotals(3)             //Remove these from the Grand Totals
                subtract          CustAging(4),AgingTotals(4)             //Remove these from the Grand Totals
                subtract          CustAging(5),AgingTotals(5)             //Remove these from the Grand Totals
.               subtract          CustAging(6),AgingTotals(6)             //Remove these from the Grand Totals
.               subtract          CustAging(7),AgingTotals(7)             //Remove these from the Grand Totals

              endif
.
..             ADD               DoubleLine,PrintLineCnt
           RETURN
.=============================================================================
PrintTotals
           PRTPAGE           P;*font=SubLineFont:
                             *alignment=*left:
                             *Pensize=1:
                             *p=40:(PrintLineCnt - 2):
                             *Line=380:(PrintLineCnt - 2):
                             *p=402:(PrintLineCnt - 2):
                             *Line=468:(PrintLineCnt - 2):
                             *p=482:(PrintLineCnt - 2):
                             *Line=548:(PrintLineCnt - 2):
                             *p=562:(PrintLineCnt - 2):
                             *Line=628:(PrintLineCnt - 2):
                             *p=642:(PrintLineCnt - 2):
                             *Line=708:(PrintLineCnt - 2):
                             *p=722:(PrintLineCnt - 2):
                             *Line=788:(PrintLineCnt - 2):
                             *p=802:(PrintLineCnt - 2):
                             *Line=868:(PrintLineCnt - 2):
                             *p=882:(PrintLineCnt - 2):
                             *Line=948:(PrintLineCnt - 2):
.
                             *p=40:(PrintLineCnt - 4):
                             *Line=380:(PrintLineCnt - 4):
                             *p=402:(PrintLineCnt - 4):
                             *Line=468:(PrintLineCnt - 4):
                             *p=482:(PrintLineCnt - 4):
                             *Line=548:(PrintLineCnt - 4):
                             *p=562:(PrintLineCnt - 4):
                             *Line=628:(PrintLineCnt - 4):
                             *p=642:(PrintLineCnt - 4):
                             *Line=708:(PrintLineCnt - 4):
                             *p=722:(PrintLineCnt - 4):
                             *Line=788:(PrintLineCnt - 4):
                             *p=802:(PrintLineCnt - 4):
                             *Line=868:(PrintLineCnt - 4):
                             *p=882:(PrintLineCnt - 4):
                             *Line=948:(PrintLineCnt - 4)



           PrtPage           P;*font=SubLineFont:
                             *alignment=*left:
                             *boldon:
                             *p=155:PrintLineCnt,"Total Report Aging ":
                             ":":
                             *alignment=*decimal:
...                             *p=368:PrintLineCnt,VStatRec.Balance:
                             *boldon:
                             *p=456:PrintLineCnt,AgingTotals(1):
                             *p=536:PrintLineCnt,AgingTotals(2):
                             *p=616:PrintLineCnt,AgingTotals(3):
                             *p=696:PrintLineCnt,AgingTotals(4):
                             *p=776:PrintLineCnt,AgingTotals(5)
.                            *p=856:PrintLineCnt,AgingTotals(6):
.                            *p=936:PrintLineCnt,AgingTotals(7)

           ADD               (SingleLine),PrintLineCnt

           PRTPAGE           P;*font=DetailFont,*boldon:
                             "Total Vendors printed :":
                             *alignment=*left:
                             ItemCount:
                             *boldoff
           RETURN
.
ExitProgram
..FUCKUP              NORETURN
..FUCKUP              NORETURN
              winshow
              chain   FromPGM
.TESTING              CHAIN
              STOP
.=============================================================================
EnableSelections
              GETITEM           RSelectedVendors,0,result
              SETPROP           AllCollection,Enabled=result

              IF                (result = 1)
                SETPROP           EFromVendor,BGCOLOR=2147483653
                SETPROP           EToVendor,BGCOLOR=2147483653
              ELSE
                SETPROP           EFromVendor,BGCOLOR=2147483663
                SETPROP           EToVendor,BGCOLOR=2147483663
              ENDIF
              RETURN
.=============================================================================
PrintCustomHeader
              PRTPAGE           P;*alignment=*left:
                                *font=SubLineFont:
                                *p=028:PrintLineCnt,"Code":
                                *P=125:PrintLineCnt,"Vendor Name":
                                *p=270:PrintLineCnt,"Inv. Date":
                                *p=340:PrintLineCnt,"Due Date":
                                *p=416:PrintLineCnt,Heading(1):
                                *p=496:PrintLineCnt,Heading(2):
                                *p=576:PrintLineCnt,Heading(3):
                                *p=656:PrintLineCnt,Heading(4):
                                *p=743:PrintLineCnt,Heading(5):
                                *p=810:PrintLineCnt,"Auto Pay"

.                               *p=810:PrintLineCnt,Heading(6):
.                               *p=912:PrintLineCnt,Heading(7)
              ADD               SingleLine,PrintLineCnt
              RETURN
.=============================================================================
PrintTextHeader
           add              "1" to printPageCnt
           compare          "1" to printPageCnt
           if not equal
             print              *f;
           endif

         PRINT     *51,"AGED ACCOUNTS Payable REPORT FOR ":
...                   LOCATION:
                   *111,"AS OF ",ReportDate
.
         PRINT     *52,"SUPERIOR WASHER & GASKET CORP.",*111,"PAGE ",PrintPageCnt
.
         PRINT     " "
         PRINT     *2,"ACCOUNT   NAME",*47,"CURRENT",*60,"PAST DUE":
                   *74,"PAST DUE",*88,"PAST DUE",*102,"PAST DUE":
                   *117,"ACCOUNT"
         PRINT     *2,"NUMBER",*48,"1-",Heading(1),*62,Heading(2),*76,Heading(3):
                   *89,Heading(4),*102,Heading(5),*118,Heading(6)
         MOVE      "6"  TO  PrintLineCnt
         RETURN

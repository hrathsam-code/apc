;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    4 NORFOLK LANE                                           ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    VINQ.PLS               admin  hunt9800 Sonicwall               ;
;                                    TZ170 to TZ300 Upgrade path              ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    02/15/2003 AT 11:47PM                                          ;
;                                                                             ;
;  PURPOSE:    Vendor Inquiry                                                 ;
;                                                                             ;
; REVISION:    VER     DATE     INIT       DETAILS                            ;
;                                                                             ;
;              1.0   07/28/2003   HOR     INITIAL VERSION                     ;
;                                                                             ;
;=============================================================================;
;
; Add Comments button

.
. Program Created On : 02/15/02 At 3:00:pm
.
. Modified to add the Freight field to the report
.
. Modified to allow lookup by Invoice Number      12/23/2003
.
. Modified to now use Order Number along with Invoice Number when reprinting
. Invoices.
.
           INCLUDE              NCOMMON.TXT
           INCLUDE           WORKVAR.INC
#RESULT    FORM              1
#RES1      FORM              1
#DIM1      DIM               1
#DIM2      DIM               2
#RES2      FORM              2
#LEN1      FORM              3
#MenuObj   Automation
#MenuItem  DIM               25
DIM10      DIM               10
UseStamps     DIM               10         //HR 11/22/2004   FORM              "0"         //HR 11/12/2004
SeqMajorD     DIM               7
Row           FORM              4
ListViewRowSelected FORM        7
DueDate       DIM               10
DiscountDate  DIM               10
GrossAmountD  DIM               13
GrossAmount   FORM              7.2
DiscAmount    FORM              5.2
NetAmountD    DIM               13
NetAmount     FORM              7.2
DiscAmountD   DIM               10
PurchAmtD     DIM               13
PaidAmtD      DIM               13
DiscAmtD      DIM               13
AmountD       DIM               10

TransDesc     DIM               17
CheckNumber   FORM              10
CheckNumberD  DIM               10

VendorBalance   FORM              10.2
VendorBalanceD  DIM               13
NodeNum    FORM              6
VendorSave DIM              6
X          integer           1
RES1
ChildNum   FORM              6
SeqNum     FORM              7
DATALINE   DIM               120
int2       FORM              4
MonthName  DIM               10
CurrentYear DIM                 4
SelectedYear DIM                4
DueDate10     DIM               10
TransDate10   DIM               10
ViewByOption  FORM              2
FromCustomer  DIM               10
DIM13         DIM               13
Days       FORM              10
YYF           FORM              2
RES2          FORM              2
IOSW     DIM       1       I/O INDICATOR
OldInvoiceNumber FORM           5
OldInvoiceNumber10 FORM         10
OldInvoiceNumberD DIM           5
BalanceD      DIM               12
OrigAmtD      DIM               12
RangeToDate   DIM               8
RangeFromDate DIM               8
TotalRows     FORM              8
MemoField     DIM               40
FreightAmt    FORM              4.2
SearchBy      FORM              1
InvoiceKey    DIM               10
CheckNoD      DIM               10
CheckDate     DIM               8
Invoice5      FORM              5

Blank         INIT              " "
           GOTO              STARTPGM

           INCLUDE           statetbl.txt      //HR 1/13/2004

           INCLUDE           Vendor.FD

.
          INCLUDE           CustD.FD
           INCLUDE           CMPNY.FD
           INCLUDE           BANK.FD
..           INCLUDE           CHST.FD
           INCLUDE           GLMAST.FD
           INCLUDE           APCTL.FD
           INCLUDE              VHST.FD
           INCLUDE              APTRN.FD
           INCLUDE              APDET.FD
              INCLUDE           Check.FD
              INCLUDE           CheckDet.FD
.
..HR 2017.4.17 WindowsCOl COLLECTION

...result     form              2

..HR 2017.4.17 VINQ1         PLFORM            VINQ1
..HR 2017.4.17 VINQ2         PLFORM            VINQ2
..HR 2017.4.17 VINQ3         PLFORM            VINQ3
VINQ4         PLFORM            VINQ4
..HR 2017.4.17 VINQ5         PLFORM            VINQ5
VINQ6         PLFORM            Vinq6
.StatusWin      PLFORM         Status1

..HR 2017.4.17 MAIN       PLFORM            VINQMAIN.PLF

VinqAll            plform            VinqAll.PLF
DataMenu           PLFORM            DataMenu.PLF

About      PLFORM            About.PLF

.X FileMenu    menu
.X ChangeMenu  menu
.X HelpMenu    menu

FileMenuTxt init      "&File;":
                      "&Print;":
                      "-;":
                      "E&xit"

ChngMenuTxt init      "&Edit;":
                      "&New record;":
                      "&Change Record;":
                      "&Delete Record;":
                      "&Save Record"

HelpMenuTxt init      "&Help;":
                      "F1 - Help with A//P Terms;":
                      "-;":
                      "&About Chiron Software"
.
STARTPGM   ROUTINE
           INCLUDE           SECURITY.INC
           MOVE              "1",ProgLoaded
.
. If we're unable to find the Help file, then we're going to simply just not make
. the F1 Function key available to the Users
.
           MOVE              "AppDir;HELPDIR",EnvData
           CLOCK             INI,EnvData
           IF                NOT OVER
             PACK              EnvData,EnvData,VendorHelp
             TRAP              NOHELP IF OBJECT
             SETMODE           *HELPLIB=EnvData
             SETMODE           *F1HELP=ON
             TRAPCLR           OBJECT
             GOTO              OPENFILES
NOHELP
             NORETURN
           ENDIF
.
OPENFILES

           CALL              OPENVendor
           CALL                 OpenVHST
           CALL                 OpenAPTrn
           CALL                 OpenAPDet
...           CALL              OPENBANK
           CALL              OPENGLMAST
           CALL              OPENCMPNY
           CALL              OPENAPCTL
           CALL                 OpenCheck
           CALL                 OpenCheckDetail

           CLOCK             TIMESTAMP,CurrentYear

VendColl   COLLECTION
VendEdt    COLLECTION
VendBoxes  COLLECTION
VendStat   COLLECTION

..HR 2017.4.17           LISTINS           WindowsCOL,VINQ1,VINQ2

.           LISTINS           VendStat,STVendCountry
           LISTINS           VendCOLL,EVendAcctNo,EVendName,EVendAddr1,EVendAddr2:
                                      EVendCity,EVendSt,EVendZip:
...                                     EVendGLAcct:
                                      EVendTaxCode,EVendDiscount,EVendAutoPay:
                                      EVendStatus,EVendRating:
                                      EVendOver30:
                                      EVendOver60,EVendOver90,EVendCurrent:
                                      EVendTotal,EVendMTDDebits,EVendMTDCredits:
                                      EVendLastPurchAmt,EVendLastPurchDate:
                                      EVendPhone
.
..HR 2017.4.17           LISTINS           VendEDT,EVendAcctNo,EVendName,EVendAddr1,EVendAddr2:
..HR 2017.4.17                                    EVendCity,EVendSt,EVendZip:
...                                    EVendGLAcct:
..HR 2017.4.17                                    EVendTaxCode,EVendDiscount,EVendAutoPay:
..HR 2017.4.17                                    EVendStatus,EVendRating:
..HR 2017.4.17                                    EVendOver30:
..HR 2017.4.17                                    EVendOver60,EVendOver90,EVendCurrent:
..HR 2017.4.17                                    EVendTotal,EVendMTDDebits,EVendMTDCredits:
..HR 2017.4.17                                    EVendLastPurchAmt,EVendLastPurchDate

.
           LISTINS           VendBOXES,CBVendActive

           INCLUDE           Temporary.inc
.           WINHIDE                                //HR 3/2/2005

                   formload          VinqAll
                   FORMLOAD          DataMenu,WMain
..HR 2017.4.17               FORMLOAD          MAIN
..HR 2017.4.17               FORMLOAD          VINQ1,WMain
..HR 2017.4.17               FORMLOAD          VINQ2,WMain
..HR 2017.4.17               FORMLOAD          VINQ3,WMain
              FORMLOAD          VINQ4,WMain
..HR 2017.4.17               FORMLOAD          VINQ5,WMain           //HR 8/23/2005
              FORMLOAD          VINQ6,WMain           //HR 9/20/2005
.                   MenuToolBar.AddButton using *ImageIndex=25:
.                                               *Tag=71:
.                                               *visible=1:
.                                               *runName="ID_Comment":
.                                               *Tooltip="Add/View Comments"



..              FORMLOAD          FStamps
.           FORMLOAD           StatusWin,WMain

..HR 2017.4.17              DEACTIVATE        VINQ2
..HR 2017.4.17              DEACTIVATE        VINQ3
.              DEACTIVATE        CINQ4
..HR 2017.4.17           SETPROP           VINQ1,visible=1
              CALL              SetupLVColumns

                   setfocus          EVendAcctNo
           LOOP
             WAITEVENT
           REPEAT
.
. We never get here!!   Just in case though.... :-)
.
           RETURN
.           STOP

.BROWSEFILE ROUTINE
.SEARCH     PLFORM            SEARCH.PLF
.           FORMLOAD          SEARCH
.           RETURN

.INITSRCH
.           PACK              SearchTitle,CustTitle," Search Window"
.           SETPROP           LVSearch,*TitleText=SearchTitle

.           CTADDCOL          "Customer ID",75,"Customer Name",125:
.                             "Address",100:
.                             "City",100:
.                             "State",40:
.                             "Zip",60:
.                             "Country",50

.           CTLoadTable       Cust,CustomerID,Name,Address1,City,St,Zip,Country
.           RETURN
.
. Routines that operate the Main program
.
..HR 2017.4.17              STOP

NOFILE
.           NORETURN
           ALERT             PLAIN,"Custor Master file does not exist. Do you wish to create it?",#RESULT
.           IF                (#RESULT = 1)
.             CALL              PREPCust
.             GOTO              OPENFILES
.           ENDIF
           STOP
.
.X READOPT    DIM               12
.X PAGED      DIM               4
.X NEXTLINE   INIT              127
.X PRTFILE    PFILE
.X PRTCOUNT   FORM              6
.X PRTCOUNTD  FORM              6
.X PRGTITLE   INIT              "A/P Terms MAster Listing"
.X PAGETITLE  DIM               60
.X DIM500     DIM               500
.X PRTWIDTH   FORM              8
.X PRTHEIGHT  FORM              8
.X DIM8       DIM               8
.X COL        FORM              3
.X ROW        FORM              3
.X MAXROWS    FORM              3
.X ACCT       DIM               9
.X TODAY8     DIM               8
.X TIME8      DIM               8
.X NUM1       FORM              3
.X NUM2       FORM              3
.X ToCode     DIM               8
.X .
.X PRTREPORT
.X CustRPT   PLFORM            CustRPT.PLF
.X .           WINHIDE
.X
.X            CLOCK             DATE,TODAY8
.X            CLOCK             TIME,TIME8
.X
.X            MOVE              "60",MAXROWS
.X            MOVE              "0",PAGE
.X            MOVE              "90",LINE
.X
.X            FORMLOAD          CustRPT
.X            LOOP
.X              WAITEVENT
.X            REPEAT
.X
.X            RETURN
.X
.X .           alert             note,"how???",returnfl
.X .           LOOP                                              .Wait...and Wait...
.X .             WAITEVENT                                       .
.X .           REPEAT                                            .and wait
.X
.X START
.X .
.X .
.X . Since we're dealing with a sorted file, we're going to read it in
.X . Sequential order vs. Key Sequential.  Also, we must make sure that
.X . we don't read any records that we're not supposed to based on the
.X . code that was in the other program. (AP42.DBS)
.X .
.X
.X            CLOCK             DATE,TODAY8
.X            CLOCK             TIME,TIME8
.X
.X            MOVE              "60",MAXROWS
.X            MOVE              "0",PAGE
.X            MOVE              "90",LINE
.X            MOVE              "0",PRTCOUNT
.X .
.X . Process all Custors in Sorted Order
.X .
.X            MOVE              " ",CustKY
.X
.X            GETITEM           RAll,0,RETURNFL
.X            BRANCH            RETURNFL OF ALL
.X
.X            GETITEM           EFromRange,0,CustKY
.X            GETITEM           EToRange,0,ToCode
.X
.X            IF                (ToCode < CustKY)
.X            BEEP
.X            ALERT             STOP,"From Code cannot be less than the To Code",RETURNFL,"Range Error"
.X            SETFOCUS          ETORANGE
.X            RETURN
.X            ENDIF
.X
.X ALL
.X            TRAP              NOPRINT IF SPOOL
.X            PRTOPEN           PRTFILE,"@?","A/P Term Code Listing"
.X            TRAPCLR           IO
.X
.X            CALL              PRTHEADER2
.X
.X
.X            CALL              RDCust
.X            LOOP
.X              CALL              KSCust
.X            UNTIL             (RETURNFL = 1 OR Vendor.Code > ToCode)
.X              CALL              PRTLINE
.X            REPEAT
.X .
.X . Print Totals line
.X .
.X            IF                (LINE + 4 > MAXROWS)
.X              CALL              PRTHEADER
.X            ENDIF
.X            PRTPAGE           PRTFILE;*N=3,PRTCOUNT," A/P Term Records Printed"
.X            PRTCLOSE          PRTFILE
.X            RETURN
.X .
.X . Print Each Detailed line
.X .
.X PRTLINE
.X            ADD               "1",PRTCOUNT
.X            MOVE              PRTCOUNT,PRTCOUNTD
.X
.X            IF                (LINE > MAXROWS)
.X              CALL              PRTHEADER
.X            ENDIF
.X            CHOP              Vendor.NETDAYS,Vendor.NETDAYS
.X            CHOP              Vendor.DISCDAYS,Vendor.DISCDAYS
.X
.X            MOVE              Vendor.NETDAYS,NUM1
.X            MOVE              Vendor.DISCDAYS,NUM2
.X
.X            PRTPAGE           PRTFILE;*1,Vendor.Code:
.X                                      *16,Vendor.Desc:
.X                                      *Alignment=*Right:
.X                                      *38,Num1:
.X                                      *50,Num2:
.X                                      *Alignment=*Decimal:
.X                                      *61,Vendor.DiscPerc:
.X                                      *Alignment=*Left
.X
.X            ADD       "2" TO LINE
.X            RETURN
.X
.X PRTHEADER
.X            PRTPAGE           PRTFILE;*NEWPAGE;
.X PRTHEADER2
.X            CALC              COL=PRTWIDTH-15
.X            ADD               "1",PAGE
.X            MOVE              PAGE,PAGED
.X .           SETITEM           EPage,0,PAGED
.X
.X            PRTPAGE           PRTFILE;*P1:63,*LINE=85:63:
.X                              *N:
.X                              *40,"Page :",*alignment=*left,PAGE:
.X                              *P1:1:
.X                              *P1:1,"Date : ",TODAY8:
.X                              *BOLDON:
.X                              *H=27,"Chiron Software & Services, Inc.",*BOLDOFF:
.X                              *72,"APTERM":
.X                              *N:
.X                              *H=1,"Time : ",TIME8:
.X                              *H=29,"A/P Term Code Master Listing":
.X                              *72,"Accounts Payable":
.X                              *N=2:
.X                              *ULON:
.X                              *H=1,"Term Code",*H=16,"Description":
.X                              *H=33,"Net Days",*H=44,"Disc. Days":
.X                              *H=57,"Disc. %":
.X                              *ULOFF:
.X                              *N
.X
.X            MOVE              "5",LINE
.X            RETURN

EXITASK
           ALERT             PLAIN,"Are you sure you wish to exit this report?",#RESULT
           IF                (#RESULT=1)
             STOP
           ENDIF
           RETURN

NOPRINT
           TRAPCLR           SPOOL
           NORETURN
           RETURN

ToggleToolBar
wintypef      form              1
.              getprop           ToolBarWin,wintype=wintypef
.              if                (wintypef = 2)
.              setprop            ToolBarWin,wintype=wintypef
.              else
.              setprop            ToolBarWin,WinType=2
.              endif
              return
;=============================================================================
MaintMenuOption
           CALL                 GetMenuName

..HR 2017.4.17           EVENTINFO         0,ARG1=#MenuObj
..HR 2017.4.17           GETPROP           #MenuObj,*ID=#MenuItem
.

..HR 2017.4.17           SELECT            USING #MenuItem
..HR 2017.4.17           WHEN              "ID_New"
..HR 2017.4.17             CALL              MainNew
..HR 2017.4.17             RETURN
..HR 2017.4.17           WHEN              "ID_Exit"
..HR 2017.4.17             CALL              MainClose
..HR 2017.4.17             RETURN
..HR 2017.4.17           WHEN              "ID_Print"
..HR 2017.4.17             CALL              MainPrint
..HR 2017.4.17             RETURN
..HR 2017.4.17           WHEN              "ID_Cancel"
..HR 2017.4.17             CALL              MainCancel
..HR 2017.4.17             RETURN
..HR 2017.4.17           WHEN              "ID_Change"
..HR 2017.4.17             CALL              MainChange
..HR 2017.4.17             RETURN
..HR 2017.4.17           WHEN              "ID_Delete"
..HR 2017.4.17             CALL              MainDelete
..HR 2017.4.17             RETURN
..HR 2017.4.17           WHEN              "ID_Find"
..HR 2017.4.17             CALL              MainFind
..HR 2017.4.17             RETURN
..HR 2017.4.17           WHEN              "ID_First"
..HR 2017.4.17             CALL              MainFirst
..HR 2017.4.17             RETURN
..HR 2017.4.17           WHEN              "ID_Last"
..HR 2017.4.17             CALL              MainLast
..HR 2017.4.17             RETURN
..HR 2017.4.17           WHEN              "ID_Next"
..HR 2017.4.17             CALL              MainNext
..HR 2017.4.17             RETURN
..HR 2017.4.17           WHEN              "ID_Previous"
..HR 2017.4.17             CALL              MainPrevious
..HR 2017.4.17             RETURN
..HR 2017.4.17           WHEN              "ID_About"
..HR 2017.4.17             CALL              MainAbout
..HR 2017.4.17             RETURN
..HR 2017.4.17           WHEN              "ID_Save"
..HR 2017.4.17             CALL              SaveMode
..HR 2017.4.17             RETURN
..HR 2017.4.17           WHEN              "ID_Undo"
..HR 2017.4.17             CALL              MainUndo
..HR 2017.4.17             RETURN
..HR 2017.4.17           WHEN              "ID_Statements"
..HR 2017.4.17             CALL              PrintStatement
..HR 2017.4.17             RETURN
..HR 2017.4.17           WHEN              "ID_Reprint_Invoices"
..HR 2017.4.17             CALL              RePrintInvoices
..HR 2017.4.17             RETURN
..HR 2017.4.17           WHEN              "ID_ShowToolbar"
..HR 2017.4.17             CALL              MainToolbar
..HR 2017.4.17             RETURN
..HR 2017.4.17           WHEN              "ID_Comment"
..HR 2017.4.17             CALL              ViewComments
..HR 2017.4.17             RETURN
..HR 2017.4.17           WHEN              "ID_PrtScrn"
..HR 2017.4.17             CALL              PrintScreen using WMain
..HR 2017.4.17             RETURN
..HR 2017.4.17           DEFAULT
..HR 2017.4.17           ENDSELECT
                   return
;==========================================================================================================
MainValid
.           IF                (Status = 0)
              GETITEM           CBSearchBy,0,SearchBy
.             IF                (SearchBy = 2)           //By Invoice Number
.               GETCOUNT          EVendAcctNo
.               RETURN            IF (CharCount = 0)      //Nothing to do

.               RESETVAR          InvoiceKey
.               GETITEM           EVendAcctNo,0,InvoiceKey
.               MOVE              InvoiceKey,Invoice5                 //HR 2/4/2005
.               RESETVAR          InvoiceKey                          //HR 2/4/2005
.               MOVE              Invoice5,InvoiceKey                 //HR 2/4/2005
.               SETLPTR           InvoiceKey

.               PACKKEY           APTRNKY5 FROM $Entity,"I",InvoiceKey,"999999"
.               CALL              RDAPTRN5

.               CALL              KPAPTRN5
.               IF                (ReturnFl = 1 or APTRN.Invoice != InvoiceKey)
.                 BEEP
.                 ALERT           note,"Invoice Number does not exist",result
.                 RETURN
.               ENDIF
.               SETITEM           EVendAcctNo,0,APTRN.Vendor
.               CLEAREVENTS
.             ENDIF

             GETCOUNT          EVendAcctNo
             IF                (CharCount > 0)
               RESETVAR          VendorKY
               GETITEM           EVendAcctNo,0,VendorKY

               CALL              RDVendor
               IF               (RETURNFL = 1)
                 PARAMTEXT        VendorTITLE,VendorKY,"",""
                 ALERT            CAUTION,"^0: ^1 Not Found",#RES2,"Record does not exist"
                 CALL             MAINRESET
                 RETURN
               ENDIF
.
. OK, we've been able to read the record and now let's show it on the screen.
.
.               CALL              MainReset
               CALL              SETMAIN
.
. HR 8/5/2003
.
           CLOCK             TIMESTAMP,Date8
.           CALL              ConvDateToDays using DATE8,Days
.           SUBTRACT          "365",Days
.           CALL              ConvDaysToDate using Days,DATE8

           unpack            DATE8,CC,YY,MM,DD
           MOVE                 MM,MMF
           SUBTRACT             "3",MMF
           IF                   (MMF <= 0)                //HR 1/26/2004
             ADD                  "12",MMF
             MOVE                 YY,YYF
             SUBTRACT             "1",YYF
             MOVE                 YYF,YY
             MOVE                 MMF,MM
           ELSE
             MOVE                 MMF,MM
           ENDIF
.
. Leap Year issue resolved.  5/30/2008
.
           IF                   (MMF = 2 and DD >= "29")
             MOVE                 "28",DD
           ENDIF
.
. Modified 7/31/2008 to resolve issue with Terry
.
           IF                   ((MMF=4 or MMF=6 or MMF=9 or MMF=11) and DD = "31")
             MOVE                 "30",DD
           ENDIF

...           PACKKEY           DATE8,MM,slash,DD,slash,YY
..HR 1/26/2004           PACKKEY           DATE8,"01",slash,"01",slash,YY
..HR 2017.4.17           PACKKEY           Date8 FROM MM,slash,DD,slash,YY
           Packkey           Date8 from CC,YY,MM,DD
           SETPROP           DTFromDate,text=DATE8

           CLOCK             TIMESTAMP,Date8
           unpack            DATE8,CC,YY,MM,DD
..HR 2017.4.17           PACKKEY           DATE8,MM,slash,DD,slash,YY
           Packkey           Date8 from CC,YY,MM,DD
           SETPROP           DTToDate,text=DATE8

              CALL              ViewHistoryByOptions
..7/30/03           GETITEM           CBViewBy,0,ViewByOption
           move              "CHIRON",$ENTITY

..HR 7/30/03           IF (APTRN.Balance = 0 and ViewByOption = 1)   //Open Items Only
..HR 7/30/03             PACKKEY           APTRNKY3,$Entity,CustKY,"O"
..HR 7/30/03           ENDIF

..HR 7/30/03           IF (APTRN.Balance = 0 and ViewByOption = 2)   //Open Items Only
..HR 7/30/03             PACKKEY           APTRNKY3,$Entity,CustKY,"C"
..HR 7/30/03           ENDIF

..HR 7/30/03           MOVE              CUSTKY,VendorSave
..HR 7/30/03           SETLPTR           CustKY

..HR 7/30/03           CALL              RDAPTRN3
..HR 7/30/03           LOOP
..HR 7/30/03             CALL              KSAPTRN3
..HR 7/30/03           UNTIL             (RETURNFL = 1 or APTRN.Vendor <> VendorSave)

..HR 7/30/03             UNPACK            APTRN.DueDate,CC,YY,MM,DD
..HR 7/30/03             PACK              DueDate10,MM,"/",DD,"/",YY

..HR 7/30/03             UNPACK            APTRN.TransDate,CC,YY,MM,DD
..HR 7/30/03             PACK              TransDate10,MM,"/",DD,"/",YY

..HR 7/30/03             PACK              DATALINE FROM APTRN.InvCredit,";":
..HR 7/30/03                                             APTRN.Invoice,";":
..HR 7/30/03                                             APTRN.PO,";":
..HR 7/30/03                                             APTRN.OrigAmt,";":
..HR 7/30/03                                             APTRN.Balance,";":
..HR 7/30/03                                             TransDate10
.             PACK              DATALINE FROM APDetail.Invoice,";":
.                                             APTRN.Balance,";":
.                                             DueDate10,";",TransDate10

..HR 7/28/2003             CINQTree.AddNode  giving int2 using dataline,0,1
..HR 7/30/03             CTInq.AddItem   giving int2 using dataline

..HR 7/28/2003             SETPROP           CINQTree,*NodeIsParent(int2)="1"
..HR 7/28/2003             SETPROP           CINQTree,*NodeData(int2)=APTRN.SeqMajor
..HR 7/28/2003             setprop           CINQTree,*NodePicture(int2)=2

..HR 7/30/03           REPEAT

           MOVE              "3",Status                   .We've found a record
.INQ               ENABLEITEM        BMainCHANGE
               ENABLETOOL        ID_Change

.               DISABLEITEM       BMainNEW
.               DISABLETOOL       ID_New

.inq               ENABLEITEM        BMainDELETE
               ENABLETOOL        ID_Delete

.               DISABLEITEM       EVendCODE
               DISABLEITEM       Fill1
.1               DISABLEITEM       ChangeMenu,1
.1               ENABLEITEM        ChangeMenu,2
.1               ENABLEITEM        ChangeMenu,3
.1               DISABLEITEM       ChangeMenu,4
.INQ               SETFOCUS          BMainChange
               CALL              SetVendorHistoryYears
               CALL              SetVendorHistoryStatistics             //HR 9/20/2005
             ENDIF
.           ENDIF
           RETURN

.=============================================================================
. Initialize MAIN Form and setup the Menu's, Fields, Objects, Buttons, etc
.
MAININIT
.X           CREATE            WMAIN;HelpMenu,HelpMenuTxt
.X           CREATE            WMAIN;ChangeMenu,ChngMenuTxt
.X           CREATE            WMAIN;FileMenu,FileMenuTxt
.
.X           ACTIVATE          HelpMenu,onClickMainWinHelpMenu,result
.X           ACTIVATE          ChangeMenu,onClickMainWinChangeMenu,result
.X           ACTIVATE          FileMenu,onClickMainWinFileMenu,result
.
. Set the SELECTALL property for the COLLECTION and then take care of
. any ActiveX controls.
.
..HR 2017.4.17           SETPROP           VendEDT,SELECTALL=$SelectAll
.
           SETPROP            StatusBar001.Panels(0),Text=$Entity
           CALL              MAINRESET
.....           call              SetInitialVendorStatistics

           CLOCK             TIMESTAMP,Date8
.           CALL              ConvDateToDays using DATE8,Days
.           SUBTRACT          "365",Days
.           CALL              ConvDaysToDate using Days,DATE8

           unpack            DATE8,CC,YY,MM,DD
...           PACKKEY           DATE8,MM,slash,DD,slash,YY
..HR 2017.4.17           PACKKEY           DATE8,"01",slash,"01",slash,YY
           SETPROP           DTFromDate,text=DATE8

           RETURN
.=============================================================================
. New Button is pressed
.
MAINNEW
           IF                (Status = 2)      //Let's 'Save' this NEW Record
             CALL              VALIDATE1     //Validate the data first
.
. Something's not right...Let's just return and wait until all the fields
. have been validated
.
             IF                (ValidFlag = 1)
               RETURN
             ENDIF
.
. Get all of the fields from the Form into the proper RECORD
.
             CALL              GETMAIN
.
. Let's see if SOMEBODY else has entered/used this code before or let's just
. see if this Code already exists in the system
.
             GETITEM           EVendAcctNo,0,VendorKY
.             JustifyCust       CustKY
.             JustifyCust       CustKY

             CALL              TSTVendor
             IF                (RETURNFL = 1)
.               CALL              WRTCust
               CALL              MAINRESET
               RETURN
             ELSE
               PARAMTEXT       VendorTITLE,VendorKY,"",""
               BEEP
               ALERT           Note,"^0 with code ^1 already exists. Please enter another code",result:
                                    "Record already exists"
               SETFOCUS        EVendAcctNo
             ENDIF                                //Valid record exists???
           ELSE
             CALL              MainReset
             MOVE              "2",Status
             CALL              DisableRecordButtons
.
. Enable all of the EditText fields and set the EditText fields
. to Non Read-Only
.
..HR 2017.4.17             ENABLEITEM        VendEDT
             DISABLEITEM       Fill1
             %IFDEF            CBVendActive
             ENABLEITEM        CBVendActive
             %ENDIF

..HR 2017.4.17              SETPROP           VendEDT,READONLY=0
..HR 2017.4.17              SETPROP           VendEDT,BGCOLOR=$WINDOW
.
. We also need to set any ActiveX controls to the same properties
.
               ENABLEITEM      VendBoxes

..HR 2014.4.17               SETPROP         EVendPhone,*Enabled=1
.               SETPROP         EVendFax,*Enabled=1
..HR 2014.4.17               SETPROP         EVendPhone,*BackColor=$WINDOW
.               SETPROP         EVendFax,*BackColor=$WINDOW
.
. Setup any DEFAULT values
.
.             SETITEM           EVendDISCDAYS,0,"0"
.
. Disable & Enable the proper Buttons along with changing
. the description of the Button's (i.e. Exit --> Change)
.
.INQ             DISABLEITEM       BMainCHANGE
             DISABLETOOL       ID_Change

.INQ             DISABLEITEM       BMainDELETE
             DISABLETOOL       ID_Delete

.INQ             SETITEM           BMainNEW,0,SaveTitle
             ENABLETOOL        ID_Save

.INQ             SETITEM           BMainCancel,0,CancelTitle
             ENABLETOOL        ID_Cancel

             DISABLETOOL       ID_New
.
. Disable the Menu Items except for the 'Save' button
.
.1             DISABLEITEM       ChangeMenu,1
.1             DISABLEITEM       ChangeMenu,2
.1             DISABLEITEM       ChangeMenu,3
.1             ENABLEITEM        ChangeMenu,4
.
. Set the Focus to the first field that we're going to be Entering
.
             SETFOCUS          EVendAcctNo
           ENDIF
           RETURN
.=============================================================================
. Change/Save Button has been pressed
.
MAINCHANGE
.
. I'm only getting here if the Change Button has been selected.  Soooooo....Either the
. Change Button has been pressed, or this button now reads 'Save'.  If it reads Save,
. the Status flag will have been set to 1 the first time that this routine has been
. reached.
           IF                (Status = 1)                //'Save' button has been pressed
             CALL              VALIDATE1
             IF                (ValidFlag = 0)           //Great..All fields ARE valid!!!
               CALL              GETMAIN                 //Get all of the fields
.               CALL              UPDCust                //Update the record
               CALL              MAINRESET               //Reset the objects & fields
             ENDIF
             RETURN                                      //Voila...Either way, we're RETURNING
           ENDIF
           GETCOUNT          EVendAcctNo
           IF                (Charcount > 0)
             GETITEM           EVendAcctNo,0,VendorKY      //Read the Primary field ito the Key
.             JustifyCust       CustKY
.             JustifyCust       CustKY

             CALL              RDVendorLK               //Lock the record so that nobody uses it
.
. Just for arguments sake, let's just make sure that the record hasn't been deleted
. by another user, AND...Let's make sure that it's not being used by another user
. as well!!
.
             IF                (RETURNFL = 1)          //WHAT!!! Somebody deleted this record
               BEEP
               ALERT             STOP,"Record deleted by another User!!",RESULT
               CALL              MAINRESET
               RETURN
             ENDIF
.
. Record is locked...Try again later
.
             IF                (RETURNFL = 2)          //WHAT!!! Somebody's locked the record
               BEEP
               ALERT             NOTE,"Record locked by another User..."::
                                       "Try again later",RESULT,LOCKTITLE
               RETURN
             ENDIF
.
. OK, OK...We've gotten this far...The record is now locked and we
. can safely change the Status to "Modify"
.
             MOVE              "1",Status                  //We've selected the Modify/Change Button
             CALL              DisableRecordButtons
.
. Not only do we have a good record, but we've been able to 'Lock' the record
. and now we're ready to proceed
.
. Enable the Entire Collection of EditText fields as well as setting the
. background colors and making them Non Read-Only
.
VendCOLL
             ENABLEITEM        VendStat
             DISABLEITEM       Fill1
             %IFDEF            CBVendActive
             ENABLEITEM        CBVendActive
             %ENDIF
.
..HR 2017.4.17             SETPROP           VendCOLL,READONLY=0
..HR 2017.4.17             SETPROP           VendCOLL,BGCOLOR=$WINDOW
.
. OK, OK...What do we do with any ActiveX components. We've got to handle
. them as well.  Let's change these to Non Read-Only and change the
. Background colors as well
.
               ENABLEITEM      VendBoxes

..HR 2014.4.17               SETPROP         EVendPhone,*Enabled=1
.               SETPROP         EVendFax,*Enabled=1
..HR 2014.4.17               SETPROP         EVendPhone,*BackColor=$WINDOW
.               SETPROP         EVendFax,*BackColor=$WINDOW
.
. Change the Cancel button button to 'Save' and the 'Exit' button to Cancel
.
             ENABLETOOL        ID_Cancel

             ENABLETOOL        ID_Save
.
             ENABLETOOL        ID_Undo
             DISABLETOOL       ID_Change
.
             DISABLETOOL       ID_New
.
             SETFOCUS          EVendName               //Set the cursor to the next field
           ENDIF
           RETURN
.=============================================================================
. Routine to read the First record and display it
.
MainUndo
. If I've click on the Undo/Reset button, I've already got the 'Key' based on
. the fact that I'm changing a record that already exists and I loaded the
. key the first time.  Soooooo....Simply 'Re-read' the record, Calll the
. SetMain routine and Voila!!!!
.
           BEEP
           ALERT             PLAIN,"Revert back to the 'Original' record",RESULT:
                                   SureTitle
           IF                (RESULT = 1)
             CALL              RDVendorLK
             CALL              SetMain
           ENDIF
           RETURN
.=============================================================================
MainFind
           FindSearch        EVendAcctNo,Vendor

           IF                (PassedVar = "Y")
             GETITEM           EVendAcctNo,0,VendorKY
             MOVE              $SearchKey,VendorKY
             CALL              RDVendor
.
. We've got a record thanks to our Trusy Search/Browse window. Let's
. continue now by setting up the proper Code field and calling the
. MainValid subroutine, that will take care of it for us.
.
             MOVE              "0",Status
             SETITEM           EVendAcctNo,0,Vendor.AccountNumber
             CALL              MainValid
           ENDIF
           RETURN
.=============================================================================
. Routine to read the First record and display it
.
MainFirst
           CLEAR             VendorKY
           FILL              FirstASCII,VendorKY
           CALL              RDVendor
           IF                (RETURNFL = 1)  . We didn't find a 'Blank' record
             CALL              KSVendor         . Try the 'next' record
             IF                (RETURNFL = 1)  . There are no records in the file
               BEEP
               ALERT             STOP,"No records exist in the system...",RESULT:
                                      FirstTitle
               RETURN
             ENDIF
           ENDIF
.
. We've got a record (either on the READ or the READKS.  Let's now continue
. processing as if we just lost the Focus of the main field.  By calling the
. MainValid subroutine, that will take care of it for us.
           MOVE              "0",Status
           SETITEM           EVendAcctNo,0,Vendor.AccountNumber
           CALL              MainValid
           RETURN
.=============================================================================
. Routine to read the Last record and display it
.
MainLast
           CLEAR             VendorKY
           FILL              LastASCII,VendorKY
           CALL              RDVendor
           IF                (RETURNFL = 1)  . We didn't find a 'Blank' record
             CALL              KPVendor         . Try the 'Previous' record
             IF                (RETURNFL = 1)  . There are no records in the file
               BEEP
               ALERT             STOP,"No records exist in the system...",RESULT:
                                      LastTitle
               RETURN
             ENDIF
           ENDIF
.
. We've got a record (either on the READ or the READKP.  Let's now continue
. processing as if we just lost the Focus of the main field.  By calling the
. MainValid subroutine, that will take care of it for us.
           MOVE              "0",Status
           SETITEM           EVendAcctNo,0,Vendor.AccountNumber
           CALL              MainValid
           RETURN
.=============================================================================
. Routine to read the Next record and display it
.
MainNext
. We can't just do a simple READKS/READKP because of certain conditions including
. 'Attempting' to read past the last record (Next --> EOF) and the reverse
. condition.  Due to this fact, we need to get the current code, and THEN
. do a READKS/READKP
.
           GETCOUNT          EVendAcctNo
           IF                (CharCount <> 0)
             GETITEM           EVendAcctNo,0,VendorKY

             CALL              RDVendor
           ENDIF
.
           CALL              KSVendor         . Try the 'next' record
           IF                (RETURNFL = 1)  . There are no records in the file
             BEEP
             ALERT             STOP,"End of file has been reached.",RESULT:
                                    NextTitle
             RETURN
           ENDIF
.
. We've got a record (either on the READ or the READKS.  Let's now continue
. processing as if we just lost the Focus of the main field.  By calling the
. MainValid subroutine, that will take care of it for us.
           MOVE              "0",Status
           SETITEM           EVendAcctNo,0,Vendor.AccountNumber
           CALL              MainValid
           RETURN
.=============================================================================
. Routine to read the Previous record and display it
.
MainPrevious
. We can't just do a simple 'READKS' because of certain conditions including
. 'Attempting' to read past the last record (Next --> EOF) and the reverse
. condition.  Due to this fact, we need to get the current code, and THEN
. do a READKS/READKP
.
           GETCOUNT          EVendAcctNo
           IF                (CharCount <> 0)
             GETITEM           EVendAcctNo,0,VendorKY

             CALL              RDVendor
           ENDIF
.
           CALL              KPVendor         . Try the 'Previous' record
           IF                (RETURNFL = 1)  . There are no records in the file
             BEEP
             ALERT             STOP,"Beginning of file has been reached...",RESULT:
                                    PrevTitle
             RETURN
           ENDIF
.
. We've got a record (either on the READ or the READKS.  Let's now continue
. processing as if we just lost the Focus of the main field.  By calling the
. MainValid subroutine, that will take care of it for us.
           MOVE              "0",Status
           SETITEM           EVendAcctNo,0,Vendor.AccountNumber
           CALL              MainValid
           RETURN
.=============================================================================
. Save has been selected from the MENU vs. the Button
.
SAVEMODE
.
. OK...The 'Save' has been selected from the Menu rather than from the Save Button.
. What to do, What to do??  Is this a Save to a 'NEW' record or is it a Save to a
. 'CHANGED' record....
. Let's check the 'Status' flag...1 is a Change record, 2 is a New Record
.
           BRANCH            Status,MainChange,MainNew
           RETURN
.=============================================================================
. Routine to Validate the data from the Form
.
VALIDATE1
           MOVE              "0",ValidFlag

.X           GETITEM           EVendCode,0,TestChars
.X           COUNT             CharCount,TestChars
.X           IF                (CharCount = 0)
.X             MOVE            "1",ValidFlag
.X             BEEP
.X             ALERT             CAUTION,"A Code must be entered into the system",RETURNFL,"Error in Field"
.X             SETFOCUS          EVendCode
.X             RETURN
.X           ENDIF

.
. Everything's OK...Let's just return because the ValidFlag will be set to
. Zero from the top of this routine.
.
           MOVE              "0",ValidFlag
           RETURN
.=============================================================================
. Routine to 'Reset' everything which includes the Button's, Objects,
. fields, etc.
.
MAINRESET
..HR 7/28/2003           CINQTree.ClearNodes
           LVDetails.DeleteAllItems
..HR 714/2005           CTInq.ClearList
           MOVE              "0",Status     //Reset the status to Not updating
           UNLOCK            VendorFL
.
. Reset the fields to 'Blank' and DISABLE all of those fields as well
           DELETEITEM        VendCOLL,0
..HR 2017.4.17           SETPROP           EVendPhone,*Text=""
..HR 2017.4.17           SETPROP           EVendPhone,*Enabled=0
..HR 2017.4.17           SETPROP           EVendPhone,*BackColor=$BTNFACE


..HR 2017.4.17           DISABLEITEM       VendCOLL
           SETPROP           VendCOLL,READONLY=1
           SETPROP           VendCOLL,BGCOLOR=$BTNFACE
           ENABLEITEM        Fill1
.
. Reset the Buttons for the Next record
.
.INQ           DISABLEITEM       BMainChange
           DISABLETOOL       ID_Change

.INQ           DISABLEITEM       BMainDELETE
           DISABLETOOL       ID_Delete

.INQ           SETITEM           BMainCHANGE,0,ChangeTitle

.INQ           SETITEM           BMainNEW,0,NewTitle
           ENABLETOOL        ID_New

.INQ           ENABLEITEM        BMainNEW
.INQ           SETITEM           BMainCancel,0,ExitTitle

           DISABLETOOL       ID_Save
           DISABLETOOL       ID_Undo
           DISABLETOOL       ID_Cancel

           CALL              EnableRecordButtons
.
. Setup the Primary field that is used for Entry purposes
.
           %IFDEF            CBVendorActive
           SETITEM           CBVendorActive,0,0
           DISABLEITEM       CBVendorActive
           %ENDIF

           SETITEM           CBViewBy,0,1

           SETPROP           EVendAcctNo,READONLY=0
           SETPROP           EVendAcctNo,BGCOLOR=$WINDOW
           ENABLEITEM        EVendAcctNo
           SETFOCUS          EVendAcctNo
           RETURN
.=============================================================================
. Cancel Button has been Clicked
.
MAINCLOSE
.
. Only display this message if I'm in either the Modify or New mode.  If not,
. simply exit the program and proceed as normal
.
           IF                (Status <> 0)
             BEEP
             ALERT              PLAIN,"By Exiting the program now, your operation will be Cancelled?",RESULT:
                                      "Are you sure?"
             IF                 (RESULT = 1)
               DESTROY         WMAIN      . Get rid of the Bank Window
..fuckup               NORETURN                   . Get rid of the call to MAINCLOSE
..fuckup               RETURN                     . Return to the Main calling routine
                CHAIN           FROMPGM
             ELSE
               RETURN                     . Contine with standard operations
             ENDIF
           ENDIF
           DESTROY         WMAIN          . Get rid of the Bank Window
.FUCKUP           NORETURN                       . We don't need this call anymore
.FUCKUP           RETURN
              CHAIN             FROMPGM
.=============================================================================
. Cancel button has been pressed
.
MainCancel
           IF                (Status = 0)      . They want to exit the program
             DESTROY         WMAIN             . Get rid of the Main Window
.FUCKUP.FUCKUP             NORETURN
.FUCKUP             RETURN
              CHAIN             FROMPGM
           ELSE
             IF                (Status = 1 OR Status = 2)  . Change/New Mode
               BEEP
               ALERT              PLAIN,"Do you wish to cancel this operation?",RETURNFL:
                                        "Are you sure?"
               IF                 (RETURNFL = 1)
                 CALL               MAINRESET
                 RETURN
               ELSE
                 RETURN
               ENDIF
             ELSE
               CALL              MAINRESET
             ENDIF
             RETURN
           ENDIF
.=============================================================================
. Delete Button has been Pressed
.
MainDelete
           PARAMTEXT        Vendor.AccountNumber,VendorTitle,"",""
           BEEP
           ALERT            PLAIN,"Do you wish to Delete the ^1: ^0 ?",#RES1,DelTitle
           IF               (#RES1 = 1)
             CALL             DELVendor
             ALERT            NOTE,"A/P Term Code ^0 has been deleted",#RES1,DelOKTitle
             CALL             MAINRESET
           ENDIF
           RETURN
.=============================================================================
.
. Setup all of the fields in the Form based upon the data record
SETMAIN
           SETITEM           EVendAcctNo,0,Vendor.AccountNumber
SETMAIN2
              SETITEM           EVendName,0,Vendor.NAME
              SETITEM           EVendAddr1,0,Vendor.Address1
              SETITEM           EVendAddr2,0,Vendor.Address2
              SETITEM           EVendCity,0,Vendor.City
              SETITEM           EVendSt,0,Vendor.State
              SETITEM           EVendZip,0,Vendor.Zip

..HR 7/26/2005              SETITEM           EVendTaxCode,0,Vendor.TaxCode
..HR 7/26/2005              SETITEM           EVendDiscount,0,Vendor.Discount
..HR 7/26/2005              SETITEM           EVendAutoPay,0,Vendor.AutoApply
..HR 7/26/2005              SETITEM           EVendStatus,0,Vendor.Status
..HR 7/26/2005              SETITEM           EVendRating,0,Vendor.CreditRating
..HR 7/26/2005              SETPROP           EVendOver30,value=Vendor.DueOver30
..HR 7/26/2005              SETPROP           EVendOver60,value=Vendor.DueOver60
..HR 7/26/2005              SETPROP           EVendOver90,value=Vendor.DueOver90
..HR 7/26/2005              SETPROP           EVendCurrent,value=Vendor.CurrentAmtDue
..HR 7/26/2005              SETPROP           EVendTotal,Value=Vendor.TotalAmtDue
..HR 7/26/2005              SETPROP           EVendMTDDebits,Value=Vendor.MTDDebits
..HR 7/26/2005              SETPROP           EVendMTDCredits,Value=Vendor.MTDCredits
..HR 7/26/2005              SETPROP           EVendLastPurchAmt,Value=Vendor.LastPurchAmt

..HR 7/26/2005              PACK              Date10,Vendor.LastPurchMM,slash,Vendor.LastPurchDD,slash:
..HR 7/26/2005                                       Vendor.LastPurchYY

              SETPROP           EVendLastPurchDate,Text=Date10
..HR 2014.4.17              SETPROP           EVendPhone,*UseMaskChars=1

              SQUEEZE           Vendor.APPhone,Vendor.APPhone,"-"          //HR 4/6/2005

              SETPROP           EVendPhone,Text=Vendor.APPhone

..HR 2014.4.17              SETPROP           EVendPhone,*UseMaskChars=0
..HR 2014.4.17              SETPROP           EVendPhone,Text=Vendor.APPhone

              RETURN
.=============================================================================
. Retrieve all of the fields in the Form based upon the data record
.
GETMAIN
           GETITEM           EVendAcctNo,0,Vendor.AccountNumber
           GETITEM           EVendName,0,Vendor.Name
           GETITEM           EVendAddr1,0,Vendor.Address1
           GETITEM           EVendAddr2,0,Vendor.Address2
           GETITEM           EVendCity,0,Vendor.City
           GETITEM           EVendSt,0,Vendor.State
           GETITEM           EVendZip,0,Vendor.Zip
..HR 2014.4.17           SETPROP           EVendPhone,*UseMaskChars=0
           GETPROP           EVendPhone,Text=Vendor.APPhone
..HR 7/26/2005           GETITEM           EVendStatus,0,Vendor.Status
           RETURN
.=============================================================================
.Help Menu selection if required
.
MAINHELP
          RETURN

onClickMainWinChangeMenu
           PERFORM           RESULT OF  MAINNEW,MAINCHANGE,MainDelete,SAVEMODE
           RETURN
.=============================================================================.
onClickMainWinExitButton
.
. check to see if this is masquerading as a CANCEL button
.
           CALL              MainCancel
           RETURN
.=============================================================================.
onClickMainWinFileMenu
.
. process a click on the file menu
.
           PERFORM           result of MainPrint,,MAINCLOSE
           RETURN
.=============================================================================.
onClickMainWinHelpMenu
           PERFORM           result of MAINHELP,MAINHELP,MAINAbout
           RETURN
.=============================================================================.
. Display the Standard "About Box"
.
MAINAbout
.
. display an alert box describing the program
.
           FORMLOAD          About
           RETURN
.=============================================================================
. Print Report option
.
MainPrint
.X           CALL              PRTREPORT
           RETURN
MainToolBar
           RETURN

.=============================================================================
. Disable the 'Record' Buttons because we're in the middle of Updating or
. Creating a New record.
.
DisableRecordButtons
           DISABLETOOL       ID_First
           DISABLETOOL       ID_Next
           DISABLETOOL       ID_Previous
           DISABLETOOL       ID_Last
           DISABLETOOL       ID_Find
           RETURN
.=============================================================================
. Enable the 'Record' Buttons because we're in the middle of Updating or
. Creating a New record.
.
EnableRecordButtons
           ENABLETOOL        ID_First
           ENABLETOOL        ID_Next
           ENABLETOOL        ID_Previous
           ENABLETOOL        ID_Last
           ENABLETOOL        ID_Find
           RETURN
;=============================================================================
OnDoubleClickDetailListView
              LVTranDetails.GetNextItem giving ListViewRowSelected using *Flags=2,*Start=FirstRow
              LVTranDetails.GetItemText giving CheckNumberD using *Index=ListViewRowSelected:
                                                                  *Subitem=1

              MOVE              CheckNumberD,CheckNumber
              CALL              OnDoubleClickCheckListView2
              RETURN
.=============================================================================
OnDoubleClickCheckListView
              DISPLAY           "Got to the Double Click Check Event"
              LVCheckDetails.DeleteAllItems

              LVChecks.GetItemParam  giving CheckNumber using *Index=ListViewRowSelected
OnDoubleClickCheckListView2
              DISPLAY           "Row Selected : ",ListViewRowSelected
              DISPLAY           "Seq Num : ",CheckNumber
              MOVE              "1",BankREC.Code

              PACKKEY           CheckKY FROM $Entity,BankREC.Code,CheckNumber
              CALL              RDCheck
              IF                (ReturnFL = 1)
                ALERT             stop,"Check Information was not found",result,"Check Not Found"
                RETURN
              ENDIF

              UNPACK            Check.CheckDate,CC,YY,MM,DD
              PACK              Date8 FROM MM,"-",DD,"-",YY

              SETPROP           ECheckNumber,value=Check.CheckNo
              SETPROP           ECheckGrossAmt,value=Check.GrossAmount
              SETPROP           ECheckDiscAmt,value=Check.DiscAmt
              SETPROP           ECheckAmt,value=Check.CheckAmount
              SETITEM           Vinq6CheckDate,0,Date8

              PACKKEY           CheckDetailKY FROM $Entity,BankREC.Code,CheckNumber,"     "
              CALL              RDCheckDetail

              LOOP
                CALL              KSCheckDetail
              UNTIL             (ReturnFl = 1 or CheckDetail.CheckNo != Check.CheckNo)

                MOVE              CheckDetail.GrossAmount,GrossAmountD
                MOVE              CheckDetail.DiscAmt,DiscAmountD
                MOVE              CheckDetail.NetAmount,NetAmountD
                PACKKEY           APTRNKY2 FROM $Entity,CheckDetail.Voucher
                CALL              RDAPTRN2
                IF                (ReturnFL = 1)
                  ALERT             stop,"A/P Transaction does not exist",result,"Invalid Transaction"
                 RETURN
                ENDIF

                CHOP              APTRN.Invoice
                UNPACK            APTRN.TransDate,CC,YY,MM,DD
                PACK              Date8 FROM MM,"-",DD,"-",YY

                LVCheckDetails.InsertItemEx using *Text=APTRN.Invoice:
                                                 *Param=CheckDetail.SeqMinor:
                                                 *SubItem1=Date8:
                                                 *SubItem2=GrossAmountD:
                                                 *SubItem3=DiscAmountD:
                                                 *SubItem4=NetAmountD
              REPEAT
              SETPROP           WVinq6,visible=1

              RETURN
.=============================================================================
.
OnDoubleClickListView
              DISPLAY           "Got to the Double Click Event"
              EventInfo             0,Result=ListViewRowSelected
              LVTranDetails.DeleteAllItems
..HR 7/15/2005             GetProp           CTInq,*ListColumnText(int2,2)=APTRN.Invoice
..HR 7/15/2005             GetProp           CTInq,*ListColumnText(int2,5)=OrigAmtD
..HR 7/15/2005             GetProp           CTInq,*ListColumnText(int2,6)=BalanceD
..HR 7/15/2005             GetProp           CTInq,*ListColumnText(int2,7)=DATE10

              LVDetails.GetItemParam  giving SeqNum using *Index=ListViewRowSelected
              DISPLAY           "Row Selected : ",ListViewRowSelected
              DISPLAY           "Seq Num : ",SeqNum

              PACKKEY           APTRNKY2 FROM $Entity,SeqNum
              CALL              RDAPTRN

              SETITEM           VInq4Invoice,0,APTRN.Invoice
              SETITEM           VInq4Amt,0,OrigAmtD
              SETITEM           VInq4Balance,0,BalanceD

              UNPACK            APTRN.TransDate,CC,YY,MM,DD
              PACK              Date10 from MM,"/",DD,"/",YY

              setprop           VInq4InvoiceDate,text=Date10
..HR 9/20/2005              SETPROP           VInq4InvoiceDate,*Text=DATE10

           PACKKEY           APDetKY,$Entity,SeqNum,"   "
           SETLPTR           APDetKY
           CALL              RDAPDet
           LOOP
             CALL              KSAPDet
           UNTIL             (RETURNFL = 1 OR SeqNum <> APDetail.SeqMajor)         //   CC YY MM DD
             UNPACK            APDetail.TransDate,CC,YY,MM,DD                      //   20 04 06 13
             PACK              TransDate10,MM,"/",DD,"/",YY                        //   06/13/04

             UNPACK            APTRN.DueDate,CC,YY,MM,DD
             PACK              DueDate10,MM,"/",DD,"/",YY

              SWITCH            APDetail.TransCode

              CASE              "0"                                 //Invoice
                MOVE              "Invoice:",TransDesc
              CASE              "7"                                 //Check
                MOVE              "Check:",TransDesc
              CASE              "6"                                 //Discount
                MOVE              "Discount:",TransDesc
              CASE              "8"                                 //Voided Check
                MOVE              "Voided Check:",TransDesc
              DEFAULT
                MOVE              " ",TransDesc
              ENDSWITCH

              UNPACK            APDetail.TransDate,CC,YY,MM,DD
              PACK              Date8 FROM MM,"-",DD,"-",YY
              MOVE              APDetail.Amount,AmountD

              LVTranDetails.InsertItemEx using *Text=TransDesc:
                                               *Param=APDetail.SeqMinor:
                                               *SubItem1=APDetail.ReferenceNo:
                                               *SubItem2=Date8:
                                               *SubItem3=AmountD
.
..HR 9/20/2005             LVTranDetails.AddItem     giving X using DataLine
..              LVTranDetails.InsertItemEx using
.             SetProp           LVTranDetails,*ListCargo(X)=APDetail.Memo

              REPEAT
              SETPROP           WVinq4,visible=1
              RETURN
.=============================================================================
OnClickDisplayDetails
              eventinfo         0,ARG1=NodeNum
.              GetProp           LVTranDetails,*ListCargo(NodeNum)=MemoField
              SETITEM           EVinq4Memo,0,MemoField
              RETURN

.=============================================================================

SetInitialVendorIDStatistics
           RETURN

..........................................................................................
SetVendorHistoryYears
              DeleteItem        CBVinqYear,0                       //HR 9.30.2014
              MOVE              "0",result
              PACKKEY           VHSTKY,$Entity,Vendor.AccountNumber,"9999"
              CALL              RDVHST
              LOOP
                CALL            KPVHST
              UNTIL             (ReturnFL = 1 or VendorHistory.Vendor != Vendor.AccountNumber)
                IF                (Result = 0)        //No year has been selected yet
                  MOVE              VendorHistory.Year,SelectedYear
                ENDIF
                InsertItem        CBVInqYear,99,VendorHistory.Year
                ADD               "1",result
              REPEAT
              SETITEM           CBVINQYear,0,result
              RETURN
..........................................................................................
SetVendorHistoryStatistics
           GETITEM           CBVinqYear,0,result
           GETITEM           CBVInqYear,result,SelectedYear
           PACKKEY           VHSTKY,$Entity,Vendor.AccountNumber,SelectedYear
.           InsertItem        CBCINQYear,99,"2002"                         //temporary
....           SETITEM           CBCINQYear,0,1
           CALL              RDVHST
           DISPLAY           "RETURNFL = ",RETURNFL
           FOR                X FROM "0" TO "12" USING "1"
             IF                (ReturnFL = 0)

              MOVE              VendorHistory.PurchAmt(X+1),PurchAmtD
              MOVE              VendorHistory.PaidAmt(X+1),PaidAmtD
              MOVE              VendorHistory.DiscAmt(X+1),DiscAmtD

               LVSummary.SetItemText using *Index=X,*SubItem=1,*Text=PurchAmtD
               LVSummary.SetItemText using *Index=X,*SubItem=2,*Text=PaidAmtD
               LVSummary.SetItemText using *Index=X,*SubItem=3,*Text=DiscAmtD
             ELSE
               LVSummary.SetItemText using *Index=X,*SubItem=1,*Text="-"
               LVSummary.SetItemText using *Index=X,*SubItem=2,*Text="-"
               LVSummary.SetItemText using *Index=X,*SubItem=3,*Text="-"
             ENDIF
           REPEAT

           RETURN
.=============================================================================
ViewHistoryByOptions
              LVDetails.DeleteAllItems

..HR 2014.4.17              GETMSDATE         DTFromDate,RangeFromDate
..HR 2014.4.17              GETMSDATE         DTToDate,RangeToDate
                   getprop           DTFromDate,text=RangeFromDate
                   getprop           DTToDate,text=RangeToDate

           GETITEM           CBViewBy,0,ViewByOption
           move              "CHIRON",$ENTITY

           IF (ViewByOption = 1)   //Open Items Only
             PACKKEY           APTRNKY4,$Entity,Vendor.AccountNumber,"O"
           ENDIF

           IF (ViewByOption = 2)   //Closed Items Only
             GETPROP           DTFromDate,text=DATE10
             move              date10 into date8
..HR 2014.4.17             parse             DATE10,MM using "09"
..HR 2014.4.17             MOVE              MM,MMF
..HR 2014.4.17             BUMP              Date10

..HR 2014.4.17             parse             DATE10,DD using "09"
..HR 2014.4.17             MOVE              DD,DDF
..HR 2014.4.17             BUMP              Date10
..HR 2014.4.17             parse             DATE10,YYYY using "09"

..HR 2014.4.17             PACKKEY           DATE8,YYYY,MMF,DDF
             REPLACE           " 0",DATE8
             PACKKEY           APTRNKY4,$Entity,Vendor.AccountNumber,"C",Date8

             GETPROP           DTToDate,text=DATE10
..HR 2014.4.17             parse             DATE10,MM using "09"
..HR 2014.4.17             MOVE              MM,MMF
..HR 2014.4.17             BUMP              Date10

..HR 2014.4.17             parse             DATE10,DD using "09"
..HR 2014.4.17             MOVE              DD,DDF
..HR 2014.4.17             BUMP              Date10
..HR 2014.4.17             parse             DATE10,YYYY using "09"

..HR 2014.4.17             PACKKEY           DATE8,YYYY,MMF,DDF
             move                    date10,date8
             REPLACE           " 0",DATE8
              MOVE              DATE8,RangeToDate
           ENDIF

              MOVE              "0",VendorBalance
              MOVE              "0",Row

           CALL              RDAPTRN4                                   //HR 9/6/2005
           LOOP
             CALL              KSAPTRN4                                 //HR 9/6/2005
           UNTIL             (RETURNFL = 1 or (APTRN.Vendor <> Vendor.AccountNumber) or:
                             (ViewByOption = 2 and APTRN.ClosedFlag != "C") or:
                             (ViewByOption = 2 and APTRN.TransDate > RangeToDate))        //HR 8/5/2003

             UNPACK            APTRN.TransDate,CC,YY,MM,DD         //HR 7/29/2003
             PACK              TransDate10,MM,"/",DD,"/",YY

             CHOP              APTRN.Invoice,APTRN.Invoice

              UNPACK            APTRN.DiscDate into CC,YY,MM,DD
              PACKKEY           DiscountDate FROM MM,slash,DD,slash,YY

              UNPACK            APTRN.DueDate into CC,YY,MM,DD
              PACKKEY           DueDate FROM MM,slash,DD,slash,YY

              MOVE              APTRN.OrigAmt,GrossAmountD

              MOVE              APTRN.Balance,NetAmount

              MOVE              APTRN.DiscAmt,DiscAmountD

..HR 9/20/2005              CALC              NetAmount = APTRN.Balance - APTRN.DiscAmt

              MOVE              NetAmount,NetAmountD

             CHOP              APTRN.PO,APTRN.PO

             PACK              DATALINE FROM APTRN.Invoice,";":
                                             APTRN.PO,";":
...                                             APTRN.PO,";":
                                             APTRN.OrigAmt,";":
                                             APTRN.Balance,";":
                                             TransDate10,"; ;"

              ADD               APTRN.Balance,VendorBalance
              MOVE              APTRN.SeqMajor,SeqMajorD

               LVDetails.InsertItemEx using *Text=SeqMajorD:
                                             *Param=APTRN.SeqMajor:
                                             *Index=Row:
                                             *SubItem1=APTRN.Invoice:
                                             *SubItem2=DueDate:
                                             *SubItem3=DiscountDate:
                                             *SubItem4=GrossAmountD:
                                             *SubItem5=DiscAmountD:
                                             *SubItem6=NetAmountD

              ADD               "1",Row
           REPEAT

              MOVE              VendorBalance,VendorBalanceD
              SETITEM           EVInqBalance,0,VendorBalanceD


              IF (ViewByOption = 1)   //Open Items Only
              ENDIF

              IF (ViewByOption = 2)   //Closed Items Only
..HR 7/15/2005                SETPROP         CTInq,*SortColumn="-1"
..HR 7/15/2005                SETPROP         CTInq,*SortDirection="1"
              ENDIF
              CALL              LoadCheckDetails
              RETURN
;=============================================================================
LoadCheckDetails
              LVChecks.DeleteAllItems
              SETLPTR           $Entity

              PACKKEY           CheckKY2 FROM $Entity,Vendor.AccountNumber,RangeFromDate
              CALL              RDCheck2
              LOOP
                CALL              KSCheck2
              UNTIL             (ReturnFl = 1 or Check.Entity != $Entity or:
                                Check.Vendor != Vendor.AccountNumber or:
                                Check.CheckDate > RangeToDate)
                READKEY           CheckFL2,CheckKY2

                MOVE              Check.CheckNo,CheckNoD
                UNPACK            Check.CheckDate into CC,YY,MM,DD
                PACKKEY           CheckDate FROM MM,"/",DD,"/",YY

                MOVE              Check.DiscAmt,DiscAmountD
                MOVE              Check.CheckAmount,NetAmountD
                MOVE              Check.GrossAmount,GrossAmountD

                LVChecks.InsertItemEx using *Text=CheckKY2:
                                            *Param=Check.CheckNo:
                                            *SubItem1=GrossAmountD:
                                            *SubItem2=DiscAmountD:
                                            *SubItem3=NetAmountD:
                                            *SubItem4=CheckDate:
                                            *SubItem5=CheckNoD

              REPEAT
              RETURN
.=============================================================================
PrintStatement
              RETURN
.=============================================================================
ReprintInvoices
              RETURN
.=============================================================================
ViewComments
              CALL                  CommentInq using Vendor.AccountNumber
              RETURN
;=============================================================================
SetupLVColumns
              LVDetails.InsertColumn using "APSeqKY",0,1,0
              LVDetails.InsertColumn using "Invoice Number",100,2,0
              LVDetails.InsertColumn using "Due Date",65,3,0
              LVDetails.InsertColumn using "Disc. Date",65,4,1
              LVDetails.InsertColumn using "Gross Amt",65,5,1
              LVDetails.InsertColumn using "Disc. Amt",65,6,1
              LVDetails.InsertColumn using "Net Amt",65,7,1

              LVTranDetails.InsertColumn using "Type",80,1,0
              LVTranDetails.InsertColumn using "Check/Reference",100,2,0
              LVTranDetails.InsertColumn using "Trans Date",80,3,0
              LVTranDetails.InsertColumn using "Amount",80,3,1

              LVChecks.InsertColumn using "CheckKY",0,1,0                  //HR 8/23/2005
              LVChecks.InsertColumn using "Gross Amt",80,2,1               //HR 8/23/2005
              LVChecks.InsertColumn using "Disc. Amt",80,3,1               //HR 8/23/2005
              LVChecks.InsertColumn using "Check Amt",80,4,1               //HR 8/23/2005
              LVChecks.InsertColumn using "Check Date",80,5,1              //HR 8/23/2005
              LVChecks.InsertColumn using "Check Number",100,6,1           //HR 8/23/2005

              LVCheckDetails.InsertColumn using "Invoice",120,1,0
              LVCheckDetails.InsertColumn using "Inv Date",65,2,0
              LVCheckDetails.InsertColumn using "Gross Amt",80,3,1
              LVCheckDetails.InsertColumn using "Disc. Amt",70,4,1
              LVCheckDetails.InsertColumn using "Net Amt",75,5,1

              LVSummary.InsertColumn using "Month",80,1,0
              LVSummary.InsertColumn using "Purchases",75,2,1
              LVSummary.InsertColumn using "Payments",75,3,1
              LVSummary.InsertColumn using "Disc. Amt",75,4,1

              LVSummary.InsertItemEx using *Index=1,*Text="January":
                                                    *SubItem1="-":
                                                    *SubItem2="-":
                                                    *SubItem3="-"

              LVSummary.InsertItemEx using *Index=2,*Text="February":
                                                    *SubItem1="-":
                                                    *SubItem2="-":
                                                    *SubItem3="-"

              LVSummary.InsertItemEx using *Index=3,*Text="March":
                                                    *SubItem1="-":
                                                    *SubItem2="-":
                                                    *SubItem3="-"

              LVSummary.InsertItemEx using *Index=4,*Text="April":
                                                    *SubItem1="-":
                                                    *SubItem2="-":
                                                    *SubItem3="-"

              LVSummary.InsertItemEx using *Index=5,*Text="May":
                                                    *SubItem1="-":
                                                    *SubItem2="-":
                                                    *SubItem3="-"

              LVSummary.InsertItemEx using *Index=6,*Text="June":
                                                    *SubItem1="-":
                                                    *SubItem2="-":
                                                    *SubItem3="-"

              LVSummary.InsertItemEx using *Index=7,*Text="July":
                                                    *SubItem1="-":
                                                    *SubItem2="-":
                                                    *SubItem3="-"

              LVSummary.InsertItemEx using *Index=8,*Text="August":
                                                    *SubItem1="-":
                                                    *SubItem2="-":
                                                    *SubItem3="-"

              LVSummary.InsertItemEx using *Index=9,*Text="September":
                                                    *SubItem1="-":
                                                    *SubItem2="-":
                                                    *SubItem3="-"

              LVSummary.InsertItemEx using *Index=10,*Text="October":
                                                    *SubItem1="-":
                                                    *SubItem2="-":
                                                    *SubItem3="-"

              LVSummary.InsertItemEx using *Index=11,*Text="November":
                                                    *SubItem1="-":
                                                    *SubItem2="-":
                                                    *SubItem3="-"

              LVSummary.InsertItemEx using *Index=12,*Text="December":
                                                    *SubItem1="-":
                                                    *SubItem2="-":
                                                    *SubItem3="-"

              LVSummary.InsertItemEx using *Index=13,*Text="YTD Totals":
                                                     *SubItem1="-":
                                                     *SubItem2="-":
                                                     *SubItem3="-"
              RETURN
;==========================================================================================================
KeyPress_EVendAcctNo
                   F2SEARCH          EVendAcctNo,Vendor
                   IF                 (PassedVar = "Y")
                   CALL               MainValid
                   ENDIF
                   RETURN
;==========================================================================================================
Click_CBVinqYear
                   call               SetVendorHistoryStatistics
                   RETURN
;==========================================================================================================
Change_EVendAcctNo
                   READAHEAD         EVendAcctNo,Vendor,AccountNumber
                   RETURN
;==========================================================================================================
DblClick_LVChecks
                   EventInfo         0,result=ListViewRowSelected
                   call               OnDoubleClickCheckListView
                   RETURN
;==========================================================================================================
GetLastInvoice



                   return
;=============================================================================
                   include           MenuDefs.inc

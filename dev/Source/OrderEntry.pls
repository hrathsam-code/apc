;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    4 NORFOLK LANE                                           ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    OrderEntry                                                     ;
;                                                                             ;
;   AUTHOR:    HARRY RATHSAM                 Gilbs157@gmail.com               ;
;                                                                             ;
;     DATE:    05/07/2015 AT 2:54AM                                           ;
;                                                                             ;
;  PURPOSE:                                                                   ;
;                                                                             ;
; REVISION:    VER     DATE     INIT       DETAILS                            ;
;                                                                             ;
;              1.0   05/07/2015   HOR     INITIAL VERSION                     ;
;                                                                             ;
;                                                                             ;
;=============================================================================;

; Add Reprint Logic to Inquiry Program, Order Entry Programs

; ************     Add weight, cartons to Invoice Header
; ************     add auto fill in to shipped/ordered quantities
; ************     Add ISO Certification        ISO-9001:2015
; ************     Remove Prod field from Entry and expand Part Number
; ************     Add completed flag to printouts
;
;
; Remove New Change Delete Buttons and change to "Accept"
;
;
; On New,Enable all Header objects and on Accept Button, check out info
;
; On Change,
;      Enter Part Number
;      Validate Part Number
;      Bring up Browse of available kits that can be updated
;      If selected, bring up all Kit Details and Create an ItemRow for each Kit Detail\
;      Setup Change Button and turn on/off appropriate buttons

                    include            NCOMMON.TXT
                   INCLUDE           WORKVAR.INC
#RESULT            FORM              1
#RES1              FORM              1
#DIM1              DIM               1
#DIM2              DIM               2
#RES2              FORM              2
#LEN1              FORM              3
#MenuItem          DIM               25
ShipToNum           form               4
.ShipToCustomer     dim               6                 //HR Fuckup 2019.8.28
ShipDate      DIM               10
BillDate      DIM               10
LightGray     COLOR
LightGrayRGB  FORM              8
TempInvoice   FORM              9
TempInvCust      DIM               30
PreviewFlag         form               1

ContactName    DIM               25

BackOrderQuantity   form               6.4
OrderQuantity       form               6.4
ShipQuantity        form               6.4
OrderPrice          form               6.4
ExtendedPrice       form               8.4
UOM                 dim                2

Document     FORM              9

CommentLine         form               3
CompletedFlag       form               1
ShipToCustomer     dim               6
SaveShipTo          form               4
LoadFromOrderFlag  form              1


$EntryProgram       equate             2

                    GOTO               STARTPGM
                    include            Sequence.FD
                    include            Default.FD
                    INCLUDE            Parts.FD
                    include            Cust.FD
                    include            ShipTo.FD
.                    include            Customer.FD
                    include            OrderHeader.FD
                    include            OrderDetails.FD
                    include            Invoices.FD
                    include            InvDetails.FD
                    include            InvNotes.FD
                    include            CustomerPartDiscounts.FD
                    include            TaxCode.FD
                    include            Chst.FD
                    include            ARTrn.FD
                    include            ARDet.FD
                    include            Cntry.FD
                    include            CustD.FD
                    include            ARTrm.FD

OrderDetailArray    record             like OrderHeader(100)

MAIN                PLFORM             OrderEntry.PLF
DataMenu            PLFORM             DataMenu.PLF
ShipToF             plform             OrderEntry3.plf

.SaveOrderHeader       like               OrderHeader.OrderNumber
StartingDate        dim                10
EndingDate          dim                10
CompanyLogo         Pict
CompanyLogo2        Pict
X                   form               2
EditTop             FORM               4
EditBottom          FORM               4
EditLeft            FORM               4
EditRight           FORM               4

LastKitEditRow      form               6

RowSelected3        FORM               3
LastEditRow         form               6

StartDate           dim                8
EndDate             dim                8
EndDateFlag         form               1
PartPrice           like               Parts.Price
Divisor            form               8.4
InvSubTotal   FORM              7.2            //HR 4/1/2005
InvoiceType   DIM               13              //HR 3/25/2005

DiscountAmt         form               6.4

TermCodeArray       dim                8(0..99)
TermCodeCounter     form               3

CopyMessage   DIM               30
OrigMessage   INIT              "ORIGINAL INVOICE"
CertMessage   init              "CERTIFICATE OF CONFORMANCE"
DupeMessage   INIT              "DUPLICATE INVOICE"
PostMessage   INIT              "POSTING COPY"
CopyNumber    FORM              1
PrintType     DIM               1
PrintFromDate DIM               8
PrintToDate   DIM               8
PrintFromInvoiceD  DIM          9          //HR 4/26/2005
PrintToInvoiceD    DIM          9          //HR 4/26/2005
PrintFromInvoice  FORM          9          //HR 4/26/2005
PrintToInvoice    FORM          9          //HR 4/26/2005

PrtInvType    FORM              1                 //HR 4/14/2005


OrderDetailQuantity form               9.2(0..50)
OrderDetailPrice    form               5.4(0..50)

AddressLines        DIM               45(5)
ShipToAddressLines  DIM               45(5)
AddressLineCounter FORM         2
ShipToAddressLineCounter FORM         2


HeaderLV            edittext           (0..50)

NQuantityOrdered    editnumber         (0..50)
NQuantityShipped    editnumber         (0..50)
NQuantityBackOrder  editnumber         (0..50)
EPartNumber         EDITTEXT           (0..50)
..EProductGroup       edittext           (0..50)
NPrice              editnumber         (0..50)
EUOM                edittext           (0..50)
NExtended           editnumber         (0..50)
EAdditionalLines    dim                1000(0..50)
PrtAdditionalLines  dim                40(25)             //HR 2019.10.16  (25)

.                                          "QTY ORD  QTY SHP  QTY B/O  PART NUMBER  ":
.                                          "PROD  PRICE  UOM EXTENSION ",*HOFF

..NDiscount           editnumber         (0..50)
..NQuantity           editnumber         (0..50)
EBModify            button             (0..50)
EBDelete            button             (0..50)

PartNumberArray     record             (0..50) like Parts

AgingDays           form               4
DiscountDays        form               4
DiscountPercent     form               2.2
...TodayDays           form               10
FormLineNo    FORM              4
FieldCount    FORM              3


InvoicesToReset FORM            9(1000)        //HR 4/20/2005
ResetNumber   FORM              4               //HR 4/20/2005
IndexCounter  FORM              4
IndexCounter2 FORM              4
SortedCounter FORM              4
SortedInvoice FORM              9(1000)
SortedCustomer DIM              30(1000)

GLTotals      FORM              8.2
GLValue       FORM              8.2


PrtInvoice    PLFORM            PrtInv.PLF

KeyPress            form               3
.

                    include            PrintRtn.INC

STARTPGM           ROUTINE
                   INCLUDE           SECURITY.INC
                   MOVE              "1",ProgLoaded
.
. If we're unable to find the Help file, then we're going to simply just not make
. the F1 Function key available to the Users
.
                   MOVE              "AppDir;HELPDIR",EnvData
                   CLOCK             INI,EnvData
                   IF                NOT OVER
                     PACK              EnvData,EnvData,PartsHelp
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
                   TRAP              NOFILE NORESET IF IO
..                   CALL              OPENParts
                   TRAPCLR           IO

                   call                OpenOrderHeader
                   call                OpenOrderDetails
                    call               OpenSequence
                    call               OpenCust
                    call               OpenShipTo
..                    call               OpenCustomer
..                    call               OpenCustomerPartDiscounts
..                    call               OpenTaxCode
                    call               OpenInvoices
                    call               OpenInvDetails
                    call               OpenInvNotes
                    call               OpenARTrn
                    call               OpenARDet
                    call               OpenCustD
                    call               OpenCHST
                    call               OpenARTrm
                    call               OpenCntry

SalesFLST          filelist
SalesFL2           ifile             name="MSSALES.ISI",NODUP
SalesFL            ifile             name="MSSalesPO.isi",DUP
                   filelistend

                   debug
                   index             "MSSales.txt,MSSalesPO -p30=S,31-48,27-29,1-26"

Sales              record
PartNumber         DIM               20            (MILSPEC PART NUMBER)
TransDate          DIM               6             (DATE .. 831201)
Suffix             DIM               3             (000-999)
Type               DIM               1             (S=SALE, Q=QUOTATION)
PONumber           DIM               18            (CUSTOMER PURCHASE ORDER NUMBER)
UOM                DIM               2             (EA=EACH,PC=PIECE,C=HUNDRED,M=THOUSAND,(BG=BAG,BX=BOX,FT=FOOT,LB=POUND,OZ=OUNCE)
Quantity           FORM              5.2           (QUANTITY SOLD)
SaleDate           DIM               6             (DATE OF SALE)
CustomerCode       DIM               4             (A/R SYSTEM CUSTOMER CODE)
Price              FORM              5.2           (SELLING PRICE PER UNIT OF PURCHASE)
Name               DIM               20            (NAME KEYED IN)
                   recordend

SalesKY            dim               41
                   open              SalesFLST,read

PartsCOLL          COLLECTION
PartsEDT           COLLECTION
PartsActive        COLLECTION

PartEntryColl       collection
PartQtyColl         collection


OrderHeaderColl       collection
CustCollection      collection
ShipCollection      collection
EditCollection      collection

;
; Includes ALL fields
;
                    CREATE                 LightGray=*LTGRAY               //HR 6/2/2005
                    GETITEM                LightGray,0,LightGrayRGB        //HR 6/2/2005
                    listins                EditCollection,STPONO,EWeight:
                                                          ECartons,NFreight

                    LISTINS           ShipCollection,STShipName,STShipAddress1:
                                                STShipAddress2,STShipAddress3:
                                                STShipCity,STShipSt,STShipZip:
                                                STShipCountry:
                                                STPONO:
                                                ESalesRep

           LISTINS           CustCollection,ECustName,ECustAddr1,ECustAddr2,ECustAddr3:
                                     ECustCity,ECustSt,ECustZip,ECustCountry

                    LISTINS            PartsColl,ECustomerID

                    LISTINS            PartsEDT,ECustomerID

                    LISTINS            PartsActive,ECustomerID

                    listins            OrderHeaderColl,DTOrderDate,CBCompleted
;
;
.                   winhide
                    FORMLOAD           MAIN

                    FORMLOAD          PrtInvoice,WMain

                    FORMLOAD           DataMenu,WMain
                    formload           ShipToF,WMain

                    call               MainReset
                    call               SetupLVColumns
                    call               LoadTerms

..HR 2019.7.24                    CREATE             CompanyLogo=100:349:100:930,"f:\apc\CompanyLogo.jpg"
                    CREATE             CompanyLogo=100:379:100:957,"\apc\CompanyLogo3.jpg"
..HR 2019.7.15                    CREATE             CompanyLogo2=100:349:100:681,"f:\apc\CompanyLogo2.jpg"

.                     MenuToolBar.AddButton using *ImageIndex=25:
.                                                 *Tag=71:
.                                                 *visible=1:
.                                                 *runName="ID_Comment":
.                                                 *Tooltip="Add/View Comments"
..                                                                 914-260-3178 Denise

                    setfocus           ECustomerID

                    LOOP
                      WAITEVENT
                    REPEAT
.
. We never get here!!   Just in case though.... :-)
.
                   RETURN
.                  STOP

BROWSEFILE         ROUTINE
...SEARCH             PLFORM            SearchAll.plf
SEARCH             PLFORM            KitSearch.plf
                   FORMLOAD          SEARCH
                   display             "Search Key",$SearchNum
;
; Logic here to capture the proper Kit Information
;
                   RETURN

INITSRCH
                   PACK              SearchTitle,"Select Kit Header to Modify"                // "," Search Window"
.                  SETPROP           WSearch,*Title=SearchTitle

.                   CTADDCOL          "Kit Part Number",100,"Start Date",100:
.                                     "End Date",100:
.                                     "Price",100

.                   ResetVar           SaveOrderHeader
.                   getprop            EOrderNumber,text=SaveOrderHeader
.                   setlptr            SaveOrderHeader,20
.                   move               SaveOrderHeader,OrderHeaderKY

.                   call               RDOrderHeader
.                   loop
.                     call               KSOrderHeader
.                   until (ReturnFl = 1 or OrderHeader.KitPartNumber != SaveOrderHeader)

.                   unpack             OrderHeader.StartingDate into yyyy,mm,dd
.                   pack               StartingDate from mm,slash,dd,slash,yyyy

.                   squeeze            OrderHeader.EndingDate,OrderHeader.EndingDate
.                   if                 (OrderHeader.EndingDate != "")
.                     unpack             OrderHeader.EndingDate into yyyy,mm,dd
.                     pack               EndingDate from mm,slash,dd,slash,yyyy
.                   else
.                     move               "--------",EndingDate
.                   endif

.                   pack               LVDataLine from OrderHeader.KitPartNumber,";",StartingDate,";",EndingDate,";",OrderHeader.KitPrice
.                   squeeze            LVDataLine,LVDataLine

.                     LVSearchPLB.SetItemTextAll using *Index=9999,*Text=LVDataLine,*Delimiter=";",*Param=OrderHeader.SeqNo
.                   repeat

.                   setfocus           LVSearchPLB
.                   LVSearchPLB.GetNextItem giving result using *Flags=1,*Start=FirstRow
.                   display            "NextItem : ",result
.                   if                 (result = -1)                             //Nothing selected
.                   LVSearchPLB.SetItemState    using *Index=0,*State=3,*StateMask=3
.                   endif
                    RETURN
.
. Routines that operate the Main program
.
NOFILE
                   NORETURN
                   ALERT             PLAIN,"A/P Terms Master file does not exist. Do you wish to create it?",#RESULT
                   IF                (#RESULT = 1)
                     CALL              PREPParts
                     GOTO              OPENFILES
                   ENDIF
                   STOP
;==========================================================================================================
PrintPreviewReport
                   return

.X READOPT         DIM               12
.X PAGED           DIM               4
.X NEXTLINE        INIT              127
.X PRTFILE         PFILE
.X PRTCOUNT        FORM              6
.X PRTCOUNTD       FORM              6
.X PRGTITLE        INIT              "A/P Terms MAster Listing"
.X PAGETITLE       DIM               60
.X DIM500          DIM               500
.X PRTWIDTH        FORM              8
.X PRTHEIGHT       FORM              8
.X DIM8            DIM               8
.X COL             FORM              3
.X ROW             FORM              3
.X MAXROWS         FORM              3
.X ACCT            DIM               9
.X TODAY8          DIM               8
.X TIME8           DIM               8
.X NUM1            FORM              3
.X NUM2            FORM              3
.X ToCode          DIM               8
.X .
;==========================================================================================================
PrintReport

.X PRTREPORT
.X PartsRPT        PLFORM            PartsRPT.PLF
.X .               WINHIDE
.X
.X                 CLOCK             DATE,TODAY8
.X                 CLOCK             TIME,TIME8
.X
.X                 MOVE              "60",MAXROWS
.X                 MOVE              "0",PAGE
.X                 MOVE              "90",LINE
.X
.X                 FORMLOAD          PartsRPT
.X                 LOOP
.X                   WAITEVENT
.X                 REPEAT
.X
.X                 RETURN
.X
.X .               alert             note,"how???",returnfl
.X .               LOOP                                              .Wait...and Wait...
.X .                 WAITEVENT                                       .
.X .               REPEAT                                            .and wait
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
.X                 CLOCK             DATE,TODAY8
.X                 CLOCK             TIME,TIME8
.X
.X                 MOVE              "60",MAXROWS
.X                 MOVE              "0",PAGE
.X                 MOVE              "90",LINE
.X                 MOVE              "0",PRTCOUNT
.X .
.X . Process all Vendors in Sorted Order
.X .
.X                 MOVE              " ",PartsKY
.X
.X                 GETITEM           RAll,0,RETURNFL
.X                 BRANCH            RETURNFL OF ALL
.X
.X                 GETITEM           EFromRange,0,PartsKY
.X                 GETITEM           EToRange,0,ToCode
.X
.X                 IF                (ToCode < PartsKY)
.X                   BEEP
.X                   ALERT             STOP,"From Code cannot be less than the To Code",RETURNFL,"Range Error"
.X                   SETFOCUS          ETORANGE
.X                   RETURN
.X                 ENDIF
.X
.X ALL
.X                 TRAP              NOPRINT IF SPOOL
.X                 PRTOPEN           PRTFILE,"@?","A/P Term Code Listing"
.X                 TRAPCLR           IO
.X
.X                 CALL              PRTHEADER2
.X
.X
.X                 CALL              RDParts
.X                 LOOP
.X                   CALL              KSParts
.X                 UNTIL             (RETURNFL = 1 OR Parts.PartNumber > ToCode)
.X                   CALL              PRTLINE
.X                 REPEAT
.X .
.X . Print Totals line
.X .
.X                 IF                (LINE + 4 > MAXROWS)
.X                   CALL              PRTHEADER
.X                 ENDIF
.X                 PRTPAGE           PRTFILE;*N=3,PRTCOUNT," A/P Term Records Printed"
.X                 PRTCLOSE          PRTFILE
.X                 RETURN
.X .
.X . Print Each Detailed line
.X .
.X PRTLINE
.X                 ADD               "1",PRTCOUNT
.X                 MOVE              PRTCOUNT,PRTCOUNTD
.X
.X                 IF                (LINE > MAXROWS)
.X                   CALL              PRTHEADER
.X                 ENDIF
.X                 CHOP              Parts.NETDAYS,Parts.NETDAYS
.X                 CHOP              Parts.DISCDAYS,Parts.DISCDAYS
.X
.X                 MOVE              Parts.NETDAYS,NUM1
.X                 MOVE              Parts.DISCDAYS,NUM2
.X
.X                 PRTPAGE           PRTFILE;*1,Parts.PartNumber:
.X                                           *16,Parts.Desc:
.X                                           *Alignment=*Right:
.X                                           *38,Num1:
.X                                           *50,Num2:
.X                                           *Alignment=*Decimal:
.X                                           *61,Parts.DiscPerc:
.X                                           *Alignment=*Left
.X
.X                 ADD       "2" TO LINE
                 RETURN
;==========================================================================================================
.X
.X PRTHEADER
.X                 PRTPAGE           PRTFILE;*NEWPAGE;
.X PRTHEADER2
.X                 CALC              COL=PRTWIDTH-15
.X                 ADD               "1",PAGE
.X                 MOVE              PAGE,PAGED
.X .               SETITEM           EPage,0,PAGED
.X
.X                 PRTPAGE           PRTFILE;*P1:63,*LINE=85:63:
.X                                           *N:
.X                                           *40,"Page :",*alignment=*left,PAGE:
.X                                           *P1:1:
.X                                           *P1:1,"Date : ",TODAY8:
.X                                           *BOLDON:
.X                                           *H=27,"Chiron Software & Services, Inc.",*BOLDOFF:
.X                                           *72,"APTERM":
.X                                           *N:
.X                                           *H=1,"Time : ",TIME8:
.X                                           *H=29,"A/P Term Code Master Listing":
.X                                           *72,"Accounts Payable":
.X                                           *N=2:
.X                                           *ULON:
.X                                           *H=1,"Term Code",*H=16,"Description":
.X                                           *H=33,"Net Days",*H=44,"Disc. Days":
.X                                           *H=57,"Disc. %":
.X                                           *ULOFF:
.X                                           *N
.X
.X                 MOVE              "5",LINE
.X                 RETURN

EXITASK
                   ALERT             PLAIN,"Are you sure you wish to exit this report?",#RESULT
                   IF                (#RESULT=1)
                     STOP
                   ENDIF
                   RETURN
;==========================================================================================================
NOPRINT
                   TRAPCLR           SPOOL
                   NORETURN
                   RETURN
;==========================================================================================================
MaintMenuOption
                   CALL                 GetMenuName
                   RETURN
;==========================================================================================================
MainValid
                   IF                (Status = 0)
                     GETCOUNT          ECustomerID
                     IF                (CharCount > 0)
                       getprop           ECustomerID,text=CustKY
                       call              RDCust
....                       call              KPOrderHeader
                       IF               (RETURNFL = 1)
                         PARAMTEXT        PartsTITLE,PartsKY,"",""
                         ALERT            CAUTION,"^0: ^1 Not Found",#RES2,"Record does not exist"
                         CALL             MAINRESET
                         RETURN
                       ENDIF
.
. OK, we've been able to read the record and now let's show it on the screen.
.
                       CALL              SETMAIN
                       MOVE              "3",Status                   .We've found a record
                       ENABLEITEM        BMainCHANGE
                       ENABLETOOL        ID_Change
                       EnableDBMenu      MModifyRecord

.HR 2019.8.9                       ENABLEITEM        BMainDELETE
                       ENABLETOOL        ID_Delete
                       EnableDBMenu        MDeleteRecord

....                       DISABLEITEM       EOrderNumber
                       setprop           ECustomerID,Static=1,BGColor=$BtnFace
                       DISABLEITEM       Fill1
                       SETFOCUS          BMainChange
                     ENDIF
                   ENDIF
                   RETURN
;==========================================================================================================
; Initialize MAIN Form and setup the Menu's, Fields, Objects, Buttons, etc

MAININIT
; Set the SELECTALL property for the COLLECTION and then take care of
; any ActiveX controls.
;
                   SETPROP           PartsEDT,SELECTALL=$SelectAll
.
                   CALL              MAINRESET
                   RETURN
;==========================================================================================================
; New Button is pressed
;
MAINNEW
                   debug
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
.
. Let's see if SOMEBODY else has entered/used this code before or let's just
. see if this Code already exists in the system
.

                     if                (LastEditRow = 0)               //We have no Kit Components
                       alert             stop,"You have not selected any Kit Components",result,"NO COMPONENTS SELECTED"
                       return
                     endif


                     %if               $EntryProgram = 1         //Order Entry
                     CALL              GetOrderHeader
                     transaction       Start,SequenceFLST,OrderHeaderFLST,OrderDetailsFLST
                     CALL              TSTOrderHeader
                     %endif


                       %if               $EntryProgram = 1
                       GetNextSeq        OrderH
                       move              Sequence.SeqNo,OrderHeader.SeqNo
                       move              Sequence.SeqNo,OrderHeader.OrderNumber

                       CALL              WRTOrderHeader
;
; Get all of the fields from the Form into the proper RECORD
;
                       call              WriteOrderDetails
                       %endif

                       set               PreviewFlag
                       %if               $EntryProgram = 2
                       if               (PreviewFlag = 1)

                         CALL              GetOrderHeader
                         call             PrintInvoicePreview

                         alert            Plain,"Is this Invoice entered correctly?",result,"EVERYHING CORRECT?"
                         return           if (result != 1)
                       endif
                       clear             PreviewFlag


                       CALL              GetOrderHeader
                       transaction       Start,SequenceFLST,InvoicesFLST,InvDetailsFLST,ARTrnFLST,CustDFLST,ChstFLST,InvNotesFLST

                       GetNextSeq        InvH
                       move              Sequence.SeqNo,Invoices.SeqMajor
                       move              Sequence.SeqNo,Invoices.Reference
                       CALL              WRTInvoices
;
; Get all of the fields from the Form into the proper RECORD
;
                       call              WriteInvoiceDetails
                       call              CreateInvoice
                       call              UpdateCustomerHistory
                       %endif
                       transaction        Commit
;
; Check to see if we want to Automatically ship out of the UPS System
;
.                       call              ShipVia

;
; Added 2019.9.12
;
                       CBShipTo.GetCurSel giving result
                       if                 (result = 0)
                         call               AddNewShipTo
                       endif

                       CALL              MAINRESET
                       call              ResetPartsEntry
                       call              PrintInvoices
                       RETURN
                   ELSE
                     CALL              MainReset
                     MOVE              "2",Status
                     CALL              DisableRecordButtons
.
. Enable all of the EditText fields and set the EditText fields
. to Non Read-Only
.
....                     ENABLEITEM        PartsEDT
                     setprop           PartsEDT,static=0,bgcolor=$Window
.
                     DISABLEITEM       BMainCHANGE
                     DISABLETOOL       ID_Change
                     DisableDBMenu     MModifyRecord

..HR 2019.8.9                     DISABLEITEM       BMainDELETE
                     DISABLETOOL       ID_Delete
                     DisableDBMenu     MDeleteRecord

...                     setprop           BMainNEW,title=SaveTitle
                     ENABLETOOL        ID_Save
                     EnableDBMenu      MSaveRecord

                     setprop           BMainCancel,title=CancelTitle
                     ENABLETOOL        ID_Cancel

                     DISABLETOOL       ID_New
                     DisableDBMenu     MNewRecord
                    setprop            OrderHeaderColl,enabled=1
                    call               OnClickBAccept
                    setprop            ECustomerID,static=1,BGColor=$BtnFace
.
. Set the Focus to the first field that we're going to be Entering
.
                     SETFOCUS          ECustomerID
                   ENDIF
                   RETURN
;==========================================================================================================
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
                       transaction       Start,SequenceFLST,OrderHeaderFLST,OrderDetailsFLST
                       CALL              GETMAIN                 //Get all of the fields
                       CALL              UPDOrderHeader            //Update the record
                       call              DeleteOrderDetails
                       call              WriteOrderDetails
                       transaction       Commit
                       call              ResetPartsEntry
                       CALL              MAINRESET               //Reset the objects & fields
                     ENDIF
                     RETURN                                      //Voila...Either way, we're RETURNING
                   ENDIF
                   GETCOUNT          ECustomerID
                   IF                (Charcount > 0)
                     getprop           ECustomerID,text=CustKY   //Read the Primary field ito the Key

                     CALL              RDCustLK               //Lock the record so that nobody uses it
.
. Just for arguments sake, let's just make sure that the record hasn't been deleted
. by another user, AND...Let's make sure that it's not being used by another user
. as well!!
.
                     IF                (RETURNFL = 1)          //WHAT!!! Somebody deleted this record
                       BEEP
                       ALERT             STOP,"Record deleted by another User!!",RESULT
                       CALL              MAINRESET
                       call              ResetPartsEntry
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
....                     ENABLEITEM        OrderHeaderColl
                     DISABLEITEM       Fill1
                     SETPROP           OrderHeaderColl,static=0,bgcolor=$Window
.
. OK, OK...What do we do with any ActiveX components. We've got to handle
. them as well.  Let's change these to Non Read-Only and change the
. Background colors as well
.
.                    SETPROP           EPartsDiscPerc,*Enabled=1
.                    SETPROP           EPartsDiscPerc,*BackColor=$Window
.
. Change the Cancel button button to 'Save' and the 'Exit' button to Cancel
.
                     setprop           BMainCancel,title=CancelTitle
                     ENABLETOOL        ID_Cancel

                     setprop           BMainCHANGE,title=SaveTitle
                     ENABLETOOL        ID_Save
                     EnableDBMenu      MSaveRecord

                     ENABLETOOL        ID_Undo
                     DISABLETOOL       ID_Change
                     DisableDBMenu     MModifyRecord

                     DISABLETOOL       ID_New
                     DISABLEITEM       BMainNew
                     DisableDBMenu     MDeleteRecord

.                      debug
                    setprop            OrderHeaderColl,enabled=1



..                     SETFOCUS          EDescription1               //Set the cursor to the next field
....                     DISABLEITEM       EOrderNumber               //and Disable the Primary Code
                     setprop           ECustomerID,Static=1,BGColor=$BtnFace
                   ENDIF
                   RETURN
;==========================================================================================================
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
                     CALL             RDCust
                     CALL              SetMain
                   ENDIF
                   RETURN
;==========================================================================================================
MainFind
                   FindSearch        ECustomerID
                   IF                (PassedVar = "Y")
                     getprop           ECustomerID,text=CustKY
                     MOVE              $SearchKey,CustKY
                     CALL              RDCust
.
. We've got a record thanks to our Trusy Search/Browse window. Let's
. continue now by setting up the proper Code field and calling the
. MainValid subroutine, that will take care of it for us.
.
                     MOVE              "0",Status
                     setprop           ECustomerID,text=Cust.CustomerID
                     CALL              MainValid
                   else
                     setfocus          ECustomerID
                   ENDIF
                   RETURN
;==========================================================================================================
. Routine to read the First record and display it
.
MainFirst
                   CLEAR             PartsKY
                   FILL              FirstASCII,CustKY
                   CALL              RDCust
                   IF                (RETURNFL = 1)  . We didn't find a 'Blank' record
                     CALL              KSCust         . Try the 'next' record
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
                   setprop           ECustomerID,text=Cust.CustomerID
                   call                MainValid
                   RETURN
;==========================================================================================================
. Routine to read the Last record and display it
.
MainLast
                   CLEAR             CustKY
                   FILL              LastASCII,CustKY
                   CALL              RDCust
                   IF                (RETURNFL = 1)  . We didn't find a 'Blank' record
                     CALL              KPCust        . Try the 'Previous' record
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
                   setprop           ECustomerID,text=Cust.CustomerID
                   CALL              MainValid
                   RETURN
;==========================================================================================================
. Routine to read the Next record and display it
.
MainNext
. We can't just do a simple READKS/READKP because of certain conditions including
. 'Attempting' to read past the last record (Next --> EOF) and the reverse
. condition.  Due to this fact, we need to get the current code, and THEN
. do a READKS/READKP
.
                   GETCOUNT          ECustomerID
                   IF                (CharCount <> 0)
                     getprop           ECustomerID,text=CustKY
                     CALL              RDCust
                   ENDIF
.
                   CALL              KSCust       . Try the 'next' record
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
                   setprop           ECustomerID,text=Cust.CustomerID
                   CALL              MainValid
                   RETURN
;==========================================================================================================
. Routine to read the Previous record and display it
.
MainPrevious
. We can't just do a simple 'READKS' because of certain conditions including
. 'Attempting' to read past the last record (Next --> EOF) and the reverse
. condition.  Due to this fact, we need to get the current code, and THEN
. do a READKS/READKP
.
                   GETCOUNT          ECustomerID
                   IF                (CharCount <> 0)
                     getprop           ECustomerID,text=CustKY
                     CALL              RDCust
                   ENDIF

                   CALL              KPCust        . Try the 'Previous' record
                   IF                (RETURNFL = 1)  . There are no records in the file
                     BEEP
                     ALERT             STOP,"Beginning of file has been reached...",RESULT:
                                            PrevTitle
                     RETURN
                   ENDIF

. We've got a record (either on the READ or the READKS.  Let's now continue
. processing as if we just lost the Focus of the main field.  By calling the
. MainValid subroutine, that will take care of it for us.

                   MOVE              "0",Status
                   setprop           ECustomerID,text=Cust.CustomerID
                   CALL              MainValid
                   RETURN
;==========================================================================================================
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
;==========================================================================================================
; Routine to Validate the data from the Form
;  If we find an error below, set the ValidFlag = 1 and return

VALIDATE1
Dim20               dim                20

                   MOVE              "0",ValidFlag

                   getprop            STPONO,text=Dim20
                   squeeze            Dim20,Dim20
                   if                 (Dim20 = "")
                     beep
                     alert              note,"A valid Purchase Order must be entered",result,"INVALID P.O."
                     move               "1",ValidFlag
                     setfocus           STPONO
                     return
                   endif

                   for                 X from "1" to (LastEditRow - 1) using "1"
                     getprop            NQuantityShipped(X),value=ShipQuantity
                     getprop            NQuantityOrdered(X),value=OrderQuantity
                     getprop            NPrice(X),value=OrderPrice

                     calc               BackOrderQuantity = OrderQuantity - ShipQuantity
                     setprop            NQuantityBackOrder(X),value=BackOrderQuantity

                     getprop            NPrice(X),value=OrderPrice
                     MOVE               OrderDetails.UnitPrice,ExtendedPrice

                     getprop            EUOM(X),text=UOM
                     squeeze            UOM,UOM

                     switch             UOM
                       CASE              "C"
                       MOVE              "100",Divisor
                     CASE              "M"
                       MOVE              "1000",Divisor
                     CASE              "EA"
                       MOVE              "1",Divisor
                     CASE              "##"                    //HR 5/18/2005
                       MOVE              "1",Divisor           //HR 5/18/2005
                     CASE              "# "                    //HR 7.22.2014
                       MOVE              "1",Divisor           //HR 7.22.2014
                     CASE              "LT"                    //HR 10/14/2005
                       MOVE              "1",Divisor           //HR 10/14/2005
                     CASE              "GR"                    //HR 10/14/2005
                       MOVE              "1",Divisor           //HR 10/14/2005
                     CASE              "LB"                    //HR 10/14/2005
                       MOVE              "1",Divisor           //HR 10/14/2005
                     CASE              "FT"                    //HR 10/14/2005
                       MOVE              "1",Divisor           //HR 10/14/2005
                     CASE              "PK"                    //HR 10/14/2005
                       MOVE              "1",Divisor           //HR 10/14/2005
                     CASE              "BX"                    //HR 10/14/2005
                      MOVE              "1",Divisor           //HR 10/14/2005
                     CASE              "RD"                    //HR 10/14/2005
                      MOVE              "1",Divisor           //HR 10/14/2005
                     CASE              "NC"                    //HR 10/14/2005
                       MOVE              "1",Divisor           //HR 10/14/2005
                     CASE              "LT"                    //HR 10/14/2005
                       MOVE              "1",Divisor           //HR 10/14/2005
                       default
                     endswitch
                   repeat

                   calc               ExtendedPrice = (ShipQuantity * OrderPrice) /Divisor
                   setprop            NExtended(RowSelected),value=ExtendedPrice
                   call               UpdateGrandTotals
.
. Everything's OK...Let's just return because the ValidFlag will be set to
. Zero from the top of this routine.
.
                   MOVE              "0",ValidFlag
                   RETURN
;==========================================================================================================
. Routine to 'Reset' everything which includes the Button's, Objects,
. fields, etc.
.
MAINRESET


                   move              "0",status     //reset the status to not updating
                   unlock            Partsfl
.
. Reset the fields to 'Blank' and DISABLE all of those fields as well
...                   DELETEITEM        OrderHeaderColl,0
                   clear             Parts
                   clear             LoadFromOrderFlag            //HR 2019.10.22
..HR 2018.4.5                   call              setmain

....                   DISABLEITEM       OrderHeaderColl
                   SETPROP           OrderHeaderColl,static=1,bgcolor=$BtnFace
                   ENABLEITEM        Fill1
.
. Reset the Buttons for the Next record
.
                   DISABLEITEM       BMainChange
                   DISABLETOOL       ID_Change
                   DisableDBMenu     MModifyRecord

..HR 2019.8.9                   DISABLEITEM       BMainDELETE
                   DISABLETOOL       ID_Delete
                   DisableDBMenu     MDeleteRecord

                   setprop           BMainCHANGE,title=ChangeTitle

..                   setprop           BMainNEW,title=NewTitle
                   ENABLETOOL        ID_New
                   EnableDBMenu      MNewRecord

                   ENABLEITEM        BMainNEW
                   setprop           BMainCancel,title=ExitTitle

                   DISABLETOOL       ID_Save
                   DISABLETOOL       ID_Undo
                   DISABLETOOL       ID_Cancel

                   DisableDBMenu     MSaveRecord

                   CALL              EnableRecordButtons
                    call               ResetHeader
                    CBShipTo.ResetContent

                    setprop            NSubTotal,value=0
                    setprop            NTax,value=0
                    setprop            NFreight,value=0
                    setprop            NTotals,value=0
                    setprop            ShipCollection,text=""
                    setprop            CustCollection,text=""

.
. Setup any ActiveX control fields to what they should be
.
.                  SETPROP           EPartsDiscPerc,*Text="0"
.                  SETPROP           EPartsDiscPerc,*Enabled=0
.                  SETPROP           EPartsDiscPerc,*BackColor=$BTNFACE
.
. Setup the Primary field that is used for Entry purposes
.

....                   SETPROP           EOrderNumber,READONLY=0
....                   SETPROP           EOrderNumber,BGCOLOR=$WINDOW
                      SETPROP           ECustomerID,static=0,bgcolor=$Window
....                   ENABLEITEM        ETRoomNumber

....                   ENABLEITEM        EOrderNumber
                   setprop           DTOrderDate,enabled=0
                     setprop           CBTerms,enabled=0
                    setprop            EditCollection,static=1,bgcolor=$BtnFace,text=""
                    setprop            CBCompleted,value=1                                  //HR 2019.7.24
                    CBShipmentCode.SetCurSel using *Index=0

...                   call                SetupLVColumns
                   call                ResetHeader
                   SETFOCUS          ECustomerID
                   RETURN
;==========================================================================================================

; Cancel Button has been Clicked
;
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
              winshow
              CHAIN             FROMPGM
             ELSE
               RETURN                     . Contine with standard operations
             ENDIF
           ENDIF
           DESTROY         WMAIN          . Get rid of the Bank Window
              winshow
              CHAIN             FROMPGM

.=============================================================================
. Cancel button has been pressed
.
MainCancel
           IF                (Status = 0)      . They want to exit the program
             DESTROY         WMAIN             . Get rid of the Main Window
..FUCKUP             NORETURN
...FUCKUP             RETURN
              winshow
              CHAIN             FROMPGM

           ELSE
             IF                (Status = 1 OR Status = 2)  . Change/New Mode
               BEEP
               ALERT              PLAIN,"Do you wish to cancel this operation?",RETURNFL:
                                        "Are you sure?"
               IF                 (RETURNFL = 1)
                 CALL               MAINRESET
                 call              ResetPartsEntry

                 RETURN
               ELSE
                 RETURN
               ENDIF
             ELSE
               CALL              MAINRESET
                call              ResetPartsEntry

             ENDIF
             RETURN
           ENDIF
;==========================================================================================================
. Delete Button has been Pressed
.
MainDelete
                   PARAMTEXT        Parts.PartNumber,PartsTitle,"",""
                   BEEP
                   ALERT            PLAIN,"Do you wish to Delete the ^1: ^0 ?",#RES1,DelTitle
                   IF               (#RES1 = 1)
                     CALL             DELParts
                     ALERT            NOTE,"A/P Term Code ^0 has been deleted",#RES1,DelOKTitle
                     CALL             MAINRESET
                   ENDIF
                   RETURN
;==========================================================================================================
.
. Setup all of the fields in the Form based upon the data record
SETMAIN
.                    debug
..                    setprop           ECustomerID,text=Cust.CustomerID

.                    setprop            DTOrderDate,text=OrderHeader.OrderDate
.                    squeeze            OrderHeader.PromiseDate,OrderHeader.PromiseDate
SetMain2

                    RETURN
;==========================================================================================================
LoadOrderFromPO                                       //PO  aapp17808
SaveSalesPO        dim               18

                   return            if (LastEditRow != 1)
                   return            if (LoadFromOrderFlag = 1)

                   debug
                   getprop           STPono,text=SaveSalesPO
                   chop              SaveSalesPO,SaveSalesPO
                   return            if (SaveSalesPO = "")                   //HR 20200317

                   packkey           SalesKY from SaveSalesPO
                   read              SalesFL,SalesKY;;
                   readks            SalesFL;Sales
                   return            if (over)

                   chop              Sales.PONumber,Sales.PONumber
                   if                (Sales.PONumber = SaveSalesPO)
                     alert             plain,"I've located a Purchase Order, would you like me to load the Items?",result,"LOAD ITEMS"
                     return            if (result != 1)
                   else
                     return
                   endif

                   set               LoadFromOrderFlag
                   move              "1",LastEditRow
                   debug

                   read              SalesFL,SalesKY;;
                   loop
                     readks            SalesFL;Sales
                   until (over)
                     chop              Sales.PONumber,Sales.PONumber
                     break             if (Sales.PONumber != SaveSalesPO)

                   debug
                     move               LastEditRow,RowSelected
                     setprop            NQuantityOrdered(LastEditRow),value=Sales.Quantity
                     setprop            NQuantityShipped(LastEditRow),value=Sales.Quantity
                     setprop            NQuantityBackOrder(LastEditRow),value=0
.                    setprop            NQuantityBackOrder(LastEditRow),value=Sales.Quantity

                     setprop            EPartNumber(LastEditRow),text=Sales.PartNumber,static=0,BGColor=$Window
                     setprop            EUOM(LastEditRow),text=Sales.UOM
                     setprop            NPrice(LastEditRow),value=Sales.Price
                     setprop            NQuantityOrdered(LastEditRow),static=0,BGColor=$Window
                     setprop            NQuantityShipped(LastEditRow),value=Sales.Quantity

                     calc               ExtendedPrice = Sales.Quantity * Sales.Price
                     setprop            NExtended(LastEditRow),value=ExtendedPrice
                     call               CreateItemRow
                   repeat
                   call               UpdateGrandTotals
                   setfocus           CBCompleted
                   return
;==========================================================================================================
LoadOrderDetails
                    move               "0",LastEditRow
                    packkey            OrderDetailsKY from OrderHeader.OrderNumber
                    call                RDOrderDetails
                    loop
                      call                KSOrderDetails
                    until               (ReturnFl = 1 or OrderDetails.OrderNumber != OrderHeader.OrderNumber)

                      call               CreateItemRow
..HR 2019.5.22                      move               OrderDetails.PartNumber,PartsKY
..HR 2019.5.22                      call               RDParts

                      move               Parts,PartNumberArray(LastEditRow)



.NQuantityOrdered    editnumber         (0..50)
.NQuantityShipped    editnumber         (0..50)
.NQuantityBackOrder  editnumber         (0..50)
.EProductGroup       edittext           (0..50)

                      setprop            NQuantityOrdered(LastEditRow),value=OrderDetails.QtyOrdered
                      setprop            NQuantityShipped(LastEditRow),value=OrderDetails.QtyShipped
                      setprop            NQuantityBackOrder(LastEditRow),value=OrderDetails.BackOrderQty
........                      setprop            EProductGroup)LastEditRow),text=


                      setprop            EPartNumber(LastEditRow),text=Parts.PartNumber,static=1,BGColor=$BtnFace
.                      setprop            EDescription(LastEditRow),text=Parts.Description1
                      setprop            EUOM(LastEditRow),text=Parts.UOM
.                      setprop            ESize(LastEditRow),text=Parts.Size
                      setprop            NPrice(LastEditRow),value=OrderDetails.UnitPrice
.                      setprop            NDiscount(LastEditRow),value=OrderDetails.DiscountAmt
                      setprop            NQuantityOrdered(LastEditRow),static=1,BGColor=$BtnFace
                      setprop            NQuantityShipped(LastEditRow),value=OrderDetails.QtyOrdered
                      setprop            NQuantityBackOrder(LastEditRow),value=OrderDetails.BackOrderQty

                      calc               ExtendedPrice = OrderDetails.QtyOrdered * OrderDetails.UnitPrice
                      setprop            NExtended(LastEditRow),value=ExtendedPrice
                    repeat
                    return
;==========================================================================================================
SaveOrderDetails
                    return
;==========================================================================================================
EnablePartItems
.                    debug
                    for                 X from "1" to (LastEditRow) using "1"
                      setprop            EPartNumber(X),static=0,BGColor=$Window
                      setprop            NQuantityOrdered(X),static=0,BGColor=$Window
                    repeat
                    return
;==========================================================================================================
GetOrderHeader
                    %if                $EntryProgram = 1
                    call               GetMain
                    move               $Entity,OrderHeader.Entity
                    CBTerms.GetCurSel  giving result
                    move               TermCodeArray(result),OrderHeader.TermCode
                    move               TermCodeArray(result),ARTRMKY
                    call               RDARTrm
                    move               ARTRM.Desc,OrderHeader.TermDesc
                    getprop            ESalesRep,text=OrderHeader.SalesRep
                    clock              TimeStamp,OrderHeader.PostedDate
                    getprop            NTotals,value=OrderHeader.OpenOrderAmt
                    move               OrderHeader.OpenOrderAmt,OrderHeader.TotalAmt
                    getprop            NFreight,value=OrderHeader.FreightAmt
                    subtract           "1",LastEditRow,OrderHeader.Lines
                    %endif

                    %if                $EntryProgram = 2
                    clear              Invoices
                    call               GetMain
                    move               $Entity,Invoices.Entity
                    CBTerms.GetCurSel  giving result
                    move               TermCodeArray(result),Invoices.TermCode
                    move               TermCodeArray(result),ARTRMKY
                    call               RDARTrm

                    getprop            ESalesRep,text=Invoices.SalesRep
                    clock              TimeStamp,Invoices.TransDate
                    getprop            CBCompleted,value=Invoices.Completed
                    clock              TimeStamp,Invoices.BillDate
                    getprop            DTOrderDate,text=Invoices.ShipDate
                    getprop            NTotals,value=Invoices.InvoiceAmt
...                    move               Invoices.InvoiceAmt,Invoices.TotalAmt
                    getprop            NFreight,value=Invoices.Freight
                    subtract           "1",LastEditRow,Invoices.Lines
                    move               "N",Invoices.Printed
                    move               "I",Invoices.InvCredit
                    %endif

                    return
;==========================================================================================================
. Retrieve all of the fields in the Form based upon the data record
.
GETMAIN
                     %if               $EntryProgram = 1
                     getprop           ECustomerID,text=OrderHeader.CustomerID
                     move              OrderHeader.CustomerID,OrderHeader.BillToCust
                     move              OrderHeader.CustomerID,OrderHeader.ShipToCust

                     getprop           DTOrderDate,text=OrderHeader.OrderDate
                     getprop           DTShipDate,Checked=EndDateFlag
                     if                (EndDateFlag = 1)
                       getprop           DTShipDate,text=OrderHeader.PromiseDate
                     else
                       clear             OrderHeader.PromiseDate
                     endif
                     %endif

                     %if               $EntryProgram = 2
                     getprop           ECustomerID,text=Invoices.BillCust
                     move              Invoices.BillCust,Invoices.ShipToCust

                     getprop           DTOrderDate,text=Invoices.OrderDate
..                     getprop           DTShipDate,Checked=EndDateFlag


                    CBShipmentCode.GetCurSel giving result
                    CBShipmentCode.GetText Giving Invoices.ShipVia using *Index=result

                    getprop            STPONo,text=Invoices.CustomerPO
                    getprop            CBCompleted,value=Invoices.Completed
                    getprop            EWeight,value=Invoices.Weight
                    getprop            ECartons,value=Invoices.Cartons

                    getprop            ECustName,text=Invoices.BillToName
                    getprop            ECustAddr1,text=Invoices.BillToAddr1
                    getprop            ECustAddr2,text=Invoices.BillToAddr2
                    getprop            ECustAddr3,text=Invoices.BillToAddr3

                    getprop            ECustCity,text=Invoices.BillToCity
                    getprop            ECustSt,text=Invoices.BillToSt
                    getprop            ECustZip,text=Invoices.BillToZip
                    getprop            ECustCountry,text=Invoices.BillToCountry
;
; Main Ship-To information
;
                    getprop            STShipName,text=Invoices.ShipToName

                    getprop            STShipAddress1,text=Invoices.ShipToAddr1
                    getprop            STShipAddress2,text=Invoices.ShipToAddr2
                    getprop            STShipAddress3,text=Invoices.ShipToAddr3

                    getprop            STShipCity,text=Invoices.ShipToCity
                    getprop            STShipSt,text=Invoices.ShipToSt
                    getprop            STShipZip,text=Invoices.ShipToZip
                    getprop            STShipCountry,text=Invoices.ShipToCountry

                     %endif

.                    getprop           CKAllowChanges,value=OrderHeader.AllowChanges                                      745
.                    getprop           CKPriceOverride,value=OrderHeader.PriceOverride
.                    if                (OrderHeader.PriceOverride = 1)
.                      getprop           NOverridePrice,value=OrderHeader.KitPrice
.                    else
.                      move              "0",OrderHeader.KitPrice
.                   endif

                    return
;==========================================================================================================
DeleteOrderDetails
;
; Remove all the Kit Details because we might have deleted some prior to clicking the Save Button
;
                    packkey            OrderDetailsKY from OrderHeader.OrderNumber
                    call                RDOrderDetails
                    loop
                      call                KSOrderDetails
                    until (ReturnFl = 1 or OrderDetails.OrderNumber != OrderHeader.OrderNumber)
                      call                DELOrderDetails
                    repeat
                    return

;==========================================================================================================
WriteOrderDetails
                    clear              OrderDetailArray
                    for                 X from "1" to (LastEditRow - 1) using "1"

                      move               PartNumberArray(X).PartNumber,PartsKY
                      call               RDParts

                      move               OrderHeader.CustomerID,OrderDetails.CustomerID

                      move               OrderHeader.OrderNumber,OrderDetails.OrderNumber
                      move               X,OrderDetails.SeqMajor
.                      move               Parts.SeqNo,OrderDetail.PartNumberSeqNo
.                      move               OrderHeader.AllowChanges,OrderDetail.AllowChanges

                      getprop            NQuantityOrdered(X),value=OrderDetails.QtyOrdered
                      getprop            NQuantityShipped(X),value=OrderDetails.QtyShipped
                      getprop            NQuantityBackOrder(X),value=OrderDetails.BackOrderQty

...                      getprop            EDescription(X),text=OrderDetails.Description1
                      getprop            NPrice(X),value=OrderDetails.UnitPrice
...                      getprop            NDiscount(X),value=OrderDetails.DiscountAmt
                      move               X,OrderDetails.Line
                      clear              OrderDetails.Completed
...                      move               Parts.PartNumber,OrderDetails.PartNumber
...                      move               Parts.UOM,OrderDetails.UOM
                      clock              TimeStamp,OrderDetails.DatePosted
...                      move               Parts.Description1,OrderDetails.Description1
...                      move               Parts.Description2,OrderDetails.Description2
...                      move               Parts.TaxCode,OrderDetails.TaxCode
                      clear              OrderDetails.ReplacementPartNumber
                      getprop            Nextended(X),value=OrderDetails.ExtendedAmt
...                      move               Parts.AllowFractional,OrderDetails.AllowFractional
...                      move               Parts.SerialNumbered,OrderDetails.SerialNumbered
...                                       move               Parts.WarrantyIncluded,OrderDetails.WarrantyIncluded
...                      move               Parts.WarrantyTime,OrderDetails.WarrantyTime
...                      move               Parts.ServiceLife,OrderDetails.ServiceLife
...                      move               Parts.Cost,OrderDetails.Cost
...                      move               Parts.Size,OrderDetails.Size
...                      move               Parts.LotNumber,OrderDetails.LotNumber
...                      move               Parts.ItemType,OrderDetails.ItemType


.OrderDetails                     RECORD
.Status                           Form               1                  39 - 39       //35 -  35
.EnteredBy                        Form               1                  56 - 56       //60 -  60    Recorded by (P)art (1) or (S
.QtyAllocated                     Form               9.2                69 - 80       //85 -  93
.QtyShipped                       Form               9.2                81 - 92       //94 - 102    Quantity Shipped (Cumulative
.OrderedFrom                      Dim                2                  93 - 94       //103 - 104
.ExtraCharges                     Form               5.2               117 - 124      //453 - 460    Extra Charges
.CancelFlag                       Form               1                 125 - 125      //488 - 488    Cancel Flag. 1 = Cancelled
.OrderType                        Form               1                 126 - 126      //579 - 579
.Comments                         Dim                100               127 - 226      //583 - 682
.TaxableAmt                       Form               9.2               227 - 238
.NonTaxableAmt                    Form               9.2               239 - 250
.KitItem                          Form               1                 387 - 387







                    switch             Status

                    case               1                           //Changed
                      packkey          OrderDetailsKY from OrderHeader.OrderNumber,OrderDetails.Line
                      call             TSTOrderDetails
                      if               (ReturnFl = 1)
                        transaction      Rollback
                        alert            stop,"Error Updating Kit Detail Records",result
                        return
                      endif

                      call               UpdOrderDetails
                    case               2                           //New
                      call               WrtOrderDetails
                    endswitch

.OrderDetailArray


.OrderDetail        record
.AllowQuantityChange form               1
.AllowDeletion       form               1

                    repeat



.                    for                 X from "1" to (LastEditRow - 1) using "1"

.                      move               PartNumberArray(X).PartNumber,PartsKY
.                      call               RDParts

.                      move               OrderHeader.SeqNo,OrderDetail.KitSeqNo
.                      move               Parts.SeqNo,OrderDetail.PartNumberSeqNo
.                      getprop            NQuantity(X),value=OrderDetail.Quantity

.                      getprop            EDescription(X),text=Parts.Description1
.                      getprop            NPrice(X),value=Parts.Price
.                      call               WrtOrderDetails

.                    repeat

                    RETURN
;==========================================================================================================
WriteInvoiceDetails
                    clear              OrderDetailArray
                    for                 X from "1" to (LastEditRow - 1) using "1"
                    call               MoveEntryFieldsToInvoice
                    chop               InvDetails.PartNumber,InvDetails.PartNumber
                    continue           if (InvDetails.PartNumber = "")                              //HR 2019.7.22

                    switch             Status

                    case               1                           //Changed
                      packkey          InvDetailsKY from Invoices.Reference,InvDetails.LineNo
                      call             TSTInvDetails
                      if               (ReturnFl = 1)
                        transaction      Rollback
                        alert            stop,"Error Updating Kit Detail Records",result
                        return
                      endif

                      call               UpdInvDetails
                    case               2                           //New
                      if                 (PreviewFlag = 1)
                      else
                        call               WrtInvDetails
                      endif
                    endswitch
                      if                 (PreviewFlag = 1)
                      else
                        call               WriteAdditionalLines
                      endif

                    repeat
                    RETURN
;==========================================================================================================
MoveEntryFieldsToInvoice

                      move               PartNumberArray(X).PartNumber,PartsKY
......                      call               RDParts

                      move               Invoices.ShipToCust,InvDetails.ShipToCust

                      move               Invoices.Reference,InvDetails.Reference
                      move               Invoices.SeqMajor,InvDetails.SeqMajor
                      move               X,InvDetails.SeqMinor

                      move               Invoices.Entity,InvDetails.Entity
                      move               Invoices.EntryDate,InvDetails.EntryDate
                      move               Invoices.TransDate,InvDetails.TransDate
                      move               Invoices.BillDate,InvDetails.BillDate
                      move               Invoices.ShipDate,InvDetails.ShipDate
                      move               Invoices.BillCust,InvDetails.BillCust
                      move               Invoices.ShipToCust,InvDetails.ShipToCust
                      getprop            NExtended(X),value=InvDetails.ExtendedAmt
                      move               InvDetails.InvoiceAmt,InvDetails.TaxableAmt
                      move               InvDetails.InvoiceAmt,InvDetails.SalesAmt

....                      getprop            EProductGroup(X),text=InvDetails.Size
                      getprop            NQuantityOrdered(X),value=InvDetails.OrderQty
                      getprop            NQuantityShipped(X),value=InvDetails.ShipQty
                      getprop            NQuantityBackOrder(X),value=InvDetails.BackOrderQty

                      getprop            NPrice(X),value=InvDetails.UnitPrice
                      move               X,InvDetails.LineNo
                      getprop            EPartNumber(X),text=InvDetails.PartNumber
                      getprop            EUOM(X),text=InvDetails.UOM
                      clock              TimeStamp,InvDetails.TransDate
...                      move               Parts.Description1,InvDetails.Description1
...                      move               Parts.Description2,InvDetails.Description2
...                      move               Parts.TaxCode,InvDetails.TaxCode
                      clear              InvDetails.ReplacementPartNumber
                      getprop            Nextended(X),value=InvDetails.ExtendedAmt
...                      move               Parts.AllowFractional,InvDetails.AllowFractional
...                      move               Parts.SerialNumbered,InvDetails.SerialNumbered
...                      move               Parts.WarrantyIncluded,InvDetails.WarrantyIncluded
...                      move               Parts.WarrantyTime,InvDetails.WarrantyTime
...                      move               Parts.ServiceLife,InvDetails.ServiceLife
...                      move               Parts.Cost,InvDetails.Cost
...                      move               Parts.Size,InvDetails.Size
...                      move               Parts.LotNumber,InvDetails.LotNumber
...                      move               Parts.ItemType,InvDetails.ItemType

                    return
;==========================================================================================================
.Help Menu selection if required
.
MAINHELP
                   RETURN
;==========================================================================================================
.Help Menu to bring up the Contents of the help file
.
mainHelpContents
                   RETURN
;==========================================================================================================
;.Help Menu to Search the help file
;
MainHelpSearch
                   RETURN
;==========================================================================================================
onClickMainWinChangeMenu
                   PERFORM           RESULT OF  MAINNEW,MAINCHANGE,MainDelete,SAVEMODE
                   RETURN
;==========================================================================================================
onClickMainWinExitButton
.
. check to see if this is masquerading as a CANCEL button
.
                   CALL              MainCancel
                   RETURN
;==========================================================================================================
onClickMainWinFileMenu
.
. process a click on the file menu
.
                   PERFORM           result of MainPrint,,MAINCLOSE
                   RETURN
;==========================================================================================================
onClickMainWinHelpMenu
                   PERFORM           result of MAINHELP,MAINHELP,MAINAbout
                   RETURN
;==========================================================================================================
. Display the Standard "About Box"
.
MAINAbout
.
. display an alert box describing the program
.
                   getmode           *ProgName=ProgramName
                   getmode           *ProgStamp=ProgramStamp
                   getmode           *ProgVer=ProgramVer

                   CALL              About using ProgramName,ProgramStamp,ProgramVer
                   SETFOCUS          WMain
                   RETURN
;==========================================================================================================
. Display the Standard "About Chiron"
.
MainAboutChiron
.
. display an alert box describing the program
.
                   CALL              AboutChiron
                   SETFOCUS          WMain
                   RETURN
;==========================================================================================================
. Print Report option
.
MainPrint
                   CALL              PrintInvoices
                   RETURN
;==========================================================================================================
MainPrintPreview
                   call              PrintPreviewReport
                   RETURN
;==========================================================================================================
MainToolBar
                   RETURN
;==========================================================================================================
. Disable the 'Record' Buttons because we're in the middle of Updating or
. Creating a New record.
.
DisableRecordButtons
                   DISABLETOOL       ID_First
                   DISABLETOOL       ID_Next
                   DISABLETOOL       ID_Previous
                   DISABLETOOL       ID_Last
                   DISABLETOOL       ID_Find

                   DisableGoToMenu   MFirst
                   DisableGoToMenu   MNext
                   DisableGoToMenu   MPrevious
                   DisableGoToMenu   MLast
                   DisableGoToMenu   MSearch
                   RETURN
;==========================================================================================================
. Enable the 'Record' Buttons because we're in the middle of Updating or
. Creating a New record.
.
EnableRecordButtons
                   ENABLETOOL        ID_First
                   ENABLETOOL        ID_Next
                   ENABLETOOL        ID_Previous
                   ENABLETOOL        ID_Last
                   ENABLETOOL        ID_Find

                   EnableGoToMenu    MFirst
                   EnableGoToMenu    MNext
                   EnableGoToMenu    MPrevious
                   EnableGoToMenu    MLast
                   EnableGoToMenu    MSearch
                   RETURN
;==========================================================================================================
SetupLVColumns
                    MOVE               "20",EditTop
                    MOVE               "0",EditLeft
                      CALC               EditBottom = (EditTop + 20)         //Was 32 //Was 16
                      CALC               EditRight = EditLeft + 80
                      move               "0",X


                      CREATE             OrderEntryPanel;HeaderLV(0)=(EditTop + ((X-1) * 20)):(EditTop + ((X-1) * 20)+ 20):(EditLeft):(EditLeft + 80):
                                         MaxChars=8,Style=2,ZORDER=1000,visible=1,Border=1,SelectAll=1,ObjectID=X,alignment=1,BGColor=$BtnFace,Static=1,autoenter=1

                      CREATE             OrderEntryPanel;HeaderLV(1)=(EditTop + ((X-1) * 20)):(EditTop + ((X-1) * 20)+ 20):(EditLeft + 80):((EditLeft + 160)):
                                         MaxChars=8,Style=2,ZORDER=1000,visible=1,Border=1,SelectAll=1,ObjectID=X,alignment=1,BGColor=$BtnFace,Static=1,autoenter=1


                      CREATE             OrderEntryPanel;HeaderLV(2)=(EditTop + ((X-1) * 20)):(EditTop + ((X-1) * 20)+ 20):(EditLeft + 160):(EditLeft + 240):
                                         MaxChars=8,Style=2,ZORDER=1000,visible=1,Border=1,SelectAll=1,ObjectID=X,alignment=1,BGColor=$BtnFace,Static=1,autoenter=1

                      CREATE             OrderEntryPanel;HeaderLV(3)=(EditTop + ((X-1) * 20)):(EditTop + ((X-1) * 20)+ 20):(EditLeft + 240):((EditLeft + 460)):
                                         MaxChars=8,Style=2,ZORDER=1000,visible=1,Border=1,SelectAll=1,ObjectID=X,alignment=1,BGColor=$BtnFace,Static=1,autoenter=1

...                      CREATE             OrderEntryPanel;HeaderLV(4)=(EditTop + ((X-1) * 20)):(EditTop + ((X-1) * 20)+ 20):(EditLeft + 400):((EditLeft + 460)):
...                                         MaxChars=8,Style=2,ZORDER=1000,visible=1,Border=1,SelectAll=1,ObjectID=X,alignment=1,BGColor=$BtnFace,Static=1,autoenter=1

                      CREATE             OrderEntryPanel;HeaderLV(4)=(EditTop + ((X-1) * 20)):(EditTop + ((X-1) * 20)+ 20):(EditLeft + 460):((EditLeft + 540)):
                                         MaxChars=8,Style=2,ZORDER=1000,visible=1,Border=1,SelectAll=1,ObjectID=X,alignment=1,BGColor=$BtnFace,Static=1,autoenter=1

                      CREATE             OrderEntryPanel;HeaderLV(5)=(EditTop + ((X-1) * 20)):(EditTop + ((X-1) * 20)+ 20):(EditLeft + 540):((EditLeft + 580)):
                                         MaxChars=8,Style=2,ZORDER=1000,visible=1,Border=1,SelectAll=1,ObjectID=X,alignment=1,BGColor=$BtnFace,Static=1,autoenter=1

                      CREATE             OrderEntryPanel;HeaderLV(6)=(EditTop + ((X-1) * 20)):(EditTop + ((X-1) * 20)+ 20):(EditLeft + 580):((EditLeft + 650)):
                                         MaxChars=8,Style=2,ZORDER=1000,visible=1,Border=1,SelectAll=1,ObjectID=X,alignment=1,BGColor=$BtnFace,Static=1,autoenter=1

                    setprop            HeaderLV(0),text="Qty Ordered"
                    setprop            HeaderLV(1),text="Qty Shipped"
                    setprop            HeaderLV(2),text="Qty B/O"
                    setprop            HeaderLV(3),text="Part Number"
....                    setprop            HeaderLV(4),text="Prod"
                    setprop            HeaderLV(4),text="Price"
                    setprop            HeaderLV(5),text="UOM"
                    setprop            HeaderLV(6),text="Extended Price"

                    MOVE               "0",EditTop
                    MOVE               "0",EditLeft

                    return
;==========================================================================================================
GainedFocus
                    pack               DataLine from "For Line ",CommentLine
                    setprop            SLines,text=DataLine
                    setprop            EComments,text=EAdditionalLines(CommentLine)
                    return
;==========================================================================================================
LostFocus
                    getprop            EComments,text=EAdditionalLines(CommentLine)
                    return
;==========================================================================================================
ValidatePartNumber
PartNumber          dim                20
;
; Validate the Part Number
;
                      clear            PartsKY
                      getprop          EPartNumber(RowSelected),text=PartsKY
                      getprop            NQuantityOrdered(LastEditRow),value=InvDetails.ORderQty

                      if               (PartsKY = "" and InvDetails.OrderQty != 0 )
                        beep
                        alert            note,"A Part Number must be entered",result,"ENTER A PART NUMBER"
                        setfocus           EPartNumber(RowSelected)
                      endif
                        return

                    display            "Got to Part Number :"

                    move               "        ",PartsKY
                    clear              PartsKY
.                    getprop            EPartNumber(RowSelected),text=PartsKY
                    display            "Row Selected ",RowSelected,"   Part: ",PartNumber
                    return             if (PartsKY = "")
..HR 2019.5.24                    call               RDParts if (PartsKY != "")
                    move               "0",ReturnFl
                    if                 (ReturnFl = 1)
                      clear          PartNumberArray(RowSelected)
                      beep
                      clearevents
                      alert              stop,"Invalid Part Number",result,"INVALID PART"
                      setfocus           EPartNumber(RowSelected)
                      return
                    else
                      if               (Parts.Inactive = 1)              //Do Not Sell!!!!
                        clear          PartNumberArray(RowSelected)
                        clearEvents
                        alert            note,"This Inventory Item cannot be sold as it's Inactive",result,"UNABLE TO SELL"
                        setfocus           EPartNumber(RowSelected)
                        return
                      endif

.                      if               (Parts.SellableItem != 1)              //Cannot Sell individually
.                        clearEvents
.                        alert            note,"This Inventory Item cannot be sold separately as an individual part",result,"UNABLE TO SELL"
.                        setfocus           EPartNumber(RowSelected)
.                        return

.                      endif

                      move               Parts,PartNumberArray(RowSelected)

...                      setprop            EDescription(RowSelected),text=Parts.Description1
                      setprop            EUOM(RowSelected),text=Parts.UOM
...                      setprop            ESize(RowSelected),text=Parts.Size
;
; Check for Discounts
;
                      call               CalculateDiscount


..HR 2018.6.12                      setprop            NPrice(RowSelected),value=Parts.Price
...                      setprop            NDiscount(RowSelected),value=DiscountAmt
                      setprop            NPrice(RowSelected),value=Parts.Price
                      setprop            NQuantityOrdered(RowSelected),BGCOLOR=$Window,Static=0
                      setprop            NQuantityShipped(RowSelected),BGCOLOR=$Window,Static=0
..HR 2019.7.24                      setprop            NQuantityBackOrder(RowSelected),BGCOLOR=$Window,Static=0
;
; Is the price adjustable?
;
.                    if                 (Parts.AdjustablePrice = 1)            //Price is adjustable
                      setprop            NPrice(RowSelected),BGColor=$Window,Static=0
.                    else
.                      setprop            NPrice(RowSelected),BGColor=$BtnFace,Static=1
.                    endif

                      if                 (RowSelected = LastEditRow)
                        call               CreateItemRow
                      endif

                      setfocus           NQuantityOrdered(RowSelected)
                      setfocus           NQuantityShipped(RowSelected)
                      setfocus           NQuantityBackOrder(RowSelected)
                      setprop            EBModify(RowSelected),enabled=1
                      setprop            EBDelete(RowSelected),enabled=1
...                    if                 (Parts.AllowFractional = 0)               //Allow only integer Quantities
...                      setprop            NQuantity(RowSelected),DecimalDigits=0
...                    endif

                    endif
;
; If we've just entered a part number into the last row, then create another Row.  Otherwise, just move on
;

                    display            "Status: ",status
                    return
;==========================================================================================================
;==========================================================================================================
CalculateDiscount
                    return

                    if                 (Parts.DiscountableItem = 1)
                      packkey            CustomerPartDiscountsKY from Cust.CustomerID,Parts.PartNumber
..                      call               RDCustomerPartDiscounts
                    move               "1",ReturnFl
                      if                 (ReturnFl = 1)
                        move               Parts.Price,PartPrice
                        clear              DiscountAmt
                      else
                        clock            TimeStamp,Date8
                        squeeze          CustomerPartDiscounts.EndDate,CustomerPartDiscounts.EndDate
                        if               (CustomerPartDiscounts.StartDate <= Date8 and (CustomerPartDiscounts.EndDate >= Date8 or:
                                          CustomerPartDiscounts.EndDate = ""))
                          switch             CustomerPartDiscounts.DiscountType
                          case               0
                            calc               PartPrice = Parts.Price * ( 1.00 - (CustomerPartDiscounts.Amount/100.00000))
                            calc               DiscountAmt = Parts.Price * (CustomerPartDiscounts.Amount/100.00000)
                          case               1
                            calc               PartPrice = Parts.Price - CustomerPartDiscounts.Amount
                            calc               DiscountAmt = CustomerPartDiscounts.Amount
                          default
                            move             Parts.Price,PartPrice
                          endswitch
                        else
                          move             Parts.Price,PartPrice
                        endif
                      endif
                    else
                      clear              DiscountAmt
                    endif
                    return
;==========================================================================================================
CreateItemRow
TabID               form               6
                      incr               LastEditRow
                      calc             TabID = 1000 + (LastEditRow * 10)
                      display          "Tab ID :",TabID
                      display          "LastEdit Row : ",LastEditRow

                      CALC               EditBottom = (EditTop + ((LastEditRow-1) * 15)+ 32)         //Was 16
                      CALC               EditRight = EditLeft + 80

                      CREATE             ItemPanel;NQuantityOrdered(LastEditRow)=(EditTop + ((LastEditRow-1) * 19)):(EditTop + ((LastEditRow-1) * 19)+ 20):(EditLeft):(EditLeft + 80):
                                         IntegerDigits=9:
                                         alignment=3:
                                         overtype=1:
                                         AutoEnter=1:
                                         TabID=TabID:
                                         Style=2,ZORDER=1000,visible=1,Border=1,SelectAll=1,ObjectID=(LastEditRow)

                      incr               TabID
                      CREATE             ItemPanel;NQuantityShipped(LastEditRow)=(EditTop + ((LastEditRow-1) * 19)):(EditTop + ((LastEditRow-1) * 19)+ 20):(EditLeft + 80):((EditLeft + 80) + 80):
                                         IntegerDigits=9:
                                         TabID=TabID:
                                         AutoEnter=1:
                                         overtype=1:
                                         alignment=3:
                                         Style=2,ZORDER=1000,visible=1,Border=1,SelectAll=1,ObjectID=(LastEditRow),Static=0,BGColor=$Window

                      incr               TabID
                      CREATE             ItemPanel;NQuantityBackOrder(LastEditRow)=(EditTop + ((LastEditRow-1) * 19)):(EditTop + ((LastEditRow-1) * 19)+ 20):(EditLeft + 160):( EditLeft + 240):
                                         IntegerDigits=9:
                                         TabID=TabID:
                                         AutoEnter=1:
                                         overtype=1:
                                         alignment=3:
                                         Style=2,ZORDER=1000,visible=1,Border=1,SelectAll=1,ObjectID=(LastEditRow),Static=1,BGColor=$BtnFace,enabled=0

                      incr               TabID
                      CREATE             ItemPanel;EPartNumber(LastEditRow)=(EditTop + ((LastEditRow-1) * 19)):(EditTop + ((LastEditRow-1) * 19)+ 20):(EditLeft + 240):(EditLeft + 460):
                                         alignment=2:
                                         TabID=TabID:
                                         overtype=1:
                                         AutoEnter=1:
                                         MaxChars=25,Style=2,ZORDER=1000,visible=1,Border=1,SelectAll=1,ObjectID=(LastEditRow),Static=0,BGColor=$Window:
                                         edittype=5

....                      incr               TabID
....                      CREATE             ItemPanel;EProductGroup(LastEditRow)=(EditTop + ((LastEditRow-1) * 19)):(EditTop + ((LastEditRow-1) * 19)+ 20):(EditLeft + 400):((EditLeft + 460)):
....                                         Style=2,ZORDER=1000,visible=1,Border=1,Alignment=2:
....                                         TabID=TabID:
....                                         overtype=1:
....                                         AutoEnter=1:
....                                         SelectAll=1,ObjectID=(LastEditRow),Static=0,BGColor=$Window:
....                                         edittype=5


                      incr               TabID
                      CREATE             ItemPanel;NPrice(LastEditRow)=(EditTop + ((LastEditRow-1) * 19)):(EditTop + ((LastEditRow-1) * 19)+ 20):(EditLeft + 460):((EditLeft + 540)):
                                         DecimalDigits=2,IntegerDigits=5,Style=2,ZORDER=1000,visible=1,Border=1,Alignment=3:
                                         TabID=TabID:
                                         overtype=1:
..HR 2019.7.2                                         AutoEnter=1:
                                         SelectAll=1,ObjectID=(LastEditRow),AllowMinus=1,Static=0,BGColor=$Window

                      incr               TabID
                      CREATE             ItemPanel;EUOM(LastEditRow)=(EditTop + ((LastEditRow-1) * 19)):(EditTop + ((LastEditRow-1) * 19)+ 20):(EditLeft + 540):((EditLeft + 580)):
                                         Style=2,ZORDER=1000,visible=1,Border=1,Alignment=2:
                                         TabID=TabID:
                                         AutoEnter=1:
                                         overtype=1:
                                         SelectAll=1,ObjectID=(LastEditRow),Static=0,BGColor=$Window:
                                         edittype=5

                      incr               TabID
                      CREATE             ItemPanel;NExtended(LastEditRow)=(EditTop + ((LastEditRow-1) * 19)):(EditTop + ((LastEditRow-1) * 19)+ 20):(EditLeft + 580):(EditLeft + 650):
                                         AutoEnter=1:
                                         TabID=TabID:
                                         overtype=1:
                                         DecimalDigits=2,IntegerDigits=7,Style=2,ZORDER=1000,visible=1,Border=1,Alignment=3:
                                         SelectAll=1,ObjectID=(LastEditRow),AllowMinus=1,Static=0,BGColor=$Window
.
                      incr               TabID
                      CREATE            ItemPanel;EBModify(LastEditRow)=(EditTop + ((LastEditRow-1) * 19)):(EditTop + ((LastEditRow-1) * 19)+ 20):(EditLeft + 650):((EditLeft + 650) + 20),"N":
                                         TabID=TabID:
                                        ZOrder=1000,visible=1:
                                         ObjectID=(LastEditRow),enabled=0

                      incr               TabID
                      CREATE            ItemPanel;EBDelete(LastEditRow)=(EditTop + ((LastEditRow-1) * 19)):(EditTop + ((LastEditRow-1) * 19)+ 20):(EditLeft + 670):((EditLeft + 670) + 20),"X":
                                         TabID=TabID:
                                         ZOrder=1000,visible=1:
                                         ObjectID=(LastEditRow),enabled=0

                      EVENTREG          EPartNumber(LastEditRow),24,ValidatePartNumber,ObjectID=RowSelected

                      EVENTREG          NQuantityOrdered(LastEditRow),3,ChangeOrderQty,ObjectID=RowSelected
                      EVENTREG          NQuantityOrdered(LastEditRow),9,GainedFocus,ObjectID=CommentLine
.                      EVENTREG          NQuantityOrdered(LastEditRow),3,ValidateQuantity,ObjectID=RowSelected


                      EVENTREG          NQuantityShipped(LastEditRow),10,KeyPressQuantity,result=KeyPress,OBJECTID=RowSelected
                      EVENTREG          NQuantityShipped(LastEditRow),3,ValidateQuantity,ObjectID=RowSelected
                      EVENTREG          NQuantityShipped(LastEditRow),24,ValidateQuantity,ObjectID=RowSelected
                      EVENTREG          NQuantityShipped(LastEditRow),9,GainedFocus,ObjectID=CommentLine

                      EVENTREG          NPrice(LastEditRow),10,ValidateQuantity,ObjectID=RowSelected
                      EVENTREG          NPrice(LastEditRow),24,ValidateQuantity,ObjectID=RowSelected
                      EVENTREG          EUOM(LastEditRow),24,ValidateUOM,ObjectID=RowSelected

                      EVENTREG          NQuantityBackOrder(LastEditRow),9,GainedFocus,ObjectID=CommentLine
                      EVENTREG          EPartNumber(LastEditRow),9,GainedFocus,ObjectID=CommentLine
                      EVENTREG          EUOM(LastEditRow),9,GainedFocus,ObjectID=CommentLine
                      EVENTREG          NPrice(LastEditRow),9,GainedFocus,ObjectID=CommentLine
                      EVENTREG          NExtended(LastEditRow),9,GainedFocus,ObjectID=CommentLine

                      ACTIVATE           EPartNumber(LastEditRow)
....                      ACTIVATE           EProductGroup(LastEditRow)
                      ACTIVATE           EUOM(LastEditRow)
                      ACTIVATE           NQuantityOrdered(LastEditRow)
                      ACTIVATE           NQuantityShipped(LastEditRow)
                      ACTIVATE           NQuantityBackOrder(LastEditRow)
                      activate           EBModify(LastEditRow)
                      activate           EBDelete(LastEditRow)

                      ListIns            PartEntryColl,EPartNumber(LastEditRow):
                                                       NQuantityOrdered(LastEditRow):
                                                       NQuantityShipped(LastEditRow):
....                                                       EProductGroup(LastEditRow):
                                                       EUOM(LastEditRow):
                                                       NQuantityBackOrder(LastEditRow):
                                                       EBModify(LastEditRow):
                                                       NPrice(LastEditRow):
...                                                       NDiscount(LastEditRow):
                                                       NExtended(LastEditRow):
                                                       EBDelete(LastEditRow)

                      ListIns            PartQtyColl,NQuantityShipped(LastEditRow)
.                                                     NQuantityBackOrder(LastEditRow)

                      if               (CompletedFlag = 1)
                        setprop          CBCompleted,value=0
.                        setprop          NQuantityShipped(LastEditRow),Static=0,BGColor=$Window,enabled=1
.                        setprop          NQuantityBackorder(LastEditRow),Static=0,BGColor=$Window,enabled=1
                        setprop          PartQtyColl,Static=0,BGColor=$Window,enabled=1
                      else
                        setprop          CBCompleted,value=1
.                        setprop          NQuantityShipped(LastEditRow),Static=CompletedFlag,BGColor=$BtnFace,enabled=0
.                        setprop          NQuantityBackorder(LastEditRow),Static=CompletedFlag,BGColor=$BtnFace,enabled=0
                        setprop          PartQtyColl,BGColor=$BtnFace,enabled=0,static=1
                      endif

                    if                 (LastEditRow = 1)
                      setfocus           NQuantityOrdered(LastEditRow)
                    endif
                    return
;==========================================================================================================
ChangeOrderQty
OrderQty            form               9

                    getprop          NQuantityOrdered(RowSelected),value=OrderQty
                    setprop            NQuantityShipped(RowSelected),value=OrderQty
...                    setprop            NQuantityBackOrder(RowSelected),value=OrderQty
                    call               ValidateQuantity
                    return
;==========================================================================================================
OnClickCompleted
                      getprop          CBCompleted,value=CompletedFlag
                      if               (CompletedFlag = 1)
                        setprop          CBCompleted,value=0
.                        setprop          NQuantityShipped(LastEditRow),Static=0,BGColor=$Window,enabled=0
.                        setprop          NQuantityBackorder(LastEditRow),Static=0,BGColor=$Window,enabled=0
                        setprop          PartQtyColl,BGColor=$Window,static=0,enabled=1
                      else
                        setprop          CBCompleted,value=1
.                        setprop          NQuantityShipped(LastEditRow),Static=CompletedFlag,BGColor=$BtnFace,enabled=1
.                        setprop          NQuantityBackorder(LastEditRow),Static=CompletedFlag,BGColor=$BtnFace,enabled=1
                        setprop          PartQtyColl,BGColor=$BtnFace,static=1,enabled=0
                      endif

                    return
;==========================================================================================================
;==========================================================================================================
KeyPressPartNumber
; 37 = Left, 39=Right, 40=Down, Up =38
..                      EVENTREG          EPartNumber(X),10,KeyPressPartNumber,ObjectID=RowSelected,result=KeyPress
                    display            "Key Pressed: ",KeyPress," ObectID = ",RowSelected

                    F2Search           EPartNumber(RowSelected),Parts

                    switch             KeyPress
                    case               38
                      if                 (RowSelected != 1)
                        decr               RowSelected
                      endif

                    case               40
                      if                 (RowSelected != LastEditRow)
                        incr               RowSelected
                      endif
                    default
                    return
                    endswitch

                    setfocus           EPartNumber(RowSelected)
                    return
;==========================================================================================================
GotFocusQuantity
                    display            "Got Focus Quanntity"

                    return
;==========================================================================================================
KeyPressQuantity
                    display            "Key Pressed: ",KeyPress," ObectID = ",RowSelected
                    switch             KeyPress

                    case               38
                      if                 (RowSelected != 1)
                        decr               RowSelected
                      endif

                    case               40
                      if                 (RowSelected != LastEditRow)
                        incr               RowSelected
                      endif
                    default
                      return
                    endswitch

                    setfocus           NQuantityOrdered(RowSelected)
                    return
;==========================================================================================================
ValidateUOM
                    getprop            EUOM(RowSelected),text=UOM
                    squeeze            UOM,UOM
                    switch             UOM
                    CASE              "C"
                      MOVE              "100",Divisor
                    CASE              "M"
                      MOVE              "1000",Divisor
                    CASE              "EA"
                      MOVE              "1",Divisor
                    CASE              "##"                    //HR 5/18/2005
                      MOVE              "1",Divisor           //HR 5/18/2005
                    CASE              "# "                    //HR 7.22.2014
                      MOVE              "1",Divisor           //HR 7.22.2014
                    CASE              "LT"                    //HR 10/14/2005
                      MOVE              "1",Divisor           //HR 10/14/2005
                    CASE              "GR"                    //HR 10/14/2005
                      MOVE              "1",Divisor           //HR 10/14/2005
                    CASE              "LB"                    //HR 10/14/2005
                      MOVE              "1",Divisor           //HR 10/14/2005
                    CASE              "FT"                    //HR 10/14/2005
                      MOVE              "1",Divisor           //HR 10/14/2005
                    CASE              "PK"                    //HR 10/14/2005
                      MOVE              "1",Divisor           //HR 10/14/2005
                    CASE              "BX"                    //HR 10/14/2005
                      MOVE              "1",Divisor           //HR 10/14/2005
                    CASE              "RD"                    //HR 10/14/2005
                      MOVE              "1",Divisor           //HR 10/14/2005
                    CASE              "NC"                    //HR 10/14/2005
                      MOVE              "1",Divisor           //HR 10/14/2005
                    CASE              "LT"                    //HR 10/14/2005
                      MOVE              "1",Divisor           //HR 10/14/2005
                    default
                    alert              note,"Invalid Unit of Measure",result,"ERROR: INVALID UOM"
                    setfocus           EUOM(RowSelected)
                    return
                    ENDSWITCH
                    call               ValidateQuantity
                    return
;==========================================================================================================
ValidateQuantity

;
; Validate the Quantity
;
; Check with the On Hand Quantity as well as the Replacement Part

.nventoryControlled form               1
.eplacementPart     dim                16

..HR 2019.7.24                    getprop            NQuantityOrdered(RowSelected),value=OrderQuantity
                    getprop            NQuantityShipped(RowSelected),value=ShipQuantity
                    getprop            NQuantityOrdered(RowSelected),value=OrderQuantity

                    calc               BackOrderQuantity = OrderQuantity - ShipQuantity

                    setprop            NQuantityBackOrder(RowSelected),value=BackOrderQuantity

                    getprop            NPrice(RowSelected),value=OrderPrice

                    MOVE               OrderDetails.UnitPrice,ExtendedPrice

                    calc               ExtendedPrice = (ShipQuantity * OrderPrice) /Divisor
                    setprop            NExtended(RowSelected),value=ExtendedPrice

                    call               UpdateGrandTotals
                    if                 (RowSelected = LastEditRow)
                      call               CreateItemRow
                      display          "Row Selected = "
                    endif
                    return
;==========================================================================================================
KeyPressKitPart

                    F2Search           ECustomerID,Cust
...                    candisp            ETermsCode,ARTRM,STermCode,Desc
                    return
;==========================================================================================================
KeyPressTerm
.                    F2Search           ETermsCode,ARTRM
                    return
;==========================================================================================================
ResetPartsEntry
.                    for                 X from "1" to LastEditRow using "1"
.                      destroy            EPartNumber(X)
.                      destroy            EDescription(X)
.                      destroy            EUOM(X)
.                      destroy            ESize(X)
.                      destroy            NPrice(X)
.                      destroy            NQuantity(X)
.                      destroy            NExtended(X)
.                      destroy            EBModify(X)
.                      destroy            EBDelete(X)

.                    repeat
                    destroy            PartEntryColl
                    ListDel            PartEntryColl
                    clear              LastEditRow
                    clear              EAdditionalLines
                    return
;==========================================================================================================
CheckOrderHeader
;
; Check if there's any "Open" Kit Header's and find out what to do if there is one
;
BrowseKit
                    return
;==========================================================================================================
ValidateOrderHeader
.                    DEBUG


                    return
;==========================================================================================================
OnClickBAccept
                      display          "OnClickAccept"

                    switch             Status
                    case               1                           //Changed
                      call               EnablePartItems
                      call               CreateItemRow
                    case               2                           //New
                      move               "0",LastEditRow
                      call               CreateItemRow
                    endswitch

                    return
;==========================================================================================================
ResetHeader
                    setprop            ECustomerID,text=""
                    setprop            EComments,text=""
                    setprop            DTOrderDate,enabled=1
                    return
;==========================================================================================================
ValidateCustomer
..                    debug
; On Change,
;      Enter Part Number
;      Validate Part Number
;      Bring up Browse of available kits that can be updated
;      If selected, bring up all Kit Details and Create an ItemRow for each Kit Detail\
;      Setup Change Button and turn on/off appropriate buttons
;
                    display            "Validate Customer"
                    move               "        ",CustKY
                    clear              CustKY
                    getprop            ECustomerID,text=CustKY
                    call               RDCust if (CustKY != "")
                    if                 (ReturnFl = 1)
                      beep
                      clearevents
                      alert              stop,"Invalid Customer Number",result,"INVALID PART"
                      setfocus           ECustomerID
                      return
                    else
                      call               SetMainValidObjects
                      call               SetCustomerInfo
                    endif
.                      if               (Parts.SellableItem != 1)              //Cannot Sell individually
.                        clearEvents
.                        alert            note,"This Inventory Item cannot be sold separately as an individual part",result,"UNABLE TO SELL"
.                        setfocus           EPartNumber(RowSelected)
.                        return

.                      endif
.                    debug
.                    if                 (Status = 0)                        //Change
.                      call               BrowseFile
.
.                      if               (PassedVar = "Y")
.                      move             $SearchNum,OrderHeader.OrderNumber
.                      packkey          OrderHeaderKY from $Entity,SaveOrderHeader,OrderHeader.OrderNumber
.                      call             RDOrderHeaderLK
.                      call             LoadOrderDetails
.                      endif

.                    endif

.                    move               OrderHeader.KitPartNumber,Parts.PartNumber
.                    call               SetMainValidObjects
.                    call               SetCustomerInfo
.                    return
                     MOVE              "2",Status
                     call              CreateItemRow
                     setprop           EditCollection,static=0,BGColor=$Window
                     setprop           DTOrderDate,enabled=1
                     CBTerms.SetCurSel using *Index=0
                     setprop           CBTerms,enabled=1

..HR 20200317                     setfocus          STPONO
                     setfocus          DTOrderDate              //HR 20200317
                    return
;==========================================================================================================

ValidateTerms
..                    mustdisp           ETermsCode,ARTRM,STermCode,Desc
                    return
;==========================================================================================================
SetCustomerInfo
;
; Main customer information
;
                    setprop            ECustName,text=Cust.Name
                    setprop            ECustAddr1,text=Cust.Addr1
                    setprop            ECustAddr2,text=Cust.Addr2
                    setprop            ECustAddr3,text=Cust.Addr3

                    setprop            ECustCity,text=Cust.City
                    setprop            ECustSt,text=Cust.St
                    setprop            ECustZip,text=Cust.Zip
                    setprop            ECustCountry,text=Cust.Country
;
; Main Ship-To information
;
                    setprop            STShipName,text=Cust.Name

                    setprop            STShipAddress1,text=Cust.Addr1
                    setprop            STShipAddress2,text=Cust.Addr2
                    setprop            STShipAddress3,text=Cust.Addr3

                    setprop            STShipCity,text=Cust.City
                    setprop            STShipSt,text=Cust.St
                    setprop            STShipZip,text=Cust.Zip

.                    setprop            ETermsCode,text=Cust.TermCode
.                    candisp            ETermsCode,ARTRM,STermCode,Desc


.                    setprop            EShipToCustAddr2,text=Cust.Addr2
.                    setprop            EShipToCustAddr3,text=Cust.Addr3

.                    setprop            EShipToCustCity,text=Cust.City
.                    setprop            EShipToCustSt,text=Cust.St
.                    setprop            EShipToCustZip,text=Cust.Zip
.                    setprop            ETermsCode,text=Cust.TermCode

                    call               LoadShipToInfo


                    return
;==========================================================================================================
LoadShipToInfo
                    CBShipTo.ResetContent
                    CBShipTo.InsertString using *String="ADD NEW SHIP TO",*Index=0
                    move               "0",ShipToNum

ShipCustomerID      dim                6

                    move               Cust.CustomerID,ShipCustomerID

                    packkey            ShipToKY from ShipCustomerID,"      "
                    call               RDShipTo
                    loop
                      call               KSShipTo
                    until (ReturnFl = 1 or ShipTo.CustomerID != ShipCustomerID)
                      incr               ShipToNum
                      chop             ShipTo.Addr1,ShipTo.Addr1
                      chop             ShipTo.City,ShipTo.City

                      pack               DataLine from ShipToNum," - ",ShipTo.Addr1,", ",ShipTo.City
                      CBShipTo.InsertString using *String=DataLine,*Index=ShipToNum
                      CBShipTo.SetItemData using *Index=ShipToNum,*Data=ShipTo.SeqNo
                    repeat
                    CBShipTo.SetCurSel using *Index=1
                    return
;==========================================================================================================
OnClickShipTo
                    CBShipTo.GetCurSel giving result

                    if                 (result != 0)
                      CBShipTo.GetItemData giving ShipToNum using *Index=result
                      display            "Result = ",result

                      move               Cust.CustomerID,ShipCustomerID
                      pack               ShipToKY from ShipCustomerID,ShipTonum
                      call               RDShipTo

                      setprop            STShipName,text=Cust.Name,static=1,BGColor=$BtnFace

                      setprop            STShipAddress1,text=ShipTo.Addr1,static=1,BGColor=$BtnFace
                      setprop            STShipAddress2,text=ShipTo.Addr2,static=1,BGColor=$BtnFace
                      setprop            STShipAddress3,text=ShipTo.Addr3,static=1,BGColor=$BtnFace

                      setprop            STShipCity,text=ShipTo.City,static=1,BGColor=$BtnFace
                      setprop            STShipSt,text=ShipTo.St,static=1,BGColor=$BtnFace
                      setprop            STShipZip,text=ShipTo.Zip,static=1,BGColor=$BtnFace

                      if                 (ShipTo.Country = "   ")
                        move               "USA",ShipTo.Country
                      endif

                      setprop            STShipCountry,text=ShipTo.Country,static=1,BGColor=$BtnFace
                    else
                      setprop            STShipName,static=0,BGColor=$Window

                      setprop            STShipAddress1,static=0,BGColor=$Window
                      setprop            STShipAddress2,static=0,BGColor=$Window
                      setprop            STShipAddress3,static=0,BGColor=$Window

                      setprop            STShipCity,static=0,BGColor=$Window
                      setprop            STShipSt,static=0,BGColor=$Window
                      setprop            STShipZip,static=0,BGColor=$Window
                      setprop            STShipCountry,static=0,BGColor=$Window
                    endif

                    return
;==========================================================================================================
;==========================================================================================================
OnClickCancelKit
                    return
;==========================================================================================================
OnCloseKitDetails
..                    setprop            WkitDetails,visible=0
                    return
;==========================================================================================================
OnClockCancelShipTo
                    setprop            WShipTo,visible=0
                    return
;==========================================================================================================
OnClockAcceptShipTo
                    setprop            WShipTo,visible=0
                    return
;==========================================================================================================
OnClickShipTo2
                    setprop            WShipTo,visible=1
                    return
;==========================================================================================================
SetMainValidObjects
.
. OK, we've been able to read the record and now let's show it on the screen.
.
                    CALL               SETMAIN
.                    MOVE               "3",Status                   .We've found a record
                    ENABLEITEM         BMainCHANGE
                    ENABLETOOL         ID_Change
                    EnableDBMenu       MModifyRecord

..HR 2019.8.9                    ENABLEITEM         BMainDELETE
                    ENABLETOOL         ID_Delete
                    EnableDBMenu       MDeleteRecord

                    setprop            ECustomerID,Static=1,BGColor=$BtnFace
                    DISABLEITEM        Fill1
                    SETFOCUS           BMainChange
                    return
;==========================================================================================================
UpdateGrandTotals
Freight             form               9.2
GrandTotals         form               9.2
SubTotals           form               9.2
TaxTotals           form               9.2


                    clear              SubTotals,GrandTotals,TaxTotals

                    for                 X from "1" to (LastEditRow - 1) using "1"
                      getprop            NExtended(X),value=ExtendedPrice
                      add                ExtendedPrice,SubTotals
                    repeat

                    getprop            NFreight,value=Freight
                    setprop            NSubTotal,value=SubTotals
                    setprop            NTax,value=GrandTotals
                    calc               GrandTotals = SubTotals + TaxTotals + Freight
                    setprop            NTotals,value=GrandTotals
                    return
;==========================================================================================================
; Read the Customer History record for updating at the bottom
; of this routine.
;
UpdateCustomerHistory
                    move               ARTrn.TransDate,CHST.Year                  //We'll onnly capture the year
                    unpack             ARTrn.TransDate,YYYYF,MMF

                    packkey            ChstKY,$Entity,ARTrn.CustomerID,YYYYF
                    call               RDChst
                    if                 (ReturnFL = 1)
                      clear              CHST
                      move               $Entity,CHST.Entity
                      move               ARTrn.CustomerID,CHST.CustomerID
                      move               ARTrn.TransDate,CHST.Year                  //We'll onnly capture the year
                      unpack             ARTrn.TransDate,YYYYF,MMF

                      switch             ARTrn.InvCredit
                      case               "I"
                        add                ARTrn.OrigAmt,CHST.PurchAmt(MMF)
                        add                ARTrn.OrigAmt,CHST.PurchAmt(13)
                        add                "1",CHST.PurchTotal(MMF)
                        add                "1",CHST.PurchTotal(13)
                      case               "D"
                        add                ARTrn.OrigAmt,CHST.PurchAmt(MMF)
                        add                ARTrn.OrigAmt,CHST.PurchAmt(13)
                      case               "C"
                        sub                ARTrn.OrigAmt,CHST.PurchAmt(MMF)
                        sub                ARTrn.OrigAmt,CHST.PurchAmt(13)
                      endswitch
                      call              WRTChst
                    else
                      move               ARTrn.TransDate,CHST.Year                  //We'll onnly capture the year
                      unpack             ARTrn.TransDate,YYYYF,MMF

                      switch             ARTrn.InvCredit
                      case               "I"
                        add                ARTrn.OrigAmt,CHST.PurchAmt(MMF)
                        add                ARTrn.OrigAmt,CHST.PurchAmt(13)
                        add                "1",CHST.PurchTotal(MMF)
                        add                "1",CHST.PurchTotal(13)

                      case               "D"
                        add                ARTrn.OrigAmt,CHST.PurchAmt(MMF)
                        add                ARTrn.OrigAmt,CHST.PurchAmt(13)
                      case               "C"
                        sub                ARTrn.OrigAmt,CHST.PurchAmt(MMF)
                        sub                ARTrn.OrigAmt,CHST.PurchAmt(13)
                      endswitch
                      call              UPDChst
                    endif
                    return
;==========================================================================================================
                    include            AddARTran.inc
;==========================================================================================================
                   include           MenuDefs.INC
;==========================================================================================================
PrintSample
.                    PRTOPEN            P,"@pdf:","",NOPRINT
.                    MOVE            "P",PrintType                   //Print Mode
.                    call               PrintInvoices3
.                    alert              Plain,"Do you wish to accept this Invoice?",result,"Accept Invoice?"
                    return
;==========================================================================================================
PrintInvoices
              MOVE              "Y",PrintByCustomer
              MOVE              "Y",PrintByCust

              SETITEM           EFromInvoice,0,"0"
              SETITEM           EToInvoice,0,"999999999"
.
. When printing Invoices/Credits, set it up to default to Invoices Only
.
              SETITEM           CBInvoiceType,0,4

              SETPROP           WPrintInvoice,visible=1
              RETURN            IF (CancelFlag = 1)

              GETITEM           EFromInvoice,0,PrintFromInvoiceD
              GETITEM           EToInvoice,0,PrintToInvoiceD
              GETITEM           CBInvoiceType,0,PrtInvType

              getprop           DTFromDate,text=PrintFromDate
              getprop           DTToDate,text=PrintToDate

              GETITEM           RAllInvoices,0,result
              IF                (result = 1)
                MOVE            "P",PrintType                   //Print Mode
              ELSE
                MOVE            "R",PrintType                   //Re-Print Mode
              ENDIF

              MOVE              "1",RunType
              MOVE              "0",PrinterOpened

PrintInvoices2
              MOVE              "0",FaxJobNumber
              MOVE              PrintFromInvoiceD,PrintFromInvoice
              MOVE              PrintToInvoiceD,PrintToInvoice
PrintInvoices3
              MOVE              "860",FormLineNo

              MOVE              "0",ResetNumber
              CLEAR             InvoicesToReset
;=============================================================================
. Logic to have the Customer's Sorted Alphabetically
.
..                SETITEM           RPrintViaPrinter,0,1      //HR 4/20/2005  Select the Printer now

                PACKKEY           InvoicesKY3 FROM $Entity,"N"
                PACKKEY           InvoicesKY2 FROM $Entity,PrintFromDate

                CALL              RDInvoices3 if (PrintType = "P")
                CALL              RDInvoices2 if (PrintType = "R")
                MOVE              "Y",FirstPrint
                MOVE              "0",Invoices.Reference
                MOVE              "0",SortedCounter
                CLEAR             SortedCustomer
                CLEAR             SortedInvoice


              LOOP
                CALL              KSInvoices3 if (PrintType = "P")
                CALL              KSInvoices2 if (PrintType = "R")
              UNTIL             ((Invoices.Printed = "Y" or ReturnFL = 1) and PrintType = "P")
              UNTIL             ((Invoices.TransDate > PrintToDate or ReturnFL = 1) and PrintType = "R")
                CONTINUE          IF (PrtInvType = 2 and Invoices.InvCredit != "C")    //Ignore everything except Credit Memos
                CONTINUE          IF (PrtInvType = 3 and Invoices.InvCredit != "D")    //Ignore everything except Debit Memos
                CONTINUE          IF (PrtInvType = 4 and Invoices.InvCredit != "I")    //Ignore everything except Debit Memos
                CONTINUE          IF ((Invoices.Reference < PrintFromInvoice or Invoices.Reference > PrintToInvoice) and PrintType = "R")      /
                CONTINUE          IF (PrintType = "R" and Invoices.Printed != "Y")
.
. We've got a valid Invoice to print.  Let's just simply record the Invoice Number along with the Customer Name in the
. SortedInvoice and the SortedCustomer variables
.
                PACKKEY           CustKY FROM Invoices.BillCust
                CALL              RDCust
                CONTINUE          IF (ReturnFL = 1)
                ADD               "1",SortedCounter
                MOVE              Cust.Name,SortedCustomer(SortedCounter)
                MOVE              Invoices.Reference,SortedInvoice(SortedCounter)
                IF                (PrintType = "P")                                      //HR 2019.7.9
                  move              Invoices.Reference,InvoicesToReset(SortedCounter)    //Moved Up from below
                endif
              REPEAT
              move                SortedCounter,ResetNumber


              CALL              PrintInit2

..HR 7.1.2019 Not Required              CALL              SortInvoicesByCustomer

;
; Moved from below
;
              FOR               IndexCounter FROM "1" TO SortedCounter USING "1"
                BREAK             IF (PrintCancelFlag = 1)            //User Aborted Print options

                SETMODE           *MCURSOR=*Wait

                PACKKEY           InvoicesKY FROM $Entity,SortedInvoice(IndexCounter)
                CALL              RDInvoices
                IF                (ReturnFL = 1)
                  ALERT             stop,"Invoice Number is missing...Please report error ",result,"ERROR!"
                  CONTINUE
                ENDIF

                MOVE              Invoices.TermCode,ARTRMKY
                CALL              RDARTRM
                MOVE              Invoices.BillCust,CustKY
                CALL              RDCust

                clear                  PrinterFallThrough

;
; For Index Counter
;
..HR 2019.7.9                FOR               IndexCounter FROM "1" TO SortedCounter USING "1"
;
; Moved from above

PrintNewCopyFlag    form               1

                clear            PrintNewCopyFlag
                FOR              CopyNumber FROM "1" TO "5" USING "1"          //3
Harry123
                  IF                (PrintType = "P" and CopyNumber >=2 and PrtInvType = 4)    //HR 4/20/2005  Set to Main when printing Regular Invoices
                    SETITEM           RPrintViaPrinter,0,1      //HR 4/20/2005  Select the Printer now
                  ENDIF

                  CONTINUE          IF ((CopyNumber = 2 or CopyNumber >= 4) and PrintType = "R")

; Moed from above  ^^^^^^^

                  CONTINUE          IF (Invoices.InvCredit = "C" and CopyNumber != 3)        //HR 5/6/2005 Only print 3rd copy for Credits
                  CONTINUE          IF (Invoices.InvCredit = "D" and CopyNumber != 3)        //HR 4/9/2009 Only print 3rd copy for Credits

...                  CONTINUE          if (Cust.InvMethod = 4 and CopyNumber != 3)          //Do Not PRINT Option is selected  HR 3/8/2010

                  PACK              DocumentType from "Invoice :",Invoices.Reference
;
; After printing the first Copy Invoice, set the Printer Method to Default and print this fucker
;
                  if                   (CopyNumber > 1)
                    set                  PrinterFallThrough
                    if                 (PrintNewCopyFlag = 0 and PrtPrintOption != "P")      //Default Printer
                      set                PrintNewCopyFlag
                      move               "1",CopyNumber
                    endif
                  endif

                  CALL              OpenCustomerPrinter         //Let's see what the Customer wants to print/fax/E-mail

..HR 2019.7.9                  IF                (PrintType = "P" and CopyNumber = 1)
..HR 2019.7.9                    ADD               "1",ResetNumber
..HR 2019.7.9                    MOVE              Invoices.Reference,InvoicesToReset(ResetNumber)
..HR 2019.7.9                  ENDIF

                  MOVE              "860",FormLineNo
                  CALL              PrintInvoiceHeader
                  PACKKEY           InvDetailsKY3 FROM Invoices.Entity,Invoices.SeqMajor
                  CALL              RDInvDetails3
                  LOOP
                    CALL              KSInvDetails3
                  UNTIL             (Invoices.SeqMajor != InvDetails.SeqMajor or ReturnFL = 1)

                    IF                (FormLineNo >= 2057)
                      MOVE              "860",FormLineNo
                      CALL              PrintInvoiceHeader
                    ENDIF

                    CALL              PrintDetailLine
                    CALL              PrintAdditionalLines
                    ADD               DoubleLine,FormLineNo
                  REPEAT                                        //Invoice Detail records
.
. Let's now update the record AFTER we've printed it properly.
. We're going to comment this out for now simply because we don't want to update
. it until we're ready to go live.  It's that simple
.
                  CALC              InvSubtotal = Invoices.InvoiceAmt - Invoices.Freight

                  if                   (CopyNumber = 1 OR CopyNumber = 2 or CopyNumber = 5)
                  PRTPAGE                   P;*Alignment=*Decimal:
                                            *FONT="FIXED(10)":
                                            *boldon:
                                            *P=1960:2310,InvSubTotal:
                                            *P=1960:2380:                       //,*Alignment=*Decimal:
                                            Invoices.Freight:
                                            *P=1960:2450,Invoices.InvoiceAmt:
                                            *Alignment=*Left:
                                            *boldoff
                 endif

                REPEAT                              //Print Copies
                CALL            PrintClose1     if (PrintByCust = "Y" or PrinterFallThrough = 1)  //If we're not seperating by Customer, then no need to close printer until end

                MOVE              "Y",FirstPrint           //HR 6/22/2019     Was "Y"    No need to Form Feed when at the end of each section.

              REPEAT                                //Print Invoices
.
. We're done with either Copy 1 or Copy 3 or ....Whatever!!!  Close all of the Print Files now!!!!

              CALL            PrintClose                        //Normal Print Close...Submits PDF files if necessary
.
. We've finished printing....Let's see if we have to reset anything based upon the "Print" flag
.
              debug
              IF                (PrintType = "P")
                FOR               X FROM "1" TO ResetNumber USING "1"
                  PACKKEY           InvoicesKY FROM $Entity,InvoicesToReset(X)
                  CALL              RDInvoices
                  CONTINUE          IF (ReturnFL = 1)                            //Record not found
                  CONTINUE          IF (Invoices.Printed = "Y")                   //Already printed
                  MOVE              "Y",Invoices.Printed
                  CALL              UpdInvoices                                   //Update the Invoice Header record now to 'P'rinted
                REPEAT
              ENDIF

              SETMODE           *MCURSOR=*Arrow
              PRTCLOSE          P,Maximize=1
              RETURN
;==========================================================================================================
PrintInvoicePreview
                    PRTOPEN            P,"@pdf:","",NOPRINT
                    move               "1",CopyNumber
                    move               "Y",FirstPrint
                    MOVE               "860",FormLineNo
                    call               GetOrderHeader
                    CALL               PrintInvoiceHeader

                    clear              OrderDetailArray
                    for                X from "1" to (LastEditRow - 1) using "1"
                      call               MoveEntryFieldsToInvoice
                      chop               InvDetails.PartNumber,InvDetails.PartNumber                  //HR 2019.8.16
                      debug
                      continue           if (InvDetails.PartNumber = "")                              //HR 2019.7.22

                      IF                (FormLineNo >= 2057)
                        MOVE              "860",FormLineNo
                        CALL              PrintInvoiceHeader
                      ENDIF

                      CALL              PrintDetailLine
                      call              WriteAdditionalLines
                      CALL              PrintAdditionalLines
                      ADD               DoubleLine,FormLineNo
                    REPEAT                                        //Invoice Detail records
.
. Let's now update the record AFTER we've printed it properly.
. We're going to comment this out for now simply because we don't want to update
. it until we're ready to go live.  It's that simple
.
                      CALC                      InvSubtotal = Invoices.InvoiceAmt - Invoices.Freight

                      PRTPAGE                   P;*Alignment=*Decimal:
                                                *FONT="FIXED(10)":
                                                *P=1960:2310,InvSubTotal:
                                                *P=1960:2380:                       //,*Alignment=*Decimal:
                                                Invoices.Freight:
                                                *boldon:
                                                *P=1960:2450,Invoices.InvoiceAmt:
                                                *Alignment=*Left:
                                                *boldoff

                    PRTCLOSE             P,Maximize=1:
                                         Zoom=3
                    return
;==========================================================================================================
ShowInvoiceLoadMod routine           Document

                   MOVE              Document,PrintFromInvoiceD
                   MOVE              Document,PrintToInvoiceD

                   CREATE            LightGray=*LTGRAY
                   GETITEM           LightGray,0,LightGrayRGB        //HR 6/2/2005

                   MOVE              "1",RunType
                   MOVE              "0",PrinterOpened
                   move              "Y",PrintByCust

                   CALL              OpenInvoices
                   CALL              OpenInvDetails

                   CALL              OpenARTRN
                   CALL              OpenCustD
                   CALL              OpenARTrm
                   CALL              OpenCntry

                   CALL              OpenSequence
                   call              OpenInvNotes
                   CALL              OpenCust

                   CREATE             CompanyLogo=100:349:100:930,"\apc\CompanyLogo.jpg"
.
. When reprinting Invoices/Credits, set it up to print 'everything'
.
                   PACKKEY           InvoicesKY FROM $Entity,Document
                   CALL              RDInvoices

                   IF                ( ReturnFL = 1 )
                     ALERT             stop,"Invoice/Credit does not exist",result
                     SETMODE           *MCURSOR=*Arrow
                   endif

                   move              Invoices.BillCust,CustKY
                   call              RDCust

..HR 2019.10.25                    PRTOPEN            P,"@pdf:",""
                    move            "Y",PrintInitFailed
                    trap              CancelPrinterSelected if spool
                    PRTOPEN            P,"@?",""
                    return           if (printInitFailed = "N")

                    move               "1",CopyNumber
                    move               "Y",FirstPrint
                    MOVE               "860",FormLineNo
                    CALL               PrintInvoiceHeader

                   PACKKEY           InvDetailsKY3 FROM Invoices.Entity,Invoices.SeqMajor
                   CALL              RDInvDetails3
                   LOOP
                     CALL              KSInvDetails3
                   UNTIL             (Invoices.SeqMajor != InvDetails.SeqMajor or ReturnFL = 1)
                     chop               InvDetails.PartNumber,InvDetails.PartNumber                  //HR 2019.8.16

                     IF                (FormLineNo >= 2057)
                       MOVE              "860",FormLineNo
                       CALL              PrintInvoiceHeader
                     ENDIF

                     CALL              PrintDetailLine
                     CALL              PrintAdditionalLines
                     ADD               DoubleLine,FormLineNo
                   REPEAT                                        //Invoice Detail records
.
. Let's now update the record AFTER we've printed it properly.
. We're going to comment this out for now simply because we don't want to update
. it until we're ready to go live.  It's that simple
.
                      CALC                      InvSubtotal = Invoices.InvoiceAmt - Invoices.Freight

                      PRTPAGE                   P;*Alignment=*Decimal:
                                                *FONT="FIXED(10)":
                                                *P=1960:2310,InvSubTotal:
                                                *P=1960:2380:                       //,*Alignment=*Decimal:
                                                Invoices.Freight:
                                                *boldon:
                                                *P=1960:2450,Invoices.InvoiceAmt:
                                                *Alignment=*Left:
                                                *boldoff

                    PRTCLOSE             P,Maximize=1:
                                         Zoom=3
                    return
;==========================================================================================================
CancelPrinterSelected
                   trapclr           spool
                   move              "N",printInitFailed
                   return
;==========================================================================================================
WriteAdditionalLines
                    chop               EAdditionalLines(X),EAdditionalLines(X)
                    return             if (EAdditionalLines(X) = "")
                    move               InvDetails.Entity,InvNotes.Entity
                    move               InvDetails.SeqMajor,InvNotes.SeqMajor
                    move               InvDetails.SeqMinor,InvNotes.SeqMinor
                    move               EAdditionalLines(X),InvNotes.Comments
                    if                 (PreviewFlag = 1)
                    else
                      call               WrtInvNotes
                    endif
                    return
;==========================================================================================================
PrintAdditionalLines
AdditionalLineCount form               3

                    if                 (PreviewFlag = 1)
                      return             if (EAdditionalLines(X) = "")

                    else
                      packkey            InvNotesKY from $Entity,InvDetails.SeqMajor,InvDetails.SeqMinor
                      call               RDInvNotes
                      return             if (ReturnFl = 1)
                    endif

Harry5
                    clear              AdditionalLineCount
                    clear              PrtAdditionalLines
                    explode            InvNotes.Comments,AlertReturn,PrtAdditionalLines
                    loop
                      incr               AdditionalLineCount
                    until              (PrtAdditionalLines(AdditionalLineCount) = "")

                      PRTPAGE           P;*FONT="HELVETICA(9)":                                     //HR 2019.7.22
                                        *alignment=*left:
                                        *OverLayOn:
                                        *BoldOn:
                                        *V=FormLineNo,*H=650,PrtAdditionalLines(AdditionalLineCount):
                                        *Boldoff:
                                        *OverLayOff
                      ADD               "45",FormLineNo
                    repeat
                    return
;==========================================================================================================
PrintDetailLine
              PRTPAGE           P;*FONT="HELVETICA(9)":                                             //HR 2019.7.22
                                *alignment=*decimal:
                                *OverLayOn:
                                *boldon:
                                *V=FormLineNo,*H=190,InvDetails.OrderQty:
                                *H=390,InvDetails.ShipQty:
                                *H=590,InvDetails.BackOrderQty:
                                *alignment=*left:
                                *BoldOn:
                                *H=650,InvDetails.PartNumber:
                                *Boldoff:
                                *OverLayOff

PrtExtendedAmt      form               7.2

                    move               InvDetails.UnitPrice,PrtExtendedAmt

              if                 (CopyNumber = 1 or CopyNumber = 2 or CopyNumber = 5)
              PRTPAGE           P;*FONT="HELVETICA(9)":                                           //HR 2019.7.22
                                *alignment=*decimal:
                                *OverLayOn:
                                *V=FormLineNo:
                                *boldon:
                                *H=1608,PrtExtendedAmt,*H=1775,InvDetails.UOM:
                                *H=1953,InvDetails.ExtendedAmt:
                                *boldoff:
                                *OverLayOff

              endif

              ADD               "45",FormLineNo

              RETURN
;==========================================================================================================
AddNewShipTo
                   move              Cust.CustomerID,ShipToCustomer
                   PACKKEY           ShipToKY from ShipToCustomer,"9999"
                   call                   RDShipTo
                   call                   KPShipTo
                   IF                (ReturnFl = 0 and ShipTo.CustomerID = ShipToCustomer)
                     add                  "1",ShipTo.SeqNo
                     move                 ShipTo.SeqNo,SaveShipTo
                     CLEAR             ShipTo
                     MOVE              SaveShipTo,ShipTo.SeqNo
                   ELSE
                     CLEAR             ShipTo
                     MOVE              "0",ShipTo.SeqNo
                   ENDIF

                   move                   Cust.CustomerID,ShipTo.CustomerID
                   getprop                STShipName,text=Cust.Name
                   getprop                STShipAddress1,text=ShipTo.Addr1
                   getprop                STShipAddress2,text=ShipTo.Addr2
                   getprop                STShipAddress3,text=ShipTo.Addr3
                   getprop                STShipCity,text=ShipTo.City
                   getprop                STShipSt,text=ShipTo.St
                   getprop                STShipZip,text=ShipTo.Zip
                   getprop                STShipCountry,text=ShipTo.Country
                   move                   ShipTo.Name,ShipTo.LookupName
                   clock                  TimeStamp,ShipTo.Created
                   clock                  TimeStamp,ShipTo.Rec_Added

                   call                   WrtShipTo
                   return
;==========================================================================================================
PrintInvoiceHeader
                    UNPACK            Invoices.ShipDate into CC,YY,MM,DD
                    PACK              ShipDate FROM MM,slash,DD,slash,YY

                    UNPACK            Invoices.BillDate into CC,YY,MM,DD
                    PACK              BillDate FROM MM,slash,DD,slash,YY

                    CHOP              Invoices.ShipVia,Invoices.ShipVia

                    IF                (FirstPrint = "N")      //HR 6/9/2004
                      PRTPAGE           P;*NewPage            //HR 6/9/2004
                    ENDIF                                     //HR 6/9/2004

                    MOVE              "N",FirstPrint

                    SWITCH            Invoices.InvCredit

                    CASE              "C"
                      MOVE              "CREDIT MEMO",InvoiceType
                    CASE              "D"
                      MOVE              "DEBIT MEMO",InvoiceType
                    CASE              "I"
                      MOVE              "INVOICE",InvoiceType
                    ENDSWITCH

                    CHOP              Invoices.ShipToCity          //HR 3/29/2005
                    CHOP              Cust.City                 //HR 3/29/2005

                    CHOP              Cust.Addr1
                    CHOP              Cust.Addr2
                    CHOP              Cust.Addr3

                    ResetVar          AddressLines
                    MOVE              "1",AddressLineCounter

                    IF                (Cust.Addr1 != "")
                      MOVE              Cust.Addr1,AddressLines(AddressLineCounter)
                      ADD               "1",AddressLineCounter
                    ENDIF

                    IF                (Cust.Addr2 != "")
                      MOVE              Cust.Addr2,AddressLines(AddressLineCounter)
                      ADD               "1",AddressLineCounter
                    ENDIF

                    IF                (Cust.Addr3 != "")
                      MOVE              Cust.Addr3,AddressLines(AddressLineCounter)
                      ADD               "1",AddressLineCounter
                    ENDIF

                    PACK              AddressLines(AddressLineCounter),Cust.City,", ",Cust.St,"  ",Cust.Zip
                    ADD               "1",AddressLineCounter

                    IF                (Cust.Country != "USA" and Cust.Country != "   ")  //We're shipping to another Country
                      MOVE              Cust.Country,CNTRYKY
                      CALL              RDCntry
                      IF                (ReturnFl = 1)
                        MOVE              "         ",AddressLines(AddressLineCounter)
                      ELSE
                        MOVE              CNTRY.Name,AddressLines(AddressLineCounter)
                      ENDIF
                    ENDIF
;
; Added 2019.8.1
;
                    IF                (Cust.Contact != "")
                      COUNT             CharCount,Cust.Contact
                      IF                (CharCount != 0)
                        MOVE              Cust.Contact,ContactName
                      ELSE
                        MOVE              "Accounts Payable",ContactName
                      ENDIF
                      pack             AddressLines(AddressLineCounter) from "Attn: ",ContactName
                      ADD               "1",AddressLineCounter
                    ENDIF

;
; Create ShipTo Information
;
                    CHOP              Invoices.ShipToAddr1
                    CHOP              Invoices.ShipToAddr2
                    CHOP              Invoices.ShipToAddr3

                    ResetVar          ShipToAddressLines
                    MOVE              "1",ShipToAddressLineCounter

                    IF                (Invoices.ShipToAddr1 != "")
                      MOVE              Invoices.ShipToAddr1,ShipToAddressLines(ShipToAddressLineCounter)
                      ADD               "1",ShipToAddressLineCounter
                    ENDIF

                    IF                (Invoices.ShipToAddr2 != "")
                      MOVE              Invoices.ShipToAddr2,ShipToAddressLines(ShipToAddressLineCounter)
                      ADD               "1",ShipToAddressLineCounter
                    ENDIF

                    IF                (Invoices.ShipToAddr3 != "")
                      MOVE              Invoices.ShipToAddr3,ShipToAddressLines(ShipToAddressLineCounter)
                      ADD               "1",ShipToAddressLineCounter
                    ENDIF

                    PACK              ShipToAddressLines(ShipToAddressLineCounter),Invoices.ShipToCity,", ",Invoices.ShipToSt,"  ",Invoices.ShipToZip
                    ADD               "1",ShipToAddressLineCounter

                    IF                (Invoices.ShipToCountry != "USA" and Invoices.ShipToCountry != "   ")  //We're shipping to another Country
                      MOVE              Invoices.ShipToCountry,CNTRYKY
                      CALL              RDCntry
                      IF                (ReturnFl = 1)
                        MOVE              "         ",ShipToAddressLines(ShipToAddressLineCounter)
                      ELSE
                        MOVE              CNTRY.Name,ShipToAddressLines(ShipToAddressLineCounter)
                      ENDIF
                    ENDIF

                    PRTPAGE           P;*FONT="HELVETICA(9)":
                                      *FGCOLOR=*BLACK:
                                      *UNITS=*LOMETRIC:
                                      *RECT=55:165:1700:2010:             //Was 80                   //Paper Type (i.e. Invoice, Packing Slip, etc)
                                      *P=1700:75,*LINE=2010:75:
                                      *RECT=640:720:1:410,*RECT=640:720:410:600:         //Customer Order No, Date Shipped, Weight
                                      *RECT=640:720:600:750,*RECT=640:720:750:900:       //Cartons, Shipped Via, Terms
                                      *RECT=640:720:900:1300,*RECT=640:720:1300:1700:    //Order, (Completed/Partial)
                                      *RECT=640:720:1700:2010:
                                      *FGCOLOR=*Black,*BGCOLOR=LightGrayRGB:
                                      *FILL=*ON:
                                      *OVERLAYON:
                                      *RECT=55:115:1700:2010:             //Was 80                   //Paper Type (i.e. Invoice, Packing Slip, etc)
                                      *RECT=720:800:1:1470:               //340                      //,*RECT=810:850:340:1190:
                                      *FONT="HELVETICA(7)",*BOLDON:
                                      *FGCOLOR=*Black,*BGCOLOR=LightGrayRGB:
                                      *OVERLAYOFF:
                                      *V=725,*H=280,"QUANTITY":                        //,*H=645,"DESCRIPTION":
                                      *v=760:
                                      *H=056,"ORDERED",*H=260,"SHIPPED",*h=401,"BACK ORDERED":
                                      *h=1000,"DESCRIPTION":
                                      *FILL=*OFF:
                                      *FGCOLOR=*BLACK,*BGCOLOR=*WHITE:
                                      *P=1:720,*LINE=1:2500:
                                      *P=001:755,*LINE=600:755:
                                      *P=200:755,*LINE=200:2500:
                                      *P=400:755,*LINE=400:2500:
                                      *P=600:720,*LINE=600:2500:
                                      *P=1470:720,*LINE=1470:2500:
                                      *P=2010:720,*LINE=2010:2500:
                                      *P=1:2500,*LINE=2010:2500:
                                      *FONT="HELVETICA(9)":
...HR 2019.9.4                                      *P=110:360,"S",*H=110,*V=395,"O",*H=110,*V=430,"L":
...HR 2019.9.4                            *P=110:465,"D",*H=110,*V=530,"T",*H=110,*V=565,"O":
                                      *P=020:360,"S",*H=020,*V=395,"O",*H=020,*V=430,"L":
                                      *P=020:465,"D",*H=020,*V=530,"T",*H=020,*V=565,"O":
                                      *P=1350:360,"S",*H=1350,*V=395,"H",*H=1350,*V=430,"I":
                                      *P=1350:465,"P",*H=1350,*V=530,"T",*H=1350,*V=565,"O":
                                      *FONT="HELVETICA(6)":
..HR 20200317                                      *V=643,*H=20,"CUSTOMER ORDER NO.",*H=306,"DATE SHIPPED":
                                      *V=643,*H=20,"CUSTOMER ORDER NO.",*H=413,"DATE SHIPPED":
                                      *H=606,"WEIGHT",*H=756,"CARTONS":
..HR 20200317                                      *H=806,"SHIPPED VIA",*h=1306,"TERMS",*H=1706,"ORDER":
                                      *H=906,"SHIPPED VIA",*h=1306,"TERMS",*H=1706,"ORDER":
                                      *v=685:
                                      *h=1750,"COMPLETE",*RECT=685:715:1710:1740:
                                      *h=1910,"PARTIAL",*RECT=685:715:1870:1900:
                                      *FONT="HELVETICA(8)":
                                      *FGCOLOR=*BLACK:
                                      *BOLDON,*FONT="HELVETICA(10)":
                                      *P=1758:115,Invoices.Reference:
                                      *BGCOLOR=*YELLOW:
                                      *BOLDOFF:
                                      *BOLDON,*FONT="HELVETICA(10)":
                                      *OverlayOn:                                                //HR 12/8/2005
                                      *OverlayOff:                                                //HR 12/8/2005
                                      *FONT="HELVETICA(8)",*FGCOLOR=*RED,*BOLDON:
                                      *FGCOLOR=*BLACK,*BOLDOFF:
                                      *FONT="HELVETICA(9)":
                                      *FGCOLOR=*BLACK,*BGCOLOR=*YELLOW,*OVERLAYON:
                                      *FGCOLOR=*BLACK,*BGCOLOR=*WHITE:
                                      *FONT="HELVETICA(9)":
                                      *V=300,*H=220,"ACCT ## ",Invoices.BillCust:
                                      *V=360,*H=220,Cust.Name:
                                      *V=405,*H=220,AddressLines(1):
                                      *V=450,*H=220,AddressLines(2):
                                      *V=495,*H=220,AddressLines(3):
                                      *V=540,*H=220,AddressLines(4):
                                      *V=585,*H=220,AddressLines(5):
                                      *FONT="HELVETICA(9)":
                                      *V=300,*H=1440,"ACCT ## ",Invoices.ShipToCust:
                                      *V=360,*H=1440,Invoices.ShipToName:
                                      *V=405,*H=1440,ShipToAddressLines(1):
                                      *V=450,*H=1440,ShipToAddressLines(2):
                                      *V=495,*H=1440,ShipToAddressLines(3):
                                      *V=540,*H=1440,ShipToAddressLines(4):
                                      *V=585,*H=1440,ShipToAddressLines(5):
                                      *P=1480:2510:
                                      *FONT="HELVETICA(6)":
                                      "Items not shipped at this time will be backordred and":
                                      *P=1480:2535,"invoiced at the time of Shipment.  All claims for defective":
                                      *P=1480:2560,"material, shortages and discrepancies are waived unless ":
                                      *P=1480:2585,"made in writing within ten days from the date of shipment":
                                      *P=1480:2610,"Unauthorized returns will not be accepted":
                                  *FONT="HELVETICA(9)",*boldon:
                                  *V=682,*H=20,Invoices.CustomerPO:
                                  *H=427,ShipDate:
                                  *H=615,Invoices.Weight:
                                  *H=770,Invoices.Cartons:
                                  *H=910,Invoices.ShipVia:
                                  *H=1310,ARTRM.Desc:
                                  *boldoff:
                                      *PL;

                    PRTPAGE           P;*PictRect=*Off:
                                        *OverLayOff:
..HR 2019.7.24                                        *Pict=10:260:40:0870:CompanyLogo
                                        *Pict=10:289:40:0897:CompanyLogo

...                                        *Pict=40:290:1110:1699:CompanyLogo2


                    if                 (Invoices.Completed = 1)
                      PRTPAGE           P;*FONT="HELVETICA(9)":
                                        *BoldOn:
                                        *FGCOLOR=*BLACK:
                                        *P=1712:681,"X":
                                        *boldOff;
                    else
                      PRTPAGE           P;*FONT="HELVETICA(9)":
                                        *BoldOn:
                                        *FGCOLOR=*BLACK:
                                        *P=1872:681,"X":
                                        *Boldoff;
                    endif

                    PRTPAGE           P;*BGCOLOR=LightGrayRGB:
                                        *OverLayOn,*BoldOn

                    SWITCH            Invoices.InvCredit
                    CASE              "I"

                    CASE              "C"
                      PRTPAGE           P;*P=1495:2550,*FGCOLOR=*Black,"Credit Amt":       //HR 8/10/2005 ,*OverLayOff:
                                                *BGCOLOR=*White
                    CASE              "D"
                      PRTPAGE           P;*P=1495:2550,*FGCOLOR=*Black,"Debit Amt":       //HR 8/10/2005 ,*OverLayOff:
                                                *BGCOLOR=*White
                    ENDSWITCH

                    SWITCH            CopyNumber
                    CASE              1 or 2 or 5
                      PRTPAGE           P;*FGCOLOR=*Black:       //HR 8/10/2005 ,*OverLayOff:
                                                *BGCOLOR=*White:
                                                *PenSize=4:
                                                *FONT="FIXED(10)":
                                                *PenSize=1:
                                                *FGCOLOR=*Black,*BGCOLOR=LightGrayRGB:
                                                *FILL=*ON:
                                                *OVERLAYON:
                                                *RECT=2305:2500:1470:1770:
                                                *FONT="HELVETICA(10)":
                                                *overLayOff:
                                                *P=1743:65,"INVOICE NO.":
                                                *H=1470,*V=2435,*LINE=2010:2435:
                                                *H=1470,*V=2365,*LINE=2010:2365:
                                      *FGCOLOR=*Black,*BGCOLOR=LightGrayRGB:
                                      *FILL=*ON:
                                      *PenSize=4:
                                      *RECT=720:800:1470:2010:               //340                      //,*RECT=810:850:340:1190:
                                      *PenSize=1:
...                                      *OVERLAYON:
..HR 2019.7.15 WTF                                          *PenSize=4:
                                                *FONT="FIXED(10)":
                                                *OverLayOn:
                                                *boldon:
                                                *P=1495:2320,"SubTotal":
                                                *P=1495:2390,"Freight":
                                                *P=1495:2450,"Invoice Total":
                                                *OverLayOff:
                                                *boldoff:
                                                *FGCOLOR=*Black:
                                                *BGCOLOR=*White:
                                                *H=1770,*V=2435,*LINE=2010:2435:
                                                *H=1770,*V=2365,*LINE=2010:2365:
                                                *P=1670:720,*LINE=1670:2305:
                                                *P=1770:720,*LINE=1770:2500:
                                                *FONT="HELVETICA(7)",*BOLDON:
                                                *v=765:
                                                *OverLayOff:
                                                *FGCOLOR=*Black,*BGCOLOR=LightGrayRGB:
                                                *H=1550,"PRICE":
                                                *H=1690,"UNITS":
                                                *H=1840,"AMOUNT",*BOLDOFF:
                                                *FGCOLOR=*Black,*BGCOLOR=*White:
                                                *H=1470,*V=2305,*LINE=2010:2305:
                                                *H=1470,*V=2435,*LINE=2010:2435:
                                                *H=1470,*V=2365,*LINE=2010:2365:
..                                          *RECT=720:800:1470:2010:               //340                      //,*RECT=810:850:340:1190:
                                          *OverLayOn:
                                          *PenSize=4:
                                           *H=1,*V=800,*LINE=2010:800:
                                           *OverLayOff:
                                  *boldOn:
                                  *FONT="HELVETICA(9)",*boldon:
                                  *P=0896:2575,"ISO-9001:2015":               // ISO-9001:2015
                                  *boldoff:
                                                *FONT="HELVETICA(10)";

                    if                 (CopyNumber = 5)
                      MOVE              DupeMessage,CopyMessage
                    else
                      MOVE              OrigMessage,CopyMessage
                    endif

                    prtpage           P;*FONT="HELVETICA(8)",*FGCOLOR=*Black,*BOLDON:
                                      *P=680:2280,"ALL CORRESPONDENCE AND REMITTANCE TO:":
                                      *P=840:2320,"APC COMPONENTS INC.":
                                      *P=920:2350,"P.O. Box 255":
                                      *P=860:2390,"Farmingdale, NY  11735":
                                      *P=800:2450,"accounting@apccomponents.com":
                                      *boldoff;


                    CASE              3 or 4
                      MOVE              CertMessage,CopyMessage
                    prtpage           P;*FONT="HELVETICA(10)",*FGCOLOR=*Black,*BOLDON:
                                      *P=0645:2350,"CERTIFICATE OF CONFORMANCE":               //2450
                                      *FONT="HELVETICA(9)":
                                      *P=0686:2450,"qualitycontrol@apccomponents.com":
                                      *boldon:
                                  *FONT="HELVETICA(9)",*boldon:
                                  *P=0819:2575,"ISO-9001:2015":               // ISO-9001:2015
                                      *FONT="HELVETICA(7)",*FGCOLOR=*Black,*BOLDOFF:
                                      *P=335:2520,"MATERIAL AND/OR PARTS FURNISHED ON THIS ORDER HAVE BEEN MANUFACTURED IN":
                                      *P=380:2545,"ACCORDANCE WITH ALL APPLICABLE INSTRUCTIONS AND SPECIFICATIONS":
                                      *FONT="HELVETICA(7)",*FGCOLOR=*Black:
                                      *P=0335:2655,"By _____________________________________________________________________":
                                      *P=0730:2685,"QUALITY CONTROL":
                                      *OverLayOn:
                                      *PictRect=*Off:
..                                      *Pict=0721:2499:1471:2009:ShadingLogo:   //  ShadingLogo:            //1480   720
..                                      *Pict=1658:2502:1471:2009:  ShadingLogo:
                                      *BGCOLOR=LightGrayRGB:
                                      *FILL=*ON:
                                      *OVERLAYON:
                                      *RECT=0720:2500:1470:2010:             //Was 80                   //Paper Type (i.e. Invoice, Packing Slip, etc)
                                      *P=1:2500,*LINE=2010:2500:
                                      *FGCOLOR=*Black,*BGCOLOR=LightGrayRGB:
                                      *FONT="HELVETICA(10)":
                                      *P=1743:65,"PACKING SLIP";

                    ENDSWITCH

                    PRTPAGE           P;*BGCOLOR=*White:
                                      *FONT="HELVETICA(9)",*BOLDON:
                                      *H=1500,*V=2650,CopyMessage:
                                      *FONT="FIXED(10)":
                                      *FGCOLOR=*Black:
                                      *BoldOff:
                                      *OverLayoff
                    RETURN
;==========================================================================================================
PrintCustomHeader
              RETURN
;==========================================================================================================
SortInvoicesByCustomer
              FOR                IndexCounter FROM "1" TO (SortedCounter - 1) USING "1"
                FOR                IndexCounter2 FROM "1" TO (SortedCounter - IndexCounter) USING "1"
                  IF                (SortedCustomer(IndexCounter2) > SortedCustomer(IndexCounter2 + 1))
                    MOVE              SortedCustomer(IndexCounter2 + 1),TempInvCust
                    MOVE              SortedCustomer(IndexCounter2),SortedCustomer(IndexCounter2 + 1)
                    MOVE              TempInvCust,SortedCustomer(IndexCounter2)

                    MOVE              SortedInvoice(IndexCounter2 + 1),TempInvoice
                    MOVE              SortedInvoice(IndexCounter2),SortedInvoice(IndexCounter2 + 1)
                    MOVE              TempInvoice,SortedInvoice(IndexCounter2)
                  ENDIF
                REPEAT
              REPEAT
              RETURN
;==========================================================================================================
CheckPrintStatus
              GETITEM           RAllInvoices,0,result
              IF                (result = 1)
                DISABLEITEM       EFromInvoice
                DISABLEITEM       EToInvoice
                SETPROP          EFromInvoice,BGCOLOR=$BTNFACE
                SETPROP          EToInvoice,BGCOLOR=$BTNFACE
                setprop          DTFromDate,enabled=0
                setprop          DTToDate,enabled=0
                MOVE            "P",PrintType                   //Print Mode
              ELSE
                SETPROP          EFromInvoice,BGCOLOR=$Window,enabled=1
                SETPROP          EToInvoice,BGCOLOR=$Window,enabled=1
                setprop          DTFromDate,enabled=1
                setprop          DTToDate,enabled=1
                MOVE            "R",PrintType                   //Re-Print Mode
              ENDIF
              RETURN
;==========================================================================================================
LoadTerms
                    CBTerms.ResetContent
                    move               " ",ARTRMKY
                    clear              TermCodeCounter
                    call               RDARTRM
                    loop
                      call               KSARTRM
                    until (ReturnFl = 1)
                      move               ARTRM.Code,TermCodeArray(TermCodeCounter)
                      CBTerms.InsertString using *String=ARTRM.Desc,*Index=TermCodeCounter
                      incr               TermCodeCounter
                    repeat
                    return
;==========================================================================================================
PrintInvoicesLoadMod            ROUTINE Document

              MOVE              Document,PrintFromInvoiceD
              MOVE              Document,PrintToInvoiceD
              MOVE              "19000101",PrintFromDate             //Set the lowest possible Date
              MOVE              "21001231",PrintToDate               //Set the highest possible Date
              MOVE              "1",PrtInvType                       //Set to print ALL invoices as a LoadMod

              MOVE              "R",PrintType                        //Re-Print Mode

              CREATE                 LightGray=*LTGRAY
              GETITEM                LightGray,0,LightGrayRGB        //HR 6/2/2005

              MOVE              "1",RunType
              MOVE              "0",PrinterOpened
              move              "Y",PrintByCust

              CALL              OpenInvoices
              CALL              OpenInvDetails


              CALL              OpenARTRN
              CALL              OpenCustD
              CALL              OpenARTrm
              CALL              OpenCntry

              CALL              OpenSequence
              call              OpenInvNotes
              CALL              OpenCust

...Not Needed 7/3/2019              call               PrintPreviewInit

                    CREATE             CompanyLogo=100:349:100:930,"\apc\CompanyLogo.jpg"
..HR 2019.7.15                    CREATE             CompanyLogo2=100:349:100:681,"f:\apc\CompanyLogo2.jpg"

.
. When reprinting Invoices/Credits, set it up to print 'everything'
.
              PACKKEY           InvoicesKY FROM $Entity,Document
              CALL              RDInvoices

              IF                ( ReturnFL = 1 )
..HR 2019.11.11                pack                 dataline from ":",Document,":","  Key:",InvoicesKY
..HR 2019.11.11                alert             note,DataLine,result
                ALERT             stop,"Invoice/Credit does not exist",result
                SETMODE           *MCURSOR=*Arrow
              ELSE
                MOVE              Invoices.TransDate,PrintFromDate              // Set the lowest possible Date
                MOVE              Invoices.TransDate,PrintToDate                // Set the highest possible Date
                CALL              PrintInvoices2                                //
              ENDIF
              RETURN
;==========================================================================================================
KeyPressComboBoxShipTo
                    EVENTINFO         0,RESULT=result
                    if                          (result = 13)
                      CBShipTo.GetCurSel giving result
                      if                 (result != 0)
                        setfocus           CBTerms
                      else
                        setfocus           STShipName
                      endif
                    endif
                    return
;==========================================================================================================
KeyPressComboBoxTerms
                    EVENTINFO         0,RESULT=result
                    if                          (result = 13)
                    setfocus           CBShipmentCode
                    endif
                    return
;==========================================================================================================
KeyPressComboBoxShipmentCode
                    EVENTINFO         0,RESULT=result
                    if                          (result = 13)
                    setfocus           EWeight
                    endif
                    return
;==========================================================================================================
KeyPressCheckBoxCompleted
                    EVENTINFO         0,RESULT=result
                    if                          (result = 13)
                    setfocus           CBShipTo
                    endif
                    return

;==========================================================================================================
                   include           ShipViaUPS.inc
;==========================================================================================================
ShipVia
                   uppercase         Invoices.ShipVia,Invoices.ShipVia
                   scan              "UPS",Invoices.ShipVia
                   if                (equal)
                     beep
                     alert             plain,"Do you wish to Automatically ship this Invoice out through the UPS System?",result,"SHIP TO UPS?"
                     return            if (result != 1)
                     call              LoadUPSRecord
                     call              ShipViaUPS
                   endif
                   return
;==========================================================================================================
LoadUPSRecord
                   move              Invoices.ShipToName,UPSRecord.ShipToName
                   move              Invoices.ShipToAddr1,UPSRecord.ShipToAddress1
                   move              Invoices.ShipToAddr2,UPSRecord.ShipToAddress2
                   move              Invoices.ShipToAddr3,UPSRecord.ShipToAddress3
                   move              Invoices.ShipToCity,UPSRecord.ShipToCity
                   move              Invoices.ShipToSt,UPSRecord.ShipToState
                   move              Invoices.ShipToZip,UPSRecord.ShipToZip
                   move              Invoices.ShipToCountry,UPSRecord.ShipToCountry
                   move              Invoices.Cartons,UPSRecord.Cartons
                   move              Invoices.Weight,UPSRecord.Weight
                   move              Invoices.ShipVia,UPSRecord.ShipVia
                   move              Cust.ShippingAcct(2),UPSRecord.ShipToAcctNo
                   move              Invoices.InvoiceAmt,UPSRecord.InvoiceAmount
                   return
;==========================================================================================================

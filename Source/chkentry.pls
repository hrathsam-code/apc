;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    4 NORFOLK LANE                                           ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    CHKENTRY.PLS                                                   ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    06/12/2005 AT 1:30AM                                           ;
;                                                                             ;
;  PURPOSE:    Check Entry Program                                            ;
;                                                                             ;
; REVISION:    VER     DATE     INIT       DETAILS                            ;
;                                                                             ;
;              1.0   06/12/2005   HOR     INITIAL VERSION                     ;
;              1.1   03/06/2019   HOR     Resolved issue with Voided Check    ;
;              1.1   10/07/2019   HOR     Modified to resolve issue with      ;
;                                         display proper Vendor Name w/voided ;
;                                                                             ;
;                                                                             ;
;=============================================================================;
;
         INCLUDE   NCOMMON.TXT
         INCLUDE   WORKVAR.INC
.
           GOTO                 #s

#s
.
                    INCLUDE            APTRN.FD         //HR 6/21/2003
                    INCLUDE            APDet.FD
                    INCLUDE            CMPNY.FD         //HR 6/21/2003
                    INCLUDE            Vendor.FD
                    INCLUDE            ARTRM.FD
                    INCLUDE            Check.FD
                    INCLUDE            CheckDet.FD
                    include             Default.FD

                    INCLUDE            Cntry.FD
                    INCLUDE            APDist.FD
                    INCLUDE            Bank.FD
                    INCLUDE            VHST.FD
                    INCLUDE            Sequence.FD
                    INCLUDE            GLMast.FD
                    inc                PrintRtn.inc

                    INCLUDE            CNTRY.FD
                    INCLUDE            ChkRun.FD
                    INCLUDE            ChkRunDt.FD
.=============================================================================
MaxSearch           FORM              "18"
CancelFlag2         FORM              1
Field1              DIM               12
Field2              DIM               12
Field3              DIM               11
DIM16               DIM               16
result10             FORM              9
result11            FORM              8
Mod11               FORM              10
MouseLeft           FORM              4
MouseTop            FORM              4
MouseTopD           DIM               4
MouseLeftD          DIM               4
result13            FORM              12
UnitPriceD          DIM               14
DueDate             DIM               10
DiscountDate        DIM               10
GrossAmountD        DIM               10
GrossAmount         FORM              7.2
DiscAmount          FORM              5.2
NetAmount           FORM              7.2
NetAmountTotals FORM            10.2
NetAmountD          DIM               10
DiscAmountD         DIM               8
CheckTotal          FORM              10.2
CheckNumber         FORM              10
CheckNoD            DIM               10
CheckAmtD           DIM               13
SeqMinor            FORM              3                        //HR 9/6/2005
CheckGrossAmount FORM           7.2
CheckDiscAmount  FORM           7.2
ProcessCheckFlag    dim                1

$CheckBG            DEFINE            9567131    ;Hex value 0x80000001

InvoiceDate         DIM               8
ShipDate            DIM               10
FieldCount          FORM              3
InvoiceKey          DIM               10
GLCounter           FORM              3
NewAgingDays        FORM              10
NewDiscountDays FORM            10
NonDiscAmount       FORM              5.2

ToolBarDetailOption FORM        4

LightGray           COLOR
LightGrayRGB        FORM              8

DayOfWeekF          FORM              1
DayString           DIM               12

EGLAccount          EDITTEXT          (10)
EGLEntity           EDITTEXT          (10)
EGLAmount           EDITNUMBER        (10)
GLTotals            FORM              8.2
GLValue             FORM              8.2

TestGLCode          DIM               8
TestGLEntity        DIM               8

LVResult            DIM               100
LVResultF           FORM              10.4
CalcPrice           FORM              5.5
ExtendedAmt         FORM              9.5
UnitsToShip         FORM              12
PrtInvType          FORM              1

SubItemHit          FORM              2
RowHit              FORM              6
NewRow              FORM              5
DIM10               DIM               10
Form10              FORM              10
Row                 FORM              6
WrkDim3             DIM               3
WrkDim10            DIM               15
Power               FORM              2
.=============================================================================
WrkLineNo           FORM              2
AddRowClicked       FORM              3
.
listCount           FORM              3
FormLineNo          FORM              4
LineNoD             DIM               2
LineNo2             FORM              2
X                   FORM              3
Clicked             FORM              1
ENV2                DIM       2
SEQMAJOR            FORM              7
SeqMajorD           DIM               7
ARTRNINVKY          DIM               18
.
AgingDays           FORM              3
DiscountDays        FORM              3
DiscountPercent     FORM            2.2
dim1                DIM               1

EditTop             FORM              4
EditBottom          FORM              4
EditLeft            FORM              4
EditRight           FORM              4

#MenuObj            Automation
FILL4               INIT              "    "
#MenuItem           DIM               25
REPLY               DIM       1
.
EditColl            COLLECTION
UpdateColl          COLLECTION

EditColl2           COLLECTION
NewColl2            COLLECTION

CheckForm           PLFORM            ChkEntry.PLF
CheckForm2          PLFORM            CHKEnt2.PLF
CheckForm4          PLFORM            ChkEnt4.PLF
DataMenu            plform             DataMenu

VoidedFL           ifile             Name=VendorISI1NM,DUP,NOPATH,UPPER
VoidedKY           like              VendorKY
.
. FILE OPENING SEQUENCE
.
OPENFLS
              LISTINS           EditColl,EVendor,EName,ECity,EState,EZip,EMemo:
                                         EAddress1,EAddress2,EAddress3

              LISTINS           UpdateColl,EMemo

              LISTINS           EditColl2,EMemo2:
                                          EReceiptNo,EDiscAmt,EAmount,ENonDiscAmt:
                                          EGLAccount,EGLEntity,EGLAmount:
                                          EInvoice,EGLTotals,EPO

              LISTINS           NewColl2,EPO:
                                         EMemo2:
                                         EReceiptNo,EDiscAmt,EAmount,ENonDiscAmt:
                                         EAmount,ENonDiscAmt,EDiscAmt:
                                         DTDueDate,DTInvoiceDate,DTDiscDate:
                                         EGLAccount,EGLEntity,EGLAmount:
                                         EInvoice,EGLTotals

              CREATE            LightGray=*LTGRAY
              GETITEM           LightGray,0,LightGrayRGB
.
              Open              VoidedFL,VendorISI1NM,READ
              CALL              OpenAPTRN
              CALL              OpenGLMast
              CALL              OpenCMPNY
              CALL              OpenVendor
              CALL              OpenVendorGL
              CALL              OpenVHST
              CALL              OpenBank
              CALL              OpenARTrm
              CALL              OpenCntry
              CALL              OpenAPDET
              CALL              OpenCheckRun
              CALL              OpenCheckRunDetail
              CALL              OpenAPDist
              CALL              OpenCheck
              CALL              OpenCheckDetail
                                                                // #4 Print Ledger by Date Name Printed in Left to Right Prin in Landscape More
              CALL              OpenSequence                    // Invoicing Portion
              INCLUDE           Temporary.inc

.              WINHIDE
                   move                "2101",Default.APAcct
                   move                "1101",Default.APCashAcct
                   move                "2401",Default.APPurchaseDiscAcct


              FORMLOAD          CheckForm
              FORMLOAD          CheckForm2,WMain
              FORMLOAD          CheckForm4,WMain
              FORMLOAD          DataMenu,WMain

              CALL              SetupLVColumns

              MOVE              "  ",BankKY
              CALL              RDBank
              LOOP
                CALL            KSBank
              UNTIL             (ReturnFL = 1)
                INSERTITEM        CBBranch,999,BankREC.Code
              REPEAT

              SETITEM           CBBranch,1,1

.              %IF       EntryProgramType = 1                            //Credit Memo Entry
.              %ELSEIF              EntryProgramType = 2                 //Debit Memo Entry
.              %ELSEIF              EntryProgramType = 0                 //Invoice Entry
.              %ENDIF

              SETFOCUS          EVendor

              LOOP
                WAITEVENT
              REPEAT
.=============================================================================
MainValid
                CALL            SetMain
              RETURN
.=============================================================================
SetMain

.              %IF       EntryProgramType = 1                            //Credit Memo Entry
.              %ELSEIF              EntryProgramType = 2                 //Debit Memo Entry
.              %ELSEIF              EntryProgramType = 0                 //Invoice Entry
.              %ENDIF

              CALL              RDVendor
              IF                (ReturnFL = 1)
                ALERT             note,"Vendor does not exist in the Vendor Master",result,"Invalid Vendor"
                ClearEvents
                SETFOCUS          EVendor
                RETURN
              ENDIF

              SETPROP           EVendor,BGColor=$CheckBG
              SETPROP           EVendor,ReadOnly=1

              SETITEM           EName,0,Vendor.Name
              SETITEM           EAddress1,0,Vendor.Address1
              SETITEM           EAddress2,0,Vendor.Address2
              SETITEM           EAddress3,0,Vendor.Address3

              SETITEM           ECity,0,Vendor.City
              SETITEM           EZip,0,Vendor.Zip
              SETITEM           EState,0,Vendor.State

              CLOCK             TimeStamp,Date8

              LVDetails.DeleteAllItems

              PACKKEY           APTRNKY3 FROM $Entity,Vendor.AccountNumber,"O"        //Find all Open Transactions  O

              CALL              RDAPTRN3
              LOOP
                CALL              KSAPTRN3
              UNTIL             (ReturnFL = 1 or APTRN.Vendor != Vendor.AccountNumber or APTRN.ClosedFlag != "O")

              MOVE              APTRN.SeqMajor,SeqMajorD
              UNPACK            APTRN.DiscDate into CC,YY,MM,DD
              PACKKEY           DiscountDate FROM MM,slash,DD,slash,YY

              UNPACK            APTRN.DueDate into CC,YY,MM,DD
              PACKKEY           DueDate FROM MM,slash,DD,slash,YY
Harry123
              PACKKEY           CheckRunDetailKY FROM APTRN.Entity,APTRN.Voucher
              CALL              RDCheckRunDetail
              IF                (ReturnFl = 0)
                MOVE              CheckRunDetail.DiscAmt,DiscAmountD
                MOVE              CheckRunDetail.GrossAmount,GrossAmountD
                MOVE              CheckRunDetail.NetAmount,NetAmount
              ELSE
                MOVE              APTRN.Balance,GrossAmountD
                MOVE              APTRN.DiscAmt,DiscAmountD
                CALC              NetAmount = APTRN.Balance - APTRN.DiscAmt
              ENDIF

              MOVE              NetAmount,NetAmountD

              LVDetails.InsertItemEx giving Row using *Text="":
                                                      *SubItem1=SeqMajorD:
                                                      *SubItem2=APTRN.Invoice:
                                                      *SubItem3=DueDate:
                                                      *SubItem4=DiscountDate:
                                                      *SubItem5=GrossAmountD:
                                                      *SubItem6=DiscAmountD:
                                                      *SubItem7=NetAmountD
              IF                (ReturnFl = 0)                            //It's in the Check Run file
                LVDetails.SetItemCheck using *Index=Row,*Value=1            //Check It!!!
              ENDIF

                MOVE              Row,RowSelected                         //HR 4/27/2005
              REPEAT

              SETPROP           UpdateColl,BGCOLOR=$Window
              SETPROP           UpdateColl,ReadOnly=0
              SETFOCUS          LVDetails               //HR 7/2/2009
              RETURN
;=============================================================================
MainCancel
           IF                (Status = 0)      . They want to exit the program
             DESTROY         WMAIN             . Get rid of the Main Window
             NORETURN
             WINSHOW
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
MainClose
              stop
.=============================================================================
MainInit
              RETURN
.=============================================================================
OnClickChangeAmounts
              RETURN
.=============================================================================
MainReset
              CLEAR             CheckRun                        //HR 4/21/2005
              CLEAR             CheckRunDetail                      //HR 4/21/2005

              SETITEM           EditColl,0,""
              SETPROP           UpdateColl,BGCOLOR=$BtnFace    //HR 4/1/2005
              SETPROP           UpdateColl,ReadOnly=1          //HR 4/1/2005

              SETITEM           ChkPrinted,0,0
              SETPROP           NCheckNumber,value=0
              SETPROP           NCheckNumber,BGColor=$CheckBG,ReadOnly=1


              SETPROP           NCheckAmount,value=0
              LVDetails.DeleteAllItems

              SETPROP           EVendor,BGColor=$Window
              SETPROP           EVendor,ReadOnly=0

.              SETPROP           STShipDate,*Enabled=0

              SETFOCUS          EVendor
              RETURN
.=============================================================================
MaintMenuOption
                    CALL                 GetMenuName

                    RETURN
.=============================================================================
OnClickAcceptEntries
              DEBUG
              GETITEM           CBBranch,0,CBresult
              GETITEM           CBBranch,CBresult,BankREC.Code

              GETITEM           ChkPrinted,0,result            //HR 7/1/2009
              IF                (result = 1)                   //Manual Check
;
; Check for Valid Check Number
;
              GETPROP           NCheckNumber,value=Check.CheckNo
              if                (Check.CheckNo = 0)
                beep
                alert                    stop,"A Valid Check Number must be entered before proceeding",result,"ERROR: INVALID CHECK NO"
                return
              endif

                CALL              CreateManualCheck
                CALL              MainReset                    //HR 7/20/2009  Modified to reset after done
                RETURN
              ENDIF
.
. Easy does it!!! Before we do anything, we must get rid of the previous
. Check Run Details first!!!!
.
              PACKKEY           CheckRunDetailKY2 FROM $Entity,Vendor.AccountNumber
              CALL              RDCheckRunDetail2
              LOOP
                CALL              KSCheckRunDetail2
              UNTIL             (ReturnFl = 1 or Vendor.AccountNumber != CheckRunDetail.Vendor)
                CALL              DELCheckRunDetail
              REPEAT
.
. Delete the Check Run record as well, since we'll be writing out a new one at the end anyway!!!
.
              MOVE              "1",CheckRun.SeqMajor

              PACKKEY           CheckRunKY FROM $Entity,Vendor.AccountNumber,BankREC.Code,CheckRun.SeqMajor
              CALL              RDCheckRun
              IF                (ReturnFl = 0)        //We're updating a record, that's why we're deleting it first!!!!
                CALL              DelCheckRun
              ENDIF

              CLEAR             CheckRun

              MOVE              $Entity,CheckRun.Entity
              MOVE              $Entity,CheckRun.SubEntity
.
. Now that we've deleted the previous information,let's now write out the new information!!!
.
              CLOCK             TimeStamp,CheckRun.Year
              CLOCK             TimeStamp,CheckRun.TransDate
              UNPACK            CheckRun.TransDate into YYYY,MM,DD

              MOVE              MM,CheckRun.Month
              MOVE              MM,CheckRun.Month

              MOVE              "  ",CheckRun.Memo
              GETITEM           EMemo,0,CheckRun.Memo

              GETPROP           NCheckAmount,value=CheckRun.CheckAmount

              MOVE              "1",CheckRun.SeqMajor

              MOVE              BankREC.Code,CheckRun.BankCode
              MOVE              Vendor.AccountNumber,CheckRun.Vendor
              MOVE              "0",CheckRun.CheckNo
              MOVE              " ",CheckRun.CheckDate
              MOVE              "0",CheckRun.Printed
              MOVE              "A",CheckRun.CheckFlag
.
. Now let's write out the Detail Lines!!!
.
              MOVE              CheckRun.Entity,CheckRunDetail.Entity
              MOVE              CheckRun.Entity,CheckRun.SubEntity
              MOVE              CheckRun.CheckNo,CheckRunDetail.CheckNo

              GETITEM           ChkPrinted,0,CheckRun.Printed

              MOVE              CheckRun.SeqMajor,CheckRunDetail.SeqMajor
              MOVE              "0",CheckRun.DiscAmt
              MOVE              "0",CheckRun.GrossAmount
              move              "N",ProcessCheckFlag

              MOVE              "-1",Row
              LOOP
                ADD             "1",Row
                LVDetails.FindItemCheck giving Row using *Start=Row
              UNTIL             (Row = -1)
                LVDetails.GetItemText giving SeqMajorD using *Index=Row,*SubItem=1

                MOVE              SeqMajorD,SeqMajor
                PACKKEY           APTRNKY2 FROM $Entity,SeqMajor
                CALL              RDAPTRN2
                IF                (ReturnFL = 1)
                  ALERT           stop,"Unable to locate specific A/P Transaction line",result,"Error in reading A/P Transaction"
                  CLEAR           APTRN
                  CONTINUE
                ENDIF

                MOVE              CheckRun.Entity,CheckRunDetail.Entity
                MOVE              CheckRun.Entity,CheckRun.SubEntity
                MOVE              CheckRun.SubEntity,CheckRunDetail.SubEntity

                MOVE              CheckRun.CheckNo,CheckRunDetail.CheckNo

                CLEAR             GrossAmountD
                CLEAR             GrossAmount
                LVDetails.GetItemText giving GrossAmountD using *Index=Row,*SubItem=5
                SQUEEZE           GrossAmountD,GrossAmountD
                MOVE              GrossAmountD,GrossAmount

                CLEAR             DiscAmountD
                CLEAR             DiscAmount
                LVDetails.GetItemText giving DiscAmountD using *Index=Row,*SubItem=6
                SQUEEZE           DiscAmountD,DiscAmountD
                MOVE              DiscAmountD,DiscAmount

                CLEAR             NetAmountD
                CLEAR             NetAmount
                LVDetails.GetItemText giving NetAmountD using *Index=Row,*SubItem=7
                SQUEEZE           NetAmountD,NetAmountD
                MOVE              NetAmountD,NetAmount

                MOVE              APTRN.SeqMajor,CheckRunDetail.SeqMajor
                MOVE              APTRN.Voucher,CheckRunDetail.Voucher
                MOVE              CheckRun.BankCode,CheckRunDetail.BankCode
                MOVE              CheckRun.Vendor,CheckRunDetail.Vendor
                MOVE              CheckRun.CheckNo,CheckRunDetail.CheckNo

                MOVE              GrossAmount,CheckRunDetail.GrossAmount
                MOVE              NetAmount,CheckRunDetail.NetAmount
                MOVE              DiscAmount,CheckRunDetail.DiscAmt

                ADD               CheckRunDetail.DiscAmt,CheckRun.DiscAmt
                ADD               CheckRunDetail.GrossAmount,CheckRun.GrossAmount
                CALC              CheckRunDetail.NetAmount = CheckRunDetail.GrossAmount - CheckRunDetail.DiscAmt
                CALL               WrtCheckRunDetail
                move              "Y",ProcessCheckFlag
              REPEAT
..HR 2019.5.3              IF                (CheckRun.CheckAmount != 0)       //We have a valid Check Run Amount
              IF                (ProcessCheckFlag = "Y")                       //We have a valid Check Run Amount
                CALL              WrtCheckRun
              ENDIF

             CALL               MainReset
             RETURN
;==========================================================================================================
ClearCheckRun
                    move               $Entity,CheckRunKY
                    call               RDCheckRun
                    loop
                      call               KSCheckRun
                    until              (ReturnFl = 1 or $Entity != CheckRun.Entity)
                      PACKKEY           CheckRunDetailKY2 FROM $Entity,CheckRun.Vendor
                      CALL              RDCheckRunDetail2
                      LOOP
                        CALL              KSCheckRunDetail2
                      UNTIL             (ReturnFl = 1 or CheckRun.Vendor != CheckRunDetail.Vendor)
                        CALL              DELCheckRunDetail
                      REPEAT
                    CALL              DelCheckRun
                    repeat
.
. Delete the Check Run record as well, since we'll be writing out a new one at the end anyway!!!
.
              MOVE              "1",CheckRun.SeqMajor            //HR 8/31/2005

              PACKKEY           CheckRunKY FROM $Entity,Vendor.AccountNumber,BankREC.Code,CheckRun.SeqMajor
              CALL              RDCheckRun
              IF                (ReturnFl = 0)        //We're updating a record, that's why we're deleting it first!!!!
              ENDIF

.=============================================================================
LoadDetails
              RETURN
.=============================================================================
SetupLVColumns
              LVDetails.InsertColumn using "Select",50,1,2
              LVDetails.InsertColumn using "APSeqKY",0,2,0
              LVDetails.InsertColumn using "Invoice Number",125,3,0
              LVDetails.InsertColumn using "Due Date",65,4,0
              LVDetails.InsertColumn using "Disc. Date",65,5,1
              LVDetails.InsertColumn using "Gross Amount",85,6,1
              LVDetails.InsertColumn using "Disc. Amount",85,7,1
              LVDetails.InsertColumn using "Net Amount",85,8,1

              MOVE              "33",EditTop
              MOVE              "45",EditLeft
              FOR               X FROM "1" TO "10" USING "1"

                CALC              EditBottom = (EditTop + ((X-1) * 15)+ 16)
                CALC              EditRight = EditLeft + 80

                CREATE            WMain2;EGLAccount(X)=(EditTop + ((X-1) * 15)):(EditTop + ((X-1) * 15)+ 16):EditLeft:(EditRight):
                                  MaxChars=8,Style=2,ZORDER=1000,visible=1,Border=1,SelectAll=1,ObjectID=X

                CREATE            WMain2;EGLEntity(X)=(EditTop + ((X-1) * 15)):(EditTop + ((X-1) * 15)+ 16):(EditLeft+80):(EditRight+80):
                                  MaxChars=8,Style=2,ZORDER=1000,visible=1,Border=1,SelectAll=1,ObjectID=X

                CREATE            WMain2;EGLAmount(X)=(EditTop + ((X-1) * 15)):(EditTop + ((X-1) * 15)+ 16):(EditLeft+160):(EditRight + 160):
                                  DecimalDigits=2,IntegerDigits=6,Style=2,ZORDER=1000,visible=1,Border=1,Alignment=3:
                                  SelectAll=1,ObjectID=X,AllowMinus=1

                ACTIVATE          EGLAccount(X)
                ACTIVATE          EGLEntity(X)
                ACTIVATE          EGLAmount(X)
              REPEAT
              EVENTREG          EGLAmount,3,UpdateGLTotals
              EVENTREG          EGLAccount,10,CheckGLAccountKeyPress,ObjectID=RowSelected
              RETURN
.=============================================================================
GetEditText
              LVDetails.SubItemHitTest  giving result13 using MouseLeft,MouseTop
              DISPLAY           "result 13 :",result13

              CALC              RowHit = result13 / 100
              CALC              SubItemHit = result13 - (RowHit * 100)
              DISPLAY           "Row : ",RowHit,"    Sub : ",SubItemHit

Harry4
              MOVE              " ",LVResult
              MOVE              "0",LVResultF

              LVDetails.GetItemText giving LVResult using RowHit,6
              MOVE              LVResult,LVResultF
              IF                EOS
                MOVE              "0",LVResultF
              ENDIF

              MOVE          LVResultF,ExtendedAmt

              LVDetails.GetItemText giving SeqMajorD using RowHit,1

              MOVE              SeqMajorD,SeqMajor
              PACKKEY           APTRNKY2 FROM $Entity,SeqMajor
              CALL              RDAPTRN2
              IF                (ReturnFL = 1)
                ALERT             note,"A/P Detail transaction does not exist",result
                RETURN
              ENDIF
.
              MOVE              "0",Field3

              LVDetails.GetItemText giving LVResult using RowHit,4

              CLEAR             LVResult
              LVDetails.GetItemText giving LVResult using *Index=RowHit,*SubItem=8
              SETPROP           EMemo,Text=LVResult        //Memo field

              MOVE              " ",LVResult
              LVDetails.GetItemText giving LVResult using *Index=RowHit,*SubItem=17

              CALL              CalculateExtendedAmounts
              MOVE              "0",CancelFlag
.=============================================================================
.
              SETITEM           EInvoiceNumber2,0,APTRN.Invoice

              CLEAR             DueDate,DiscountDate

              LVDetails.GetItemText giving DueDate using *Index=RowHit,*SubItem=3
              LVDetails.GetItemText giving DiscountDate using *Index=RowHit,*SubItem=4

              SETITEM           EDueDate2,0,DueDate
              SETITEM           EDiscDate2,0,DiscountDate

              MOVE              "   ",GrossAmountD
              LVDetails.GetItemText giving GrossAmountD using *Index=RowHit,*SubItem=5
              MOVE              GrossAmountD,GrossAmount

              MOVE              "   ",DiscAmountD
              LVDetails.GetItemText giving DiscAmountD using *Index=RowHit,*SubItem=6
              MOVE              DiscAmountD,DiscAmount

              CALC              NetAmount = GrossAmount - DiscAmount
              SETPROP           NNetAmount,value=NetAmount
              SETPROP           NGrossAmount,value=GrossAmount
              SETPROP           NDiscAmount,value=DiscAmount

              SETFOCUS          NGrossAmount
              SETPROP           WCHKEntry2,visible=1

              IF                (CancelFlag)
                RETURN
              ELSE
.
                CLEAR             LVResult

                MOVE              NetAmount,NetAmountD
                MOVE              GrossAmount,GrossAmountD
                MOVE              DiscAmount,DiscAmountD

                LVDetails.SetItemText giving result using *Index=RowHit,*SubItem=5,*Text=GrossAmountD

                LVDetails.SetItemText giving result using *Index=RowHit,*SubItem=6,*Text=DiscAmountD
.
                LVDetails.SetItemText giving result using *Index=RowHit,*SubItem=7,*Text=NetAmountD

              ENDIF
              call              CalculateCheckDetails
              RETURN
;=============================================================================
InlineEdit
.Only used for inline editing.
.
              LVDetails.GetItemRect giving Dim16 using *Index=RowHit,*Subitem=SubItemHit
              UNPACK            DIM16,EditTop,EditBottom,EditLeft,EditRight

              ADD               "4",EditTop
              ADD               "2",EditBottom

              ADD               "4",EditLeft
              ADD               "3",EditRight

              RETURN
.=============================================================================
GetClickedRow
              LVDetails.SubItemHitTest  giving result13 using MouseLeft,MouseTop

              CALC              RowHit = result13 / 100
              CALC              SubItemHit = result13 - (RowHit * 100)

              LVDetails.GetItemCheck  giving result using *Index=RowHit
              display           "CheckBox = ",result,"   Row : ",RowHit
.
              RETURN
.=============================================================================
CalculateExtendedAmounts
              RETURN

.=============================================================================
UpdateDetailRecord
                CLEAR           LVResult
                CLEAR           WrkDim10

                LVDetails.GetItemText giving LVResult using *Index=RowSelected,*SubItem=6
                MOVE            LVResult,LVResultF
                  LVDetails.GetItemText giving LVResult using *Index=RowSelected,*SubItem=4
                  PARSE             LVRESULT,WrkDim10 using "09.."
                  MOVE              WrkDim10,ExtendedAmt

                  MOVE          ExtendedAmt,LVResult
                  LVDetails.SetItemText giving result using *Index=RowSelected,*SubItem=7,*Text=LVResult
              RETURN

;==========================================================================================================
CalculateCheckDetails
              MOVE              "0",CheckTotal
              LVDetails.GetItemCount giving RowClicked
              FOR                X FROM "0" TO (RowClicked - 1) USING "1"
                LVDetails.GetItemCheck giving Clicked using *Index=X
                IF                (Clicked = 1)             //Row Selected
                  MOVE          "  ",WrkDim10
                  MOVE              "0",NetAmount
                  LVDetails.GetItemText giving WrkDim10 using *Index=X,*SubItem=7
                  MOVE              WrkDim10,NetAmount
                  ADD               NetAmount,CheckTotal
                ENDIF
              REPEAT

              SETPROP           NCheckAmount,Value=CheckTotal
              RETURN
.=============================================================================
MainAbout
              RETURN
.=============================================================================
MainUndo
              RETURN
;=============================================================================
OnClickCheckPrinted
              DEBUG

              GETITEM           ChkPrinted,0,result
              IF                (result = 1)
                SETITEM           ChkPrinted,0,0
                SETPROP           NCheckNumber,value=0,ReadOnly=1,BGColor=$CheckBG
                SETPROP           DTCheckDate,Enabled=0
              ELSE
                SETITEM           ChkPrinted,0,1
                SETPROP           NCheckNumber,ReadOnly=0,BGColor=$Window
                SETFOCUS          NCheckNumber
                CLOCK             TimeStamp,Date8          //HR 7/2/2009 During Testing
                setprop           DTCheckDate,text=Date8

                SETPROP           DTCheckDate,Enabled=1
              ENDIF

              RETURN
.=============================================================================
MainToolBar
              RETURN
.=============================================================================
PrintCustomHeader
              RETURN
;=============================================================================
PrintRTN
              RETURN
.=============================================================================
UpdateAdditionalCharges
              RETURN
;=============================================================================
CalculateNetAmount
              GETPROP           NGrossAmount,value=GrossAmount
              GETPROP           NDiscAmount,value=DiscAmount
              CALC              NetAmount = GrossAmount - DiscAmount
              SETPROP           NNetAmount,value=NetAmount
              RETURN
.=============================================================================
CalculateAdditionalCharges
              RETURN
.=============================================================================
CalculateTotalLineAmount
              RETURN
;=============================================================================
VoidCheck
              RETURN
;=============================================================================
CheckVoidedCheck
              GETITEM           ChkPrinted,0,CBResult
              RETURN            IF (CBResult != 1)

              GETITEM           CBBranch,0,CBResult
              GETITEM           CBBranch,CBresult,BankREC.Code
              GETPROP           NCheckNumber,value=CheckNumber

              PACKKEY           CheckKY FROM $Entity,BankREC.Code,CheckNumber
              CALL              RDCheck
              RETURN            IF (ReturnFl = 1)                   //There's no check to Void!!!

              MOVE              Check.CheckAmount,CheckAmtD
              MOVE              Check.CheckNo,CheckNoD
              SQUEEZE           CheckAmtD,CheckAmtD
              SQUEEZE           CheckNoD,CheckNoD

              move              Check.Vendor,VoidedKY
              read              VoidedFL,VoidedKY;TempVendor

              PACK              AlertString FROM "Do you wish to VOID Check : ",CheckNoD," in the ":
                                                 "Amount of $",CheckAmtD,AlertReturn:
                                                 "for Vendor : ",TempVendor.Name
..HR 2019.10.7                                                 "for Vendor : ",Vendor.Name

              ALERT             Plain,AlertString,result,"VOID CHECK?"
              if                (result != 1)
                setprop           NCheckNumber,value=0                      //Reset the Check Number if cancel or No was selected HR 2019.3.6
                setfocus                 NCheckNumber
                return
              endif

..HR 2019.3.6              RETURN            IF (result != 1)                          //Cancelled or NO was selected
.
. We're now here to Void the Check!!!
.
. Here's the steps that we need to take
.                    Set the VOID FLAG settings on the Check
.                    Read the AP Detail information for this check
.                    Reverse the AP Detail transactions
.                    Update the APTRN transactions
.                    Vendor History update
. Write out information to Check Reconc file
.
              CLOCK             TimeStamp,Check.VoidedDate
              MOVE              "1",Check.VoidedFlag

              PACK              CheckDetailKY FROM Check.Entity,Check.BankCode,Check.CheckNo,"    "
              CALL              RDCheckDetail

              LOOP
                CALL              KSCheckDetail
              UNTIL             (ReturnFl = 1 or Check.BankCode != CheckDetail.BankCode or Check.CheckNo != CheckDetail.CheckNo)
                PACKKEY           APTRNKY2 FROM $Entity,CheckDetail.Voucher
                CALL              RDAPTRN2
                IF                (ReturnFl = 1)
                  ALERT             stop,"Unable to find A/P Transaction",result,"ERROR Reading APTRN"
                  RETURN
                ENDIF
.
. Get the last SeqMinor record for writing out future records.
.
                PACKKEY           APDetKY,$Entity,CheckDetail.Voucher,"999"
                CALL              RDAPDet
                CALL              KPAPDet

                IF                (ReturnFL = 0 and APDetail.SeqMajor = CheckDetail.Voucher)
                  MOVE              APDetail.SeqMinor,SeqMinor
                  ADD               "1",SeqMinor
                ELSE
                  MOVE              "1",SeqMinor
                ENDIF

                CLEAR             APDetail               //Start fresh, JUST in case!!!

                MOVE              APTRN.Entity,APDetail.Entity
                MOVE              APTRN.SubEntity,APDetail.SubEntity
                MOVE              APTRN.SeqMajor,APDetail.SeqMajor
                MOVE              Check.Vendor,APDetail.Vendor
                MOVE              "8",APDetail.TransCode
                MOVE              Check.VoidedDate,APDetail.TransDate
                MOVE              Check.VoidedDate,APDetail.PostDate
                UNPACK            APDetail.PostDate,YYYY,MM,DD
                MOVE              YYYY,APDetail.Year
                MOVE              MM,APDetail.Month
                PACK              APDetail.ReferenceNo,Check.CheckNo
                PACK              APDetail.Memo,"VOIDED : ",Check.CheckNo
                MOVE              CheckDetail.GrossAmount,APDetail.Amount          //Gross = Net Amount + Discount Amt
                MOVE              SeqMinor,APDetail.SeqMinor                //Increment the Minor record by one!!!
.
. OK, we're at the end of the A/P Detail record, let's write it out now!!!!
.
                CALL              WrtAPDet
                CALC              APTRN.Balance = APTRN.Balance + CheckDetail.GrossAmount
                IF                (APTRN.Balance > 0)
                  MOVE              "O",APTRN.ClosedFlag
                ENDIF
                CALL              UpdAPTRN
              REPEAT
              CALL              WriteVendorHistory
              CALL              UpdCheck
              multiply          "-1",Check.CheckAmount
              multiply          "-1",Check.DiscAmt
              multiply          "-1",Check.GrossAmount
              call              WriteGLCheckDetails

              ALERT             note,"This Check has been Voided within the system",result,"Void Complete"
              RETURN
;==========================================================================================================
WriteGLCheckDetails
;
; Write the Accounts Payable Transaction First
;
                GetNextSeq         Pay

                MOVE              Check.Entity,APDist.Entity
                MOVE              Check.SubEntity,APDist.SubEntity
                MOVE              Check.Vendor,APDist.Vendor
                move              Check.CheckNo,APDist.CheckNo
                MOVE              Check.TransDate,APDist.TransDate
                MOVE              Sequence.SeqNo,APDist.SeqMajor
                move              Sequence.SeqNo,Check.CheckSeqMajor
                MOVE              Sequence.SeqNo,APDist.Voucher
                move              Default.APAcct,APDist.GLCode                  //Default A/P GL Code
                UNPACK            APDist.TransDate into APDist.Year,APDist.Month

                MOVE              "0",APDist.PostedToGL
                MOVE              "9",APDist.TransCode                 //Check
                move              "1",APDist.SeqMinor
                PACK              APDist.Description FROM "Check : ",Check.CheckNo," for Vendor : ",APTRN.Vendor

                IF                (Check.GrossAmount > 0)                  //Debit Transaction
                  move              Check.GrossAmount,APDist.DebitAmount
                  MOVE              "0",APDist.CreditAmount
                ELSE                                                   //Credit Transaction
                  multiply          "-1",Check.GrossAmount,APDist.CreditAmount
                  MOVE              "0",APDist.DebitAmount
                ENDIF

                call                   WRTAPDist           // Write out the Debit to A/P Trade Account first
;
; Let's write out the Cash portion of the General Ledger Transaction
;
                IF                (Check.CheckAmount > 0)                  //Debit Transaction
                  move              Check.CheckAmount,APDist.CreditAmount
                  MOVE              "0",APDist.DebitAmount
                ELSE                                                   //Credit Transaction
                  multiply          "-1",Check.CheckAmount,APDist.DebitAmount
                  MOVE              "0",APDist.CreditAmount
                ENDIF
                add                    "1",APDist.SeqMinor
                move                   Default.APCashAcct,APDist.GLCode
                call                   WRTAPDist           // Write out the Credit to Cash Account

                if                (Check.DiscAmt != 0)
                  IF                (Check.DiscAmt > 0)                  //Debit Transaction
                    move              Check.DiscAmt,APDist.CreditAmount
                    MOVE              "0",APDist.DebitAmount
                  ELSE                                                   //Credit Transaction
                    multiply          "-1",Check.DiscAmt,APDist.DebitAmount
                    MOVE              "0",APDist.CreditAmount
                  ENDIF
                  add                    "1",APDist.SeqMinor
                  move                   Default.APPurchaseDiscAcct,APDist.GLCode
                  call                   WRTAPDist           // Write out the Credit to Cash Account
                endif
              RETURN

;=============================================================================
WriteVendorHistory
              UNPACK            Check.VoidedDate,CC,YY,MM,DD
              MOVE              MM,MMF

              PACKKEY           VHSTKY FROM Check.Entity,Check.Vendor,CC,YY
              CALL              RDVHST                                //Read the Vendor History record
              IF                (ReturnFL = 1)                        //Vendor History record not found, add it!!!
                CLEAR             VendorHistory
                MOVE              Check.Entity,VendorHistory.Entity
                MOVE              Check.Vendor,VendorHistory.Vendor
                PACKKEY           VendorHistory.Year FROM CC,YY
                MOVE              Check.DiscAmt,VendorHistory.DiscAmt(MMF)
                MOVE              Check.DiscAmt,VendorHistory.DiscAmt(13)
                MOVE              (Check.CheckAmount * -1),VendorHistory.PaidAmt(MMF)
                MOVE              (Check.CheckAmount * -1),VendorHistory.PaidAmt(13)
                MOVE              "-1",VendorHistory.PaidTotal(MMF)
                MOVE              "-1",VendorHistory.PaidTotal(13)

                MOVE              Check.CheckDate,VendorHistory.LastPayDt
                MOVE              Check.CheckNo,VendorHistory.LastCheck
..HR 9/6/2005                MOVE              (Check.CheckAmount ,VendorHistory.LastPayAmt
                CALL              WrtVHST
              ELSE
                SUBTRACT          Check.DiscAmt,VendorHistory.DiscAmt(MMF)
                SUBTRACT          Check.DiscAmt,VendorHistory.DiscAmt(13)
                SUBTRACT          Check.CheckAmount,VendorHistory.PaidAmt(MMF)
                SUBTRACT          Check.CheckAmount,VendorHistory.PaidAmt(13)
                SUBTRACT          "1",VendorHistory.PaidTotal(MMF)
                SUBTRACT          "1",VendorHistory.PaidTotal(13)

                MOVE              Check.CheckDate,VendorHistory.LastPayDt
                MOVE              Check.CheckNo,VendorHistory.LastCheck
..HR 9/6/2005                MOVE              Check.CheckAmount,VendorHistory.LastPayAmt
                CALL              UpdVHST
              ENDIF
              RETURN
;=============================================================================
CheckGLAccountKeyPress
              F2SEARCH          EGLAccount(RowSelected),GLMast
              DISPLAY           "Object = ",RowSelected
              RETURN
;=============================================================================
CheckGLTotals
              MOVE              "0",GLTotals
              MOVE              "1",ValidFlag
              FOR               X FROM "1" TO "10" USING "1"
                GETPROP           EGLAmount(X),Value=GLValue
                IF              (GLValue != 0)             //We have a GL Amount...Let's verify the GL Code & Entity
                  GETPROP           EGLAccount(X),Text=TestGLCode
                  CANFIND           EGLAccount(X),GLMast
..HR 2019.3.2                  GETPROP           EGLEntity(X),Text=TestGLEntity
..HR 2019.3.2                  IF                (TestGLEntity != "1" and TestGLEntity != "2" and TestGLEntity != "3")  //HR 9/17/2005 Added NV
..HR 2019.3.2                    PACK              AlertString FROM "Invalid Entity. Please re-enter proper entity before posting this ":
..HR 2019.3.2                                      "transaction"
..HR 2019.3.2                    ALERT             stop,AlertString,result,"Error in Posting"
..HR 2019.3.2                    SETFOCUS          EGLEntity(X)
..HR 2019.3.2                    RETURN
..HR 2019.3.2                  ENDIF
                ENDIF
                CALC              GLTotals = GLTotals + GLValue
              REPEAT
              SETPROP           EGLTotals,Value=GLTotals
              MOVE              "0",ValidFlag
              RETURN
;=============================================================================
UpdateGLTotals
              MOVE              "0",GLTotals
              FOR               X FROM "1" TO "10" USING "1"
                GETPROP           EGLAmount(X),Value=GLValue
                CALC              GLTotals = GLTotals + GLValue
              REPEAT
              SETPROP           EGLTotals,Value=GLTotals
              RETURN
;=============================================================================
UpdateTransactionDates
.              GetMSDate         DTInvoiceDate,InvoiceDate
              getprop                  DTInvoiceDate,text=InvoiceDate

              CALL              ConvDateToDays using InvoiceDate,TodayDays
              ADD               TodayDays,AgingDays,NewAgingDays       //Calculate the new Invoice Due Dates, etc
              ADD               TodayDays,DiscountDays,NewDiscountDays

              CALL              ConvDaysToDate using NewAgingDays,Date8
              setprop           DTDueDate,text=Date8
.              PutMSDate         DTDueDate,Date8
              CALL              ConvDaysToDate using NewDiscountDays,Date8
              setprop           DTDiscDate,text=Date8
..              PutMSDate         DTDiscDate,Date8

                    display            "GL Counter : ",GLCounter
              GETPROP           EAmount,value=GrossAmount
              IF                (GLCounter = 1)                        //HR 7/25/2005
                SETPROP           EGLAmount(1),Value=GrossAmount       //HR 7/25/2005
                CALL              UpdateGLTotals
              ENDIF                                                    //HR 7/25/2005

              GETPROP           ENonDiscAmt,value=NonDiscAmount

              CALC              NetAmount = (GrossAmount - NonDiscAmount) * (DiscountPercent / 100)
              SETPROP           EDiscAmt,value=NetAmount
              RETURN
;=============================================================================
.OnClickAcceptEntries2
.              MOVE      Vendor.AccountNumber to VendorKY
.              CALL      RDVendor

.
. Write out the Accounts Payable information write here along with the AP
. Distribution records.
.
.             GETPROP           EAmount,value=APTRN.OrigAmt
.             CALL              CheckGLTotals

.             IF                (GLTotals != APTRN.OrigAmt)     //Distribution doesn't match Invoice Amt
.               PACK              AlertString FROM "G/L Distribution Amounts do not match the actual Invoice Amount.":
.                                 AlertReturn,"Please check your amounts before continuing"
.               ALERT             note,AlertString,result,"Invalid Totals"
.               RETURN
.             ENDIF
.             RETURN            if (ValidFlag != 0)
.
. Logic added to verify the On hold status
.
.             GETITEM           CBHoldRelease,0,APTRN.HoldFlag
.             IF                (APTRN.HoldFlag = 1)               //HR 4/7/2008
.               ALERT             plain,"Are you sure you wish to put this Invoice on Hold?",result,"Are you sure?"
.               RETURN            if (result != 1)
.             ENDIF

.             IF                (APTRN.OrigAmt = 0)                 //HR 4/7/2008
.               ALERT             note,"There is no Invoice amount that has been entered!",result,"Zero Invoice Amt."
.               RETURN
.             ENDIF

.             MOVE              $Entity,APTRN.Entity
.             MOVE              $Entity,APTRN.Entity
.             GETPROP           EVendor,Text=APTRN.Vendor
.             MOVE              "O",APTRN.ClosedFlag
.             GETITEM           EInvoice,0,APTRN.Invoice
.             GETITEM           CB1099,0,APTRN.Form1099
.             CLOCK             TimeStamp,APTRN.EntryDate
.             GETPROP           EDiscAmt,Value=APTRN.DiscAmt
.             GETPROP           ENonDiscAmt,Value=APTRN.NonDiscAmt
.             GETITEM           EMemo,0,APTRN.Memo
.             GETITEM           EPO,0,APTRN.PO
.             GETITEM           EReceiptNo,0,APTRN.Receipt
.             GETITEM           EVendor,0,APTRN.FromVendor
.             MOVE              "0",APTRN.Release

.             GetMSDate         DTInvoiceDate,APTRN.TransDate

.             GetMSDate         DTDiscDate,APTRN.DiscDate
.             GetMSDate         DTDueDate,APTRN.DueDate
.             GetMSDate         DTReceiptDate,APTRN.ReceiptDate
.             MOVE              "    ",APTRN.ReceiptDate
.             MOVE              ARTRMREC.DiscPerc,APTRN.DiscPct

.             MOVE              APTRN.OrigAmt,APTRN.Balance

.             MOVE              "    ",APTRN.APAccount

.             MOVE              "PAY",SEQKY
.             CALL              RDSeq
.             IF                (ReturnFL = 1)
.               MOVE              "PAY",Sequence.Code
.               MOVE              "1",Sequence.SeqNo
.               CALL              WrtSeq
.             ELSE
.               ADD               "1",Sequence.SeqNo
.               CALL              UpdSeq
.             ENDIF

.             MOVE              Sequence.SeqNo,APTRN.SeqMajor
.             MOVE              Sequence.SeqNo,APTRN.Voucher
.             CALL              WrtAPTRN
.             CALL              WriteAPDetails
.             CALL              WriteVendorHistory2
.             CALL              WriteGLDetails

.             CALL               MainReset
.             RETURN
;=============================================================================
WriteAPDetails
              MOVE              APTRN.Entity,APDetail.Entity
              MOVE              APTRN.SubEntity,APDetail.SubEntity
              MOVE              APTRN.Vendor,APDetail.Vendor
              MOVE              "0",APDetail.TransCode
              MOVE              APTRN.SeqMajor,APDetail.SeqMajor
              MOVE              "1",APDetail.SeqMinor
              MOVE              APTRN.TransDate,APDetail.TransDate
              MOVE              APTRN.EntryDate,APDetail.PostDate

              UNPACK            APTRN.EntryDate,YYYY,MM,DD
              MOVE              YYYY,APDetail.Year
              MOVE              MM,APDetail.Month
              MOVE              APTRN.Invoice,APDetail.ReferenceNo
              MOVE              "    ",APDetail.APAccount
              MOVE              APTRN.OrigAmt,APDetail.Amount
              CALL              WrtAPDET
              RETURN
;=============================================================================
WriteVendorHistory2
              UNPACK            APTRN.EntryDate,CC,YY,MM,DD
              MOVE              MM,MMF

              PACKKEY           VHSTKY FROM APTRN.Entity,APTRN.Vendor,CC,YY
              CALL              RDVHST                                //Read the Vendor History record
              IF                (ReturnFL = 1)                        //Vendor History record not found, add it!!!
                CLEAR             VendorHistory
                MOVE              APTRN.Entity,VendorHistory.Entity
                MOVE              APTRN.Vendor,VendorHistory.Vendor
                PACKKEY           VendorHistory.Year FROM CC,YY
                MOVE              APTRN.OrigAmt,VendorHistory.PurchAmt(MMF)
                MOVE              APTRN.OrigAmt,VendorHistory.PurchAmt(13)
                MOVE              APTRN.Invoice,VendorHistory.LastInvoice
                MOVE              APTRN.TransDate,VendorHistory.LastInvDate
                ADD               "1",VendorHistory.PurchTotal(MMF)
                ADD               "1",VendorHistory.PurchTotal(13)
                CALL              WrtVHST
              ELSE
                ADD               APTRN.OrigAmt,VendorHistory.PurchAmt(MMF)
                ADD               APTRN.OrigAmt,VendorHistory.PurchAmt(13)
                MOVE              APTRN.Invoice,VendorHistory.LastInvoice
                MOVE              APTRN.TransDate,VendorHistory.LastInvDate
                ADD               "1",VendorHistory.PurchTotal(MMF)
                ADD               "1",VendorHistory.PurchTotal(13)
                CALL              UpdVHST
              ENDIF
              RETURN
;=============================================================================
WriteGLDetails
;
; Write the Accounts Payable Transaction First
;
                MOVE              APTRN.Entity,APDist.Entity
                MOVE              APTRN.SubEntity,APDist.SubEntity
                MOVE              APTRN.Vendor,APDist.Vendor
                MOVE              APTRN.EntryDate,APDist.TransDate
                MOVE              APTRN.SeqMajor,APDist.SeqMajor
                MOVE              APTRN.Voucher,APDist.Voucher
                move              Default.APAcct,APDist.GLCode                  //Default A/P GL Code
                UNPACK            APDist.TransDate into APDist.Year,APDist.Month

                MOVE              "0",APDist.PostedToGL
                MOVE              "1",APDist.TransCode                 //AP Invoice
                MOVE              "0",APDist.CheckNo
                move              "1",APDist.SeqMinor

                IF                (APTRN.OrigAmt > 0)                  //Credit Transaction
                  move              APTRN.OrigAmt,APDist.CreditAmount
                  MOVE              "0",APDist.DebitAmount
                ELSE                                                   //Debit Transaction
                  multiply          "-1",APTRN.OrigAmt,APDist.DebitAmount
                  MOVE              "0",APDist.CreditAmount
                ENDIF
                call                   WRTAPDist


..              MOVE              "0",APDist.SeqMinor
              FOR               X FROM "1" TO "10" USING "1"
                GETPROP           EGLAmount(X),Value=GLValue
                CONTINUE          IF (GLValue = 0)

                MOVE              APTRN.Entity,APDist.Entity
                MOVE              APTRN.SubEntity,APDist.SubEntity
                MOVE              APTRN.Vendor,APDist.Vendor
..HR 10/7/2005  STUPID!!!!                MOVE              APTRN.TransDate,APDist.TransDate
                MOVE              APTRN.EntryDate,APDist.TransDate         //HR 10/7/2005
                MOVE              APTRN.SeqMajor,APDist.SeqMajor
                MOVE              APTRN.Voucher,APDist.Voucher
                MOVE              "0",APDist.PostedToGL
                MOVE              "1",APDist.TransCode                 //AP Invoice
                MOVE              "0",APDist.CheckNo
                UNPACK            APDist.TransDate,CC,YY,MM,DD
                MOVE              MM,APDist.Month
                PACKKEY           APDist.Year FROM CC,YY
                GETITEM           EGLAccount(X),0,APDist.GLCode
..HR 2019.3.2                GETITEM           EGLEntity(X),0,APDist.SubEntity

                IF                (GLValue < 0)                        //Credit Transaction
                  MOVE              GLValue,APDist.CreditAmount
                  MOVE              "0",APDist.DebitAmount
                ELSE                                                   //Debit Transaction
                  MOVE              GLValue,APDist.DebitAmount
                  MOVE              "0",APDist.CreditAmount
                ENDIF
              ADD               "1",APDist.SeqMinor                    //HR 7/11/2005
              CALL              WrtAPDist
              REPEAT
              RETURN
;=============================================================================
CreateManualCheck
;
;          Write APTRN record with Invoice Information including Balance which will probably be Zero
;          Write APDET record for Invoice
;          Write APDIST record
; Write AP Distribution Record
; Write Vendor History Record
;
.
. Write out the Accounts Payable information write here along with the AP
. Distribution records.
.
              CALL              UpdateCheckDetails
              RETURN
;=============================================================================
WriteAPInvoiceDetails
              MOVE              APTRN.Entity,APDetail.Entity
              MOVE              APTRN.SubEntity,APDetail.SubEntity
              MOVE              APTRN.Vendor,APDetail.Vendor
              MOVE              "0",APDetail.TransCode
              MOVE              APTRN.SeqMajor,APDetail.SeqMajor
              MOVE              "1",APDetail.SeqMinor
              MOVE              APTRN.TransDate,APDetail.TransDate
              MOVE              APTRN.EntryDate,APDetail.PostDate

              UNPACK            APTRN.EntryDate,YYYY,MM,DD
              MOVE              YYYY,APDetail.Year
              MOVE              MM,APDetail.Month
              MOVE              APTRN.Invoice,APDetail.ReferenceNo
              MOVE              "    ",APDetail.APAccount
              MOVE              APTRN.OrigAmt,APDetail.Amount
              CALL              WrtAPDET
              RETURN
;=============================================================================
WriteVendorInvoiceHistory
              UNPACK            APTRN.EntryDate,CC,YY,MM,DD
              MOVE              MM,MMF

              PACKKEY           VHSTKY FROM APTRN.Entity,APTRN.Vendor,CC,YY
              CALL              RDVHST                                //Read the Vendor History record
              IF                (ReturnFL = 1)                        //Vendor History record not found, add it!!!
                CLEAR             VendorHistory
                MOVE              APTRN.Entity,VendorHistory.Entity
                MOVE              APTRN.Vendor,VendorHistory.Vendor
                PACKKEY           VendorHistory.Year FROM CC,YY
                MOVE              APTRN.OrigAmt,VendorHistory.PurchAmt(MMF)
                MOVE              APTRN.OrigAmt,VendorHistory.PurchAmt(13)
                MOVE              APTRN.Invoice,VendorHistory.LastInvoice
                MOVE              APTRN.TransDate,VendorHistory.LastInvDate
                ADD               "1",VendorHistory.PurchTotal(MMF)
                ADD               "1",VendorHistory.PurchTotal(13)
                CALL              WrtVHST
              ELSE
                ADD               APTRN.OrigAmt,VendorHistory.PurchAmt(MMF)
                ADD               APTRN.OrigAmt,VendorHistory.PurchAmt(13)
                MOVE              APTRN.Invoice,VendorHistory.LastInvoice
                MOVE              APTRN.TransDate,VendorHistory.LastInvDate
                ADD               "1",VendorHistory.PurchTotal(MMF)
                ADD               "1",VendorHistory.PurchTotal(13)
                CALL              UpdVHST
              ENDIF
              RETURN
;=============================================================================
OnClickAAddManualInvoice
              DEBUG
              CLOCK             TimeStamp,Date8
              setprop           DTInvoiceDate,text=Date8
              setprop           DTDueDate,text=Date8
              setprop           DTDiscDate,text=Date8

.              PutMSDate         DTInvoiceDate,Date8
.              PutMSDate         DTDueDate,Date8
.              PutMSDate         DTDiscDate,Date8

              CALL              LoadGLDetails

              CLEAR             CancelFlag2

              SETPROP           WMain2,visible=1
              CALL              ResetInvoices
              RETURN
;==========================================================================================================
LoadGLDetails
              MOVE              "0",GLCounter                        //HR 7/25/2005
              MOVE              Vendor.AccountNumber,VendorGLKY
              CALL              RDVendorGL
              LOOP
                CALL              KSVendorGL
              UNTIL             (ReturnFL = 1 or Vendor.AccountNumber != VendorGL.AccountNumber)
                SETITEM           EGLAccount(VendorGL.Line),0,VendorGL.GLCode
                SETITEM           EGLEntity(VendorGL.Line),0,VendorGL.SubEntity
                ADD               "1",GLCounter
              REPEAT
              RETURN
;==============================================================================

;=============================================================================
OnClickAcceptInvoice
              setprop                  BAccept2,enabled=0
              CLEAR             CancelFlag2

...HR              MOVE              Vendor.AccountNumber to VendorKY
...HR              CALL              RDVendor
.
. Write out the Accounts Payable information write here along with the AP
. Distribution records.
.
              GETPROP           EAmount,value=APTRN.OrigAmt
              CALL              CheckGLTotals

              IF                (GLTotals != APTRN.OrigAmt)     //Distribution doesn't match Invoice Amt
                PACK              AlertString FROM "G/L Distribution Amounts do not match the actual Invoice Amount.":
                                  AlertReturn,"Please check your amounts before continuing"
                ALERT             note,AlertString,result,"Invalid Totals"
                SET               CancelFlag2
                setprop                  BAccept2,enabled=1

                RETURN
              ENDIF
.
. Logic added to verify the On hold status
.
              IF                (APTRN.OrigAmt = 0)                 //HR 4/7/2008
                ALERT             note,"There is no Invoice amount that has been entered!",result,"Zero Invoice Amt."
                SET               CancelFlag2
                setprop                  BAccept2,enabled=0
                RETURN
              ENDIF

              MOVE              $Entity,APTRN.Entity
              MOVE              $Entity,APTRN.Entity
              GETPROP           EVendor,Text=APTRN.Vendor
              MOVE              "O",APTRN.ClosedFlag
              GETITEM           EInvoice,0,APTRN.Invoice
              GETITEM           CB1099,0,APTRN.Form1099
              CLOCK             TimeStamp,APTRN.EntryDate
              GETPROP           EDiscAmt,Value=APTRN.DiscAmt
              GETPROP           ENonDiscAmt,Value=APTRN.NonDiscAmt
              GETITEM           EMemo,0,APTRN.Memo
              GETITEM           EPO,0,APTRN.PO
              GETITEM           EReceiptNo,0,APTRN.Receipt
              GETITEM           EVendor,0,APTRN.FromVendor
              MOVE              "0",APTRN.Release

.              GetMSDate         DTInvoiceDate,APTRN.TransDate
              getprop                  DTInvoiceDate,text=APTRN.TransDate

..              GetMSDate         DTDiscDate,APTRN.DiscDate
..              GetMSDate         DTDueDate,APTRN.DueDate
..              GetMSDate         DTReceiptDate,APTRN.ReceiptDate
              getprop                  DTDiscDate,text=APTRN.DiscDate
              getprop                  DTDueDate,text=APTRN.DueDate
              getprop                  DTReceiptDate,text=APTRN.ReceiptDate

              MOVE              "    ",APTRN.ReceiptDate
              MOVE              ARTRM.DiscPerc,APTRN.DiscPct

              MOVE              APTRN.OrigAmt,APTRN.Balance

              MOVE              "    ",APTRN.APAccount

              GetNextSeq        APTRN


              MOVE              Sequence.SeqNo,APTRN.SeqMajor
              MOVE              Sequence.SeqNo,APTRN.Voucher
              CALL              WrtAPTRN
              CALL              WriteAPDetails
              CALL              WriteVendorHistory2
              CALL              WriteGLDetails
              CALL              InsertManualEntry
              CALL              ResetInvoices
              setprop           BAccept2,enabled=1
              RETURN
;=============================================================================
ResetInvoices
              SETITEM           EditColl2,0,""
              SETPROP           NewColl2,BGCOLOR=$Window
              SETPROP           NewColl2,ReadOnly=0
              SETPROP           DTInvoiceDate,Enabled=1
              SETPROP           DTDueDate,Enabled=1
              SETPROP           DTDiscDate,Enabled=1
              RETURN
;=============================================================================
InsertManualEntry
              MOVE              APTRN.SeqMajor,SeqMajorD
              UNPACK            APTRN.DiscDate into CC,YY,MM,DD
              PACKKEY           DiscountDate FROM MM,slash,DD,slash,YY

              UNPACK            APTRN.DueDate into CC,YY,MM,DD
              PACKKEY           DueDate FROM MM,slash,DD,slash,YY

              MOVE              APTRN.Balance,GrossAmountD
              MOVE              APTRN.DiscAmt,DiscAmountD
              CALC              NetAmount = APTRN.Balance - APTRN.DiscAmt
              MOVE              NetAmount,NetAmountD
              LVDetails.InsertItemEx giving Row using *Text="":
                                                      *SubItem1=SeqMajorD:
                                                      *SubItem2=APTRN.Invoice:
                                                      *SubItem3=DueDate:
                                                      *SubItem4=DiscountDate:
                                                      *SubItem5=GrossAmountD:
                                                      *SubItem6=DiscAmountD:
                                                      *SubItem7=NetAmountD

              IF                (ReturnFl = 0)
                LVDetails.SetItemCheck using *Index=Row,*Value=1
              ENDIF
              CALL              CalculateCheckDetails
              RETURN
;==========================================================================================================
.Help Menu selection if required
.
MAINHELP
          RETURN
;==========================================================================================================
SAVEMODE
.
. OK...The 'Save' has been selected from the Menu rather than from the Save Button.
. What to do, What to do??  Is this a Save to a 'NEW' record or is it a Save to a
. 'CHANGED' record....
. Let's check the 'Status' flag...1 is a Change record, 2 is a New Record
.
           RETURN
;=============================================================================
UpdateCheckDetails
.
. OK, all of the Check information has printed OK!!!!  Yipee!! (Did we think that it wouldn't???)
. Now, let's update the APTRN, APDET, Check, CheckDetails, VendorHistory files with the
. appropriate information
.
              MOVE              $Entity,Check.Entity
              MOVE              APTRN.SubEntity,Check.SubEntity
              MOVE              APTRN.Vendor,Check.Vendor
              MOVE              BankREC.Code,Check.BankCode
              GETPROP           NCheckNumber,value=Check.CheckNo
              getprop           DTCheckDate,text=Check.CheckDate
              GETPROP           NCheckAmount,value=Check.CheckAmount
              GETITEM           EMemo,0,CheckRun.Memo

              MOVE              "M",Check.CheckFlag
              MOVE              "1",Check.Printed
              MOVE              "0",Check.VoidedFlag                 //0, DUH...We just printed the check!!
              MOVE              "        ",Check.VoidedDate
              CLOCK             TimeStamp,Check.TransDate
              UNPACK            Check.TransDate,YYYY,MM,DD
              MOVE              YYYY,Check.Year
              MOVE              MM,Check.Month
              CALL              CalculateManualCheckDetails

              MOVE              CheckDiscAmount,Check.DiscAmt
              MOVE              CheckGrossAmount,Check.GrossAmount

              GetNextSeq        CHK

              MOVE              Sequence.SeqNo,Check.SeqMajor
              CALL              WrtCheck
              MOVE              "0",CheckDetail.SeqMinor         //We're going to start with 1 as the main Sequence

              CALL              WriteVendorHistory3
;
; Now create the Check Details from the APTRN records
;
              MOVE              "-1",Row
              LOOP
                ADD             "1",Row
                LVDetails.FindItemCheck giving Row using *Start=Row
              UNTIL             (Row = -1)
                LVDetails.GetItemText giving SeqMajorD using *Index=Row,*SubItem=1

                MOVE              SeqMajorD,SeqMajor
                PACKKEY           APTRNKY2 FROM $Entity,SeqMajor
                CALL              RDAPTRN2
                IF                (ReturnFL = 1)
                  ALERT           stop,"Unable to locate specific A/P Transaction line",result,"Error in reading A/P Transaction"
                  CLEAR           APTRN
                  CONTINUE                             //HR 3/29/2005
                ENDIF

                CLEAR             GrossAmountD
                CLEAR             GrossAmount
                LVDetails.GetItemText giving GrossAmountD using *Index=Row,*SubItem=5
                SQUEEZE           GrossAmountD,GrossAmountD
                MOVE              GrossAmountD,GrossAmount

                CLEAR             DiscAmountD
                CLEAR             DiscAmount
                LVDetails.GetItemText giving DiscAmountD using *Index=Row,*SubItem=6
                SQUEEZE           DiscAmountD,DiscAmountD
                MOVE              DiscAmountD,DiscAmount

                CLEAR             NetAmountD
                CLEAR             NetAmount
                LVDetails.GetItemText giving NetAmountD using *Index=Row,*SubItem=7
                SQUEEZE           NetAmountD,NetAmountD
                MOVE              NetAmountD,NetAmount
;
; OK, we have our A/P Transaction, now what???
;
                CALC              APTRN.Balance = APTRN.Balance - GrossAmount  //We write out the Disc & Net information later
;
; Fixup Bug where system would automatically 'C'lose the Invoice, regardless of whether or not it had a Zero balance
;
                IF                (APTRN.Balance = 0)           //HR 3/16/2006
                  MOVE              "C",APTRN.ClosedFlag        //HR 3/16/2006  Moved to inside IF...ENDIF
                ENDIF                                           //HR 3/16/2006
                CALL              UpdAPTRN
;
; One file down, what's next??? Oh yes, the APDetail Transactions!!
; Get the last SeqMinor record for writing out future records.
;
                PACKKEY           APDetKY,$Entity,APTRN.SeqMajor,"999"
                CALL              RDAPDet
                CALL              KPAPDet

                IF                (ReturnFL = 0 and APDetail.SeqMajor = APTrn.SeqMajor)
                  MOVE              APDetail.SeqMinor,SeqMinor
                  ADD               "1",SeqMinor
                ELSE
                  MOVE              "1",SeqMinor
                ENDIF

                CLEAR             APDetail               //Start fresh, JUST in case!!!

                MOVE              APTRN.Entity,APDetail.Entity
                MOVE              APTRN.SubEntity,APDetail.SubEntity
                MOVE              APTRN.SeqMajor,APDetail.SeqMajor

                MOVE              SeqMinor,APDetail.SeqMinor
                CLOCK             TimeStamp,APDetail.PostDate
                MOVE              Check.CheckDate,APDetail.TransDate
                MOVE              APTRN.Vendor,APDetail.Vendor
                UNPACK            APDetail.PostDate,YYYY,MM,DD
                MOVE              YYYY,APDetail.Year
                MOVE              MM,APDetail.Month

                MOVE              "7",APDetail.TransCode             //Check Printed Trans Code...could be automatic check

                MOVE              Check.CheckNo,APDetail.ReferenceNo
                MOVE              Check.Memo,ApDetail.Memo
                MOVE              "    ",APDetail.APAccount

                MOVE              NetAmount,APDetail.Amount          //Use the 'Net Amount'
                CALL              WrtAPDet                           //Write out the 'Net Amount'
.
. Now write out any Discount Amount information if available!!
.
                IF                (CheckRun.DiscAmt != 0)
                  ADD               "1",APDetail.SeqMinor
                  MOVE              DiscAmount,APDetail.Amount
                  MOVE              "6",APDetail.TransCode
                  CALL              WrtAPDet
                ENDIF
.
. OK, we've created the appropriate A/P Detail transactions, now what???
. Ah yes, the Check Details too!!!
.
                MOVE              Check.Entity,CheckDetail.Entity
                MOVE              Check.SubEntity,CheckDetail.SubEntity
                MOVE              Check.BankCode,CheckDetail.BankCode
                MOVE              APTRN.Voucher,CheckDetail.Voucher
                MOVE              Check.Vendor,CheckDetail.Vendor
                MOVE              Check.CheckNo,CheckDetail.CheckNo
                MOVE              Check.SeqMajor,CheckDetail.SeqMajor
                MOVE              DiscAmount,CheckDetail.DiscAmt
                MOVE              GrossAmount,CheckDetail.GrossAmount
                MOVE              NetAmount,CheckDetail.NetAmount
                ADD               "1",CheckDetail.SeqMinor
                CALL              WrtCheckDetail                 //OK, let's write out this Check Detail Transaction

              REPEAT
              RETURN
.
. OK, we're just Kickin' A** and taking numbers here...We're written out
. the Main Check information, the Check Details, the AP Details...What's next???
. Absolutely Nothing, say it again!!!!
. OK, Voila!!!
. We've written out to the Vendor History, Check History and now we've
. updated the AP Detail and Check Run Detail information, there's nothing
. left to do.....EXCEPT....Delete the
. CheckRun and CheckRun Detail information
.
.
. OK, we've been done with the Check Run master file, now what???
. Let's delete this record and all of the CheckRun Details!!!!
;=============================================================================
WriteVendorHistory3
              UNPACK            Check.TransDate,CC,YY,MM,DD
              MOVE              MM,MMF

              PACKKEY           VHSTKY FROM Check.Entity,Check.Vendor,CC,YY
              CALL              RDVHST                                //Read the Vendor History record
              IF                (ReturnFL = 1)                        //Vendor History record not found, add it!!!
                CLEAR             VendorHistory
                MOVE              Check.Entity,VendorHistory.Entity
                MOVE              Check.Vendor,VendorHistory.Vendor
                PACKKEY           VendorHistory.Year FROM CC,YY
                MOVE              Check.DiscAmt,VendorHistory.DiscAmt(MMF)
                MOVE              Check.DiscAmt,VendorHistory.DiscAmt(13)
                MOVE              Check.CheckAmount,VendorHistory.PaidAmt(MMF)
                MOVE              Check.CheckAmount,VendorHistory.PaidAmt(13)
                MOVE              "1",VendorHistory.PaidTotal(MMF)
                MOVE              "1",VendorHistory.PaidTotal(13)

                MOVE              Check.CheckDate,VendorHistory.LastPayDt
                MOVE              Check.CheckNo,VendorHistory.LastCheck
                MOVE              Check.CheckAmount,VendorHistory.LastPayAmt
                CALL              WrtVHST
              ELSE
                ADD               Check.DiscAmt,VendorHistory.DiscAmt(MMF)
                ADD               Check.DiscAmt,VendorHistory.DiscAmt(13)
                ADD               Check.CheckAmount,VendorHistory.PaidAmt(MMF)
                ADD               Check.CheckAmount,VendorHistory.PaidAmt(13)
                ADD               "1",VendorHistory.PaidTotal(MMF)
                ADD               "1",VendorHistory.PaidTotal(13)

                MOVE              Check.CheckDate,VendorHistory.LastPayDt
                MOVE              Check.CheckNo,VendorHistory.LastCheck
                MOVE              Check.CheckAmount,VendorHistory.LastPayAmt
                CALL              UpdVHST
              ENDIF
              RETURN
;=============================================================================
CalculateManualCheckDetails
              MOVE              "0",CheckDiscAmount
              MOVE              "0",CheckGrossAmount

              LVDetails.GetItemCount giving RowClicked
              FOR                X FROM "0" TO (RowClicked - 1) USING "1"
                LVDetails.GetItemCheck giving Clicked using *Index=X
                IF                (Clicked = 1)             //Row Selected
                  CLEAR             GrossAmountD
                  CLEAR             GrossAmount
                  LVDetails.GetItemText giving GrossAmountD using *Index=Row,*SubItem=5
                  SQUEEZE           GrossAmountD,GrossAmountD
                  MOVE              GrossAmountD,GrossAmount

                  CLEAR             DiscAmountD
                  CLEAR             DiscAmount
                  LVDetails.GetItemText giving DiscAmountD using *Index=Row,*SubItem=6
                  SQUEEZE           DiscAmountD,DiscAmountD
                  MOVE              DiscAmountD,DiscAmount

                  ADD               GrossAmount,CheckGrossAmount
                  ADD               DiscAmount,CheckDiscAmount
                ENDIF
              REPEAT
              RETURN
;=============================================================================
                    include            MenuDefs.INC

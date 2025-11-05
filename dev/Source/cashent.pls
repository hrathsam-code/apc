;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    4 NORFOLK LANE                                           ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    CASHENT.PLS                                                    ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    02/15/2002 AT 3:02PM                                           ;
;                                                                             ;
;  PURPOSE:    Enter/Record Cash Entry desposits against Invoices             ;
;                                                                             ;
; REVISION:    VER     DATE     INIT       DETAILS                            ;
;                                                                             ;
;              1.0   06/03/2005   HOR     INITIAL VERSION                     ;
;                                                                             ;
; Modified 8/29/2003 to resolve misc. data from Previous A/R Trans. Record    ;
;                                                                             ;
;Modfied 9/3/2003 to use the GroupTo when F2 Search is being used HR          ;
;                                                                             ;
; Modified 4/14/2004.  Allan found problem where creation of Unapplied AFTER  ;
; an entry was made that had a discount amount.  The Discount Amount field    ;
; was not cleared on the A/R Detail line.  It's cleared up for now.           ;
;                                                                             ;
; Modified program 12/22/2004 to check for proper 5 digit Invoice Number      ;
;                                                                             ;
; Modified program 2/1/2005                                                   ;
;                                                                             ;
; HR 6/3/2005 Modified to handle Invoice #'s lower AND greater than 100,000   ;
;=============================================================================;
.

                    include            NCommon.TXT
                    INCLUDE            WORKVAR.INC

                    include            Sequence.FD
.                    INCLUDE            statetbl.txt      //HR 1/13/2004

                    INCLUDE            Cust.FD

SysDate             DIM                8
#RESULT             FORM               1
NodeNum             FORM               6

AgingDays     FORM              3             //HR 1/8/2004
DiscountDays  FORM              3             //HR 1/8/2004
DiscountPercent FORM            2.2           //HR 1/8/2004


..HR 2019.7.25 TodayDays           form               10
ChildNum            FORM               6
AlertMsg            DIM                125
InvoiceF            FORM               5     //Temp code until complete conversion
SeqNumD             DIM                7
SeqNum              FORM               7
..HR 2018.10.2  DATALINE            DIM                255
int2                FORM               4
ListCount           FORM               6
CustomerIDSave      like               Cust.CustomerID
CustomerChk         DIM                6
Invoice5            FORM               5
CustBalance         FORM               10.2
CustBalanceD        DIM                13
CheckAmount         form               9.2
X                   FORM               6
BalanceAmt          FORM               7.2
SeqMajorD           DIM                7
SeqMinor            FORM               3
Row                 FORM               6
TotalRows           FORM               6
Column              FORM               2
Clicked             FORM               1
Amount              FORM               7.2
InvoiceTotals       FORM               7.2
DiscountTotals      FORM               7.2
LineDiscount        FORM               7.2
LineVoucher         FORM               7.2
LineWriteOff        FORM               7.2
CustomerReOpened    DIM                6
SEQMAJOR            FORM               7
RES2                FORM               2
InvoiceTotalsD      DIM                11
DiscountTotalsD     DIM                11
WriteOffTotals      FORM               7.2
WriteOffTotalD      DIM                11
LineCount           FORM               7
TestAmount          FORM               9.2
TestAmountD         DIM                12
PaymentAmt          FORM               7.2
PaymentAmtD         DIM                10
UnAppliedAmtD       DIM                10
UnAppliedAmt        FORM               7.2

Memo                DIM                80    //HR 1/16/2005  Changed from 20 to 40
OldInvoiceNumber    FORM               5
OldInvoiceNumber10  FORM               10
OldInvoiceNumberD   DIM                5
Reference           DIM                20
NonARAmount         FORM               7.2
NonARAmountD        DIM                10
FromCustomer        like               Cust.CustomerID
WrkAmount           dim                13
ShipToCounter       form               4

ReasonCode          dim                4
TransSubCode        form               1

Check               form               4
PaymentAmount       form               9.2


;==========================================================================================================
AR_SeqNum           form               7(999)
AR_Memo             dim                80(999)
AR_DiscAmt          form               7.2(999)
AR_WriteOffAmt      form               7.2(999)
AR_Amount           form               7.2(999)
AR_ReasonCode       dim                8(999)

AR_Counter          form               4
DepositID           dim                14
PaymentReference    dim                10
;==========================================================================================================



NetAmount           FORM               7.2
AmtToPay            FORM               7.2
AmtToDisc           FORM               7.2
AmtToWriteOff       FORM               7.2
NetToReceive        FORM               7.2
WriteOffAmt         FORM               7.2
DATE81              DIM                8
CBValue             FORM               1
PaymentDesc         DIM                22
IOSW                DIM                1       I/O INDICATOR
DIM13               DIM                13
FreightTemp         FORM               5.2
#RES1               FORM               1
#DIM1               DIM                1
#DIM2               DIM                2
#RES2               FORM               2
#LEN1               FORM               3
#MenuObj            Automation
FILL4               INIT               "    "
#MenuItem           DIM                25
#MenuResult         form               6
Date82              dim                10
date83              dim                10
addflag             dim                1
TimeStapVar         DIM                12
Harrytext           DIM                40
RES1                FORM               3
SearchMethod        FORM               1
InvoiceKey          DIM                10
InvoiceKeyF         FORM               10
UseStamps           DIM                10                 //HR 11/22/2004  FORM              "0"

WrkDim3             DIM                3

                    GOTO               STARTPGM

                    INCLUDE            CustD.FD             //Customer Dynamic File
                    INCLUDE            CHST.FD
                    INCLUDE            CNTRY.FD
                    INCLUDE            STATE.FD
                    include            BatchChecks.FD
                    INCLUDE            ARTRN.FD
                    INCLUDE            ARDET.FD
                    INCLUDE            PYMNT.FD
                    INCLUDE            REASON.FD
                    INCLUDE            ARDEP.FD
...                    INCLUDE            ARSEQ.FD
                    include            ARDist.FD
                    include            Default.FD

InputCustomer       like               Cust.CustomerID

.......                   INCLUDE           SOHDRFD.TXT            //HR 07/07/2003


.......                   INCLUDE           INVCPOFD.TXT
.
WindowsCOl          COLLECTION
SelectColl          COLLECTION

MAIN                PLFORM             CashEnt.PLF
Cash2               PLFORM             CashEnt2.PLF
Cash3               PLFORM             CashEnt3.PLF
Cash4               PLFORM             CashEnt4.PLF
Cash5               PLFORM             CashEnt5.PLF
Cash6               PLFORM             CashEnt6.PLF
FStamps             PLFORM             StampST.PLF

About               PLFORM             About.PLF


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
                      "F1 - Help with Cash Entry;":
                      "-;":
                      "&About Chiron Software"
.
STARTPGM            ROUTINE            InputCustomer

                    INCLUDE            SECURITY.INC
                    MOVE               "1",ProgLoaded
.
. If we're unable to find the Help file, then we're going to simply just not make
. the F1 Function key available to the Users
.
           MOVE              "AppDir;HELPDIR",EnvData
           CLOCK             INI,EnvData
           IF                NOT OVER
             PACK              EnvData,EnvData,"\SUPERIOR.hlp"
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
                    CLOCK              TimeStamp,SysDate
                    CALL               OPENCust
                    CALL               OPENARDET
                    CALL               OpenARTRN
                    call               OpenBatchChecks
                    CALL               OPENCNTRY
                    CALL               OpenCHST
                    CALL               OpenCustD

                    CALL               OpenARDep
                    CALL               OpenPYMNT
                    CALL               OpenReason
                    call               OpenARDist
                    call               OpenDefault
                    call               OpenSequence
.
ChckColl            COLLECTION
ChckEdt             COLLECTION
ChckBoxes           COLLECTION
ChckStat            COLLECTION

                    LISTINS           ChckStat,STChckCountry
.
           LISTINS           ChckCOLL,EChckCode,EChckName,EChckAddr1,EChckAddr2,EChckAddr3:
                                     EChckCity,EChckSt,EChckCountry,EChckZip
.
           LISTINS           ChckEDT,EChckCode,EChckName,EChckAddr1,EChckAddr2,EChckAddr3:
                                     EChckCity,EChckSt,EChckCountry,EChckzip

           LISTINS           SelectColl,BSelectAll,BUnSelectAll
.
...           WINHIDE                         //HR 3/2/2005

                    FORMLOAD           Cash5
                    FORMLOAD           MAIN
                    FORMLOAD           FStamps
                    FORMLOAD           Cash3,WMain

                    MOVE               "11",SortHeader             //HR 4.20.2016

                    MOVE               "3",SortHeader(0)
                    MOVE               "3",SortHeader(2)
                    MOVE               "3",SortHeader(5)
                    MOVE               "3",SortHeader(6)
                    MOVE               "3",SortHeader(10)
                    MOVE               "3",SortHeader(11)

                    MOVE               "5",SortHeader(3)
                    MOVE               "5",SortHeader(4)

..Not Required                    OPEN               ARSEQFL,"ARSEQFL"

...FUCKUP                    MOVE               "CHIRON",$Entity              ...Temporary

                    squeeze            InputCustomer,InputCustomer

                    if                 (InputCustomer != "")            //We've got a Customer that we're inputting
                      call               MainReset
                      setprop            EChckCode,text=InputCustomer
                      clock              TimeStamp,Date8
                      setprop            EDepositID,text=Date8
                      CBSearchBy.SetCurSel using *Index=0
                      call               MainValid
                    endif

                      move               "11000",Default.ARAcct
                    clock              TimeStamp,Date8
                    setprop            EDepositID,text=Date8

                    LOOP
                      WAITEVENT
                    REPEAT
.
. We never get here!!   Just in case though.... :-)
.
                    RETURN

.INITSRCH
.           PACK              SearchTitle,CustTitle," Search Window"
.           SETPROP           LVSearch,*TitleText=SearchTitle
.
.           CTADDCOL          "Customer ID",75,"Customer Name",125:
.                             "Address",100:
.                             "City",100:
.                             "State",40:
.                             "Zip",60:
.                             "Country",50
.
.           CTLoadTable       Cust,CustomerID,Name,Addr1,City,St,Zip,Country
.           RETURN
.                                                                   *
. Routines that operate the Main program
.

..HR 2018.7.26              INCLUDE           INVCPOIO.TXT
..HR 2018.7.26              INCLUDE           STDIOERR.TXT

NOFILE
           NORETURN
           ALERT             PLAIN,"Check Transactional file does not exist. Do you wish to create it?",#RESULT
           IF                (#RESULT = 1)
.             CALL              PREPCust
             GOTO              OPENFILES
           ENDIF
              return

.              STOP
.=============================================================================
MaintMenuOption
..HR 4.22.2016           EVENTINFO         0,ARG1=#MenuObj           -9 -0+.

           EVENTINFO         0,result=#MenuResult
.
           SELECT            USING #MenuResult
           WHEN              99
             CALL              MainClose
             RETURN
           WHEN              25
             CALL              MainReset
             RETURN
.           WHEN              "ID_Change"
.             CALL              OnClickAcceptChanges
.             RETURN
.           WHEN              "ID_Delete"
.             CALL              MainDelete
.             RETURN
.           WHEN              "ID_Find"
.             CALL              MainFind
.             RETURN
.           WHEN              "ID_First"
.             CALL              MainFirst
.             RETURN
.           WHEN              "ID_Last"
.             CALL              MainLast
.             RETURN
.           WHEN              "ID_Next"
.             CALL              MainNext
.             RETURN
.           WHEN              "ID_Previous"
.             CALL              MainPrevious
.             RETURN
           WHEN              14
             CALL              MainAbout
             RETURN
.           WHEN              "ID_Save"
.             CALL              OnClickAcceptChanges
.             RETURN
           WHEN              20
             CALL              MainUndo
             RETURN
           WHEN              99
             CALL              MainToolbar
             RETURN
           WHEN              65
             CALL              PrintStatement
             RETURN
           WHEN              60
             CALL              RePrintInvoices
             RETURN
           WHEN              69
             CALL              ViewComments
             RETURN
           WHEN              2
             CALL              PrintScreen using WMain
             RETURN
           DEFAULT
           ENDSELECT
           RETURN

MainValid
                    CALL               GetSelectionMethod

..HR 2018.7.27              IF                (SearchMethod = 1 or SearchMethod = 2)
                    if                 (SearchMethod = 0)
                      getprop            EChckCode,text=CustKY
                      call               RDCust
                      if                 (ReturnFl = 1)
                        beep
                        alert              note,"Customer does not exist",result,"ERROR: Invalid Customer"
                        EChckCode.Clear
                        return
                      endif

                      CALL              SetMain
                      MOVE              "3",Status
                      setprop           EChckCODE,enabled=0
                      setprop           Fill1,enabled=0
                      setprop           BAccept,enabled=1
                      RETURN
                    endif
.
. Added Logic on 12/23/2003
. HR
              IF                (SearchMethod = 1)         //By Invoice Number
                RESETVAR          InvoiceKey
                getprop           EChckCODE,text=InvoiceKey
.
. HR 12/22/2004 Modified due to problem properly reading Invoice Key
.
.                MOVE              InvoiceKey,InvoiceKeyF                //HR 5/16/2005
.                MOVE              InvoiceKeyF,InvoiceKey                //HR 5/16/2005

                PACKKEY           ARTRNKY5 FROM $Entity,"I",InvoiceKey,"999999"
                CALL              RDARTRN5

                CALL              KPARTRN5
                IF                (ReturnFl = 1 or ARTrn.Reference != InvoiceKey)
                  BEEP
                  ALERT           note,"Invoice Number does not exist",result
                  RETURN
                ENDIF
..HR 2018.07.25                SETITEM           RCustomer,0,1                //Set Button 'like' it's a customer
                setprop           EChckCODE,text=ARTrn.CustomerID
                CALL              GetSelectionMethod
                CLEAREVENTS
              ENDIF

           GETCOUNT          EChckCODE
           IF                (CharCount > 0)
             RESETVAR          CustKY
             getprop           EChckCODE,text=CustKY
.             MOVE              CustKY,CustomerIDF
.             MOVE              CustomerIDF,CustKY
..HR 2018.8.1              JustifyCust       CustKY

.             GETITEM            ECHckCode,0,CustNumD
.             MOVE               CustNumD,CustNumF
.             MOVE               CustNumF,CustNumD
.             MOVE               CustNumD,CustKY
.
             SETLPTR           CustKY
             CALL              RDCust
             IF               (RETURNFL = 1)
               PARAMTEXT        CustTITLE,CustKY,"",""
               ALERT            CAUTION,"^0: ^1 Not Found",#RES2,"Record does not exist"
               CALL             MAINRESET
               RETURN
             ENDIF
.
. OK, we've been able to read the record and now let's show it on the screen.
.
.fucked up here           CALL              MainReset
             CALL              SETMAIN
             CALL              CalculateCustomerBalance
             ENABLEITEM        BAccept                  //HR 7/22/2003

.
HAR1


           MOVE              "3",Status                   .We've found a record
.hr           ENABLETOOL        ID_Change

.hr           ENABLETOOL        ID_Delete

           DISABLEITEM       EChckCODE
           DISABLEITEM       Fill1
.hr           SETPROP           CTView1,*Selected=0
.hr           SETFOCUS          CTView1
...           SETFOCUS          EChckBank
              SETFOCUS          EPaymentRef

           ENDIF
           RETURN

.=============================================================================
. Initialize MAIN Form and setup the Menu's, Fields, Objects, Buttons, etc
.
MAININIT
                    return             if (InputCustomer != "")            //We've got a Customer that we're inputting


.
. Set the SELECTALL property for the COLLECTION and then take care of
. any ActiveX controls.
.
           SETPROP           ChckEDT,SELECTALL=$SelectAll
.
           CALL              MAINRESET
           SETFOCUS          EChckCode
..HR 4.4.2016           SETPROP           CTView1,*ColumnTextAlign(1)=1
..HR 4.4.2016           SETPROP           CTView1,*ColumnTextAlign(2)=1
..HR 4.4.2016           SETPROP           CTView1,*ColumnTextAlign(3)=2
..HR 4.4.2016           SETPROP           CTView1,*ColumnTextAlign(4)=2

..HR 4.4.2016           SETPROP           CTView1,*ColumnTextAlign(5)=1
..HR 4.4.2016           SETPROP           CTView1,*ColumnTextAlign(6)=1
..HR 4.4.2016           SETPROP           CTView1,*ColumnTextAlign(7)=1         //Write-Off 4/15/03
           setprop           NChkVoucherTotals,value=0
           setprop           NChkDiscountTotals,value=0
           setprop           NWriteOffAmt,value=0
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
             CALL              RDCustLK
             CALL              SetMain
           ENDIF
           RETURN
.=============================================================================
MainFind
           FindSearch        EChckCode,Cust
           IF                (PassedVar = "Y")
             RESETVAR          CustKY
             getprop           EChckCode,text=CustKY
             MOVE              $SearchKey,CustKY
             SETLPTR           CustKY
             CALL              RDCust
.
. We've got a record thanks to our Trusy Search/Browse window. Let's
. continue now by setting up the proper Code field and calling the
. MainValid subroutine, that will take care of it for us.
.
             MOVE              "0",Status
             setprop           EChckCode,text=Cust.CustomerID
             CALL              MainValid
           ENDIF
           RETURN
.=============================================================================
. Routine to read the First record and display it
.
MainFirst
           RESETVAR          CustKY
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
           setprop           EChckCode,text=Cust.CustomerID
           CALL              MainValid
           RETURN
.=============================================================================
. Routine to read the Last record and display it
.
MainLast
           CLEAR             CustKY
           FILL              LastASCII,CustKY
           CALL              RDCust
           IF                (RETURNFL = 1)  . We didn't find a 'Blank' record
             CALL              KPCust         . Try the 'Previous' record
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
           setprop           EChckCode,text=Cust.CustomerID
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
           GETCOUNT          EChckCode
           IF                (CharCount <> 0)
             RESETVAR          CustKY
             getprop            EChckCode,text=CustKY
.             MOVE              CustKY,CustomerIDF
.             MOVE              CustomerIDF,CustKY
..HR 2018.8.1              JustifyCust       CustKY

             SETLPTR           CustKY
             CALL              RDCust
           ENDIF
.
           CALL              KSCust         . Try the 'next' record
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
           setprop           EChckCode,text=Cust.CustomerID
           CALL              MainValid
           RETURN
.=============================================================================
. Routine to read the Previous record and display it
.
MainPrevious
. We can't just do a simple 'READKS' because of certain conditions including
. 'Attempting' to read past the last record (Next --> EOF) and the reverse
. condition.  Due to this fact, we need to get the current code, and THEN
. do a /READKP
.
           GETCOUNT          EChckCode
           IF                (CharCount <> 0)
             RESETVAR          CustKY
             getprop            EChckCode,text=CustKY
.             MOVE              CustKY,CustomerIDF
.             MOVE              CustomerIDF,CustKY
..HR 2018.8.1              JustifyCust       CustKY

             SETLPTR           CustKY
             CALL              RDCust
           ENDIF
.
           CALL              KPCust         . Try the 'Previous' record
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
           setprop           EChckCode,text=Cust.CustomerID
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
.           BRANCH            Status,MainChange,MainNew
           RETURN
.=============================================================================
. Routine to Validate the data from the Form
.
VALIDATE1
           MOVE              "0",ValidFlag

.X           GETITEM           EChckCode,0,TestChars
.X           COUNT             CharCount,TestChars
.X           IF                (CharCount = 0)
.X             MOVE            "1",ValidFlag
.X             BEEP
.X             ALERT             CAUTION,"A Code must be entered into the system",RETURNFL,"Error in Field"
.X             SETFOCUS          EChckCode
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
..HR 4.4.2016           CTView1.ClearList
           LVDetails.DeleteAllItems
           SETPROP           SCollection,visible=0

           MOVE              "0",Status     //Reset the status to Not updating
           UNLOCK            CustFL
.
. Reset the fields to 'Blank' and DISABLE all of those fields as well
           DELETEITEM        ChckCOLL,0
           DELETEITEM        ChckStat,0

.           DISABLEITEM       ChckCOLL
.           DisableItem       ChckStat
           SETPROP           ChckCOLL,READONLY=1
           SETPROP           ChckCOLL,BGCOLOR=$BTNFACE
           SETPROP           ChckStat,BGCOLOR=$BTNFACE

           setprop           NChkVoucherTotals,value=0
           setprop           NChkDiscountTotals,value=0
           setprop           NWriteOffAmt,value=0
           setprop           NGrossAmt,value=0

           SETPROP           EPaymentRef,BGCOLOR=$BTNFACE
           SETPROP           NPaymentAmt,BGCOLOR=$BTNFACE,value=0
           SETITEM           EPaymentRef,0,""

           SETITEM           ECustBalance,0,""              //HR 9/10/2003  Reset on Cancel

..HR 4/1/2004           SETITEM           RCustomer,0,1                  //HR 9/10/2003  Reset to Customer Mode
..HR 2018.07.25           SETITEM           RInvoice,0,1                 //HR 4/1/2004

           ENABLEITEM        Fill1
.
. Reset the Buttons for the Next record
.
.hr           DISABLETOOL       ID_Change

.hr           DISABLETOOL       ID_Delete

.hr           ENABLETOOL        ID_New

.hr           DISABLETOOL       ID_Save
.hr           DISABLETOOL       ID_Undo

              SETITEM           CBPaymentType,0,1
              CALL              ChangePaymentDesc
              CALL              EnableRecordButtons
.hr           DisableItem       SelectColl

.
. Setup the Primary field that is used for Entry purposes
.
           %IFDEF            CBChckActive
             SETITEM           CBChckActive,0,0
             DISABLEITEM       CBChckActive
           %ENDIF

           SETPROP           EChckCODE,READONLY=0
           SETPROP           EChckCode,BGCOLOR=$WINDOW
           ENABLEITEM        EChckCODE

           clear             AR_DiscAmt,AR_WriteOffAmt,AR_Amount,WriteOffAmt

           DISABLEITEM       BAccept

           ENABLEITEM        BGetData
..HR 2018.07.25           SETITEM           CKSelectAll,0,0
..HR 2018.07.25           ENABLEITEM        CKSelectAll
           SETFOCUS          EChckCODE
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
           PARAMTEXT        Cust.CustomerID,CustTitle,"",""
           BEEP
           ALERT            PLAIN,"Do you wish to Delete the ^1: ^0 ?",#RES1,DelTitle
           IF               (#RES1 = 1)
             CALL             DELCust
             ALERT            NOTE,"A/P Term Code ^0 has been deleted",#RES1,DelOKTitle
             CALL             MAINRESET
           ENDIF
           RETURN

.=============================================================================
.
. Setup all of the fields in the Form based upon the data record
SETMAIN
           setprop           EChckCode,text=Cust.CustomerID
SETMAIN2
           setprop           EChckName,text=Cust.NAME
           setprop           EChckAddr1,text=Cust.Addr1
           setprop           EChckAddr2,text=Cust.Addr2
           setprop           EChckAddr3,text=Cust.Addr3
           setprop           EChckCity,text=Cust.City
           setprop           EChckSt,text=Cust.St
           setprop           EChckZip,text=Cust.Zip
           setprop           EChckCountry,text=Cust.Country
           CANDISP           EChckCountry,CNTRY,STChckCountry,Name
           setprop           EPaymentRef,text=""
...           SETITEM           NPaymentAmt,0,""
           SETPROP           EPaymentRef,BGCOLOR=$Window
           SETPROP           NPaymentAmt,BGCOLOR=$Window,value=0
.
. HR 10/21/2003
. Added In Collection Notice if the Custoner is on Collection Status
.
              SETPROP           SCollection,visible=Cust.InActive
.
.
.           SETITEM           EChckBank,0,Cust.BankCode
.           CANDISP           EChckBank,Bank,SChkBank,Name

..HR 4.4.2016           CTView1.ClearList
           LVDetails.DeleteAllItems

           SETPROP              WLoading,visible=1
..FUCLUP           move              "CHIRON",$ENTITY

..HR 8/11/2003           GETITEM           CKSelectAll,0,CBValue

              SWITCH            SearchMethod

              CASE               0                                     //By Customer ID
                RESETVAR          CustKY
                getprop           EChckCODE,text=CustKY
;
; Check to see if there's more Ship-To Customers                                              Mon 7-8
;                                                                              2929000 7257  Alec
                MOVE              Cust.CustomerID,CustomerIDSave
                move              Cust.CustomerID,CustKY3
                CALL              RDCust3
..WTF!!!!                MOVE              Cust.CustomerID,CustomerIDSave

                clear                  ShipToCounter
                LOOP
                  CALL              KSCust3
                UNTIL             (RETURNFL = 1 OR Cust.GroupCust != CustomerIDSave)
                  if                  (Cust.CustomerID != CustomerIDSave)
                    incr                   ShipToCounter
                  endif
                REPEAT
                    if                 (ShipToCounter > 1)
                      beep
                      alert              note,"Do you wish to view all the Invoices for the main Customer?",result,"VIEW ALL INVOICES?"
                      if                 (result = 1)
                        call              RDCust3
                        loop
                          call              KSCust3
                        until             (RETURNFL = 1 OR Cust.GroupCust != CustKY)
                          packkey           ARTRNKY3,$Entity,Cust.CustomerID,"O"      //HR 4/30/03
                          call              RDARTRN3                                                        //HR 4/30/03
                          loop
                            call              KSARTRN3
                          until             (RETURNFL = 1 or ARTrn.CustomerID != Cust.CustomerID)
                            call              AddTransactionRecord
                          repeat
                        repeat
                      else
                        packkey           ARTRNKY3,$Entity,CustomerIDSave,"O"      //HR 4/30/03
                        call              RDARTRN3                                                        //HR 4/30/03
                        loop
                          call              KSARTRN3
                        until             (RETURNFL = 1 or ARTrn.CustomerID != CustomerIDSave)
                          call              AddTransactionRecord
                        repeat

                      endif
                    else
                      packkey           ARTRNKY3,$Entity,CustomerIDSave,"O"      //HR 4/30/03
                      call              RDARTRN3                                                        //HR 4/30/03
                      loop
                        call              KSARTRN3
                      until             (RETURNFL = 1 or ARTrn.CustomerID != CustomerIDSave)
                        call              AddTransactionRecord
                      repeat
                    endif


.               PACKKEY           ARTRNKY3,$Entity,CustKY,"O"      //HR 4/30/03
.               CALL              RDARTRN3                         //HR 4/30/03
.               MOVE              CUSTKY,CustomerIDSave
.               LOOP
.                 CALL              KSARTRN3
.               UNTIL             (RETURNFL = 1 or ARTrn.CustomerID != CustomerIDSave)
.                 CALL              AddTransactionRecord
.               REPEAT
              CASE              "1"                                                    //By Invoice
                PACKKEY           ARTRNKY4,$Entity,"O"      //Look for 'O'pen Invoices
                CALL              RDARTRN4
                MOVE              CUSTKY,CustomerIDSave
                LOOP
                  CALL              KSARTRN4
                UNTIL             ( RETURNFL = 1 )
                  CALL              AddTransactionRecord
                REPEAT
.             CASE              "2"
.               RESETVAR          CustKY
.               GETITEM           EChckCODE,0,CustKY                  //Get the "Group To" Customer
.               MOVE              CustKY,Cust3KY

.               MOVE              CUSTKY,CustomerIDSave
.               CALL              RDCust3
.               LOOP
.                 CALL              KSCust3
.               UNTIL             (RETURNFL = 1 OR Cust.GroupCust != CustKY)
.                 PACKKEY           ARTRNKY3,$Entity,Cust.CustomerID,"O"      //HR 4/30/03
.                 CALL              RDARTRN3                                                        //HR 4/30/03
.                 LOOP
.                   CALL              KSARTRN3
.                 UNTIL             (RETURNFL = 1 or ARTrn.CustomerID != Cust.CustomerID)
.                   CALL              AddTransactionRecord
.                 REPEAT
.               REPEAT
              ENDSWITCH

           SETPROP              WLoading,visible=0

..           CTView1.Redraw using "1"


..HR 4.4.2016           GetProp           CTView1,*ListCount=ListCount
           LVDetails.GetItemCount giving ListCount
           IF                (ListCount != 0)
..HR 4.4.2016             SETPROP           CTView1,*Selected=0                 //fuckup
             LVDetails.SetItemState using *Index=0,*State=03,*StateMask=03

             ENABLEITEM        SelectColl
.hr             ENABLETOOL        ID_SAVE
           ELSE
             DisableItem       SelectColl
.hr             DISABLETOOL       ID_SAVE
           ENDIF
           CALL              CalcInvoiceTotals
.
. 4/9/03
.
              DISABLEITEM       BGetData
..HR 2018.07.25              DISABLEITEM       CKSelectAll
              DISABLEITEM       EChckCode

           RETURN
.=============================================================================
AddTransactionRecord
.                  MOVE              "30",AgingDays
.                  MOVE              "15",DiscountDays
.                  MOVE              "2",DiscountPercent

.HR 2019.7.22              CALL              ConvDateToDays using ARTRN.EntryDate,TodayDays
.HR 2019.7.22              ADD               AgingDays,TodayDays
.HR 2019.7.22              CALL              ConvDaysToDate using TodayDays,ARTRN.DueDate
.
. Calculate the Discount Amount
.
.HR 2019.7.22              CALL              ConvDateToDays using ARTRN.EntryDate,TodayDays
.HR 2019.7.22              ADD               DiscountDays,TodayDays
.HR 2019.7.22              CALL              ConvDaysToDate using TodayDays,ARTRN.DiscDate

              IF                (ARTrn.DiscDate >= SysDate)
                move                   ARTrn.DiscAmt,AmtToDisc
..HR 2019.7.22                calc                   AmtToDisc = (ARTRN.OrigAmt * (DiscountPercent / 100))
              ELSE
                MOVE            ".00",AmtToDisc
              ENDIF                      //End of HR 08/15/2003 Changes

             MOVE            ARTrn.Balance,AmtToPay
             MOVE            "0",Clicked

             UNPACK            ARTrn.TransDate INTO YYYY,MM,DD
             PACK              DATE82 FROM MM,"/",DD,"/",YYYY

             UNPACK            ARTrn.DiscDate INTO YYYY,MM,DD
             PACK              DATE83 FROM MM,"/",DD,"/",YYYY

             PACKKEY            alertstring FROM "Customer : ",ARTrn.CustomerID
             SETITEM            SCustomerProcessing,0,AlertString
.
. 05/13/2003  After meeting with Tom, Carlene, add new fields P.O. & S.O.
. Number to ListView for processing.
.
.             MOVE              SPACES TO OAFL1KEY
.             CLEAR             OAFL1KEY
.             RESET             INVCUST TO 6
.             LENSET            INVCUST
.             RESET             INVCUST
.             APPEND            INVCUST TO OAFL1KEY
.             RESET             INVKEY TO 5
.             LENSET            INVKEY
.             RESET             INVKEY
.             APPEND            "0" TO OAFL1KEY
              parse             ARTrn.Reference,OldInvoiceNumberD using "09"
              reset             ARTrn.Reference                        //HR 5/28/2003 testing
.              MOVE              ARTrn.Reference,OldInvoiceNumber10
..              MOVE              OldInvoiceNumber10,OldInvoiceNumber
.              MOVE              OldInvoiceNumber,OldInvoiceNumberD
.             REPLACE           " 0",OldInvoiceNumberD
.             PACKKEY           OAFL1KEY FROM ARTrn.CustomerID,"0",OldInvoiceNumberD

.             CALL              OPARF1RD
.             IF                over
.               MOVE              "  ",OPARPONO
.             ELSE
.               PACKKEY           SOHDRKEY,ARTrn.CustomerID,OPARPONO
.               READ              ACCTPOFL,SOHDRKEY;SOHDRREC
.               IF                OVER
.                 MOVE              " ",SONUMBER
.               ENDIF
.             ENDIF
              CALC             FreightTemp = ARTrn.OrigAmt - ARTrn.SalesAmt

             CHOP              ARTrn.Reference,ARTrn.Reference
             CHOP              ARTrn.CustomerPO,ARTrn.CustomerPO
             CHOP              ARTrn.OrderNumber,ARTrn.OrderNumber

              IF                (ARTrn.Balance != ARTrn.OrigAmt)          //HR 1/30/2009
                MOVE              "Yes",WrkDim3
              ELSE
                MOVE              " ",WrkDim3
              ENDIF

              PACK              DATALINE FROM ARTrn.Reference,";":
                                              ARTrn.Balance,";":
                                              "0.00;":
                                              DATE82,";":
                                              DATE83,";":
                                              AmtToDisc,";":
                                              "0;":                     //Write-off Amt
                                              ARTrn.CustomerPO,";":
                                              ARTrn.InvCredit,";":
                                              ARTrn.Memo,";":                                             //Memo Field HR 4.25.2016
                                              ARTrn.CustomerID

..HR8/2/2003                                             OPARPONO,";":
..HR8/2/2003                                             SONUMBER,";":
..HR8/2/2003                                             OPARFRGT

..HR 4.4.2016             LVDetails.InsertItem giving int2 using ARTrn.CustomerID                                         //HR 4.4.2016
             LVDetails.SetItemTextAll giving Int2 using *Index=99999,*Text=DataLine,*Delimiter=";",*Param=ARTrn.SeqMajor  //HR 4.4.2016
             LVDetails.SetItemCheck using *Index=Int2,*Value=Clicked
..HR 4.4.2016             CTView1.AddItem   giving int2 using dataline
..HR 4.4.2016             SETPROP           CTView1,*ListColumnCheck(int2,8)=Clicked
.             SETPROP           CTView1,*ListColumnCheck(int2,5)=ARTrn.HoldFlag
..HR 4.4.2016             SETPROP           CTView1,*ListData(int2)=ARTrn.SeqMajor

              RETURN
.=============================================================================
. Retrieve all of the fields in the Form based upon the data record
.
GETMAIN
           getprop           EChckCode,text=Cust.CustomerID
..HR 2018.8.1              JustifyCust       Cust.CustomerID

.           MOVE              Cust.CustomerID,CustomerIDF
.           MOVE              CustomerIDF,Cust.CustomerID

           getprop           EChckName,text=Cust.Name
           getprop           EChckAddr1,text=Cust.Addr1
           getprop           EChckAddr2,text=Cust.Addr2
           getprop           EChckAddr3,text=Cust.Addr3
           getprop           EChckCity,text=Cust.City
           getprop           EChckSt,text=Cust.St
.           getprop           EChckZip,text=Cust.Zip
           getprop           EChckCountry,text=Cust.Country
           RETURN
.=============================================================================
.Help Menu selection if required
.
MAINHELP
          RETURN

onClickMainWinChangeMenu
..           PERFORM           RESULT OF  MAINNEW,MAINCHANGE,MainDelete,SAVEMODE
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
.hr           DISABLETOOL       ID_First
.hr           DISABLETOOL       ID_Next
.hr           DISABLETOOL       ID_Previous
.hr           DISABLETOOL       ID_Last
.hr           DISABLETOOL       ID_Find
           RETURN
.=============================================================================
. Enable the 'Record' Buttons because we're in the middle of Updating or
. Creating a New record.
.
EnableRecordButtons
.hr           ENABLETOOL        ID_First
.hr           ENABLETOOL        ID_Next
.hr           ENABLETOOL        ID_Previous
.hr           ENABLETOOL        ID_Last
.hr           ENABLETOOL        ID_Find
           RETURN
.=============================================================================
OnClickAcceptEntries
.
. Before we proceed, let's check to see if there's any amount that hasn't
. been applied (i.e. or that is leftover).
.
;
; Get the main data fields
;

              GETCOUNT          EDepositID
              IF                (CharCount = 0)       //No Deposit ID Entered
                BEEP
                ALERT             STOP,"Deposit ID must be entered for this transaction",result
                SETFOCUS          EDepositID
                RETURN
              ENDIF

              move                     DepositID,ARDepKY

              getprop                  EPaymentRef,text=PaymentReference
              getprop                  EDepositID,text=DepositID
              clear                    ReasonCode
              getprop                  NPaymentAmt,value=CheckAmount

              CBPaymentType.GetCurSel  giving TransSubCode

              squeeze           PaymentReference,PaymentReference
              IF                (PaymentReference = "")
                PACK              AlertMsg FROM "Missing ",PaymentDesc,".  Enter ",PaymentDesc:
                                  " before Applying"
                ALERT             note,AlertMsg,result,"Missing Reference Number"
                SETFOCUS          EPaymentRef
                RETURN
              ENDIF

              debug
              CALL              CalcInvoiceTotals
              IF                (PaymentAmt != 0)

                if                       (PaymentAmt <= -90)
                  beep
                  alert              stop,"The Amount left to apply is outside of the range.  Please correct these entries",result
                  return
                endif


                beep
..HR 2019.7.25                ALERT             plain,"Do you wish to create an Un-applied payment for the remaining amount?",result
                    alert              plain,"There remains an outstanding amount to post. Do you wish to Write off this amount?",result
                    return             if (result != 1)
..HR 2019.7.25                RETURN            if (result = 3)         //Cancel

                    call               CreateDiscountInvoice
                    debug

..HR 2019.7.25                IF                (result = 2)
..HR 2019.7.25                  SETFOCUS          NPaymentAmt
..HR 2019.7.25                  RETURN
..HR 2019.7.25                ENDIF
..HR 2019.7.25                MOVE              "0",UnAppliedAmt
..HR 2019.7.25                MOVE              "0.00",UnAppliedAmtD

..HR 2019.7.25                getprop           NChkVoucherTotals,value=UnAppliedAmt
..HR 2019.7.25                setprop           NUnAppliedAmt,value=UnAppliedAmt

..HR 2019.7.25                EUnAppliedCustomer.Clear
..HR 2019.7.25                EUnAppliedName.Clear
..HR 2019.7.25                E3ChckCode.Clear

..HR 2019.7.25                EUnappliedLotNumber.Clear

..HR 2019.7.25                CLEAR           CancelFlag                               //HR 1/8/2004
..HR 2019.7.25                SETPROP         Cash3,visible=1
..HR 2019.7.25                RETURN          IF (CancelFlag = 1)   //User Cancelled out of it!! HR 1/8/2004
              ENDIF
;
; Load up the Arrary of variables first before processing
; Once we've got everything, then we'll proceed to process the same way except we'll
; use the array information through TRANSACTIONAL processing.
;
                    move              FirstRow,X
                    clear             AR_Counter
                    loop
                      add                  "1",X
                      LVDetails.FindItemCheck giving X using *Start=X
                    until             (X = -1)
                      incr               AR_Counter

                      LVDetails.GetItemParam giving AR_SeqNum(AR_Counter) using *Index=X
                      LVDetails.GetItemText giving AR_Memo(AR_Counter) using *Index=X,*SubItem=9
                      LVDetails.GetItemText giving WrkAmount using *Index=X,*SubItem=5
                      squeeze                 WrkAmount,WrkAmount
                      move                    WrkAmount,AR_DiscAmt(AR_Counter)

                      LVDetails.GetItemText giving WrkAmount using *Index=X,*SubItem=6
                      squeeze                 WrkAmount,WrkAmount
                      move                    WrkAmount,AR_WriteOffAmt(AR_Counter)

                      if                      (AR_WriteOffAmt(AR_Counter) != 0)
                        LVDetails.GetItemText giving AR_ReasonCode(AR_Counter) using *Index=X,*SubItem=11    //HR 2018.10.10
                      else
                        clear                   AR_ReasonCode(AR_Counter)
                      endif

                      LVDetails.GetItemText giving WrkAmount using *Index=X,*SubItem=2           //HR 4.25.2016 Changed to zero from 7
                      squeeze                 WrkAmount,WrkAmount
                      move                    WrkAmount,AR_Amount(AR_Counter)

                    repeat
                    clock              TimeStamp,DateTime

;==========================================================================================================
.AR_SeqNum           form               7(999)
.AR_Memo             dim                80(999)
.AR_DiscAmt          form               7.2(999)
.AR_WriteOffAmt      form               7.2(999)
.AR_Amount           form               7.2(999)

.AR_Counter          form               4
.DepositID           dim                14
.PaymentReference    dim                10
;==========================================================================================================
                    transaction        Start,SequenceFLST,ARDetFLST,ARTRNFlst,PymntFLST,ARDepFLST:
                                             CustDFLST,CHSTFLST,ARDistFLST,BatchChecksFLST
;
; Validate the Sequence Transactions first
;
                    for                X from "1" to AR_Counter using "1"

                      packkey           ARTRNKY2 FROM $Entity,AR_SeqNum(X)
                      call              RDARTRN2                   //Read it first to see if it's there and get the Seq Num
                      if                (ReturnFl = 1)
                        transaction        rollback
                        beep
                        alert              note,"Missing Transaction record",result,"ERROR:Missing AR TRANS"
                        return
                      endif
                    repeat
;
; We've validated the AR Transactions exist (using SeqNum), now let's begin processing
;
                    for                X from "1" to AR_Counter using "1"

                      packkey           ARTrnKY2 FROM $Entity,AR_SeqNum(X)
                      call              RDARTrn2LK                   //Read it first to see if it's there and get the Seq Num

                      if                (ReturnFl = 1)
                        transaction        rollback
                        beep
                        alert              note,"Missing Transaction record",result,"ERROR:Missing AR TRANS"
                        return
                      endif
.
. Get the last SeqMinor record for writing out future records.
.
                      packkey           ARDetKY,$Entity,ARTrn.SeqMajor,"999"
                      call              RDARDet
                      call              KPARDet

                      if                (ReturnFL = 0 AND ARDet.SeqMajor = :
                                                    ARTrn.seqmajor)
                        move              ARDet.SeqMinor,SeqMinor
                        add               "1",SeqMinor
                      else
                        move              "1",SeqMinor
                      endif
.
. Reset the Detail Records
.
                      clear              ARDet
                      move              "0",WriteOffAmt
;
; Let's begin populating the AR Detail Record
;
.ARDet      RECORD
.ARAccount     DIM               8       27 - 34
.PostDate      DIM               8       88 - 95
.Year          DIM               4       96 - 99
.Month         FORM              2       100 - 101
.ReasonCode    DIM               4       269 - 272
.NonARFlag     DIM               1       273 - 273             //'Y' = Non A/R       //Used to be 231

                      move               ARTrn.SeqMajor,ARDet.SeqMajor
                      move               SeqMinor,ARDet.SeqMinor
                      move               AR_Memo(X),ARDet.Memo
                      move               AR_DiscAmt(X),ARDet.DiscAmt
                      move               AR_WriteOffAmt(X),WriteOffAmt
                      move               AR_Amount(X),ARDet.Amount
                      move               AR_Reasoncode(X),ARDet.ReasonCode

..HR 2018.10.2                      multiply           "-1",ARDet.DiscAmt
..HR 2018.10.2                      multiply           "-1",ARDet.Amount
..HR 2018.10.2                      multiply           "-1",WriteOffAmt
;
; Moved here from above
;
              if                       (AR_WriteOffAmt(X) = 0)
                clear                    ARDet.ReasonCode
              endif

;
; Move Full Item records to Detail Transactional records
;

                      move               ARTrn.Entity,ARDet.Entity
                      move               ARTrn.SubEntity,ARDet.SubEntity
                      move               ARTrn.CustomerID,ARDet.CustomerID
                      unpack             DateTime,ARDet.TransDate,ARDet.TransTime          //Get the Date & Time
                      move               ARDet.TransDate,ARDet.BillDate
                      move               ARDet.TransDate,ARDet.EntryDate
                      move               ARDet.TransDate,ARDet.PostDate
                      move               "5",ARDet.TransCode                //Payment Code
                      move               TransSubCode,ARDet.TransSubCode

                      move               ARTrn.ARAccount,ARDet.ARAccount

                      move               ARDet.TransDate,ARDet.BillDate
                      move               ARDet.TransDate,ARDet.EntryDate
                      move               ARDet.TransDate,ARDet.PostDate
                      move               PaymentReference,ARDet.Reference
                      move               DepositID,ARDet.LockBoxID

                      clear              NetAmount
                      calc               NetAmount = ARDet.Amount - ARDet.DiscAmt - WriteOffAmt

                      unpack             ARDet.PostDate,ARDet.Year,ARDet.Month
;
; Record General Ledger Information
;
                      clear              ARDist
                      move               ARTrn.Entity,ARDist.Entity
                      move               ARTrn.SubEntity,ARDist.SubEntity
                      move               ARDet.TransDate,ARDist.TransDate
                      move               ARTrn.CustomerID,ARDist.CustomerID
                      move               ARDet.Year,ARDist.Year
                      move               ARDet.Month,ARDist.Month

                      move               Default.ARAcct,ARDist.GLCode
                      move               "0",ARDist.PostedToGL
                      move               ARDet.SeqMajor,ARDist.Voucher
                      move               ARDet.TransCode,ARDist.TransCode
                      move               ARDet.Reference,ARDist.CheckNo
                      move               ARDet.SeqMinor,ARDist.SeqMinor
                      GetNextSeq         ARDist
                      move               Sequence.SeqNo,ARDist.SeqMajor
;
; Write out the A/R Amount
;
                      move               NetAmount,ARDist.DebitAmount
                      clear              ARDist.CreditAmount
                      call               WrtARDist
;
; Get the next sequence number
;
                      GetNextSeq         ARDist
                      move               Sequence.SeqNo,ARDist.SeqMajor
;
; Write out the Cash Amount
;
                      move               "80100",ARDist.GLCode
                      move               ARDet.Amount,ARDist.CreditAmount
                      clear              ARDist.DebitAmount
                      call               WrtARDist
;
; If there's a discount, write out the Discounts
;
                      if                 (ARDet.DiscAmt != 0)
                        GetNextSeq         ARDist
                        move               Sequence.SeqNo,ARDist.SeqMajor

                        move               "13000",ARDist.GLCode
..HR 2018.10.2                        multiply           "-1",ARDet.DiscAmt,ARDist.DebitAmount
                        move               ARDet.DiscAmt,ARDist.DebitAmount
                        clear              ARDist.CreditAmount
                        call               WrtARDist
                      endif

                      call               WrtARDet
                      call               UpdateCustomerBalance     //Update the Customer Balance
;
; Write out the Payment Detail record, which includes NON A/R TRansactions as well
;
                      move               ARDet,PymntREC
                      call               WrtPymnt
;
; Calculate the new AR Transaction Balance
;

..HR 2018.10.2                      add                NetAmount,ARTrn.Balance                 //Update the Open Balance
..HR 2018.10.2                      add                ARDet.DiscAmt,ARTrn.DiscAmt          //Update the Discount Amount
                      sub                NetAmount,ARTrn.Balance                 //Update the Open Balance
                      sub                ARDet.DiscAmt,ARTrn.DiscAmt          //Update the Discount Amount
                      if                 (ARTrn.DiscAmt < 0)
                        move               "0",ARTrn.DiscAmt
                      endif
..HR 2018.10.2                      add                ARDet.DiscAmt,ARTrn.Balance
                      sub                ARDet.DiscAmt,ARTrn.Balance

                      move              ARDepREC.DepositID,ARDepKY
                      call              RDARDepLK
                      if                (Returnfl = 1)
                        getprop           DTDepositDate,text=ARDepREC.DepositDate
                        replace            " 0",ARDepREC.DepositDate
                        move               "0",ARDepREC.AppliedTotal
                        move               "  ",ARDepREC.ApprovalUser
                        move               "  ",ARDepREC.ApprovalDate
                        move               "  ",ARDepREC.ApprovalTime
                        move               "0",ARDepREC.Approved
...FUCKUP                call              WRTARDep
                      endif

                      add                ARDet.Amount,ARDepREC.AppliedTotal
                      call               UpdateCustomerHistory

                      DEBUG
                      if                 (WriteOffAmt != 0)      //We have a Write-Off Amt
                        add                "1",ARDet.SeqMinor  //New Sequence Record
                        move               "0",ARDet.DiscAmt
                        move               WriteOffAmt,ARDet.Amount
                        move               "          ",ARDet.DiscDate
                        move               ARTrn.ARAccount,ARDet.ARAccount     //Fuckup - Wait for G/L system
                        move               "8",ARDet.TransCode                    //Payment Code
                        move               "9",ARDet.TransSubCode
                        move               "                  ",ARDet.CustomerPO
..HR 2018.8.2                      move               " ",ARDet.ReasonCode
..HR 2018.10.10                        move               ReasonCode,ARDet.ReasonCode             //HR 2018.8.2
                        move               DepositID,ARDet.LockBoxID

                        move               " ",ARDet.NonARFlag

                        call               WRTARDet

                        GetNextSeq         ARDist
                        move               Sequence.SeqNo,ARDist.SeqMajor

                        move               "14000",ARDist.GLCode
..HR 2018.10.2                        multiply           "-1",WriteOffAmt,ARDist.DebitAmount
                        move               WriteOffAmt,ARDist.DebitAmount
                        clear              ARDist.CreditAmount
                        call               WrtARDist

                        call               UpdateCustomerBalance
;
; Write out the Payment Journal Transaction Record.
;
                        move              ARDet,PymntREC
                        call              WrtPymnt

..HR 2018.10.2                        add              ARDet.Amount,ARTrn.Balance           //Update the Open Balance
                        sub              ARDet.Amount,ARTrn.Balance           //Update the Open Balance
                      endif

                      debug
                      if                (ARTrn.Balance = 0)                 //HR 3/19/2009
                        move              "C",ARTrn.ClosedFlag
                      else
                        move              "O",ARTrn.ClosedFlag
                      endif

                      call                UPDARTrn
                    repeat
;
; Create Check Information for Batch Controls
;
                    if                 (CheckAmount != 0)           //No need to writeout a Batch Check record   2019.9.24
                      clear              BatchChecks
                      move               $Entity,BatchChecks.Entity
                      clock              TimeStamp,BatchChecks.CheckDate
                      move               Cust.CustomerID,BatchChecks.CustomerID
                      move               PaymentReference,BatchChecks.CheckNo
                      GetNextSeq         BatChk
                      move               Sequence.SeqNo,BatchChecks.SeqNo
                      move               CheckAmount,BatchChecks.Amount
                      move               TransSubCode,BatchChecks.Type
                      call               WrtBatchChecks
                    endif

                    transaction        Commit
                    call               MainReset
                    return


..HR 2018.8.1             MOVE              "0",ARDet.DiscAmt                      //HR 4/14/2004
..HR 4.4.2016             GETPROP           CTView1,*ListColumnText(X,6)=ARDet.DiscAmt
..HR 4.4.2016             GETPROP           CTView1,*ListColumnText(X,7)=WriteOffAmt
..HR 4.4.2016             GetProp           CTView1,*ListColumnText(X,8)=ARDet.Amount
..HR 2018.8.1             LVDetails.GetItemText giving WrkAmount using *Index=X,*SubItem=5
..HR 2018.8.1             squeeze                 WrkAmount,WrkAmount
..HR 2018.8.1             move                    WrkAmount,ARDet.DiscAmt

..HR 2018.8.1             LVDetails.GetItemText giving WrkAmount using *Index=X,*SubItem=6
..HR 2018.8.1             squeeze                 WrkAmount,WrkAmount
..HR 2018.8.1             move                    WrkAmount,WriteOffAmt

..HR 2018.8.1             LVDetails.GetItemText giving WrkAmount using *Index=X,*SubItem=0           //HR 4.25.2016 Changed to zero from 7
..HR 2018.8.1             squeeze                 WrkAmount,WrkAmount
..HR 2018.8.1             move                    WrkAmount,ARDet.Amount
.
. Because this is a 'Payment' entry program, let's make the figures negative
.
..HR 2018.8.1             multiply          "-1",ARDet.DiscAmt
..HR 2018.8.1             multiply          "-1",ARDet.Amount
..HR 2018.8.1             MULTIPLY          "-1",WriteOffAmt
...HR 6/21/2003             SUBTRACT          WriteOffAmt,ARDet.Amount     //HR 6/20/2003
.
. Move Full Item records to Detail Transactional records
.
..HR 2018.8.1              MOVE              "          ",ARDet.DiscDate
..HR 2018.8.1              MOVE              ARTrn.Entity,ARDet.Entity
..HR 2018.8.1              MOVE              ARTrn.SubEntity,ARDet.SubEntity
..HR 2018.8.1              MOVE              ARTrn.CustomerID,ARDet.CustomerID

..HR 2018.8.1              MOVE              ARTrn.ARAccount,ARDet.ARAccount
..HR 2018.8.1              MOVE              "5",ARDet.TransCode                //Payment Code
..HR 2018.8.1              MOVE              "                  ",ARDet.CustomerPO

..HR 2018.8.1              CLOCK             TIMESTAMP,ARDet.TransDate
..HR 2018.8.1              MOVE              ARDet.TransDate,ARDet.BillDate
..HR 2018.8.1              MOVE              ARDet.TransDate,ARDet.EntryDate
..HR 2018.8.1              MOVE              ARDet.TransDate,ARDet.PostDate
..HR 2018.8.1              unpack            ARDet.PostDate,ARDet.Year,ARDet.Month

..HR 2018.8.1              GETITEM           CBPaymentType,0,ARDet.TransSubCode                      //gET AT THE TOP!!!
..HR 2018.8.1              GETITEM           EPaymentRef,0,ARDet.Reference
..HR 2018.8.1              GETITEM           EDepositID,0,ARDet.LockBoxID
.
. This record has now been added to the system...Now let's update the original
. Item.
.
..HR 2018.8.1             MOVE              " ",ARDet.NonARFlag

..HR 2018.8.1             CALL              WRTARDET
..HR 2018.8.1             CALL              UpdateCustomerBalance
;
; Write out the Payment Journal record.  This is the same as the AR Detailed
; Transaction record except it will also include Non A/R
..HR 2018.8.1              MOVE              ARDet,PYMNTREC
..HR 2018.8.1              CALL              WRTPYMNT

;..             ADD              ARDet.Amount,ARTrn.Balance           //Update the Open Balance
..HR 2018.8.1             MOVE               "0",NetAmount
..HR 2018.8.1             CALC             NetAmount = ARDet.Amount - ARDet.DiscAmt - WriteOffAmt
..HR 2018.8.1             ADD              NetAmount,ARTrn.Balance           //Update the Open Balance
..HR 2018.8.1             ADD              ARDet.DiscAmt,ARTrn.DiscAmt          //Update the Discount Amount
..HR 2018.8.1             IF               (ARTrn.DiscAmt < 0)
..HR 2018.8.1               MOVE              "0",ARTrn.DiscAmt
..HR 2018.8.1             ENDIF
..HR 2018.8.1             ADD              ARDet.DiscAmt,ARTrn.Balance
.HR 6/21/2003             ADD              WriteOffAmt,ARTrn.Balance
.
. OK, Now that we've gotten this far in the update process, let's update
. the A/R Deposit Master record from this transaction before continuing
. Added HR 5/20/2003
.
..HR 2018.8.1              GETITEM           EDepositID,0,ARDepREC.DepositID
..HR 2018.8.1              MOVE              ARDepREC.DepositID,ARDepKY
..HR 2018.8.1              call              RDARDepLK
..HR 2018.8.1              IF                (Returnfl = 1)
..HR 4.1.2016                GETPROP           EDepositDate,*Value=DATE10
..HR 2018.8.1                getprop           DTDepositDate,text=ARDepREC.DepositDate
..HR 4.1.2016                parse             DATE10,MM using "09"
..HR 4.1.2016                MOVE              MM,MMF
..HR 4.1.2016                BUMP              Date10

..HR 4.1.2016                parse             DATE10,DD using "09"
..HR 4.1.2016                MOVE              DD,DDF
..HR 4.1.2016                BUMP              Date10
..HR 4.1.2016                parse             DATE10,YYYY using "09"

..HR 4.1.2016                PACKKEY           ARDepREC.DepositDate,YYYY,MMF,DDF
..HR 2018.8.1                REPLACE           " 0",ARDepREC.DepositDate
..HR 2018.8.1                MOVE              "0",ARDepREC.AppliedTotal
..HR 2018.8.1                MOVE              "  ",ARDepREC.ApprovalUser
..HR 2018.8.1                MOVE              "  ",ARDepREC.ApprovalDate
..HR 2018.8.1                MOVE              "  ",ARDepREC.ApprovalTime
..HR 2018.8.1                MOVE              "0",ARDepREC.Approved
...FUCKUP                CALL              WRTARDep
..HR 2018.8.1              ENDIF

..HR 2018.8.1              ADD               ARDet.Amount,ARDepREC.AppliedTotal
..HR 2018.8.1              CALL                UpdateCustomerHistory

...fuckup              CALL              UPDARDep
.
. OK..Now let's check to see if there's a Write-Off Amount that we have to use.
. We're going to add a line with a Trans Code of 8 for Write-Off's.
.
..HR 2018.8.1             IF               (WriteOffAmt != 0)      //We have a Write-Off Amt
..HR 2018.8.1               ADD               "1",ARDet.SeqMinor  //New Sequence Record
..HR 2018.8.1               MOVE              "0",ARDet.DiscAmt
..HR 2018.8.1               MOVE              WriteOffAmt,ARDet.Amount
..HR 2018.8.1               MOVE              "          ",ARDet.DiscDate
..HR 2018.8.1               MOVE              ARTrn.ARAccount,ARDet.ARAccount     //Fuckup - Wait for G/L system
..HR 2018.8.1               MOVE              "8",ARDet.TransCode                    //Payment Code
..HR 2018.8.1               MOVE              "9",ARDet.TransSubCode
..HR 2018.8.1               MOVE              "                  ",ARDet.CustomerPO
..HR 2018.8.1               MOVE              " ",ARDet.ReasonCode
..HR 2018.8.1               GETITEM           EDepositID,0,ARDet.LockBoxID
..HR 2018.8.1               MOVE              " ",ARDet.NonARFlag

..HR 2018.8.1               CALL              WRTARDET
..HR 2018.8.1              CALL              UpdateCustomerBalance

.
. Write out the Payment Journal Transaction Record.
.
..HR 2018.8.1               MOVE              ARDet,PYMNTREC
..HR 2018.8.1               CALL              WRTPYMNT

..HR 2018.8.1               ADD              ARDet.Amount,ARTrn.Balance           //Update the Open Balance
..HR 2018.8.1             ENDIF
.
. As per Allan (2/4/2004), "IF" the Balance is also less than Zero, we're going
. to set the Closed Flag.
.
..HR 2/5/2004             IF                (ARTrn.Balance = 0)
..HR 2018.8.1             IF                (ARTrn.Balance = 0)                 //HR 3/19/2009
..HR 2018.8.1               MOVE              "C",ARTrn.ClosedFlag
..HR 2018.8.1             ELSE
..HR 2018.8.1               MOVE              "O",ARTrn.ClosedFlag
..HR 2018.8.1             ENDIF
.
..HR 2018.8.1             CALL                UPDARTRN
..HR             CALL                UpdateCustomerHistory
.
..HR 2018.8.1           REPEAT
..HR 2018.8.1           CALL              MainReset
..HR 2018.8.1           RETURN
;
; End of original Apply Transactions
;==========================================================================================================
OnClickSelectAll
..HR 4.4.2016           GetProp           CTView1,*ListCount=ListCount
           LVDetails.GetItemCount giving ListCount
           SUBTRACT          "1",ListCount
           FOR                X FROM "0" TO ListCount USING "1"
..HR 4.4.2016             SetProp           CTView1,*ListColumnCheck(X,8)=1
           LVDetails.SetItemCheck using *Index=X,*Value=1
           REPEAT
           CALL              CalcInvoiceTotals
           RETURN
.=============================================================================
OnClickUnSelectAll
..HR 4.4.2016           GetProp           CTView1,*ListCount=ListCount
           LVDetails.GetItemCount giving ListCount
           SUBTRACT          "1",ListCount
           FOR                X FROM "0" TO ListCount USING "1"
..HR 4.4.2016             SetProp           CTView1,*ListColumnCheck(X,8)=0
           LVDetails.SetItemCheck using *Index=X,*Value=0
           REPEAT
           CALL              CalcInvoiceTotals
           RETURN
;==========================================================================================================
OnCTChange
                    eventinfo          0,result=RowSelected
                    return

.=============================================================================
OnCTViewKeyPress
                    LVDetails.GetItemCheck giving Check using *Index=RowSelected
                    if                 (Check = 1)
                      LVDetails.GetItemText giving WrkAmount using *Index=RowSelected,*SubItem=1           //HR 4.25.2016 Changed to zero from 7
                      squeeze                 WrkAmount,WrkAmount
                      move                    WrkAmount,PaymentAmount
                      LVDetails.SetItemText using *Index=RowSelected,*SubItem=2,*text=WrkAmount           //HR 4.25.2016 Changed to zero from 7
                    else
                      LVDetails.SetItemText using *Index=RowSelected,*SubItem=2,*text="0.00"              //HR 4.25.2016 Changed to zero from 7
                    endif

                    CALL              CalcInvoiceTotals
                    RETURN
;==========================================================================================================
OnCTViewCheckClick
..                    debug

. Renee@WreathsAcrossAmerica.Org


                    eventinfo          0,result=RowSelected
                    LVDetails.GetItemCheck giving Check using *Index=RowSelected
                    if                 (Check = 1)
                      LVDetails.GetItemText giving WrkAmount using *Index=RowSelected,*SubItem=2          //HR 4.25.2016 Changed to zero from 7
                      squeeze                 WrkAmount,WrkAmount
                      move                    WrkAmount,PaymentAmount
                      if                     (PaymentAmount = 0)
                        LVDetails.GetItemText giving WrkAmount using *Index=RowSelected,*SubItem=1           //HR 4.25.2016 Changed to zero from 7
                        squeeze                 WrkAmount,WrkAmount
                        move                    WrkAmount,PaymentAmount
                        LVDetails.SetItemText using *Index=RowSelected,*SubItem=2,*text=WrkAmount           //HR 4.25.2016 Changed to zero from 7
                      endif
                    else
                      LVDetails.SetItemText using *Index=RowSelected,*SubItem=2,*text="0.00"              //HR 4.25.2016 Changed to zero from 7
                    endif

           CALL              CalcInvoiceTotals
           RETURN
;==========================================================================================================
OnValidateNPaymentAmt
DisbursementAmt     form               9.2
AmountToDisburse    form               9.2

                   return

....                    return             if (Cust.AutoDisburse = 0)           //Ignore Autmatic Disbursements
                    getprop            NPaymentAmt,value=DisbursementAmt
                    move               DisbursementAmt,AmountToDisburse

.                    call              RDCust3
.                    loop
.                      call              KSCust3


                    packkey            ARTRNKY3,$Entity,Cust.CustomerID,"O"      //HR 4/30/03
                    call               RDARTRN3                                                        //HR 4/30/03
                    loop
                      call               KSARTRN3
                    until              (RETURNFL = 1 or ARTrn.CustomerID != Cust.CustomerID or AmountToDisburse = 0)
                      LVDetails.FindItem giving RowSelected using *Param=ARTrn.SeqMajor
                      if                 (AmountToDisburse - ARTrn.Balance > 0)
                        subtract                ARTrn.Balance,AmountToDisburse
                        move                    ARTrn.Balance,WrkAmount
                        squeeze                 WrkAmount,WrkAmount
                        LVDetails.SetItemText using *Index=RowSelected,*SubItem=2,*Text=WrkAmount   //HR 4.25.2016 Changed from 7 to zero
                        LVDetails.SetItemCheck using *Index=RowSelected,*Value=1
                      else
                        if                   (AmountToDisburse < ARTrn.Balance)
                          move                    AmountToDisburse,WrkAmount
                          squeeze                 WrkAmount,WrkAmount
                          LVDetails.SetItemText using *Index=RowSelected,*SubItem=2,*Text=WrkAmount   //HR 4.25.2016 Changed from 7 to zero
                          LVDetails.SetItemCheck using *Index=RowSelected,*Value=1
                          clear                   AmountToDisburse
                        endif
                      endif
                    repeat
                    call               CalcInvoiceTotals
                    return
.=============================================================================
CalcInvoiceTotals
                    SETMODE            *mcursor=*Wait
                    LVDetails.GetItemCount giving LineCount
                    SUBTRACT           "1",LineCount
                    MOVE               "0",InvoiceTotals
                    MOVE               "0",DiscountTotals
                    MOVE               "0",WriteOffTotals
                    MOVE               "0",PaymentAmt
                    getprop            NPaymentAmt,value=PaymentAmt

                    MOVE              FirstRow,X
                    LOOP
                      add                "1",X
                      LVDetails.FindItemCheck giving X using *Start=X
                    UNTIL              (X = -1)

                      MOVE               "0",LineDiscount
                      MOVE               "0",LineVoucher
                      MOVE               "0",LineWriteOff
                      LVDetails.GetItemText giving WrkAmount using *Index=X,*SubItem=5
                      squeeze            WrkAmount,WrkAmount
                      move               WrkAmount,LineDiscount

                      LVDetails.GetItemText giving WrkAmount using *Index=X,*SubItem=6
                      squeeze            WrkAmount,WrkAmount
                      move               WrkAmount,LineWriteOff

                      LVDetails.GetItemText giving WrkAmount using *Index=X,*SubItem=2
                      squeeze            WrkAmount,WrkAmount
                      move               WrkAmount,LineVoucher

                      ADD                LineDiscount,DiscountTotals
                      ADD                LineWriteOff,WriteOffTotals
                      ADD                LineVoucher,InvoiceTotals
                    REPEAT

                    SUBTRACT           InvoiceTotals,PaymentAmt
                    ADD                DiscountTotals,PaymentAmt
                    ADD                WriteOffTotals,PaymentAmt     //Write-Off Amt 4/15/03
                    MOVE               PaymentAmt,PaymentAmtD

                    MOVE               DiscountTotals,DiscountTotalsD
                    MOVE               InvoiceTotals,InvoiceTotalsD
                    MOVE               WriteOffTotals,WriteOffTotalD
                    setprop            NGrossAmt,value=InvoiceTotals
                    setprop            NChkDiscountTotals,value=DiscountTotals
                    setprop            NChkVoucherTotals,value=PaymentAmt
                    setprop            NWriteOffamt,value=WriteOffTotals

                    SETMODE            *mcursor=*Arrow
                    RETURN
;==========================================================================================================
CreateDiscountInvoice
DiscountAmtToApply  form               7.2
;
; Determine what's left to apply and see if we can throw it onto a single Invoice
;
                    debug
                    getprop            NChkVoucherTotals,value=DiscountAmtToApply

                    SETMODE            *mcursor=*Wait
                    LVDetails.GetItemCount giving LineCount

                    MOVE              FirstRow,X
                    LOOP
                      add                "1",X
                      LVDetails.FindItemCheck giving X using *Start=X
                    UNTIL              (X = -1)
                      MOVE               "0",LineDiscount
                      MOVE               "0",LineVoucher
                      MOVE               "0",LineWriteOff
                      LVDetails.GetItemText giving WrkAmount using *Index=X,*SubItem=5
                      squeeze            WrkAmount,WrkAmount
                      move               WrkAmount,LineDiscount

                      LVDetails.GetItemText giving WrkAmount using *Index=X,*SubItem=6
                      squeeze            WrkAmount,WrkAmount
                      move               WrkAmount,LineWriteOff

                      LVDetails.GetItemText giving WrkAmount using *Index=X,*SubItem=2
                      squeeze            WrkAmount,WrkAmount
                      move               WrkAmount,LineVoucher
;
; If we've got an Invoice that's greater than the current Amount left to apply, let's apply it to this invoice
;
                      if                (LineVoucher - LineDiscount - LineWriteOff + DiscountAmtToApply > 0)     //Invoice - Current Discounts - Left to Apply)
                        calc               LineWriteoff = LineWriteOff + DiscountAmtToApply
                        move               LineWriteOff,WrkAmount
                        squeeze            WrkAmount,WrkAmount
..HR 2019.9.30                        LVDetails.SetItemText using *Text=WrkAmount,*Index=X,*SubItem=6
                        LVDetails.SetItemText using *Text=WrkAmount,*Index=X,*SubItem=5
                        LVDetails.SetItemText using *Text="CE",*Index=X,*SubItem=11
                      endif
                    REPEAT
                    call               CalcInvoiceTotals
                    SETMODE            *mcursor=*Arrow
                    RETURN
;==========================================================================================================
OnClickChangeAmounts
                    EventInfo          0,RESULT=Row                               //HR 4.19.2016
                    LVDetails.GetItemParam giving SeqNum using *Index=Row
                    LVDetails.GetItemText giving Memo using *Index=X,*SubItem=9
                    PACKKEY            ARTRNKY2,$Entity,SeqNum
                    CALL               RDARTRN2
                    IF                 (RETURNFL = 1)
                      ALERT              STOP,"ERROR:  Transaction has been deleted by another user",result,"ERROR"
                      RETURN
                    ENDIF

                    FORMLOAD           Cash2
                    setfocus           LVDetails
                    RETURN
.=============================================================================
LoadCheck2

                    LVDetails.GetItemCheck giving result using *Index=Row
                    if               (result = 0)
                      move             ARTRN.Balance,AmtToPay
                      LVDetails.SetItemCheck using *Index=Row,*Value=1               //HR 2019.10.30 Change to Checked
                    else
                      LVDetails.GetItemText giving WrkAmount using *Index=Row,*SubItem=2             //HR 4.25.2016 Changed from 7 to zero
                      squeeze                 WrkAmount,WrkAmount
                      move                    WrkAmount,AmtToPay
                    endif

                    setprop           EChk2Reference,text=ARTrn.Reference
                    setprop           NChk2Balance,value=ARTrn.Balance
                    setprop           NChk2DiscAmt,value=ARTrn.DiscAmt
                    setprop           NChk2NonDiscAmt,value=ARTrn.NonDiscAmt

                    unpack            ARTrn.TransDate INTO YYYY,MM,DD
                    pack              DATE10 FROM MM,"/",DD,"/",YYYY
                    setprop           EChk2TransDate,Text=DATE10

                    unpack            ARTrn.DueDate INTO YYYY,MM,DD
                    pack              DATE8 FROM MM,"/",DD,"/",YYYY
                    setprop           EChk2DueDate,Text=DATE10

                    unpack            ARTrn.DiscDate INTO YYYY,MM,DD
                    pack              DATE8 FROM MM,"/",DD,"/",YY
                    setprop           EChk2DiscDate,Text=DATE10

                    move              "  ",Memo

                    LVDetails.GetItemText giving WrkAmount using *Index=Row,*SubItem=5
                    squeeze                 WrkAmount,WrkAmount
                    move                    WrkAmount,AmtToDisc

                    LVDetails.GetItemText giving WrkAmount using *Index=Row,*SubItem=6
                    squeeze                 WrkAmount,WrkAmount
                    move                    WrkAmount,AmtToWriteOff

                    LVDetails.GetItemText giving Memo using *Index=Row,*SubItem=9

                    setprop           NChk2AmtToPay,value=AmtToPay
                    setprop           NChk2AmtToDisc,value=AmtToDisc
                    setprop           NChk2AmtToWriteOff,value=AmtToWriteOff
                    setprop           EMemo,text=Memo
                    setfocus          NChk2AmtToDisc
                    return
.=============================================================================
EnableReasonCode
              MOVE              "0",TestAmount
              GETPROP           NChk2AmtToWriteOff,value=TestAmount
..HR 2018.8.1              MOVE              TestAmountD,TestAmount
              IF                (TestAmount != 0)    //We need a Reason Code
                ENABLEITEM        EReason
                SETPROP           EReason,ReadOnly=0                   //Read Only mode = Off
                ENABLEITEM        BReason
                SETPROP           Ereason,BGCOLOR=$WINDOW
              ELSE
                DISABLEITEM       EReason
                DISABLEITEM       BReason
                SETPROP           EReason,ReadOnly=1
                SETPROP           EReason,BGCOLOR=$BTNFACE
              ENDIF
              RETURN
.=============================================================================
OnClickAcceptNewChanges
                    GetProp           NChk2AmtToPay,value=AmtToPay
                    GetProp           NChk2AmtToDisc,value=AmtToDisc
                    GETPROP           NChk2AmtToWriteOff,value=AmtToWriteOff
                    IF                (AmtToWriteOff != 0)
                      BEEP
                      ALERT             Plain,"Are you sure you wish to Write-Off this Amount?",result:
                                              "Approve Write-Off?"
                      RETURN            IF (result != 1)
                    ENDIF

                    MOVE               "  ",Memo
                    getprop            EMemo,text=Memo

                    move               AmtToDisc,WrkAmount
                    squeeze            WrkAmount,WrkAmount
                    LVDetails.SetItemText using *Index=Row,*SubItem=5,*Text=WrkAmount

                    move               AmtToWriteOff,WrkAmount
                    squeeze            WrkAmount,WrkAmount
                    LVDetails.SetItemText using *Index=Row,*SubItem=6,*Text=WrkAmount

                    move               AmtToPay,WrkAmount
                    squeeze            WrkAmount,WrkAmount
                    LVDetails.SetItemText using *Index=Row,*SubItem=2,*Text=WrkAmount          //HR 4.25.2016 Changed from 7 to zero

                    LVDetails.SetItemText using *Index=Row,*SubItem=9,*Text=Memo


                    Destroy            WCheck2
                    CALL               CalcInvoiceTotals
                    RETURN
.=============================================================================
OnClickManualCB
           RETURN
.=============================================================================
CheckSelectedAll
..HR 4.19.2016              eventinfo         0,ARG1=Row
              EventInfo         0,RESULT=Row                               //HR 4.19.2016

. Modified to resolve a bug where the Customer info was not being updated/chnaged
. if the Group To option was selected
.
              IF                (SearchMethod = 1 or SearchMethod = 2)   //HR 10/21/2003 Bug
..HR 4.4.2016                GetProp           CTView1,*ListColumnText(Row,1)=CustKY
                LVDetails.GetItemText giving CustKY using *Index=Row,*SubItem=10                //HR 4.25.2016 Changed from 0  //HR 4.20.2016   Was 1
                CALL              RDCust
                setprop           EChckCode,text=Cust.CustomerID
                setprop           EChckName,text=Cust.Name
                setprop           EChckAddr1,text=Cust.Addr1
                setprop           EChckAddr2,text=Cust.Addr2
                setprop           EChckAddr3,text=Cust.Addr3
                setprop           EChckCity,text=Cust.City
                setprop           EChckSt,text=Cust.St
                setprop           EChckZip,text=Cust.Zip
                setprop           EChckCountry,text=Cust.Country
                SETPROP           SCollection,visible=Cust.InActive     //HR 10/21/2003
                CANDISP           EChckCountry,CNTRY,STChckCountry,Name
                PACKKEY           CustDKY,$Entity,Cust.CustomerID
              ENDIF
              CALL              RDCustD
              IF                (Returnfl = 1)       //None exists, create one!!
                MOVE              "0.00",CustD.Balance
              ENDIF
              MOVE              CustD.Balance,DIM13
              setprop           ECustBalance,text=DIM13
              CALL              CalculateCustomerBalance
              RETURN
.=============================================================================
CalculateCustomerBalance                                                 //HR 9/9/2003
              MOVE              "0",CustBalance
..HR 4.4.2016              GETPROP           CTView1,*ListCount=TotalRows
              LVDetails.GetItemCount giving TotalRows
              FOR                X FROM "0" TO TotalRows USING "1"
..HR 4.4.2016                GETPROP           CTView1,*ListColumnText(X,1)=CustomerChk
                LVDetails.GetItemText giving CustomerChk using *Index=X,*SubItem=10         //HR 4.25.2016 Changed from 0    //HR 4.20.2016 Was 1
                IF                (Cust.CustomerID = CustomerChk)
..HR 4.4.2016                  GETPROP           CTView1,*ListColumnText(X,3)=BalanceAmt
                  LVDetails.GetItemText giving WrkAmount using *Index=X,*SubItem=2               //HR 4.20.2016 Was 3
                  squeeze                 WrkAmount,WrkAmount
                  move                    WrkAmount,BalanceAmt
                  ADD                     BalanceAmt,CustBalance
                ENDIF
              REPEAT
              MOVE              CustBalance,CustBalanceD
              setprop           ECustBalance,text=CustBalanceD

              RETURN
.=============================================================================
. Read the Customer History record for updating at the bottom
. of this routine.
.
UpdateCustomerHistory
                    packkey            CHSTKY,$Entity,ARTrn.CustomerID,ARDet.Year
                    call               RDCHST
                    if                 (ReturnFL = 1)
                      move               $Entity,CHST.Entity
                      move               ARTrn.CustomerID,CHST.CustomerID
                      move               ARDet.Year,CHST.Year
                      clear              CHST.PurchAmt
                      clear              CHST.PaidAmt
                      clear              CHST.PurchTotal
                      clear              CHST.PaidTotal
                      clear              CHST.DiscAmt
                      clear              CHST.LastPayDt
                      clear              CHST.LastPayAmt
..HR 2018.10.2                      subtract           ARDet.Amount,CHST.PaidAmt(ARDet.Month)
                      add                ARDet.Amount,CHST.PaidAmt(ARDet.Month)
                      add                "1",CHST.PaidTotal(ARDet.Month)
..HR 2018.10.2                      subtract           ARDet.DiscAmt,CHST.DiscAmt(ARDet.Month)
                      add                ARDet.DiscAmt,CHST.DiscAmt(ARDet.Month)
.
. Calculate the YTD totals
.
..HR 2018.10.2                      subtract          ARDet.Amount,CHST.PaidAmt(13)      //HR 10/14/2003
                      add               ARDet.Amount,CHST.PaidAmt(13)      //HR 10/14/2003
                      add               "1",CHST.PaidTotal(13)
..HR 2018.10.2                      subtract          ARDet.DiscAmt,CHST.DiscAmt(13)
                      add               ARDet.DiscAmt,CHST.DiscAmt(13)
.
                      move              ARDet.TransDate,CHST.LastPayDt
                      calc              CHST.LastPayAmt = ARDet.Amount-ARDet.DiscAmt
                      call              WRTCHST
                    else
..HR 2018.10.2                      subtract          ARDet.Amount,CHST.PaidAmt(ARDet.Month)
                      add               ARDet.Amount,CHST.PaidAmt(ARDet.Month)
                      add               "1",CHST.PaidTotal(ARDet.Month)
..HR 2018.10.2                      subtract          ARDet.DiscAmt,CHST.DiscAmt(ARDet.Month)
                      add               ARDet.DiscAmt,CHST.DiscAmt(ARDet.Month)
.
. Calculate the YTD totals
.
..HR 2018.10.2                      subtract          ARDet.Amount,CHST.PaidAmt(13)
                      add               ARDet.Amount,CHST.PaidAmt(13)
                      add               "1",CHST.PaidTotal(13)
..HR 2018.10.2                      subtract          ARDet.DiscAmt,CHST.DiscAmt(13)
                      add               ARDet.DiscAmt,CHST.DiscAmt(13)
.
                      if                (ARDet.TransDate > CHST.LastPayDt)
                        move              ARDet.TransDate,CHST.LastPayDt
                        calc              CHST.LastPayAmt = ARDet.Amount-ARDet.DiscAmt
                      endif
                      call              UPDCHST
                    endif
                    RETURN
............................................................................
.
CalculateNetAmount
              GETPROP           NChk2AmtToPay,value=AmtToPay
              GETPROP           NChk2AmtToDisc,value=AmtToDisc
              GETPROP           NChk2AmtToWriteOff,value=AmtToWriteOff
              SUBTRACT          AmtToDisc,AmtToPay,NetToReceive
              SUBTRACT          AmtToWriteOff,NetToReceive
              SETPROP           CNNetAmount,value=NetToReceive
              RETURN
............................................................................
.
ChangePaymentDesc
              GETITEM           CBPaymentType,0,result
              SWITCH            result
              CASE              "1"
                MOVE              "Check No.",PaymentDesc
              CASE              "2"
                MOVE              "Cash Ref. No.",PaymentDesc
              CASE              "3"
                MOVE              "Credit Card Ref. No.",PaymentDesc
              CASE              "4"
                MOVE              "Wire Transfer Ref. No.",PaymentDesc
              CASE              "5"
                MOVE              "Letter of Credit No.",PaymentDesc
              ENDSWITCH
              setprop           SReferenceNo,text=PaymentDesc
              RETURN

............................................................................
.
LoadCash2
              unpack            ARTrn.TransDate,CC,YY,MM,DD
              PACK              DATE82,MM,"/",DD,"/",YY
              SETPROP           EChk2TransDate,Text=DATE82
              SETPROP           NChk2Balance,value=ARTrn.Balance
              RETURN
.========================================================================
ReOpenInvoice
              FORMLOAD          Cash4
              RETURN
.========================================================================
OnClickReOpenInvoice
              getprop           EReOpenCustomerID,text=ARTrn.CustomerID
.
              getprop           EReOpenInvoice,text=ARTrn.Reference

..              MOVE              InvoiceKey,InvoiceKeyF                //HR 4/27/2005

...              MOVE              InvoiceKey,ARTrn.Reference      //HR 4/27/2005

              PACKKEY           ARTRNKY,$Entity,ARTrn.CustomerID,ARTrn.Reference        //HR 6/3/2005 +5 digit Invoice #
              CALL              RDARTRN
              IF                (Returnfl = 1)         //Record does not exist
                BEEP
                ALERT             note,"Invoice Number does not exist for this Customer",result,"Invalid Customer/Reference"
                RETURN
              ELSE
                ALERT             Type=4,"Do you wish to Re-Open this Invoice?",result
                IF                (result = 7)             //No..Do not re-open invoice
                  Destroy           WCheck4
                  RETURN
                ELSE
                  MOVE            "O",ARTrn.ClosedFlag
                  CALL            UPDARTRN
                  alert           type=4,"Invoice has now been Re-opened for processing. Do you wish me to add this to list of Open Transactions?",result
                  IF              (result = 6)
                    MOVE            ARTrn.Balance,AmtToPay
                    MOVE            ARTrn.DiscAmt,AmtToDisc
                    MOVE            "0",Clicked

                    UNPACK            ARTrn.DueDate INTO YYYY,MM,DD
                    PACK              DATE82 FROM MM,"/",DD,"/",YYYY

                    UNPACK            ARTrn.DiscDate INTO YYYY,MM,DD
                    PACK              DATE83 FROM MM,"/",DD,"/",YYYY
.
. 05/13/2003  After meeting with Tom, Carlene, add new fields P.O. & S.O.
. Number to ListView for processing.
.
                    parse             ARTrn.Reference,OldInvoiceNumberD using "09"
                    reset             ARTrn.Reference                        //HR 5/28/2003 testing
                    REPLACE           " 0",OldInvoiceNumberD
.                    PACKKEY           OAFL1KEY FROM ARTrn.CustomerID,"0",OldInvoiceNumberD

.                    CALL              OPARF1RD
.                    IF                over
.                      MOVE              "  ",OPARPONO
.                    ENDIF
.                    TRAPCLR           IO

             CALC             FreightTemp = ARTrn.OrigAmt - ARTrn.SalesAmt


              IF                (ARTrn.Balance != ARTrn.OrigAmt)          //HR 1/23/2009
                MOVE              "Yes",WrkDim3
              ELSE
                MOVE              " ",WrkDim3
              ENDIF

              PACK              DATALINE FROM AmtToPay,";":
                                              ARTrn.Reference,";":
                                              ARTrn.Balance,";":
                                              DATE82,";":
                                              DATE83,";":
                                              AmtToDisc,";":
                                              "0;":                     //Write-off Amt
..HR 4.25.2016                                             AmtToPay,";":
                                              WrkDim3,";":
                                              ARTrn.CustomerPO,";":
..                                              ARTrn.OrderNumber,";":
                                              FreightTemp,";":
                                              ARTrn.OrigAmt,";":
                                              ARTrn.InvCredit,";":
                                              ";":                                             //Memo Field HR 4.25.2016
                                              ARTrn.CustomerID


..HR 4.4.2016                    CTView1.AddItem   giving int2 using dataline
                    LVDetails.SetItemTextAll giving Int2 using *Index=99999,*Text=DataLine,*Delimiter=";",*Param=ARTrn.SeqMajor  //HR 4.4.2016
                    LVDetails.SetItemCheck using *Index=Int2,*Value=Clicked

..HR 4.4.2016                    SETPROP           CTView1,*ListColumnCheck(int2,8)=Clicked
.                    SETPROP           CTView1,*ListColumnCheck(int2,5)=ARTrn.HoldFlag
..HR 4.4.2016                    SETPROP           CTView1,*ListData(int2)=ARTrn.SeqMajor
                  ENDIF
                ENDIF
              ENDIF
              RETURN
.=============================================================================
OnClickCreateNonAR
              CLEAR             CancelFlag         //HR 1/8/2004
              FORMLOAD          Cash6
              RETURN

.=============================================================================
OnAcceptCreateNonAR
              getprop           ENonARAmount,text=NonARAmountD
              MOVE              NonARAmountD,NonARAmount
              IF                (NonARAmount = 0)
                BEEP
                ALERT             note,"Non A/R Amount has not been entered",result
                SETFOCUS          ENonARAmount
                RETURN
              ENDIF

              getprop           E6ChckCode,text=Reference
              IF                (Reference = " ")
                BEEP
                ALERT             note,"A Customer Reference must be entered",result
                SETFOCUS          E6ChckCode
                RETURN
              ENDIF

...FUCkUP              MOVE              "CHIRON",ARTrn.Entity
              MOVE              "      ",ARTrn.CustomerID
              MOVE              Reference,ARTrn.Reference

. By Entity, Customer, Reference (Invoice No)

              CLOCK             TIMESTAMP,ARTrn.EntryDate
              MOVE              "      ",ARTrn.DiscDate
              MOVE              "I",ARTrn.InvCredit
.
              MOVE              ARTrn.EntryDate,ARTrn.TransDate
              MOVE              ARTrn.EntryDate,ARTrn.BillDate
.
..HR 2018.10.2              MULTIPLY          "-1",NonARAmount

              MOVE              NonARAmount,ARTrn.OrigAmt
              MOVE              NonARAmount,ARTrn.Balance
              MOVE              "0",ARTrn.NonDiscAmt
              MOVE              "0",ARTrn.DiscPct
              MOVE              "0",ARTrn.DiscAmt
.
..HR 2018.9.4              FILEPI            3;ARSEQFL
..HR 2018.9.4              READ              ARSEQFL,ZEROSEQ;SEQMAJOR
..HR 2018.9.4              ADD               "1",SeqMajor
..HR 2018.9.4              WRITE             ARSEQFL,ZEROSEQ;SEQMAJOR

..HR 2018.9.4              MOVE              SeqMajor,ARTrn.SeqMajor
..              MOVE              "0",ARTrn.HoldFlag
              MOVE              "O",ARTrn.ClosedFlag

..Non A/R Transaction, Not required        CALL              WRTARTRN
.
. Write out the AR Detailed Transaction
.
              CLEAR             ARDet                          //HR 2/6/2009 to resolve issue with Disc Amounts
              MOVE              ARTrn.Reference,ARDet.Memo
              MOVE              ARTrn.Reference,ARDet.Reference
.
              MOVE              ARTrn.SeqMajor,ARDet.SeqMajor
              MOVE              "1",ARDet.SeqMinor
.
              MOVE              ARTrn.OrigAmt,ARDet.Amount

.
. Move Full Item records to Detail Transactional records
.
              MOVE              "0",ARDet.DiscAmt

              MOVE              "          ",ARDet.DiscDate
              MOVE              ARTrn.Entity,ARDet.Entity
              MOVE              ARTrn.SubEntity,ARDet.SubEntity
              MOVE              ARTrn.CustomerID,ARDet.CustomerID

              MOVE              ARTrn.ARAccount,ARDet.ARAccount
              MOVE              "5",ARDet.TransCode                //Payment Code
              MOVE              "                  ",ARDet.CustomerPO

              MOVE              ARTrn.TransDate,ARDet.TransDate
              MOVE              ARTrn.TransDate,ARDet.BillDate
              MOVE              ARTrn.TransDate,ARDet.EntryDate
              MOVE              ARTrn.TransDate,ARDet.PostDate
              unpack            ARDet.PostDate,ARDet.Year,ARDet.Month
              getitem           CBPaymentType,0,ARDet.TransSubCode
              getprop           EPaymentRef,text=ARDet.Reference
              getprop           EDepositID,text=ARDet.LockBoxID
              MOVE              "Y",ARDet.NonARFlag
.
. This record has now been added to the system...Now let's update the original
. Item.
.
              CALL              WRTARDET
              CALL              UpdateCustomerBalance

.
. Write out the Payment Journal record.  This is the same as the AR Detailed
. Transaction record except it will also include Non A/R
              MOVE              ARDet,PYMNTREC
              CALL              WRTPYMNT
...              NORETURN
              Destroy           Cash6
              CALL              MainReset
              RETURN
.=============================================================================
OnClickAcceptUnApplied
              MOVE              " ",ARDet.NonARFlag

              getprop           NChkVoucherTotals,value=UnAppliedAmt            //HR 2019.9.13
..HR 2019.7.25                setprop           NUnAppliedAmt,value=UnAppliedAmt

..HR 2019.9.13              getprop           NUnAppliedAmt,value=UnAppliedAmt

              IF                (UnAppliedAmt = 0)
                BEEP
                ALERT             note,"UnnApplied Amount has not been entered",result
                RETURN
              ENDIF

              getprop                  EPaymentRef,text=PaymentReference
              getprop                  EDepositID,text=DepositID
              clear                    ReasonCode
              getprop                  NPaymentAmt,value=CheckAmount

              CBPaymentType.GetCurSel  giving TransSubCode
              squeeze           PaymentReference,PaymentReference
              IF                (PaymentReference = "")
                PACK              AlertMsg FROM "Missing ",PaymentDesc,".  Enter ",PaymentDesc:
                                  " before Applying"
                ALERT             note,AlertMsg,result,"Missing Reference Number"
                SETFOCUS          EPaymentRef
                RETURN
              ENDIF

              beep
              ALERT             plain,"Are you sure you wish to create an Un-applied payment for the remaining amount? "::
                                      "This will record the payment without any invoice associated to it.",result
              return             if (result != 1)

..HR 2019.9.13              GETITEM           RSpecificCustomer,0,result
..HR 2019.9.13              IF                (result = 1)
..HR 2019.9.13                getprop           EUnAppliedCustomer,text=ARTrn.CustomerID
..HR 2019.9.13                READ              CUSTFL,ARTrn.CustomerID;;
..HR 2019.9.13                IF                (over)
..HR 2019.9.13                  BEEP
..HR 2019.9.13                  ALERT             stop,"Invalid Customer ID",result,"ERROR"
..HR 2019.9.13                  SETFOCUS           EUnAppliedCustomer
..HR 2019.9.13                  RETURN
..HR 2019.9.13                ENDIF
                PACK              Reference,"UnApplied"
..HR 2019.9.13              ELSE
..HR 2019.9.13                MOVE              " 14486",ARTrn.CustomerID
..HR 2019.9.13                getprop           E3ChckCode,text=Reference
..HR 2019.9.13                IF                (Reference = " ")
..HR 2019.9.13                  BEEP
..HR 2019.9.13                  ALERT             note,"A Customer Reference must be entered",result
..HR 2019.9.13                  SETFOCUS          E3ChckCode
..HR 2019.9.13                  RETURN
..HR 2019.9.13                ENDIF
..HR 2019.9.13              ENDIF

                   move              Cust.CustomerID,ARTrn.CustomerID      //HR 2019.9.13

..FUCKUP              MOVE              "CHIRON",ARTrn.Entity
              MOVE              Reference,ARTrn.Reference

. By Entity, Customer, Reference (Invoice No)
              getprop                  EPaymentRef,text=PaymentReference

.
. Clear out the ARDetail record before we start doing anything..."Might" be some
. older information that's left over from previous records.
. HR 4/14/2004
.
              CLEAR             ARDet

              CLOCK             TIMESTAMP,ARTrn.EntryDate
              MOVE              ARTrn.EntryDate,ARTrn.TransDate
              MOVE              ARTrn.EntryDate,ARTrn.BillDate

              MOVE              "      ",ARTrn.DiscDate
              MOVE              "I",ARTrn.InvCredit
.
              MOVE                " ",ARTrn.CustomerPO
              MOVE              " ",ARTrn.Memo
              MOVE              " ",ARTrn.OrderNumber
              MOVE              "0",ARTrn.SalesAmt

..HR 2019.9.13              GETPROP           EUnappliedLotNumber,text=ARTrn.OrderNumber      //HR 9/25/2008
.
..HR 2018.10.2              MULTIPLY          "-1",UnAppliedAmt

              MOVE              "0",ARTrn.OrigAmt
              MOVE              UnAppliedAmt,ARTrn.Balance
              MOVE              "0",ARTrn.NonDiscAmt
              MOVE              "0",ARTrn.DiscPct
              MOVE              "0",ARTrn.DiscAmt
              MOVE              "0",ARDet.DiscAmt
.
..HR 2018.9.4              FILEPI            3;ARSEQFL
..HR 2018.9.4              READ              ARSEQFL,ZEROSEQ;SEQMAJOR
..HR 2018.9.4              ADD               "1",SeqMajor
..HR 2018.9.4              WRITE             ARSEQFL,ZEROSEQ;SEQMAJOR



              transaction        Start,SequenceFLST,ARDetFLST,ARTRNFlst,PymntFLST,ARDepFLST:
                                       CustDFLST,CHSTFLST,ARDistFLST,BatchChecksFLST

              GetNextSeq         ARTRN                                 //HR 2019.9.13
              move               Sequence.SeqNo,ARTrn.SeqMajor         //HR 2019.9.13

..HR 2019.9.16 WTF??              MOVE              SeqMajor,ARTrn.SeqMajor
..              MOVE              "0",ARTrn.HoldFlag
              MOVE              "O",ARTrn.ClosedFlag
.
              clock              TimeStamp,Date8
              move               Date8,ARDet.LockBoxID
..HR 2019.9.13              getprop           EDepositID,text=ARDet.LockBoxID

              CALL              WRTARTRN
.
. Write out the AR Detailed Transaction
.
              MOVE              ARTrn.Reference,ARDet.Memo
              MOVE              ARTrn.Reference,ARDet.Reference
.
              MOVE              ARTrn.SeqMajor,ARDet.SeqMajor
              MOVE              "1",ARDet.SeqMinor
.
..DICK!!! Stupid Me...Move it below and it S/B Unapplied Amt     MOVE              ARTrn.OrigAmt,ARDet.Amount
              MOVE              UnAppliedAmt,ARDet.Amount     //HR 9/17/2003

.
. Move Full Item records to Detail Transactional records
.
              MOVE              "          ",ARDet.DiscDate
              MOVE              ARTrn.Entity,ARDet.Entity
              MOVE              ARTrn.SubEntity,ARDet.SubEntity
              MOVE              ARTrn.CustomerID,ARDet.CustomerID

              MOVE              ARTrn.ARAccount,ARDet.ARAccount
              MOVE              "5",ARDet.TransCode                //Payment Code
              MOVE              "                  ",ARDet.CustomerPO

              MOVE              ARTrn.TransDate,ARDet.TransDate
              MOVE              ARTrn.TransDate,ARDet.BillDate
              MOVE              ARTrn.TransDate,ARDet.EntryDate
              MOVE              ARTrn.TransDate,ARDet.PostDate
              unpack            ARDet.PostDate,ARDet.Year,ARDet.Month
              GETITEM           CBPaymentType,0,ARDet.TransSubCode

              move              PaymentReference,ARDet.Reference
.
. This record has now been added to the system...Now let's update the original
. Item.
.
              CALL              UpdateCustomerHistory         //HR 8/28/2009 Modified to properly update Unapplied Entries!!

              CALL              WRTARDET
              CALL              UpdateCustomerBalance
.
. Write out the Payment Journal record.  This is the same as the AR Detailed
. Transaction record except it will also include Non A/R
              MOVE              ARDet,PYMNTREC
              CALL              WRTPYMNT

..              NORETURN
..HR 2019.9.13              SETPROP           Cash3,visible=0
;
; Record General Ledger Information
;
                      clear              ARDist
                      move               ARTrn.Entity,ARDist.Entity
                      move               ARTrn.SubEntity,ARDist.SubEntity
                      move               ARDet.TransDate,ARDist.TransDate
                      move               ARTrn.CustomerID,ARDist.CustomerID
                      move               ARDet.Year,ARDist.Year
                      move               ARDet.Month,ARDist.Month

                      move               Default.ARAcct,ARDist.GLCode
                      move               "0",ARDist.PostedToGL
                      move               ARDet.SeqMajor,ARDist.Voucher
                      move               ARDet.TransCode,ARDist.TransCode
                      move               ARDet.Reference,ARDist.CheckNo
                      move               ARDet.SeqMinor,ARDist.SeqMinor
                      GetNextSeq         ARDist
                      move               Sequence.SeqNo,ARDist.SeqMajor
;
; Write out the A/R Amount
;
                      move               UnAppliedAmt,ARDist.DebitAmount
                      clear              ARDist.CreditAmount
                      call               WrtARDist
;
; Get the next sequence number
;
                      GetNextSeq         ARDist
                      move               Sequence.SeqNo,ARDist.SeqMajor
;
; Write out the Cash Amount
;
                      move               "80100",ARDist.GLCode
                      move               ARDet.Amount,ARDist.CreditAmount
                      clear              ARDist.DebitAmount
                      call               WrtARDist
;
; Create Check Information for Batch Controls
;
                    if                 (CheckAmount != 0)           //No need to writeout a Batch Check record   2019.9.24
                      clear              BatchChecks
                      move               $Entity,BatchChecks.Entity
                      clock              TimeStamp,BatchChecks.CheckDate
                      move               Cust.CustomerID,BatchChecks.CustomerID
                      move               PaymentReference,BatchChecks.CheckNo
                      GetNextSeq         BatChk
                      move               Sequence.SeqNo,BatchChecks.SeqNo
                      move               UnAppliedAmt,BatchChecks.Amount
                      move               TransSubCode,BatchChecks.Type
                      call               WrtBatchChecks
                    endif

                    transaction        Commit
                    call               MainReset

                BEEP                                                                       //HR 2019.9.13
                ALERT             note,"UnnApplied Amount has been entered",result     //HR 2019.9.13
                call                 MainReset
              RETURN
.=============================================================================
CheckUnAppliedCustomer
              GETITEM           RSpecificCustomer,0,result
              IF                (result = 1)
                ENABLEITEM        EUnAppliedCustomer
                SETPROP           EUnAppliedCustomer,BGColor=$BTNFACE,Enabled=0
..HR 2018.10.2                DISABLEITEM       E3ChckCode
                SETPROP           EUnAppliedCustomer,BGColor=$Window,Enabled=0
              ELSE
                ENABLEITEM        E3ChckCode
                SETPROP           EUnAppliedCustomer,BGColor=$Window
..HR 2018.10.2                DISABLEITEM       EUnAppliedCustomer
                SETPROP           EUnAppliedCustomer,BGColor=$BTNFACE,enabled=0
              ENDIF
              RETURN
.=============================================================================
PrintStatement
              getprop           EChckCode,text=FromCustomer
              MOVE              "         ",UseStamps
              setprop           EStampCodes,text=UseStamps
              SETFOCUS          EStampCodes
              SETPROP           WStamps,visible=1
              GETITEM           EStampCodes,0,UseStamps
              CALL              PrintStatemnt using FromCustomer,FromCustomer,RunType,UseStamps

              RETURN
.=============================================================================
PrintPaymentReport
              getprop           EChckCode,text=FromCustomer
              CALL              PrintStatemnt using FromCustomer,FromCustomer
              RETURN
.=============================================================================
UpdateCustomerBalance
              PACKKEY           CustDKY FROM ARTrn.Entity,ARTrn.CustomerID
              CALL              RDCustD
              IF                (Returnfl = 1)       //None exists, create one!!
                MOVE              ARDet.Entity,CustD.Entity
                MOVE              ARDet.CustomerID,CustD.CustomerID
                MOVE              ARDet.TransDate,CustD.LastPayDt
..HR 2018.10.2                multiply          "-1",ARDet.Amount,CustD.LastPayAmt
                move              ARDet.Amount,CustD.LastPayAmt

..HR 2018.8.1                MOVE              ARDet.Amount,CustD.Balance
..HR 2018.8.1                MULTIPLY          "-1",ARDet.Amount,CustD.Balance          //HR 10/12/2003
                MOVE              ARDet.Reference,CustD.LastCheck
                MOVE              "  ",CustD.LastInvoiceDt
                MOVE              "  ",CustD.LastInvoice
                MOVE              "0",CustD.LastInvoiceAmt
                CALL              WRTCUSTD
              ELSE
                SUBTRACT          ARDet.Amount,CustD.Balance
                IF                (ARDet.TransDate >= CustD.LastPayDt and ARDet.TransCode = 5)
                  MOVE              ARDet.TransDate,CustD.LastPayDt
..HR 2018.10.2                  multiply          "-1",ARDet.Amount,CustD.LastPayAmt
                  move              ARDet.Amount,CustD.LastPayAmt
                  MOVE              ARDet.Reference,CustD.LastCheck
                ENDIF
                CALL              UPDCustD
              ENDIF
              RETURN
.=============================================================================
ReprintInvoices
#Document     FORM              10
DocumentD     DIM               12
..HR 4.4.2016              GETPROP           CTView1,*ListCount=TotalRows
              MOVE              FirstRow,StartingRow                           //HR 4.4.2016
..HR 4.4.2016 Not Required              LVDetails.GetItemCount giving TotalRows
..HR 4.4.2016              FOR                X FROM "0" TO TotalRows USING "1"
..HR 4.4.2016                GETPROP           CTView1,*ListSelect(X)=RES2   fuckup
              LOOP
                LVDetails.GetNextItem giving RES2 using *Flags=2,*Start=StartingRow
              UNTIL             (RES2 = -1)
                LVDetails.GetItemParam giving SeqNum using RES2
                MOVE              RES2,StartingRow
..HR 4.4.2016                IF                (RES2= -1)
..HR 4.4.2016                GETPROP           CTView1,*ListData(X)=SeqNum
                PACKKEY           ARTRNKY2,$Entity,SeqNum
                CALL              RDARTRN2
                MOVE              ARTrn.Reference,DocumentD
                chop              DocumentD
                MOVE              DocumentD,#Document

                CALL              PrintInvoice using ARTrn.Reference,ARTrn.OrderNumber if (ARTrn.InvCredit = "I":
                                                                                             and #Document < 100000)

                CALLS             "InvEntry;PrintInvoicesLoadMod" using #Document if (ARTrn.InvCredit = "C" or #Document > 100000)

              REPEAT

              RETURN

.=============================================================================
CustomerInquiryProgram
              CALL              CustInquiry
              RETURN
.=============================================================================
ViewComments2
              CALL                  CommentInq using Cust.CustomerID
              RETURN
.=============================================================================
GetSelectionMethod
                    CBSearchBy.GetCurSel giving SearchMethod

..HR 2018.07.25              GETITEM           CKSelectAll,0,CBValue
              IF                (CBValue = 1)
..HR 2018.7.27                MOVE              "1",SearchMethod         //By All Invoices
..HR 2018.7.27                SETITEM           SSelection,0,"Customer ID"
              ENDIF
.
..HR 2018.07.25              GETITEM           RCustomer,0,CBValue
              IF                (CBValue = 1)
..HR 2018.7.27                MOVE              "0",SearchMethod         //By Specific Customer
..HR 2018.7.27                SETITEM           SSelection,0,"Customer ID"
              ENDIF

..HR 2018.07.25              GETITEM           RGroupTo,0,CBValue
              IF                (CBValue = 1)
..HR 2018.7.27                MOVE              "2",SearchMethod         //By Grouped Customer
..HR 2018.7.27                SETITEM           SSelection,0,"Group To ID"
              ENDIF

..HR 2018.07.25              GETITEM           RInvoice,0,CBValue
              IF                (CBValue = 1)
..HR 2018.7.27                MOVE              "3",SearchMethod         //By Grouped Customer
..HR 2018.7.27                SETITEM           SSelection,0,"Invoice ##"
              ENDIF

              RETURN
;==========================================================================================================
SortColumn

              EventInfo         0,Result=SortColumn

              MOVE              FirstRow,StartingRow

              LVDetails.GetNextItem giving SelectedRow using *Flags=2,*Start=StartingRow
              LVDetails.GetItemParam giving ItemParam using *Index=SelectedRow

              IF                (((SortHeader(SortColumn) / 2) * 2) = SortHeader(SortColumn))
                SUBTRACT        "1",SortHeader(SortColumn)
              ELSE
                ADD             "1",SortHeader(SortColumn)
              ENDIF

              SWITCH            SortHeader(SortColumn)

              CASE              5
                MOVE              "MM/DD/YYYY",SortMask
              CASE              6
                MOVE              "MM/DD/YYYY",SortMask
              DEFAULT
                MOVE              "",SortMask
              ENDSWITCH

              LVDetails.SortColumn using *Column=SortColumn,*Type=SortHeader(SortColumn),*Mask=SortMask
              LVDetails.FindItem giving SelectedRow using *Start=StartingRow,*Param=ItemParam
              LVDetails.EnsureVisible using *Index=SelectedRow,*Partial=0
              LVDetails.SetItemState using *Index=SelectedRow,*State=03,*StateMask=03
              RETURN
;==========================================================================================================
OnClickSearchBy
                    return
;==========================================================================================================
KeyPressCust
                    F2Search           EChckCode,Cust
                    return
;==========================================================================================================
KeyPressCheckBoxType
                    EVENTINFO         0,RESULT=result
                    if                          (result = 13)
                    setfocus           EPaymentRef
                    endif
                    return





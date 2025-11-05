;=============================================================================;
;       created by:  chiron software & services, inc.                         ;
;                    4 norfolk lane                                           ;
;                    bethpage, ny  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  program:    LedgerCard.pls                                                 ;
;                                                                             ;
;   author:    harry rathsam                                                  ;
;                                                                             ;
;     date:    10/23/2019 at 2:58pm                                           ;
;                                                                             ;
;  purpose:                                                                   ;
;                                                                             ;
; revision:    ver     date     init       details                            ;
;                                                                             ;
;              1.0   10/23/2019   hor     initial version                     ;
;                                                                             ;
;                                                                             ;
;=============================================================================;
; Check Number and Paid on same line  Paid (Completed/Partial
;
                    include            NCommon.txt
                   INCLUDE           WORKVAR.INC
#RESULT            FORM              1
NodeNum            FORM              6
#Document          form              9
                   INCLUDE           Cust.FD

CustBalance   FORM              10.2
CustBalanceD  DIM               13

WrkAmt1            dim               15
WrkAmt2            dim               15
WrkAmt3            dim               15

UseStamps     DIM               10

InvType       dim               30
CustomerIDSave dim                     10
X          integer           1
ChildNum   FORM              6
SeqNum     FORM              7
DataLine2           dim                200
int2       FORM              4
MonthName  DIM               10
CurrentYear DIM                 4
SelectedYear DIM                4
DueDate10     DIM               10
TransDate10   DIM               10
ViewByOption  FORM              2
TransAmt      dim               12(3)
Dim10         dim               10
SearchBy      FORM              1
InvoiceKey    DIM               10
InvoiceKeyF   FORM              10
Invoice5      FORM              5
OldInvoiceNumber FORM           5
OldInvoiceNumber10 FORM         10
OldInvoiceNumberD DIM           5
BalanceD      DIM               12
OrigAmtD      DIM               12
RangeToDate   DIM               8
TotalRows     FORM              8
MemoField     DIM               40
FreightAmt    FORM              4.2
PaymentType   DIM               17
FromCustomer  DIM               10
DIM13         DIM               13
Days       FORM              10
RES2          FORM              2
IOSW     DIM       1       I/O INDICATOR
RecordKey          dim               20

#RES1      FORM              1
#DIM1      DIM               1
#DIM2      DIM               2
#RES2      FORM              2
#LEN1      FORM              3
#MenuObj   Automation
#MenuItem  DIM               25


                   GOTO              STARTPGM

                   include           Sequence.FD

                   include           Parts.FD
                   include           CustD.FD
                   INCLUDE           ARTRM.FD
                   INCLUDE           CMPNY.FD
                   INCLUDE           CHST.FD
                   INCLUDE           GLMAST.FD
                   include           BatchChecks.FD
                   include           BatchDetails.FD
                   INCLUDE           CLASS.FD
                   INCLUDE           TYPE.FD
                   INCLUDE           CNTRY.FD
                   INCLUDE           STATE.FD
                   INCLUDE           ARTRN.FD
                   INCLUDE           ARDET.FD
                   include           CreditCards.FD
                   include           Invoices.FD
                   include           PrintRtn.INC

WindowsCOl         COLLECTION
CloseColl          collection

MAIN               PLFORM            FullCard.PLF
ToolBars           PLFORM            DataMenu.PLF


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
             PACK              EnvData,EnvData,CustHelp
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
                   CALL              OPENCustD
                   call               OpenSequence

                   CALL              OPENCust
                   CALL              OPENARTRM
                   CALL              OPENARTRNRO
                   CALL              OPENARDETRO
                   CALL              OPENCNTRY
                   call              OpenBatchChecks
                   call              OpenCreditCards
                   call              OpenBatchDetails
                   CLOCK             TIMESTAMP,CurrentYear

CustColl   COLLECTION
CustEdt    COLLECTION
CustBoxes  COLLECTION
CustStat   COLLECTION

..HR 2017.12.28           LISTINS           WindowsCOL,CINQ1,CINQ2


              LISTINS           CustStat,STCustCountry
              LISTINS           CustCOLL,ECustCode,ECustName,ECustAddr1,ECustAddr2,ECustAddr3:
                                        ECustCity,ECustSt,ECustZip,ECustCountry:
                                        ECustPhone,ECustFax
.
              LISTINS           CustEDT,ECustCode,ECustName,ECustAddr1,ECustAddr2,ECustAddr3:
                                       ECustCity,ECustSt,ECustZip,ECustCountry:
                                       ECustPhone,ECustFax
.
              LISTINS           CustBOXES,CBCustActive

              INCLUDE           Temporary.inc
.           winhide

                    MOVE              "1",SortHeader             //HR 4.20.2016


                    MOVE              "12",SortHeader(4)
                    MOVE              "3",SortHeader(4)
                    MOVE              "3",SortHeader(5)
                    MOVE              "5",SortHeader(6)

              FORMLOAD          MAIN
              FORMLOAD          ToolBars,WMain

              setprop           MenuToolBar.Buttons("ID_New"),visible=0
              setprop           MenuToolBar.Buttons("ID_Change"),visible=0
              setprop           MenuToolBar.Buttons("ID_Delete"),visible=0

              MenuDatabase.RemoveItem using *Key="MNewRecord"
              MenuDatabase.RemoveItem using *Key="MModifyRecord"
              MenuDatabase.RemoveItem using *Key="MDeleteRecord"
              MenuDatabase.RemoveItem using *Key="MSaveRecord"

              setprop           MenuToolBar.Buttons("ID_Cancel"),visible=0
              setprop           MenuToolBar.Buttons("ID_Save"),visible=0
              setprop           MenuToolBar.Buttons("TBRecDivide"),visible=0

              setprop           MenuToolBar.Buttons("TBRecDivide2"),visible=1
              setprop           MenuToolBar.Buttons("ID_Comments"),visible=1
              setprop           MenuToolBar.Buttons("ID_Statements"),visible=1
              setprop           MenuToolBar.Buttons("ID_Reprint_Invoices"),visible=1


..HR 2017.12.28           FORMLOAD          CINQ1,WMain
..HR 2017.12.28           FORMLOAD          CINQ2,WMain
..HR 2017.12.28           FORMLOAD          CINQ3,WMain
.           FORMLOAD           StatusWin,WMain

..HR 2017.12.28           DEACTIVATE        CINQ2
..HR 2017.12.28           DEACTIVATE        CINQ3
..HR 2017.12.28           SETPROP           CINQ1,visible=1


                   clock             TimeStamp,Date8
                   CALL              ConvDateToDays using Date8,TodayDays
                   subtract          "730",TodayDays
                   CALL              ConvDaysToDate using TodayDays,Date8
                   setprop           DTPrintFrom,text=Date8

                   LOOP
                     WAITEVENT
                   REPEAT
.
. We never get here!!   Just in case though.... :-)
.
           RETURN
.           STOP

BROWSEFILE ROUTINE
SEARCH     PLFORM            SEARCH3.PLF
           FORMLOAD          SEARCH

INITSRCH
           PACK              SearchTitle,CustTitle," Search Window"
           SETPROP           WSearch,*Title=SearchTitle



           CTADDCOL          "Customer ID",75,"Customer Name",125:
                             "Address",100:
                             "City",100:
                             "State",40:
                             "Zip",60:
                             "Country",50

.
. Routines that operate the Main program
.
.=============================================================================
LoadSearchWindow
              GETITEM           ESearchName,0,CustKY2

              SETMODE           *mcursor=*wait

              COUNT             result,CustKY2
              IF                (result = 0)
                SETMODE           *mcursor=*Arrow
                setprop                BSearchSearch,default=1
                setfocus                 ESearchName

                RETURN
              ENDIF

              clear             SearchCounter
              Uppercase         CustKY2
              LVSearchPLB.DeleteAllItems
              CALL              RDCust2
              LOOP
                CALL              KSCust2
              UNTIL             (ReturnFl = 1)
                uppercase         Cust.Name
                MATCH             CustKY2,Cust.Name
                IF                not equal
                  SETMODE           *mcursor=*Arrow
                  BREAK
                ENDIF
                incr              SearchCounter
                CTLoadRecord2     Cust2,Cust,Cust.CustomerID,Cust.CustomerID,Cust.Name:
                                  Cust.Addr1,Cust.City,Cust.St
              REPEAT
              SETMODE           *mcursor=*Arrow
              if                (SearchCounter = 0)
                beep
                alert                    stop,"No Custs Found that match the Search Criteria",result,"NO CustS FOUND"
                ESearchName.SelectAll
                ESearchName.Clear
                setprop                BSearchSearch,default=1
                setfocus                 ESearchName
              else
                LVSearchPLB.SetItemState using *Index=0,*State=03,*StateMask=03
                setprop                BSearchSelect,default=1
                setfocus               LVSearchPLB
              endif
              RETURN
;==========================================================================================================
ItemSelected
                      LVSearchPLB.GetNextItem giving RowSelected using *Flags=02,*Start=FirstRow
                    if                 (RowSelected != -1)
                      LVSearchPLB.GetItemText giving $SearchKey using *Index=RowSelected,*SubItem=0
                      MOVE               "Y",PassedVar
                      DESTROY            WSearch
                    endif
                    RETURN
;==========================================================================================================
MaintMenuOption
              CALL                 GetMenuName
              RETURN
;==========================================================================================================
Change_ECustCode
              READAHEAD         ECustCode,Cust,CustomerID
              return
;==========================================================================================================
KeyPress_ECustCode
              F2SEARCH          ECustCode,Cust
.              debug
              IF                 (PassedVar = "Y")
.              CALL               MainValid
              ENDIF
              RETURN
;==========================================================================================================
MainValid
             GETCOUNT          ECustCODE
             IF                (CharCount > 0)
               RESETVAR          CustKY
               GETITEM           ECustCODE,0,CustKY
               setlptr           CustKY,10

                CALL              RDCust
               IF               (RETURNFL = 1)
                 PARAMTEXT        CustTITLE,CustKY,"",""
                 ALERT            CAUTION,"^0: ^1 Not Found",#RES2,"Record does not exist"
                 CALL             MAINRESET
                 RETURN
               ENDIF
               CALL              SETMAIN
.
. HR 8/5/2003
.
           unpack            DATE8,CC,YY,MM,DD

           MOVE              "3",Status                   .We've found a record
               ENABLETOOL        ID_Change
               ENABLETOOL        ID_Delete
               DISABLEITEM       Fill1
             ENDIF
.           ENDIF
           setfocus                  LVTransactions
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
           SETPROP           CustEDT,SELECTALL=$SelectAll
.
           CALL              MAINRESET

           CLOCK             TIMESTAMP,Date8

           RETURN
.=============================================================================
. New Button is pressed
.
MAINNEW
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
           GETCOUNT          ECustCODE
           IF                (Charcount > 0)
             GETITEM           ECustCODE,0,CustKY      //Read the Primary field ito the Key

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
             ENABLEITEM        CustCOLL
             ENABLEITEM        CustStat
             DISABLEITEM       Fill1
             %IFDEF            CBCustActive
             ENABLEITEM        CBCustActive
             %ENDIF
.
             SETPROP           CustCOLL,READONLY=0
             SETPROP           CustCOLL,BGCOLOR=$WINDOW
.
. OK, OK...What do we do with any ActiveX components. We've got to handle
. them as well.  Let's change these to Non Read-Only and change the
. Background colors as well
.
               ENABLEITEM      CustBoxes

.
. Change the Cancel button button to 'Save' and the 'Exit' button to Cancel
.
.INQ             SETITEM           BMainCancel,0,CancelTitle
             ENABLETOOL        ID_Cancel

.INQ             SETITEM           BMainCHANGE,0,SaveTitle
             ENABLETOOL        ID_Save
.
             ENABLETOOL        ID_Undo
             DISABLETOOL       ID_Change
.
             DISABLETOOL       ID_New
.INQ             DISABLEITEM       BMainNew
.
             SETFOCUS          ECustName               //Set the cursor to the next field
.             DISABLEITEM       ECustCODE               //and Disable the Primary Code
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
             CALL              RDCustLK
             CALL              SetMain
           ENDIF
           RETURN
.=============================================================================
MainFind
...HR            FindSearch        ECustCode            //07/07/2003
           FindSearch        ECustCode,Cust

           IF                (PassedVar = "Y")
             GETITEM           ECustCode,0,CustKY
             MOVE              $SearchKey,CustKY
             CALL              RDCust
.
. We've got a record thanks to our Trusy Search/Browse window. Let's
. continue now by setting up the proper Code field and calling the
. MainValid subroutine, that will take care of it for us.
.
             MOVE              "0",Status
             SETITEM           ECustCode,0,Cust.CustomerID
             CALL              MainValid
           ENDIF
           RETURN
.=============================================================================
. Routine to read the First record and display it
.
MainFirst
           CLEAR             CustKY
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
           SETITEM           ECustCode,0,Cust.CustomerID
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
           SETITEM           ECustCode,0,Cust.CustomerID
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
           GETCOUNT          ECustCode
           IF                (CharCount <> 0)
             GETITEM           ECustCode,0,CustKY

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
           SETITEM           ECustCode,0,Cust.CustomerID
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
           GETCOUNT          ECustCode
           IF                (CharCount <> 0)
             GETITEM           ECustCode,0,CustKY

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
           SETITEM           ECustCode,0,Cust.CustomerID
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
           LVTransactions.DeleteAllItems

           MOVE              "0",Status     //Reset the status to Not updating
           UNLOCK            CustFL
.
. Reset the fields to 'Blank' and DISABLE all of those fields as well
           DELETEITEM        CustCOLL,0
           DELETEITEM        CustStat,0
           SETITEM           CBCustActive,0,0
           DISABLEITEM       CBCustActive

           DISABLEITEM       CustCOLL
           DisableItem       CustStat
           SETPROP           CustCOLL,READONLY=1
           SETPROP           CustCOLL,BGCOLOR=$BTNFACE
           SETPROP           CustStat,BGCOLOR=$BTNFACE
           ENABLEITEM        Fill1
                   setprop           NBalance,value=0
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
. Enable & Disable the proper Menu options
.
.X           ENABLEITEM        FileMenu,1
.X           ENABLEITEM        ChangeMenu,1
.X           DISABLEITEM       ChangeMenu,2
.X           DISABLEITEM       ChangeMenu,3
.X           DISABLEITEM       ChangeMenu,4
.
. Setup any ActiveX control fields to what they should be
.
.           SETPROP           ECustDiscPerc,*Text="0"
.           SETPROP           ECustDiscPerc,*Enabled=0
.           SETPROP           ECustDiscPerc,*BackColor=$BTNFACE
.
. Setup the Primary field that is used for Entry purposes
.
           %IFDEF            CBCustActive
           SETITEM           CBCustActive,0,0
           DISABLEITEM       CBCustActive
           %ENDIF

           SETPROP           ECustCODE,READONLY=0
           SETPROP           ECustCode,BGCOLOR=$WINDOW
           ENABLEITEM        ECustCODE

           setprop         EComments,text="",static=1,BGColor=$BtnFace

           SETFOCUS          ECustCODE
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
ModifyFlag         form              1

           debug
           getprop           EComments,ModifyFlag=ModifyFlag
           if                (ModifyFlag = 1)
             transaction       start,CustFLST
             call              TSTCust
             getprop           EComments,text=Cust.Memo
             call              UPDCust
             transaction       commit
             setprop           EComments,ModifyFlag=0
           endif

           IF                (Status = 0)      . They want to exit the program
             DESTROY         WMAIN             . Get rid of the Main Window
              winshow
              if                (Frompgm != "")
                CHAIN             FROMPGM
              else
                stop
              endif
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
           RETURN
.=============================================================================
.
. Setup all of the fields in the Form based upon the data record
SETMAIN
           SETITEM           ECustCode,0,Cust.CustomerID
SETMAIN2
           SETITEM           ECustName,0,Cust.NAME
           SETITEM           ECustAddr1,0,Cust.Addr1
           SETITEM           ECustAddr2,0,Cust.Addr2
           SETITEM           ECustAddr3,0,Cust.Addr3
           SETITEM           ECustCity,0,Cust.City
           SETITEM           ECustSt,0,Cust.St
           SETITEM           ECustZip,0,Cust.Zip
           SETITEM           ECustCountry,0,Cust.Country
           SETPROP           ECustPhone,Text=Cust.Telephone
           SETPROP           ECustFax,Text=Cust.Fax
           SETITEM           CBCustActive,0,Cust.InActive
           CANDISP           ECustCountry,CNTRY,STCustCountry,Name


           chop            Cust.ShippingAcct(1),Cust.ShippingAcct(1)
           chop            Cust.ShippingAcct(2),Cust.ShippingAcct(2)
           setprop         EShippingAcct,text=Cust.ShippingAcct(2)
           setprop         EFedexAcct,text=Cust.ShippingAcct(1)
           setprop         EComments,text=Cust.Memo,static=0,BGColor=$Window
           debug
           call              LoadTransactions
           RETURN
.=============================================================================
. Retrieve all of the fields in the Form based upon the data record
.
GETMAIN
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
                   getmode           *ProgName=ProgramName
                   getmode           *ProgStamp=ProgramStamp
                   getmode           *ProgVer=ProgramVer

                   CALL              About using ProgramName,ProgramStamp,ProgramVer
                   SETFOCUS          WMain
                   RETURN
;==========================================================================================================
. Print Report option
.
.MainPrint
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
.=============================================================================
OnDoubleClickTransaction
              RETURN

.=============================================================================
.
OnExpandCINQTree
              LVTransactions.GetItemText giving ARTrn.Reference using *Index=int2,*SubItem=1
              LVTransactions.GetItemText giving OrigAmtD using *Index=int2,*SubItem=3
              LVTransactions.GetItemText giving BalanceD using *Index=int2,*SubItem=4
              LVTransactions.GetItemText giving Date10 using *Index=int2,*SubItem=5

           PACKKEY           ARDETKY,$Entity,SeqNum,"   "
              SETLPTR             ARDETky
           CALL              RDARDET
..HR 7/28/2003           SETPROP           CINQTree,*NodeSelect(NodeNum)=1
           LOOP
             CALL              KSARDET
           UNTIL             (RETURNFL = 1 OR SeqNum <> ARDet.SeqMajor)            CC YY MM DD
             UNPACK            ARDet.TransDate,CC,YY,MM,DD                         20 04 06 13
             PACK              TransDate10,MM,"-",DD,"-",YY                           06/13/04

             UNPACK            ARTrn.DueDate,CC,YY,MM,DD
             PACK              DueDate10,MM,"-",DD,"-",YY

             IF                (ARDet.TransCode = 1)
             PACK              DATALINE FROM "Inv: ;",ARDet.Reference,";":
                                                     ARDet.Amount,";":
                                                     DueDate10,";",TransDate10,";":
                                                     ARDet.Memo
             ENDIF
             IF                (ARDet.TransCode = 5)

               SWITCH            ARDet.TransSubCode
               CASE              1
                 MOVE              "Check:",PaymentType
               CASE              2
                 MOVE              "Cash:",PaymentType
               CASE              3
                 MOVE              "Credit Card:",PaymentType
               CASE              4
                 MOVE              "Wire Transfer:",PaymentType
               CASE              5
                 MOVE              "Letter of Credit:",PaymentType
               CASE              6
                 MOVE              "Toucher Details:",PaymentType
               CASE              7
                 MOVE              "Money Order:",PaymentType
               CASE              8
                 MOVE              "Electronic Wire:",PaymentType
               DEFAULT
                 MOVE              "Check:",PaymentType
               ENDSWITCH
           endif
               PACK              DATALINE FROM PaymentType,";",ARDet.Reference,";":
                                               TransDate10," ;":
                                               ARDet.Amount,";":
                                               ARDet.DiscAmt,";":
                                               ARDet.Memo
                repeat
                   return
.=============================================================================
.=============================================================================
LoadTransactions
ViewHistoryByOptions
;
; Load the Invoices first
;
              SETMODE           *mcursor=*wait
              LVTransactions.DeleteAllItems
              LVCreditCards.DeleteAllItems
              setprop                LVTransactions,AutoRedraw=0
;
; Load the Credit Cards into the Screen first
;
                     packkey            CreditCardsKY from $Entity,Cust.CustomerID
                     call               RDCreditCards
                     loop
                       call               KSCreditCards
                     until (ReturnFl = 1 or  Cust.CustomerID != CreditCards.CustomerID)
                       call               InsertIntoListView
                     repeat
CheckDate          dim               10


                PACKKEY           ARTRNKY3,$Entity,CustKY,"C"

              MOVE              "0",CustBalance

              CALL              RDARTRN3
              LOOP
                CALL              KSARTRN3
              UNTIL             (RETURNFL = 1 or (ARTrn.CustomerID <> Cust.CustomerID))
                UNPACK            ARTrn.TransDate,CC,YY,MM,DD         //HR 7/29/2003
                PACK              TransDate10,MM,"-",DD,"-",YY
                                                                     //   030918
                CHOP              ARTrn.Reference,ARTrn.Reference
                CHOP              ARTrn.CustomerPO,ARTrn.CustomerPO
                CHOP              ARTrn.OrderNumber,ARTrn.OrderNumber
                move              ARTRN.Reference,#Document
                CALC              FreightAmt = ARTrn.OrigAmt - ARTrn.SalesAmt
                add               ARTRN.Balance,CustBalance

              switch            ARTrn.InvCredit
              case              "I"
                move              "Inv",InvType
              case              "C"
                move              "Credit Memo",InvType
              case              "D"
                move              "Debit Memo",InvType
              endswitch

ARStatus           dim               4
CheckNo            dim               10
                if                   (ARTrn.Balance = 0)
                  move                 "Paid",ARStatus
                else
                  move                 "Open",ARStatus
                endif

                   clear             CheckNo,CheckDate
                   packkey           ARDETKY,$Entity,ARTrn.SeqMajor,"   "
                   call              RDARDET
                   loop
                     call              KSARDET
                   until             (RETURNFL = 1 OR ARDet.SeqMajor <> ARTrn.SeqMajor )            CC YY MM DD
                     if                (ARDet.TransCode = 5)
                      switch            ARDet.TransSubCode
                       case              1
                         move              "Check:",PaymentType
                       case              2
                         move              "Cash:",PaymentType
                       case              3
                         move              "Credit Card:",PaymentType
                       case              4
                         move              "Wire Transfer:",PaymentType
                       case              5
                         move              "Letter of Credit:",PaymentType
                       case              6
                         move              "Toucher Details:",PaymentType
                       case              7
                         move              "Money Order:",PaymentType
                       case              8
                         move              "Electronic Wire:",PaymentType
                       default
                         move              "Check:",PaymentType
                       endswitch

                       unpack            ARDet.TransDate,CC,YY,MM,DD                         20 04 06 13
                       pack              CheckDate,MM,"-",DD,"-",YY                           06/13/04
                       chop              ARDet.Reference,CheckNo
;
; Find out when the check was deposited
;
..HR 2020.04.15                   ResetVar          BatchChecks.CustomerID
..HR 2020.04.15                   move              Cust.CustomerID,BatchChecks.CustomerID
..HR 2020.04.15                   lenset            BatchChecks.CustomerID

..HR 2020.04.15                   packkey           BatchChecksKY4 from $Entity,BatchChecks.CustomerID,ARTRN.Reference
..HR 2020.04.15                   call              RDBatchChecks4
..HR 2020.04.15                   call              KSBatchChecks4
..HR 2020.04.15                   chop              BatchChecks.CustomerID,BatchChecks.CustomerID
..HR 2020.04.15                   if                (ReturnFl =  0 and BatchChecks.CustomerID != Cust.CustomerID and BatchChecks.CheckNo != ARTDet.Reference)
..HR 2020.04.15                     packkey           BatchDetailsKY2 from $Entity,BatchChecks.SeqNo
..HR 2020.04.15                     call              RDBatchDetails2

..HR 2020.04.15                     chop              BatchChecks
..HR 2020.04.15                     else
..HR 2020.04.15                       clear             BatchDate,BatchNumber
..HR 2020.04.15                     endif


                       break
                     endif
                   repeat

                packkey              RecordKey from cc,yy,mm,dd,"C"
                PACK              DATALINE FROM RecordKey,";",TransDate10,";",InvType,":",ARTrn.Reference,";",ARTrn.CustomerPO,";":
                                             ARTrn.OrigAmt,";":
                                             ARStatus,";":
                                             CheckNo,";":
                                             CheckDate

             LVTransactions.SetItemTextAll using *Text=DataLine,*Delimiter=";",*Param=ARTRN.SeqMajor,*Index=0
           REPEAT
;
; Load the Checks for this Customer
;
              SETMODE                *mcursor=*Arrow
              setprop                LVTransactions,AutoRedraw=1
              LVTransactions.SortColumn using *Column=0,*Type=12
              LVTransactions.SetItemState using *Index=0,*State=03,*StateMask=03

              setfocus               LVTransactions
              setprop                EComments,ModifyFlag=0
              setprop                NBalance,value=CustBalance
              RETURN
;==========================================================================================================
RePrintInvoices
DocumentD     DIM               9

              MOVE                FirstRow,StartingRow
              LOOP
                LVTransactions.GetNextItem giving RES2 using *Flags=2,*Start=StartingRow
              UNTIL               (res2 = -1)
                LVTransactions.GetItemParam giving SeqNum using *Index=Res2
                MOVE              RES2,StartingRow

                PACKKEY           ARTRNKY2,$Entity,SeqNum
                CALL              RDARTRN2

                squeeze           ARTrn.Reference,DocumentD
                MOVE              DocumentD,#Document

                CALLS             "OrderEntry;ShowInvoiceLoadMod" using #Document
              REPEAT



;==========================================================================================================
InsertIntoListView
CardDesc            dim                20
CreditCardNo        dim                20
ExpirationDate      dim                12
CardLength          form               2
CreditCard          dim                20
CVC                 dim                4
CCType1             dim                4(4)
CCNUmber           dim               26
                    incr               CreditCards.Type
                    load               CardDesc from CreditCards.Type with "MASTERCARD","VISA","AMEX","Discover","Diners"
                    unpack             CreditCards.ExpirationDate into yyyy,mm
                    pack               ExpirationDate from mm,"/",yyyy
                    switch             CreditCards.Type

                    case               1
                      unpack             CreditCards.Number,CCType1
                      packkey            CCNumber from CCType1(1),"-",CCType1(2),"-",CCType1(3),"-",CCType1(4)
                    case               2
                      unpack             CreditCards.Number,CCType1
                      packkey            CCNumber from CCType1(1),"-",CCType1(2),"-",CCType1(3),"-",CCType1(4)
                    case               3
                    move             CreditCards.Number,CCNumber
                    case               4
                    move             CreditCards.Number,CCNumber

                    endswitch

                    PACK              DATALINE FROM CardDesc,";":
                                                    CCNumber,";":
                                                    ExpirationDate,";":
                                                    CreditCards.CVC

                    LVCreditCards.SetItemTextAll using *Index=SelectedRow,*Text=DataLine,*Delimiter=";",*Param=CreditCards.SeqNo,*Options=LVOptions  //HR 4.4.2016
                    return
;==========================================================================================================
OnClickChange1
                    return
;==========================================================================================================
SortColumn
              EventInfo         0,Result=SortColumn
              MOVE              FirstRow,StartingRow

              LVTransactions.GetNextItem giving SelectedRow using *Flags=2,*Start=StartingRow
              LVTransactions.GetItemParam giving ItemParam using *Index=SelectedRow

              IF                (((SortHeader(SortColumn) / 2) * 2) = SortHeader(SortColumn))
                SUBTRACT        "1",SortHeader(SortColumn)
              ELSE
                ADD             "1",SortHeader(SortColumn)
              ENDIF

              SWITCH            SortHeader(SortColumn)

              CASE              5
                MOVE              "mm-dd-yy",SortMask
              CASE              6
                MOVE              "mm-dd-yy",SortMask
              DEFAULT
                MOVE              "",SortMask
              ENDSWITCH

              LVTransactions.SortColumn using *Column=SortColumn,*Type=SortHeader(SortColumn),*Mask=SortMask
              LVTransactions.FindItem giving SelectedRow using *Start=StartingRow,*Param=ItemParam
              LVTransactions.EnsureVisible using *Index=SelectedRow,*Partial=0
              LVTransactions.SetItemState using *Index=SelectedRow,*State=03,*StateMask=03
              RETURN
;==========================================================================================================
TestTrack
TestInvoice        dim               10
IndexCounter       form              6
DateFrom           dim               8
dim1               dim               1
                   return
;==========================================================================================================
PrintLedgerCard
MainPrint
                   getprop           DTPrintFrom,text=DateTime
                   move              DateTime,yyyy

                   packkey           DateFrom from yyyy,"0101"
                   call              PrintInit

                   LVTransactions.GetItemCount  giving result9
                   move              "0",IndexCounter
                   CALL              PrintHeader

                   loop
                     LVTransactions.GetItemTextAll giving DataLine using *Index=IndexCounter,*Delimiter=";"
                   until             (IndexCounter = Result9)
                     explode           DataLine,";",RecordKey,TransDate10,InvType,ARTrn.CustomerPO,ARTrn.OrigAmt:
                                                    ARStatus,CheckNo,CheckDate


                     unpack              TransDate10 into mm,dim1,dd,dim1,yy
                     packkey             CheckDate from "20",yy,mm,dd
                     break               if (CheckDate < DateFrom)
                     EndOfPage
                     PrtPage           P;*font=DetailFont:
                                         *alignment=*left:
                                         *P=020:PrintLineCnt,TransDate10:
                                         *p=090:PrintLineCnt,InvType:
                                         *p=250:PrintLineCnt,ARTrn.CustomerPO:
                                         *p=450:PrintLineCnt,ARTrn.OrigAmt:
                                         *p=550:PrintLineCnt,ARStatus:
                                         *p=620:PrintLineCnt,CheckNo:
                                         *p=720:PrintLineCnt,CheckDate

                        ADD               SingleLine,PrintLineCnt

                   incr              IndexCounter
                   repeat

                   call              PrintClose1
                   return
;==========================================================================================================
PrintCustomHeader
TelephoneDim15     dim               15
                   chop              Cust.Addr1,Cust.Addr1
                   chop              Cust.City,Cust.City
                   chop              Cust.Zip,Cust.Zip
                   chop              Cust.Telephone,Cust.Telephone
                   squeeze           Cust.Telephone,Cust.Telephone,"-"

                   if               (Cust.Telephone != "")
                     unpack            Cust.Telephone into Phone1,Phone2,Phone3
                     packkey           TelephoneDim15 from Phone1,"-",Phone2,"-",Phone3
                   else
                     move             " ",TelephoneDim15
                   endif


                   PRTPAGE           P;*alignment=*left:
                                     *font=DetailFont:
                                     *P=200:PrintLineCnt,"Vendor :",Cust.CustomerID,"  -  ",Cust.Name:
                                     *p=200:(PrintLineCnt + SingleLine),*LL,Cust.Addr1,"     ",Cust.City,",  ",Cust.St:
                                     "  ",Cust.Zip:
                                     *p=650:(PrintLineCnt + SingleLine),"Phone : ",TelephoneDim15:
                                     *font=SubLineFont:
                                     *p=018:(PrintLineCnt + 2 * SingleLine),"Trans Date":
                                     *P=090:(PrintLineCnt + 2 * SingleLine),"Invoice":
                                     *p=250:(PrintLineCnt + 2 * SingleLine),"Customer PO":
                                     *p=457:(PrintLineCnt + 2 * SingleLine),"Inv. Amt.":
                                     *p=550:(PrintLineCnt + 2 * SingleLine),"Status":
                                     *p=620:(PrintLineCnt + 2 * SingleLine),"Check No.":
                                     *p=720:(PrintLineCnt + 2 * SingleLine),"Check Date"
                   ADD               (2 * SingleLine),PrintLineCnt
                   RETURN
.=============================================================================
ViewComments2
              CALL                  CommentInq using Cust.CustomerID
              RETURN
;==========================================================================================================
              include           MenuDefs.INC

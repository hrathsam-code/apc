;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    4 NORFOLK LANE                                           ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    BatchEntry                                                     ;
;                                                                             ;
;   AUTHOR:    HARRY RATHSAM                                                  ;
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
;
.
. .             SWITCH            ARDET.TransSubCode
.              CASE              1
.                MOVE              "Check:",PaymentType
.              CASE              2
.                MOVE              "Cash:",PaymentType
.              CASE              3
.                MOVE              "Credit Card:",PaymentType
.              CASE              4
.                MOVE              "Wire Transferk:",PaymentType
.              CASE              5
.                MOVE              "Letter of Credit:",PaymentType
.              CASE              6
.                MOVE              "Toucher Details:",PaymentType
.              CASE              7
.                MOVE              "Money Order:",PaymentType
.              CASE              8
.                MOVE              "Electronic Wire:",PaymentType
.              DEFAULT
.                MOVE              "Check:",PaymentType
.              ENDSWITCH


                    include            NCommon.TXT
                   INCLUDE           WORKVAR.INC
#RESULT            FORM              1
#RES1              FORM              1
#DIM1              DIM               1
#DIM2              DIM               2
#RES2              FORM              2
#LEN1              FORM              3
#MenuItem          DIM               25
BatchSeqNo          form               9(1000)
BatchCounter        form               4

WrkAmountF          form               7.2
LineCount           form               4
InvoiceTotals       form               7.2
PaymentAmt          form               7.2
x                   form               4
WrkAmount           dim                12


RES2          FORM              2
Int2                form               9

CheckDate           dim                10
Parameter1          form               10

                   GOTO              STARTPGM
                   include             Cust.FD

                   INCLUDE           Batch.FD
                   include             BatchDetails.FD
                   include             ARDet.FD
                   include             ARTRN.FD
                   include             BatchChecks.FD
                   include             Sequence.FD

MAIN               PLFORM            BatchEntry.PLF
DataMenu           PLFORM            DataMenu.PLF


.
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
                     PACK              EnvData,EnvData,BatchHelp
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
                   CALL              OpenARDet
                   call                OpenARTrn
                   call                OpenBatch
                   call                OpenBatchDetails
                   call                OpenBatchChecks
                   call                OpenCust
                   call                OpenSequence

                   TRAPCLR           IO

BatchCOLL          COLLECTION
BatchEDT           COLLECTION
BatchActive        COLLECTION

;
; Includes ALL fields
;
...                   LISTINS           BatchCOLL,NBatchTotals,NBatchID

                   LISTINS           BatchEDT,NBatchTotals,NBatchID

                   LISTINS           BatchActive

.                  winhide
                   FORMLOAD          MAIN
                   FORMLOAD          DataMenu,WMain

                   call              MainReset
                   setfocus          NBatchTotals

                    MOVE               "11",SortHeader

                    MOVE               "3",SortHeader(2)
                    MOVE               "5",SortHeader(2)

                   LOOP
                     WAITEVENT
                   REPEAT
.
. We never get here!!   Just in case though.... :-)
.
                   RETURN
.                  STOP

BROWSEFILE         ROUTINE
SEARCH             PLFORM            Search3.plf
                   FORMLOAD          SEARCH
                   RETURN

INITSRCH
                   PACK              SearchTitle,BatchTitle," Search Window"
                   SETPROP           WSearch,*Title=SearchTitle

                   CTADDCOL          "A/P Term Code",100,"Term Description",100:
                                     "Net Days",75

.                   CTLoadTable       Batch,Code,Desc,NetDays,DiscDays,DiscPerc,DiscAmt
                   RETURN
;==========================================================================================================
LoadSearchWindow
                    return
;==========================================================================================================
ItemSelected
                    RETURN
;==========================================================================================================

.
. Routines that operate the Main program
.
NOFILE
                   NORETURN
                   ALERT             PLAIN,"A/P Terms Master file does not exist. Do you wish to create it?",#RESULT
                   IF                (#RESULT = 1)
..                     CALL              PREPBatch
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
.X BatchEntryRPT        PLFORM            BatchEntryRPT.PLF
.X .               WINHIDE
.X
.X                 CLOCK             DATE,TODAY8
.X                 CLOCK             TIME,TIME8
.X
.X                 MOVE              "60",MAXROWS
.X                 MOVE              "0",PAGE
.X                 MOVE              "90",LINE
.X
.X                 FORMLOAD          BatchEntryRPT
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
.X                 MOVE              " ",BatchEntryKY
.X
.X                 GETITEM           RAll,0,RETURNFL
.X                 BRANCH            RETURNFL OF ALL
.X
.X                 GETITEM           EFromRange,0,BatchEntryKY
.X                 GETITEM           EToRange,0,ToCode
.X
.X                 IF                (ToCode < BatchEntryKY)
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
.X                 CALL              RDBatch
.X                 LOOP
.X                   CALL              KSBatchEntry
.X                 UNTIL             (RETURNFL = 1 OR BatchEntryREC.Code > ToCode)
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
.X                 CHOP              BatchEntryREC.NETDAYS,BatchEntryREC.NETDAYS
.X                 CHOP              BatchEntryREC.DISCDAYS,BatchEntryREC.DISCDAYS
.X
.X                 MOVE              BatchEntryREC.NETDAYS,NUM1
.X                 MOVE              BatchEntryREC.DISCDAYS,NUM2
.X
.X                 PRTPAGE           PRTFILE;*1,BatchEntryREC.Code:
.X                                           *16,BatchEntryREC.Desc:
.X                                           *Alignment=*Right:
.X                                           *38,Num1:
.X                                           *50,Num2:
.X                                           *Alignment=*Decimal:
.X                                           *61,BatchEntryREC.DiscPerc:
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
.
. OK, we've been able to read the record and now let's show it on the screen.
.
                       CALL              SETMAIN

                       setprop           NBatchTotals,Static=1,BGColor=$BtnFace
                       DISABLEITEM       Fill1
                       SETFOCUS          BMainChange
                   RETURN
;==========================================================================================================
; Initialize MAIN Form and setup the Menu's, Fields, Objects, Buttons, etc

MAININIT
; Set the SELECTALL property for the COLLECTION and then take care of
; any ActiveX controls.
;
                   SETPROP           BatchEDT,SELECTALL=$SelectAll
.
                   CALL              MAINRESET
                   RETURN
;==========================================================================================================
; New Button is pressed
;
MAINNEW
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
                    setprop            LVChecks,enabled=0
                    clear              Batch
                    CALL              GETMAIN
;
; Let's capture all the checks selected so we can put them into a Transaction
;
                    clear              BatchCounter
                    MOVE              "0",StartingRow
                    LOOP
                      LVChecks.FindItemCheck giving result using *Start=StartingRow
                    UNTIL               (result = -1)
                      incr             BatchCounter
                      LVChecks.GetItemParam giving BatchSeqNo(BatchCounter) using *Index=Result

                      move              result,StartingRow
                      incr              StartingRow
                    repeat
.
. Let's see if SOMEBODY else has entered/used this code before or let's just
. see if this Code already exists in the system
.
                    transaction       start,BatchFLST,SequenceFLST,BatchDetailsFLST,BatchChecksFLST

                    GetNextSeq         Batch
                    move               Sequence.SeqNo,Batch.SeqNo
                    move               Sequence.SeqNo,Batch.BatchID
                    move               $Entity,Batch.Entity

                    CALL              WRTBatch

                    for                 X from 1 to BatchCounter using "1"
                      move             BatchSeqNo(X),BatchChecks.SeqNo
                      packkey          BatchChecksKY2 from $Entity,BatchChecks.SeqNo
                      call             RDBatchChecks2
                      if               (ReturnFl = 1)
                        transaction        rollback
                        beep
                        alert              note,"Unable to locate specific Check Record. Restoring the updates",result,"INVALID CHECK"
                        setprop            LVChecks,enabled=1
                        return                                                      :
                      endif

                      move             Batch.BatchDate,BatchDetails.BatchDate
                      move             Batch.Entity,BatchDetails.Entity
                      move             Batch.SeqNo,BatchDetails.SeqNo
                      move             Batch.Entity,BatchDetails.Entity
                      move             Batch.SubEntity,BatchDetails.SubEntity
                      move             BatchChecks.CheckNo,BatchDetails.Reference
                      move             BatchChecks.Amount,BatchDetails.CheckAmt
                      move             "1",BatchDetails.PostedFlag
                      move             BatchChecks.CustomerID,BatchDetails.CustomerID

                      clock            TimeStamp,BatchDetails.PostedDate

                      move             BatchChecks.SeqNo,BatchDetails.BatchCheckSeqNo
                      call             WRTBatchDetails
                      move             "1",BatchChecks.BatchPosted
                      move             Batch.SeqNo,BatchChecks.BatchSeqNo
                      call             UPDBatchChecks
                    REPEAT
                    transaction        commit
;
; Now delete the transactions from the Listview before Enabling the Listview again
;
                    MOVE              "0",StartingRow
                    LOOP
                      LVChecks.FindItemCheck giving result using *Start=StartingRow
                    UNTIL               (result = -1)

                      LVChecks.DeleteItem using *Index=Result
                      move              result,StartingRow
                    repeat

                    setprop            LVChecks,enabled=1
                    pack               dataline from "Batch ##",Batch.BatchID," has been created in the amount of :",Batch.BatchTotal
                    alert              note,dataline,result,"BATCH POSTED"
                    CALL              MAINRESET
                    RETURN
;==========================================================================================================
. Change/Save Button has been pressed
.
MAINCHANGE
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
                     CALL              RDBatchLK
                     CALL              SetMain
                   ENDIF
                   RETURN
;==========================================================================================================
MainFind
                   FindSearch        NBatchID
                   IF                (PassedVar = "Y")
                     getprop           NBatchID,value=Batch.BatchID
                     packkey           BatchKY from $Entity,Batch.BatchID
.                     MOVE              $SearchKey,BatchEntryKY
                     CALL              RDBatch
.
. We've got a record thanks to our Trusy Search/Browse window. Let's
. continue now by setting up the proper Code field and calling the
. MainValid subroutine, that will take care of it for us.
.
                     MOVE              "0",Status
                     setprop           NBatchID,value=Batch.BatchID
                     CALL              MainValid
                   else
                     setfocus          NBatchID
                   ENDIF
                   RETURN
;==========================================================================================================
. Routine to read the First record and display it
.
MainFirst
                   CLEAR             BatchKY
                   FILL              FirstASCII,BatchKY
                   CALL              RDBatch
                   IF                (RETURNFL = 1)  . We didn't find a 'Blank' record
                     CALL              KSBatch         . Try the 'next' record
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
                   setprop           NBatchID,value=Batch.BatchID
                   CALL              MainValid
                   RETURN
;==========================================================================================================
. Routine to read the Last record and display it
.
MainLast
                   CLEAR             BatchKY
                   FILL              LastASCII,BatchKY
                   CALL              RDBatch
                   IF                (RETURNFL = 1)  . We didn't find a 'Blank' record
                     CALL              KPBatch         . Try the 'Previous' record
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
                   setprop           NBatchID,value=Batch.BatchID
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
                   GETCOUNT          NBatchID
                   IF                (CharCount <> 0)
                     getprop           NBatchID,text=BatchKY
                     CALL              RDBatch
                   ENDIF

                   CALL              KSBatch         . Try the 'next' record
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
                   setprop           NBatchID,value=Batch.BatchID
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
                   GETCOUNT          NBatchID
                   IF                (CharCount <> 0)
                     getprop           NBatchID,text=BatchKY
                     CALL              RDBatch
                   ENDIF

                   CALL              KPBatch         . Try the 'Previous' record
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
                   setprop           NBatchID,value=Batch.BatchID
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
                   MOVE              "0",ValidFlag

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
                   unlock            Batchfl
.
. Reset the fields to 'Blank' and DISABLE all of those fields as well
...                   DELETEITEM        BatchCOLL,0
                   clear             Batch
                   call              setmain

....                   DISABLEITEM       BatchCOLL
...                   SETPROP           BatchCOLL,static=1,bgcolor=$BtnFace
                   ENABLEITEM        Fill1
.
. Reset the Buttons for the Next record
.
                   DISABLEITEM       BMainChange
                   DISABLETOOL       ID_Change
                   DisableDBMenu     MModifyRecord

                   DISABLEITEM       BMainDELETE
                   DISABLETOOL       ID_Delete
                   DisableDBMenu     MDeleteRecord

                   setprop           BMainCHANGE,title=ChangeTitle

...                   setprop           BMainNEW,title=NewTitle
                   ENABLETOOL        ID_New
                   EnableDBMenu      MNewRecord

                   setprop           BMainNEW,enabled=0
                   setprop           BMainCancel,title=ExitTitle

                   DISABLETOOL       ID_Save
                   DISABLETOOL       ID_Undo
                   DISABLETOOL       ID_Cancel

                   DisableDBMenu     MSaveRecord

                   CALL              EnableRecordButtons
.
. Setup any ActiveX control fields to what they should be
.
.                  SETPROP           EBatchDiscPerc,*Text="0"
.                  SETPROP           EBatchDiscPerc,*Enabled=0
.                  SETPROP           EBatchDiscPerc,*BackColor=$BTNFACE
.
. Setup the Primary field that is used for Entry purposes
.
                   %IFDEF            CBBatchInactive
....                   SETITEM           CBBatchInactive,0,0
....                   DISABLEITEM       CBBatchInactive
                   setprop           CBBatchInactive,enabled=0,value=0
                   %ENDIF

....                   SETPROP           NBatchID,READONLY=0
....                   SETPROP           NBatchID,BGCOLOR=$WINDOW
                   SETPROP           NBatchID,static=0,bgcolor=$Window
....                   ENABLEITEM        ETRoomNumber

                    LVChecks.DeleteAllItems
                    call               LoadOpenChecks
                   SETFOCUS          NBatchTotals
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
                 RETURN
               ELSE
                 RETURN
               ENDIF
             ELSE
               CALL              MAINRESET
             ENDIF
             RETURN
           ENDIF
;==========================================================================================================
LoadOpenChecks
PaymentType         dim                20


                    packkey            BatchChecksKY from $Entity
                    call               RDBatchChecks
                    loop
                    call               KSBatchChecks
                    until              (ReturnFl = 1 or BatchChecks.BatchPosted = 1)
                      move               BatchChecks.CustomerID,CustKY
                      call               RDCust
                      unpack             BatchChecks.CheckDate into yyyy,mm,dd
                      packkey            CheckDate from mm,"-",dd,"-",yyyy

                    SWITCH            BatchChecks.Type
                    CASE              0
                      MOVE              "Check",PaymentType
                    CASE              1
                      MOVE              "Cash",PaymentType
                    CASE              2
                      MOVE              "Credit Card",PaymentType
                    CASE              3
                      MOVE              "Wire Transferk",PaymentType
                    CASE              4
                      MOVE              "Letter of Credit",PaymentType
                    CASE              5
                      MOVE              "Toucher Details",PaymentType
                    CASE              6
                      MOVE              "Money Order",PaymentType
                    CASE              7
                      MOVE              "Electronic Wire",PaymentType
                    DEFAULT
                      MOVE              "Check",PaymentType
                    ENDSWITCH

                    chop               Cust.Name


                      PACK               DATALINE FROM BatchChecks.CustomerID,";":
                                                       BatchChecks.Amount,";":
                                                       CheckDate,";":
                                                       Cust.Name,";":
                                                       PaymentType,";":
                                                       BatchChecks.CheckNo

                      LVChecks.SetItemTextAll giving Int2 using *Index=99999,*Text=DataLine,*Delimiter=";",*Param=BatchChecks.SeqNo
                    repeat
                    return


;==========================================================================================================
. Delete Button has been Pressed
.
MainDelete
.                   PARAMTEXT        Batch.Code,BatchTitle,"",""
                   BEEP
                   ALERT            PLAIN,"Do you wish to Delete the ^1: ^0 ?",#RES1,DelTitle
                   IF               (#RES1 = 1)
                     CALL             DELBatch
                     ALERT            NOTE,"A/P Term Code ^0 has been deleted",#RES1,DelOKTitle
                     CALL             MAINRESET
                   ENDIF
                   RETURN
;==========================================================================================================
.
. Setup all of the fields in the Form based upon the data record
SETMAIN
                   setprop           NBatchID,value=Batch.BatchID
                   %IFDEF            CBBatchInactive
                   setprop           CBBatchInactive,value=Batch.Inactive
                   %ENDIF
                   RETURN
;==========================================================================================================
. Retrieve all of the fields in the Form based upon the data record
.
GETMAIN
                   getprop             DTBatchDate,text=Batch.BatchDate
                   getprop             NBatchTotals,value=Batch.BatchTotal
                   clock               TimeStamp,Batch.PostedDate
                   set                 Batch.PostedFlag

                   %IFDEF            CBBatchInactive
                   getprop           CBBatchInactive,value=Batch.Inactive
                   %ENDIF
                   RETURN
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
                   CALL              PrintReport
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
                   include           MenuDefs.INC
;==========================================================================================================
CalcInvoiceTotals

                    SETMODE           *mcursor=*Wait

                    LVChecks.GetItemCount giving LineCount
                    SUBTRACT          "1",LineCount
                    MOVE              "0",InvoiceTotals
                    getprop           NBatchTotals,value=PaymentAmt

                     MOVE              FirstRow,X
                     LOOP
                         add                  "1",X
                         LVChecks.FindItemCheck giving X using *Start=X
                     UNTIL             (X = -1)
                        LVChecks.GetItemText giving WrkAmount using *Index=X,*SubItem=1
                        squeeze                 WrkAmount,WrkAmount
                        move                    WrkAmount,WrkAmountF

                        ADD               WrkAmountF,InvoiceTotals
                     REPEAT

                       SUBTRACT          InvoiceTotals,PaymentAmt
                       if                (PaymentAmt = 0)
                       setprop         BMainNew,enabled=1
                       else
                       setprop         BMainNew,enabled=0
                       endif
.                       setprop                  NWriteOffamt,value=WriteOffTotals

                       SETMODE           *mcursor=*Arrow

                       RETURN
;==========================================================================================================
SortColumn

              EventInfo         0,Result=SortColumn

              MOVE              FirstRow,StartingRow

              LVChecks.GetNextItem giving SelectedRow using *Flags=2,*Start=StartingRow
              LVChecks.GetItemParam giving ItemParam using *Index=SelectedRow

              IF                (((SortHeader(SortColumn) / 2) * 2) = SortHeader(SortColumn))
                SUBTRACT        "1",SortHeader(SortColumn)
              ELSE
                ADD             "1",SortHeader(SortColumn)
              ENDIF

              SWITCH            SortHeader(SortColumn)

              CASE              5
                MOVE              "MM-DD-YYYY",SortMask
              CASE              6
                MOVE              "MM-DD-YYYY",SortMask
              DEFAULT
                MOVE              "",SortMask
              ENDSWITCH

              LVChecks.SortColumn using *Column=SortColumn,*Type=SortHeader(SortColumn),*Mask=SortMask
              LVChecks.FindItem giving SelectedRow using *Start=StartingRow,*Param=ItemParam
              LVChecks.EnsureVisible using *Index=SelectedRow,*Partial=0
              LVChecks.SetItemState using *Index=SelectedRow,*State=03,*StateMask=03
              RETURN

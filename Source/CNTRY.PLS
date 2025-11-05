;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    4 NORFOLK LANE                                           ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    Cntry                                                          ;
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
; Primary Object = Main Object when program first opens
; Secondary Object = Object that gets focus AFTER the record is viewed/created
;
; PrimaryyKey = Main Key used to retrieve the record
;
; Cntry.Code = Main Field that is normally used in Primary Index
;
;
$SearchMethod       equ                1                    //1 = All, 2 = Specific
MajorMinorVersion   init               "1.005"

                    include            WORKVAR.INC

                    goto               STARTPGM
                    include            Cntry.FD
                    include            cust.fd

MAIN                plform             Cntry.PLF
DataMenu            plform             DataMenu.PLF

STARTPGM            routine
                    include           SECURITY.INC
                    move              "1",ProgLoaded
;
; If we're unable to find the Help file, then we're going to simply just not make
; the F1 Function key available to the Users
;
                    move              "AppDir;HELPDIR",EnvData
                    clock             INI,EnvData
                    if                NOT OVER
                     pack              EnvData,EnvData,CntryHelp
                     trap              NOHELP IF OBJECT
                     setmode           *HELPLIB=EnvData
                     setmode           *F1HELP=ON
                     trapclr           OBJECT
NOHELP
                     noreturn
                   endif

                    call               OpenAllFiles

CntryEDTColl        collection
CntryResetColl      collection
CntryActive         collection                                                        //Used for Enable/Disable objects only
;
; Includes ALL fields
;
                    listins           CntryEDTColl,ECntryName                    //Fields that are edited during New/Update

                    listins           CntryResetColl,ECntryCode,CntryEDTColl

                    listins           CntryActive,ECntryName

                    winhide
                    formload          MAIN
                    formload          DataMenu,WMain

                    call              MainReset
                    setfocus          ECntryCode

                    loop
                      waitevent
                    repeat
;
; We never get here!!   Just in case though.... :-)
;
                    return
;==========================================================================================================
BROWSEFILE          routine
SEARCH              plform             SEARCHAll.PLF

                    call               OpenAllFiles
                    formload          SEARCH
                    return
;==========================================================================================================
INITSRCH
                    pack              SearchTitle,CntryTitle," Search Window"
                    setprop           WSearch,Title=SearchTitle

                    ctaddcol          "Country Code",100,"Country",300

                    %if                $SearchMethod = 1                   //LoadAll
                    call               LoadAllRecords
                    %endif

                    return
;==========================================================================================================
                    %if                $SearchMethod = 1                   //LoadAll
LoadAllRecords
                    move              " ",CntryKY
                    call              RDCntry
                    loop
                      call              KSCntry
                    until (ReturnFl = 1)
                      CTLoadRecord2     CntryFL,Cntry,Cntry.Code,Cntry.Code,Cntry.Name
..                    CTLoadRecord2     &File,&Record,&Key,&Field1=,&Field2=
                    repeat
                    LVSearchPLB.SetItemState using *Index=0,*State=03,*StateMask=03
                    setprop                BSearchSelect,default=1
                    setfocus               LVSearchPLB
                    return
                    %endif
;==========================================================================================================
LoadSearchWindow
                    SETMODE           *mcursor=*wait

                    clear             SearchCounter
                    clear             CntryKY
                    LVSearchPLB.DeleteAllItems
                    CALL              RDCntry
                    LOOP
                      CALL              KSCntry
                    UNTIL             (ReturnFl = 1)
                      incr              SearchCounter
                      CTLoadRecord2     CntryFL,Cntry,Cntry.Code,Cntry.Code,Cntry.Name
                    REPEAT
                    SETMODE           *mcursor=*Arrow
                      LVSearchPLB.SetItemState using *Index=0,*State=03,*StateMask=03
                      setprop                BSearchSelect,default=1
                      setfocus               LVSearchPLB
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
OnClickCntry
                    F2SEARCH          ECntryCode
                    if                 (PassedVar="Y")
                      call               MainValid
                    endif
                    return
;==========================================================================================================
ErrorRoutines
;
; Routines that operate the Main program
;
                    OPEN               ErrorFile,"ErrorLog.PLD"
                    CLOCK              TimeStamp,ErrorDateTime
                    PACK               AlertString FROM "Error : ",FileNameError,AlertReturn:
                                                        "Actual Error : ",S$ERROR$
                    getmode            *ProgName=ProgramName
                    getmode            *ProgStamp=ProgramStamp
                    getmode            *ProgVer=ProgramVer

                    WRITE              ErrorFile,SeqEOF;*CDFON,ErrorDateTime,AlertString,ProgramName,ProgramStamp,ProgramVer,*CDFOFF
                    ALERT              stop,AlertString,result,"ERROR"
                    STOP
;==========================================================================================================
PrintPreviewReport
                    return
;==========================================================================================================
PrintReport
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
                   IF                (RecordStatus = "")
                     GETCOUNT          ECntryCode
                     IF                (CharCount > 0)
                       getprop           ECntryCode,text=CntryKY
                       CALL              RDCntry
                       IF               (RETURNFL = 1)
                         pack             AlertString from CntryTITLE,": ",CntryKY," Not Found"
                         ALERT            CAUTION,AlertString,AlertResult,"Record does not exist"
                         CALL             MAINRESET
                         RETURN
                       ENDIF
;
; OK, we've been able to read the record and now let's show it on the screen.
;
                       CALL              SETMAIN
                       MOVE              "F",RecordStatus                   .We've found a record
                       setprop           BMainChange,enabled=1

                       ENABLETOOL        ID_Change
                       EnableDBMenu      MModifyRecord

                       setprop           BMainDelete,enabled=1
                       ENABLETOOL        ID_Delete
                       EnableDBMenu        MDeleteRecord

                       setprop           ECntryCode,Static=1,BGColor=$BtnFace
                       setprop           Fill1,enabled=0
                       SETFOCUS          BMainChange
                     ENDIF
                   ENDIF
                   RETURN
;==========================================================================================================
MAININIT
;
; Set the SELECTALL property for the COLLECTION and then take care of
; any ActiveX controls.
; Initialize MAIN Form and setup the Menu's, Fields, Objects, Buttons, etc
;
                   SETPROP           CntryEDTColl,SELECTALL=$SelectAll
.
                   CALL              MainReset
                   RETURN
;==========================================================================================================
MainNew
;
; New Button is pressed
;
                   IF                (RecordStatus = "N")      //Let's 'Save' this NEW Record
                     CALL              ValidateFields     //Validate the data first
;
; Something's not right...Let's just return and wait until all the fields
; have been validated
;
                     IF                (ValidFlag = 1)
                       RETURN
                     ENDIF
;
; Get all of the fields from the Form into the proper RECORD
;
                     CALL              GetMain
;
; Let's see if SOMEBODY else has entered/used this code before or let's just
; see if this Code already exists in the system
;
                     getprop           ECntryCode,text=CntryKY
                     CALL              TSTCntry
                     IF                (RETURNFL = 1)
                       CALL              WRTCntry
                       CALL              MAINRESET
                       RETURN
                     ELSE
                       BEEP
                       pack            AlertString from CntryTITLE with code CntryKY already exists. Please enter another code"
                       ALERT           Note,AlertString,result:
                                            "Record already exists"
                       SETFOCUS        ECntryCode
                     ENDIF                                //Valid record exists???
                   ELSE
                     CALL              MainReset
                     MOVE              "N",RecordStatus
                     CALL              DisableRecordButtons
;
; Enable all of the EditText fields and set the EditText fields
; to Non Read-Only
;
                     setprop           CntryEDTColl,static=0,bgcolor=$Window
                     setprop           CntryActive,enabled=1

                     setprop           Fill1,enabled=0
;
; Setup any DEFAULT values
;
                     call              LoadDefaultValues
;
; Disable & Enable the proper Buttons along with changing
; the description of the Button's (i.e. Exit --> Change)
;
                     setprop           BMainChange,enabled=0
                     DISABLETOOL       ID_Change
                     DisableDBMenu     MModifyRecord

                     setprop           BMainDelete,enabled=0
                     DISABLETOOL       ID_Delete
                     DisableDBMenu     MDeleteRecord

                     setprop           BMainNEW,title=SaveTitle
                     ENABLETOOL        ID_Save
                     EnableDBMenu      MSaveRecord

                     setprop           BMainCancel,title=CancelTitle
                     ENABLETOOL        ID_Cancel

                     DISABLETOOL       ID_New
                     DisableDBMenu     MNewRecord

;
; Set the Focus to the first field that we're going to be Entering
;
                     SETFOCUS          ECntryCode
                   ENDIF
                   RETURN
;==========================================================================================================
MainChange
;
; Change/Save Button has been pressed
;
; I'm only getting here if the Change Button has been selected.  Soooooo....Either the
; Change Button has been pressed, or this button now reads 'Save'.  If it reads Save,
; the Status flag will have been set to 1 the first time that this routine has been
; reached.
                   IF                (RecordStatus = "U")                //'Save' button has been pressed
                     CALL              ValidateFields
                     IF                (ValidFlag = 0)           //Great..All fields ARE valid!!!
                       CALL              GETMAIN                 //Get all of the fields
                       CALL              UPDCntry                //Update the record
                       CALL              MAINRESET               //Reset the objects & fields
                     ENDIF
                     RETURN                                      //Voila...Either way, we're RETURNING
                   ENDIF
                   GETCOUNT          ECntryCode
                   IF                (Charcount > 0)
                     getprop           ECntryCode,text=CntryKY   //Read the Primary field ito the Key

                     CALL              RDCntryLK               //Lock the record so that nobody uses it
;
; Just for arguments sake, let's just make sure that the record hasn't been deleted
; by another user, AND...Let's make sure that it's not being used by another user
; as well!!                                                                                              b8fw56
;
                     IF                (RETURNFL = 1)          //WHAT!!! Somebody deleted this record
                       BEEP
                       ALERT             STOP,"Record deleted by another User!!",RESULT
                       CALL              MAINRESET
                       RETURN
                     ENDIF
;
; Record is locked...Try again later
;
                     IF                (RETURNFL = 2)          //WHAT!!! Somebody's locked the record
                       BEEP
                       ALERT             NOTE,"Record locked by another User..."::
                                               "Try again later",RESULT,LOCKTITLE
                       RETURN
                     ENDIF
;
; OK, OK...We've gotten this far...The record is now locked and we
; can safely change the Status to "Modify"
;
                     MOVE              "U",RecordStatus                  //We've selected the Modify/Change Button
                     CALL              DisableRecordButtons
;
; Not only do we have a good record, but we've been able to 'Lock' the record
; and now we're ready to proceed
;
; Enable the Entire Collection of EditText fields as well as setting the
; background colors and making them Non Read-Only
;
                     setprop           Fill1,enabled=0

                     SETPROP           CntryEDTColl,static=0,bgcolor=$Window
                     setprop           CntryActive,enabled=1

;
; OK, OK...What do we do with any ActiveX components. We've got to handle
; them as well.  Let's change these to Non Read-Only and change the
; Background colors as well
;
; Change the Cancel button button to 'Save' and the 'Exit' button to Cancel
;
                     setprop           BMainCancel,title=CancelTitle
                     ENABLETOOL        ID_Cancel

                     setprop           BMainCHANGE,title=SaveTitle
                     ENABLETOOL        ID_Save
                     EnableDBMenu      MSaveRecord

                     ENABLETOOL        ID_Undo
                     DISABLETOOL       ID_Change
                     DisableDBMenu     MModifyRecord

                     DISABLETOOL       ID_New
                     setprop           BMainNew,enabled=0
                     DisableDBMenu     MDeleteRecord

                     SETFOCUS          ECntryName               //Set the cursor to the next field
                     setprop           ECntryCode,Static=1,BGColor=$BtnFace
                   ENDIF
                   RETURN
;==========================================================================================================
MainUndo                             // Routine to read the First record and display it
;
; If I've click on the Undo/Reset button, I've already got the 'Key' based on
; the fact that I'm changing a record that already exists and I loaded the
; key the first time.  Soooooo....Simply 'Re-read' the record, Calll the
; SetMain routine and Voila!!!!
;
                   BEEP
                   ALERT             PLAIN,"Revert back to the 'Original' record",RESULT:
                                           SureTitle
                   IF                (RESULT = 1)
                     CALL              RDCntryLK
                     CALL              SetMain
                   ENDIF
                   RETURN
;==========================================================================================================
MainFind
                   FindSearch        ECntryCode
                   IF                (PassedVar = "Y")
                     getprop           ECntryCode,text=CntryKY
                     MOVE              $SearchKey,CntryKY
                     CALL              RDCntry
;
; We've got a record thanks to our Trusy Search/Browse window. Let's
; continue now by setting up the proper Code field and calling the
; MainValid subroutine, that will take care of it for us.
;
                     clear             RecordStatus
                     setprop           ECntryCode,text=Cntry.Code
                     CALL              MainValid
                   else
                     setfocus          ECntryCode
                   ENDIF
                   RETURN
;==========================================================================================================
MainFirst                            // Routine to read the First record and display it
;
                   CLEAR             CntryKY
                   FILL              FirstASCII,CntryKY
                   CALL              RDCntry
                   IF                (RETURNFL = 1)  . We didn't find a 'Blank' record
                     CALL              KSCntry         . Try the 'next' record
                     IF                (RETURNFL = 1)  . There are no records in the file
                       BEEP
                       ALERT             STOP,"No records exist in the system...",RESULT:
                                              FirstTitle
                       RETURN
                     ENDIF
                   ENDIF
;
; We've got a record (either on the READ or the READKS.  Let's now continue
; processing as if we just lost the Focus of the main field.  By calling the
; MainValid subroutine, that will take care of it for us.
;
                   clear               RecordStatus
                   setprop           ECntryCode,text=Cntry.Code
                   CALL              MainValid
                   RETURN
;==========================================================================================================
MainLast                             // Routine to read the Last record and display it
;
                   CLEAR             CntryKY
                   FILL              LastASCII,CntryKY
                   CALL              RDCntry
                   IF                (RETURNFL = 1)  . We didn't find a 'Blank' record
                     CALL              KPCntry         . Try the 'Previous' record
                     IF                (RETURNFL = 1)  . There are no records in the file
                       BEEP
                       ALERT             STOP,"No records exist in the system...",RESULT:
                                              LastTitle
                       RETURN
                     ENDIF
                   ENDIF
;
; We've got a record (either on the READ or the READKP.  Let's now continue
; processing as if we just lost the Focus of the main field.  By calling the
; MainValid subroutine, that will take care of it for us.

                   clear               RecordStatus
                   setprop           ECntryCode,text=Cntry.Code
                   CALL              MainValid
                   RETURN
;==========================================================================================================
MainNext                             // Routine to read the Next record and display it
;
; We can't just do a simple READKS/READKP because of certain conditions including
; 'Attempting' to read past the last record (Next --> EOF) and the reverse
; condition.  Due to this fact, we need to get the current code, and THEN
; do a READKS/READKP
;
                   GETCOUNT          ECntryCode
                   IF                (CharCount <> 0)
                     getprop           ECntryCode,text=CntryKY
                     CALL              RDCntry
                   ENDIF

                   CALL              KSCntry         . Try the 'next' record
                   IF                (RETURNFL = 1)  . There are no records in the file
                     BEEP
                     ALERT             STOP,"End of file has been reached.",RESULT:
                                            NextTitle
                     RETURN
                   ENDIF
;
; We've got a record (either on the READ or the READKS.  Let's now continue
; processing as if we just lost the Focus of the main field.  By calling the
; MainValid subroutine, that will take care of it for us.
;
                   clear               RecordStatus
                   setprop           ECntryCode,text=Cntry.Code
                   CALL              MainValid
                   RETURN
;==========================================================================================================
MainPrevious                         //  Routine to read the Previous record and display it
;
; We can't just do a simple 'READKS' because of certain conditions including
; 'Attempting' to read past the last record (Next --> EOF) and the reverse
; condition.  Due to this fact, we need to get the current code, and THEN
; do a READKS/READKP
;
                   GETCOUNT          ECntryCode
                   IF                (CharCount <> 0)
                     getprop           ECntryCode,text=CntryKY
                     CALL              RDCntry
                   ENDIF

                   CALL              KPCntry         . Try the 'Previous' record
                   IF                (RETURNFL = 1)  . There are no records in the file
                     BEEP
                     ALERT             STOP,"Beginning of file has been reached...",RESULT:
                                            PrevTitle
                     RETURN
                   ENDIF

. We've got a record (either on the READ or the READKS.  Let's now continue
. processing as if we just lost the Focus of the main field.  By calling the
. MainValid subroutine, that will take care of it for us.

                   clear               RecordStatus
                   setprop           ECntryCode,text=Cntry.Code
                   CALL              MainValid
                   RETURN
;==========================================================================================================
SaveMode                            // Save has been selected from the MENU vs. the Button
;
; OK...The 'Save' has been selected from the Menu rather than from the Save Button.
; What to do, What to do??  Is this a Save to a 'NEW' record or is it a Save to a
; 'CHANGED' record....
; Let's check the 'Status' flag...1 is a Change record, 2 is a New Record
;
                   BRANCH            Status,MainChange,MainNew
                   RETURN
;==========================================================================================================
ValidateFields                       // Routine to Validate the data from the Form
;
;  If we find an error below, set the ValidFlag = 1 and return
;
                   MOVE              "0",ValidFlag

; Everything's OK...Let's just return because the ValidFlag will be set to
; Zero from the top of this routine.
;
                   MOVE              "0",ValidFlag
                   RETURN
;==========================================================================================================
MainReset                            // Routine to 'Reset' everything which includes the Button's, Objects, fields, etc.
;
                   clear               RecordStatus       //reset the status to not updating
                   unlock            Cntryfl
;
; Reset the fields to 'Blank' and DISABLE all of those fields as well
;
                   clear             Cntry
                   call              setmain

                   setprop           Fill1,enabled=1
;
; Reset the Buttons for the Next record
;
                   DISABLETOOL       ID_Change
                   DisableDBMenu     MModifyRecord

                   setprop           BMainDelete,enabled=0
                   DISABLETOOL       ID_Delete
                   DisableDBMenu     MDeleteRecord

                   setprop           BMainCHANGE,title=ChangeTitle,enabled=0

                   setprop           BMainNEW,title=NewTitle,enabled=1
                   ENABLETOOL        ID_New
                   EnableDBMenu      MNewRecord

                   setprop           BMainCancel,title=ExitTitle

                   DISABLETOOL       ID_Save
                   DISABLETOOL       ID_Undo
                   DISABLETOOL       ID_Cancel

                   DisableDBMenu     MSaveRecord

                   CALL              EnableRecordButtons
;
; Setup the Primary field that is used for Entry purposes
;
                   setprop           CntryActive,enabled=0
                   setprop           CntryEDTColl,static=1,BGColor=$BtnFace
                   SETPROP           ECntryCode,static=0,bgcolor=$Window
                   SETFOCUS          ECntryCode
                   RETURN
;==========================================================================================================
MainClose                              // Close Button has been Clicked
;
; Only display this message if I'm in either the Modify or New mode.  If not,
; simply exit the program and proceed as normal
;
                    if                (RecordStatus = "U" and RecordStatus = "N")
                      beep
                      alert              PLAIN,"By Exiting the program now, your operation will be Cancelled?",RESULT:
                                               "Are you sure?"
                      return           if (Result != 1)
                    endif
                    destroy            WMain                              //Get rid of the Bank Window
                    winshow
                    return
.=============================================================================
MainCancel                             // Cancel button has been pressed
;
                    if                (RecordStatus = "")                      // They want to exit the program
                      destroy         WMain                             // Get rid of the Main Window
                      winshow
                      return
                    else
                      if                (RecordStatus = "N" OR RecordStatus = "U")  . Change/New Mode
                        beep
                        alert              PLAIN,"Do you wish to cancel this operation?",RETURNFL:
                                                 "Are you sure?"
                        call               MainReset if (ReturnFl = 1)
                      else
                        call              MainReset
                      endif
                    endif
                    return
;==========================================================================================================
MainDelete                             // Delete Button has been Pressed
;
                   pack             AlertString from "Do you wish to Delete the ",CntryTitle,": ",Cntry.Code,"?"
                   BEEP
                   ALERT            PLAIN,AlertString,AlertResult,DelTitle
                   IF               (AlertResult = 1)
                     CALL             DELCntry
                     pack             AlertString from "Cntryx has been deleted"
                     ALERT            NOTE,AlertString,AlertResult,DelOKTitle
                     CALL             MAINRESET
                   ENDIF
                   RETURN
;==========================================================================================================
SetMain                                // Setup all of the fields in the Form based upon the data record

                   setprop           ECntryCode,text=Cntry.Code
                   RETURN
;==========================================================================================================
GetMain                                // Retrieve all of the fields in the Form based upon the data record

                   getprop           ECntryCode,text=Cntry.Code
                   RETURN
;==========================================================================================================
MainHelp
;
; Help Menu selection if required
;
                   RETURN
;==========================================================================================================
mainHelpContents
;
;Help Menu to bring up the Contents of the help file
;
                   RETURN
;==========================================================================================================
MainHelpSearch
;
; Help Menu to Search the help file
;
                   RETURN
;==========================================================================================================
onClickMainWinChangeMenu
                   PERFORM           RESULT OF  MAINNEW,MAINCHANGE,MainDelete,SAVEMODE
                   RETURN
;==========================================================================================================
onClickMainWinExitButton
;
; check to see if this is masquerading as a CANCEL button
;
                   CALL              MainCancel
                   RETURN
;==========================================================================================================
onClickMainWinFileMenu
;
; process a click on the file menu
;
                   PERFORM           result of MainPrint,,MAINCLOSE
                   RETURN
;==========================================================================================================
onClickMainWinHelpMenu
                   PERFORM           result of MAINHELP,MAINHELP,MAINAbout
                   RETURN
;==========================================================================================================
MainAbout                              // Display the Standard "About Box"
;
; Display an alert box describing the program
;
                   getmode           *ProgName=ProgramName
                   getmode           *ProgStamp=ProgramStamp
                   getmode           *ProgVer=ProgramVer
                   CALL              About using ProgramName,ProgramStamp,ProgramVer,MajorMinorVersion

                   SETFOCUS          WMain
                   RETURN
;==========================================================================================================
MainAboutChiron                        // Display the Standard "About Chiron"
;
; display an alert box describing the program
;
                   CALL              AboutChiron
                   SETFOCUS          WMain
                   RETURN
;==========================================================================================================
MainPrint                              // Print Report option
;
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
DisableRecordButtons
;
; Disable the 'Record' Buttons because we're in the middle of Updating or
; Creating a New record.
;
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
EnableRecordButtons
;
; Enable the 'Record' Buttons because we're in the middle of Updating or
; Creating a New record.
;
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
OpenAllFiles
                    TRAP               ErrorRoutines if IO NORESET
                    CALL               OpenCntry
                    TRAPCLR            IO
                    return
;==========================================================================================================
LoadDefaultValues                       // Setup the Default values when adding a new record
;
; Set the values and properties when adding new record
;
                    return
;==========================================================================================================
Harry1
KeyPress_ECntryCode
                   F2SEARCH          ECntryCode
                   RETURN


;==========================================================================================================
                   include           MenuDefs.INC

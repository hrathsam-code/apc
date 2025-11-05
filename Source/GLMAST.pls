;=============================================================================;
;       created by:  chiron software & services, inc.                         ;
;                    4 norfolk lane                                           ;
;                    bethpage, ny  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  program:    glmast                                                   ;
;                                                                             ;
;   author:    harry rathsam                                                  ;
;                                                                             ;
;     date:    01/28/2019 at 7:18pm                                             ;
;                                                                             ;
;  purpose:                                                                   ;
;                                                                             ;
; revision:    ver     date     init       details                            ;
;                                                                             ;
;              1.0   01/28/2019   hor     initial version                     ;
;                                                                             ;
;                                                                             ;
;=============================================================================;
.
           INCLUDE           Common
           INCLUDE           WORKVAR.INC
           include                     Sequence.FD
           INCLUDE              PrintRtn.INC
#RESULT    FORM              1
           GOTO              STARTPGM
           INCLUDE           GLMast.FD

MAIN       PLFORM            GLMast.PLF
About      PLFORM            About.PLF
DataMenu            plform             DataMenu


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
             PACK              EnvData,EnvData,GLMastHelp
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
           CALL              OPENGLMast
           TRAPCLR           IO

GLMastCOLL  COLLECTION
GLMastEDT   COLLECTION

           LISTINS           GLMastCOLL,EGLMstAccount,EGLMstDesc,EGLMstFSDesc,CBAccountType:
                                        CBAccountGroup,EGLMstFSCategory,CBGLMstIndicator
           LISTINS           GLMastEDT,EGLMstAccount,EGLMstDesc,EGLMstFSDesc:
                                       EGLMstFSCategory


           winhide



           FORMLOAD          MAIN2
           FORMLOAD          DataMenu,WMain

           setfocus                    EGLMstAccount
           LOOP
             WAITEVENT
           REPEAT
.
. We never get here!!   Just in case though.... :-)
.
           RETURN
.           STOP
;==========================================================================================================
OnClickGLAccount
                    F2SEARCH          EGLMstAccount
                    if                 (PassedVar="Y")
                      call               MainValid
                    endif
                    return
;==========================================================================================================

BROWSEFILE ROUTINE
SEARCH     PLFORM            SEARCH4.PLF

           CALL                 OpenGLMast

           FORMLOAD          SEARCH
           RETURN

INITSRCH
           PACK              SearchTitle,GLMastTitle," Search Window"
           SETPROP           WSearch,Title=SearchTitle

           CTADDCOL          "G/L Code",100,"G/L Description",200


           move              " ",GLMastKY
           call              RDGLMast
           loop
             call              KSGLMast
           until (ReturnFl = 1)
             CTLoadRecord2     GLMast,GLMast,GLMast.Account,GLMast.Account,GLMast.Desc
             repeat
           RETURN
           RETURN
.
. Routines that operate the Main program
.
;==========================================================================================================
ItemSelected
                    LVSearchPLB.GetNextItem giving RowSelected using *Flags=02,*Start=FirstRow
                    if                 (RowSelected != -1)
                      LVSearchPLB.GetItemText giving $SearchKey using *Index=RowSelected,*SubItem=0
                      MOVE               "Y",PassedVar
                      DESTROY            WSearch
                    endif
                    return
;==========================================================================================================

NOFILE
           NORETURN
           ALERT             PLAIN,"GL Master file does not exist. Do you wish to create it?",#RESULT
           STOP

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
ToCode     DIM               8
.X .
PrintAll      FORM              1


PRTREPORT
GLMastRPT   PLFORM            GLMastRPT.PLF
.           WINHIDE

           CLOCK             DATE,TODAY8


           FORMLOAD          GLMastRPT
           RETURN

.           alert             note,"how???",returnfl
.           LOOP                                              .Wait...and Wait...
.             WAITEVENT                                       .
.           REPEAT                                            .and wait

START
.
.
. Since we're dealing with a sorted file, we're going to read it in
. Sequential order vs. Key Sequential.  Also, we must make sure that
. we don't read any records that we're not supposed to based on the
. code that was in the other program. (AP42.DBS)
.
           MOVE              " ",GLMastKY

           GETITEM           RAll,0,PrintAll
           IF                   (PrintAll = 1)
             MOVE              "            ",ToCode
             MOVE              "ZZZZZZZZZZZZ",ToCode
           ELSE
             GETITEM           EFromRange,0,GLMastKY
             GETITEM           EToRange,0,ToCode
             IF                (ToCode < GLMastKY)
               BEEP
               ALERT             STOP,"From Code cannot be less than the To Code",RETURNFL,"Range Error"
               SETFOCUS          ETORANGE
               RETURN
             ENDIF
           ENDIF

           CALL                 PrintPreviewInit

           MOVE              "1200",PrintLineCnt
           CALL              RDGLMast
           LOOP
             CALL              KSGLMast
           UNTIL             (RETURNFL = 1 OR (GLMast.Account > ToCode and PrintAll = 1))
             CALL              PRTLINE
           REPEAT
.
. Print Totals line
.
              ADD               DoubleLine,PrintLineCnt
              EndofPage
           PRTPAGE              P;*P=100:PrintLineCnt,"G/L Master Records Printed"
           CALL              PrintClose
           RETURN
.
. Print Each Detailed line
.
PRTLINE
           EndOfPage
           PRTPAGE           P;*P=10:PrintLineCnt,GLMast.Account:
                               *P=130:PrintLineCnt,GLMast.Desc
.                                     *Alignment=*Right:
..                                     *38,Num1:
..                                     *50,Num2:
.                                     *Alignment=*Decimal:
.                                     *61,GLMast.DiscPerc:
.                                     *Alignment=*Left

           ADD                  SingleLine,PrintLineCnt
           RETURN

PrintCustomHeader

              RETURN


EXITASK
           ALERT             PLAIN,"Are you sure you wish to exit this report?",#RESULT
           IF                (#RESULT=1)
             STOP
           ENDIF
           RETURN

.=============================================================================
#RES1      FORM              1
#DIM1      DIM               1
#DIM2      DIM               2
#RES2      FORM              2
#LEN1      FORM              3
#MenuObj   Automation
#MenuItem  DIM               25
.
.=============================================================================
.
MaintMenuOption
                    CALL                 GetMenuName

                    RETURN
;==========================================================================================================

MainValid
           IF                (Status = 0)
             GETCOUNT          EGLMstAccount
             IF                (CharCount > 0)
               GETITEM           EGLMstAccount,0,GLMastKY
               CALL              RDGLMast
               IF               (RETURNFL = 1)
                 PARAMTEXT        GLMastTITLE,GLMastKY,"",""
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

.               DISABLEITEM       BMainNEW
.               DISABLETOOL       ID_New

               ENABLEITEM        BMainDELETE
               ENABLETOOL        ID_Delete

               DISABLEITEM       EGLMstAccount
               DISABLEITEM       Fill1
.1               DISABLEITEM       ChangeMenu,1
.1               ENABLEITEM        ChangeMenu,2
.1               ENABLEITEM        ChangeMenu,3
.1               DISABLEITEM       ChangeMenu,4
               SETFOCUS          BMainChange
             ENDIF
           ENDIF
           RETURN

.=============================================================================
. Initialize MAIN Form and setup the Menu's, Fields, Objects, Buttons, etc
.
MAININIT
.           CREATE            WMAIN;HelpMenu,HelpMenuTxt
.           CREATE            WMAIN;ChangeMenu,ChngMenuTxt
.           CREATE            WMAIN;FileMenu,FileMenuTxt
.
.           ACTIVATE          HelpMenu,onClickMainWinHelpMenu,result
.           ACTIVATE          ChangeMenu,onClickMainWinChangeMenu,result
.           ACTIVATE          FileMenu,onClickMainWinFileMenu,result
.
. Set the SELECTALL property for the COLLECTION and then take care of
. any ActiveX controls.
.
           SETPROP           GLMastEDT,SELECTALL=$SelectAll
.
           CALL              MAINRESET
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
             GETITEM           EGLMstAccount,0,GLMastKY
             CALL              TSTGLMast
             IF                (RETURNFL = 1)
               CALL              WRTGLMast
               CALL              MAINRESET
               RETURN
             ELSE
               PARAMTEXT       GLMastTITLE,GLMastKY,"",""
               BEEP
               ALERT           Note,"^0 with code ^1 already exists. Please enter another code",result:
                                    "Record already exists"
               SETFOCUS        EGLMstAccount
             ENDIF                                //Valid record exists???
           ELSE
             CALL              MainReset
             MOVE              "2",Status
             CALL              DisableRecordButtons
.
. Enable all of the EditText fields and set the EditText fields
. to Non Read-Only
.
             ENABLEITEM        GLMastEDT
             DISABLEITEM       Fill1
             %IFDEF            CBGLMastActive
             ENABLEITEM        CBGLMastActive
             %ENDIF

             SETPROP           GLMastEDT,READONLY=0
             SETPROP           GLMastEDT,BGCOLOR=$WINDOW
.
. We also need to set any ActiveX controls to the same properties
.
.             SETPROP           EGLMastDiscPerc,*Enabled=1
.             SETPROP           EGLMastDiscPerc,*BackColor=$Window
.
. Setup any DEFAULT values
.
.             SETITEM           EGLMastDISCDAYS,0,"0"
.
. Disable & Enable the proper Buttons along with changing
. the description of the Button's (i.e. Exit --> Change)
.
             DISABLEITEM       BMainCHANGE
             DISABLETOOL       ID_Change

             DISABLEITEM       BMainDELETE
             DISABLETOOL       ID_Delete

             SETITEM           BMainNEW,0,SaveTitle
             ENABLETOOL        ID_Save

             SETITEM           BMainCancel,0,CancelTitle
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
             SETFOCUS          EGLMstAccount
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
               CALL              UPDGLMast                //Update the record
               CALL              MAINRESET               //Reset the objects & fields
             ENDIF
             RETURN                                      //Voila...Either way, we're RETURNING
           ENDIF
           GETCOUNT          EGLMstAccount
           IF                (Charcount > 0)
             GETITEM           EGLMstAccount,0,GLMastKY      //Read the Primary field ito the Key

             CALL              RDGLMastLK               //Lock the record so that nobody uses it
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
             ENABLEITEM        GLMastCOLL
             DISABLEITEM       Fill1
             %IFDEF            CBGLMastActive
             ENABLEITEM        CBGLMastActive
             %ENDIF
             SETPROP           GLMastCOLL,READONLY=0
             SETPROP           GLMastCOLL,BGCOLOR=$WINDOW
.
. OK, OK...What do we do with any ActiveX components. We've got to handle
. them as well.  Let's change these to Non Read-Only and change the
. Background colors as well
.
.             SETPROP           EGLMastDiscPerc,*Enabled=1
.             SETPROP           EGLMastDiscPerc,*BackColor=$Window
.
. Change the Cancel button button to 'Save' and the 'Exit' button to Cancel
.
             SETITEM           BMainCancel,0,CancelTitle
             ENABLETOOL        ID_Cancel

             SETITEM           BMainCHANGE,0,SaveTitle
             ENABLETOOL        ID_Save
.
             ENABLETOOL        ID_Undo
             DISABLETOOL       ID_Change
.
             DISABLETOOL       ID_New
             DISABLEITEM       BMainNew
.
             SETFOCUS          EGLMstDesc               //Set the cursor to the next field
             DISABLEITEM       EGLMstAccount               //and Disable the Primary Code
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
             CALL              RDGLMastLK
             CALL              SetMain
           ENDIF
           RETURN
.=============================================================================
MainFind
           FindSearch        EGLMstAccount
           IF                (PassedVar = "Y")
             GETITEM           EGLMstAccount,0,GLMastKY
             MOVE              $SearchKey,GLMastKY
             CALL              RDGLMast
.
. We've got a record thanks to our Trusy Search/Browse window. Let's
. continue now by setting up the proper Code field and calling the
. MainValid subroutine, that will take care of it for us.
.
             MOVE              "0",Status
             SETITEM           EGLMstAccount,0,GLMast.Account
             CALL              MainValid
           ENDIF
           RETURN
.=============================================================================
. Routine to read the First record and display it
.
MainFirst
           CLEAR             GLMastKY
           FILL              FirstASCII,GLMastKY
           CALL              RDGLMast
           IF                (RETURNFL = 1)  . We didn't find a 'Blank' record
             CALL              KSGLMast         . Try the 'next' record
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
           SETITEM           EGLMstAccount,0,GLMast.Account
           CALL              MainValid
           RETURN
.=============================================================================
. Routine to read the Last record and display it
.
MainLast
           CLEAR             GLMastKY
           FILL              LastASCII,GLMastKY
           CALL              RDGLMast
           IF                (RETURNFL = 1)  . We didn't find a 'Blank' record
             CALL              KPGLMast         . Try the 'Previous' record
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
           SETITEM           EGLMstAccount,0,GLMast.Account
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
           GETCOUNT          EGLMstAccount
           IF                (CharCount <> 0)
             GETITEM           EGLMstAccount,0,GLMastKY
             CALL              RDGLMast
           ENDIF
.
           CALL              KSGLMast         . Try the 'next' record
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
           SETITEM           EGLMstAccount,0,GLMast.Account
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
           GETCOUNT          EGLMstAccount
           IF                (CharCount <> 0)
             GETITEM           EGLMstAccount,0,GLMastKY
             CALL              RDGLMast
           ENDIF
.
           CALL              KPGLMast         . Try the 'Previous' record
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
           SETITEM           EGLMstAccount,0,GLMast.Account
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

.X           GETITEM           EGLMstAccount,0,TestChars
.X           COUNT             CharCount,TestChars
.X           IF                (CharCount = 0)
.X             MOVE            "1",ValidFlag
.X             BEEP
.X             ALERT             CAUTION,"A Code must be entered into the system",RETURNFL,"Error in Field"
.X             SETFOCUS          EGLMstAccount
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
           MOVE              "0",Status     //Reset the status to Not updating
           UNLOCK            GLMastFL
.
. Reset the fields to 'Blank' and DISABLE all of those fields as well
..HR 12/28/2007           DELETEITEM        GLMastCOLL,0
           DELETEITEM        GLMastEDT,0
           DISABLEITEM       GLMastCOLL
           SETPROP           GLMastCOLL,READONLY=1
           SETPROP           GLMastCOLL,BGCOLOR=$BTNFACE
           ENABLEITEM        Fill1
.
. Reset the Buttons for the Next record
.
           DISABLEITEM       BMainChange
           DISABLETOOL       ID_Change

           DISABLEITEM       BMainDELETE
           DISABLETOOL       ID_Delete

           SETITEM           BMainCHANGE,0,ChangeTitle

           SETITEM           BMainNEW,0,NewTitle
           ENABLETOOL        ID_New

           ENABLEITEM        BMainNEW
           SETITEM           BMainCancel,0,ExitTitle

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
.           SETPROP           EGLMastDiscPerc,*Text="0"
.           SETPROP           EGLMastDiscPerc,*Enabled=0
.           SETPROP           EGLMastDiscPerc,*BackColor=$BTNFACE
.
. Setup the Primary field that is used for Entry purposes
.
           %IFDEF            CBGLMastActive
           SETITEM           CBGLMastActive,0,0
           DISABLEITEM       CBGLMastActive
           %ENDIF

           SETPROP           EGLMstAccount,READONLY=0
           SETPROP           EGLMstAccount,BGCOLOR=$WINDOW
           ENABLEITEM        EGLMstAccount
           SETFOCUS          EGLMstAccount
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
..not yet               NORETURN                   . Get rid of the call to MAINCLOSE
..not yet               RETURN                     . Return to the Main calling routine
             winshow
             Chain      FROMPGM
             ELSE
               RETURN                     . Contine with standard operations
             ENDIF
           ENDIF
           DESTROY         WMAIN          . Get rid of the Bank Window
..not yet           NORETURN                       . We don't need this call anymore
             winshow
             Chain      FROMPGM

           RETURN
.=============================================================================
. Cancel button has been pressed
.
MainCancel
           IF                (Status = 0)      . They want to exit the program
             DESTROY         WMAIN             . Get rid of the Main Window
..not yet             NORETURN
..not yet             RETURN
           winshow
           CHAIN      FROMPGM
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
           PARAMTEXT        GLMast.Account,GLMastTitle,"",""
           BEEP
           ALERT            PLAIN,"Do you wish to Delete the ^1: ^0 ?",#RES1,DelTitle
           IF               (#RES1 = 1)
             CALL             DELGLMast
             ALERT            NOTE,"A/P Term Code ^0 has been deleted",#RES1,DelOKTitle
             CALL             MAINRESET
           ENDIF
           RETURN
.=============================================================================
.
. Setup all of the fields in the Form based upon the data record
SETMAIN
           SETITEM           EGLMstAccount,0,GLMast.Account
.           SETPROP           EGLMastDiscPerc,*Text=GLMast.DiscPerc
           %IFDEF            CBGLMastActive
           SETITEM           CBGLMastActive,0,GLMast.Active
           %ENDIF

           SETITEM              EGLMstDesc,0,GLMast.Desc
           SETITEM              EGLMstFSDesc,0,GLMast.FSDesc
..HR 12/28/2007           SETITEM              EGLMstGLCategory,0,GLMast.GLCategory
           SETITEM              CBAccountGroup,0,GLMast.GLCategory
           SETITEM              CBAccountType,0,GLMast.Type
           SETITEM              EGLMstDesc,0,GLMast.Indicator
           SETITEM              EGLMstFSCategory,0,GLMast.FSCategory
           RETURN
.=============================================================================
. Retrieve all of the fields in the Form based upon the data record
.
GETMAIN
           GETITEM           EGLMstAccount,0,GLMast.Account
.           GETPROP           EGLMastDiscPerc,*Text=GLMast.DiscPerc
           %IFDEF            CBGLMastActive
           GETITEM           CBGLMastActive,0,GLMast.Active
           %ENDIF

           GETITEM              EGLMstDesc,0,GLMast.Desc
           GETITEM              EGLMstFSDesc,0,GLMast.FSDesc
..HR 12/28/2007           GETITEM              EGLMstGLCategory,0,GLMast.GLCategory
..HR 12/28/2007           GETITEM              EGLMstType,0,GLMast.Type
           GETITEM              CBAccountGroup,0,GLMast.GLCategory
           GETITEM              CBAccountType,0,GLMast.Type

           GETITEM              EGLMstDesc,0,GLMast.Indicator
           GETITEM              EGLMstFSCategory,0,GLMast.FSCategory
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
           CALL              PRTREPORT
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
;==========================================================================================================
                    include            MenuDefs.INC



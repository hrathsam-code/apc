......................................................................
.    Chiron Software & Services, Inc.
.    4 Norfolk Lane
.    Bethpage, Ny  11714
.    (516) 935-0196
.
.
. Program Created On : 02/15/02 At 3:00:am
.
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
           EVENTINFO         0,ARG1=#MenuObj
           GETPROP           #MenuObj,*ID=#MenuItem
.
           SELECT            USING #MenuItem
           WHEN              "ID_New"
             CALL              MainNew
             RETURN
           WHEN              "ID_Exit"
             CALL              MainClose
             RETURN
           WHEN              "ID_Print"
             CALL              MainPrint
             RETURN
           WHEN              "ID_Cancel"
             CALL              MainCancel
             RETURN
           WHEN              "ID_Change"
             CALL              MainChange
             RETURN
           WHEN              "ID_Delete"
             CALL              MainDelete
             RETURN
           WHEN              "ID_Find"
             CALL              MainFind
             RETURN
           WHEN              "ID_First"
             CALL              MainFirst
             RETURN
           WHEN              "ID_Last"
             CALL              MainLast
             RETURN
           WHEN              "ID_Next"
             CALL              MainNext
             RETURN
           WHEN              "ID_Previous"
             CALL              MainPrevious
             RETURN
           WHEN              "ID_About"
             CALL              MainAbout
             RETURN
           WHEN              "ID_Save"
             CALL              SaveMode
             RETURN
           WHEN              "ID_Undo"
             CALL              MainUndo
             RETURN
           WHEN              "ID_ShowToolbar"
             CALL              MainToolbar
             RETURN
           DEFAULT
           ENDSELECT
           RETURN

MainValid
           IF                (Status = 0)
             GETCOUNT          ECNTRYCODE
             IF                (CharCount > 0)
               GETITEM           ECNTRYCODE,0,CNTRYKY
               CALL              RDCNTRY
               IF               (RETURNFL = 1)
                 PARAMTEXT        CNTRYTITLE,CNTRYKY,"",""
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

               DISABLEITEM       BMainNEW
               DISABLETOOL       ID_New

               ENABLEITEM        BMainDELETE
               ENABLETOOL        ID_Delete

               DISABLEITEM       ECNTRYCODE
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
           SETPROP           CNTRYEDT,SELECTALL=$SelectAll
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
             GETITEM           ECNTRYCode,0,CNTRYKY
             CALL              TSTCNTRY
             IF                (RETURNFL = 1)
               CALL              WRTCNTRY
               CALL              MAINRESET
               RETURN
             ELSE
               PARAMTEXT       CNTRYTITLE,CNTRYKY,"",""
               BEEP
               ALERT           Note,"^0 with code ^1 already exists. Please enter another code",result:
                                    "Record already exists"
               SETFOCUS        ECNTRYCode
             ENDIF                                //Valid record exists???
           ELSE
             MOVE              "2",Status
             CALL              DisableRecordButtons
.
. Enable all of the EditText fields and set the EditText fields
. to Non Read-Only
.
             ENABLEITEM        CNTRYEDT
             DISABLEITEM       Fill1
             %IFDEF            CBCNTRYActive
             ENABLEITEM        CBCNTRYActive
             %ENDIF

             SETPROP           CNTRYEDT,READONLY=0
             SETPROP           CNTRYEDT,BGCOLOR=$WINDOW
.
. We also need to set any ActiveX controls to the same properties
.
.             SETPROP           ECNTRYDiscPerc,*Enabled=1
.             SETPROP           ECNTRYDiscPerc,*BackColor=$Window
.
. Setup any DEFAULT values
.
.             SETITEM           ECNTRYDISCDAYS,0,"0"
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
             SETFOCUS          ECNTRYCode
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
               CALL              UPDCNTRY                //Update the record
               CALL              MAINRESET               //Reset the objects & fields
             ENDIF
             RETURN                                      //Voila...Either way, we're RETURNING
           ENDIF
           GETCOUNT          ECNTRYCODE
           IF                (Charcount > 0)
             GETITEM           ECNTRYCODE,0,CNTRYKY      //Read the Primary field ito the Key

             CALL              RDCNTRYLK               //Lock the record so that nobody uses it
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
             ENABLEITEM        CNTRYCOLL
             DISABLEITEM       Fill1
             %IFDEF            CBCNTRYActive
             ENABLEITEM        CBCNTRYActive
             %ENDIF
             SETPROP           CNTRYCOLL,READONLY=0
             SETPROP           CNTRYCOLL,BGCOLOR=$WINDOW
.
. OK, OK...What do we do with any ActiveX components. We've got to handle
. them as well.  Let's change these to Non Read-Only and change the
. Background colors as well
.
.             SETPROP           ECNTRYDiscPerc,*Enabled=1
.             SETPROP           ECNTRYDiscPerc,*BackColor=$Window
.
. Change the Cancel button button to 'Save' and the 'Exit' button to Cancel
.
             SETITEM           BMainCancel,0,CancelTitle
             ENABLETOOL        ID_Cancel

             SETITEM           BMainCHANGE,0,SaveTitle
             ENABLETOOL        ID_Save
.
             SETFOCUS          ECNTRYName               //Set the cursor to the next field
             DISABLEITEM       ECNTRYCODE               //and Disable the Primary Code
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
             CALL              RDCNTRYLK
             CALL              SetMain
           ENDIF
           RETURN
.=============================================================================
MainFind
           FindSearch        ECNTRYCode
           GETITEM           ECNTRYCode,0,CNTRYKY
           MATCH             CNTRYKY,$SearchKey
           IF                NOT EQUAL
             MOVE              $SearchKey,CNTRYKY
             CALL              RDCNTRY
.
. We've got a record thanks to our Trusy Search/Browse window. Let's
. continue now by setting up the proper Code field and calling the
. MainValid subroutine, that will take care of it for us.
.
             MOVE              "0",Status
             SETITEM           ECNTRYCode,0,Cntry.Code
             CALL              MainValid
           ENDIF
           RETURN
.=============================================================================
. Routine to read the First record and display it
.
MainFirst
           CLEAR             CNTRYKY
           FILL              FirstASCII,CNTRYKY
           CALL              RDCNTRY
           IF                (RETURNFL = 1)  . We didn't find a 'Blank' record
             CALL              KSCNTRY         . Try the 'next' record
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
           SETITEM           ECNTRYCode,0,Cntry.Code
           CALL              MainValid
           RETURN
.=============================================================================
. Routine to read the Last record and display it
.
MainLast
           CLEAR             CNTRYKY
           FILL              LastASCII,CNTRYKY
           CALL              RDCNTRY
           IF                (RETURNFL = 1)  . We didn't find a 'Blank' record
             CALL              KPCNTRY         . Try the 'Previous' record
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
           SETITEM           ECNTRYCode,0,Cntry.Code
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
           GETCOUNT          ECNTRYCode
           IF                (CharCount <> 0)
             GETITEM           ECNTRYCode,0,CNTRYKY
             CALL              RDCNTRY
           ENDIF
.
           CALL              KSCNTRY         . Try the 'next' record
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
           SETITEM           ECNTRYCode,0,Cntry.Code
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
           GETCOUNT          ECNTRYCode
           IF                (CharCount <> 0)
             GETITEM           ECNTRYCode,0,CNTRYKY
             CALL              RDCNTRY
           ENDIF
.
           CALL              KPCNTRY         . Try the 'Previous' record
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
           SETITEM           ECNTRYCode,0,Cntry.Code
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

           GETCOUNT          ECntryCode
           IF                (CharCount = 0)
             MOVE            "1",ValidFlag
             BEEP
             ALERT             CAUTION,"A Code must be entered into the system",RETURNFL,"Error in Field"
             SETFOCUS          ECNTRYCode
             RETURN
           ENDIF

           GETCOUNT          ECntryName
           IF                (CharCount = 0)
             MOVE            "1",ValidFlag
             BEEP
             ALERT             CAUTION,"A Country Description must be entered into the system",RETURNFL,"Error in Field"
             SETFOCUS          ECNTRYName
             RETURN
           ENDIF



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
           UNLOCK            CNTRYFL
.
. Reset the fields to 'Blank' and DISABLE all of those fields as well
           DELETEITEM        CNTRYCOLL,0
           DISABLEITEM       CNTRYCOLL
           SETPROP           CNTRYCOLL,READONLY=1
           SETPROP           CNTRYCOLL,BGCOLOR=$BTNFACE
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
.           SETPROP           ECNTRYDiscPerc,*Text="0"
.           SETPROP           ECNTRYDiscPerc,*Enabled=0
.           SETPROP           ECNTRYDiscPerc,*BackColor=$BTNFACE
.
. Setup the Primary field that is used for Entry purposes
.
           %IFDEF            CBCNTRYActive
           SETITEM           CBCNTRYActive,0,0
           DISABLEITEM       CBCNTRYActive
           %ENDIF

           SETPROP           ECNTRYCODE,READONLY=0
           SETPROP           ECNTRYCode,BGCOLOR=$WINDOW
           ENABLEITEM        ECNTRYCODE
           SETFOCUS          ECNTRYCODE
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
               NORETURN                   . Get rid of the call to MAINCLOSE
               RETURN                     . Return to the Main calling routine
             ELSE
               RETURN                     . Contine with standard operations
             ENDIF
           ENDIF
           DESTROY         WMAIN          . Get rid of the Bank Window
           NORETURN                       . We don't need this call anymore
           RETURN
.=============================================================================
. Cancel button has been pressed
.
MainCancel
           IF                (Status = 0)      . They want to exit the program
             NORETURN
             DESTROY         WMAIN             . Get rid of the Main Window
             RETURN
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
           PARAMTEXT        Cntry.Code,CNTRYTitle,"",""
           BEEP
           ALERT            PLAIN,"Do you wish to Delete the ^1: ^0 ?",#RES1,DelTitle
           IF               (#RES1 = 1)
             CALL             DELCNTRY
             ALERT            NOTE,"A/P Term Code ^0 has been deleted",#RES1,DelOKTitle
             CALL             MAINRESET
           ENDIF
           RETURN
.=============================================================================
.
. Setup all of the fields in the Form based upon the data record
SETMAIN
           SETITEM           ECNTRYCode,0,Cntry.CODE
           SETITEM           ECntryName,0,Cntry.Name
           %IFDEF            CBCNTRYActive
           SETITEM           CBCNTRYActive,0,Cntry.Active
           %ENDIF

           RETURN
.=============================================================================
. Retrieve all of the fields in the Form based upon the data record
.
GETMAIN
           GETITEM           ECNTRYCode,0,Cntry.CODE
           GETITEM           ECntryName,0,Cntry.Name
           %IFDEF            CBCNTRYActive
           GETITEM           CBCNTRYActive,0,Cntry.Active
           %ENDIF
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


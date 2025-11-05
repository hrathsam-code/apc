;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    4 NORFOLK LANE                                           ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    Defaults                                                       ;
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
                   INCLUDE           WORKVAR.INC
#RESULT            FORM              1
#RES1              FORM              1
#DIM1              DIM               1
#DIM2              DIM               2
#RES2              FORM              2
#LEN1              FORM              3
#MenuItem          DIM               25
                   GOTO              STARTPGM
                   INCLUDE           Defaults.FD
                   include             DefaultEmail.FD
                   include             Cntry.FD
                   include             State.FD
                   include             Class.FD
                   include             Type.FD
                   include             ARTRM.FD


MAIN               PLFORM            Defaults2.PLF
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
                     PACK              EnvData,EnvData,DefaultsHelp
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
                   CALL              OPENDefaults
                   call                OpenDefaultEmail
                   call                OpenARTRM
                   call                OpenClass
                   call                OpenState
                   call                OpenType
                   call                OpenCntry

                   TRAPCLR           IO

DefaultsCOLL          COLLECTION
DefaultsEDT           COLLECTION
DefaultsActive        COLLECTION

;
; Includes ALL fields
;
                   LISTINS           DefaultsCOLL,EName,EAddress1,EAddress2,EAddress3

                   LISTINS           DefaultsEDT,EName,EAddress1,EAddress2,EAddress3,ECity,ESt,EZip,ECountry:
                                                 ECustTerm,ECustCountry,EVendCountry,EVendType,EVendClass:
                                                 EVendTerm,ESmtpServer,ESmtpUserName,ESmtpPassword:
                                                 NSmtpPort,EEMailAddress,EEMailText,ESubject

                   LISTINS           DefaultsActive,BSearchCountry,BSearchARTerm,BSearchCustCountry:
                                                    ECustInvType,BSearchVendCountry,EVendPOType:
                                                    BSearchType,BSearchClass,BSearchVendTerm:
                                                    CBEmailType,CBMessageType,CBPrimary

.                  winhide
                   FORMLOAD          MAIN
                   FORMLOAD          DataMenu,WMain

                   call              MainReset
                   setfocus          EEntity

                   LOOP
                     WAITEVENT
                   REPEAT
.
. We never get here!!   Just in case though.... :-)
.
                   RETURN
.                  STOP

BROWSEFILE         ROUTINE
SEARCH              PLFORM            SEARCH4.PLF
                    CALL                 OpenDefaults
                   RETURN

INITSRCH
           PACK              SearchTitle,DefaultsTitle," Search Window"
           SETPROP           WSearch,Title=SearchTitle

           CTADDCOL          "Entity",100,"Entity Name",150:
                             "Address 1",100

           move              " ",DefaultsKY
           call              RDDefaults
           loop
             call              KSDefaults
           until (ReturnFl = 1)
           CTLoadRecord2     Defaults,Defaults,Defaults.Entity,Defaults.Name,Defaults.Address1
             repeat
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
OnClickDefaults
                    F2SEARCH          EEntity
                    if                 (PassedVar="Y")
                      call               MainValid
                    endif
                    return
.
. Routines that operate the Main program
.
NOFILE
                   NORETURN
                   ALERT             PLAIN,"A/P Terms Master file does not exist. Do you wish to create it?",#RESULT
                   IF                (#RESULT = 1)
                     CALL              PREPDefaults
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
.X DefaultsRPT        PLFORM            DefaultsRPT.PLF
.X .               WINHIDE
.X
.X                 CLOCK             DATE,TODAY8
.X                 CLOCK             TIME,TIME8
.X
.X                 MOVE              "60",MAXROWS
.X                 MOVE              "0",PAGE
.X                 MOVE              "90",LINE
.X
.X                 FORMLOAD          DefaultsRPT
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
.X                 MOVE              " ",DefaultsKY
.X
.X                 GETITEM           RAll,0,RETURNFL
.X                 BRANCH            RETURNFL OF ALL
.X
.X                 GETITEM           EFromRange,0,DefaultsKY
.X                 GETITEM           EToRange,0,ToCode
.X
.X                 IF                (ToCode < DefaultsKY)
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
.X                 CALL              RDDefaults
.X                 LOOP
.X                   CALL              KSDefaults
.X                 UNTIL             (RETURNFL = 1 OR Defaults.Entity > ToCode)
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
.X                 CHOP              Defaults.NETDAYS,Defaults.NETDAYS
.X                 CHOP              Defaults.DISCDAYS,Defaults.DISCDAYS
.X
.X                 MOVE              Defaults.NETDAYS,NUM1
.X                 MOVE              Defaults.DISCDAYS,NUM2
.X
.X                 PRTPAGE           PRTFILE;*1,Defaults.Entity:
.X                                           *16,Defaults.Desc:
.X                                           *Alignment=*Right:
.X                                           *38,Num1:
.X                                           *50,Num2:
.X                                           *Alignment=*Decimal:
.X                                           *61,Defaults.DiscPerc:
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
                     GETCOUNT          EEntity
                     IF                (CharCount > 0)
                       getprop           EEntity,text=DefaultsKY
                       CALL              RDDefaults
                       IF               (RETURNFL = 1)
                         PARAMTEXT        DefaultsTITLE,DefaultsKY,"",""
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

                       ENABLEITEM        BMainDELETE
                       ENABLETOOL        ID_Delete
                       EnableDBMenu        MDeleteRecord

....                       DISABLEITEM       EEntity
                       setprop           EEntity,Static=1,BGColor=$BtnFace
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
                   SETPROP           DefaultsEDT,SELECTALL=$SelectAll
                   setprop             DefaultsActive,enabled=0
.
                   CALL              MAINRESET
                   RETURN
;==========================================================================================================
; New Button is pressed
;
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
                     getprop           EEntity,text=DefaultsKY
                     CALL              TSTDefaults
                     IF                (RETURNFL = 1)
                       CALL              WRTDefaults
                       CALL              MAINRESET
                       RETURN
                     ELSE
                       PARAMTEXT       DefaultsTITLE,DefaultsKY,"",""
                       BEEP
                       ALERT           Note,"^0 with code ^1 already exists. Please enter another code",result:
                                            "Record already exists"
                       SETFOCUS        EEntity
                     ENDIF                                //Valid record exists???
                   ELSE
                     CALL              MainReset
                     MOVE              "2",Status
                     CALL              DisableRecordButtons
.
. Enable all of the EditText fields and set the EditText fields
. to Non Read-Only
.
....                     ENABLEITEM        DefaultsEDT
                     setprop           DefaultsEDT,static=0,bgcolor=$Window
                     setprop           DefaultsActive,enabled=1
                     DISABLEITEM       Fill1
                     %IFDEF            CBDefaultsInactive
                     setprop           CBDefaultsInactive,enabled=1
                     %ENDIF

....                 SETPROP           DefaultsEDT,READONLY=0
....                 SETPROP           DefaultsEDT,BGCOLOR=$WINDOW
.
. We also need to set any ActiveX controls to the same properties
.
.                    SETPROP           EDefaultsDiscPerc,*Enabled=1
.                    SETPROP           EDefaultsDiscPerc,*BackColor=$Window
.
. Setup any DEFAULT values
.
.                    SETPROP          EDefaultsDISCDAYS,value=0
.
. Disable & Enable the proper Buttons along with changing
. the description of the Button's (i.e. Exit --> Change)
.
                     DISABLEITEM       BMainCHANGE
                     DISABLETOOL       ID_Change
                     DisableDBMenu     MModifyRecord

                     DISABLEITEM       BMainDELETE
                     DISABLETOOL       ID_Delete
                     DisableDBMenu     MDeleteRecord

                     setprop           BMainNEW,title=SaveTitle
                     ENABLETOOL        ID_Save
                     EnableDBMenu      MSaveRecord

                     setprop           BMainCancel,title=CancelTitle
                     ENABLETOOL        ID_Cancel

                     DISABLETOOL       ID_New
                     DisableDBMenu     MNewRecord

.
. Set the Focus to the first field that we're going to be Entering
.
                     SETFOCUS          EEntity
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
                       CALL              GETMAIN                 //Get all of the fields
                       CALL              UPDDefaults                //Update the record
                       CALL              MAINRESET               //Reset the objects & fields
                     ENDIF
                     RETURN                                      //Voila...Either way, we're RETURNING
                   ENDIF
                   GETCOUNT          EEntity
                   IF                (Charcount > 0)
                     getprop           EEntity,text=DefaultsKY   //Read the Primary field ito the Key

                     CALL              RDDefaultsLK               //Lock the record so that nobody uses it
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
....                     ENABLEITEM        DefaultsCOLL
                     DISABLEITEM       Fill1
                     %IFDEF            CBDefaultsInactive
....                     ENABLEITEM        CBDefaultsInactive
                     setprop           CBDefaultsInactive,enabled=1
                     %ENDIF
                     SETPROP           DefaultsEDT,static=0,bgcolor=$Window
                     setprop           DefaultsActive,enabled=1

.
. OK, OK...What do we do with any ActiveX components. We've got to handle
. them as well.  Let's change these to Non Read-Only and change the
. Background colors as well
.
.                    SETPROP           EDefaultsDiscPerc,*Enabled=1
.                    SETPROP           EDefaultsDiscPerc,*BackColor=$Window
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

                     SETFOCUS          EName                     //Set the cursor to the next field
....                     DISABLEITEM       EEntity               //and Disable the Primary Code
                     setprop           EEntity,Static=1,BGColor=$BtnFace
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
                     CALL              RDDefaultsLK
                     CALL              SetMain
                   ENDIF
                   RETURN
;==========================================================================================================
MainFind
                   FindSearch        EEntity
                   IF                (PassedVar = "Y")
                     getprop           EEntity,text=DefaultsKY
                     MOVE              $SearchKey,DefaultsKY
                     CALL              RDDefaults
.
. We've got a record thanks to our Trusy Search/Browse window. Let's
. continue now by setting up the proper Code field and calling the
. MainValid subroutine, that will take care of it for us.
.
                     MOVE              "0",Status
                     setprop           EEntity,text=Defaults.Entity
                     CALL              MainValid
                   else
                     setfocus          EEntity
                   ENDIF
                   RETURN
;==========================================================================================================
. Routine to read the First record and display it
.
MainFirst
                   CLEAR             DefaultsKY
                   FILL              FirstASCII,DefaultsKY
                   CALL              RDDefaults
                   IF                (RETURNFL = 1)  . We didn't find a 'Blank' record
                     CALL              KSDefaults         . Try the 'next' record
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
                   setprop           EEntity,text=Defaults.Entity
                   CALL              MainValid
                   RETURN
;==========================================================================================================
. Routine to read the Last record and display it
.
MainLast
                   CLEAR             DefaultsKY
                   FILL              LastASCII,DefaultsKY
                   CALL              RDDefaults
                   IF                (RETURNFL = 1)  . We didn't find a 'Blank' record
                     CALL              KPDefaults         . Try the 'Previous' record
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
                   setprop           EEntity,text=Defaults.Entity
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
                   GETCOUNT          EEntity
                   IF                (CharCount <> 0)
                     getprop           EEntity,text=DefaultsKY
                     CALL              RDDefaults
                   ENDIF

                   CALL              KSDefaults         . Try the 'next' record
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
                   setprop           EEntity,text=Defaults.Entity
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
                   GETCOUNT          EEntity
                   IF                (CharCount <> 0)
                     getprop           EEntity,text=DefaultsKY
                     CALL              RDDefaults
                   ENDIF

                   CALL              KPDefaults         . Try the 'Previous' record
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
                   setprop           EEntity,text=Defaults.Entity
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
                   unlock            Defaultsfl
.
. Reset the fields to 'Blank' and DISABLE all of those fields as well
...                   DELETEITEM        DefaultsCOLL,0
                   clear             Defaults
                   call              setmain

....                   DISABLEITEM       DefaultsCOLL
                   SETPROP           DefaultsEDT,static=1,bgcolor=$BtnFace
                   setprop           DefaultsActive,enabled=0

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

                   setprop           BMainNEW,title=NewTitle
                   ENABLETOOL        ID_New
                   EnableDBMenu      MNewRecord

                   ENABLEITEM        BMainNEW
                   setprop           BMainCancel,title=ExitTitle

                   DISABLETOOL       ID_Save
                   DISABLETOOL       ID_Undo
                   DISABLETOOL       ID_Cancel

                   DisableDBMenu     MSaveRecord

                   CALL              EnableRecordButtons
.
. Setup any ActiveX control fields to what they should be
.
.
. Setup the Primary field that is used for Entry purposes
.
                   %IFDEF            CBDefaultsInactive
                   setprop           CBDefaultsInactive,enabled=0,value=0
                   %ENDIF

....                   SETPROP           EEntity,READONLY=0
....                   SETPROP           EEntity,BGCOLOR=$WINDOW
                   SETPROP           EEntity,static=0,bgcolor=$Window
....                   ENABLEITEM        ETRoomNumber

....                   ENABLEITEM        EEntity
                   SETFOCUS          EEntity
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
                       NORETURN                   . Get rid of the call to MAINCLOSE
                       RETURN                     . Return to the Main calling routine
                     ELSE
                       RETURN                     . Contine with standard operations
                     ENDIF
                   ENDIF
                   DESTROY         WMAIN          . Get rid of the Bank Window
                   NORETURN                       . We don't need this call anymore
                   RETURN
;==========================================================================================================
; Cancel button has been pressed
;
MainCancel
                   IF                (Status = 0)      . They want to exit the program
                     DESTROY         WMAIN             . Get rid of the Main Window
                     NORETURN
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
;==========================================================================================================
. Delete Button has been Pressed
.
MainDelete
                   PARAMTEXT        Defaults.Entity,DefaultsTitle,"",""
                   BEEP
                   ALERT            PLAIN,"Do you wish to Delete the ^1: ^0 ?",#RES1,DelTitle
                   IF               (#RES1 = 1)
                     CALL             DELDefaults
                     ALERT            NOTE,"A/P Term Code ^0 has been deleted",#RES1,DelOKTitle
                     CALL             MAINRESET
                   ENDIF
                   RETURN
;==========================================================================================================
.
. Setup all of the fields in the Form based upon the data record
SETMAIN
;
; Set Main Address and Entity
;
                    setprop            EEntity,text=Defaults.Entity
                    setprop            EName,text=Defaults.Name
                    setprop            EAddress1,text=Defaults.Address1
                    setprop            EAddress2,text=Defaults.Address2
                    setprop            EAddress3,text=Defaults.Address3
                    setprop            ECity,text=Defaults.City
                    setprop            ESt,text=Defaults.St
                    setprop            EZip,text=Defaults.Zip
                    setprop            ECountry,text=Defaults.Country
                    setprop            CBPrimary,value=Defaults.ISPrimary
;
; Set Customer Information
;
                    setprop            ECustTerm,text=Defaults.CustTermCode
                    setprop            ECustCountry,text=Defaults.CustCountry
                    ECustInvType.SetCurSel using Defaults.CustInvMethod
;
; Vendor Information
;
                    setprop            EVendTerm,text=Defaults.VendTermCode
                    setprop            EVendCountry,text=Defaults.VendCountry
                    setprop            EVendType,text=Defaults.VendType
                    setprop            EVendClass,text=Defaults.VendClass
                    EVendPOType.SetCurSel using Defaults.VendContactMethod
;
; Set Email Default Information
;
                    setprop            ESmtpServer,text=Defaults.SmtpServer
                    setprop            ESmtpUserName,text=Defaults.SmtpUserName
                    setprop            ESmtpPassword,text=Defaults.SmtpPassword
                    setprop            NSmtpPort,value=Defaults.SmtpPort
;
; Set the Additional Info for E-mails to be used
;
                    CBEmailType.SetCurSel using DefaultEmail.EMailType
                    setprop            EEmailAddress,text=DefaultEmail.EmailFrom
                    CBMessageType.SetCurSel using DefaultEmail.MessageType
                    setprop            EEmailText,text=DefaultEMail.BodyText
                    setprop            ESubject,text=DefaultEMail.Subject

                   %IFDEF            CBDefaultsInactive
                   setprop           CBDefaultsInactive,value=Defaults.Inactive
                   %ENDIF
                   RETURN
;==========================================================================================================
. Retrieve all of the fields in the Form based upon the data record
.
GETMAIN
;
; Get Main Address and Entity
;
                    getprop            EEntity,text=Defaults.Entity
                    getprop            EName,text=Defaults.Name
                    getprop            EAddress1,text=Defaults.Address1
                    getprop            EAddress2,text=Defaults.Address2
                    getprop            EAddress3,text=Defaults.Address3
                    getprop            ECity,text=Defaults.City
                    getprop            ESt,text=Defaults.St
                    getprop            EZip,text=Defaults.Zip
                    getprop            ECountry,text=Defaults.Country
                    getprop            CBPrimary,value=Defaults.ISPrimary
;
; Get Customer Information
;
                    getprop            ECustTerm,text=Defaults.CustTermCode
                    getprop            ECustCountry,text=Defaults.CustCountry
                    ECustInvType.GetCurSel giving Defaults.CustInvMethod
;
; Vendor Information
;
                    getprop            EVendTerm,text=Defaults.VendTermCode
                    getprop            EVendCountry,text=Defaults.VendCountry
                    getprop            EVendType,text=Defaults.VendType
                    getprop            EVendClass,text=Defaults.VendClass
                    EVendPOType.GetCurSel giving Defaults.VendContactMethod
;
; Get Email Default Information
;
                    getprop            ESmtpServer,text=Defaults.SmtpServer
                    getprop            ESmtpUserName,text=Defaults.SmtpUserName
                    getprop            ESmtpPassword,text=Defaults.SmtpPassword
                    getprop            NSmtpPort,value=Defaults.SmtpPort
;
; Get the Additional Info for E-mails to be used
;
                    CBEmailType.GetCurSel giving DefaultEmail.EMailType
                    getprop            EEmailAddress,text=DefaultEmail.EmailFrom
                    CBMessageType.GetCurSel giving DefaultEmail.MessageType
                    getprop            EEmailText,text=DefaultEMail.BodyText
                    getprop            ESubject,text=DefaultEMail.Subject


                    %IFDEF             CBDefaultsInactive
                    getprop            CBDefaultsInactive,value=Defaults.Inactive
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
;==========================================================================================================
OnKeyPressARTRM
                    F2Search           ECustTerm,ARTrm
                    return
;==========================================================================================================
OnClickARTRM
                    BTSearch           ECustTerm,ARTrm
                    return

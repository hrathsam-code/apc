*...........................................................................
.
.Example Program: EDITTEXT.PLS
.
.  This demonstration programs shows some of the capabilities of the 
.  Edittext objects.
.
.  Copyright @ 1997, Sunbelt Computer Systems, Inc.
.  All Rights Reserved.
.............................................................................
.
. Revision History
.
. 9-10-98 JSS: Convert to GUI screen I/O
.              Modify search routine to work for newly entered text.
.
............................................................................
.
.Define the Replacement File Menu
.
FileMenu  MENU
FileData  INIT      ")File;E)xit"
*
.Define the New Search Menu
.
FindMenu  MENU
FindData  INIT      ")Search;/F)Find ...",011,"Ctrl+F;":
                    "/GFind a)gain",011,"Ctrl+G"
*
.Define the Find Dialog
.
FindDlg   DIALOG
FDData    INIT      "TYPE=MODELESS,":
                    "POS=15:12,":
                    "TITLE='Modeless Find Dialog',":
                    "BUTTON=4:4:25:31:'Find',":
                    "BUTTON=4:4:16:22:'Cancel',":
                    "TEXT=2:2:2:5:'Find:',":
                    "EDIT=2:2:6:31"
*
.Search Variables
.
SrchBtn   FORM      "1"
CanBtn    EQU       2
SrchText  EQU       3
SrchFld   FORM      "4"
STxtSize  FORM      8
SrchData  DIM       100
Stxt      DIM       5120
*
.Edittext Object and Data
.
EditText  EDITTEXT
.
Sample    INIT      "What is PL/B?",0x7F,0x7F,0x7F,0x7F:
                    "The PL/B language is an interactive,":
                    " data entry programming language ":
                    "designed primarily for business programming. ":
                    "Since its creation,PL/B has evolved into ":
                    "a powerful business programming ":
                    "language running under more than 60 combinations ":
                    "of hardware and operating ":
                    "systems. ",0x7F,0x7F:
                    "The PL/B language is easy to learn":
                    " and powerful enough to create complex programs."
*
.Page Heading
.
Header    STATTEXT
*
.Local Variables
.
StartSel  FORM      4
EndSel    FORM      4
Result    FORM      9
MAGENTA   COLOR
WHITE     COLOR
BLACK     COLOR
*............................................................................
.
.Ready the Screen
.
          SETMODE   *LTGRAY=ON,*3D=ON
          DISPLAY   *BGCOLOR=*YELLOW,*ES
. Define colors
          CREATE    MAGENTA=*MAGENTA
          CREATE    WHITE=*WHITE
*
.Create the Screen Heading
.
          CREATE    Header=2:4:23:55,"Edit Text Demo":
                    "Times(24,ITALIC,BOLD)",BORDER,STYLE=3DOUT:
                    ALIGNMENT=1,FGCOLOR=MAGENTA
.
*
.Create the Replacement File Menu
.
          CREATE    FileMenu,FileData
*
.Create the New Search Menu
.
          CREATE    FindMenu,FindData
*
.Create the Find Dialog
.
          CREATE    FindDlg,FDData
.
*
.Create the Edittext Object
.
          CREATE    EditText=5:24:5:75,BORDER,FONT="Times(12)":
                    MULTILINE,WORDWRAP,MAXCHARS=5120,BGCOLOR=WHITE
.
.           DISPLAY   *BGCOLOR=*YELLOW
*
.Load the Data into the Edittext Object
.
          SETITEM   EditText,0,Sample
*
. Activate all the objects
.
          ACTIVATE  FileMenu,Quit,Result
          ACTIVATE  FindMenu,FindIt,Result
          ACTIVATE  Header
          ACTIVATE  EditText
*
.Deactivate the Find Again Item
.
          DISABLEITEM FindMenu,3
*
.Wait for an Event to Occur
.
          LOOP
            WAITEVENT
          REPEAT
*...........................................................................
.
.Find Menu Item Selected
.
FindIt
          IF        (Result = 1)                     // Find   Requested
*
.Activate or Deactivate the Find Button Based on Search Text
.
            GETITEM   FindDlg,SrchFld,0,STxtSize   // Any Search Value?
            IF          ZERO
              DISABLEITEM FindDlg,SrchBtn        // No, Disable Search Button
            ELSE
              ENABLEITEM FindDlg,SrchBtn         // Yes, Enable Search Button
            ENDIF
*
. Get current contents of edit text box into Stxt
.
            GETITEM EditText,0,Stxt

*
.Activate the Find Dialog
.
            ACTIVATE  FindDlg,DlgRtn,Result
            SETFOCUS  FindDlg,4
            RESET       Stxt
          ELSE
*
.Search Again Requested
.
            BUMP        Stxt
            CALL        SEARCH
.
          ENDIF

          RETURN
*............................................................................
.
. Dialog Handling Routine
.
DlgRtn 
*
. Enable or Disable the Find Button and Find Again Menu Item
. Based on the Contents of the Search Text
.
          GETITEM   FindDlg,SrchFld,0,StxtSize
          IF        ZERO
            DISABLEITEM FindDlg,1
            DISABLEITEM FindMenu,3
          ELSE
            ENABLEITEM FindDlg,1
            ENABLEITEM FindMenu,3
          ENDIF
*
.Branch to the Correct Function
.
          BRANCH    Result to Search,Cancel
.
          RETURN
*............................................................................
.
.Search for the Specified Text
.
Search
          DEACTIVATE FindDlg
.
*
.Search for the String
.
          GETITEM   FindDlg,SrchFld,0,SrchData
          SCAN      SrchData,Stxt
*
.If Found, Highlight Selection
.
          IF EQUAL

            MOVEFPTR  Stxt,StartSel
            SUB       "1",StartSel
            SETITEM   EditText,1,StartSel
            COUNT     Result,SrchData
            SETITEM   EditText,2,(StartSel + Result)
            SETFOCUS  EditText
          ELSE
*
.Catch Search Failure
.
            ALERT     CAUTION,"String Not Found",RESULT,"Search"
          ENDIF
.
	 RETURN
*............................................................................
.
. Cancel the Find dialog
.
Cancel
          DEACTIVATE FindDlg
          RETURN
*.............................................................................
.
.Terminate the Program
.
Quit
          STOP

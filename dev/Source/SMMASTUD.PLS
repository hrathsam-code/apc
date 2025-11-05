...........................................................
. SMMASTUD - ENTER/MODIFY/DELETE MENU MASTER FILE RECORDS .
...........................................................
. LAST REVISION - 08/12/98
.
         INCLUDE   NCOMMON.TXT
.
REPLY    DIM       1
IOSW     DIM       1
DIM3     DIM       3
NWK2     FORM      2
.
MENUMST  IFILE     KEYL=4,UNCOMPRESSED,FIX=52,NODUP
MENUMSTN INIT      "MENUMST.ISI"
MENUMKEY DIM       4
.
MNUSYSID DIM       2         1 -  2    Application System Code
MNUSELNO DIM       2         3 -  4    Menu Selection Number
MNUPRGNM DIM       8         5 - 12    Program Name
MNUPRGDS DIM       40       13 - 52    Program Description
.
MASTREC  DIM       56
MSTDESC  DIM       40
MASTNAM  DIM       8
.
.
MENUSYS  IFILE     KEYL=2,UNCOMPRESSED,FIX=30,NODUP
MENUSYSN INIT      "MENUSYS.ISI"
MENUSKEY DIM       2
.
MSYSID   DIM       2         1 -  2    Application System Code
MSYSDSC  DIM       28        3 - 30    Application Description         
.
MENUREC  DIM       32
MNUDESC  DIM       28
MENUCOD  DIM       2
COMPSYS  DIM       2
SPACE    INIT      " "
SP1      INIT      " "
TAB      INIT      011
TABSETS  INIT      "4"
MTABSETS INIT      "6;15"
.
NDX      FORM      3
XDX      FORM      3
AFTRITM  FORM      3
.
CHGFLAG  INIT      " "
NAMFLAG  INIT      " "
EOJFLAG  INIT      " "
XITFLAG  INIT      " "
OPMODE   INIT      " "
MASTFLAG INIT      " "
NULLFLD  INIT      "                              ":
                   "                              "
MenuButton BUTTON                   
CnclButton BUTTON
QuitButton BUTTON
DeltButton BUTTON
SaveButton BUTTON
WritButton BUTTON
GetButton  BUTTON
AddButton  BUTTON
.
Forward  ICON
Bckward  ICON
ICONID1  FORM      "10050"
ICONID2  FORM      "10060"
.
.
TITLTXT  INIT      "MENU MASTER FILE MAINTENANCE"
PROGNTXT INIT      "SMMASTUD"
FLD01TXT INIT      "Application Code"
FLD02TXT INIT      "Description"
FLD03TXT INIT      "Sel"
FLD04TXT INIT      "Prog Name"
FLD05TXT INIT      "Program Description"
NEWKYTXT INIT      "New Sel'n No"
.
TITLE    STATTEXT
PROGNAME STATTEXT
CURRDATE STATTEXT
PRMT01   STATTEXT
PRMT02   STATTEXT
PRMT03   STATTEXT
PRMT04   STATTEXT
PRMT05   STATTEXT
NEWKYPT  STATTEXT
.
ENTRY01  EDITTEXT
ENTRY02  EDITTEXT
ENTRY03  EDITTEXT
ENTRY04  EDITTEXT
ENTRY05  EDITTEXT
NEWKY01  EDITTEXT
.
MENULST  DATALIST
MASTLST  DATALIST
.
RESULT   FORM      4
RESULTR  FORM      4
DA       DIALOG
DDATA    INIT      "FONTSIZE=8,POS=5:5,SIZE=45:9,":
                   "TYPE=MODELESS,":
                   "TEXT=3:5:5:40:'IF YOU HAVE COME HERE ERRONEOUSLY ":
                   "FROM THE SYSTEM MENUS":
                   " AND DO NOT WANT TO RUN THIS PROGRAM, ":
                   "YOU MAY EXIT BY":
                   " CLICKING THE Quit BUTTON... ":
                   "OTHERWISE, CLICK Continue',":
                   "BUTTON=7:8:14:20:'&Continue',": 
                   "BUTTON=7:8:26:32:'&Quit'" 
.
SAVEBOX  DIALOG
SDATA    INIT      "FONTSIZE=8,POS=5:5,SIZE=45:9,":
                   "TYPE=MODELESS,":
                   "TEXT=3:5:5:40:'THIS RECORD HAS CHANGED!  DO YOU ":
                   "WANT TO SAVE YOUR ":
                   "CHANGES BEFORE CONTINUING?           ":
                   "     CLICK THE Save ":
                   "BUTTON TO SAVE YOUR CHANGES, or ":
                   "CLICK Discard TO CONTINUE WITHOUT SAVING.',":
                   "BUTTON=7:8:14:20:'&Save',": 
                   "BUTTON=7:8:26:32:'&Discard'" 
.
+........................................................................
.
         SETMODE   *LTGRAY=ON,*3D=ON 
         CREATE    DA,DDATA
         DISPLAY   *BGCOLOR=*YELLOW,*ES,*BLUE:
                   *HON,*P05:01,"ENTER/MODIFY MENU MASTER FILE RECORDS":
                   *HOFF,*BLACK
         ACTIVATE  DA,TESTIT,RESULT
         LOOP
         WAITEVENT
         REPEAT
         STOP
.
TESTIT   BRANCH    RESULT OF NULL,MAINLINE,INDXIT
.
NULL     RETURN
.
INDXIT   DISPLAY   *ES,*BLUE
         BEEP
         CHAIN     "SMMENU"
. 
MAINLINE MOVE      " ",REPLY
         DEACTIVATE DA
         DESTROY   DA
         DISPLAY   *BLUE,*ES
   CREATE PROGNAME=1:2:1:11,PROGNTXT,"HELVETICA",BORDER,STYLE=3DOUT         
   CREATE TITLE=1:2:22:59,TITLTXT,"HELVETICA(10,BOLD)",CENTER,BORDER,STYLE=3DOUT
       CREATE  CURRDATE=1:2:72:80,TODAY,"HELVETICA",BORDER,STYLE=3DOUT
       CREATE  PRMT01=4:5:2:17,FLD01TXT,"HELVETICA",BORDER,STYLE=3DOUT
       CREATE  PRMT02=6:7:2:17,FLD02TXT,"HELVETICA",CENTER,BORDER,STYLE=3DOUT  
       CREATE  PRMT03=8:9:2:5,FLD03TXT,"HELVETICA",BORDER,STYLE=3DOUT
       CREATE  PRMT04=8:9:8:17,FLD04TXT,"HELVETICA",BORDER,STYLE=3DOUT  
       CREATE  PRMT05=8:9:20:41,FLD05TXT,"HELVETICA",BORDER,STYLE=3DOUT  
       CREATE  NEWKYPT=19:20:2:16,NEWKYTXT,"HELVETICA",BORDER,STYLE=3DOUT
.
         DISPLAY   *BLACK
       CREATE  ENTRY01=4:5:20:23,FONT="HELVETICA",BORDER,STATIC,MAXCHARS=2
       CREATE  ENTRY02=6:7:20:63,FONT="HELVETICA",BORDER,MAXCHARS=28
       CREATE  ENTRY03=10:11:2:5,FONT="HELVETICA",BORDER,MAXCHARS=2
       CREATE  ENTRY04=10:11:8:17,FONT="HELVETICA",BORDER,MAXCHARS=8
       CREATE  ENTRY05=10:11:20:68,FONT="HELVETICA",BORDER,MAXCHARS=40
       CREATE  NEWKY01=19:20:19:22,FONT="HELVETICA",BORDER,MAXCHARS=2
.
       CREATE  MenuButton=23:24:10:18,"Sel&Menu"
       CREATE  DeltButton=23:24:30:38,"&Delete"
       CREATE  AddButton=23:24:40:48,"&AddRec"
       CREATE  WritButton=23:24:50:58,"&Save"  
       CREATE  QuitButton=23:24:60:68,"&Quit"
       CREATE  CnclButton=23:24:70:78,"Ca&ncel"
       CREATE  SaveBox,SDATA
.
.
         CALL      MENUSOPN
         CALL      MASTOPEN
.
START
*............................................................
. INITIAL SCREEN DISPLAY SEQUENCE
LOOP
.
         ACTIVATE  TITLE
         ACTIVATE  PROGNAME
         ACTIVATE  CURRDATE
         ACTIVATE  PRMT01
         ACTIVATE  PRMT02
         ACTIVATE  PRMT03
         ACTIVATE  PRMT04
         ACTIVATE  PRMT05
.
         ACTIVATE  ENTRY01
         ACTIVATE  ENTRY02
         ACTIVATE  ENTRY03
         ACTIVATE  ENTRY04
         ACTIVATE  ENTRY05
         ACTIVATE  MenuButton,GETKEY,RESULT
         ACTIVATE  QuitButton,EOJ,RESULT
         ACTIVATE  AddButton,ADDKEY,RESULT
         ACTIVATE  CnclButton,CLRADDS,RESULT
.
         LOOP
           WAITEVENT
         REPEAT
         STOP
.
.
GETKEY   CALL      CHKSAV
         CALL      CLRADDS
         DISABLEITEM AddButton
.
. Open the Application Descriptions File
.
         CALL      MENUSOPN
.
. Create a DATALIST object which contains the application descriptions
.
         MATCH     "X" TO MASTFLAG
         GOTO      CRMENU IF NOT EQUAL
         DEACTIVATE  MASTLST
         DESTROY   MASTLST
CRMENU   CREATE    MENULST=15:22:25:56,FONT="HELVETICA",TABSTOPS=TABSETS
.
. Insert the application descriptions into the DATALIST
.
         DEACTIVATE DeltButton
         MOVE      "1" TO XDX
         MOVE      "0" TO AFTRITM
         LOOP
           READKS  MENUSYS;MSYSID,MSYSDSC
           GOTO    ENDLOOP IF OVER
           PACKKEY    MENUREC WITH MSYSID,TAB,MSYSDSC
           INSERTITEM MENULST,AFTRITM,MENUREC
BYPINS     MOVE    "999" TO AFTRITM
           ADD     "1",XDX
         REPEAT    
ENDLOOP
.
. Show the DATALIST
.
         ACTIVATE  MENULST,GETMENU,RESULT
         LOOP
           WAITEVENT
         REPEAT
         STOP
.
.
. Retrieve an item from the DATALST object 
.
GETMENU 		                    ;
         DEACTIVATE MENULST
	GETITEM   MENULST,RESULT,MENUREC
         UNPACK    MENUREC INTO MENUCOD,SP1,MNUDESC
.
         MOVE      MENUCOD TO MENUSKEY
         DESTROY   MENULST
         SETITEM   ENTRY01,0,MENUCOD
         SETITEM   ENTRY02,0,MNUDESC
         MOVE      MENUCOD TO MSYSID
         MOVE      MNUDESC TO MSYSDSC
.
.
. Open the Menu Master File
.
         CALL      MASTOPEN
.
. Create a DATALIST object which contains the program descriptions
.
       CREATE    MASTLST=13:22:10:71,FONT="HELVETICA",TABSTOPS=MTABSETS,SORTED
.
. Insert the application descriptions into the DATALIST
.
         MOVE      "X" TO MASTFLAG
         DEACTIVATE DeltButton
         MOVE      MENUSKEY TO MENUMKEY
         MOVE      MENUCOD TO COMPSYS
         READ      MENUMST,MENUMKEY;DIM3
         MOVE      "1" TO XDX
         MOVE      "0" TO AFTRITM
         LOOP
           READKS  MENUMST;MNUSYSID,MNUSELNO,MNUPRGNM,MNUPRGDS
           GOTO    ENDLOOPM IF OVER
           MATCH   MNUSYSID TO COMPSYS
           GOTO    ENDLOOPM IF NOT EQUAL
           PACKKEY    MASTREC WITH MNUSYSID,MNUSELNO,TAB,MNUPRGNM,TAB,MNUPRGDS
           INSERTITEM MASTLST,AFTRITM,MASTREC
BYPINSM    MOVE    "999" TO AFTRITM
           ADD     "1",XDX
         REPEAT    
ENDLOOPM
.
. Show the DATALIST
.
         ENABLEITEM  AddButton
         ACTIVATE  MASTLST,GETMAST,RESULTR
         LOOP
           WAITEVENT
         REPEAT
         STOP
.
.
. Retrieve an item from the DATALST object 
.
GETMAST 		                    ;
.         DEACTIVATE MENULST
	GETITEM   MASTLST,RESULTR,MASTREC
         UNPACK    MASTREC INTO MNUSYSID,MNUSELNO,SP1,MNUPRGNM,SP1,MNUPRGDS
.
         PACKKEY   MENUMKEY WITH MNUSYSID,MNUSELNO
.
MODIFYIT          
.
.
         READ      MENUMST,MENUMKEY;MNUSYSID,MNUSELNO,MNUPRGNM,MNUPRGDS
.
         GOTO      MODIFY IF NOT OVER
         BEEP
         ALERT     CAUTION,"INVALID PROGRAM CODE - CANNOT MODIFY!",RESULT
         GOTO      GETKEY
.
. Add a New Code to the Table
.
ADDKEY   CALL      CHKSAV
.
NEWONE   ALERT     NOTE,"THIS IS A NEW PROGRAM ITEM ",RESULT
.
         MOVE      MENUCOD TO MNUSYSID
         MOVE      NULLFLD TO MNUSELNO
         SETITEM   ENTRY01,0,MENUCOD
         SETITEM   ENTRY02,0,MNUDESC
         SETITEM   ENTRY03,0,NULLFLD
         SETITEM   ENTRY04,0,NULLFLD
         SETITEM   ENTRY05,0,NULLFLD
         SETITEM   NEWKY01,0,NULLFLD
.
         ACTIVATE  ENTRY03,K03,RESULT
         SETFOCUS  ENTRY03
         LOOP
           WAITEVENT
         REPEAT
         STOP
.
CHKADD
         PACKKEY   MENUMKEY WITH MENUCOD,MNUSELNO
.
         READ      MENUMST,MENUMKEY;DIM3
         GOTO      ADDOK IF OVER
         ALERT     CAUTION,"THAT PROGRAM IS ALREADY ON FILE!",RESULT
         CALL      CLRADDS
         RETURN
.
ADDOK    
         SETITEM   ENTRY01,0,MSYSID
         SETITEM   ENTRY02,0,MSYSDSC
         SETITEM   ENTRY03,0,MNUSELNO
.
.
ADDLOOP  ACTIVATE  ENTRY01
         ACTIVATE  ENTRY02
         ACTIVATE  ENTRY03
         ACTIVATE  ENTRY04,K04,RESULT
         ACTIVATE  ENTRY05,K05,RESULT
         ACTIVATE  WritButton,SAVE,RESULT
         DEACTIVATE DeltButton
         SETFOCUS  ENTRY04
         MOVE      "A" TO OPMODE
         MOVE      "X" TO CHGFLAG
.
         LOOP
           WAITEVENT
         REPEAT
         STOP
.
.
.
MODIFY   
         MOVE      "U" TO OPMODE
.
*............................................................
. DISPLAY VARIABLES
DISPVAR  NORETURN
         SETITEM   ENTRY01,0,MSYSID
         SETITEM   ENTRY02,0,MSYSDSC
         SETITEM   ENTRY03,0,MNUSELNO
         SETITEM   ENTRY04,0,MNUPRGNM
         SETITEM   ENTRY05,0,MNUPRGDS
.
.
         ACTIVATE  ENTRY01
         ACTIVATE  ENTRY02
         ACTIVATE  ENTRY03
         ACTIVATE  ENTRY04,K04,RESULT
         ACTIVATE  ENTRY05,K05,RESULT
         ACTIVATE  DeltButton,DELET,RESULT
         ACTIVATE  WritButton,SAVE,RESULT
         SETFOCUS  ENTRY04
.
         LOOP
           WAITEVENT
         REPEAT
         STOP
.
*............................................................
. APPLICATION CODE (PRIMARY KEY TO TABLE)
.
K01      COMPARE   "2" TO RESULT
         RETURN    IF NOT EQUAL
K01A     CLEAR     MSYSID
         GETITEM   NEWKY01,0,MSYSID
         NORETURN
         GOTO      CHKADD
*............................................................
. APPLICATION DESCRIPTION
.
K02      COMPARE   "2" TO RESULT
         RETURN    IF NOT EQUAL
K02A     CLEAR     MSYSDSC
         GETITEM   ENTRY02,0,MSYSDSC
         MOVE      "X" TO CHGFLAG
         RETURN
.
*............................................................
. MENU SELECTION NUMBER (PART OF KEY TO TABLE)
.
K03      COMPARE   "2" TO RESULT
         RETURN    IF NOT EQUAL
K03A     CLEAR     MNUSELNO
         GETITEM   ENTRY03,0,MNUSELNO
         TYPE      MNUSELNO
         GOTO      MOV03 IF EQUAL
         ALERT     CAUTION,"Selection MUST BE NUMERIC.",RESULT
         SETFOCUS  ENTRY03
         RETURN
MOV03    MOVE      MNUSELNO TO NWK2
         MOVE      NWK2 TO MNUSELNO
         SETITEM   ENTRY03,0,MNUSELNO         
         NORETURN
         GOTO      CHKADD
*............................................................
. PROGRAM NAME
.
K04      COMPARE   "2" TO RESULT
         RETURN    IF NOT EQUAL
K04A     CLEAR     MNUPRGNM
         GETITEM   ENTRY04,0,MNUPRGNM
         MOVE      "X" TO CHGFLAG
         RETURN
.
*............................................................
. PROGRAM DESCRIPTION
.
K05      COMPARE   "2" TO RESULT
         RETURN    IF NOT EQUAL
K05A     CLEAR     MNUPRGDS
         GETITEM   ENTRY05,0,MNUPRGDS
         MOVE      "X" TO CHGFLAG
         RETURN
.
.............................................................
. Delete an existing record
.
DELET    ALERT     PLAIN,"DELETE THIS RECORD?",RESULT,"Confirm Delete"
         COMPARE   "1" TO RESULT
         GOTO      ENDDEL IF NOT EQUAL
.
         PACKKEY   MENUMKEY WITH MNUSYSID,MNUSELNO
         DELETE    MENUMST,MENUMKEY
         DELETEITEM  MASTLST,RESULTR
         ALERT     NOTE,"RECORD DELETED!",RESULT
ENDDEL   GOTO      ENDUP
.
.............................................................
SAVE     MATCH     "A" TO OPMODE
         GOTO      WRITE IF EQUAL
UPDAT    MATCH     "X" TO CHGFLAG
         GOTO      NOCHG IF NOT EQUAL
.
         TRAP      BDMNUIO IF IO
         UPDATE    MENUMST;MNUSYSID,MNUSELNO,MNUPRGNM,MNUPRGDS
         TRAPCLR   IO
.
         MOVE      "999" TO AFTRITM
         DELETEITEM  MASTLST,RESULTR
         PACKKEY   MASTREC WITH MNUSYSID,MNUSELNO,TAB,MNUPRGNM,TAB,MNUPRGDS
         INSERTITEM  MASTLST,AFTRITM,MASTREC
.
.
ENDUP    MOVE      " " TO CHGFLAG
         MOVE      " " TO OPMODE
         MOVE      " " TO NAMFLAG
         DEACTIVATE DeltButton
         CALL      CLRENTRY
         MATCH     "X" TO EOJFLAG
         RETURN    IF NOT EQUAL
         NORETURN
         GOTO      EOJOK
.
NOCHG    ALERT     NOTE,"You didn't change anything!",RESULT
         GOTO      EXITPNT
.
MENUSOPN TRAP      NOMENUS IF IO
         OPEN      MENUSYS,MENUSYSN
         TRAPCLR   IO
         GOTO      MENUOPND
.         
NOMENUS  ALERT     CAUTION,"Application Code Table NOT FOUND!",RESULT
         CHAIN     "SMMENU"
.
MENUOPND RETURN         
.
.
MASTOPEN TRAP      NOMAST IF IO
         OPEN      MENUMST,MENUMSTN
         TRAPCLR   IO
         GOTO      MASTOPND
.         
NOMAST   ALERT     CAUTION,"Menu Master File NOT FOUND!",RESULT
         CHAIN     "SMMENU"
.
MASTOPND RETURN         
.
BDMNUIO
         ALERT     CAUTION,"ERROR ON MENU MASTER FILE!",RESULT
         CHAIN     "SMMENU"
.....................................................................
.
WRITE    MATCH     "X" TO CHGFLAG
         GOTO      NOCHG IF NOT EQUAL
.
         TRAP      BDMNUIO IF IO
         WRITE     MENUMST,MENUMKEY;MNUSYSID,MNUSELNO,MNUPRGNM,MNUPRGDS
         TRAPCLR   IO
.
         MOVE      "999" TO AFTRITM
         PACKKEY   MASTREC WITH MNUSYSID,MNUSELNO,TAB,MNUPRGNM,TAB,MNUPRGDS
         INSERTITEM  MASTLST,AFTRITM,MASTREC
.
.
         MOVE      " " TO CHGFLAG
         MATCH     "X" TO EOJFLAG
         GOTO      ENDWT IF EQUAL
         MATCH     "X" TO XITFLAG
         GOTO      ENDWT IF EQUAL
ENDWT    MOVE      " " TO CHGFLAG
         MOVE      " " TO NAMFLAG
         MOVE      " " TO XITFLAG
         CALL      CLRENTRY
         MATCH     "X" TO EOJFLAG
         RETURN    IF NOT EQUAL
         NORETURN
         GOTO      EOJOK
.
.
CLRADDS  MOVE      NULLFLD TO MNUSYSID
         MOVE      NULLFLD TO MNUSELNO
         MOVE      NULLFLD TO MNUPRGNM
         MOVE      NULLFLD TO MNUPRGDS
CLRENTRY
         MOVE      " " TO CHGFLAG
         SETITEM   ENTRY03,0,NULLFLD
         SETITEM   ENTRY04,0,NULLFLD
         SETITEM   ENTRY05,0,NULLFLD
         DEACTIVATE  NEWKYPT
         DEACTIVATE  NEWKY01
EXITPNT
         MOVE      " " TO CHGFLAG
         DEACTIVATE  DeltButton
         DEACTIVATE  WritButton
         ACTIVATE  AddButton,ADDKEY,RESULT
         RETURN
.
.
.
CHKSAV   MATCH     "X" TO CHGFLAG
         RETURN    IF NOT EQUAL
         ACTIVATE  SAVEBOX,TESTSV1,RESULT
         LOOP
           WAITEVENT
         REPEAT
         STOP
.
TESTSV1  BRANCH    RESULT OF NULLSV1,SAVEIT,DUMPIT
.
NULLSV1  RETURN
.
SAVEIT   MATCH     "A" TO OPMODE
         GOTO      DOWRIT IF EQUAL
         MATCH     "U" TO OPMODE
         GOTO      DOUPDT IF EQUAL
         NORETURN
         GOTO      EXITSV1
.
DOWRIT   MOVE      "X" TO XITFLAG
         CALL      WRITE
         NORETURN
         GOTO      EXITSV1
.
DOUPDT   CALL      UPDAT
         NORETURN
         GOTO      EXITSV1
.
DUMPIT   NORETURN
.
EXITSV1  DEACTIVATE SAVEBOX
         MOVE      " " TO CHGFLAG
         MOVE      " " TO XITFLAG
         RETURN
.
*............................................................
. END OF JOB
EOJ      MATCH     "X" TO CHGFLAG
         GOTO      EOJOK IF NOT EQUAL
         ACTIVATE  SAVEBOX,TESTSAV,RESULT
         LOOP
           WAITEVENT
         REPEAT
         STOP
TESTSAV  BRANCH    RESULT OF NULLSAV,DOSAVE,EOJOK
.
NULLSAV  RETURN
.
DOSAVE   MATCH     "A" TO OPMODE
         CALL      WRITE IF EQUAL
         MATCH     "U" TO OPMODE
         CALL      UPDAT IF EQUAL  
EOJOK
.
         CHAIN     "SMMENU"
.


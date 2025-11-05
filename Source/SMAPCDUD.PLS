...................................................................
. SMAPCDUD - ENTER/MODIFY/DELETE APPLICATION SYSTEM TABLE RECORDS .
...................................................................
. LAST REVISION - 03/26/98
.
         INCLUDE   NCOMMON.TXT
.
REPLY    DIM       1
IOSW     DIM       1
DIM3     DIM       3
.
.
MENUSYS  IFILE     "KEYL=2,UNCOMPRESSED,FIX=30,NODUP
MENUSYSN INIT      "MENUSYS.ISI"
MENUSKEY DIM       2
.
MSYSID   DIM       2         1 -  2    Application System Code
MSYSDSC  DIM       28        3 - 30    Application Description         
.
MENUREC  DIM       32
MNUDESC  DIM       28
MENUCOD  DIM       2
SPACE    INIT      " "
SP1      INIT      " "
TAB      INIT      011
TABSETS  INIT      "4"
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
NULLFLD  INIT      "                              ":
                   "                              "
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
TITLTXT  INIT      "APPLICATION SYSTEM CODE  TABLE MAINTENANCE"
PROGNTXT INIT      "SMAPCDUD"
FLD01TXT INIT      "Application Code"
FLD02TXT INIT      "Description"
NEWKYTXT INIT      "New App Code"
.
TITLE    STATTEXT
PROGNAME STATTEXT
CURRDATE STATTEXT
PRMT01   STATTEXT
PRMT02   STATTEXT
NEWKYPT  STATTEXT
.
ENTRY01  EDITTEXT
ENTRY02  EDITTEXT
NEWKY01  EDITTEXT
.
MENULST  DATALIST
.
RESULT   FORM      4
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
                   *HON,*P05:01,"ENTER/MODIFY APPLICATION CODES & DESCRIPTIONS":
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
   CREATE TITLE=1:2:16:65,TITLTXT,"HELVETICA(10,BOLD)",CENTER,BORDER,STYLE=3DOUT
       CREATE  CURRDATE=1:2:72:80,TODAY,"HELVETICA",BORDER,STYLE=3DOUT
       CREATE  PRMT01=4:5:2:16,FLD01TXT,"HELVETICA",BORDER,STYLE=3DOUT
       CREATE  PRMT02=6:7:2:16,FLD02TXT,"HELVETICA",BORDER,STYLE=3DOUT  
       CREATE  NEWKYPT=19:20:2:16,NEWKYTXT,"HELVETICA",BORDER,STYLE=3DOUT
.
         DISPLAY   *BLACK
       CREATE  ENTRY01=4:5:19:22,FONT="HELVETICA",BORDER,STATIC,MAXCHARS=2
       CREATE  ENTRY02=6:7:19:62,FONT="HELVETICA",BORDER,MAXCHARS=28
       CREATE  NEWKY01=19:20:19:22,FONT="HELVETICA",BORDER,MAXCHARS=2
.
       CREATE  Bckward=23:35,ICONID1
       CREATE  Forward=23:40,ICONID2
       CREATE  DeltButton=23:24:5:13,"&Delete"
       CREATE  AddButton=23:24:15:23,"&AddRec"
       CREATE  GetButton=23:24:25:33,"&GetRec"
       CREATE  WritButton=23:24:45:53,"&Save"  
       CREATE  QuitButton=23:24:55:63,"&Quit"
       CREATE  CnclButton=23:24:65:73,"Ca&ncel"
       CREATE  SaveBox,SDATA
.
.
         CALL      MENUSOPN
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
.
         ACTIVATE  ENTRY01
         ACTIVATE  ENTRY02
         ACTIVATE  Bckward,RDBCK,RESULT
         ACTIVATE  Forward,RDFWD,RESULT
         ACTIVATE  QuitButton,EOJ,RESULT
         ACTIVATE  AddButton,ADDKEY,RESULT
         ACTIVATE  GetButton,GETKEY,RESULT
         ACTIVATE  CnclButton,CLRADDS,RESULT
.
         LOOP
           WAITEVENT
         REPEAT
         STOP
.
.
GETKEY   CALL      CHKSAV
         DEACTIVATE Bckward
         DEACTIVATE Forward
         DEACTIVATE AddButton
.
. Open the Application Descriptions File
.
         CALL      MENUSOPN
.
. Create a DATALIST object which contains the application descriptions
.
         CREATE    MENULST=15:22:25:56,FONT="HELVETICA",TABSTOPS=TABSETS
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
.
MODIFYIT          
.
.
         READ      MENUSYS,MENUSKEY;MSYSID,MSYSDSC
.
         GOTO      MODIFY IF NOT OVER
         BEEP
         ALERT     CAUTION,"INVALID COMMODITY CODE - CANNOT MODIFY!",RESULT
         GOTO      GETKEY
.
. Add a New Code to the Table
.
ADDKEY   CALL      CHKSAV
         DEACTIVATE Bckward
         DEACTIVATE Forward
         DEACTIVATE GetButton
.
NEWONE   ALERT     NOTE,"THIS IS A NEW APPLICATION DESCRIPTION ",RESULT
.
         MOVE      NULLFLD TO MSYSID
         MOVE      NULLFLD TO MSYSDSC
         SETITEM   ENTRY01,0,NULLFLD
         SETITEM   ENTRY02,0,NULLFLD
         SETITEM   NEWKY01,0,NULLFLD
.
         ACTIVATE  NEWKYPT
         ACTIVATE  NEWKY01,K01,RESULT
         SETFOCUS  NEWKY01
         LOOP
           WAITEVENT
         REPEAT
         STOP
.
CHKADD
         MOVE      MSYSID TO MENUSKEY
.
         READ      MENUSYS,MENUSKEY;DIM3
         GOTO      ADDOK IF OVER
         ALERT     CAUTION,"THAT CODE IS ALREADY ON FILE!",RESULT
         DEACTIVATE  NEWKYPT
         DEACTIVATE  NEWKY01
         CALL      CLRADDS
         RETURN
.
ADDOK    
         DEACTIVATE  NEWKYPT
         DEACTIVATE  NEWKY01
         SETITEM   ENTRY01,0,MSYSID
.
.
ADDLOOP  ACTIVATE  ENTRY01
         ACTIVATE  ENTRY02,K02,RESULT
         ACTIVATE  WritButton,SAVE,RESULT
         DEACTIVATE DeltButton
         SETFOCUS  ENTRY02
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
COMODOPN
         TRAP      NOCOMODS IF IO
         OPEN      MENUSYS,MENUSYSN
         RETURN
.
NOCOMODS
         ALERT     CAUTION,"APPLICATION DESCRIPTION FILE NOT FOUND!!",RESULT
         CHAIN     "SMMENU"
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
.
.
         ACTIVATE  ENTRY01
         ACTIVATE  ENTRY02,K02,RESULT
         ACTIVATE  DeltButton,DELET,RESULT
         ACTIVATE  WritButton,SAVE,RESULT
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
.............................................................
. Delete an existing record
.
DELET    ALERT     PLAIN,"DELETE THIS RECORD?",RESULT,"Confirm Delete"
         COMPARE   "1" TO RESULT
         GOTO      ENDDEL IF NOT EQUAL
.
         MOVE      MSYSID TO MENUSKEY
         DELETE    MENUSYS,MENUSKEY
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
         UPDATE    MENUSYS;MSYSID,MSYSDSC
         TRAPCLR   IO
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
BDMNUIO
         ALERT     CAUTION,"ERROR ON COMMODITY FILE!",RESULT
         CHAIN     "SMMENU"
.....................................................................
.
WRITE    MATCH     "X" TO CHGFLAG
         GOTO      NOCHG IF NOT EQUAL
.
         TRAP      BDMNUIO IF IO
         WRITE     MENUSYS,MENUSKEY;MSYSID,MSYSDSC
         TRAPCLR   IO
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
         CALL      CLRADDS
         MATCH     "X" TO EOJFLAG
         RETURN    IF NOT EQUAL
         NORETURN
         GOTO      EOJOK
.
.
CLRADDS  MOVE      NULLFLD TO MSYSID
         MOVE      NULLFLD TO MSYSDSC
CLRENTRY
         MOVE      " " TO CHGFLAG
         SETITEM   ENTRY01,0,NULLFLD
         SETITEM   ENTRY02,0,NULLFLD
         DEACTIVATE  NEWKYPT
         DEACTIVATE  NEWKY01
EXITPNT
         DEACTIVATE  DeltButton
         DEACTIVATE  WritButton
         ACTIVATE  Bckward,RDBCK,RESULT
         ACTIVATE  Forward,RDFWD,RESULT
         ACTIVATE  AddButton,ADDKEY,RESULT
         ACTIVATE  GetButton,GETKEY,RESULT
         RETURN
.
RDBCK    CALL      CHKSAV
         DEACTIVATE AddButton
         DEACTIVATE GetButton
         READKP    MENUSYS;MSYSID,MSYSDSC
         RETURN    IF OVER
         NORETURN
         GOTO      MODIFY
.
RDFWD    CALL      CHKSAV
         DEACTIVATE AddButton
         DEACTIVATE GetButton
         READKS    MENUSYS;MSYSID,MSYSDSC
         RETURN    IF OVER
         NORETURN
         GOTO      MODIFY
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


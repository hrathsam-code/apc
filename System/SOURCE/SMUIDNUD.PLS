..........................................
. SMUIDNUD - CHANGE A USER SECURITY CODE .
..........................................
. LAST REVISION - 11/26/01
.
. 11/26/01 - ADDED USER LOCATION CODE TO USER FILE RECORD
.
         INCLUDE   NCOMMON.TXT
.
REPLY    DIM       1
IOSW     DIM       1
DIM2     DIM       2
DIM3     DIM       3
DIM9     DIM       9
AWK2     INIT      "  "
NWK2     FORM      2
.
.
USERFIL  IFILE     KEYL=9,UNCOMPRESSED,FIX=30,NODUP
USERFILN INIT      "SRESUF.ISI"
USERKEY  DIM       9
.
USERID   DIM       9         1 -  9    User ID Number
USER     DIM       20       10 - 29    User Name
USERLOC  DIM       1        30 - 30    User Location
.                                      1=NY, 2=SC, 3=NV
.
USERREC  DIM       31
USERNM   DIM       20
USERCOD  DIM       9
USERTABS INIT      "21"
.
USERMNUS IFILE     KEYL=13,UNCOMPRESSED,FIX=61,NODUP
USERMNUN INIT      "USERMNUS.ISI"
USERMKEY DIM       13
.
UMNUID   DIM       9         1 -  9    User ID Number
UMNUCD   DIM       2        10 - 11    Application System Code
UMNSELNO DIM       2        12 - 13    Menu Selection Number
UMNPRGNM DIM       8        14 - 21    Program Name
UMNPRGDS DIM       40       22 - 61    Program Description         
.
UMNUREC  DIM       67
UMNUDSC  DIM       40
UMNUPGM  DIM       8
UMNUSEL  DIM       2
UMNUCOD  DIM       2
UMTABSET INIT      "6;15;66"
.
.
USERSYS  IFILE     KEYL=11,UNCOMPRESSED,FIX=13,NODUP
USERSYSN INIT      "USERSYS.ISI"
USERSKEY DIM       11
.
USYSID   DIM       9         1 -  9    User ID Number
USYSCOD  DIM       2        10 - 11    Application System Code
USYSLVL  FORM      2        12 - 13    User Security Level for Application
.
USYSREC  DIM       36
USYSDSC  DIM       28
USYSCD   DIM       2
USYSLV   DIM       2
UTABSETS INIT      "4;33"
.
.
SPACE    INIT      " "
SP1      INIT      " "
TAB      INIT      011
TABSETS  INIT      "4"
.
NEWUSRID DIM       9
OLDUSRID DIM       9
OLDMNUKY DIM       13
NEWMNUKY DIM       13
OLDSYSKY DIM       11
NEWSYSKY DIM       11
.
NDX      FORM      3
XDX      FORM      3
AFTRITM  FORM      3
.
NULLFLD  INIT      "                              ":
                   "                              "
CnclButton BUTTON
QuitButton BUTTON
GetButton  BUTTON
.
.
TITLTXT  INIT      "CHANGE A USER SECURITY CODE"
PROGNTXT INIT      "SMUIDNUD"
FLD01TXT INIT      "User ID"
FLD02TXT INIT      "User Name"
FLD2ATXT INIT      "Location"
FLD03TXT INIT      "New ID"
.
TITLE    STATTEXT
PROGNAME STATTEXT
CURRDATE STATTEXT
PRMT01   STATTEXT
PRMT02   STATTEXT
PRMT02A  STATTEXT
PRMT03   STATTEXT
.
ENTRY01  EDITTEXT
ENTRY02  EDITTEXT
ENTRY02A EDITTEXT
ENTRY03  EDITTEXT
.
USERLST  DATALIST
.
EVENTS   INIT      "YYYYNN"
.
BLUE     COLOR
BLACK    COLOR
RED      COLOR
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
+........................................................................
. 
         CREATE    BLUE=*BLUE
         CREATE    BLACK=*BLACK
         CREATE    RED=*RED
         SETMODE   *LTGRAY=ON,*3D=ON,*DEFILTER=EVENTS,*SCREEN=OFF
         WINERASE                        
         CREATE    DA,DDATA
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
INDXIT   WINERASE
         BEEP
         CHAIN     FROMPGM
. 
MAINLINE MOVE      " ",REPLY
         DEACTIVATE DA
.
         CREATE PROGNAME=1:2:1:11,PROGNTXT,"HELVETICA",BORDER:
                                  STYLE=3DOUT,FGCOLOR=BLUE
         CREATE TITLE=1:2:23:58,TITLTXT,"HELVETICA(10,BOLD)",CENTER,BORDER:
                                STYLE=3DOUT,FGCOLOR=BLUE
         CREATE  CURRDATE=1:2:72:80,TODAY,"HELVETICA",BORDER:
                                STYLE=3DOUT,FGCOLOR=BLUE
         CREATE  PRMT01=4:5:1:9,FLD01TXT,"HELVETICA",BORDER,STYLE=3DOUT:
                                FGCOLOR=BLUE
         CREATE  PRMT02=4:5:24:33,FLD02TXT,"HELVETICA",BORDER,STYLE=3DOUT:
                                  FGCOLOR=BLUE  
         CREATE  PRMT02A=4:5:59:67,FLD2ATXT,"HELVETICA",BORDER,STYLE=3DOUT:
                                  FGCOLOR=BLUE  
         CREATE  PRMT03=6:7:1:9,FLD03TXT,"HELVETICA",BORDER,STYLE=3DOUT:
                                FGCOLOR=BLUE
.
         CREATE  ENTRY01=4:5:11:21,FONT="HELVETICA",BORDER,PASSWORD:
                                   FGCOLOR=BLACK,MAXCHARS=9
         CREATE  ENTRY02=4:5:35:56,FONT="HELVETICA",BORDER:
                                   FGCOLOR=BLACK,MAXCHARS=20
         CREATE  ENTRY02A=4:5:69:71,FONT="HELVETICA",BORDER:
                                   FGCOLOR=BLACK,STATIC
         CREATE  ENTRY03=6:7:11:21,FONT="HELVETICA",BORDER,PASSWORD:
                                   FGCOLOR=BLACK,MAXCHARS=9
.
       CREATE  GetButton=23:24:25:33,"&GetUser"
       CREATE  QuitButton=23:24:55:63,"&Quit"
       CREATE  CnclButton=23:24:65:73,"Ca&ncel"
.
.
. Open the System Users File
.
         CALL      USEROPEN
.
. Open the User/Application File
.
         CALL      USERSOPN
.
. Open the User Menus File File
.
         CALL      USERMOPN
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
         ACTIVATE  PRMT02A
         ACTIVATE  PRMT03
.
         ACTIVATE  ENTRY01
         ACTIVATE  ENTRY02
         ACTIVATE  ENTRY02A
         ACTIVATE  ENTRY03
         ACTIVATE  QuitButton,EOJ,RESULT
         ACTIVATE  GetButton,GETKEY,RESULT
         ACTIVATE  CnclButton,CLRADDS,RESULT
.
         LOOP
           WAITEVENT
         REPEAT
         STOP
.
. Open the System Users File
.
GETKEY   CALL      USEROPEN
.
. Create a DATALIST object which contains the user records
.
         CREATE    USERLST=15:22:30:51,FONT="HELVETICA",TABSTOPS=USERTABS
.
. Insert the user records into the DATALIST
.
         MOVE      "1" TO XDX
         MOVE      "0" TO AFTRITM
         LOOP
           READKS  USERFIL;USERID,USER,USERLOC
           GOTO    ENDLOOPU IF OVER
           PACKKEY    USERREC WITH USER,TAB,USERID
           INSERTITEM USERLST,AFTRITM,USERREC
           MOVE    "999" TO AFTRITM
           ADD     "1",XDX
         REPEAT    
ENDLOOPU
.
. Show the DATALIST
.
         ACTIVATE  USERLST,GETUSER,RESULT
         LOOP
           WAITEVENT
         REPEAT
         STOP
.
.
. Retrieve an item from the DATALST object 
.
GETUSER 		                    ;
         DEACTIVATE USERLST
	GETITEM   USERLST,RESULT,USERREC
         UNPACK    USERREC INTO USERNM,SP1,USERCOD
.
         MOVE      USERCOD TO USERKEY
.
         READ      USERFIL,USERKEY;USERID,USER,USERLOC
.
         GOTO      MODIFY IF NOT OVER
         ALERT     CAUTION,"INVALID USER CODE - CANNOT MODIFY!",RESULT
         GOTO      GETKEY
.
MODIFY   
DISPVAR  NORETURN
         SETITEM   ENTRY01,0,USERID
         SETITEM   ENTRY02,0,USER
         SETITEM   ENTRY02A,0,USERLOC
.
.
         ACTIVATE  PRMT01
         ACTIVATE  PRMT02
         ACTIVATE  PRMT02A
         ACTIVATE  PRMT03
         ACTIVATE  ENTRY01
         ACTIVATE  ENTRY02
         ACTIVATE  ENTRY02A
         ACTIVATE  ENTRY03,K03,RESULT
         SETFOCUS  ENTRY03
         LOOP
           WAITEVENT
         REPEAT
         STOP
.
.
K03      COMPARE   "2" TO RESULT
         RETURN    IF NOT EQUAL
         GETITEM   ENTRY03,0,NEWUSRID
         READ      USERFIL,NEWUSRID;DIM3
         GOTO      NEWIDOK IF OVER
         ALERT     STOP,"THAT ID NUMBER IS ALREADY IN USE!",RESULT
         CHAIN     FROMPGM
.
.
NEWIDOK  NORETURN
         SETMODE   *MCURSOR=*WAIT
         MOVE      USERID TO OLDUSRID
         CLEAR     USERMKEY
         PACKKEY   USERMKEY WITH OLDUSRID
         RESET     USERMKEY
         READ      USERMNUS,USERMKEY;DIM3
         LOOP
           READKS  USERMNUS;UMNUID,UMNUCOD,UMNSELNO,UMNPRGNM,UMNPRGDS
           GOTO    ENDLPUM IF OVER
           MATCH   UMNUID TO OLDUSRID
           GOTO    ENDLPUM IF NOT EQUAL
           READKEY USERMNUS,OLDMNUKY
           PACKKEY NEWMNUKY WITH NEWUSRID,UMNUCOD,UMNSELNO
           WRITE   USERMNUS,NEWMNUKY;NEWUSRID,UMNUCOD,UMNSELNO,UMNPRGNM,UMNPRGDS
           DELETE  USERMNUS,OLDMNUKY
         REPEAT    
ENDLPUM
.
.
         PACKKEY   USERSKEY WITH OLDUSRID
         READ      USERSYS,USERSKEY;DIM3;
         LOOP
           READKS  USERSYS;USYSID,USYSCOD,USYSLVL
           GOTO    ENDLPUS IF OVER
           MATCH   USYSID TO OLDUSRID
           GOTO    ENDLPUS IF NOT EQUAL
           READKEY USERSYS,OLDSYSKY
           PACKKEY NEWSYSKY WITH NEWUSRID,USYSCOD
           WRITE   USERSYS,NEWSYSKY;NEWUSRID,USYSCOD,USYSLVL
           DELETE  USERSYS,OLDSYSKY
         REPEAT
ENDLPUS
.
         PACKKEY   USERKEY WITH OLDUSRID
         READ      USERFIL,USERKEY;USERID,USER,USERLOC
         GOTO      ERRUF IF OVER
         WRITE     USERFIL,NEWUSRID;NEWUSRID,USER,USERLOC
         DELETE    USERFIL,OLDUSRID
         GOTO      CLRADDS
.
.............................................................
.
USEROPEN TRAP      NOUSER IF IO
         OPEN      USERFIL,USERFILN
         TRAPCLR   IO
         GOTO      USEROPND
.         
NOUSER   ALERT     CAUTION,"Authorized User File NOT FOUND!",RESULT
         CHAIN     FROMPGM
.
USEROPND RETURN         
.
ERRUF    ALERT     STOP,"ERROR READING USER FILE!",RESULT
.
USERSOPN TRAP      NOUSERS IF IO
         OPEN      USERSYS,USERSYSN
         TRAPCLR   IO
         GOTO      USRSOPND
.         
NOUSERS  ALERT     CAUTION,"User/Application File NOT FOUND!",RESULT
         CHAIN     FROMPGM
.
USRSOPND RETURN         
.
.
USERMOPN TRAP      NOUSERM IF IO
         OPEN      USERMNUS,USERMNUN
         TRAPCLR   IO
         GOTO      USRMOPND
.         
NOUSERM  ALERT     CAUTION,"User Menus File NOT FOUND!",RESULT
         CHAIN     FROMPGM
.
USRMOPND RETURN         
.
.
.....................................................................
.
CLRADDS  SETMODE   *MCURSOR=*ARROW
         ALERT     NOTE,"USER ID CHANGED ON ALL MENUS",RESULT
         MOVE      NULLFLD TO USERID
         MOVE      NULLFLD TO USER
         MOVE      NULLFLD TO USERLOC
CLRENTRY
         SETITEM   ENTRY01,0,NULLFLD
         SETITEM   ENTRY02,0,NULLFLD
         SETITEM   ENTRY02A,0,NULLFLD
         SETITEM   ENTRY03,0,NULLFLD
EXITPNT
         ACTIVATE  GetButton,GETKEY,RESULT
         NORETURN
         GOTO      LOOP
.
.
*............................................................
. END OF JOB
EOJ      
EOJOK
.
         CHAIN     FROMPGM
.


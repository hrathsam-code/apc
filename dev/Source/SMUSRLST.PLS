................................................................
. SMUSRLST.TXT  LISTING OF SYSTEM USERS
.
. LAST REVISION - 01/30/02
.
         INCLUDE   NCOMMON.TXT
.
.
.
USERFIL  IFILE     "KEYL=9,UNCOMPRESSED,FIX=30,NODUP
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
USERSYS  IFILE     "KEYL=11,UNCOMPRESSED,FIX=13,NODUP
USERSYSN INIT      "USERSYS.ISI"
USERSKEY DIM       11
.
USYSID   DIM       9         1 -  9    User ID Number
USYSCOD  DIM       2        10 - 11    Application System Code
USYSLVL  FORM      2        12 - 13    User Security Level for Application
.
.
.
MENUSYS  IFILE     "KEYL=2,UNCOMPRESSED,FIX=30,NODUP
MENUSYSN INIT      "MENUSYS.ISI"
MENUSKEY DIM       2
.
MSYSID   DIM       2         1 -  2    Application System Code
MSYSDSC  DIM       28        3 - 30    Application Description         
.
.
.
TITLTXT  INIT      "LIST AUTHORIZED SYSTEM USERS"
PROGNTXT INIT      "SMUSRLST"
.
TITLE    STATTEXT
PROGNAME STATTEXT
CURRDATE STATTEXT
.
PRTID    CHECKBOX
.
ContButton  BUTTON
QuitButton  BUTTON
.
BLUE     COLOR
BLACK    COLOR
RED      COLOR
.
EVENTS   INIT      "YYYYNN"
.
         INCLUDE   SPLOPNFD.TXT
.
REPLY    DIM       1
ONE      FORM      "1"
IDFLAG   INIT      " "
HDGFLAG  INIT      " "
PRTSIDE  FORM      1
LINECNT  FORM      2
PAGENO   FORM      4         
.
RESULT   FORM      4
RESULT1  FORM      1
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
.
         CREATE PROGNAME=1:2:1:11,PROGNTXT,"HELVETICA",BORDER:
                                  STYLE=3DOUT,FGCOLOR=BLUE
         CREATE TITLE=1:2:23:58,TITLTXT,"HELVETICA(10,BOLD)",CENTER,BORDER:
                                STYLE=3DOUT,FGCOLOR=BLUE
         CREATE  CURRDATE=1:2:72:80,TODAY,"HELVETICA",BORDER:
                                    STYLE=3DOUT,FGCOLOR=BLUE
         CREATE    PRTID=10:11:10:40,"Show User ID##"
         CREATE    ContButton=23:24:55:63,"&Cont"
         CREATE    QuitButton=23:24:65:73,"&Quit"
                                             
.
.
         ACTIVATE  PROGNAME
         ACTIVATE  TITLE
         ACTIVATE  CURRDATE
         ACTIVATE  PRTID
         ACTIVATE  ContButton
         ACTIVATE  QuitButton
         MOVE      " " TO IDFLAG
.
         INCLUDE   SPLOPNPR.TXT
.
. Open the Application Descriptions File
.
         CALL      MENUSOPN
.
. Open the System Users File
.
         CALL      USEROPEN
.
. Open the User/Application File
.
         CALL      USERSOPN
.
...........................................................
.
         ACTIVATE  PRTID,CKPRTID,RESULT1
         ACTIVATE  ContButton,INIT,RESULT
         ACTIVATE  QuitButton,EOJ,RESULT
         LOOP
           WAITEVENT
         REPEAT
         STOP
.
. Check to see if user wants to see User ID's
.
CKPRTID
         SUBTRACT  "1" FROM RESULT1
         SETITEM   PRTID,ONE,RESULT1
         COMPARE   "1" TO RESULT1
         GOTO      PRT0 IF NOT EQUAL   
         MOVE      "X" TO IDFLAG
         RETURN
PRT0     
         MOVE      " " TO IDFLAG
         RETURN
.
INIT     CALL      PRTHDG
.
NEWUSER  READKS    USERFIL;USERID,USER,USERLOC
         GOTO      ENDJOB IF OVER
         COMPARE   "54" TO LINECNT
         CALL      PRTHDGX IF EQUAL
         PRINT     *1," "
         ADD       "1" TO LINECNT
         COMPARE   "55" TO LINECNT
         CALL      PRTHDGX IF NOT LESS
         COMPARE   "2" TO PRTSIDE
         GOTO      CHKID IF NOT EQUAL
         PRINT     *1," "
         ADD       "1" TO LINECNT
         COMPARE   "55" TO LINECNT
         CALL      PRTHDGX IF NOT LESS
CHKID    MATCH     "X" TO IDFLAG
         GOTO      PRTNAME IF NOT EQUAL
         PRINT     *1,USERID
         ADD       "1" TO LINECNT
         COMPARE   "55" TO LINECNT
         CALL      PRTHDGX IF NOT LESS
PRTNAME  PRINT     *1,USER;
         MOVE      "1" TO PRTSIDE
         PACKKEY   USERSKEY WITH USERID
         READ      USERSYS,USERSKEY;REPLY
.
APPLOOP  READKS    USERSYS;USYSID,USYSCOD,USYSLVL
         GOTO      NEWUSER IF OVER
         MATCH     USERID TO USYSID
         GOTO      NEWUSER IF NOT EQUAL
         PACKKEY   MENUSKEY WITH USYSCOD
         READ      MENUSYS,MENUSKEY;MSYSID,MSYSDSC
         BRANCH    PRTSIDE OF PRTLEFT,PRTRITE
.
PRTLEFT  PRINT     *22,MSYSID,"-",MSYSDSC;
         ADD       "1" TO PRTSIDE
         GOTO      APPLOOP
.
PRTRITE  PRINT     *54,MSYSID,"-",MSYSDSC
         ADD       "1" TO LINECNT
         COMPARE   "55" TO LINECNT
         CALL      PRTHDGX IF NOT LESS
         MOVE      "1" TO PRTSIDE
         GOTO      APPLOOP
.
PRTHDGX  PRINT     *F;
PRTHDG   ADD       "1" TO PAGENO
         PRINT     *1,PROGNTXT,*29,"AUTHORIZED SYSTEM USERS",*72,"PAGE ",PAGENO
         PRINT     *64,"PRINTED  ",TODAY,*N
         PRINT     *1,"USER ID/NAME",*25,"============ AUTHORIZED APPLICATION":
                                         " SYSTEMS ============",*N
         MOVE      "1" TO PRTSIDE
         MOVE      "1" TO LINECNT
         RETURN
.
.
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
MENUSOPN TRAP      NOMENUS IF IO
         OPEN      MENUSYS,MENUSYSN
         TRAPCLR   IO
         GOTO      MENUOPND
.         
NOMENUS  ALERT     CAUTION,"Application Code Table NOT FOUND!",RESULT
         CHAIN     FROMPGM
.
MENUOPND RETURN         
.
.
ENDJOB   PRINT     *N,*1,"End-of-Listing"
         RELEASE
         SPLCLOSE
EOJ      CHAIN     FROMPGM
                                                  
              
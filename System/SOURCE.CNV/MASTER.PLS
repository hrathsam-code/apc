. MASTER.PLS   MAIN APPLICATION SELECTION MENU
. LAST REVISION - 01-15-03   (MASTER VICE MASTEST)
.
         INCLUDE   NCOMMON.TXT
.
.
USERSYS  IFILE     "KEYL=11,UNCOMPRESSED,FIX=13,NODUP
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
TAB      INIT      011
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
REPLY    DIM       1
DIM9     DIM       9
NWK2     FORM      2
PROGRAM  DIM       8
.
AFTRITM  FORM      3
XDX      FORM      3
.
LogButton  BUTTON
.
.
TITLTXT  INIT      "APPLICATION SELECTION MENU"
PROGNTXT INIT      "MASTER"
LOGNTXT  INIT      "Please make your selection from the list above..."
.
TITLE    STATTEXT
PROGNAME STATTEXT
CURRDATE STATTEXT
LOGNMSG  STATTEXT
.
USRAPPS  DATALIST
.
RUNMENU  MENU
MENUDATA INIT      ")Run;)ProgByName"
ISPARMS  DIM       9(3),("0627     "),("081350   "),("10101    ")
ISFLAG   INIT      " "
KPRMPTXT INIT      "ProgName"
KEYPRMPT STATTEXT
KEYENTRY EDITTEXT
.
RESULT   FORM      4
RESULTR  FORM      4
INDEX    FORM      2
.
PROG     DIM       8(25),("ACCTMNU1"):
                         ("APPINVC1"):
                         ("ARMENU1 "):
                         ("APMENU1 "):
                         ("APMAINT "):
                         ("MSHISTRY"):
                         ("DAILYEOJ"):
                         ("CORPCTLS"):
                         ("GULLPART"):
                         ("RPRTINVC"):
                         ("SOPRINT "):
                         ("GULLFULL"):
                         ("        "):
                         ("        "):
                         ("        "):
                         ("        "):
                         ("        "):
                         ("        "):
                         ("        "):
                         ("        "):
                         ("        "):
                         ("        "):
                         ("        "):
                         ("        "):
                         ("        ")
.
.
+........................................................................
.

 
         SETMODE   *LTGRAY=ON,*3D=ON 
         DISPLAY   *BGCOLOR=*YELLOW,*ES,*BLUE
   CREATE PROGNAME=1:2:1:11,PROGNTXT,"HELVETICA",BORDER,STYLE=3DOUT         
   CREATE TITLE=1:2:25:56,TITLTXT,"HELVETICA(10,BOLD)",CENTER,BORDER,STYLE=3DOUT
       CREATE  CURRDATE=1:2:72:80,TODAY,"HELVETICA",BORDER,STYLE=3DOUT
.
         DISPLAY   *BLACK
     CREATE  LOGNMSG=16:17:20:61,LOGNTXT,"HELVETICA",CENTER,BORDER,STYLE=3DOUT         
     CREATE  LogButton=23:24:36:45,"&LogOff"
     CREATE  RUNMENU,MENUDATA
     CREATE  KEYPRMPT=19:20:1:11,KPRMPTXT,"HELVETICA",BORDER,STYLE=3DOUT
     CREATE  KEYENTRY=19:20:13:22,FONT="HELVETICA",BORDER,MAXCHARS=8
.
         MATCH     USERCODE TO ISPARMS(1)
         CALL      SETIS IF EQUAL
         MATCH     USERCODE TO ISPARMS(2)
         CALL      SETIS IF EQUAL 
         MATCH     USERCODE TO ISPARMS(3)
         CALL      SETIS IF EQUAL    
.
.
.
. Open the Application Descriptions File
.
         CALL      MENUSOPN
.
. Open the User/Application File
.
         CALL      USERSOPN
*............................................................
. INITIAL SCREEN DISPLAY SEQUENCE
LOOP
         ACTIVATE  TITLE
         ACTIVATE  PROGNAME
         ACTIVATE  CURRDATE
.
LOADAPPS
         CREATE    USRAPPS=7:14:27:54,FONT="HELVETICA",SORTED,TABSTOPS=UTABSETS
         MOVE      USERCODE TO USERSKEY
         READ      USERSYS,USERSKEY;DIM9;
         MOVE      "1" TO XDX
         MOVE      "0" TO AFTRITM
         LOOP
           READKS  USERSYS;USYSID,USYSCOD,USYSLVL
           GOTO    ENDLOOPS IF OVER
           MATCH   USYSID TO USERCODE
           GOTO    ENDLOOPS IF NOT EQUAL
           PACKKEY MENUSKEY WITH USYSCOD
           READ    MENUSYS,MENUSKEY;MSYSID,MSYSDSC
           GOTO    BADMNU IF OVER
           MOVE    MSYSDSC TO USYSDSC
           PACKKEY USYSREC WITH USYSCOD,TAB,USYSDSC,TAB,USYSLVL
           INSERTITEM  USRAPPS,AFTRITM,USYSREC
           MOVE    "999" TO AFTRITM
           ADD     "1" TO XDX
         REPEAT
ENDLOOPS
         GOTO      SELECT
.
BADMNU   ALERT     CAUTION,"INVALID APPLICATION CODE ENCOUNTERED",RESULT
         RETURN
.
SELECT
         ACTIVATE  USRAPPS,GETAPP,RESULTR
         ACTIVATE  LogButton,LOGOUT,RESULT
         ACTIVATE  LOGNMSG
         MATCH     "X" TO ISFLAG
         GOTO      NOTIS IF NOT EQUAL
         ACTIVATE  RUNMENU,RUNBYNM,RESULT
NOTIS    LOOP
           WAITEVENT
         REPEAT
         STOP
.
.
GETAPP
         GETITEM   USRAPPS,RESULTR,USYSREC
         UNPACK    USYSREC INTO USYSCD,REPLY,USYSDSC,REPLY,USYSLV
         TYPE      USYSLV
         GOTO      MVSLV IF EQUAL
         MOVE      "00" TO USYSLV
MVSLV    MOVE      USYSLV TO APPSECUR
         MOVE      USYSCD TO INDEX
         TRAP      NOPROG IF CFAIL
         MOVE      PROG(INDEX) TO PROGRAM
         MOVE      INDEX TO APPCODE
         CHAIN     PROGRAM
         RETURN
.
.
USERSOPN TRAP      NOUSERS IF IO
         OPEN      USERSYS,USERSYSN
         TRAPCLR   IO
         GOTO      USRSOPND
.         
NOUSERS  ALERT     CAUTION,"User/Application File NOT FOUND!",RESULT
         DSCNCT
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
         DSCNCT
.
MENUOPND RETURN
.
.
SETIS    MOVE      "X" TO ISFLAG
         RETURN
.
RUNBYNM  ACTIVATE  KEYPRMPT
         ACTIVATE  KEYENTRY,KEYPROG,RESULT
         SETFOCUS  KEYENTRY
         LOOP
           WAITEVENT
         REPEAT
         STOP
.
KEYPROG  COMPARE   "2" TO RESULT
         RETURN    IF NOT EQUAL
         CLEAR     PROGRAM
         GETITEM   KEYENTRY,0,PROGRAM
         NORETURN
         TRAP      NOPROG IF CFAIL
         CHAIN     PROGRAM                  
.
.
.
NOPROG   ALERT     CAUTION,"Could NOT load program",RESULT
         TRAPCLR   CFAIL
...         RETURN            12/6/2002  RB
         CHAIN     "MASTER"
.
.
LOGOUT   DSCNCT                  
           
                         
         
                         
                         
         
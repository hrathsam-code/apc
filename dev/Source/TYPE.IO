          %IFNDEF $TYPEVARIO
 
$TYPEVARIO                       EQUATE         1
.
#result   FORM       1
#Operand  DIM        40
#ErrorString  DIM        120
.
.
.
          GOTO       #EndOfRoutine
.
.
.
. Test Read for TYPEKY Index
.
TSTTYPE                                     
          MOVE       "Testing",#Operand
          READ       TYPEFL,TYPEKY;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Read for TYPEKY Index
.
RDTYPE                                      
          MOVE       "Reading",#Operand
          READ       TYPEFL,TYPEKY;TYPE
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Locked Read for TYPEKY Index
.
RDTYPELK                                    
          MOVE       "Reading",#Operand
          READLK     TYPEFL,TYPEKY;TYPE
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Sequential Read for TYPEKY Index
.
KSTYPE                                      
          MOVE       "Reading Key Sequentially",#Operand
          READKS     TYPEFL;TYPE
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Sequential Read for TYPEKY Index
.
KSTYPELK                                    
          MOVE       "Reading Key Sequentially",#Operand
          READKSLK   TYPEFL;TYPE
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Previous Read for TYPEKY Index
.
KPTYPE                                      
          MOVE       "Reading Key Previously",#Operand
          READKP     TYPEFL;TYPE
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Previous Read for TYPEKY Index
.
KPTYPELK                                    
          MOVE       "Reading Key Previously",#Operand
          READKPLK   TYPEFL;TYPE
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Update of TYPE Record
.
UpdTYPE                                     
          MOVE       "Updating",#Operand
          UPDATE     TYPEFLST;TYPE
          GOTO       #VALID
.
. Deletion of TYPE Record
.
DelTYPE                                     
          MOVE       "Deleting",#Operand
          DELETE     TYPEFLST
          GOTO       #VALID
.
. Write for TYPE Record
.
WrtTYPE                                     
          MOVE       "Writing",#Operand
          WRITE      TYPEFLST;TYPE
          GOTO       #VALID
.
.  Opening of TYPE Files
.
OpenTYPE                                    
          GETFILE          TYPEFL
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             TYPEFLST,LockManual,Single,NoWait
          RETURN
.
.  Opening of TYPE Files in Read-Only Mode
.
OpenTYPERO                                  
          GETFILE          TYPEFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             TYPEFLST,READ
          RETURN
.
.  Opening of TYPE Files in Read-Only Mode
.
OpenTYPEEx                                  
          GETFILE          TYPEFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             TYPEFLST,Exclusive
          RETURN
.
.  Preparing of TYPE Files
.
PrepTYPE                                    
           PREPARE       TYPEFL,"TypeFL.txt","TYPE.isi","-n,z,y,1-4","20",EXCLUSIVE
           RETURN
.
. Standard Return Values for I/O Include
.
#ERROR
          MOVE       "1" TO ReturnFl    
          MOVE       "Preparing",#Operand
          RETURN
#LOCKED
          MOVE       "2" TO ReturnFl    
          RETURN
#VALID
          MOVE       "0" TO ReturnFl    
          RETURN
 
 
#TYPEError
          PACK        #ErrorString from "Error ",#Operand," TYPE FileActual Error : ",S$ERROR$
          BEEP
          ALERT       STOP,#ErrorString,result,"I/O Error"
          STOP
 
 
#EndOfRoutine
          %ENDIF          //End of IO Include File

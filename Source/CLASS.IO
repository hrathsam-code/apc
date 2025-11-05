          %IFNDEF $ClassVARIO
 
$ClassVARIO                      EQUATE         1
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
. Test Read for ClassKY Index
.
TSTClass                                    
          MOVE       "Testing",#Operand
          READ       ClassFL,ClassKY;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Read for ClassKY Index
.
RDClass                                     
          MOVE       "Reading",#Operand
          READ       ClassFL,ClassKY;Class
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Locked Read for ClassKY Index
.
RDClassLK                                   
          MOVE       "Reading",#Operand
          READLK     ClassFL,ClassKY;Class
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Sequential Read for ClassKY Index
.
KSClass                                     
          MOVE       "Reading Key Sequentially",#Operand
          READKS     ClassFL;Class
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Sequential Read for ClassKY Index
.
KSClassLK                                   
          MOVE       "Reading Key Sequentially",#Operand
          READKSLK   ClassFL;Class
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Previous Read for ClassKY Index
.
KPClass                                     
          MOVE       "Reading Key Previously",#Operand
          READKP     ClassFL;Class
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Previous Read for ClassKY Index
.
KPClassLK                                   
          MOVE       "Reading Key Previously",#Operand
          READKPLK   ClassFL;Class
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Update of Class Record
.
UpdClass                                    
          MOVE       "Updating",#Operand
          UPDATE     ClassFLST;Class
          GOTO       #VALID
.
. Deletion of Class Record
.
DelClass                                    
          MOVE       "Deleting",#Operand
          DELETE     ClassFLST
          GOTO       #VALID
.
. Write for Class Record
.
WrtClass                                    
          MOVE       "Writing",#Operand
          WRITE      ClassFLST;Class
          GOTO       #VALID
.
.  Opening of Class Files
.
OpenClass                                   
          GETFILE          ClassFL
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             ClassFLST,LockManual,Single,NoWait
          RETURN
.
.  Opening of Class Files in Read-Only Mode
.
OpenClassRO                                 
          GETFILE          ClassFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             ClassFLST,READ
          RETURN
.
.  Opening of Class Files in Read-Only Mode
.
OpenClassEx                                 
          GETFILE          ClassFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             ClassFLST,Exclusive
          RETURN
.
.  Preparing of Class Files
.
PrepClass                                   
           PREPARE       ClassFL,"ClassFL.txt","Class.isi","-n,z,y,1-4","20",EXCLUSIVE
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
 
 
#ClassError
          PACK        #ErrorString from "Error ",#Operand," Class FileActual Error : ",S$ERROR$
          BEEP
          ALERT       STOP,#ErrorString,result,"I/O Error"
          STOP
 
 
#EndOfRoutine
          %ENDIF          //End of IO Include File

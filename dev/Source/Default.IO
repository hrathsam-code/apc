          %IFNDEF $DefaultVARIO
 
$DefaultVARIO                    EQUATE         1
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
. Test Read for DefaultKY Index
.
TSTDefault                                  
          MOVE       "Testing",#Operand
          READ       DefaultFL,DefaultKY;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Read for DefaultKY Index
.
RDDefault                                   
          MOVE       "Reading",#Operand
          READ       DefaultFL,DefaultKY;Default
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Locked Read for DefaultKY Index
.
RDDefaultLK                                 
          MOVE       "Reading",#Operand
          READLK     DefaultFL,DefaultKY;Default
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Sequential Read for DefaultKY Index
.
KSDefault                                   
          MOVE       "Reading Key Sequentially",#Operand
          READKS     DefaultFL;Default
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Sequential Read for DefaultKY Index
.
KSDefaultLK                                 
          MOVE       "Reading Key Sequentially",#Operand
          READKSLK   DefaultFL;Default
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Previous Read for DefaultKY Index
.
KPDefault                                   
          MOVE       "Reading Key Previously",#Operand
          READKP     DefaultFL;Default
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Previous Read for DefaultKY Index
.
KPDefaultLK                                 
          MOVE       "Reading Key Previously",#Operand
          READKPLK   DefaultFL;Default
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Update of Default Record
.
UpdDefault                                  
          MOVE       "Updating",#Operand
          UPDATE     DefaultFLST;Default
          GOTO       #VALID
.
. Deletion of Default Record
.
DelDefault                                  
          MOVE       "Deleting",#Operand
          DELETE     DefaultFLST
          GOTO       #VALID
.
. Write for Default Record
.
WrtDefault                                  
          MOVE       "Writing",#Operand
          WRITE      DefaultFLST;Default
          GOTO       #VALID
.
.  Opening of Default Files
.
OpenDefault                                 
          GETFILE          DefaultFL
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             DefaultFLST,LockManual,Single,NoWait
          RETURN
.
.  Opening of Default Files in Read-Only Mode
.
OpenDefaultRO                               
          GETFILE          DefaultFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             DefaultFLST,READ
          RETURN
.
.  Opening of Default Files in Read-Only Mode
.
OpenDefaultEx                               
          GETFILE          DefaultFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             DefaultFLST,Exclusive
          RETURN
.
.  Preparing of Default Files
.
PrepDefault                                 
           PREPARE       DefaultFL,"Default.txt","Default.isi","-n,z,y,1-8","300",EXCLUSIVE
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
 
 
#DefaultError
          PACK        #ErrorString from "Error ",#Operand," Default FileActual Error : ",S$ERROR$
          BEEP
          ALERT       STOP,#ErrorString,result,"I/O Error"
          STOP
 
 
#EndOfRoutine
          %ENDIF          //End of IO Include File

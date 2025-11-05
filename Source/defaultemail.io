          %IFNDEF $DefaultEmailVARIO
 
$DefaultEmailVARIO               EQUATE         1
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
. Test Read for DefaultEmailKY Index
.
TSTDefaultEmail                             
          MOVE       "Testing",#Operand
          READ       DefaultEmailFL,DefaultEmailKY;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Read for DefaultEmailKY Index
.
RDDefaultEmail                              
          MOVE       "Reading",#Operand
          READ       DefaultEmailFL,DefaultEmailKY;DefaultEmail
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Locked Read for DefaultEmailKY Index
.
RDDefaultEmailLK                            
          MOVE       "Reading",#Operand
          READLK     DefaultEmailFL,DefaultEmailKY;DefaultEmail
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Sequential Read for DefaultEmailKY Index
.
KSDefaultEmail                              
          MOVE       "Reading Key Sequentially",#Operand
          READKS     DefaultEmailFL;DefaultEmail
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Sequential Read for DefaultEmailKY Index
.
KSDefaultEmailLK                            
          MOVE       "Reading Key Sequentially",#Operand
          READKSLK   DefaultEmailFL;DefaultEmail
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Previous Read for DefaultEmailKY Index
.
KPDefaultEmail                              
          MOVE       "Reading Key Previously",#Operand
          READKP     DefaultEmailFL;DefaultEmail
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Previous Read for DefaultEmailKY Index
.
KPDefaultEmailLK                            
          MOVE       "Reading Key Previously",#Operand
          READKPLK   DefaultEmailFL;DefaultEmail
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Update of DefaultEmail Record
.
UpdDefaultEmail                             
          MOVE       "Updating",#Operand
          UPDATE     DefaultEmailFLST;DefaultEmail
          GOTO       #VALID
.
. Deletion of DefaultEmail Record
.
DelDefaultEmail                             
          MOVE       "Deleting",#Operand
          DELETE     DefaultEmailFLST
          GOTO       #VALID
.
. Write for DefaultEmail Record
.
WrtDefaultEmail                             
          MOVE       "Writing",#Operand
          WRITE      DefaultEmailFLST;DefaultEmail
          GOTO       #VALID
.
.  Opening of DefaultEmail Files
.
OpenDefaultEmail                            
          GETFILE          DefaultEmailFL
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             DefaultEmailFLST,LockManual,Single,NoWait
          RETURN
.
.  Opening of DefaultEmail Files in Read-Only Mode
.
OpenDefaultEmailRO                          
          GETFILE          DefaultEmailFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             DefaultEmailFLST,READ
          RETURN
.
.  Opening of DefaultEmail Files in Read-Only Mode
.
OpenDefaultEmailEx                          
          GETFILE          DefaultEmailFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             DefaultEmailFLST,Exclusive
          RETURN
.
.  Preparing of DefaultEmail Files
.
PrepDefaultEmail                            
           PREPARE       DefaultEmailFL,"DefaultEMail.txt","DefaultEmail.isi","-n,z,y,1-6","5192",EXCLUSIVE
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
 
 
#DefaultEmailError
          PACK        #ErrorString from "Error ",#Operand," DefaultEmail FileActual Error : ",S$ERROR$
          BEEP
          ALERT       STOP,#ErrorString,result,"I/O Error"
          STOP
 
 
#EndOfRoutine
          %ENDIF          //End of IO Include File

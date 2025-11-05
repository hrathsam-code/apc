          %IFNDEF $DefaultsVARIO
 
$DefaultsVARIO                   EQUATE         1
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
. Test Read for DefaultsKY Index
.
TSTDefaults                                 
          MOVE       "Testing",#Operand
          READ       DefaultsFL,DefaultsKY;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Read for DefaultsKY Index
.
RDDefaults                                  
          MOVE       "Reading",#Operand
          READ       DefaultsFL,DefaultsKY;Defaults
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Locked Read for DefaultsKY Index
.
RDDefaultsLK                                
          MOVE       "Reading",#Operand
          READLK     DefaultsFL,DefaultsKY;Defaults
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Sequential Read for DefaultsKY Index
.
KSDefaults                                  
          MOVE       "Reading Key Sequentially",#Operand
          READKS     DefaultsFL;Defaults
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Sequential Read for DefaultsKY Index
.
KSDefaultsLK                                
          MOVE       "Reading Key Sequentially",#Operand
          READKSLK   DefaultsFL;Defaults
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Previous Read for DefaultsKY Index
.
KPDefaults                                  
          MOVE       "Reading Key Previously",#Operand
          READKP     DefaultsFL;Defaults
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Previous Read for DefaultsKY Index
.
KPDefaultsLK                                
          MOVE       "Reading Key Previously",#Operand
          READKPLK   DefaultsFL;Defaults
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Test Read for DefaultsKY2 Index
.
TSTDefaults2                                
          MOVE       "Testing",#Operand
          READ       DefaultsFL2,DefaultsKY2;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Read for DefaultsKY2 Index
.
RDDefaults2                                 
          MOVE       "Reading",#Operand
          READ       DefaultsFL2,DefaultsKY2;Defaults
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Locked Read for DefaultsKY2 Index
.
RDDefaults2LK                               
          MOVE       "Reading",#Operand
          READLK     DefaultsFL2,DefaultsKY2;Defaults
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Sequential Read for DefaultsKY2 Index
.
KSDefaults2                                 
          MOVE       "Reading Key Sequentially",#Operand
          READKS     DefaultsFL2;Defaults
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Sequential Read for DefaultsKY2 Index
.
KSDefaults2LK                               
          MOVE       "Reading Key Sequentially",#Operand
          READKSLK   DefaultsFL2;Defaults
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Previous Read for DefaultsKY2 Index
.
KPDefaults2                                 
          MOVE       "Reading Key Previously",#Operand
          READKP     DefaultsFL2;Defaults
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Previous Read for DefaultsKY2 Index
.
KPDefaults2LK                               
          MOVE       "Reading Key Previously",#Operand
          READKPLK   DefaultsFL2;Defaults
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Update of Defaults Record
.
UpdDefaults                                 
          MOVE       "Updating",#Operand
          UPDATE     DefaultsFLST;Defaults
          GOTO       #VALID
.
. Deletion of Defaults Record
.
DelDefaults                                 
          MOVE       "Deleting",#Operand
          DELETE     DefaultsFLST
          GOTO       #VALID
.
. Write for Defaults Record
.
WrtDefaults                                 
          MOVE       "Writing",#Operand
          WRITE      DefaultsFLST;Defaults
          GOTO       #VALID
.
.  Opening of Defaults Files
.
OpenDefaults                                
          GETFILE          DefaultsFL
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             DefaultsFLST,LockManual,Multiple,NoWait
          RETURN
.
.  Opening of Defaults Files in Read-Only Mode
.
OpenDefaultsRO                              
          GETFILE          DefaultsFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             DefaultsFLST,READ
          RETURN
.
.  Opening of Defaults Files in Read-Only Mode
.
OpenDefaultsEx                              
          GETFILE          DefaultsFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             DefaultsFLST,Exclusive
          RETURN
.
.  Preparing of Defaults Files
.
PrepDefaults                                
           PREPARE       DefaultsFL,"Defaults.txt","Defaults.isi","-n,z,y,1-8","1024",EXCLUSIVE
           PREPARE       DefaultsFL2,"Defaults.txt","Defaults2.isi","-n,z,y,1-8,9-18","1024",EXCLUSIVE
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
 
 
#DefaultsError
          PACK        #ErrorString from "Error ",#Operand," Defaults FileActual Error : ",S$ERROR$
          BEEP
          ALERT       STOP,#ErrorString,result,"I/O Error"
          STOP
 
 
#EndOfRoutine
          %ENDIF          //End of IO Include File

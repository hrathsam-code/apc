          %IFNDEF $CNTRYVARIO
 
$CNTRYVARIO                      EQUATE         1
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
. Test Read for CNTRYKY Index
.
TSTCNTRY                                    
          MOVE       "Testing",#Operand
          READ       CNTRYFL,CNTRYKY;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Read for CNTRYKY Index
.
RDCNTRY                                     
          MOVE       "Reading",#Operand
          READ       CNTRYFL,CNTRYKY;CNTRY
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Locked Read for CNTRYKY Index
.
RDCNTRYLK                                   
          MOVE       "Reading",#Operand
          READLK     CNTRYFL,CNTRYKY;CNTRY
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Sequential Read for CNTRYKY Index
.
KSCNTRY                                     
          MOVE       "Reading Key Sequentially",#Operand
          READKS     CNTRYFL;CNTRY
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Sequential Read for CNTRYKY Index
.
KSCNTRYLK                                   
          MOVE       "Reading Key Sequentially",#Operand
          READKSLK   CNTRYFL;CNTRY
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Previous Read for CNTRYKY Index
.
KPCNTRY                                     
          MOVE       "Reading Key Previously",#Operand
          READKP     CNTRYFL;CNTRY
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Previous Read for CNTRYKY Index
.
KPCNTRYLK                                   
          MOVE       "Reading Key Previously",#Operand
          READKPLK   CNTRYFL;CNTRY
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Update of CNTRY Record
.
UpdCNTRY                                    
          MOVE       "Updating",#Operand
          UPDATE     CNTRYFLST;CNTRY
          GOTO       #VALID
.
. Deletion of CNTRY Record
.
DelCNTRY                                    
          MOVE       "Deleting",#Operand
          DELETE     CNTRYFLST
          GOTO       #VALID
.
. Write for CNTRY Record
.
WrtCNTRY                                    
          MOVE       "Writing",#Operand
          WRITE      CNTRYFLST;CNTRY
          GOTO       #VALID
.
.  Opening of CNTRY Files
.
OpenCNTRY                                   
          GETFILE          CNTRYFL
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             CNTRYFLST,LockManual,Single,NoWait
          RETURN
.
.  Opening of CNTRY Files in Read-Only Mode
.
OpenCNTRYRO                                 
          GETFILE          CNTRYFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             CNTRYFLST,READ
          RETURN
.
.  Opening of CNTRY Files in Read-Only Mode
.
OpenCNTRYEx                                 
          GETFILE          CNTRYFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             CNTRYFLST,Exclusive
          RETURN
.
.  Preparing of CNTRY Files
.
PrepCNTRY                                   
           PREPARE       CNTRYFL,"CntryFL.txt","CNTRYFL.isi","-n,z,y,1-3","44",EXCLUSIVE
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
 
 
#CNTRYError
          PACK        #ErrorString from "Error ",#Operand," CNTRY FileActual Error : ",S$ERROR$
          BEEP
          ALERT       STOP,#ErrorString,result,"I/O Error"
          STOP
 
 
#EndOfRoutine
          %ENDIF          //End of IO Include File

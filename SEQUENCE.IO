          %IFNDEF $SequenceVARIO
 
$SequenceVARIO                   EQUATE         1
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
. Test Read for SequenceKY Index
.
TSTSequence                                 
          MOVE       "Testing",#Operand
          READ       SequenceFL,SequenceKY;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Read for SequenceKY Index
.
RDSequence                                  
          MOVE       "Reading",#Operand
          READ       SequenceFL,SequenceKY;Sequence
          READ       SequenceFL,SequenceKY;Sequence
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Locked Read for SequenceKY Index
.
RDSequenceLK                                
          MOVE       "Reading",#Operand
          READLK     SequenceFL,SequenceKY;Sequence
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Sequential Read for SequenceKY Index
.
KSSequence                                  
          MOVE       "Reading Key Sequentially",#Operand
          READKS     SequenceFL;Sequence
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Sequential Read for SequenceKY Index
.
KSSequenceLK                                
          MOVE       "Reading Key Sequentially",#Operand
          READKSLK   SequenceFL;Sequence
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Previous Read for SequenceKY Index
.
KPSequence                                  
          MOVE       "Reading Key Previously",#Operand
          READKP     SequenceFL;Sequence
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Previous Read for SequenceKY Index
.
KPSequenceLK                                
          MOVE       "Reading Key Previously",#Operand
          READKPLK   SequenceFL;Sequence
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Update of Sequence Record
.
UpdSequence                                 
          MOVE       "Updating",#Operand
          UPDATE     SequenceFLST;Sequence
          GOTO       #VALID
.
. Deletion of Sequence Record
.
DelSequence                                 
          MOVE       "Deleting",#Operand
          DELETE     SequenceFLST
          GOTO       #VALID
.
. Write for Sequence Record
.
WrtSequence                                 
          MOVE       "Writing",#Operand
          WRITE      SequenceFLST;Sequence
          GOTO       #VALID
.
.  Opening of Sequence Files
.
OpenSequence                                
          GETFILE          SequenceFL
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             SequenceFLST,LockManual,Single,NoWait
          RETURN
.
.  Opening of Sequence Files in Read-Only Mode
.
OpenSequenceRO                              
          GETFILE          SequenceFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             SequenceFLST,READ
          RETURN
.
.  Opening of Sequence Files in Read-Only Mode
.
OpenSequenceEx                              
          GETFILE          SequenceFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             SequenceFLST,Exclusive
          RETURN
.
.  Preparing of Sequence Files
.
PrepSequence                                
           PREPARE       SequenceFL,"$DataDir\Sequence.TXT.txt","$DataDir\Sequence.isi","-n,z,y,1-6","15",EXCLUSIVE
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
 
 
#SequenceError
          PACK        #ErrorString from "Error ",#Operand," Sequence FileActual Error : ",S$ERROR$
          BEEP
          ALERT       STOP,#ErrorString,result,"I/O Error"
          STOP
 
 
#EndOfRoutine
          %ENDIF          //End of IO Include File

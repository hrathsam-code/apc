          %IFNDEF $CheckRunDetailVARIO
 
$CheckRunDetailVARIO             EQUATE         1
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
. Update of CheckRunDetail Record
.
UpdCheckRunDetail                           
          MOVE       "Updating",#Operand
          UPDATE     CheckRunDetailFLST;CheckRunDetail
          GOTO       #VALID
.
. Deletion of CheckRunDetail Record
.
DelCheckRunDetail                           
          MOVE       "Deleting",#Operand
          DELETE     CheckRunDetailFLST
          GOTO       #VALID
.
. Write for CheckRunDetail Record
.
WrtCheckRunDetail                           
          MOVE       "Writing",#Operand
          WRITE      CheckRunDetailFLST;CheckRunDetail
          GOTO       #VALID
.
.  Opening of CheckRunDetail Files
.
OpenCheckRunDetail                          
          GETFILE          CheckRunDetailFL
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             CheckRunDetailFLST,LockManual,Multiple,Wait=  2
          RETURN
.
.  Opening of CheckRunDetail Files in Read-Only Mode
.
OpenCheckRunDetailRO                        
          GETFILE          CheckRunDetailFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             CheckRunDetailFLST,READ
          RETURN
.
.  Opening of CheckRunDetail Files in Read-Only Mode
.
OpenCheckRunDetailEx                        
          GETFILE          CheckRunDetailFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             CheckRunDetailFLST,Exclusive
          RETURN
.
.  Preparing of CheckRunDetail Files
.
PrepCheckRunDetail                          
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
 
 
#CheckRunDetailError
          PACK        #ErrorString from "Error ",#Operand," CheckRunDetail FileActual Error : ",S$ERROR$
          BEEP
          ALERT       STOP,#ErrorString,result,"I/O Error"
          STOP
 
 
#EndOfRoutine
          %ENDIF          //End of IO Include File

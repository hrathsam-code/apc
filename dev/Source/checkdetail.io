          %IFNDEF $CheckDetailVARIO
 
$CheckDetailVARIO                EQUATE         1
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
. Update of CheckDetail Record
.
UpdCheckDetail                              
          MOVE       "Updating",#Operand
          UPDATE     CheckDetailFLST;CheckDetail
          GOTO       #VALID
.
. Deletion of CheckDetail Record
.
DelCheckDetail                              
          MOVE       "Deleting",#Operand
          DELETE     CheckDetailFLST
          GOTO       #VALID
.
. Write for CheckDetail Record
.
WrtCheckDetail                              
          MOVE       "Writing",#Operand
          WRITE      CheckDetailFLST;CheckDetail
          GOTO       #VALID
.
.  Opening of CheckDetail Files
.
OpenCheckDetail                             
          GETFILE          CheckDetailFL
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             CheckDetailFLST,LockManual,Multiple,Wait=  2
          RETURN
.
.  Opening of CheckDetail Files in Read-Only Mode
.
OpenCheckDetailRO                           
          GETFILE          CheckDetailFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             CheckDetailFLST,READ
          RETURN
.
.  Opening of CheckDetail Files in Read-Only Mode
.
OpenCheckDetailEx                           
          GETFILE          CheckDetailFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             CheckDetailFLST,Exclusive
          RETURN
.
.  Preparing of CheckDetail Files
.
PrepCheckDetail                             
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
 
 
#CheckDetailError
          PACK        #ErrorString from "Error ",#Operand," CheckDetail FileActual Error : ",S$ERROR$
          BEEP
          ALERT       STOP,#ErrorString,result,"I/O Error"
          STOP
 
 
#EndOfRoutine
          %ENDIF          //End of IO Include File

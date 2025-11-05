          %IFNDEF $invNotesVARIO
 
$invNotesVARIO                   EQUATE         1
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
. Test Read for invNotesKY Index
.
TSTinvNotes                                 
          MOVE       "Testing",#Operand
          READ       invNotesFL,invNotesKY;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Read for invNotesKY Index
.
RDinvNotes                                  
          MOVE       "Reading",#Operand
          READ       invNotesFL,invNotesKY;invNotes
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Locked Read for invNotesKY Index
.
RDinvNotesLK                                
          MOVE       "Reading",#Operand
          READLK     invNotesFL,invNotesKY;invNotes
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Sequential Read for invNotesKY Index
.
KSinvNotes                                  
          MOVE       "Reading Key Sequentially",#Operand
          READKS     invNotesFL;invNotes
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Sequential Read for invNotesKY Index
.
KSinvNotesLK                                
          MOVE       "Reading Key Sequentially",#Operand
          READKSLK   invNotesFL;invNotes
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Previous Read for invNotesKY Index
.
KPinvNotes                                  
          MOVE       "Reading Key Previously",#Operand
          READKP     invNotesFL;invNotes
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Previous Read for invNotesKY Index
.
KPinvNotesLK                                
          MOVE       "Reading Key Previously",#Operand
          READKPLK   invNotesFL;invNotes
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Update of invNotes Record
.
UpdinvNotes                                 
          MOVE       "Updating",#Operand
          UPDATE     invNotesFLST;invNotes
          GOTO       #VALID
.
. Deletion of invNotes Record
.
DelinvNotes                                 
          MOVE       "Deleting",#Operand
          DELETE     invNotesFLST
          GOTO       #VALID
.
. Write for invNotes Record
.
WrtinvNotes                                 
          MOVE       "Writing",#Operand
          WRITE      invNotesFLST;invNotes
          GOTO       #VALID
.
.  Opening of invNotes Files
.
OpeninvNotes                                
          GETFILE          invNotesFL
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             invNotesFLST,LockManual,Multiple,Wait=  2
          RETURN
.
.  Opening of invNotes Files in Read-Only Mode
.
OpeninvNotesRO                              
          GETFILE          invNotesFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             invNotesFLST,READ
          RETURN
.
.  Opening of invNotes Files in Read-Only Mode
.
OpeninvNotesEx                              
          GETFILE          invNotesFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             invNotesFLST,Exclusive
          RETURN
.
.  Preparing of invNotes Files
.
PrepinvNotes                                
           PREPARE       invNotesFL,"InvNotes.txt","invNotes.isi","-n,z,y,1-8,9-17,18-21","1021",EXCLUSIVE
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
 
 
#invNotesError
          PACK        #ErrorString from "Error ",#Operand," invNotes FileActual Error : ",S$ERROR$
          BEEP
          ALERT       STOP,#ErrorString,result,"I/O Error"
          STOP
 
 
#EndOfRoutine
          %ENDIF          //End of IO Include File

          %IFNDEF $BatchVARIO
 
$BatchVARIO                      EQUATE         1
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
. Test Read for BatchKY Index
.
TSTBatch                                    
          MOVE       "Testing",#Operand
          READ       BatchFL,BatchKY;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Read for BatchKY Index
.
RDBatch                                     
          MOVE       "Reading",#Operand
          READ       BatchFL,BatchKY;Batch
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Locked Read for BatchKY Index
.
RDBatchLK                                   
          MOVE       "Reading",#Operand
          READLK     BatchFL,BatchKY;Batch
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Sequential Read for BatchKY Index
.
KSBatch                                     
          MOVE       "Reading Key Sequentially",#Operand
          READKS     BatchFL;Batch
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Sequential Read for BatchKY Index
.
KSBatchLK                                   
          MOVE       "Reading Key Sequentially",#Operand
          READKSLK   BatchFL;Batch
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Previous Read for BatchKY Index
.
KPBatch                                     
          MOVE       "Reading Key Previously",#Operand
          READKP     BatchFL;Batch
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Previous Read for BatchKY Index
.
KPBatchLK                                   
          MOVE       "Reading Key Previously",#Operand
          READKPLK   BatchFL;Batch
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Test Read for BatchKY2 Index
.
TSTBatch2                                   
          MOVE       "Testing",#Operand
          READ       BatchFL2,BatchKY2;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Read for BatchKY2 Index
.
RDBatch2                                    
          MOVE       "Reading",#Operand
          READ       BatchFL2,BatchKY2;Batch
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Locked Read for BatchKY2 Index
.
RDBatch2LK                                  
          MOVE       "Reading",#Operand
          READLK     BatchFL2,BatchKY2;Batch
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Sequential Read for BatchKY2 Index
.
KSBatch2                                    
          MOVE       "Reading Key Sequentially",#Operand
          READKS     BatchFL2;Batch
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Sequential Read for BatchKY2 Index
.
KSBatch2LK                                  
          MOVE       "Reading Key Sequentially",#Operand
          READKSLK   BatchFL2;Batch
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Previous Read for BatchKY2 Index
.
KPBatch2                                    
          MOVE       "Reading Key Previously",#Operand
          READKP     BatchFL2;Batch
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Previous Read for BatchKY2 Index
.
KPBatch2LK                                  
          MOVE       "Reading Key Previously",#Operand
          READKPLK   BatchFL2;Batch
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Test Read for BatchKY3 Index
.
TSTBatch3                                   
          MOVE       "Testing",#Operand
          READ       BatchFL3,BatchKY3;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Read for BatchKY3 Index
.
RDBatch3                                    
          MOVE       "Reading",#Operand
          READ       BatchFL3,BatchKY3;Batch
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Locked Read for BatchKY3 Index
.
RDBatch3LK                                  
          MOVE       "Reading",#Operand
          READLK     BatchFL3,BatchKY3;Batch
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Sequential Read for BatchKY3 Index
.
KSBatch3                                    
          MOVE       "Reading Key Sequentially",#Operand
          READKS     BatchFL3;Batch
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Sequential Read for BatchKY3 Index
.
KSBatch3LK                                  
          MOVE       "Reading Key Sequentially",#Operand
          READKSLK   BatchFL3;Batch
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Previous Read for BatchKY3 Index
.
KPBatch3                                    
          MOVE       "Reading Key Previously",#Operand
          READKP     BatchFL3;Batch
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Previous Read for BatchKY3 Index
.
KPBatch3LK                                  
          MOVE       "Reading Key Previously",#Operand
          READKPLK   BatchFL3;Batch
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Update of Batch Record
.
UpdBatch                                    
          MOVE       "Updating",#Operand
          UPDATE     BatchFLST;Batch
          GOTO       #VALID
.
. Deletion of Batch Record
.
DelBatch                                    
          MOVE       "Deleting",#Operand
          DELETE     BatchFLST
          GOTO       #VALID
.
. Write for Batch Record
.
WrtBatch                                    
          MOVE       "Writing",#Operand
          WRITE      BatchFLST;Batch
          GOTO       #VALID
.
.  Opening of Batch Files
.
OpenBatch                                   
          GETFILE          BatchFL
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             BatchFLST,LockManual,Single,NoWait
          RETURN
.
.  Opening of Batch Files in Read-Only Mode
.
OpenBatchRO                                 
          GETFILE          BatchFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             BatchFLST,READ
          RETURN
.
.  Opening of Batch Files in Read-Only Mode
.
OpenBatchEx                                 
          GETFILE          BatchFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             BatchFLST,Exclusive
          RETURN
.
.  Preparing of Batch Files
.
PrepBatch                                   
           PREPARE       BatchFL,"Batch.txt","Batch.isi","-n,u,z,y,1-10,21-29","140",EXCLUSIVE
           PREPARE       BatchFL2,"Batch.txt","Batch2.isi","-n,z,y,1-10,42-50","140",EXCLUSIVE
           PREPARE       BatchFL3,"Batch.txt","Batch3.isi","-n,z,y,1-10,30-37,42-50","140",EXCLUSIVE
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
 
 
#BatchError
          PACK        #ErrorString from "Error ",#Operand," Batch FileActual Error : ",S$ERROR$
          BEEP
          ALERT       STOP,#ErrorString,result,"I/O Error"
          STOP
 
 
#EndOfRoutine
          %ENDIF          //End of IO Include File

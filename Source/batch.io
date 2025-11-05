;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    1 Meade Ave                                              ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 532-6266                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    Batch.FD                                                ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    07-05-2019 At 14:41                                            ;
;                                                                             ;
;  PURPOSE:                                                                   ;
;                                                                             ;
; REVISION:     Ver        Date     INIT       DETAILS                        ;
;                                                                             ;
;              00101   07-05-2019   HOR     INITIAL VERSION                  ;
;                                                                             ;
;=============================================================================;
;
          %IFNDEF $BatchVARIO
 
$BatchVARIO                      EQUATE         1
;
#result   FORM       1
#Operand  DIM        40
#ErrorString  DIM        120
;
;
;
          GOTO       #EndOfRoutine
;
;
;=========================================================================================;
;
; Test Read for BatchKY Index
;
TSTBatch                                    
          pack       FileNameError from "Testing ","Batch"
          READ       BatchFL,BatchKY;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for BatchKY Index
;
RDBatch                                     
          pack       FileNameError from "Reading ","Batch"
          READ       BatchFL,BatchKY;Batch
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for BatchKY Index
;
RDBatchLK                                   
          pack       FileNameError from "Reading ","Batch"
          READLK     BatchFL,BatchKY;Batch
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for BatchKY Index
;
KSBatch                                     
          pack       FileNameError from "Reading KS ","Batch"
          READKS     BatchFL;Batch
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for BatchKY Index
;
KSBatchLK                                   
          pack       FileNameError from "Reading KS Locked ","Batch"
          READKSLK   BatchFL;Batch
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for BatchKY Index
;
KPBatch                                     
          pack       FileNameError from "Reaing KP ","Batch"
          READKP     BatchFL;Batch
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for BatchKY Index
;
KPBatchLK                                   
          pack       FileNameError from "Reading Locked KP ","Batch"
          READKPLK   BatchFL;Batch
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Test Read for BatchKY2 Index
;
TSTBatch2                                   
          pack       FileNameError from "Testing ","Batch"
          READ       BatchFL2,BatchKY2;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for BatchKY2 Index
;
RDBatch2                                    
          pack       FileNameError from "Reading ","Batch"
          READ       BatchFL2,BatchKY2;Batch
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for BatchKY2 Index
;
RDBatch2LK                                  
          pack       FileNameError from "Reading ","Batch"
          READLK     BatchFL2,BatchKY2;Batch
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for BatchKY2 Index
;
KSBatch2                                    
          pack       FileNameError from "Reading KS ","Batch"
          READKS     BatchFL2;Batch
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for BatchKY2 Index
;
KSBatch2LK                                  
          pack       FileNameError from "Reading KS Locked ","Batch"
          READKSLK   BatchFL2;Batch
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for BatchKY2 Index
;
KPBatch2                                    
          pack       FileNameError from "Reaing KP ","Batch"
          READKP     BatchFL2;Batch
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for BatchKY2 Index
;
KPBatch2LK                                  
          pack       FileNameError from "Reading Locked KP ","Batch"
          READKPLK   BatchFL2;Batch
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Test Read for BatchKY3 Index
;
TSTBatch3                                   
          pack       FileNameError from "Testing ","Batch"
          READ       BatchFL3,BatchKY3;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for BatchKY3 Index
;
RDBatch3                                    
          pack       FileNameError from "Reading ","Batch"
          READ       BatchFL3,BatchKY3;Batch
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for BatchKY3 Index
;
RDBatch3LK                                  
          pack       FileNameError from "Reading ","Batch"
          READLK     BatchFL3,BatchKY3;Batch
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for BatchKY3 Index
;
KSBatch3                                    
          pack       FileNameError from "Reading KS ","Batch"
          READKS     BatchFL3;Batch
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for BatchKY3 Index
;
KSBatch3LK                                  
          pack       FileNameError from "Reading KS Locked ","Batch"
          READKSLK   BatchFL3;Batch
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for BatchKY3 Index
;
KPBatch3                                    
          pack       FileNameError from "Reaing KP ","Batch"
          READKP     BatchFL3;Batch
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for BatchKY3 Index
;
KPBatch3LK                                  
          pack       FileNameError from "Reading Locked KP ","Batch"
          READKPLK   BatchFL3;Batch
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Update of Batch Record
;
UpdBatch                                    
          pack       FileNameError from "Updating ","Batch"
          UPDATE     BatchFLST;Batch
          GOTO       #VALID
;=========================================================================================;
;
; Deletion of Batch Record
;
DelBatch                                    
          pack       FileNameError from "Deleting ","Batch"
          DELETE     BatchFLST
          GOTO       #VALID
;=========================================================================================;
;
; Write for Batch Record
;
WrtBatch                                    
          pack       FileNameError from "Writing ","Batch"
          WRITE      BatchFLST;Batch
          GOTO       #VALID
;=========================================================================================;
;
;  Opening of Batch Files
;
OpenBatch                                   
          GETFILE          BatchFL
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening Batch"
          OPEN             BatchFLST,LockManual,Single,NoWait
          RETURN
;=========================================================================================;
;
;  Opening of Batch Files in Read-Only Mode
;
OpenBatchRO                                 
          GETFILE          BatchFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening Batch"
          OPEN             BatchFLST,READ
          RETURN
;=========================================================================================;
;
;  Opening of Batch Files in Read-Only Mode
;
OpenBatchEx                                 
          GETFILE          BatchFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening Batch"
          OPEN             BatchFLST,Exclusive
          RETURN
;=========================================================================================;
;
;  Preparing of Batch Files
;
PrepBatch                                   
          pack       FileNameError from "Opening Batch"
           PREPARE       BatchFL,"Batch.txt","Batch.isi","-n,u,z,y,1-10,21-29","140",EXCLUSIVE
           PREPARE       BatchFL2,"Batch.txt","Batch2.isi","-n,z,y,1-10,42-50","140",EXCLUSIVE
           PREPARE       BatchFL3,"Batch.txt","Batch3.isi","-n,z,y,1-10,30-37,42-50","140",EXCLUSIVE
           RETURN
;=========================================================================================;
;
; Standard Return Values for I/O Include
;
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

;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    1 Meade Ave                                              ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 532-6266                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    BatchChecks.FD                                                ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    07-08-2019 At 11:34                                            ;
;                                                                             ;
;  PURPOSE:                                                                   ;
;                                                                             ;
; REVISION:     Ver        Date     INIT       DETAILS                        ;
;                                                                             ;
;              00107   07-08-2019   HOR     INITIAL VERSION                  ;
;                                                                             ;
;=============================================================================;
;
          %IFNDEF $BatchChecksVARIO
 
$BatchChecksVARIO                EQUATE         1
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
; Test Read for BatchChecksKY Index
;
TSTBatchChecks                              
          pack       FileNameError from "Testing ","BatchChecks"
          READ       BatchChecksFL,BatchChecksKY;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for BatchChecksKY Index
;
RDBatchChecks                               
          pack       FileNameError from "Reading ","BatchChecks"
          READ       BatchChecksFL,BatchChecksKY;BatchChecks
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for BatchChecksKY Index
;
RDBatchChecksLK                             
          pack       FileNameError from "Reading ","BatchChecks"
          READLK     BatchChecksFL,BatchChecksKY;BatchChecks
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for BatchChecksKY Index
;
KSBatchChecks                               
          pack       FileNameError from "Reading KS ","BatchChecks"
          READKS     BatchChecksFL;BatchChecks
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for BatchChecksKY Index
;
KSBatchChecksLK                             
          pack       FileNameError from "Reading KS Locked ","BatchChecks"
          READKSLK   BatchChecksFL;BatchChecks
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for BatchChecksKY Index
;
KPBatchChecks                               
          pack       FileNameError from "Reaing KP ","BatchChecks"
          READKP     BatchChecksFL;BatchChecks
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for BatchChecksKY Index
;
KPBatchChecksLK                             
          pack       FileNameError from "Reading Locked KP ","BatchChecks"
          READKPLK   BatchChecksFL;BatchChecks
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Test Read for BatchChecksKY2 Index
;
TSTBatchChecks2                             
          pack       FileNameError from "Testing ","BatchChecks"
          READ       BatchChecksFL2,BatchChecksKY2;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for BatchChecksKY2 Index
;
RDBatchChecks2                              
          pack       FileNameError from "Reading ","BatchChecks"
          READ       BatchChecksFL2,BatchChecksKY2;BatchChecks
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for BatchChecksKY2 Index
;
RDBatchChecks2LK                            
          pack       FileNameError from "Reading ","BatchChecks"
          READLK     BatchChecksFL2,BatchChecksKY2;BatchChecks
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for BatchChecksKY2 Index
;
KSBatchChecks2                              
          pack       FileNameError from "Reading KS ","BatchChecks"
          READKS     BatchChecksFL2;BatchChecks
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for BatchChecksKY2 Index
;
KSBatchChecks2LK                            
          pack       FileNameError from "Reading KS Locked ","BatchChecks"
          READKSLK   BatchChecksFL2;BatchChecks
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for BatchChecksKY2 Index
;
KPBatchChecks2                              
          pack       FileNameError from "Reaing KP ","BatchChecks"
          READKP     BatchChecksFL2;BatchChecks
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for BatchChecksKY2 Index
;
KPBatchChecks2LK                            
          pack       FileNameError from "Reading Locked KP ","BatchChecks"
          READKPLK   BatchChecksFL2;BatchChecks
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Test Read for BatchChecksKY3 Index
;
TSTBatchChecks3                             
          pack       FileNameError from "Testing ","BatchChecks"
          READ       BatchChecksFL3,BatchChecksKY3;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for BatchChecksKY3 Index
;
RDBatchChecks3                              
          pack       FileNameError from "Reading ","BatchChecks"
          READ       BatchChecksFL3,BatchChecksKY3;BatchChecks
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for BatchChecksKY3 Index
;
RDBatchChecks3LK                            
          pack       FileNameError from "Reading ","BatchChecks"
          READLK     BatchChecksFL3,BatchChecksKY3;BatchChecks
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for BatchChecksKY3 Index
;
KSBatchChecks3                              
          pack       FileNameError from "Reading KS ","BatchChecks"
          READKS     BatchChecksFL3;BatchChecks
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for BatchChecksKY3 Index
;
KSBatchChecks3LK                            
          pack       FileNameError from "Reading KS Locked ","BatchChecks"
          READKSLK   BatchChecksFL3;BatchChecks
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for BatchChecksKY3 Index
;
KPBatchChecks3                              
          pack       FileNameError from "Reaing KP ","BatchChecks"
          READKP     BatchChecksFL3;BatchChecks
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for BatchChecksKY3 Index
;
KPBatchChecks3LK                            
          pack       FileNameError from "Reading Locked KP ","BatchChecks"
          READKPLK   BatchChecksFL3;BatchChecks
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Test Read for BatchChecksKY4 Index
;
TSTBatchChecks4                             
          pack       FileNameError from "Testing ","BatchChecks"
          READ       BatchChecksFL4,BatchChecksKY4;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for BatchChecksKY4 Index
;
RDBatchChecks4                              
          pack       FileNameError from "Reading ","BatchChecks"
          READ       BatchChecksFL4,BatchChecksKY4;BatchChecks
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for BatchChecksKY4 Index
;
RDBatchChecks4LK                            
          pack       FileNameError from "Reading ","BatchChecks"
          READLK     BatchChecksFL4,BatchChecksKY4;BatchChecks
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for BatchChecksKY4 Index
;
KSBatchChecks4                              
          pack       FileNameError from "Reading KS ","BatchChecks"
          READKS     BatchChecksFL4;BatchChecks
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for BatchChecksKY4 Index
;
KSBatchChecks4LK                            
          pack       FileNameError from "Reading KS Locked ","BatchChecks"
          READKSLK   BatchChecksFL4;BatchChecks
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for BatchChecksKY4 Index
;
KPBatchChecks4                              
          pack       FileNameError from "Reaing KP ","BatchChecks"
          READKP     BatchChecksFL4;BatchChecks
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for BatchChecksKY4 Index
;
KPBatchChecks4LK                            
          pack       FileNameError from "Reading Locked KP ","BatchChecks"
          READKPLK   BatchChecksFL4;BatchChecks
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Update of BatchChecks Record
;
UpdBatchChecks                              
          pack       FileNameError from "Updating ","BatchChecks"
          UPDATE     BatchChecksFLST;BatchChecks
          GOTO       #VALID
;=========================================================================================;
;
; Deletion of BatchChecks Record
;
DelBatchChecks                              
          pack       FileNameError from "Deleting ","BatchChecks"
          DELETE     BatchChecksFLST
          GOTO       #VALID
;=========================================================================================;
;
; Write for BatchChecks Record
;
WrtBatchChecks                              
          pack       FileNameError from "Writing ","BatchChecks"
          WRITE      BatchChecksFLST;BatchChecks
          GOTO       #VALID
;=========================================================================================;
;
;  Opening of BatchChecks Files
;
OpenBatchChecks                             
          GETFILE          BatchChecksFL
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening BatchChecks"
          OPEN             BatchChecksFLST,LockManual,Single,NoWait
          RETURN
;=========================================================================================;
;
;  Opening of BatchChecks Files in Read-Only Mode
;
OpenBatchChecksRO                           
          GETFILE          BatchChecksFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening BatchChecks"
          OPEN             BatchChecksFLST,READ
          RETURN
;=========================================================================================;
;
;  Opening of BatchChecks Files in Read-Only Mode
;
OpenBatchChecksEx                           
          GETFILE          BatchChecksFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening BatchChecks"
          OPEN             BatchChecksFLST,Exclusive
          RETURN
;=========================================================================================;
;
;  Preparing of BatchChecks Files
;
PrepBatchChecks                             
          pack       FileNameError from "Opening BatchChecks"
           PREPARE       BatchChecksFL,"BatchChecks.txt","BatchChecks.isi","-n,z,y,1-8,33-33,43-51","210",EXCLUSIVE
           PREPARE       BatchChecksFL2,"BatchChecks.txt","BatchChecks2.isi","-n,z,y,1-8,43-51","210",EXCLUSIVE
           PREPARE       BatchChecksFL3,"BatchChecks.txt","BatchChecks3.isi","-n,z,y,1-8,17-22,43-51","210",EXCLUSIVE
           PREPARE       BatchChecksFL4,"BatchChecks.txt","BatchChecks4.isi","-n,z,y,1-8,17-22,23-32,43-51","210",EXCLUSIVE
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
 
 
#BatchChecksError
          PACK        #ErrorString from "Error ",#Operand," BatchChecks FileActual Error : ",S$ERROR$
          BEEP
          ALERT       STOP,#ErrorString,result,"I/O Error"
          STOP
 
 
#EndOfRoutine
          %ENDIF          //End of IO Include File

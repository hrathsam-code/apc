;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    1 Meade Ave                                              ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 532-6266                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    BatchDetails.FD                                                ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    07-05-2019 At 15:00                                            ;
;                                                                             ;
;  PURPOSE:                                                                   ;
;                                                                             ;
; REVISION:     Ver        Date     INIT       DETAILS                        ;
;                                                                             ;
;              00106   07-05-2019   HOR     INITIAL VERSION                  ;
;                                                                             ;
;=============================================================================;
;
          %IFNDEF $BatchDetailsVARIO
 
$BatchDetailsVARIO               EQUATE         1
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
; Test Read for BatchDetailsKY Index
;
TSTBatchDetails                             
          pack       FileNameError from "Testing ","BatchDetails"
          READ       BatchDetailsFL,BatchDetailsKY;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for BatchDetailsKY Index
;
RDBatchDetails                              
          pack       FileNameError from "Reading ","BatchDetails"
          READ       BatchDetailsFL,BatchDetailsKY;BatchDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for BatchDetailsKY Index
;
RDBatchDetailsLK                            
          pack       FileNameError from "Reading ","BatchDetails"
          READLK     BatchDetailsFL,BatchDetailsKY;BatchDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for BatchDetailsKY Index
;
KSBatchDetails                              
          pack       FileNameError from "Reading KS ","BatchDetails"
          READKS     BatchDetailsFL;BatchDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for BatchDetailsKY Index
;
KSBatchDetailsLK                            
          pack       FileNameError from "Reading KS Locked ","BatchDetails"
          READKSLK   BatchDetailsFL;BatchDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for BatchDetailsKY Index
;
KPBatchDetails                              
          pack       FileNameError from "Reaing KP ","BatchDetails"
          READKP     BatchDetailsFL;BatchDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for BatchDetailsKY Index
;
KPBatchDetailsLK                            
          pack       FileNameError from "Reading Locked KP ","BatchDetails"
          READKPLK   BatchDetailsFL;BatchDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Test Read for BatchDetailsKY2 Index
;
TSTBatchDetails2                            
          pack       FileNameError from "Testing ","BatchDetails"
          READ       BatchDetailsFL2,BatchDetailsKY2;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for BatchDetailsKY2 Index
;
RDBatchDetails2                             
          pack       FileNameError from "Reading ","BatchDetails"
          READ       BatchDetailsFL2,BatchDetailsKY2;BatchDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for BatchDetailsKY2 Index
;
RDBatchDetails2LK                           
          pack       FileNameError from "Reading ","BatchDetails"
          READLK     BatchDetailsFL2,BatchDetailsKY2;BatchDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for BatchDetailsKY2 Index
;
KSBatchDetails2                             
          pack       FileNameError from "Reading KS ","BatchDetails"
          READKS     BatchDetailsFL2;BatchDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for BatchDetailsKY2 Index
;
KSBatchDetails2LK                           
          pack       FileNameError from "Reading KS Locked ","BatchDetails"
          READKSLK   BatchDetailsFL2;BatchDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for BatchDetailsKY2 Index
;
KPBatchDetails2                             
          pack       FileNameError from "Reaing KP ","BatchDetails"
          READKP     BatchDetailsFL2;BatchDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for BatchDetailsKY2 Index
;
KPBatchDetails2LK                           
          pack       FileNameError from "Reading Locked KP ","BatchDetails"
          READKPLK   BatchDetailsFL2;BatchDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Update of BatchDetails Record
;
UpdBatchDetails                             
          pack       FileNameError from "Updating ","BatchDetails"
          UPDATE     BatchDetailsFLST;BatchDetails
          GOTO       #VALID
;=========================================================================================;
;
; Deletion of BatchDetails Record
;
DelBatchDetails                             
          pack       FileNameError from "Deleting ","BatchDetails"
          DELETE     BatchDetailsFLST
          GOTO       #VALID
;=========================================================================================;
;
; Write for BatchDetails Record
;
WrtBatchDetails                             
          pack       FileNameError from "Writing ","BatchDetails"
          WRITE      BatchDetailsFLST;BatchDetails
          GOTO       #VALID
;=========================================================================================;
;
;  Opening of BatchDetails Files
;
OpenBatchDetails                            
          GETFILE          BatchDetailsFL
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening BatchDetails"
          OPEN             BatchDetailsFLST,LockManual,Multiple,NoWait
          RETURN
;=========================================================================================;
;
;  Opening of BatchDetails Files in Read-Only Mode
;
OpenBatchDetailsRO                          
          GETFILE          BatchDetailsFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening BatchDetails"
          OPEN             BatchDetailsFLST,READ
          RETURN
;=========================================================================================;
;
;  Opening of BatchDetails Files in Read-Only Mode
;
OpenBatchDetailsEx                          
          GETFILE          BatchDetailsFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening BatchDetails"
          OPEN             BatchDetailsFLST,Exclusive
          RETURN
;=========================================================================================;
;
;  Preparing of BatchDetails Files
;
PrepBatchDetails                            
          pack       FileNameError from "Opening BatchDetails"
           PREPARE       BatchDetailsFL,"BatchDetails.txt","BatchDetails.isi","-n,w,z,y,1-10,49-57,79-87","87",EXCLUSIVE
           PREPARE       BatchDetailsFL2,"BatchDetails.txt","BatchDetails2.isi","-n,z,y,1-10,79-87","87",EXCLUSIVE
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
 
 
#BatchDetailsError
          PACK        #ErrorString from "Error ",#Operand," BatchDetails FileActual Error : ",S$ERROR$
          BEEP
          ALERT       STOP,#ErrorString,result,"I/O Error"
          STOP
 
 
#EndOfRoutine
          %ENDIF          //End of IO Include File

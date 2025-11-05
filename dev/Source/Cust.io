;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    1 Meade Ave                                              ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 532-6266                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    Cust.FD                                                ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    05-02-2018 At 13:38                                            ;
;                                                                             ;
;  PURPOSE:                                                                   ;
;                                                                             ;
; REVISION:     Ver        Date     INIT       DETAILS                        ;
;                                                                             ;
;              00325   05-02-2018   HOR     INITIAL VERSION                  ;
;                                                                             ;
;=============================================================================;
;
          %IFNDEF $CustVARIO
 
$CustVARIO                       EQUATE         1
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
; Test Read for CustKY Index
;
TSTCust                                     
          pack       FileNameError from "Testing ","Cust"
          READ       CustFL,CustKY;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for CustKY Index
;
RDCust                                      
          pack       FileNameError from "Reading ","Cust"
          READ       CustFL,CustKY;Cust
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for CustKY Index
;
RDCustLK                                    
          pack       FileNameError from "Reading ","Cust"
          READLK     CustFL,CustKY;Cust
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for CustKY Index
;
KSCust                                      
          pack       FileNameError from "Reading KS ","Cust"
          READKS     CustFL;Cust
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for CustKY Index
;
KSCustLK                                    
          pack       FileNameError from "Reading KS Locked ","Cust"
          READKSLK   CustFL;Cust
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for CustKY Index
;
KPCust                                      
          pack       FileNameError from "Reaing KP ","Cust"
          READKP     CustFL;Cust
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for CustKY Index
;
KPCustLK                                    
          pack       FileNameError from "Reading Locked KP ","Cust"
          READKPLK   CustFL;Cust
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Test Read for CustKY2 Index
;
TSTCust2                                    
          pack       FileNameError from "Testing ","Cust"
          READ       CustFL2,CustKY2;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for CustKY2 Index
;
RDCust2                                     
          pack       FileNameError from "Reading ","Cust"
          READ       CustFL2,CustKY2;Cust
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for CustKY2 Index
;
RDCust2LK                                   
          pack       FileNameError from "Reading ","Cust"
          READLK     CustFL2,CustKY2;Cust
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for CustKY2 Index
;
KSCust2                                     
          pack       FileNameError from "Reading KS ","Cust"
          READKS     CustFL2;Cust
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for CustKY2 Index
;
KSCust2LK                                   
          pack       FileNameError from "Reading KS Locked ","Cust"
          READKSLK   CustFL2;Cust
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for CustKY2 Index
;
KPCust2                                     
          pack       FileNameError from "Reaing KP ","Cust"
          READKP     CustFL2;Cust
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for CustKY2 Index
;
KPCust2LK                                   
          pack       FileNameError from "Reading Locked KP ","Cust"
          READKPLK   CustFL2;Cust
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Test Read for CustKY3 Index
;
TSTCust3                                    
          pack       FileNameError from "Testing ","Cust"
          READ       CustFL3,CustKY3;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for CustKY3 Index
;
RDCust3                                     
          pack       FileNameError from "Reading ","Cust"
          READ       CustFL3,CustKY3;Cust
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for CustKY3 Index
;
RDCust3LK                                   
          pack       FileNameError from "Reading ","Cust"
          READLK     CustFL3,CustKY3;Cust
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for CustKY3 Index
;
KSCust3                                     
          pack       FileNameError from "Reading KS ","Cust"
          READKS     CustFL3;Cust
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for CustKY3 Index
;
KSCust3LK                                   
          pack       FileNameError from "Reading KS Locked ","Cust"
          READKSLK   CustFL3;Cust
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for CustKY3 Index
;
KPCust3                                     
          pack       FileNameError from "Reaing KP ","Cust"
          READKP     CustFL3;Cust
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for CustKY3 Index
;
KPCust3LK                                   
          pack       FileNameError from "Reading Locked KP ","Cust"
          READKPLK   CustFL3;Cust
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Test Read for CustKY4 Index
;
TSTCust4                                    
          pack       FileNameError from "Testing ","Cust"
          READ       CustFL4,CustKY4;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for CustKY4 Index
;
RDCust4                                     
          pack       FileNameError from "Reading ","Cust"
          READ       CustFL4,CustKY4;Cust
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for CustKY4 Index
;
RDCust4LK                                   
          pack       FileNameError from "Reading ","Cust"
          READLK     CustFL4,CustKY4;Cust
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for CustKY4 Index
;
KSCust4                                     
          pack       FileNameError from "Reading KS ","Cust"
          READKS     CustFL4;Cust
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for CustKY4 Index
;
KSCust4LK                                   
          pack       FileNameError from "Reading KS Locked ","Cust"
          READKSLK   CustFL4;Cust
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for CustKY4 Index
;
KPCust4                                     
          pack       FileNameError from "Reaing KP ","Cust"
          READKP     CustFL4;Cust
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for CustKY4 Index
;
KPCust4LK                                   
          pack       FileNameError from "Reading Locked KP ","Cust"
          READKPLK   CustFL4;Cust
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Update of Cust Record
;
UpdCust                                     
          pack       FileNameError from "Updating ","Cust"
          UPDATE     CustFLST;Cust
          GOTO       #VALID
;=========================================================================================;
;
; Deletion of Cust Record
;
DelCust                                     
          pack       FileNameError from "Deleting ","Cust"
          DELETE     CustFLST
          GOTO       #VALID
;=========================================================================================;
;
; Write for Cust Record
;
WrtCust                                     
          pack       FileNameError from "Writing ","Cust"
          WRITE      CustFLST;Cust
          GOTO       #VALID
.
. Random Aamdex Read for CustAAM Aamdex
.
RDCustA1                                    
          READ       CustA1,CustAAMKY1,CustAAMKY2,CustAAMKY3,CustAAMKY4,CustAAMKY5,CustAAMKY6;Cust
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Sequential Aamdex Read for CustAAM Aamdex
.
KGCustA1                                    
          READKG     CustA1;Cust
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Previous Aamdex Read for CustAAM Aamdex
.
KGPCustA1                                   
          READKGP    CustA1;Cust
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
;  Opening of Cust Files
;
OpenCust                                    
          GETFILE          CustFL
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening Cust"
          OPEN             CustFLST,LockManual,Single,NoWait
          RETURN
;=========================================================================================;
;
;  Opening of Cust Files in Read-Only Mode
;
OpenCustRO                                  
          GETFILE          CustFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening Cust"
          OPEN             CustFLST,READ
          RETURN
;=========================================================================================;
;
;  Opening of Cust Files in Read-Only Mode
;
OpenCustEx                                  
          GETFILE          CustFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening Cust"
          OPEN             CustFLST,Exclusive
          RETURN
;=========================================================================================;
;
;  Preparing of Cust Files
;
PrepCust                                    
          pack       FileNameError from "Opening Cust"
           PREPARE       CustFL,"Cust.txt","Cust.isi","-n,z,y,1-10","1024",EXCLUSIVE
           PREPARE       CustFL2,"Cust.txt","Cust2.isi","-n,z,y,11-70,1-10","1024",EXCLUSIVE
           PREPARE       CustFL3,"Cust.txt","Cust3.isi","-n,z,y,516-521,1-10","1024",EXCLUSIVE
           PREPARE       CustFL4,"Cust.txt","Cust4.isi","-n,z,y,265-274,1-10","1024",EXCLUSIVE
           PREPARE       CustA1,"Cust.txt","Cust.AAM","-z,11-70,131-160,221-250,251-252,253-262,265-274","1024",EXCLUSIVE
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
 
 
#CustError
          PACK        #ErrorString from "Error ",#Operand," Cust FileActual Error : ",S$ERROR$
          BEEP
          ALERT       STOP,#ErrorString,result,"I/O Error"
          STOP
 
 
#EndOfRoutine
          %ENDIF          //End of IO Include File

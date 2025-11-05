;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    1 Meade Ave                                              ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 532-6266                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    TaxCode.FD                                                ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    05-02-2018 At 13:51                                            ;
;                                                                             ;
;  PURPOSE:                                                                   ;
;                                                                             ;
; REVISION:     Ver        Date     INIT       DETAILS                        ;
;                                                                             ;
;              00114   05-02-2018   HOR     INITIAL VERSION                  ;
;                                                                             ;
;=============================================================================;
;
          %IFNDEF $TaxCodeVARIO
 
$TaxCodeVARIO                    EQUATE         1
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
; Test Read for TaxCodeKY Index
;
TSTTaxCode                                  
          pack       FileNameError from "Testing ","TaxCode"
          READ       TaxCodeFL,TaxCodeKY;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for TaxCodeKY Index
;
RDTaxCode                                   
          pack       FileNameError from "Reading ","TaxCode"
          READ       TaxCodeFL,TaxCodeKY;TaxCode
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for TaxCodeKY Index
;
RDTaxCodeLK                                 
          pack       FileNameError from "Reading ","TaxCode"
          READLK     TaxCodeFL,TaxCodeKY;TaxCode
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for TaxCodeKY Index
;
KSTaxCode                                   
          pack       FileNameError from "Reading KS ","TaxCode"
          READKS     TaxCodeFL;TaxCode
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for TaxCodeKY Index
;
KSTaxCodeLK                                 
          pack       FileNameError from "Reading KS Locked ","TaxCode"
          READKSLK   TaxCodeFL;TaxCode
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for TaxCodeKY Index
;
KPTaxCode                                   
          pack       FileNameError from "Reaing KP ","TaxCode"
          READKP     TaxCodeFL;TaxCode
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for TaxCodeKY Index
;
KPTaxCodeLK                                 
          pack       FileNameError from "Reading Locked KP ","TaxCode"
          READKPLK   TaxCodeFL;TaxCode
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Test Read for TaxCodeKY2 Index
;
TSTTaxCode2                                 
          pack       FileNameError from "Testing ","TaxCode"
          READ       TaxCodeFL2,TaxCodeKY2;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for TaxCodeKY2 Index
;
RDTaxCode2                                  
          pack       FileNameError from "Reading ","TaxCode"
          READ       TaxCodeFL2,TaxCodeKY2;TaxCode
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for TaxCodeKY2 Index
;
RDTaxCode2LK                                
          pack       FileNameError from "Reading ","TaxCode"
          READLK     TaxCodeFL2,TaxCodeKY2;TaxCode
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for TaxCodeKY2 Index
;
KSTaxCode2                                  
          pack       FileNameError from "Reading KS ","TaxCode"
          READKS     TaxCodeFL2;TaxCode
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for TaxCodeKY2 Index
;
KSTaxCode2LK                                
          pack       FileNameError from "Reading KS Locked ","TaxCode"
          READKSLK   TaxCodeFL2;TaxCode
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for TaxCodeKY2 Index
;
KPTaxCode2                                  
          pack       FileNameError from "Reaing KP ","TaxCode"
          READKP     TaxCodeFL2;TaxCode
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for TaxCodeKY2 Index
;
KPTaxCode2LK                                
          pack       FileNameError from "Reading Locked KP ","TaxCode"
          READKPLK   TaxCodeFL2;TaxCode
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Test Read for TaxCodeKY3 Index
;
TSTTaxCode3                                 
          pack       FileNameError from "Testing ","TaxCode"
          READ       TaxCodeFL3,TaxCodeKY3;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for TaxCodeKY3 Index
;
RDTaxCode3                                  
          pack       FileNameError from "Reading ","TaxCode"
          READ       TaxCodeFL3,TaxCodeKY3;TaxCode
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for TaxCodeKY3 Index
;
RDTaxCode3LK                                
          pack       FileNameError from "Reading ","TaxCode"
          READLK     TaxCodeFL3,TaxCodeKY3;TaxCode
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for TaxCodeKY3 Index
;
KSTaxCode3                                  
          pack       FileNameError from "Reading KS ","TaxCode"
          READKS     TaxCodeFL3;TaxCode
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for TaxCodeKY3 Index
;
KSTaxCode3LK                                
          pack       FileNameError from "Reading KS Locked ","TaxCode"
          READKSLK   TaxCodeFL3;TaxCode
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for TaxCodeKY3 Index
;
KPTaxCode3                                  
          pack       FileNameError from "Reaing KP ","TaxCode"
          READKP     TaxCodeFL3;TaxCode
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for TaxCodeKY3 Index
;
KPTaxCode3LK                                
          pack       FileNameError from "Reading Locked KP ","TaxCode"
          READKPLK   TaxCodeFL3;TaxCode
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Update of TaxCode Record
;
UpdTaxCode                                  
          pack       FileNameError from "Updating ","TaxCode"
          UPDATE     TaxCodeFLST;TaxCode
          GOTO       #VALID
;=========================================================================================;
;
; Deletion of TaxCode Record
;
DelTaxCode                                  
          pack       FileNameError from "Deleting ","TaxCode"
          DELETE     TaxCodeFLST
          GOTO       #VALID
;=========================================================================================;
;
; Write for TaxCode Record
;
WrtTaxCode                                  
          pack       FileNameError from "Writing ","TaxCode"
          WRITE      TaxCodeFLST;TaxCode
          GOTO       #VALID
;=========================================================================================;
;
;  Opening of TaxCode Files
;
OpenTaxCode                                 
          GETFILE          TaxCodeFL
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening TaxCode"
          OPEN             TaxCodeFLST,LockManual,Single,NoWait
          RETURN
;=========================================================================================;
;
;  Opening of TaxCode Files in Read-Only Mode
;
OpenTaxCodeRO                               
          GETFILE          TaxCodeFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening TaxCode"
          OPEN             TaxCodeFLST,READ
          RETURN
;=========================================================================================;
;
;  Opening of TaxCode Files in Read-Only Mode
;
OpenTaxCodeEx                               
          GETFILE          TaxCodeFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening TaxCode"
          OPEN             TaxCodeFLST,Exclusive
          RETURN
;=========================================================================================;
;
;  Preparing of TaxCode Files
;
PrepTaxCode                                 
          pack       FileNameError from "Opening TaxCode"
           PREPARE       TaxCodeFL,"TaxCode.txt","TaxCode.isi","-n,1-8","84",EXCLUSIVE
           PREPARE       TaxCodeFL2,"TaxCode.txt","TaxCode2.isi","-n,9-38,1-8","84",EXCLUSIVE
           PREPARE       TaxCodeFL3,"TaxCode.txt","TaxCode3.isi","-n,75-84,39-47","84",EXCLUSIVE
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
 
 
#TaxCodeError
          PACK        #ErrorString from "Error ",#Operand," TaxCode FileActual Error : ",S$ERROR$
          BEEP
          ALERT       STOP,#ErrorString,result,"I/O Error"
          STOP
 
 
#EndOfRoutine
          %ENDIF          //End of IO Include File

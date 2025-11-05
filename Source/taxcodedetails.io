;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    1 Meade Ave                                              ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 532-6266                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    TaxCodeDetails.FD                                                ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    04-17-2020 At 21:00                                            ;
;                                                                             ;
;  PURPOSE:                                                                   ;
;                                                                             ;
; REVISION:     Ver        Date     INIT       DETAILS                        ;
;                                                                             ;
;              00101   04-17-2020   HOR     INITIAL VERSION                  ;
;                                                                             ;
;=============================================================================;
;
          %IFNDEF $TaxCodeDetailsVARIO
 
$TaxCodeDetailsVARIO             EQUATE         1
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
; Test Read for TaxCodeDetailsKY Index
;
TSTTaxCodeDetails                           
          pack       FileNameError from "Testing ","TaxCodeDetails"
          READ       TaxCodeDetailsFL,TaxCodeDetailsKY;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for TaxCodeDetailsKY Index
;
RDTaxCodeDetails                            
          pack       FileNameError from "Reading ","TaxCodeDetails"
          READ       TaxCodeDetailsFL,TaxCodeDetailsKY;TaxCodeDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for TaxCodeDetailsKY Index
;
RDTaxCodeDetailsLK                          
          pack       FileNameError from "Reading ","TaxCodeDetails"
          READLK     TaxCodeDetailsFL,TaxCodeDetailsKY;TaxCodeDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for TaxCodeDetailsKY Index
;
KSTaxCodeDetails                            
          pack       FileNameError from "Reading KS ","TaxCodeDetails"
          READKS     TaxCodeDetailsFL;TaxCodeDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for TaxCodeDetailsKY Index
;
KSTaxCodeDetailsLK                          
          pack       FileNameError from "Reading KS Locked ","TaxCodeDetails"
          READKSLK   TaxCodeDetailsFL;TaxCodeDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for TaxCodeDetailsKY Index
;
KPTaxCodeDetails                            
          pack       FileNameError from "Reaing KP ","TaxCodeDetails"
          READKP     TaxCodeDetailsFL;TaxCodeDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for TaxCodeDetailsKY Index
;
KPTaxCodeDetailsLK                          
          pack       FileNameError from "Reading Locked KP ","TaxCodeDetails"
          READKPLK   TaxCodeDetailsFL;TaxCodeDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Test Read for TaxCodeDetailsKY2 Index
;
TSTTaxCodeDetails2                          
          pack       FileNameError from "Testing ","TaxCodeDetails"
          READ       TaxCodeDetailsFL2,TaxCodeDetailsKY2;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for TaxCodeDetailsKY2 Index
;
RDTaxCodeDetails2                           
          pack       FileNameError from "Reading ","TaxCodeDetails"
          READ       TaxCodeDetailsFL2,TaxCodeDetailsKY2;TaxCodeDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for TaxCodeDetailsKY2 Index
;
RDTaxCodeDetails2LK                         
          pack       FileNameError from "Reading ","TaxCodeDetails"
          READLK     TaxCodeDetailsFL2,TaxCodeDetailsKY2;TaxCodeDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for TaxCodeDetailsKY2 Index
;
KSTaxCodeDetails2                           
          pack       FileNameError from "Reading KS ","TaxCodeDetails"
          READKS     TaxCodeDetailsFL2;TaxCodeDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for TaxCodeDetailsKY2 Index
;
KSTaxCodeDetails2LK                         
          pack       FileNameError from "Reading KS Locked ","TaxCodeDetails"
          READKSLK   TaxCodeDetailsFL2;TaxCodeDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for TaxCodeDetailsKY2 Index
;
KPTaxCodeDetails2                           
          pack       FileNameError from "Reaing KP ","TaxCodeDetails"
          READKP     TaxCodeDetailsFL2;TaxCodeDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for TaxCodeDetailsKY2 Index
;
KPTaxCodeDetails2LK                         
          pack       FileNameError from "Reading Locked KP ","TaxCodeDetails"
          READKPLK   TaxCodeDetailsFL2;TaxCodeDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Update of TaxCodeDetails Record
;
UpdTaxCodeDetails                           
          pack       FileNameError from "Updating ","TaxCodeDetails"
          UPDATE     TaxCodeDetailsFLST;TaxCodeDetails
          GOTO       #VALID
;=========================================================================================;
;
; Deletion of TaxCodeDetails Record
;
DelTaxCodeDetails                           
          pack       FileNameError from "Deleting ","TaxCodeDetails"
          DELETE     TaxCodeDetailsFLST
          GOTO       #VALID
;=========================================================================================;
;
; Write for TaxCodeDetails Record
;
WrtTaxCodeDetails                           
          pack       FileNameError from "Writing ","TaxCodeDetails"
          WRITE      TaxCodeDetailsFLST;TaxCodeDetails
          GOTO       #VALID
;=========================================================================================;
;
;  Opening of TaxCodeDetails Files
;
OpenTaxCodeDetails                          
          GETFILE          TaxCodeDetailsFL
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening TaxCodeDetails"
          OPEN             TaxCodeDetailsFLST,LockManual,Multiple,NoWait
          RETURN
;=========================================================================================;
;
;  Opening of TaxCodeDetails Files in Read-Only Mode
;
OpenTaxCodeDetailsRO                        
          GETFILE          TaxCodeDetailsFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening TaxCodeDetails"
          OPEN             TaxCodeDetailsFLST,READ
          RETURN
;=========================================================================================;
;
;  Opening of TaxCodeDetails Files in Read-Only Mode
;
OpenTaxCodeDetailsEx                        
          GETFILE          TaxCodeDetailsFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening TaxCodeDetails"
          OPEN             TaxCodeDetailsFLST,Exclusive
          RETURN
;=========================================================================================;
;
;  Preparing of TaxCodeDetails Files
;
PrepTaxCodeDetails                          
          pack       FileNameError from "Opening TaxCodeDetails"
           PREPARE       TaxCodeDetailsFL,"TaxCodeDetails.txt","TaxCodeDetails.isi","-n,z,y,19-27,28-29","100",EXCLUSIVE
           PREPARE       TaxCodeDetailsFL2,"TaxCodeDetails.txt","TaxCodeDetails2.isi","-n,z,y,19-27,1-9,28-29","100",EXCLUSIVE
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
 
 
#TaxCodeDetailsError
          PACK        #ErrorString from "Error ",#Operand," TaxCodeDetails FileActual Error : ",S$ERROR$
          BEEP
          ALERT       STOP,#ErrorString,result,"I/O Error"
          STOP
 
 
#EndOfRoutine
          %ENDIF          //End of IO Include File

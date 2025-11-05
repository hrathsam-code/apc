;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    1 Meade Ave                                              ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 532-6266                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    TaxType.FD                                                ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    05-02-2018 At 13:51                                            ;
;                                                                             ;
;  PURPOSE:                                                                   ;
;                                                                             ;
; REVISION:     Ver        Date     INIT       DETAILS                        ;
;                                                                             ;
;              00107   05-02-2018   HOR     INITIAL VERSION                  ;
;                                                                             ;
;=============================================================================;
;
          %IFNDEF $TaxTypeVARIO
 
$TaxTypeVARIO                    EQUATE         1
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
; Test Read for TaxTypeKY Index
;
TSTTaxType                                  
          pack       FileNameError from "Testing ","TaxType"
          READ       TaxTypeFL,TaxTypeKY;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for TaxTypeKY Index
;
RDTaxType                                   
          pack       FileNameError from "Reading ","TaxType"
          READ       TaxTypeFL,TaxTypeKY;TaxType
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for TaxTypeKY Index
;
RDTaxTypeLK                                 
          pack       FileNameError from "Reading ","TaxType"
          READLK     TaxTypeFL,TaxTypeKY;TaxType
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for TaxTypeKY Index
;
KSTaxType                                   
          pack       FileNameError from "Reading KS ","TaxType"
          READKS     TaxTypeFL;TaxType
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for TaxTypeKY Index
;
KSTaxTypeLK                                 
          pack       FileNameError from "Reading KS Locked ","TaxType"
          READKSLK   TaxTypeFL;TaxType
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for TaxTypeKY Index
;
KPTaxType                                   
          pack       FileNameError from "Reaing KP ","TaxType"
          READKP     TaxTypeFL;TaxType
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for TaxTypeKY Index
;
KPTaxTypeLK                                 
          pack       FileNameError from "Reading Locked KP ","TaxType"
          READKPLK   TaxTypeFL;TaxType
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Test Read for TaxTypeKY2 Index
;
TSTTaxType2                                 
          pack       FileNameError from "Testing ","TaxType"
          READ       TaxTypeFL2,TaxTypeKY2;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for TaxTypeKY2 Index
;
RDTaxType2                                  
          pack       FileNameError from "Reading ","TaxType"
          READ       TaxTypeFL2,TaxTypeKY2;TaxType
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for TaxTypeKY2 Index
;
RDTaxType2LK                                
          pack       FileNameError from "Reading ","TaxType"
          READLK     TaxTypeFL2,TaxTypeKY2;TaxType
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for TaxTypeKY2 Index
;
KSTaxType2                                  
          pack       FileNameError from "Reading KS ","TaxType"
          READKS     TaxTypeFL2;TaxType
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for TaxTypeKY2 Index
;
KSTaxType2LK                                
          pack       FileNameError from "Reading KS Locked ","TaxType"
          READKSLK   TaxTypeFL2;TaxType
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for TaxTypeKY2 Index
;
KPTaxType2                                  
          pack       FileNameError from "Reaing KP ","TaxType"
          READKP     TaxTypeFL2;TaxType
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for TaxTypeKY2 Index
;
KPTaxType2LK                                
          pack       FileNameError from "Reading Locked KP ","TaxType"
          READKPLK   TaxTypeFL2;TaxType
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Update of TaxType Record
;
UpdTaxType                                  
          pack       FileNameError from "Updating ","TaxType"
          UPDATE     TaxTypeFLST;TaxType
          GOTO       #VALID
;=========================================================================================;
;
; Deletion of TaxType Record
;
DelTaxType                                  
          pack       FileNameError from "Deleting ","TaxType"
          DELETE     TaxTypeFLST
          GOTO       #VALID
;=========================================================================================;
;
; Write for TaxType Record
;
WrtTaxType                                  
          pack       FileNameError from "Writing ","TaxType"
          WRITE      TaxTypeFLST;TaxType
          GOTO       #VALID
;=========================================================================================;
;
;  Opening of TaxType Files
;
OpenTaxType                                 
          GETFILE          TaxTypeFL
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening TaxType"
          OPEN             TaxTypeFLST,LockManual,Single,NoWait
          RETURN
;=========================================================================================;
;
;  Opening of TaxType Files in Read-Only Mode
;
OpenTaxTypeRO                               
          GETFILE          TaxTypeFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening TaxType"
          OPEN             TaxTypeFLST,READ
          RETURN
;=========================================================================================;
;
;  Opening of TaxType Files in Read-Only Mode
;
OpenTaxTypeEx                               
          GETFILE          TaxTypeFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening TaxType"
          OPEN             TaxTypeFLST,Exclusive
          RETURN
;=========================================================================================;
;
;  Preparing of TaxType Files
;
PrepTaxType                                 
          pack       FileNameError from "Opening TaxType"
           PREPARE       TaxTypeFL,"TaxType.txt","TaxType.isi","-n,z,y,1-8","180",EXCLUSIVE
           PREPARE       TaxTypeFL2,"TaxType.txt","TaxType2.isi","-n,z,y,48-56","180",EXCLUSIVE
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
 
 
#TaxTypeError
          PACK        #ErrorString from "Error ",#Operand," TaxType FileActual Error : ",S$ERROR$
          BEEP
          ALERT       STOP,#ErrorString,result,"I/O Error"
          STOP
 
 
#EndOfRoutine
          %ENDIF          //End of IO Include File

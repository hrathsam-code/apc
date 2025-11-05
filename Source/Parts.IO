;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    1 Meade Ave                                              ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 532-6266                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    Parts.FD                                                ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    05-02-2018 At 10:19                                            ;
;                                                                             ;
;  PURPOSE:                                                                   ;
;                                                                             ;
; REVISION:     Ver        Date     INIT       DETAILS                        ;
;                                                                             ;
;              00102   05-02-2018   HOR     INITIAL VERSION                  ;
;                                                                             ;
;=============================================================================;
;
          %IFNDEF $PartsVARIO
 
$PartsVARIO                      EQUATE         1
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
; Test Read for PartsKY Index
;
TSTParts                                    
          pack       FileNameError from "Testing ","Parts"
          READ       PartsFL,PartsKY;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for PartsKY Index
;
RDParts                                     
          pack       FileNameError from "Reading ","Parts"
          READ       PartsFL,PartsKY;Parts
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for PartsKY Index
;
RDPartsLK                                   
          pack       FileNameError from "Reading ","Parts"
          READLK     PartsFL,PartsKY;Parts
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for PartsKY Index
;
KSParts                                     
          pack       FileNameError from "Reading KS ","Parts"
          READKS     PartsFL;Parts
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for PartsKY Index
;
KSPartsLK                                   
          pack       FileNameError from "Reading KS Locked ","Parts"
          READKSLK   PartsFL;Parts
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for PartsKY Index
;
KPParts                                     
          pack       FileNameError from "Reaing KP ","Parts"
          READKP     PartsFL;Parts
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for PartsKY Index
;
KPPartsLK                                   
          pack       FileNameError from "Reading Locked KP ","Parts"
          READKPLK   PartsFL;Parts
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Test Read for PartsKY2 Index
;
TSTParts2                                   
          pack       FileNameError from "Testing ","Parts"
          READ       PartsFL2,PartsKY2;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for PartsKY2 Index
;
RDParts2                                    
          pack       FileNameError from "Reading ","Parts"
          READ       PartsFL2,PartsKY2;Parts
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for PartsKY2 Index
;
RDParts2LK                                  
          pack       FileNameError from "Reading ","Parts"
          READLK     PartsFL2,PartsKY2;Parts
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for PartsKY2 Index
;
KSParts2                                    
          pack       FileNameError from "Reading KS ","Parts"
          READKS     PartsFL2;Parts
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for PartsKY2 Index
;
KSParts2LK                                  
          pack       FileNameError from "Reading KS Locked ","Parts"
          READKSLK   PartsFL2;Parts
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for PartsKY2 Index
;
KPParts2                                    
          pack       FileNameError from "Reaing KP ","Parts"
          READKP     PartsFL2;Parts
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for PartsKY2 Index
;
KPParts2LK                                  
          pack       FileNameError from "Reading Locked KP ","Parts"
          READKPLK   PartsFL2;Parts
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Test Read for PartsKY3 Index
;
TSTParts3                                   
          pack       FileNameError from "Testing ","Parts"
          READ       PartsFL3,PartsKY3;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for PartsKY3 Index
;
RDParts3                                    
          pack       FileNameError from "Reading ","Parts"
          READ       PartsFL3,PartsKY3;Parts
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for PartsKY3 Index
;
RDParts3LK                                  
          pack       FileNameError from "Reading ","Parts"
          READLK     PartsFL3,PartsKY3;Parts
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for PartsKY3 Index
;
KSParts3                                    
          pack       FileNameError from "Reading KS ","Parts"
          READKS     PartsFL3;Parts
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for PartsKY3 Index
;
KSParts3LK                                  
          pack       FileNameError from "Reading KS Locked ","Parts"
          READKSLK   PartsFL3;Parts
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for PartsKY3 Index
;
KPParts3                                    
          pack       FileNameError from "Reaing KP ","Parts"
          READKP     PartsFL3;Parts
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for PartsKY3 Index
;
KPParts3LK                                  
          pack       FileNameError from "Reading Locked KP ","Parts"
          READKPLK   PartsFL3;Parts
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Update of Parts Record
;
UpdParts                                    
          pack       FileNameError from "Updating ","Parts"
          UPDATE     PartsFLST;Parts
          GOTO       #VALID
;=========================================================================================;
;
; Deletion of Parts Record
;
DelParts                                    
          pack       FileNameError from "Deleting ","Parts"
          DELETE     PartsFLST
          GOTO       #VALID
;=========================================================================================;
;
; Write for Parts Record
;
WrtParts                                    
          pack       FileNameError from "Writing ","Parts"
          WRITE      PartsFLST;Parts
          GOTO       #VALID
;=========================================================================================;
;
;  Opening of Parts Files
;
OpenParts                                   
          GETFILE          PartsFL
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening Parts"
          OPEN             PartsFLST,LockManual,Single,NoWait
          RETURN
;=========================================================================================;
;
;  Opening of Parts Files in Read-Only Mode
;
OpenPartsRO                                 
          GETFILE          PartsFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening Parts"
          OPEN             PartsFLST,READ
          RETURN
;=========================================================================================;
;
;  Opening of Parts Files in Read-Only Mode
;
OpenPartsEx                                 
          GETFILE          PartsFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening Parts"
          OPEN             PartsFLST,Exclusive
          RETURN
;=========================================================================================;
;
;  Preparing of Parts Files
;
PrepParts                                   
          pack       FileNameError from "Opening Parts"
           PREPARE       PartsFL,"Parts.txt","Parts.isi","-n,1-25","600",EXCLUSIVE
           PREPARE       PartsFL2,"Parts.txt","Parts2.isi","-w,26-34","600",EXCLUSIVE
           PREPARE       PartsFL3,"Parts.txt","Parts3.isi","-n,z,y,105-112,1-25","600",EXCLUSIVE
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
 
 
#PartsError
          PACK        #ErrorString from "Error ",#Operand," Parts FileActual Error : ",S$ERROR$
          BEEP
          ALERT       STOP,#ErrorString,result,"I/O Error"
          STOP
 
 
#EndOfRoutine
          %ENDIF          //End of IO Include File

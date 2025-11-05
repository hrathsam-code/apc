;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    1 Meade Ave                                              ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 532-6266                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    Check.FD                                                ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    07-05-2019 At 14:34                                            ;
;                                                                             ;
;  PURPOSE:                                                                   ;
;                                                                             ;
; REVISION:     Ver        Date     INIT       DETAILS                        ;
;                                                                             ;
;              10001   07-05-2019   HOR     INITIAL VERSION                  ;
;                                                                             ;
;=============================================================================;
;
          %IFNDEF $CheckVARIO
 
$CheckVARIO                      EQUATE         1
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
; Test Read for CheckKY Index
;
TSTCheck                                    
          pack       FileNameError from "Testing ","Check"
          READ       CheckFL,CheckKY;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for CheckKY Index
;
RDCheck                                     
          pack       FileNameError from "Reading ","Check"
          READ       CheckFL,CheckKY;Check
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for CheckKY Index
;
RDCheckLK                                   
          pack       FileNameError from "Reading ","Check"
          READLK     CheckFL,CheckKY;Check
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for CheckKY Index
;
KSCheck                                     
          pack       FileNameError from "Reading KS ","Check"
          READKS     CheckFL;Check
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for CheckKY Index
;
KSCheckLK                                   
          pack       FileNameError from "Reading KS Locked ","Check"
          READKSLK   CheckFL;Check
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for CheckKY Index
;
KPCheck                                     
          pack       FileNameError from "Reaing KP ","Check"
          READKP     CheckFL;Check
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for CheckKY Index
;
KPCheckLK                                   
          pack       FileNameError from "Reading Locked KP ","Check"
          READKPLK   CheckFL;Check
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Test Read for CheckKY2 Index
;
TSTCheck2                                   
          pack       FileNameError from "Testing ","Check"
          READ       CheckFL2,CheckKY2;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for CheckKY2 Index
;
RDCheck2                                    
          pack       FileNameError from "Reading ","Check"
          READ       CheckFL2,CheckKY2;Check
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for CheckKY2 Index
;
RDCheck2LK                                  
          pack       FileNameError from "Reading ","Check"
          READLK     CheckFL2,CheckKY2;Check
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for CheckKY2 Index
;
KSCheck2                                    
          pack       FileNameError from "Reading KS ","Check"
          READKS     CheckFL2;Check
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for CheckKY2 Index
;
KSCheck2LK                                  
          pack       FileNameError from "Reading KS Locked ","Check"
          READKSLK   CheckFL2;Check
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for CheckKY2 Index
;
KPCheck2                                    
          pack       FileNameError from "Reaing KP ","Check"
          READKP     CheckFL2;Check
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for CheckKY2 Index
;
KPCheck2LK                                  
          pack       FileNameError from "Reading Locked KP ","Check"
          READKPLK   CheckFL2;Check
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Test Read for CheckKY3 Index
;
TSTCheck3                                   
          pack       FileNameError from "Testing ","Check"
          READ       CheckFL3,CheckKY3;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for CheckKY3 Index
;
RDCheck3                                    
          pack       FileNameError from "Reading ","Check"
          READ       CheckFL3,CheckKY3;Check
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for CheckKY3 Index
;
RDCheck3LK                                  
          pack       FileNameError from "Reading ","Check"
          READLK     CheckFL3,CheckKY3;Check
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for CheckKY3 Index
;
KSCheck3                                    
          pack       FileNameError from "Reading KS ","Check"
          READKS     CheckFL3;Check
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for CheckKY3 Index
;
KSCheck3LK                                  
          pack       FileNameError from "Reading KS Locked ","Check"
          READKSLK   CheckFL3;Check
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for CheckKY3 Index
;
KPCheck3                                    
          pack       FileNameError from "Reaing KP ","Check"
          READKP     CheckFL3;Check
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for CheckKY3 Index
;
KPCheck3LK                                  
          pack       FileNameError from "Reading Locked KP ","Check"
          READKPLK   CheckFL3;Check
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Update of Check Record
;
UpdCheck                                    
          pack       FileNameError from "Updating ","Check"
          UPDATE     CheckFLST;Check
          GOTO       #VALID
;=========================================================================================;
;
; Deletion of Check Record
;
DelCheck                                    
          pack       FileNameError from "Deleting ","Check"
          DELETE     CheckFLST
          GOTO       #VALID
;=========================================================================================;
;
; Write for Check Record
;
WrtCheck                                    
          pack       FileNameError from "Writing ","Check"
          WRITE      CheckFLST;Check
          GOTO       #VALID
;=========================================================================================;
;
;  Opening of Check Files
;
OpenCheck                                   
          GETFILE          CheckFL
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening Check"
          OPEN             CheckFLST,LockManual,Single,NoWait
          RETURN
;=========================================================================================;
;
;  Opening of Check Files in Read-Only Mode
;
OpenCheckRO                                 
          GETFILE          CheckFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening Check"
          OPEN             CheckFLST,READ
          RETURN
;=========================================================================================;
;
;  Opening of Check Files in Read-Only Mode
;
OpenCheckEx                                 
          GETFILE          CheckFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening Check"
          OPEN             CheckFLST,Exclusive
          RETURN
;=========================================================================================;
;
;  Preparing of Check Files
;
PrepCheck                                   
          pack       FileNameError from "Opening Check"
           PREPARE       CheckFL,"CheckFL.txt","CheckFL.isi","-n,z,y,1-8,23-28,29-38","190",EXCLUSIVE
           PREPARE       CheckFL2,"CheckFL.txt","CheckFL2.isi","-n,z,y,1-8,17-22,39-46,91-97","190",EXCLUSIVE
           PREPARE       CheckFL3,"CheckFL.txt","CheckFL3.isi","-n,z,y,1-8,39-46,29-38,17-22,23-28","190",EXCLUSIVE
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
 
 
#CheckError
          PACK        #ErrorString from "Error ",#Operand," Check FileActual Error : ",S$ERROR$
          BEEP
          ALERT       STOP,#ErrorString,result,"I/O Error"
          STOP
 
 
#EndOfRoutine
          %ENDIF          //End of IO Include File

;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    1 Meade Ave                                              ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 532-6266                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    CheckRun.FD                                                ;
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
          %IFNDEF $CheckRunVARIO
 
$CheckRunVARIO                   EQUATE         1
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
; Test Read for CheckRunKY Index
;
TSTCheckRun                                 
          pack       FileNameError from "Testing ","CheckRun"
          READ       CheckRunFL,CheckRunKY;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for CheckRunKY Index
;
RDCheckRun                                  
          pack       FileNameError from "Reading ","CheckRun"
          READ       CheckRunFL,CheckRunKY;CheckRun
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for CheckRunKY Index
;
RDCheckRunLK                                
          pack       FileNameError from "Reading ","CheckRun"
          READLK     CheckRunFL,CheckRunKY;CheckRun
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for CheckRunKY Index
;
KSCheckRun                                  
          pack       FileNameError from "Reading KS ","CheckRun"
          READKS     CheckRunFL;CheckRun
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for CheckRunKY Index
;
KSCheckRunLK                                
          pack       FileNameError from "Reading KS Locked ","CheckRun"
          READKSLK   CheckRunFL;CheckRun
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for CheckRunKY Index
;
KPCheckRun                                  
          pack       FileNameError from "Reaing KP ","CheckRun"
          READKP     CheckRunFL;CheckRun
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for CheckRunKY Index
;
KPCheckRunLK                                
          pack       FileNameError from "Reading Locked KP ","CheckRun"
          READKPLK   CheckRunFL;CheckRun
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Update of CheckRun Record
;
UpdCheckRun                                 
          pack       FileNameError from "Updating ","CheckRun"
          UPDATE     CheckRunFLST;CheckRun
          GOTO       #VALID
;=========================================================================================;
;
; Deletion of CheckRun Record
;
DelCheckRun                                 
          pack       FileNameError from "Deleting ","CheckRun"
          DELETE     CheckRunFLST
          GOTO       #VALID
;=========================================================================================;
;
; Write for CheckRun Record
;
WrtCheckRun                                 
          pack       FileNameError from "Writing ","CheckRun"
          WRITE      CheckRunFLST;CheckRun
          GOTO       #VALID
;=========================================================================================;
;
;  Opening of CheckRun Files
;
OpenCheckRun                                
          GETFILE          CheckRunFL
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening CheckRun"
          OPEN             CheckRunFLST,LockManual,Single,NoWait
          RETURN
;=========================================================================================;
;
;  Opening of CheckRun Files in Read-Only Mode
;
OpenCheckRunRO                              
          GETFILE          CheckRunFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening CheckRun"
          OPEN             CheckRunFLST,READ
          RETURN
;=========================================================================================;
;
;  Opening of CheckRun Files in Read-Only Mode
;
OpenCheckRunEx                              
          GETFILE          CheckRunFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening CheckRun"
          OPEN             CheckRunFLST,Exclusive
          RETURN
;=========================================================================================;
;
;  Preparing of CheckRun Files
;
PrepCheckRun                                
          pack       FileNameError from "Opening CheckRun"
           PREPARE       CheckRunFL,"CheckRun.txt","CheckRun.isi","-n,z,y,1-8,17-22,23-28,91-97","165",EXCLUSIVE
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
 
 
#CheckRunError
          PACK        #ErrorString from "Error ",#Operand," CheckRun FileActual Error : ",S$ERROR$
          BEEP
          ALERT       STOP,#ErrorString,result,"I/O Error"
          STOP
 
 
#EndOfRoutine
          %ENDIF          //End of IO Include File

;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    1 Meade Ave                                              ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 532-6266                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    QTDetails.FD                                                ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    05-02-2018 At 13:47                                            ;
;                                                                             ;
;  PURPOSE:                                                                   ;
;                                                                             ;
; REVISION:     Ver        Date     INIT       DETAILS                        ;
;                                                                             ;
;              00110   05-02-2018   HOR     INITIAL VERSION                  ;
;                                                                             ;
;=============================================================================;
;
          %IFNDEF $QTDetailsVARIO
 
$QTDetailsVARIO                  EQUATE         1
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
; Test Read for QTDetailsKY Index
;
TSTQTDetails                                
          pack       FileNameError from "Testing ","QTDetails"
          READ       QTDetailsFL,QTDetailsKY;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for QTDetailsKY Index
;
RDQTDetails                                 
          pack       FileNameError from "Reading ","QTDetails"
          READ       QTDetailsFL,QTDetailsKY;QTDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for QTDetailsKY Index
;
RDQTDetailsLK                               
          pack       FileNameError from "Reading ","QTDetails"
          READLK     QTDetailsFL,QTDetailsKY;QTDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for QTDetailsKY Index
;
KSQTDetails                                 
          pack       FileNameError from "Reading KS ","QTDetails"
          READKS     QTDetailsFL;QTDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for QTDetailsKY Index
;
KSQTDetailsLK                               
          pack       FileNameError from "Reading KS Locked ","QTDetails"
          READKSLK   QTDetailsFL;QTDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for QTDetailsKY Index
;
KPQTDetails                                 
          pack       FileNameError from "Reaing KP ","QTDetails"
          READKP     QTDetailsFL;QTDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for QTDetailsKY Index
;
KPQTDetailsLK                               
          pack       FileNameError from "Reading Locked KP ","QTDetails"
          READKPLK   QTDetailsFL;QTDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Test Read for QTDetailsKY2 Index
;
TSTQTDetails2                               
          pack       FileNameError from "Testing ","QTDetails"
          READ       QTDetailsFL2,QTDetailsKY2;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for QTDetailsKY2 Index
;
RDQTDetails2                                
          pack       FileNameError from "Reading ","QTDetails"
          READ       QTDetailsFL2,QTDetailsKY2;QTDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for QTDetailsKY2 Index
;
RDQTDetails2LK                              
          pack       FileNameError from "Reading ","QTDetails"
          READLK     QTDetailsFL2,QTDetailsKY2;QTDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for QTDetailsKY2 Index
;
KSQTDetails2                                
          pack       FileNameError from "Reading KS ","QTDetails"
          READKS     QTDetailsFL2;QTDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for QTDetailsKY2 Index
;
KSQTDetails2LK                              
          pack       FileNameError from "Reading KS Locked ","QTDetails"
          READKSLK   QTDetailsFL2;QTDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for QTDetailsKY2 Index
;
KPQTDetails2                                
          pack       FileNameError from "Reaing KP ","QTDetails"
          READKP     QTDetailsFL2;QTDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for QTDetailsKY2 Index
;
KPQTDetails2LK                              
          pack       FileNameError from "Reading Locked KP ","QTDetails"
          READKPLK   QTDetailsFL2;QTDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Test Read for QTDetailsKY3 Index
;
TSTQTDetails3                               
          pack       FileNameError from "Testing ","QTDetails"
          READ       QTDetailsFL3,QTDetailsKY3;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for QTDetailsKY3 Index
;
RDQTDetails3                                
          pack       FileNameError from "Reading ","QTDetails"
          READ       QTDetailsFL3,QTDetailsKY3;QTDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for QTDetailsKY3 Index
;
RDQTDetails3LK                              
          pack       FileNameError from "Reading ","QTDetails"
          READLK     QTDetailsFL3,QTDetailsKY3;QTDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for QTDetailsKY3 Index
;
KSQTDetails3                                
          pack       FileNameError from "Reading KS ","QTDetails"
          READKS     QTDetailsFL3;QTDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for QTDetailsKY3 Index
;
KSQTDetails3LK                              
          pack       FileNameError from "Reading KS Locked ","QTDetails"
          READKSLK   QTDetailsFL3;QTDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for QTDetailsKY3 Index
;
KPQTDetails3                                
          pack       FileNameError from "Reaing KP ","QTDetails"
          READKP     QTDetailsFL3;QTDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for QTDetailsKY3 Index
;
KPQTDetails3LK                              
          pack       FileNameError from "Reading Locked KP ","QTDetails"
          READKPLK   QTDetailsFL3;QTDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Update of QTDetails Record
;
UpdQTDetails                                
          pack       FileNameError from "Updating ","QTDetails"
          UPDATE     QTDetailsFLST;QTDetails
          GOTO       #VALID
;=========================================================================================;
;
; Deletion of QTDetails Record
;
DelQTDetails                                
          pack       FileNameError from "Deleting ","QTDetails"
          DELETE     QTDetailsFLST
          GOTO       #VALID
;=========================================================================================;
;
; Write for QTDetails Record
;
WrtQTDetails                                
          pack       FileNameError from "Writing ","QTDetails"
          WRITE      QTDetailsFLST;QTDetails
          GOTO       #VALID
;=========================================================================================;
;
;  Opening of QTDetails Files
;
OpenQTDetails                               
          GETFILE          QTDetailsFL
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening QTDetails"
          OPEN             QTDetailsFLST,LockManual,Single,NoWait
          RETURN
;=========================================================================================;
;
;  Opening of QTDetails Files in Read-Only Mode
;
OpenQTDetailsRO                             
          GETFILE          QTDetailsFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening QTDetails"
          OPEN             QTDetailsFLST,READ
          RETURN
;=========================================================================================;
;
;  Opening of QTDetails Files in Read-Only Mode
;
OpenQTDetailsEx                             
          GETFILE          QTDetailsFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening QTDetails"
          OPEN             QTDetailsFLST,Exclusive
          RETURN
;=========================================================================================;
;
;  Preparing of QTDetails Files
;
PrepQTDetails                               
          pack       FileNameError from "Opening QTDetails"
           PREPARE       QTDetailsFL,"QTDetails.txt","QTDetails.isi","-n,z,y,1-8,9-17,49-52","423",EXCLUSIVE
           PREPARE       QTDetailsFL2,"QTDetails.txt","QTDetails2.isi","-n,w,z,y,1-8,9-17,53-77,49-52","423",EXCLUSIVE
           PREPARE       QTDetailsFL3,"QTDetails.txt","QTDetails3.isi","-n,w,z,y,1-8,36-44,45-48","423",EXCLUSIVE
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
 
 
#QTDetailsError
          PACK        #ErrorString from "Error ",#Operand," QTDetails FileActual Error : ",S$ERROR$
          BEEP
          ALERT       STOP,#ErrorString,result,"I/O Error"
          STOP
 
 
#EndOfRoutine
          %ENDIF          //End of IO Include File

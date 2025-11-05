;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    1 Meade Ave                                              ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 532-6266                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    QTHeader.FD                                                ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    05-02-2018 At 13:49                                            ;
;                                                                             ;
;  PURPOSE:                                                                   ;
;                                                                             ;
; REVISION:     Ver        Date     INIT       DETAILS                        ;
;                                                                             ;
;              00112   05-02-2018   HOR     INITIAL VERSION                  ;
;                                                                             ;
;=============================================================================;
;
          %IFNDEF $QTHeaderVARIO
 
$QTHeaderVARIO                   EQUATE         1
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
; Test Read for QTHeaderKY Index
;
TSTQTHeader                                 
          pack       FileNameError from "Testing ","QTHeader"
          READ       QTHeaderFL,QTHeaderKY;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for QTHeaderKY Index
;
RDQTHeader                                  
          pack       FileNameError from "Reading ","QTHeader"
          READ       QTHeaderFL,QTHeaderKY;QTHeader
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for QTHeaderKY Index
;
RDQTHeaderLK                                
          pack       FileNameError from "Reading ","QTHeader"
          READLK     QTHeaderFL,QTHeaderKY;QTHeader
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for QTHeaderKY Index
;
KSQTHeader                                  
          pack       FileNameError from "Reading KS ","QTHeader"
          READKS     QTHeaderFL;QTHeader
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for QTHeaderKY Index
;
KSQTHeaderLK                                
          pack       FileNameError from "Reading KS Locked ","QTHeader"
          READKSLK   QTHeaderFL;QTHeader
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for QTHeaderKY Index
;
KPQTHeader                                  
          pack       FileNameError from "Reaing KP ","QTHeader"
          READKP     QTHeaderFL;QTHeader
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for QTHeaderKY Index
;
KPQTHeaderLK                                
          pack       FileNameError from "Reading Locked KP ","QTHeader"
          READKPLK   QTHeaderFL;QTHeader
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Test Read for QTHeaderKY2 Index
;
TSTQTHeader2                                
          pack       FileNameError from "Testing ","QTHeader"
          READ       QTHeaderFL2,QTHeaderKY2;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for QTHeaderKY2 Index
;
RDQTHeader2                                 
          pack       FileNameError from "Reading ","QTHeader"
          READ       QTHeaderFL2,QTHeaderKY2;QTHeader
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for QTHeaderKY2 Index
;
RDQTHeader2LK                               
          pack       FileNameError from "Reading ","QTHeader"
          READLK     QTHeaderFL2,QTHeaderKY2;QTHeader
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for QTHeaderKY2 Index
;
KSQTHeader2                                 
          pack       FileNameError from "Reading KS ","QTHeader"
          READKS     QTHeaderFL2;QTHeader
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for QTHeaderKY2 Index
;
KSQTHeader2LK                               
          pack       FileNameError from "Reading KS Locked ","QTHeader"
          READKSLK   QTHeaderFL2;QTHeader
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for QTHeaderKY2 Index
;
KPQTHeader2                                 
          pack       FileNameError from "Reaing KP ","QTHeader"
          READKP     QTHeaderFL2;QTHeader
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for QTHeaderKY2 Index
;
KPQTHeader2LK                               
          pack       FileNameError from "Reading Locked KP ","QTHeader"
          READKPLK   QTHeaderFL2;QTHeader
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Test Read for QTHeaderKY3 Index
;
TSTQTHeader3                                
          pack       FileNameError from "Testing ","QTHeader"
          READ       QTHeaderFL3,QTHeaderKY3;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for QTHeaderKY3 Index
;
RDQTHeader3                                 
          pack       FileNameError from "Reading ","QTHeader"
          READ       QTHeaderFL3,QTHeaderKY3;QTHeader
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for QTHeaderKY3 Index
;
RDQTHeader3LK                               
          pack       FileNameError from "Reading ","QTHeader"
          READLK     QTHeaderFL3,QTHeaderKY3;QTHeader
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for QTHeaderKY3 Index
;
KSQTHeader3                                 
          pack       FileNameError from "Reading KS ","QTHeader"
          READKS     QTHeaderFL3;QTHeader
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for QTHeaderKY3 Index
;
KSQTHeader3LK                               
          pack       FileNameError from "Reading KS Locked ","QTHeader"
          READKSLK   QTHeaderFL3;QTHeader
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for QTHeaderKY3 Index
;
KPQTHeader3                                 
          pack       FileNameError from "Reaing KP ","QTHeader"
          READKP     QTHeaderFL3;QTHeader
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for QTHeaderKY3 Index
;
KPQTHeader3LK                               
          pack       FileNameError from "Reading Locked KP ","QTHeader"
          READKPLK   QTHeaderFL3;QTHeader
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Test Read for QTHeaderKY4 Index
;
TSTQTHeader4                                
          pack       FileNameError from "Testing ","QTHeader"
          READ       QTHeaderFL4,QTHeaderKY4;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for QTHeaderKY4 Index
;
RDQTHeader4                                 
          pack       FileNameError from "Reading ","QTHeader"
          READ       QTHeaderFL4,QTHeaderKY4;QTHeader
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for QTHeaderKY4 Index
;
RDQTHeader4LK                               
          pack       FileNameError from "Reading ","QTHeader"
          READLK     QTHeaderFL4,QTHeaderKY4;QTHeader
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for QTHeaderKY4 Index
;
KSQTHeader4                                 
          pack       FileNameError from "Reading KS ","QTHeader"
          READKS     QTHeaderFL4;QTHeader
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for QTHeaderKY4 Index
;
KSQTHeader4LK                               
          pack       FileNameError from "Reading KS Locked ","QTHeader"
          READKSLK   QTHeaderFL4;QTHeader
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for QTHeaderKY4 Index
;
KPQTHeader4                                 
          pack       FileNameError from "Reaing KP ","QTHeader"
          READKP     QTHeaderFL4;QTHeader
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for QTHeaderKY4 Index
;
KPQTHeader4LK                               
          pack       FileNameError from "Reading Locked KP ","QTHeader"
          READKPLK   QTHeaderFL4;QTHeader
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Test Read for QTHeaderKY5 Index
;
TSTQTHeader5                                
          pack       FileNameError from "Testing ","QTHeader"
          READ       QTHeaderFL5,QTHeaderKY5;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for QTHeaderKY5 Index
;
RDQTHeader5                                 
          pack       FileNameError from "Reading ","QTHeader"
          READ       QTHeaderFL5,QTHeaderKY5;QTHeader
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for QTHeaderKY5 Index
;
RDQTHeader5LK                               
          pack       FileNameError from "Reading ","QTHeader"
          READLK     QTHeaderFL5,QTHeaderKY5;QTHeader
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for QTHeaderKY5 Index
;
KSQTHeader5                                 
          pack       FileNameError from "Reading KS ","QTHeader"
          READKS     QTHeaderFL5;QTHeader
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for QTHeaderKY5 Index
;
KSQTHeader5LK                               
          pack       FileNameError from "Reading KS Locked ","QTHeader"
          READKSLK   QTHeaderFL5;QTHeader
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for QTHeaderKY5 Index
;
KPQTHeader5                                 
          pack       FileNameError from "Reaing KP ","QTHeader"
          READKP     QTHeaderFL5;QTHeader
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for QTHeaderKY5 Index
;
KPQTHeader5LK                               
          pack       FileNameError from "Reading Locked KP ","QTHeader"
          READKPLK   QTHeaderFL5;QTHeader
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Update of QTHeader Record
;
UpdQTHeader                                 
          pack       FileNameError from "Updating ","QTHeader"
          UPDATE     QTHeaderFLST;QTHeader
          GOTO       #VALID
;=========================================================================================;
;
; Deletion of QTHeader Record
;
DelQTHeader                                 
          pack       FileNameError from "Deleting ","QTHeader"
          DELETE     QTHeaderFLST
          GOTO       #VALID
;=========================================================================================;
;
; Write for QTHeader Record
;
WrtQTHeader                                 
          pack       FileNameError from "Writing ","QTHeader"
          WRITE      QTHeaderFLST;QTHeader
          GOTO       #VALID
;=========================================================================================;
;
;  Opening of QTHeader Files
;
OpenQTHeader                                
          GETFILE          QTHeaderFL
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening QTHeader"
          OPEN             QTHeaderFLST,LockManual,Single,NoWait
          RETURN
;=========================================================================================;
;
;  Opening of QTHeader Files in Read-Only Mode
;
OpenQTHeaderRO                              
          GETFILE          QTHeaderFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening QTHeader"
          OPEN             QTHeaderFLST,READ
          RETURN
;=========================================================================================;
;
;  Opening of QTHeader Files in Read-Only Mode
;
OpenQTHeaderEx                              
          GETFILE          QTHeaderFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening QTHeader"
          OPEN             QTHeaderFLST,Exclusive
          RETURN
;=========================================================================================;
;
;  Preparing of QTHeader Files
;
PrepQTHeader                                
          pack       FileNameError from "Opening QTHeader"
           PREPARE       QTHeaderFL,"QTHeader.txt","QTHeader.isi","-n,z,y,1-8,9-17","800",EXCLUSIVE
           PREPARE       QTHeaderFL2,"QTHeader.txt","QTHeader2.isi","-n,w,z,y,1-8,85-92,9-17","800",EXCLUSIVE
           PREPARE       QTHeaderFL3,"QTHeader.txt","QTHeader3.isi","-n,w,z,y,1-8,655-655,9-17","800",EXCLUSIVE
           PREPARE       QTHeaderFL4,"QTHeader.txt","QTHeader4.isi","-n,z,y,1-8,45-50,85-92,9-17","800",EXCLUSIVE
           PREPARE       QTHeaderFL5,"QTHeader.txt","QTHeader5.isi","-n,z,y,1-8,57-76,9-17","800",EXCLUSIVE
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
 
 
#QTHeaderError
          PACK        #ErrorString from "Error ",#Operand," QTHeader FileActual Error : ",S$ERROR$
          BEEP
          ALERT       STOP,#ErrorString,result,"I/O Error"
          STOP
 
 
#EndOfRoutine
          %ENDIF          //End of IO Include File

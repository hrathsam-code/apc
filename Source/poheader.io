;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    1 Meade Ave                                              ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 532-6266                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    POHeader.FD                                                ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    05-02-2018 At 13:49                                            ;
;                                                                             ;
;  PURPOSE:                                                                   ;
;                                                                             ;
; REVISION:     Ver        Date     INIT       DETAILS                        ;
;                                                                             ;
;              00111   05-02-2018   HOR     INITIAL VERSION                  ;
;                                                                             ;
;=============================================================================;
;
          %IFNDEF $POHeaderVARIO
 
$POHeaderVARIO                   EQUATE         1
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
; Test Read for POHeaderKY Index
;
TSTPOHeader                                 
          pack       FileNameError from "Testing ","POHeader"
          READ       POHeaderFL,POHeaderKY;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for POHeaderKY Index
;
RDPOHeader                                  
          pack       FileNameError from "Reading ","POHeader"
          READ       POHeaderFL,POHeaderKY;POHeader
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for POHeaderKY Index
;
RDPOHeaderLK                                
          pack       FileNameError from "Reading ","POHeader"
          READLK     POHeaderFL,POHeaderKY;POHeader
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for POHeaderKY Index
;
KSPOHeader                                  
          pack       FileNameError from "Reading KS ","POHeader"
          READKS     POHeaderFL;POHeader
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for POHeaderKY Index
;
KSPOHeaderLK                                
          pack       FileNameError from "Reading KS Locked ","POHeader"
          READKSLK   POHeaderFL;POHeader
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for POHeaderKY Index
;
KPPOHeader                                  
          pack       FileNameError from "Reaing KP ","POHeader"
          READKP     POHeaderFL;POHeader
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for POHeaderKY Index
;
KPPOHeaderLK                                
          pack       FileNameError from "Reading Locked KP ","POHeader"
          READKPLK   POHeaderFL;POHeader
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Test Read for POHeaderKY2 Index
;
TSTPOHeader2                                
          pack       FileNameError from "Testing ","POHeader"
          READ       POHeaderFL2,POHeaderKY2;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for POHeaderKY2 Index
;
RDPOHeader2                                 
          pack       FileNameError from "Reading ","POHeader"
          READ       POHeaderFL2,POHeaderKY2;POHeader
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for POHeaderKY2 Index
;
RDPOHeader2LK                               
          pack       FileNameError from "Reading ","POHeader"
          READLK     POHeaderFL2,POHeaderKY2;POHeader
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for POHeaderKY2 Index
;
KSPOHeader2                                 
          pack       FileNameError from "Reading KS ","POHeader"
          READKS     POHeaderFL2;POHeader
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for POHeaderKY2 Index
;
KSPOHeader2LK                               
          pack       FileNameError from "Reading KS Locked ","POHeader"
          READKSLK   POHeaderFL2;POHeader
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for POHeaderKY2 Index
;
KPPOHeader2                                 
          pack       FileNameError from "Reaing KP ","POHeader"
          READKP     POHeaderFL2;POHeader
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for POHeaderKY2 Index
;
KPPOHeader2LK                               
          pack       FileNameError from "Reading Locked KP ","POHeader"
          READKPLK   POHeaderFL2;POHeader
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Test Read for POHeaderKY3 Index
;
TSTPOHeader3                                
          pack       FileNameError from "Testing ","POHeader"
          READ       POHeaderFL3,POHeaderKY3;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for POHeaderKY3 Index
;
RDPOHeader3                                 
          pack       FileNameError from "Reading ","POHeader"
          READ       POHeaderFL3,POHeaderKY3;POHeader
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for POHeaderKY3 Index
;
RDPOHeader3LK                               
          pack       FileNameError from "Reading ","POHeader"
          READLK     POHeaderFL3,POHeaderKY3;POHeader
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for POHeaderKY3 Index
;
KSPOHeader3                                 
          pack       FileNameError from "Reading KS ","POHeader"
          READKS     POHeaderFL3;POHeader
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for POHeaderKY3 Index
;
KSPOHeader3LK                               
          pack       FileNameError from "Reading KS Locked ","POHeader"
          READKSLK   POHeaderFL3;POHeader
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for POHeaderKY3 Index
;
KPPOHeader3                                 
          pack       FileNameError from "Reaing KP ","POHeader"
          READKP     POHeaderFL3;POHeader
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for POHeaderKY3 Index
;
KPPOHeader3LK                               
          pack       FileNameError from "Reading Locked KP ","POHeader"
          READKPLK   POHeaderFL3;POHeader
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Test Read for POHeaderKY4 Index
;
TSTPOHeader4                                
          pack       FileNameError from "Testing ","POHeader"
          READ       POHeaderFL4,POHeaderKY4;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for POHeaderKY4 Index
;
RDPOHeader4                                 
          pack       FileNameError from "Reading ","POHeader"
          READ       POHeaderFL4,POHeaderKY4;POHeader
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for POHeaderKY4 Index
;
RDPOHeader4LK                               
          pack       FileNameError from "Reading ","POHeader"
          READLK     POHeaderFL4,POHeaderKY4;POHeader
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for POHeaderKY4 Index
;
KSPOHeader4                                 
          pack       FileNameError from "Reading KS ","POHeader"
          READKS     POHeaderFL4;POHeader
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for POHeaderKY4 Index
;
KSPOHeader4LK                               
          pack       FileNameError from "Reading KS Locked ","POHeader"
          READKSLK   POHeaderFL4;POHeader
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for POHeaderKY4 Index
;
KPPOHeader4                                 
          pack       FileNameError from "Reaing KP ","POHeader"
          READKP     POHeaderFL4;POHeader
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for POHeaderKY4 Index
;
KPPOHeader4LK                               
          pack       FileNameError from "Reading Locked KP ","POHeader"
          READKPLK   POHeaderFL4;POHeader
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Test Read for POHeaderKY5 Index
;
TSTPOHeader5                                
          pack       FileNameError from "Testing ","POHeader"
          READ       POHeaderFL5,POHeaderKY5;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for POHeaderKY5 Index
;
RDPOHeader5                                 
          pack       FileNameError from "Reading ","POHeader"
          READ       POHeaderFL5,POHeaderKY5;POHeader
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for POHeaderKY5 Index
;
RDPOHeader5LK                               
          pack       FileNameError from "Reading ","POHeader"
          READLK     POHeaderFL5,POHeaderKY5;POHeader
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for POHeaderKY5 Index
;
KSPOHeader5                                 
          pack       FileNameError from "Reading KS ","POHeader"
          READKS     POHeaderFL5;POHeader
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for POHeaderKY5 Index
;
KSPOHeader5LK                               
          pack       FileNameError from "Reading KS Locked ","POHeader"
          READKSLK   POHeaderFL5;POHeader
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for POHeaderKY5 Index
;
KPPOHeader5                                 
          pack       FileNameError from "Reaing KP ","POHeader"
          READKP     POHeaderFL5;POHeader
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for POHeaderKY5 Index
;
KPPOHeader5LK                               
          pack       FileNameError from "Reading Locked KP ","POHeader"
          READKPLK   POHeaderFL5;POHeader
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Update of POHeader Record
;
UpdPOHeader                                 
          pack       FileNameError from "Updating ","POHeader"
          UPDATE     POHeaderFLST;POHeader
          GOTO       #VALID
;=========================================================================================;
;
; Deletion of POHeader Record
;
DelPOHeader                                 
          pack       FileNameError from "Deleting ","POHeader"
          DELETE     POHeaderFLST
          GOTO       #VALID
;=========================================================================================;
;
; Write for POHeader Record
;
WrtPOHeader                                 
          pack       FileNameError from "Writing ","POHeader"
          WRITE      POHeaderFLST;POHeader
          GOTO       #VALID
;=========================================================================================;
;
;  Opening of POHeader Files
;
OpenPOHeader                                
          GETFILE          POHeaderFL
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening POHeader"
          OPEN             POHeaderFLST,LockManual,Single,NoWait
          RETURN
;=========================================================================================;
;
;  Opening of POHeader Files in Read-Only Mode
;
OpenPOHeaderRO                              
          GETFILE          POHeaderFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening POHeader"
          OPEN             POHeaderFLST,READ
          RETURN
;=========================================================================================;
;
;  Opening of POHeader Files in Read-Only Mode
;
OpenPOHeaderEx                              
          GETFILE          POHeaderFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening POHeader"
          OPEN             POHeaderFLST,Exclusive
          RETURN
;=========================================================================================;
;
;  Preparing of POHeader Files
;
PrepPOHeader                                
          pack       FileNameError from "Opening POHeader"
           PREPARE       POHeaderFL,"POHeader.txt","POHeader.isi","-n,z,y,1-8,9-17","800",EXCLUSIVE
           PREPARE       POHeaderFL2,"POHeader.txt","POHeader2.isi","-n,w,z,y,1-8,85-92,9-17","800",EXCLUSIVE
           PREPARE       POHeaderFL3,"POHeader.txt","POHeader3.isi","-n,w,z,y,1-8,655-655,9-17","800",EXCLUSIVE
           PREPARE       POHeaderFL4,"POHeader.txt","POHeader4.isi","-n,z,y,1-8,45-50,85-92,9-17","800",EXCLUSIVE
           PREPARE       POHeaderFL5,"POHeader.txt","POHeader5.isi","-n,z,y,1-8,57-76,9-17","800",EXCLUSIVE
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
 
 
#POHeaderError
          PACK        #ErrorString from "Error ",#Operand," POHeader FileActual Error : ",S$ERROR$
          BEEP
          ALERT       STOP,#ErrorString,result,"I/O Error"
          STOP
 
 
#EndOfRoutine
          %ENDIF          //End of IO Include File

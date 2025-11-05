;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    1 Meade Ave                                              ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 532-6266                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    PODetails.FD                                                ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    05-02-2018 At 13:47                                            ;
;                                                                             ;
;  PURPOSE:                                                                   ;
;                                                                             ;
; REVISION:     Ver        Date     INIT       DETAILS                        ;
;                                                                             ;
;              00112   05-02-2018   HOR     INITIAL VERSION                  ;
;                                                                             ;
;=============================================================================;
;
          %IFNDEF $PODetailsVARIO
 
$PODetailsVARIO                  EQUATE         1
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
; Test Read for PODetailsKY Index
;
TSTPODetails                                
          pack       FileNameError from "Testing ","PODetails"
          READ       PODetailsFL,PODetailsKY;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for PODetailsKY Index
;
RDPODetails                                 
          pack       FileNameError from "Reading ","PODetails"
          READ       PODetailsFL,PODetailsKY;PODetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for PODetailsKY Index
;
RDPODetailsLK                               
          pack       FileNameError from "Reading ","PODetails"
          READLK     PODetailsFL,PODetailsKY;PODetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for PODetailsKY Index
;
KSPODetails                                 
          pack       FileNameError from "Reading KS ","PODetails"
          READKS     PODetailsFL;PODetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for PODetailsKY Index
;
KSPODetailsLK                               
          pack       FileNameError from "Reading KS Locked ","PODetails"
          READKSLK   PODetailsFL;PODetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for PODetailsKY Index
;
KPPODetails                                 
          pack       FileNameError from "Reaing KP ","PODetails"
          READKP     PODetailsFL;PODetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for PODetailsKY Index
;
KPPODetailsLK                               
          pack       FileNameError from "Reading Locked KP ","PODetails"
          READKPLK   PODetailsFL;PODetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Test Read for PODetailsKY2 Index
;
TSTPODetails2                               
          pack       FileNameError from "Testing ","PODetails"
          READ       PODetailsFL2,PODetailsKY2;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for PODetailsKY2 Index
;
RDPODetails2                                
          pack       FileNameError from "Reading ","PODetails"
          READ       PODetailsFL2,PODetailsKY2;PODetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for PODetailsKY2 Index
;
RDPODetails2LK                              
          pack       FileNameError from "Reading ","PODetails"
          READLK     PODetailsFL2,PODetailsKY2;PODetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for PODetailsKY2 Index
;
KSPODetails2                                
          pack       FileNameError from "Reading KS ","PODetails"
          READKS     PODetailsFL2;PODetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for PODetailsKY2 Index
;
KSPODetails2LK                              
          pack       FileNameError from "Reading KS Locked ","PODetails"
          READKSLK   PODetailsFL2;PODetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for PODetailsKY2 Index
;
KPPODetails2                                
          pack       FileNameError from "Reaing KP ","PODetails"
          READKP     PODetailsFL2;PODetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for PODetailsKY2 Index
;
KPPODetails2LK                              
          pack       FileNameError from "Reading Locked KP ","PODetails"
          READKPLK   PODetailsFL2;PODetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Test Read for PODetailsKY3 Index
;
TSTPODetails3                               
          pack       FileNameError from "Testing ","PODetails"
          READ       PODetailsFL3,PODetailsKY3;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for PODetailsKY3 Index
;
RDPODetails3                                
          pack       FileNameError from "Reading ","PODetails"
          READ       PODetailsFL3,PODetailsKY3;PODetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for PODetailsKY3 Index
;
RDPODetails3LK                              
          pack       FileNameError from "Reading ","PODetails"
          READLK     PODetailsFL3,PODetailsKY3;PODetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for PODetailsKY3 Index
;
KSPODetails3                                
          pack       FileNameError from "Reading KS ","PODetails"
          READKS     PODetailsFL3;PODetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for PODetailsKY3 Index
;
KSPODetails3LK                              
          pack       FileNameError from "Reading KS Locked ","PODetails"
          READKSLK   PODetailsFL3;PODetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for PODetailsKY3 Index
;
KPPODetails3                                
          pack       FileNameError from "Reaing KP ","PODetails"
          READKP     PODetailsFL3;PODetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for PODetailsKY3 Index
;
KPPODetails3LK                              
          pack       FileNameError from "Reading Locked KP ","PODetails"
          READKPLK   PODetailsFL3;PODetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Update of PODetails Record
;
UpdPODetails                                
          pack       FileNameError from "Updating ","PODetails"
          UPDATE     PODetailsFLST;PODetails
          GOTO       #VALID
;=========================================================================================;
;
; Deletion of PODetails Record
;
DelPODetails                                
          pack       FileNameError from "Deleting ","PODetails"
          DELETE     PODetailsFLST
          GOTO       #VALID
;=========================================================================================;
;
; Write for PODetails Record
;
WrtPODetails                                
          pack       FileNameError from "Writing ","PODetails"
          WRITE      PODetailsFLST;PODetails
          GOTO       #VALID
;=========================================================================================;
;
;  Opening of PODetails Files
;
OpenPODetails                               
          GETFILE          PODetailsFL
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening PODetails"
          OPEN             PODetailsFLST,LockManual,Single,NoWait
          RETURN
;=========================================================================================;
;
;  Opening of PODetails Files in Read-Only Mode
;
OpenPODetailsRO                             
          GETFILE          PODetailsFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening PODetails"
          OPEN             PODetailsFLST,READ
          RETURN
;=========================================================================================;
;
;  Opening of PODetails Files in Read-Only Mode
;
OpenPODetailsEx                             
          GETFILE          PODetailsFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening PODetails"
          OPEN             PODetailsFLST,Exclusive
          RETURN
;=========================================================================================;
;
;  Preparing of PODetails Files
;
PrepPODetails                               
          pack       FileNameError from "Opening PODetails"
           PREPARE       PODetailsFL,"PODetails.txt","PODetails.isi","-n,z,y,1-8,9-17,49-52","415",EXCLUSIVE
           PREPARE       PODetailsFL2,"PODetails.txt","PODetails2.isi","-n,w,z,y,1-8,9-17,53-77,49-52","415",EXCLUSIVE
           PREPARE       PODetailsFL3,"PODetails.txt","PODetails3.isi","-n,w,z,y,1-8,36-44,45-48","415",EXCLUSIVE
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
 
 
#PODetailsError
          PACK        #ErrorString from "Error ",#Operand," PODetails FileActual Error : ",S$ERROR$
          BEEP
          ALERT       STOP,#ErrorString,result,"I/O Error"
          STOP
 
 
#EndOfRoutine
          %ENDIF          //End of IO Include File

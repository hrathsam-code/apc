;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    1 Meade Ave                                              ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 532-6266                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    InvDetails.FD                                                ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    05-02-2018 At 13:47                                            ;
;                                                                             ;
;  PURPOSE:                                                                   ;
;                                                                             ;
; REVISION:     Ver        Date     INIT       DETAILS                        ;
;                                                                             ;
;              00109   05-02-2018   HOR     INITIAL VERSION                  ;
;                                                                             ;
;=============================================================================;
;
          %IFNDEF $InvDetailsVARIO
 
$InvDetailsVARIO                 EQUATE         1
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
; Test Read for InvDetailsKY Index
;
TSTInvDetails                               
          pack       FileNameError from "Testing ","InvDetails"
          READ       InvDetailsFL,InvDetailsKY;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for InvDetailsKY Index
;
RDInvDetails                                
          pack       FileNameError from "Reading ","InvDetails"
          READ       InvDetailsFL,InvDetailsKY;InvDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for InvDetailsKY Index
;
RDInvDetailsLK                              
          pack       FileNameError from "Reading ","InvDetails"
          READLK     InvDetailsFL,InvDetailsKY;InvDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for InvDetailsKY Index
;
KSInvDetails                                
          pack       FileNameError from "Reading KS ","InvDetails"
          READKS     InvDetailsFL;InvDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for InvDetailsKY Index
;
KSInvDetailsLK                              
          pack       FileNameError from "Reading KS Locked ","InvDetails"
          READKSLK   InvDetailsFL;InvDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for InvDetailsKY Index
;
KPInvDetails                                
          pack       FileNameError from "Reaing KP ","InvDetails"
          READKP     InvDetailsFL;InvDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for InvDetailsKY Index
;
KPInvDetailsLK                              
          pack       FileNameError from "Reading Locked KP ","InvDetails"
          READKPLK   InvDetailsFL;InvDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Test Read for InvDetailsKY2 Index
;
TSTInvDetails2                              
          pack       FileNameError from "Testing ","InvDetails"
          READ       InvDetailsFL2,InvDetailsKY2;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for InvDetailsKY2 Index
;
RDInvDetails2                               
          pack       FileNameError from "Reading ","InvDetails"
          READ       InvDetailsFL2,InvDetailsKY2;InvDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for InvDetailsKY2 Index
;
RDInvDetails2LK                             
          pack       FileNameError from "Reading ","InvDetails"
          READLK     InvDetailsFL2,InvDetailsKY2;InvDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for InvDetailsKY2 Index
;
KSInvDetails2                               
          pack       FileNameError from "Reading KS ","InvDetails"
          READKS     InvDetailsFL2;InvDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for InvDetailsKY2 Index
;
KSInvDetails2LK                             
          pack       FileNameError from "Reading KS Locked ","InvDetails"
          READKSLK   InvDetailsFL2;InvDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for InvDetailsKY2 Index
;
KPInvDetails2                               
          pack       FileNameError from "Reaing KP ","InvDetails"
          READKP     InvDetailsFL2;InvDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for InvDetailsKY2 Index
;
KPInvDetails2LK                             
          pack       FileNameError from "Reading Locked KP ","InvDetails"
          READKPLK   InvDetailsFL2;InvDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Test Read for InvDetailsKY3 Index
;
TSTInvDetails3                              
          pack       FileNameError from "Testing ","InvDetails"
          READ       InvDetailsFL3,InvDetailsKY3;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for InvDetailsKY3 Index
;
RDInvDetails3                               
          pack       FileNameError from "Reading ","InvDetails"
          READ       InvDetailsFL3,InvDetailsKY3;InvDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for InvDetailsKY3 Index
;
RDInvDetails3LK                             
          pack       FileNameError from "Reading ","InvDetails"
          READLK     InvDetailsFL3,InvDetailsKY3;InvDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for InvDetailsKY3 Index
;
KSInvDetails3                               
          pack       FileNameError from "Reading KS ","InvDetails"
          READKS     InvDetailsFL3;InvDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for InvDetailsKY3 Index
;
KSInvDetails3LK                             
          pack       FileNameError from "Reading KS Locked ","InvDetails"
          READKSLK   InvDetailsFL3;InvDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for InvDetailsKY3 Index
;
KPInvDetails3                               
          pack       FileNameError from "Reaing KP ","InvDetails"
          READKP     InvDetailsFL3;InvDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for InvDetailsKY3 Index
;
KPInvDetails3LK                             
          pack       FileNameError from "Reading Locked KP ","InvDetails"
          READKPLK   InvDetailsFL3;InvDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Update of InvDetails Record
;
UpdInvDetails                               
          pack       FileNameError from "Updating ","InvDetails"
          UPDATE     InvDetailsFLST;InvDetails
          GOTO       #VALID
;=========================================================================================;
;
; Deletion of InvDetails Record
;
DelInvDetails                               
          pack       FileNameError from "Deleting ","InvDetails"
          DELETE     InvDetailsFLST
          GOTO       #VALID
;=========================================================================================;
;
; Write for InvDetails Record
;
WrtInvDetails                               
          pack       FileNameError from "Writing ","InvDetails"
          WRITE      InvDetailsFLST;InvDetails
          GOTO       #VALID
;=========================================================================================;
;
;  Opening of InvDetails Files
;
OpenInvDetails                              
          GETFILE          InvDetailsFL
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening InvDetails"
          OPEN             InvDetailsFLST,LockManual,Single,NoWait
          RETURN
;=========================================================================================;
;
;  Opening of InvDetails Files in Read-Only Mode
;
OpenInvDetailsRO                            
          GETFILE          InvDetailsFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening InvDetails"
          OPEN             InvDetailsFLST,READ
          RETURN
;=========================================================================================;
;
;  Opening of InvDetails Files in Read-Only Mode
;
OpenInvDetailsEx                            
          GETFILE          InvDetailsFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening InvDetails"
          OPEN             InvDetailsFLST,Exclusive
          RETURN
;=========================================================================================;
;
;  Preparing of InvDetails Files
;
PrepInvDetails                              
          pack       FileNameError from "Opening InvDetails"
           PREPARE       InvDetailsFL,"InvDetails.txt","InvDetails.isi","-n,z,y,1-8,9-17,49-52","423",EXCLUSIVE
           PREPARE       InvDetailsFL2,"InvDetails.txt","InvDetails2.isi","-n,w,z,y,1-8,9-17,53-77,49-52","423",EXCLUSIVE
           PREPARE       InvDetailsFL3,"InvDetails.txt","InvDetails3.isi","-n,w,z,y,1-8,36-44,45-48","423",EXCLUSIVE
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
 
 
#InvDetailsError
          PACK        #ErrorString from "Error ",#Operand," InvDetails FileActual Error : ",S$ERROR$
          BEEP
          ALERT       STOP,#ErrorString,result,"I/O Error"
          STOP
 
 
#EndOfRoutine
          %ENDIF          //End of IO Include File

;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    1 Meade Ave                                              ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 532-6266                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    CreditCards.FD                                                ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    06-28-2019 At 12:03                                            ;
;                                                                             ;
;  PURPOSE:                                                                   ;
;                                                                             ;
; REVISION:     Ver        Date     INIT       DETAILS                        ;
;                                                                             ;
;              00103   06-28-2019   HOR     INITIAL VERSION                  ;
;                                                                             ;
;=============================================================================;
;
          %IFNDEF $CreditCardsVARIO
 
$CreditCardsVARIO                EQUATE         1
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
; Test Read for CreditCardsKY Index
;
TSTCreditCards                              
          pack       FileNameError from "Testing ","CreditCards"
          READ       CreditCardsFL,CreditCardsKY;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for CreditCardsKY Index
;
RDCreditCards                               
          pack       FileNameError from "Reading ","CreditCards"
          READ       CreditCardsFL,CreditCardsKY;CreditCards
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for CreditCardsKY Index
;
RDCreditCardsLK                             
          pack       FileNameError from "Reading ","CreditCards"
          READLK     CreditCardsFL,CreditCardsKY;CreditCards
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for CreditCardsKY Index
;
KSCreditCards                               
          pack       FileNameError from "Reading KS ","CreditCards"
          READKS     CreditCardsFL;CreditCards
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for CreditCardsKY Index
;
KSCreditCardsLK                             
          pack       FileNameError from "Reading KS Locked ","CreditCards"
          READKSLK   CreditCardsFL;CreditCards
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for CreditCardsKY Index
;
KPCreditCards                               
          pack       FileNameError from "Reaing KP ","CreditCards"
          READKP     CreditCardsFL;CreditCards
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for CreditCardsKY Index
;
KPCreditCardsLK                             
          pack       FileNameError from "Reading Locked KP ","CreditCards"
          READKPLK   CreditCardsFL;CreditCards
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Test Read for CreditCardsKY2 Index
;
TSTCreditCards2                             
          pack       FileNameError from "Testing ","CreditCards"
          READ       CreditCardsFL2,CreditCardsKY2;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for CreditCardsKY2 Index
;
RDCreditCards2                              
          pack       FileNameError from "Reading ","CreditCards"
          READ       CreditCardsFL2,CreditCardsKY2;CreditCards
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for CreditCardsKY2 Index
;
RDCreditCards2LK                            
          pack       FileNameError from "Reading ","CreditCards"
          READLK     CreditCardsFL2,CreditCardsKY2;CreditCards
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for CreditCardsKY2 Index
;
KSCreditCards2                              
          pack       FileNameError from "Reading KS ","CreditCards"
          READKS     CreditCardsFL2;CreditCards
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for CreditCardsKY2 Index
;
KSCreditCards2LK                            
          pack       FileNameError from "Reading KS Locked ","CreditCards"
          READKSLK   CreditCardsFL2;CreditCards
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for CreditCardsKY2 Index
;
KPCreditCards2                              
          pack       FileNameError from "Reaing KP ","CreditCards"
          READKP     CreditCardsFL2;CreditCards
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for CreditCardsKY2 Index
;
KPCreditCards2LK                            
          pack       FileNameError from "Reading Locked KP ","CreditCards"
          READKPLK   CreditCardsFL2;CreditCards
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Update of CreditCards Record
;
UpdCreditCards                              
          pack       FileNameError from "Updating ","CreditCards"
          UPDATE     CreditCardsFLST;CreditCards
          GOTO       #VALID
;=========================================================================================;
;
; Deletion of CreditCards Record
;
DelCreditCards                              
          pack       FileNameError from "Deleting ","CreditCards"
          DELETE     CreditCardsFLST
          GOTO       #VALID
;=========================================================================================;
;
; Write for CreditCards Record
;
WrtCreditCards                              
          pack       FileNameError from "Writing ","CreditCards"
          WRITE      CreditCardsFLST;CreditCards
          GOTO       #VALID
;=========================================================================================;
;
;  Opening of CreditCards Files
;
OpenCreditCards                             
          GETFILE          CreditCardsFL
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening CreditCards"
          OPEN             CreditCardsFLST,LockManual,Single,NoWait
          RETURN
;=========================================================================================;
;
;  Opening of CreditCards Files in Read-Only Mode
;
OpenCreditCardsRO                           
          GETFILE          CreditCardsFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening CreditCards"
          OPEN             CreditCardsFLST,READ
          RETURN
;=========================================================================================;
;
;  Opening of CreditCards Files in Read-Only Mode
;
OpenCreditCardsEx                           
          GETFILE          CreditCardsFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening CreditCards"
          OPEN             CreditCardsFLST,Exclusive
          RETURN
;=========================================================================================;
;
;  Preparing of CreditCards Files
;
PrepCreditCards                             
          pack       FileNameError from "Opening CreditCards"
           PREPARE       CreditCardsFL,"CreditCards.txt","CreditCards.isi","-n,z,y,1-8,9-18,19-27","250",EXCLUSIVE
           PREPARE       CreditCardsFL2,"CreditCards.txt","CreditCards2.isi","-n,z,y,1-8,9-18,36-36,19-27","250",EXCLUSIVE
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
 
 
#CreditCardsError
          PACK        #ErrorString from "Error ",#Operand," CreditCards FileActual Error : ",S$ERROR$
          BEEP
          ALERT       STOP,#ErrorString,result,"I/O Error"
          STOP
 
 
#EndOfRoutine
          %ENDIF          //End of IO Include File

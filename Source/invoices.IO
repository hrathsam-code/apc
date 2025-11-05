;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    1 Meade Ave                                              ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 532-6266                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    Invoices.FD                                                ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    05-02-2018 At 13:49                                            ;
;                                                                             ;
;  PURPOSE:                                                                   ;
;                                                                             ;
; REVISION:     Ver        Date     INIT       DETAILS                        ;
;                                                                             ;
;              00107   05-02-2018   HOR     INITIAL VERSION                  ;
;                                                                             ;
;=============================================================================;
;
          %IFNDEF $InvoicesVARIO
 
$InvoicesVARIO                   EQUATE         1
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
; Test Read for InvoicesKY Index
;
TSTInvoices                                 
          pack       FileNameError from "Testing ","Invoices"
          READ       InvoicesFL,InvoicesKY;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for InvoicesKY Index
;
RDInvoices                                  
          pack       FileNameError from "Reading ","Invoices"
          READ       InvoicesFL,InvoicesKY;Invoices
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for InvoicesKY Index
;
RDInvoicesLK                                
          pack       FileNameError from "Reading ","Invoices"
          READLK     InvoicesFL,InvoicesKY;Invoices
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for InvoicesKY Index
;
KSInvoices                                  
          pack       FileNameError from "Reading KS ","Invoices"
          READKS     InvoicesFL;Invoices
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for InvoicesKY Index
;
KSInvoicesLK                                
          pack       FileNameError from "Reading KS Locked ","Invoices"
          READKSLK   InvoicesFL;Invoices
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for InvoicesKY Index
;
KPInvoices                                  
          pack       FileNameError from "Reaing KP ","Invoices"
          READKP     InvoicesFL;Invoices
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for InvoicesKY Index
;
KPInvoicesLK                                
          pack       FileNameError from "Reading Locked KP ","Invoices"
          READKPLK   InvoicesFL;Invoices
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Test Read for InvoicesKY2 Index
;
TSTInvoices2                                
          pack       FileNameError from "Testing ","Invoices"
          READ       InvoicesFL2,InvoicesKY2;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for InvoicesKY2 Index
;
RDInvoices2                                 
          pack       FileNameError from "Reading ","Invoices"
          READ       InvoicesFL2,InvoicesKY2;Invoices
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for InvoicesKY2 Index
;
RDInvoices2LK                               
          pack       FileNameError from "Reading ","Invoices"
          READLK     InvoicesFL2,InvoicesKY2;Invoices
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for InvoicesKY2 Index
;
KSInvoices2                                 
          pack       FileNameError from "Reading KS ","Invoices"
          READKS     InvoicesFL2;Invoices
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for InvoicesKY2 Index
;
KSInvoices2LK                               
          pack       FileNameError from "Reading KS Locked ","Invoices"
          READKSLK   InvoicesFL2;Invoices
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for InvoicesKY2 Index
;
KPInvoices2                                 
          pack       FileNameError from "Reaing KP ","Invoices"
          READKP     InvoicesFL2;Invoices
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for InvoicesKY2 Index
;
KPInvoices2LK                               
          pack       FileNameError from "Reading Locked KP ","Invoices"
          READKPLK   InvoicesFL2;Invoices
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Test Read for InvoicesKY3 Index
;
TSTInvoices3                                
          pack       FileNameError from "Testing ","Invoices"
          READ       InvoicesFL3,InvoicesKY3;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for InvoicesKY3 Index
;
RDInvoices3                                 
          pack       FileNameError from "Reading ","Invoices"
          READ       InvoicesFL3,InvoicesKY3;Invoices
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for InvoicesKY3 Index
;
RDInvoices3LK                               
          pack       FileNameError from "Reading ","Invoices"
          READLK     InvoicesFL3,InvoicesKY3;Invoices
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for InvoicesKY3 Index
;
KSInvoices3                                 
          pack       FileNameError from "Reading KS ","Invoices"
          READKS     InvoicesFL3;Invoices
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for InvoicesKY3 Index
;
KSInvoices3LK                               
          pack       FileNameError from "Reading KS Locked ","Invoices"
          READKSLK   InvoicesFL3;Invoices
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for InvoicesKY3 Index
;
KPInvoices3                                 
          pack       FileNameError from "Reaing KP ","Invoices"
          READKP     InvoicesFL3;Invoices
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for InvoicesKY3 Index
;
KPInvoices3LK                               
          pack       FileNameError from "Reading Locked KP ","Invoices"
          READKPLK   InvoicesFL3;Invoices
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Test Read for InvoicesKY4 Index
;
TSTInvoices4                                
          pack       FileNameError from "Testing ","Invoices"
          READ       InvoicesFL4,InvoicesKY4;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for InvoicesKY4 Index
;
RDInvoices4                                 
          pack       FileNameError from "Reading ","Invoices"
          READ       InvoicesFL4,InvoicesKY4;Invoices
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for InvoicesKY4 Index
;
RDInvoices4LK                               
          pack       FileNameError from "Reading ","Invoices"
          READLK     InvoicesFL4,InvoicesKY4;Invoices
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for InvoicesKY4 Index
;
KSInvoices4                                 
          pack       FileNameError from "Reading KS ","Invoices"
          READKS     InvoicesFL4;Invoices
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for InvoicesKY4 Index
;
KSInvoices4LK                               
          pack       FileNameError from "Reading KS Locked ","Invoices"
          READKSLK   InvoicesFL4;Invoices
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for InvoicesKY4 Index
;
KPInvoices4                                 
          pack       FileNameError from "Reaing KP ","Invoices"
          READKP     InvoicesFL4;Invoices
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for InvoicesKY4 Index
;
KPInvoices4LK                               
          pack       FileNameError from "Reading Locked KP ","Invoices"
          READKPLK   InvoicesFL4;Invoices
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Test Read for InvoicesKY5 Index
;
TSTInvoices5                                
          pack       FileNameError from "Testing ","Invoices"
          READ       InvoicesFL5,InvoicesKY5;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for InvoicesKY5 Index
;
RDInvoices5                                 
          pack       FileNameError from "Reading ","Invoices"
          READ       InvoicesFL5,InvoicesKY5;Invoices
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for InvoicesKY5 Index
;
RDInvoices5LK                               
          pack       FileNameError from "Reading ","Invoices"
          READLK     InvoicesFL5,InvoicesKY5;Invoices
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for InvoicesKY5 Index
;
KSInvoices5                                 
          pack       FileNameError from "Reading KS ","Invoices"
          READKS     InvoicesFL5;Invoices
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for InvoicesKY5 Index
;
KSInvoices5LK                               
          pack       FileNameError from "Reading KS Locked ","Invoices"
          READKSLK   InvoicesFL5;Invoices
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for InvoicesKY5 Index
;
KPInvoices5                                 
          pack       FileNameError from "Reaing KP ","Invoices"
          READKP     InvoicesFL5;Invoices
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for InvoicesKY5 Index
;
KPInvoices5LK                               
          pack       FileNameError from "Reading Locked KP ","Invoices"
          READKPLK   InvoicesFL5;Invoices
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Update of Invoices Record
;
UpdInvoices                                 
          pack       FileNameError from "Updating ","Invoices"
          UPDATE     InvoicesFLST;Invoices
          GOTO       #VALID
;=========================================================================================;
;
; Deletion of Invoices Record
;
DelInvoices                                 
          pack       FileNameError from "Deleting ","Invoices"
          DELETE     InvoicesFLST
          GOTO       #VALID
;=========================================================================================;
;
; Write for Invoices Record
;
WrtInvoices                                 
          pack       FileNameError from "Writing ","Invoices"
          WRITE      InvoicesFLST;Invoices
          GOTO       #VALID
;=========================================================================================;
;
;  Opening of Invoices Files
;
OpenInvoices                                
          GETFILE          InvoicesFL
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening Invoices"
          OPEN             InvoicesFLST,LockManual,Single,NoWait
          RETURN
;=========================================================================================;
;
;  Opening of Invoices Files in Read-Only Mode
;
OpenInvoicesRO                              
          GETFILE          InvoicesFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening Invoices"
          OPEN             InvoicesFLST,READ
          RETURN
;=========================================================================================;
;
;  Opening of Invoices Files in Read-Only Mode
;
OpenInvoicesEx                              
          GETFILE          InvoicesFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening Invoices"
          OPEN             InvoicesFLST,Exclusive
          RETURN
;=========================================================================================;
;
;  Preparing of Invoices Files
;
PrepInvoices                                
          pack       FileNameError from "Opening Invoices"
           PREPARE       InvoicesFL,"Invvoices.txt","Invoices.isi","-n,z,y,1-8,9-17","800",EXCLUSIVE
           PREPARE       InvoicesFL2,"Invvoices.txt","Invoices2.isi","-n,w,z,y,1-8,93-100,9-17","800",EXCLUSIVE
           PREPARE       InvoicesFL3,"Invvoices.txt","Invoices3.isi","-n,w,z,y,1-8,663-663,9-17","800",EXCLUSIVE
           PREPARE       InvoicesFL4,"Invvoices.txt","Invoices4.isi","-n,z,y,1-8,45-54,93-100,9-17","800",EXCLUSIVE
           PREPARE       InvoicesFL5,"Invvoices.txt","Invoices5.isi","-n,z,y,1-8,65-84,9-17","800",EXCLUSIVE
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
 
 
#InvoicesError
          PACK        #ErrorString from "Error ",#Operand," Invoices FileActual Error : ",S$ERROR$
          BEEP
          ALERT       STOP,#ErrorString,result,"I/O Error"
          STOP
 
 
#EndOfRoutine
          %ENDIF          //End of IO Include File

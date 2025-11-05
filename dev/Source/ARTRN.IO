;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    1 Meade Ave                                              ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 532-6266                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    ARTRN.FD                                                ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    05-02-2018 At 13:38                                            ;
;                                                                             ;
;  PURPOSE:                                                                   ;
;                                                                             ;
; REVISION:     Ver        Date     INIT       DETAILS                        ;
;                                                                             ;
;              00105   05-02-2018   HOR     INITIAL VERSION                  ;
;                                                                             ;
;=============================================================================;
;
          %IFNDEF $ARTRNVARIO
 
$ARTRNVARIO                      EQUATE         1
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
; Test Read for ARTRNKY Index
;
TSTARTRN                                    
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Testing ","ARTRN"
          READ       ARTRNFL,ARTRNKY;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for ARTRNKY Index
;
RDARTRN                                     
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Reading ","ARTRN"
          READ       ARTRNFL,ARTRNKY;ARTRN
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for ARTRNKY Index
;
RDARTRNLK                                   
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Reading ","ARTRN"
          READLK     ARTRNFL,ARTRNKY;ARTRN
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for ARTRNKY Index
;
KSARTRN                                     
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Reading KS ","ARTRN"
          READKS     ARTRNFL;ARTRN
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for ARTRNKY Index
;
KSARTRNLK                                   
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Reading KS Locked ","ARTRN"
          READKSLK   ARTRNFL;ARTRN
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for ARTRNKY Index
;
KPARTRN                                     
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Reaing KP ","ARTRN"
          READKP     ARTRNFL;ARTRN
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for ARTRNKY Index
;
KPARTRNLK                                   
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Reading Locked KP ","ARTRN"
          READKPLK   ARTRNFL;ARTRN
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Test Read for ARTRNKY2 Index
;
TSTARTRN2                                   
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Testing ","ARTRN"
          READ       ARTRNFL2,ARTRNKY2;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for ARTRNKY2 Index
;
RDARTRN2                                    
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Reading ","ARTRN"
          READ       ARTRNFL2,ARTRNKY2;ARTRN
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for ARTRNKY2 Index
;
RDARTRN2LK                                  
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Reading ","ARTRN"
          READLK     ARTRNFL2,ARTRNKY2;ARTRN
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for ARTRNKY2 Index
;
KSARTRN2                                    
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Reading KS ","ARTRN"
          READKS     ARTRNFL2;ARTRN
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for ARTRNKY2 Index
;
KSARTRN2LK                                  
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Reading KS Locked ","ARTRN"
          READKSLK   ARTRNFL2;ARTRN
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for ARTRNKY2 Index
;
KPARTRN2                                    
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Reaing KP ","ARTRN"
          READKP     ARTRNFL2;ARTRN
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for ARTRNKY2 Index
;
KPARTRN2LK                                  
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Reading Locked KP ","ARTRN"
          READKPLK   ARTRNFL2;ARTRN
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Test Read for ARTRNKY3 Index
;
TSTARTRN3                                   
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Testing ","ARTRN"
          READ       ARTRNFL3,ARTRNKY3;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for ARTRNKY3 Index
;
RDARTRN3                                    
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Reading ","ARTRN"
          READ       ARTRNFL3,ARTRNKY3;ARTRN
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for ARTRNKY3 Index
;
RDARTRN3LK                                  
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Reading ","ARTRN"
          READLK     ARTRNFL3,ARTRNKY3;ARTRN
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for ARTRNKY3 Index
;
KSARTRN3                                    
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Reading KS ","ARTRN"
          READKS     ARTRNFL3;ARTRN
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for ARTRNKY3 Index
;
KSARTRN3LK                                  
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Reading KS Locked ","ARTRN"
          READKSLK   ARTRNFL3;ARTRN
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for ARTRNKY3 Index
;
KPARTRN3                                    
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Reaing KP ","ARTRN"
          READKP     ARTRNFL3;ARTRN
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for ARTRNKY3 Index
;
KPARTRN3LK                                  
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Reading Locked KP ","ARTRN"
          READKPLK   ARTRNFL3;ARTRN
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Test Read for ARTRNKY4 Index
;
TSTARTRN4                                   
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Testing ","ARTRN"
          READ       ARTRNFL4,ARTRNKY4;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for ARTRNKY4 Index
;
RDARTRN4                                    
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Reading ","ARTRN"
          READ       ARTRNFL4,ARTRNKY4;ARTRN
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for ARTRNKY4 Index
;
RDARTRN4LK                                  
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Reading ","ARTRN"
          READLK     ARTRNFL4,ARTRNKY4;ARTRN
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for ARTRNKY4 Index
;
KSARTRN4                                    
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Reading KS ","ARTRN"
          READKS     ARTRNFL4;ARTRN
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for ARTRNKY4 Index
;
KSARTRN4LK                                  
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Reading KS Locked ","ARTRN"
          READKSLK   ARTRNFL4;ARTRN
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for ARTRNKY4 Index
;
KPARTRN4                                    
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Reaing KP ","ARTRN"
          READKP     ARTRNFL4;ARTRN
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for ARTRNKY4 Index
;
KPARTRN4LK                                  
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Reading Locked KP ","ARTRN"
          READKPLK   ARTRNFL4;ARTRN
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Test Read for ARTRNKY5 Index
;
TSTARTRN5                                   
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Testing ","ARTRN"
          READ       ARTRNFL5,ARTRNKY5;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for ARTRNKY5 Index
;
RDARTRN5                                    
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Reading ","ARTRN"
          READ       ARTRNFL5,ARTRNKY5;ARTRN
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for ARTRNKY5 Index
;
RDARTRN5LK                                  
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Reading ","ARTRN"
          READLK     ARTRNFL5,ARTRNKY5;ARTRN
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for ARTRNKY5 Index
;
KSARTRN5                                    
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Reading KS ","ARTRN"
          READKS     ARTRNFL5;ARTRN
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for ARTRNKY5 Index
;
KSARTRN5LK                                  
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Reading KS Locked ","ARTRN"
          READKSLK   ARTRNFL5;ARTRN
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for ARTRNKY5 Index
;
KPARTRN5                                    
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Reaing KP ","ARTRN"
          READKP     ARTRNFL5;ARTRN
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for ARTRNKY5 Index
;
KPARTRN5LK                                  
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Reading Locked KP ","ARTRN"
          READKPLK   ARTRNFL5;ARTRN
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Update of ARTRN Record
;
UpdARTRN                                    
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Updating ","ARTRN"
          UPDATE     ARTRNFLST;ARTRN
          GOTO       #VALID
;=========================================================================================;
;
; Deletion of ARTRN Record
;
DelARTRN                                    
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Deleting ","ARTRN"
          DELETE     ARTRNFLST
          GOTO       #VALID
;=========================================================================================;
;
; Write for ARTRN Record
;
WrtARTRN                                    
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Writing ","ARTRN"
          WRITE      ARTRNFLST;ARTRN
          GOTO       #VALID
;=========================================================================================;
;
;  Opening of ARTRN Files
;
OpenARTRN                                   
          GETFILE          ARTRNFL
          RETURN           IF ZERO             //Nothing to do, the file is already open
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Opening ARTRN"
          OPEN             ARTRNFLST,LockManual,Single,NoWait
          RETURN
;=========================================================================================;
;
;  Opening of ARTRN Files in Read-Only Mode
;
OpenARTRNRO                                 
          GETFILE          ARTRNFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Opening ARTRN"
          OPEN             ARTRNFLST,READ
          RETURN
;=========================================================================================;
;
;  Opening of ARTRN Files in Read-Only Mode
;
OpenARTRNEx                                 
          GETFILE          ARTRNFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          TRAP       #ARTRNError if IO
          TRAP       #ARTRNError if Range
          TRAP       #ARTRNError if Format
          TRAP       #ARTRNError if Parity
          pack       FileNameError from "Opening ARTRN"
          OPEN             ARTRNFLST,Exclusive
          RETURN
;=========================================================================================;
;
;  Preparing of ARTRN Files
;
PrepARTRN                                   
          pack       FileNameError from "Opening ARTRN"
           PREPARE       ARTRNFL,"ARTRNFL.txt","ARTRNFL.isi","-u,z,y,1-8,17-26,27-36","300",EXCLUSIVE
           PREPARE       ARTRNFL2,"ARTRNFL.txt","$Datadir\ARTRNFL2.isi","-n,u,z,y,1-8,181-187","300",EXCLUSIVE
           PREPARE       ARTRNFL3,"ARTRNFL.txt","ARTRNFL3.isi","-n,u,z,y,1-8,17-26,189-189,65-72,181-187","300",EXCLUSIVE
           PREPARE       ARTRNFL4,"ARTRNFL.txt","ARTRNFL4.isi","-n,u,z,y,1-8,189-189,17-26,65-72,181-187","300",EXCLUSIVE
           PREPARE       ARTRNFL5,"ARTRNFL.txt","ARTRNFL5.isi","-n,u,z,y,1-8,188-188,27-36,181-187","300",EXCLUSIVE
           RETURN
;=========================================================================================;
;
; Standard Return Values for I/O Include
;
#ERROR
          MOVE       "1" TO ReturnFl    
          TRAPCLR    IO
          TRAPCLR    Range
          TRAPCLR    Format
          TRAPCLR    Parity
          MOVE       "Preparing",#Operand
          RETURN
#LOCKED
          MOVE       "2" TO ReturnFl    
          TRAPCLR    IO
          TRAPCLR    Range
          TRAPCLR    Format
          TRAPCLR    Parity
          RETURN
#VALID
          MOVE       "0" TO ReturnFl    
          TRAPCLR    IO
          TRAPCLR    Range
          TRAPCLR    Format
          TRAPCLR    Parity
          RETURN
 
 
#ARTRNError
          PACK        #ErrorString from "Error ",#Operand," ARTRN FileActual Error : ",S$ERROR$
          BEEP
          ALERT       STOP,#ErrorString,result,"I/O Error"
          STOP
 
 
#EndOfRoutine
          %ENDIF          //End of IO Include File

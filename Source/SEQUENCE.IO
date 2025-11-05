;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    1 Meade Ave                                              ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 532-6266                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    Sequence.FD                                                ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    05-02-2018 At 13:51                                            ;
;                                                                             ;
;  PURPOSE:                                                                   ;
;                                                                             ;
; REVISION:     Ver        Date     INIT       DETAILS                        ;
;                                                                             ;
;              00104   05-02-2018   HOR     INITIAL VERSION                  ;
;                                                                             ;
;=============================================================================;
;
          %IFNDEF $SequenceVARIO
 
$SequenceVARIO                   EQUATE         1
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
; Test Read for SequenceKY Index
;
TSTSequence                                 
          pack       FileNameError from "Testing ","Sequence"
          READ       SequenceFL,SequenceKY;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for SequenceKY Index
;
RDSequence                                  
          pack       FileNameError from "Reading ","Sequence"
          READ       SequenceFL,SequenceKY;Sequence
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for SequenceKY Index
;
RDSequenceLK                                
          pack       FileNameError from "Reading ","Sequence"
          READLK     SequenceFL,SequenceKY;Sequence
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for SequenceKY Index
;
KSSequence                                  
          pack       FileNameError from "Reading KS ","Sequence"
          READKS     SequenceFL;Sequence
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for SequenceKY Index
;
KSSequenceLK                                
          pack       FileNameError from "Reading KS Locked ","Sequence"
          READKSLK   SequenceFL;Sequence
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for SequenceKY Index
;
KPSequence                                  
          pack       FileNameError from "Reaing KP ","Sequence"
          READKP     SequenceFL;Sequence
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for SequenceKY Index
;
KPSequenceLK                                
          pack       FileNameError from "Reading Locked KP ","Sequence"
          READKPLK   SequenceFL;Sequence
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Update of Sequence Record
;
UpdSequence                                 
          pack       FileNameError from "Updating ","Sequence"
          UPDATE     SequenceFLST;Sequence
          GOTO       #VALID
;=========================================================================================;
;
; Deletion of Sequence Record
;
DelSequence                                 
          pack       FileNameError from "Deleting ","Sequence"
          DELETE     SequenceFLST
          GOTO       #VALID
;=========================================================================================;
;
; Write for Sequence Record
;
WrtSequence                                 
          pack       FileNameError from "Writing ","Sequence"
          WRITE      SequenceFLST;Sequence
          GOTO       #VALID
;=========================================================================================;
;
;  Opening of Sequence Files
;
OpenSequence                                
          GETFILE          SequenceFL
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening Sequence"
          OPEN             SequenceFLST,LockManual,Single,NoWait
          RETURN
;=========================================================================================;
;
;  Opening of Sequence Files in Read-Only Mode
;
OpenSequenceRO                              
          GETFILE          SequenceFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening Sequence"
          OPEN             SequenceFLST,READ
          RETURN
;=========================================================================================;
;
;  Opening of Sequence Files in Read-Only Mode
;
OpenSequenceEx                              
          GETFILE          SequenceFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening Sequence"
          OPEN             SequenceFLST,Exclusive
          RETURN
;=========================================================================================;
;
;  Preparing of Sequence Files
;
PrepSequence                                
          pack       FileNameError from "Opening Sequence"
           PREPARE       SequenceFL,"$DataDir\Sequence.TXT.txt","$DataDir\Sequence.isi","-n,z,y,1-6","15",EXCLUSIVE
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
 
 
#SequenceError
          PACK        #ErrorString from "Error ",#Operand," Sequence FileActual Error : ",S$ERROR$
          BEEP
          ALERT       STOP,#ErrorString,result,"I/O Error"
          STOP
 
 
#EndOfRoutine
          %ENDIF          //End of IO Include File

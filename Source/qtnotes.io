;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    1 Meade Ave                                              ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 532-6266                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    QTNotes.FD                                                ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    06-20-2019 At 08:40                                            ;
;                                                                             ;
;  PURPOSE:                                                                   ;
;                                                                             ;
; REVISION:     Ver        Date     INIT       DETAILS                        ;
;                                                                             ;
;              00105   06-20-2019   HOR     INITIAL VERSION                  ;
;                                                                             ;
;=============================================================================;
;
          %IFNDEF $QTNotesVARIO
 
$QTNotesVARIO                    EQUATE         1
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
; Test Read for QTNotesKY Index
;
TSTQTNotes                                  
          pack       FileNameError from "Testing ","QTNotes"
          READ       QTNotesFL,QTNotesKY;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for QTNotesKY Index
;
RDQTNotes                                   
          pack       FileNameError from "Reading ","QTNotes"
          READ       QTNotesFL,QTNotesKY;QTNotes
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for QTNotesKY Index
;
RDQTNotesLK                                 
          pack       FileNameError from "Reading ","QTNotes"
          READLK     QTNotesFL,QTNotesKY;QTNotes
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for QTNotesKY Index
;
KSQTNotes                                   
          pack       FileNameError from "Reading KS ","QTNotes"
          READKS     QTNotesFL;QTNotes
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for QTNotesKY Index
;
KSQTNotesLK                                 
          pack       FileNameError from "Reading KS Locked ","QTNotes"
          READKSLK   QTNotesFL;QTNotes
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for QTNotesKY Index
;
KPQTNotes                                   
          pack       FileNameError from "Reaing KP ","QTNotes"
          READKP     QTNotesFL;QTNotes
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for QTNotesKY Index
;
KPQTNotesLK                                 
          pack       FileNameError from "Reading Locked KP ","QTNotes"
          READKPLK   QTNotesFL;QTNotes
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Update of QTNotes Record
;
UpdQTNotes                                  
          pack       FileNameError from "Updating ","QTNotes"
          UPDATE     QTNotesFLST;QTNotes
          GOTO       #VALID
;=========================================================================================;
;
; Deletion of QTNotes Record
;
DelQTNotes                                  
          pack       FileNameError from "Deleting ","QTNotes"
          DELETE     QTNotesFLST
          GOTO       #VALID
;=========================================================================================;
;
; Write for QTNotes Record
;
WrtQTNotes                                  
          pack       FileNameError from "Writing ","QTNotes"
          WRITE      QTNotesFLST;QTNotes
          GOTO       #VALID
;=========================================================================================;
;
;  Opening of QTNotes Files
;
OpenQTNotes                                 
          GETFILE          QTNotesFL
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening QTNotes"
          OPEN             QTNotesFLST,LockManual,Multiple,Wait=  2
          RETURN
;=========================================================================================;
;
;  Opening of QTNotes Files in Read-Only Mode
;
OpenQTNotesRO                               
          GETFILE          QTNotesFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening QTNotes"
          OPEN             QTNotesFLST,READ
          RETURN
;=========================================================================================;
;
;  Opening of QTNotes Files in Read-Only Mode
;
OpenQTNotesEx                               
          GETFILE          QTNotesFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening QTNotes"
          OPEN             QTNotesFLST,Exclusive
          RETURN
;=========================================================================================;
;
;  Preparing of QTNotes Files
;
PrepQTNotes                                 
          pack       FileNameError from "Opening QTNotes"
           PREPARE       QTNotesFL,"QTNotes.txt","QTNotes.isi","-n,z,y,1-8,9-17,18-21","1021",EXCLUSIVE
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
 
 
#QTNotesError
          PACK        #ErrorString from "Error ",#Operand," QTNotes FileActual Error : ",S$ERROR$
          BEEP
          ALERT       STOP,#ErrorString,result,"I/O Error"
          STOP
 
 
#EndOfRoutine
          %ENDIF          //End of IO Include File

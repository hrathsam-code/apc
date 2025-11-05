;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    1 Meade Ave                                              ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 532-6266                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    PONotes.FD                                                ;
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
          %IFNDEF $PONotesVARIO
 
$PONotesVARIO                    EQUATE         1
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
; Test Read for PONotesKY Index
;
TSTPONotes                                  
          pack       FileNameError from "Testing ","PONotes"
          READ       PONotesFL,PONotesKY;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Read for PONotesKY Index
;
RDPONotes                                   
          pack       FileNameError from "Reading ","PONotes"
          READ       PONotesFL,PONotesKY;PONotes
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Random Locked Read for PONotesKY Index
;
RDPONotesLK                                 
          pack       FileNameError from "Reading ","PONotes"
          READLK     PONotesFL,PONotesKY;PONotes
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Sequential Read for PONotesKY Index
;
KSPONotes                                   
          pack       FileNameError from "Reading KS ","PONotes"
          READKS     PONotesFL;PONotes
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Sequential Read for PONotesKY Index
;
KSPONotesLK                                 
          pack       FileNameError from "Reading KS Locked ","PONotes"
          READKSLK   PONotesFL;PONotes
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Previous Read for PONotesKY Index
;
KPPONotes                                   
          pack       FileNameError from "Reaing KP ","PONotes"
          READKP     PONotesFL;PONotes
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Key Locked Previous Read for PONotesKY Index
;
KPPONotesLK                                 
          pack       FileNameError from "Reading Locked KP ","PONotes"
          READKPLK   PONotesFL;PONotes
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
;=========================================================================================;
;
; Update of PONotes Record
;
UpdPONotes                                  
          pack       FileNameError from "Updating ","PONotes"
          UPDATE     PONotesFLST;PONotes
          GOTO       #VALID
;=========================================================================================;
;
; Deletion of PONotes Record
;
DelPONotes                                  
          pack       FileNameError from "Deleting ","PONotes"
          DELETE     PONotesFLST
          GOTO       #VALID
;=========================================================================================;
;
; Write for PONotes Record
;
WrtPONotes                                  
          pack       FileNameError from "Writing ","PONotes"
          WRITE      PONotesFLST;PONotes
          GOTO       #VALID
;=========================================================================================;
;
;  Opening of PONotes Files
;
OpenPONotes                                 
          GETFILE          PONotesFL
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening PONotes"
          OPEN             PONotesFLST,LockManual,Multiple,Wait=  2
          RETURN
;=========================================================================================;
;
;  Opening of PONotes Files in Read-Only Mode
;
OpenPONotesRO                               
          GETFILE          PONotesFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening PONotes"
          OPEN             PONotesFLST,READ
          RETURN
;=========================================================================================;
;
;  Opening of PONotes Files in Read-Only Mode
;
OpenPONotesEx                               
          GETFILE          PONotesFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          pack       FileNameError from "Opening PONotes"
          OPEN             PONotesFLST,Exclusive
          RETURN
;=========================================================================================;
;
;  Preparing of PONotes Files
;
PrepPONotes                                 
          pack       FileNameError from "Opening PONotes"
           PREPARE       PONotesFL,"PONotes.txt","PONotes.isi","-n,z,y,1-8,9-17,18-21","1021",EXCLUSIVE
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
 
 
#PONotesError
          PACK        #ErrorString from "Error ",#Operand," PONotes FileActual Error : ",S$ERROR$
          BEEP
          ALERT       STOP,#ErrorString,result,"I/O Error"
          STOP
 
 
#EndOfRoutine
          %ENDIF          //End of IO Include File

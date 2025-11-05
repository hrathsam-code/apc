          %IFNDEF $CustDVARIO
 
$CustDVARIO                      EQUATE         1
.
#result   FORM       1
#Operand  DIM        40
#ErrorString  DIM        120
.
.
.
          GOTO       #EndOfRoutine
.
.
.
. Test Read for CustDKY Index
.
TSTCustD                                    
          MOVE       "Testing",#Operand
          READ       CustDFL,CustDKY;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Read for CustDKY Index
.
RDCustD                                     
          MOVE       "Reading",#Operand
          READ       CustDFL,CustDKY;CustD
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Locked Read for CustDKY Index
.
RDCustDLK                                   
          MOVE       "Reading",#Operand
          READLK     CustDFL,CustDKY;CustD
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Sequential Read for CustDKY Index
.
KSCustD                                     
          MOVE       "Reading Key Sequentially",#Operand
          READKS     CustDFL;CustD
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Sequential Read for CustDKY Index
.
KSCustDLK                                   
          MOVE       "Reading Key Sequentially",#Operand
          READKSLK   CustDFL;CustD
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Previous Read for CustDKY Index
.
KPCustD                                     
          MOVE       "Reading Key Previously",#Operand
          READKP     CustDFL;CustD
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Previous Read for CustDKY Index
.
KPCustDLK                                   
          MOVE       "Reading Key Previously",#Operand
          READKPLK   CustDFL;CustD
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Update of CustD Record
.
UpdCustD                                    
          MOVE       "Updating",#Operand
          UPDATE     CustDFLST;CustD
          GOTO       #VALID
.
. Deletion of CustD Record
.
DelCustD                                    
          MOVE       "Deleting",#Operand
          DELETE     CustDFLST
          GOTO       #VALID
.
. Write for CustD Record
.
WrtCustD                                    
          MOVE       "Writing",#Operand
          WRITE      CustDFLST;CustD
          GOTO       #VALID
.
.  Opening of CustD Files
.
OpenCustD                                   
          GETFILE          CustDFL
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             CustDFLST,LockManual,Multiple,Wait=  2
          RETURN
.
.  Opening of CustD Files in Read-Only Mode
.
OpenCustDRO                                 
          GETFILE          CustDFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             CustDFLST,READ
          RETURN
.
.  Opening of CustD Files in Read-Only Mode
.
OpenCustDEx                                 
          GETFILE          CustDFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             CustDFLST,Exclusive
          RETURN
.
.  Preparing of CustD Files
.
PrepCustD                                   
           PREPARE       CustDFL,"CustDFL.txt","CustDFL.isi","-n,z,y,1-8,9-18","360",EXCLUSIVE
           RETURN
.
. Standard Return Values for I/O Include
.
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
 
 
#CustDError
          PACK        #ErrorString from "Error ",#Operand," CustD FileActual Error : ",S$ERROR$
          BEEP
          ALERT       STOP,#ErrorString,result,"I/O Error"
          STOP
 
 
#EndOfRoutine
          %ENDIF          //End of IO Include File

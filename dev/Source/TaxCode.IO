          %IFNDEF $TaxCodeVARIO
 
$TaxCodeVARIO                    EQUATE         1
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
. Test Read for TaxCodeKY Index
.
TSTTaxCode                                  
          MOVE       "Testing",#Operand
          READ       TaxCodeFL,TaxCodeKY;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Read for TaxCodeKY Index
.
RDTaxCode                                   
          MOVE       "Reading",#Operand
          READ       TaxCodeFL,TaxCodeKY;TaxCode
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Locked Read for TaxCodeKY Index
.
RDTaxCodeLK                                 
          MOVE       "Reading",#Operand
          READLK     TaxCodeFL,TaxCodeKY;TaxCode
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Sequential Read for TaxCodeKY Index
.
KSTaxCode                                   
          MOVE       "Reading Key Sequentially",#Operand
          READKS     TaxCodeFL;TaxCode
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Sequential Read for TaxCodeKY Index
.
KSTaxCodeLK                                 
          MOVE       "Reading Key Sequentially",#Operand
          READKSLK   TaxCodeFL;TaxCode
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Previous Read for TaxCodeKY Index
.
KPTaxCode                                   
          MOVE       "Reading Key Previously",#Operand
          READKP     TaxCodeFL;TaxCode
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Previous Read for TaxCodeKY Index
.
KPTaxCodeLK                                 
          MOVE       "Reading Key Previously",#Operand
          READKPLK   TaxCodeFL;TaxCode
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Test Read for TaxCodeKY2 Index
.
TSTTaxCode2                                 
          MOVE       "Testing",#Operand
          READ       TaxCodeFL2,TaxCodeKY2;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Read for TaxCodeKY2 Index
.
RDTaxCode2                                  
          MOVE       "Reading",#Operand
          READ       TaxCodeFL2,TaxCodeKY2;TaxCode
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Locked Read for TaxCodeKY2 Index
.
RDTaxCode2LK                                
          MOVE       "Reading",#Operand
          READLK     TaxCodeFL2,TaxCodeKY2;TaxCode
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Sequential Read for TaxCodeKY2 Index
.
KSTaxCode2                                  
          MOVE       "Reading Key Sequentially",#Operand
          READKS     TaxCodeFL2;TaxCode
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Sequential Read for TaxCodeKY2 Index
.
KSTaxCode2LK                                
          MOVE       "Reading Key Sequentially",#Operand
          READKSLK   TaxCodeFL2;TaxCode
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Previous Read for TaxCodeKY2 Index
.
KPTaxCode2                                  
          MOVE       "Reading Key Previously",#Operand
          READKP     TaxCodeFL2;TaxCode
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Previous Read for TaxCodeKY2 Index
.
KPTaxCode2LK                                
          MOVE       "Reading Key Previously",#Operand
          READKPLK   TaxCodeFL2;TaxCode
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Test Read for TaxCodeKY3 Index
.
TSTTaxCode3                                 
          MOVE       "Testing",#Operand
          READ       TaxCodeFL3,TaxCodeKY3;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Read for TaxCodeKY3 Index
.
RDTaxCode3                                  
          MOVE       "Reading",#Operand
          READ       TaxCodeFL3,TaxCodeKY3;TaxCode
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Locked Read for TaxCodeKY3 Index
.
RDTaxCode3LK                                
          MOVE       "Reading",#Operand
          READLK     TaxCodeFL3,TaxCodeKY3;TaxCode
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Sequential Read for TaxCodeKY3 Index
.
KSTaxCode3                                  
          MOVE       "Reading Key Sequentially",#Operand
          READKS     TaxCodeFL3;TaxCode
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Sequential Read for TaxCodeKY3 Index
.
KSTaxCode3LK                                
          MOVE       "Reading Key Sequentially",#Operand
          READKSLK   TaxCodeFL3;TaxCode
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Previous Read for TaxCodeKY3 Index
.
KPTaxCode3                                  
          MOVE       "Reading Key Previously",#Operand
          READKP     TaxCodeFL3;TaxCode
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Previous Read for TaxCodeKY3 Index
.
KPTaxCode3LK                                
          MOVE       "Reading Key Previously",#Operand
          READKPLK   TaxCodeFL3;TaxCode
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Update of TaxCode Record
.
UpdTaxCode                                  
          MOVE       "Updating",#Operand
          UPDATE     TaxCodeFLST;TaxCode
          GOTO       #VALID
.
. Deletion of TaxCode Record
.
DelTaxCode                                  
          MOVE       "Deleting",#Operand
          DELETE     TaxCodeFLST
          GOTO       #VALID
.
. Write for TaxCode Record
.
WrtTaxCode                                  
          MOVE       "Writing",#Operand
          WRITE      TaxCodeFLST;TaxCode
          GOTO       #VALID
.
.  Opening of TaxCode Files
.
OpenTaxCode                                 
          GETFILE          TaxCodeFL
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             TaxCodeFLST,LockManual,Single,NoWait
          RETURN
.
.  Opening of TaxCode Files in Read-Only Mode
.
OpenTaxCodeRO                               
          GETFILE          TaxCodeFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             TaxCodeFLST,READ
          RETURN
.
.  Opening of TaxCode Files in Read-Only Mode
.
OpenTaxCodeEx                               
          GETFILE          TaxCodeFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             TaxCodeFLST,Exclusive
          RETURN
.
.  Preparing of TaxCode Files
.
PrepTaxCode                                 
           PREPARE       TaxCodeFL,"TaxCode.txt","TaxCode.isi","-n,1-8","85",EXCLUSIVE
           PREPARE       TaxCodeFL2,"TaxCode.txt","TaxCode2.isi","-n,9-38,1-8","85",EXCLUSIVE
           PREPARE       TaxCodeFL3,"TaxCode.txt","TaxCode3.isi","-n,39-47","85",EXCLUSIVE
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
 
 
#TaxCodeError
          PACK        #ErrorString from "Error ",#Operand," TaxCode FileActual Error : ",S$ERROR$
          BEEP
          ALERT       STOP,#ErrorString,result,"I/O Error"
          STOP
 
 
#EndOfRoutine
          %ENDIF          //End of IO Include File

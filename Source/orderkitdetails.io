          %IFNDEF $OrderKitDetailsVARIO
 
$OrderKitDetailsVARIO            EQUATE         1
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
. Test Read for OrderKitDetailsKY Index
.
TSTOrderKitDetails                          
          TRAP       #OrderKitDetailsError if IO
          TRAP       #OrderKitDetailsError if Range
          TRAP       #OrderKitDetailsError if Format
          TRAP       #OrderKitDetailsError if Parity
          MOVE       "Testing",#Operand
          READ       OrderKitDetailsFL,OrderKitDetailsKY;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Read for OrderKitDetailsKY Index
.
RDOrderKitDetails                           
          TRAP       #OrderKitDetailsError if IO
          TRAP       #OrderKitDetailsError if Range
          TRAP       #OrderKitDetailsError if Format
          TRAP       #OrderKitDetailsError if Parity
          MOVE       "Reading",#Operand
          READ       OrderKitDetailsFL,OrderKitDetailsKY;OrderKitDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Locked Read for OrderKitDetailsKY Index
.
RDOrderKitDetailsLK                         
          TRAP       #OrderKitDetailsError if IO
          TRAP       #OrderKitDetailsError if Range
          TRAP       #OrderKitDetailsError if Format
          TRAP       #OrderKitDetailsError if Parity
          MOVE       "Reading",#Operand
          READLK     OrderKitDetailsFL,OrderKitDetailsKY;OrderKitDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Sequential Read for OrderKitDetailsKY Index
.
KSOrderKitDetails                           
          TRAP       #OrderKitDetailsError if IO
          TRAP       #OrderKitDetailsError if Range
          TRAP       #OrderKitDetailsError if Format
          TRAP       #OrderKitDetailsError if Parity
          MOVE       "Reading Key Sequentially",#Operand
          READKS     OrderKitDetailsFL;OrderKitDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Sequential Read for OrderKitDetailsKY Index
.
KSOrderKitDetailsLK                         
          TRAP       #OrderKitDetailsError if IO
          TRAP       #OrderKitDetailsError if Range
          TRAP       #OrderKitDetailsError if Format
          TRAP       #OrderKitDetailsError if Parity
          MOVE       "Reading Key Sequentially",#Operand
          READKSLK   OrderKitDetailsFL;OrderKitDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Previous Read for OrderKitDetailsKY Index
.
KPOrderKitDetails                           
          TRAP       #OrderKitDetailsError if IO
          TRAP       #OrderKitDetailsError if Range
          TRAP       #OrderKitDetailsError if Format
          TRAP       #OrderKitDetailsError if Parity
          MOVE       "Reading Key Previously",#Operand
          READKP     OrderKitDetailsFL;OrderKitDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Previous Read for OrderKitDetailsKY Index
.
KPOrderKitDetailsLK                         
          TRAP       #OrderKitDetailsError if IO
          TRAP       #OrderKitDetailsError if Range
          TRAP       #OrderKitDetailsError if Format
          TRAP       #OrderKitDetailsError if Parity
          MOVE       "Reading Key Previously",#Operand
          READKPLK   OrderKitDetailsFL;OrderKitDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Update of OrderKitDetails Record
.
UpdOrderKitDetails                          
          TRAP       #OrderKitDetailsError if IO
          TRAP       #OrderKitDetailsError if Range
          TRAP       #OrderKitDetailsError if Format
          TRAP       #OrderKitDetailsError if Parity
          MOVE       "Updating",#Operand
          UPDATE     OrderKitDetailsFLST;OrderKitDetails
          GOTO       #VALID
.
. Deletion of OrderKitDetails Record
.
DelOrderKitDetails                          
          TRAP       #OrderKitDetailsError if IO
          TRAP       #OrderKitDetailsError if Range
          TRAP       #OrderKitDetailsError if Format
          TRAP       #OrderKitDetailsError if Parity
          MOVE       "Deleting",#Operand
          DELETE     OrderKitDetailsFLST
          GOTO       #VALID
.
. Write for OrderKitDetails Record
.
WrtOrderKitDetails                          
          TRAP       #OrderKitDetailsError if IO
          TRAP       #OrderKitDetailsError if Range
          TRAP       #OrderKitDetailsError if Format
          TRAP       #OrderKitDetailsError if Parity
          MOVE       "Writing",#Operand
          WRITE      OrderKitDetailsFLST;OrderKitDetails
          GOTO       #VALID
.
.  Opening of OrderKitDetails Files
.
OpenOrderKitDetails                         
          GETFILE          OrderKitDetailsFL
          RETURN           IF ZERO             //Nothing to do, the file is already open
          TRAP       #OrderKitDetailsError if IO
          TRAP       #OrderKitDetailsError if Range
          TRAP       #OrderKitDetailsError if Format
          TRAP       #OrderKitDetailsError if Parity
          MOVE       "Opening",#Operand
          OPEN             OrderKitDetailsFLST,LockManual,Multiple,NoWait
          RETURN
.
.  Opening of OrderKitDetails Files in Read-Only Mode
.
OpenOrderKitDetailsRO                       
          GETFILE          OrderKitDetailsFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          TRAP       #OrderKitDetailsError if IO
          TRAP       #OrderKitDetailsError if Range
          TRAP       #OrderKitDetailsError if Format
          TRAP       #OrderKitDetailsError if Parity
          MOVE       "Opening",#Operand
          OPEN             OrderKitDetailsFLST,READ
          RETURN
.
.  Opening of OrderKitDetails Files in Read-Only Mode
.
OpenOrderKitDetailsEx                       
          GETFILE          OrderKitDetailsFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          TRAP       #OrderKitDetailsError if IO
          TRAP       #OrderKitDetailsError if Range
          TRAP       #OrderKitDetailsError if Format
          TRAP       #OrderKitDetailsError if Parity
          MOVE       "Opening",#Operand
          OPEN             OrderKitDetailsFLST,Exclusive
          RETURN
.
.  Preparing of OrderKitDetails Files
.
PrepOrderKitDetails                         
           PREPARE       OrderKitDetailsFL,"OrderKitDetails.txt","OrderKitDetails.isi","-n,z,y,1-3,4-6","122",EXCLUSIVE
           RETURN
.
. Standard Return Values for I/O Include
.
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
 
 
#OrderKitDetailsError
          PACK        #ErrorString from "Error ",#Operand," OrderKitDetails FileActual Error : ",S$ERROR$
          BEEP
          ALERT       STOP,#ErrorString,result,"I/O Error"
          STOP
 
 
#EndOfRoutine
          %ENDIF          //End of IO Include File

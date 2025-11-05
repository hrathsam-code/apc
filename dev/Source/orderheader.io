          %IFNDEF $OrderHeaderVARIO
 
$OrderHeaderVARIO                EQUATE         1
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
. Test Read for OrderHeaderKY Index
.
TSTOrderHeader                              
          MOVE       "Testing",#Operand
          READ       OrderHeaderFL,OrderHeaderKY;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Read for OrderHeaderKY Index
.
RDOrderHeader                               
          MOVE       "Reading",#Operand
          READ       OrderHeaderFL,OrderHeaderKY;OrderHeader
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Locked Read for OrderHeaderKY Index
.
RDOrderHeaderLK                             
          MOVE       "Reading",#Operand
          READLK     OrderHeaderFL,OrderHeaderKY;OrderHeader
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Sequential Read for OrderHeaderKY Index
.
KSOrderHeader                               
          MOVE       "Reading Key Sequentially",#Operand
          READKS     OrderHeaderFL;OrderHeader
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Sequential Read for OrderHeaderKY Index
.
KSOrderHeaderLK                             
          MOVE       "Reading Key Sequentially",#Operand
          READKSLK   OrderHeaderFL;OrderHeader
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Previous Read for OrderHeaderKY Index
.
KPOrderHeader                               
          MOVE       "Reading Key Previously",#Operand
          READKP     OrderHeaderFL;OrderHeader
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Previous Read for OrderHeaderKY Index
.
KPOrderHeaderLK                             
          MOVE       "Reading Key Previously",#Operand
          READKPLK   OrderHeaderFL;OrderHeader
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Test Read for OrderHeaderKY2 Index
.
TSTOrderHeader2                             
          MOVE       "Testing",#Operand
          READ       OrderHeaderFL2,OrderHeaderKY2;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Read for OrderHeaderKY2 Index
.
RDOrderHeader2                              
          MOVE       "Reading",#Operand
          READ       OrderHeaderFL2,OrderHeaderKY2;OrderHeader
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Locked Read for OrderHeaderKY2 Index
.
RDOrderHeader2LK                            
          MOVE       "Reading",#Operand
          READLK     OrderHeaderFL2,OrderHeaderKY2;OrderHeader
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Sequential Read for OrderHeaderKY2 Index
.
KSOrderHeader2                              
          MOVE       "Reading Key Sequentially",#Operand
          READKS     OrderHeaderFL2;OrderHeader
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Sequential Read for OrderHeaderKY2 Index
.
KSOrderHeader2LK                            
          MOVE       "Reading Key Sequentially",#Operand
          READKSLK   OrderHeaderFL2;OrderHeader
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Previous Read for OrderHeaderKY2 Index
.
KPOrderHeader2                              
          MOVE       "Reading Key Previously",#Operand
          READKP     OrderHeaderFL2;OrderHeader
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Previous Read for OrderHeaderKY2 Index
.
KPOrderHeader2LK                            
          MOVE       "Reading Key Previously",#Operand
          READKPLK   OrderHeaderFL2;OrderHeader
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Update of OrderHeader Record
.
UpdOrderHeader                              
          MOVE       "Updating",#Operand
          UPDATE     OrderHeaderFLST;OrderHeader
          GOTO       #VALID
.
. Deletion of OrderHeader Record
.
DelOrderHeader                              
          MOVE       "Deleting",#Operand
          DELETE     OrderHeaderFLST
          GOTO       #VALID
.
. Write for OrderHeader Record
.
WrtOrderHeader                              
          MOVE       "Writing",#Operand
          WRITE      OrderHeaderFLST;OrderHeader
          GOTO       #VALID
.
.  Opening of OrderHeader Files
.
OpenOrderHeader                             
          GETFILE          OrderHeaderFL
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             OrderHeaderFLST,LockManual,Single,NoWait
          RETURN
.
.  Opening of OrderHeader Files in Read-Only Mode
.
OpenOrderHeaderRO                           
          GETFILE          OrderHeaderFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             OrderHeaderFLST,READ
          RETURN
.
.  Opening of OrderHeader Files in Read-Only Mode
.
OpenOrderHeaderEx                           
          GETFILE          OrderHeaderFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             OrderHeaderFLST,Exclusive
          RETURN
.
.  Preparing of OrderHeader Files
.
PrepOrderHeader                             
           PREPARE       OrderHeaderFL,"OrderHeader.txt","OrderHeader.isi","-n,z,y,429-436,20-28","600",EXCLUSIVE
           PREPARE       OrderHeaderFL2,"OrderHeader.txt","OrderHeader2.isi","-n,z,y,429-436,1-10,20-28","600",EXCLUSIVE
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
 
 
#OrderHeaderError
          PACK        #ErrorString from "Error ",#Operand," OrderHeader FileActual Error : ",S$ERROR$
          BEEP
          ALERT       STOP,#ErrorString,result,"I/O Error"
          STOP
 
 
#EndOfRoutine
          %ENDIF          //End of IO Include File

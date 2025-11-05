          %IFNDEF $OrderDetailsVARIO
 
$OrderDetailsVARIO               EQUATE         1
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
. Test Read for OrderDetailsKY Index
.
TSTOrderDetails                             
          MOVE       "Testing",#Operand
          READ       OrderDetailsFL,OrderDetailsKY;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Read for OrderDetailsKY Index
.
RDOrderDetails                              
          MOVE       "Reading",#Operand
          READ       OrderDetailsFL,OrderDetailsKY;OrderDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Locked Read for OrderDetailsKY Index
.
RDOrderDetailsLK                            
          MOVE       "Reading",#Operand
          READLK     OrderDetailsFL,OrderDetailsKY;OrderDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Sequential Read for OrderDetailsKY Index
.
KSOrderDetails                              
          MOVE       "Reading Key Sequentially",#Operand
          READKS     OrderDetailsFL;OrderDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Sequential Read for OrderDetailsKY Index
.
KSOrderDetailsLK                            
          MOVE       "Reading Key Sequentially",#Operand
          READKSLK   OrderDetailsFL;OrderDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Previous Read for OrderDetailsKY Index
.
KPOrderDetails                              
          MOVE       "Reading Key Previously",#Operand
          READKP     OrderDetailsFL;OrderDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Previous Read for OrderDetailsKY Index
.
KPOrderDetailsLK                            
          MOVE       "Reading Key Previously",#Operand
          READKPLK   OrderDetailsFL;OrderDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Test Read for OrderDetailsKY2 Index
.
TSTOrderDetails2                            
          MOVE       "Testing",#Operand
          READ       OrderDetailsFL2,OrderDetailsKY2;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Read for OrderDetailsKY2 Index
.
RDOrderDetails2                             
          MOVE       "Reading",#Operand
          READ       OrderDetailsFL2,OrderDetailsKY2;OrderDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Locked Read for OrderDetailsKY2 Index
.
RDOrderDetails2LK                           
          MOVE       "Reading",#Operand
          READLK     OrderDetailsFL2,OrderDetailsKY2;OrderDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Sequential Read for OrderDetailsKY2 Index
.
KSOrderDetails2                             
          MOVE       "Reading Key Sequentially",#Operand
          READKS     OrderDetailsFL2;OrderDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Sequential Read for OrderDetailsKY2 Index
.
KSOrderDetails2LK                           
          MOVE       "Reading Key Sequentially",#Operand
          READKSLK   OrderDetailsFL2;OrderDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Previous Read for OrderDetailsKY2 Index
.
KPOrderDetails2                             
          MOVE       "Reading Key Previously",#Operand
          READKP     OrderDetailsFL2;OrderDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Previous Read for OrderDetailsKY2 Index
.
KPOrderDetails2LK                           
          MOVE       "Reading Key Previously",#Operand
          READKPLK   OrderDetailsFL2;OrderDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Test Read for OrderDetailsKY3 Index
.
TSTOrderDetails3                            
          MOVE       "Testing",#Operand
          READ       OrderDetailsFL3,OrderDetailsKY3;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Read for OrderDetailsKY3 Index
.
RDOrderDetails3                             
          MOVE       "Reading",#Operand
          READ       OrderDetailsFL3,OrderDetailsKY3;OrderDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Locked Read for OrderDetailsKY3 Index
.
RDOrderDetails3LK                           
          MOVE       "Reading",#Operand
          READLK     OrderDetailsFL3,OrderDetailsKY3;OrderDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Sequential Read for OrderDetailsKY3 Index
.
KSOrderDetails3                             
          MOVE       "Reading Key Sequentially",#Operand
          READKS     OrderDetailsFL3;OrderDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Sequential Read for OrderDetailsKY3 Index
.
KSOrderDetails3LK                           
          MOVE       "Reading Key Sequentially",#Operand
          READKSLK   OrderDetailsFL3;OrderDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Previous Read for OrderDetailsKY3 Index
.
KPOrderDetails3                             
          MOVE       "Reading Key Previously",#Operand
          READKP     OrderDetailsFL3;OrderDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Previous Read for OrderDetailsKY3 Index
.
KPOrderDetails3LK                           
          MOVE       "Reading Key Previously",#Operand
          READKPLK   OrderDetailsFL3;OrderDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Test Read for OrderDetailsKY4 Index
.
TSTOrderDetails4                            
          MOVE       "Testing",#Operand
          READ       OrderDetailsFL4,OrderDetailsKY4;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Read for OrderDetailsKY4 Index
.
RDOrderDetails4                             
          MOVE       "Reading",#Operand
          READ       OrderDetailsFL4,OrderDetailsKY4;OrderDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Locked Read for OrderDetailsKY4 Index
.
RDOrderDetails4LK                           
          MOVE       "Reading",#Operand
          READLK     OrderDetailsFL4,OrderDetailsKY4;OrderDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Sequential Read for OrderDetailsKY4 Index
.
KSOrderDetails4                             
          MOVE       "Reading Key Sequentially",#Operand
          READKS     OrderDetailsFL4;OrderDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Sequential Read for OrderDetailsKY4 Index
.
KSOrderDetails4LK                           
          MOVE       "Reading Key Sequentially",#Operand
          READKSLK   OrderDetailsFL4;OrderDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Previous Read for OrderDetailsKY4 Index
.
KPOrderDetails4                             
          MOVE       "Reading Key Previously",#Operand
          READKP     OrderDetailsFL4;OrderDetails
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Previous Read for OrderDetailsKY4 Index
.
KPOrderDetails4LK                           
          MOVE       "Reading Key Previously",#Operand
          READKPLK   OrderDetailsFL4;OrderDetails
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Update of OrderDetails Record
.
UpdOrderDetails                             
          MOVE       "Updating",#Operand
          UPDATE     OrderDetailsFLST;OrderDetails
          GOTO       #VALID
.
. Deletion of OrderDetails Record
.
DelOrderDetails                             
          MOVE       "Deleting",#Operand
          DELETE     OrderDetailsFLST
          GOTO       #VALID
.
. Write for OrderDetails Record
.
WrtOrderDetails                             
          MOVE       "Writing",#Operand
          WRITE      OrderDetailsFLST;OrderDetails
          GOTO       #VALID
.
.  Opening of OrderDetails Files
.
OpenOrderDetails                            
          GETFILE          OrderDetailsFL
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             OrderDetailsFLST,LockManual,Single,NoWait
          RETURN
.
.  Opening of OrderDetails Files in Read-Only Mode
.
OpenOrderDetailsRO                          
          GETFILE          OrderDetailsFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             OrderDetailsFLST,READ
          RETURN
.
.  Opening of OrderDetails Files in Read-Only Mode
.
OpenOrderDetailsEx                          
          GETFILE          OrderDetailsFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             OrderDetailsFLST,Exclusive
          RETURN
.
.  Preparing of OrderDetails Files
.
PrepOrderDetails                            
           PREPARE       OrderDetailsFL,"OrderDetails.txt","OrderDetails.isi","-n,z,y,431-438,11-20,35-37","600",EXCLUSIVE
           PREPARE       OrderDetailsFL2,"OrderDetails.txt","OrderDetails2.isi","-n,z,y,431-438,11-20,40-55,21-27","600",EXCLUSIVE
           PREPARE       OrderDetailsFL3,"OrderDetails.txt","OrderDetails3.isi","-n,w,z,y,431-438,1-10,11-20,40-55,21-27","600",EXCLUSIVE
           PREPARE       OrderDetailsFL4,"OrderDetails.txt","OrderDetails4.isi","-n,w,z,y,431-438,40-55,11-20,21-27","600",EXCLUSIVE
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
 
 
#OrderDetailsError
          PACK        #ErrorString from "Error ",#Operand," OrderDetails FileActual Error : ",S$ERROR$
          BEEP
          ALERT       STOP,#ErrorString,result,"I/O Error"
          STOP
 
 
#EndOfRoutine
          %ENDIF          //End of IO Include File

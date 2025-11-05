          %IFNDEF $CustomerPartDiscountsVARIO
 
$CustomerPartDiscountsVARIO      EQUATE         1
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
. Test Read for CustomerPartDiscountsKY Index
.
TSTCustomerPartDiscounts                    
          TRAP       #CustomerPartDiscountsError if IO
          TRAP       #CustomerPartDiscountsError if Range
          TRAP       #CustomerPartDiscountsError if Format
          TRAP       #CustomerPartDiscountsError if Parity
          MOVE       "Testing",#Operand
          READ       CustomerPartDiscountsFL,CustomerPartDiscountsKY;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Read for CustomerPartDiscountsKY Index
.
RDCustomerPartDiscounts                     
          TRAP       #CustomerPartDiscountsError if IO
          TRAP       #CustomerPartDiscountsError if Range
          TRAP       #CustomerPartDiscountsError if Format
          TRAP       #CustomerPartDiscountsError if Parity
          MOVE       "Reading",#Operand
          READ       CustomerPartDiscountsFL,CustomerPartDiscountsKY;CustomerPartDiscounts
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Locked Read for CustomerPartDiscountsKY Index
.
RDCustomerPartDiscountsLK                   
          TRAP       #CustomerPartDiscountsError if IO
          TRAP       #CustomerPartDiscountsError if Range
          TRAP       #CustomerPartDiscountsError if Format
          TRAP       #CustomerPartDiscountsError if Parity
          MOVE       "Reading",#Operand
          READLK     CustomerPartDiscountsFL,CustomerPartDiscountsKY;CustomerPartDiscounts
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Sequential Read for CustomerPartDiscountsKY Index
.
KSCustomerPartDiscounts                     
          TRAP       #CustomerPartDiscountsError if IO
          TRAP       #CustomerPartDiscountsError if Range
          TRAP       #CustomerPartDiscountsError if Format
          TRAP       #CustomerPartDiscountsError if Parity
          MOVE       "Reading Key Sequentially",#Operand
          READKS     CustomerPartDiscountsFL;CustomerPartDiscounts
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Sequential Read for CustomerPartDiscountsKY Index
.
KSCustomerPartDiscountsLK                   
          TRAP       #CustomerPartDiscountsError if IO
          TRAP       #CustomerPartDiscountsError if Range
          TRAP       #CustomerPartDiscountsError if Format
          TRAP       #CustomerPartDiscountsError if Parity
          MOVE       "Reading Key Sequentially",#Operand
          READKSLK   CustomerPartDiscountsFL;CustomerPartDiscounts
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Previous Read for CustomerPartDiscountsKY Index
.
KPCustomerPartDiscounts                     
          TRAP       #CustomerPartDiscountsError if IO
          TRAP       #CustomerPartDiscountsError if Range
          TRAP       #CustomerPartDiscountsError if Format
          TRAP       #CustomerPartDiscountsError if Parity
          MOVE       "Reading Key Previously",#Operand
          READKP     CustomerPartDiscountsFL;CustomerPartDiscounts
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Previous Read for CustomerPartDiscountsKY Index
.
KPCustomerPartDiscountsLK                   
          TRAP       #CustomerPartDiscountsError if IO
          TRAP       #CustomerPartDiscountsError if Range
          TRAP       #CustomerPartDiscountsError if Format
          TRAP       #CustomerPartDiscountsError if Parity
          MOVE       "Reading Key Previously",#Operand
          READKPLK   CustomerPartDiscountsFL;CustomerPartDiscounts
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Test Read for CustomerPartDiscountsKY2 Index
.
TSTCustomerPartDiscounts2                   
          TRAP       #CustomerPartDiscountsError if IO
          TRAP       #CustomerPartDiscountsError if Range
          TRAP       #CustomerPartDiscountsError if Format
          TRAP       #CustomerPartDiscountsError if Parity
          MOVE       "Testing",#Operand
          READ       CustomerPartDiscountsFL2,CustomerPartDiscountsKY2;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Read for CustomerPartDiscountsKY2 Index
.
RDCustomerPartDiscounts2                    
          TRAP       #CustomerPartDiscountsError if IO
          TRAP       #CustomerPartDiscountsError if Range
          TRAP       #CustomerPartDiscountsError if Format
          TRAP       #CustomerPartDiscountsError if Parity
          MOVE       "Reading",#Operand
          READ       CustomerPartDiscountsFL2,CustomerPartDiscountsKY2;CustomerPartDiscounts
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Locked Read for CustomerPartDiscountsKY2 Index
.
RDCustomerPartDiscounts2LK                  
          TRAP       #CustomerPartDiscountsError if IO
          TRAP       #CustomerPartDiscountsError if Range
          TRAP       #CustomerPartDiscountsError if Format
          TRAP       #CustomerPartDiscountsError if Parity
          MOVE       "Reading",#Operand
          READLK     CustomerPartDiscountsFL2,CustomerPartDiscountsKY2;CustomerPartDiscounts
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Sequential Read for CustomerPartDiscountsKY2 Index
.
KSCustomerPartDiscounts2                    
          TRAP       #CustomerPartDiscountsError if IO
          TRAP       #CustomerPartDiscountsError if Range
          TRAP       #CustomerPartDiscountsError if Format
          TRAP       #CustomerPartDiscountsError if Parity
          MOVE       "Reading Key Sequentially",#Operand
          READKS     CustomerPartDiscountsFL2;CustomerPartDiscounts
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Sequential Read for CustomerPartDiscountsKY2 Index
.
KSCustomerPartDiscounts2LK                  
          TRAP       #CustomerPartDiscountsError if IO
          TRAP       #CustomerPartDiscountsError if Range
          TRAP       #CustomerPartDiscountsError if Format
          TRAP       #CustomerPartDiscountsError if Parity
          MOVE       "Reading Key Sequentially",#Operand
          READKSLK   CustomerPartDiscountsFL2;CustomerPartDiscounts
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Previous Read for CustomerPartDiscountsKY2 Index
.
KPCustomerPartDiscounts2                    
          TRAP       #CustomerPartDiscountsError if IO
          TRAP       #CustomerPartDiscountsError if Range
          TRAP       #CustomerPartDiscountsError if Format
          TRAP       #CustomerPartDiscountsError if Parity
          MOVE       "Reading Key Previously",#Operand
          READKP     CustomerPartDiscountsFL2;CustomerPartDiscounts
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Previous Read for CustomerPartDiscountsKY2 Index
.
KPCustomerPartDiscounts2LK                  
          TRAP       #CustomerPartDiscountsError if IO
          TRAP       #CustomerPartDiscountsError if Range
          TRAP       #CustomerPartDiscountsError if Format
          TRAP       #CustomerPartDiscountsError if Parity
          MOVE       "Reading Key Previously",#Operand
          READKPLK   CustomerPartDiscountsFL2;CustomerPartDiscounts
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Update of CustomerPartDiscounts Record
.
UpdCustomerPartDiscounts                    
          TRAP       #CustomerPartDiscountsError if IO
          TRAP       #CustomerPartDiscountsError if Range
          TRAP       #CustomerPartDiscountsError if Format
          TRAP       #CustomerPartDiscountsError if Parity
          MOVE       "Updating",#Operand
          UPDATE     CustomerPartDiscountsFLST;CustomerPartDiscounts
          GOTO       #VALID
.
. Deletion of CustomerPartDiscounts Record
.
DelCustomerPartDiscounts                    
          TRAP       #CustomerPartDiscountsError if IO
          TRAP       #CustomerPartDiscountsError if Range
          TRAP       #CustomerPartDiscountsError if Format
          TRAP       #CustomerPartDiscountsError if Parity
          MOVE       "Deleting",#Operand
          DELETE     CustomerPartDiscountsFLST
          GOTO       #VALID
.
. Write for CustomerPartDiscounts Record
.
WrtCustomerPartDiscounts                    
          TRAP       #CustomerPartDiscountsError if IO
          TRAP       #CustomerPartDiscountsError if Range
          TRAP       #CustomerPartDiscountsError if Format
          TRAP       #CustomerPartDiscountsError if Parity
          MOVE       "Writing",#Operand
          WRITE      CustomerPartDiscountsFLST;CustomerPartDiscounts
          GOTO       #VALID
.
.  Opening of CustomerPartDiscounts Files
.
OpenCustomerPartDiscounts                   
          GETFILE          CustomerPartDiscountsFL
          RETURN           IF ZERO             //Nothing to do, the file is already open
          TRAP       #CustomerPartDiscountsError if IO
          TRAP       #CustomerPartDiscountsError if Range
          TRAP       #CustomerPartDiscountsError if Format
          TRAP       #CustomerPartDiscountsError if Parity
          MOVE       "Opening",#Operand
          OPEN             CustomerPartDiscountsFLST,LockManual,Multiple,NoWait
          RETURN
.
.  Opening of CustomerPartDiscounts Files in Read-Only Mode
.
OpenCustomerPartDiscountsRO                 
          GETFILE          CustomerPartDiscountsFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          TRAP       #CustomerPartDiscountsError if IO
          TRAP       #CustomerPartDiscountsError if Range
          TRAP       #CustomerPartDiscountsError if Format
          TRAP       #CustomerPartDiscountsError if Parity
          MOVE       "Opening",#Operand
          OPEN             CustomerPartDiscountsFLST,READ
          RETURN
.
.  Opening of CustomerPartDiscounts Files in Read-Only Mode
.
OpenCustomerPartDiscountsEx                 
          GETFILE          CustomerPartDiscountsFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          TRAP       #CustomerPartDiscountsError if IO
          TRAP       #CustomerPartDiscountsError if Range
          TRAP       #CustomerPartDiscountsError if Format
          TRAP       #CustomerPartDiscountsError if Parity
          MOVE       "Opening",#Operand
          OPEN             CustomerPartDiscountsFLST,Exclusive
          RETURN
.
.  Preparing of CustomerPartDiscounts Files
.
PrepCustomerPartDiscounts                   
           PREPARE       CustomerPartDiscountsFL,"CustomerPartDiscounts.txt","CustomerPartDiscounts.isi","-n,z,y,1-10,11-26","65",EXCLUSIVE
           PREPARE       CustomerPartDiscountsFL2,"CustomerPartDiscounts.txt","CustomerPartDiscounts2.isi","-n,z,y,57-65","65",EXCLUSIVE
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
 
 
#CustomerPartDiscountsError
          PACK        #ErrorString from "Error ",#Operand," CustomerPartDiscounts FileActual Error : ",S$ERROR$
          BEEP
          ALERT       STOP,#ErrorString,result,"I/O Error"
          STOP
 
 
#EndOfRoutine
          %ENDIF          //End of IO Include File

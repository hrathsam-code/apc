          %IFNDEF $ARDETVARIO
 
$ARDETVARIO                      EQUATE         1
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
. Test Read for ARDETKY Index
.
TSTARDET                                    
          MOVE       "Testing",#Operand
          READ       ARDETFL,ARDETKY;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Read for ARDETKY Index
.
RDARDET                                     
          MOVE       "Reading",#Operand
          READ       ARDETFL,ARDETKY;ARDET
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Locked Read for ARDETKY Index
.
RDARDETLK                                   
          MOVE       "Reading",#Operand
          READLK     ARDETFL,ARDETKY;ARDET
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Sequential Read for ARDETKY Index
.
KSARDET                                     
          MOVE       "Reading Key Sequentially",#Operand
          READKS     ARDETFL;ARDET
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Sequential Read for ARDETKY Index
.
KSARDETLK                                   
          MOVE       "Reading Key Sequentially",#Operand
          READKSLK   ARDETFL;ARDET
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Previous Read for ARDETKY Index
.
KPARDET                                     
          MOVE       "Reading Key Previously",#Operand
          READKP     ARDETFL;ARDET
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Previous Read for ARDETKY Index
.
KPARDETLK                                   
          MOVE       "Reading Key Previously",#Operand
          READKPLK   ARDETFL;ARDET
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Test Read for ARDETKY2 Index
.
TSTARDET2                                   
          MOVE       "Testing",#Operand
          READ       ARDETFL2,ARDETKY2;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Read for ARDETKY2 Index
.
RDARDET2                                    
          MOVE       "Reading",#Operand
          READ       ARDETFL2,ARDETKY2;ARDET
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Locked Read for ARDETKY2 Index
.
RDARDET2LK                                  
          MOVE       "Reading",#Operand
          READLK     ARDETFL2,ARDETKY2;ARDET
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Sequential Read for ARDETKY2 Index
.
KSARDET2                                    
          MOVE       "Reading Key Sequentially",#Operand
          READKS     ARDETFL2;ARDET
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Sequential Read for ARDETKY2 Index
.
KSARDET2LK                                  
          MOVE       "Reading Key Sequentially",#Operand
          READKSLK   ARDETFL2;ARDET
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Previous Read for ARDETKY2 Index
.
KPARDET2                                    
          MOVE       "Reading Key Previously",#Operand
          READKP     ARDETFL2;ARDET
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Previous Read for ARDETKY2 Index
.
KPARDET2LK                                  
          MOVE       "Reading Key Previously",#Operand
          READKPLK   ARDETFL2;ARDET
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Test Read for ARDETKY3 Index
.
TSTARDET3                                   
          MOVE       "Testing",#Operand
          READ       ARDETFL3,ARDETKY3;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Read for ARDETKY3 Index
.
RDARDET3                                    
          MOVE       "Reading",#Operand
          READ       ARDETFL3,ARDETKY3;ARDET
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Locked Read for ARDETKY3 Index
.
RDARDET3LK                                  
          MOVE       "Reading",#Operand
          READLK     ARDETFL3,ARDETKY3;ARDET
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Sequential Read for ARDETKY3 Index
.
KSARDET3                                    
          MOVE       "Reading Key Sequentially",#Operand
          READKS     ARDETFL3;ARDET
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Sequential Read for ARDETKY3 Index
.
KSARDET3LK                                  
          MOVE       "Reading Key Sequentially",#Operand
          READKSLK   ARDETFL3;ARDET
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Previous Read for ARDETKY3 Index
.
KPARDET3                                    
          MOVE       "Reading Key Previously",#Operand
          READKP     ARDETFL3;ARDET
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Previous Read for ARDETKY3 Index
.
KPARDET3LK                                  
          MOVE       "Reading Key Previously",#Operand
          READKPLK   ARDETFL3;ARDET
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Test Read for ARDETKY4 Index
.
TSTARDET4                                   
          MOVE       "Testing",#Operand
          READ       ARDETFL4,ARDETKY4;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Read for ARDETKY4 Index
.
RDARDET4                                    
          MOVE       "Reading",#Operand
          READ       ARDETFL4,ARDETKY4;ARDET
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Locked Read for ARDETKY4 Index
.
RDARDET4LK                                  
          MOVE       "Reading",#Operand
          READLK     ARDETFL4,ARDETKY4;ARDET
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Sequential Read for ARDETKY4 Index
.
KSARDET4                                    
          MOVE       "Reading Key Sequentially",#Operand
          READKS     ARDETFL4;ARDET
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Sequential Read for ARDETKY4 Index
.
KSARDET4LK                                  
          MOVE       "Reading Key Sequentially",#Operand
          READKSLK   ARDETFL4;ARDET
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Previous Read for ARDETKY4 Index
.
KPARDET4                                    
          MOVE       "Reading Key Previously",#Operand
          READKP     ARDETFL4;ARDET
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Previous Read for ARDETKY4 Index
.
KPARDET4LK                                  
          MOVE       "Reading Key Previously",#Operand
          READKPLK   ARDETFL4;ARDET
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Test Read for ARDETKY5 Index
.
TSTARDET5                                   
          MOVE       "Testing",#Operand
          READ       ARDETFL5,ARDETKY5;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Read for ARDETKY5 Index
.
RDARDET5                                    
          MOVE       "Reading",#Operand
          READ       ARDETFL5,ARDETKY5;ARDET
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Locked Read for ARDETKY5 Index
.
RDARDET5LK                                  
          MOVE       "Reading",#Operand
          READLK     ARDETFL5,ARDETKY5;ARDET
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Sequential Read for ARDETKY5 Index
.
KSARDET5                                    
          MOVE       "Reading Key Sequentially",#Operand
          READKS     ARDETFL5;ARDET
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Sequential Read for ARDETKY5 Index
.
KSARDET5LK                                  
          MOVE       "Reading Key Sequentially",#Operand
          READKSLK   ARDETFL5;ARDET
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Previous Read for ARDETKY5 Index
.
KPARDET5                                    
          MOVE       "Reading Key Previously",#Operand
          READKP     ARDETFL5;ARDET
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Previous Read for ARDETKY5 Index
.
KPARDET5LK                                  
          MOVE       "Reading Key Previously",#Operand
          READKPLK   ARDETFL5;ARDET
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Test Read for ARDETKY6 Index
.
TSTARDET6                                   
          MOVE       "Testing",#Operand
          READ       ARDETFL6,ARDETKY6;;
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Read for ARDETKY6 Index
.
RDARDET6                                    
          MOVE       "Reading",#Operand
          READ       ARDETFL6,ARDETKY6;ARDET
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Random Locked Read for ARDETKY6 Index
.
RDARDET6LK                                  
          MOVE       "Reading",#Operand
          READLK     ARDETFL6,ARDETKY6;ARDET
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Sequential Read for ARDETKY6 Index
.
KSARDET6                                    
          MOVE       "Reading Key Sequentially",#Operand
          READKS     ARDETFL6;ARDET
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Sequential Read for ARDETKY6 Index
.
KSARDET6LK                                  
          MOVE       "Reading Key Sequentially",#Operand
          READKSLK   ARDETFL6;ARDET
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Previous Read for ARDETKY6 Index
.
KPARDET6                                    
          MOVE       "Reading Key Previously",#Operand
          READKP     ARDETFL6;ARDET
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Key Locked Previous Read for ARDETKY6 Index
.
KPARDET6LK                                  
          MOVE       "Reading Key Previously",#Operand
          READKPLK   ARDETFL6;ARDET
          GOTO       #LOCKED IF LESS
          GOTO       #ERROR IF OVER
          GOTO       #VALID
.
. Update of ARDET Record
.
UpdARDET                                    
          MOVE       "Updating",#Operand
          UPDATE     ARDETFLST;ARDET
          GOTO       #VALID
.
. Deletion of ARDET Record
.
DelARDET                                    
          MOVE       "Deleting",#Operand
          DELETE     ARDETFLST
          GOTO       #VALID
.
. Write for ARDET Record
.
WrtARDET                                    
          MOVE       "Writing",#Operand
          WRITE      ARDETFLST;ARDET
          GOTO       #VALID
.
.  Opening of ARDET Files
.
OpenARDET                                   
          GETFILE          ARDETFL
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             ARDETFLST,LockManual,Single,NoWait
          RETURN
.
.  Opening of ARDET Files in Read-Only Mode
.
OpenARDETRO                                 
          GETFILE          ARDETFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             ARDETFLST,READ
          RETURN
.
.  Opening of ARDET Files in Read-Only Mode
.
OpenARDETEx                                 
          GETFILE          ARDETFl
          RETURN           IF ZERO             //Nothing to do, the file is already open
          MOVE       "Opening",#Operand
          OPEN             ARDETFLST,Exclusive
          RETURN
.
.  Preparing of ARDET Files
.
PrepARDET                                   
           PREPARE       ARDETFL,"ARDETFL.txt","ARDETFL.isi","-n,z,y,1-8,212-218,219-221","300",EXCLUSIVE
           PREPARE       ARDETFL2,"ARDETFL.txt","ARDETFL2.isi","-n,z,y,1-8,96-99,100-101,212-218,219-221","300",EXCLUSIVE
           PREPARE       ARDETFL3,"ARDETFL.txt","ARDETFL3.isi","-n,z,y,1-8,35-35,72-79,212-218,219-221","300",EXCLUSIVE
           PREPARE       ARDETFL4,"ARDETFL.txt","ARDETFL4.isi","-n,z,y,1-8,35-35,72-79,17-26,36-45,212-218,219-221","300",EXCLUSIVE
           PREPARE       ARDETFL5,"ARDETFL.txt","ARDETFL5.isi","-n,z,y,1-8,72-79,17-26,36-45,35-35,212-218,219-221","300",EXCLUSIVE
           PREPARE       ARDETFL6,"ARDETFL.txt","ARDETFL6.isi","-n,z,y,1-8,278-278,212-218,219-221","300",EXCLUSIVE
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
 
 
#ARDETError
          PACK        #ErrorString from "Error ",#Operand," ARDET FileActual Error : ",S$ERROR$
          BEEP
          ALERT       STOP,#ErrorString,result,"I/O Error"
          STOP
 
 
#EndOfRoutine
          %ENDIF          //End of IO Include File

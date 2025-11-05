harry	testing	
harry	testing	

	LOOP
	<-CUR>
	endif
                   
                   
	endif
	c



                    
	endif
	\c


	endif
	
	

                  include

	endif
	
                    prtpage           p;*ATTACH 
                    *B 

	endif 

                      


                

                    hARRY1.IF   

                    HARRY2.COPY 
                    *BORDER
                    HARRY2,*BORDER

      	RETURN
.copy             
	*BORDER
      	harry2.Copy
      	harry.copy

	harry.Copy

                    Harry.GetItemData 
                    .Copy 

                  

	endif
	
                   CALL               GetSelectionMethod
..HR 2018.7.27              IF                (SearchMethod = 1 or SearchMethod = 2)
                    if                 (SearchMethod = 0)
                      getprop            EChckCode,text=CustKY



                    for %(Variable) from "0" to 100 by "1"
                      
                    repeat


                      
                      call               RDCust
                      if                 (ReturnFl = 1)
                        beep
                        alert              note,"Customer does not exist",result,"ERROR: Invalid Customer"
                        EChckCode.Clear
                        return
                      endif









                      CALL              SetMain
                      MOVE              "3",Status
                      setprop           EChckCODE,enabled=0
                      setprop           Fill1,enabled=0
                      setprop           BAccept,enabled=1
                      RETURN
                    endif
.
. Added Logic on 12/23/2003
. HR
              IF                (SearchMethod = 1)         //By Invoice Number
                RESETVAR          InvoiceKey
                getprop           EChckCODE,text=InvoiceKey
.
. HR 12/22/2004 Modified due to problem properly reading Invoice Key
.
.                MOVE              InvoiceKey,InvoiceKeyF                //HR 5/16/2005
.                MOVE              InvoiceKeyF,InvoiceKey                //HR 5/16/2005

                PACKKEY           ARTRNKY5 FROM $Entity,"I",InvoiceKey,"999999"
                CALL              RDARTRN5

                CALL              KPARTRN5
                IF                (ReturnFl = 1 or ARTrn.Reference != InvoiceKey)
                  BEEP
                  ALERT           note,"Invoice Number does not exist",result
                  RETURN
                ENDIF
..HR 2018.07.25                SETITEM           RCustomer,0,1                //Set Button 'like' it's a customer
                setprop           EChckCODE,text=ARTrn.CustomerID
                CALL              GetSelectionMethod
                CLEAREVENTS


     











	endif 

                      

                    hARRY1.IF   

                    HARRY2.COPY 
                    *BORDER
                    HARRY2,*BORDER

      	RETURN

	*BORDER
      	harry2.Copy
      	harry.copy

	harry.Copy

	endif
	
                   CALL               GetSelectionMethod
..HR 2018.7.27              IF                (SearchMethod = 1 or SearchMethod = 2)
                    if                 (SearchMethod = 0)
                      getprop     

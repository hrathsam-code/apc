........................................................
.
         PACK      StateScan FROM CustREC.St,"2"
         RESET     States
         SCAN      StateScan in States
         IF        equal
           MOVE      "SC",DispBrch
         ELSE
           MOVE      "NY",DispBrch
         ENDIF


              INCLUDE           workvar.inc

InputCount    FORM              7

              INCLUDE           Sequence.FD
              INCLUDE           Cust.Fd


             CALL              OpenCust

              MOVE              " ",CustKY
              CALL              RDCust
              loop
                CALL              KSCust
              until             (ReturnFL = 1)
                squeeze                Cust.Contact,Cust.Contact
                if                     (Cust.Contact != "")
Harry
                    display            "Customer : ",Cust.CustomerID
                endif
                move                     "Accounts Payable",Cust.Contact
                call                     UPDCust

              REPEAT
              KEYIN           *p1:24,"Acct Added",ans

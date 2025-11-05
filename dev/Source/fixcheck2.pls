              INCLUDE           WorkVar.inc
              INCLUDE           Check.FD
              INCLUDE           CheckDet.FD
CheckFile     FILE
InpCount      FORM              7
UpdCount      FORM              7

..              CALL              OpenCheck
..              CALL              OpenCheckDetail
              OPEN              CheckFLST,Exclusive
              OPEN              CheckDetailFLST,Exclusive
              OPEN              CheckFile,"Checkfl",READ

              MOVE              " ",CheckKY
              LOOP
                READ              CheckFile,seq;Check
              UNTIL             (over)

                ADD               "1",InpCount
                DISPLAY           *P10:10,"Input Count : ",InpCount
                CONTINUE          if (Check.CheckDate > "20190228" or Check.BankCode = "9999  ")   //Delete all items BEFORE 1995

                PACKKEY           CheckKY FROM Check.Entity,Check.BankCode,Check.CheckNo
                CALL              RDCheck
                CONTINUE          if (ReturnFl = 1)

                PACKKEY           CheckDetailKY FROM Check.Entity,Check.BankCode,Check.CheckNo
                LOOP
                  CALL              RDCheckDetail
                  CALL              KSCheckDetail
                UNTIL             (ReturnFl = 1 or Check.CheckNo != CheckDetail.CheckNo or :
                                                   Check.BankCode != CheckDetail.BankCode)
                  MOVE              "9999",CheckDetail.BankCode
                  CALL              UPDCheckDetail
                REPEAT

                MOVE              "9999",Check.BankCode
                CALL              UPDCheck
                ADD               "1",UpdCount
                DISPLAY           *P10:12,"Update Count : ",UpdCount
              REPEAT

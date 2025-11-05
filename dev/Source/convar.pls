;=============================================================================;
;       created by:  chiron software & services, inc.                         ;
;                    4 norfolk lane                                           ;
;                    bethpage, ny  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  program:    convar                                                         ;
;                                                                             ;
;   author:    harry rathsam                                                  ;
;                                                                             ;
;     date:    01/09/2019 at 11:46am                                          ;
;                                                                             ;
;  purpose:    Convvert A/R Data Files                                        ;
;                                                                             ;
; revision:    ver     date     init       details                            ;
;                                                                             ;
;              1.0   01/09/2019   hor     initial version                     ;
;                                                                             ;
;                                                                             ;
;=============================================================================;
              INCLUDE           workvar.inc
              INCLUDE           rcvbles.fd
              INCLUDE           artrn.fd
              INCLUDE           ardet.fd
              INCLUDE           CHST.FD
              INCLUDE           CMPNY.FD
..              INCLUDE           APCTL.FD
.
InputCounter  FORM              10
ConvDate      DIM               8
ConvDate2     DIM               6
SeqMajor      FORM              7
SeqMinor      FORM              3
X             FORM              2


OldARfiles    file

              MOVE              "20",SeqMajor
              open              OldARFiles,"arfile",read
              call                     PREPartrn
              call                     PrepARDet
              call                     PrepCHST
              CALL              OpenARTRN.

              CALL              OpenARDET
              CALL              OPENCHST
..              CALL              OpenCMPNY
..              INCLUDE           Temporary.inc

              LOOP
                read              OldARFiles,seq;RCVBLEREC
              UNTIL             (over)
...FUCKUP                CONTINUE        IF (INVTYPE = "C")          //HR
                ADD             "1",InputCounter
                MOVE            "1",SeqMinor
.....
. Write out the Master record first....Make sure that we don't have any
. duplicates
.
              MOVE              $Entity,ARTRN.Entity
              MOVE              INVCUST,ARTRN.CustomerID
              MOVE              INVKEY,ARTRN.Reference

. By Entity, Customer, Reference (Invoice No)
              PACKKEY           ARTRNKY FROM ARTRN.Entity,ARTRN.CustomerID,ARTRN.Reference
              CALL              TSTARTRN
              CONTINUE          if (ReturnFL = 0)    //Record already exists!!!

              unpack            INVDATE,MM,DD,YY
              IF                (YY > "90")
                PACK              YYYY,"19",YY
              ELSE
                PACK              YYYY,"20",YY
              ENDIF
              PACK              ARTRN.EntryDate,YYYY,MM,DD
              replace           " 0",ARTRN.EntryDate

              MOVE              ARTRN.EntryDate,ARTRN.TransDate
              MOVE              ARTRN.EntryDate,ARTRN.BillDate
              MOVE              ARTRN.EntryDate,ARTRN.DueDate
              MOVE              INVTOTL,ARTRN.OrigAmt
              MOVE              IDOLSLFT,ARTRN.Balance
              MOVE              "0",ARTRN.NonDiscAmt
              MOVE              "0",ARTRN.DiscPct
              MOVE              "0",ARTRN.DiscAmt
              MOVE              "Converted A/R",ARTRN.Memo
              ADD               "1",SeqMajor
              MOVE              SeqMajor,ARTRN.SeqMajor
..FUCKUP              MOVE              "0",ARTRN.HoldFlag
              MOVE              INVTYPE,ARTRN.InvCredit

              IF                (ARTRN.InvCredit = "C")
                MULTIPLY          "-1",ARTRN.Balance
                MULTIPLY          "-1",ARTRN.OrigAmt
              ENDIF

              IF                (ARTRN.Balance = 0 or INVSTAT = "W" or INVSTAT = "X" or INVSTAT="V")
                MOVE              "C",ARTRN.ClosedFlag
                MOVE              "0",ARTRN.Balance
                move                   "0",ARDet.BatchPosted
              ELSE
                MOVE              "O",ARTRN.ClosedFlag
                move                   "1",ARDet.BatchPosted
              ENDIF
.............................
. Write out the A/R Header record
.
              CALL              WRTARTRN

........................................................................
. Process the Details now
.
              MOVE              ARTRN.Entity,ARDet.Entity
              MOVE              ARTRN.SubEntity,ARDet.SubEntity
              MOVE              ARTRN.CustomerID,ARDet.CustomerID
              MOVE              "5",ARDet.TransCode                //Payment Code
              MOVE              "0",ARDet.DiscAmt
              MOVE              "AR Conversion",ARDet.Memo
              MOVE              ARTRN.SeqMajor,ARDet.SeqMajor
              MOVE              "1",ARDet.TransSubCode

.............................
. Let's see if we have multiple records that should be written out
. as multiple Detail lines
.
                FOR                X FROM "1" TO IPMNTS USING "1"
                  LOAD            ConvDate2 FROM X OF IDTPD1,IDTPD2,IDTPD3,IDTPD4,IDTPD5
                  unpack          ConvDate2 into MM,DD,YY
                  IF                (YY > "90")
                    PACK              YYYY,"19",YY
                  ELSE
                    PACK              YYYY,"20",YY
                  ENDIF
                  PACK              ARDet.TransDate,YYYY,MM,DD              //Fuckup, WAS ARTRN  2019.8.2
                  MOVE              ARDet.TransDate,ARDet.EntryDate
                  MOVE              ARDet.TransDate,ARDet.BillDate
                  MOVE              ARDet.TransDate,ARDet.DiscDate
                  MOVE              ARDet.TransDate,ARDet.PostDate
                  MOVE              YYYY,ARDet.Year
                  MOVE              MM,ARDet.Month

                  LOAD            ARDet.Amount FROM X OF IAMTPD1,IAMTPD2,IAMTPD3,IAMTPD4,IAMTPD5
                  LOAD            ARDet.Reference FROM X OF ICHK1,ICHK2,ICHK3,ICHK4,ICHK5
                  CONTINUE        IF (ARDet.Amount = 0)        //Ignore this record

                  MOVE              SeqMinor,ARDet.SeqMinor
                  ADD               "1",SeqMinor
                  CALL            WRTARDet
                  CALL            UpdateCustomerHistory
                REPEAT
.
. Write off Amount
.
              IF                (INVSTAT = "W")                             //Write off Amount (as per Bob)
                ADD               "1",ARDet.SeqMinor                     //New Sequence Record
                MOVE              "0",ARDet.DiscAmt
                MOVE              IDOLSLFT,ARDet.Amount
                MOVE              "          ",ARDet.DiscDate
                MOVE              ARTRN.ARAccount,ARDet.ARAccount     //Fuckup - Wait for G/L system
                MOVE              "8",ARDet.TransCode                    //Payment Code
                MOVE              "9",ARDet.TransSubCode
                MOVE              "                  ",ARDet.CustomerPO
                CALL              WRTARDet
              ENDIF

                DISPLAY           *P10:10,"Input Counter ",InputCounter
              REPEAT
              STOP
.
.==================================================================
UpdateCustomerHistory
           RETURN            IF (ARDet.Month = 0 or ARDet.Month > 12)

           PACKKEY           CHSTKY,$Entity,ARTRN.CustomerID,ARDet.Year
           CALL              RDCHST
           IF                (ReturnFL = 1)
             MOVE              $Entity,CHST.Entity
             MOVE              ARTRN.CustomerID,CHST.CustomerID
             MOVE              ARDet.Year,CHST.Year
             CLEAR             CHST.PurchAmt
             CLEAR             CHST.PaidAmt
             CLEAR             CHST.PurchTotal
             CLEAR             CHST.PaidTotal
             CLEAR             CHST.DiscAmt
             CLEAR             CHST.LastPayDt
             CLEAR             CHST.LastPayAmt
             ADD               ARDet.Amount,CHST.PaidAmt(ARDet.Month)
             ADD               "1",CHST.PaidTotal(ARDet.Month)
             ADD               ARDet.DiscAmt,CHST.DiscAmt(ARDet.Month)
.
. Calculate the YTD totals
.
             ADD               ARDet.Amount,CHST.PaidAmt(13)
             ADD               "1",CHST.PaidTotal(13)
             ADD               ARDet.DiscAmt,CHST.DiscAmt(13)
.
             MOVE              ARDet.TransDate,CHST.LastPayDt
             CALC              CHST.LastPayAmt = ARDet.Amount-ARDet.DiscAmt
             CALL              WRTCHST
           ELSE
             ADD               ARDet.Amount,CHST.PaidAmt(ARDet.Month)
             ADD               "1",CHST.PaidTotal(ARDet.Month)
             ADD               ARDet.DiscAmt,CHST.DiscAmt(ARDet.Month)
.
. Calculate the YTD totals
.
             ADD               ARDet.Amount,CHST.PaidAmt(13)
             ADD               "1",CHST.PaidTotal(13)
             ADD               ARDet.DiscAmt,CHST.DiscAmt(13)
.
             IF                (ARDet.TransDate > CHST.LastPayDt)
               MOVE              ARDet.TransDate,CHST.LastPayDt
               CALC              CHST.LastPayAmt = ARDet.Amount-ARDet.DiscAmt
             ENDIF
             CALL              UPDCHST
           ENDIF
           RETURN


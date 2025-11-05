;=============================================================================;
;       created by:  chiron software & services, inc.                         ;
;                    4 norfolk lane                                           ;
;                    bethpage, ny  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  program:    PrtCust.PLS                                                    ;
;                                                                             ;
;   author:    harry rathsam                                                  ;
;                                                                             ;
;     date:    01/08/2019 at 8:15am                                           ;
;                                                                             ;
;  purpose:                                                                   ;
;                                                                             ;
; revision:    ver     date     init       details                            ;
;                                                                             ;
;              1.0   01/08/2019   hor     initial version                     ;
;                                                                             ;
;                                                                             ;
;=============================================================================;

.
                    include            Common.INC
                    INCLUDE            WORKVAR.INC

..2017.08.21 PLBWebServer  EQUATE            1

ItemCount           FORM               6
TransDate           DIM                8
DueDate             DIM                8
DiscDate            DIM                8
HoldFlag            DIM                1
CityState           DIM                42
Days                FORM               10
IncludeInactive     form               1

SortedBy            FORM               1
AtleastOne          DIM                1
CustomerPrinted     DIM                1


AllVendorFlag         FORM               1
FromCustomer        DIM                6
ToCustomer          DIM                6

AllCollection       COLLECTION

.
                    GOTO               #S
                    include            Sequence.FD

                    INCLUDE            Cust.FD
                    INCLUDE            PrintRtn.INC

PrtCustomer         PLFORM            PrtCust
#S
STARTPGM            routine
                    winhide
                    LISTINS           AllCollection,EVendorFrom,EVendorTo,BVendorFrom,BVendorTo

                    FORMLOAD          PrtCustomer
.                    move               "NEWMASTER",FromPGM

                    LOOP
                      WAITEVENT
                    REPEAT
                    chain              fromPGM
                    STOP
;==========================================================================================================
StartPrint
                    setmode            *MCursor=*Wait
                    MOVE               "Y",FirstFlag
                    MOVE               "Customer Listing Report",ReportTitle

                    CLOCK              timestamp to DATE8
                    CALL               ConvDateToDays using DATE8,TodayDays

                    open               CustFLST,READ

                    CALL               PrintPreviewInit
                    RETURN             IF (printInitFailed = "N")
                    CALL               PrintPortraitMode

                    getprop            CBInactive,value=IncludeInactive

                    GETITEM            CBSortedBy,0,SortedBy

                    GETITEM            RAllVendors,0,AllVendorFlag
                    IF                 (AllVendorFlag = 0)
                      GETITEM           EVendorFrom,0,FromCustomer
                      GETITEM           EVendorTo,0,ToCustomer

                    ENDIF

                    CALL              PrintHeader



                    IF                  (AllVendorFlag = 0)
                      MOVE                 FromCustomer,CustKY
                    ENDIF

                    switch             SortedBy


                    case               1
                      MOVE              "        ",CustKY2     //By Customer Name
                      CALL              RDCust2
                    case               2
                      MOVE              " ",CustKY
                      CALL              RDCust
                    case               3

                    endswitch

                    LOOP
                      switch           SortedBy

                      case             1
                        CALL              KSCust2
                      case             2
                        IF               (ReturnFL = 1 or FirstFlag = "N")
                          CALL              KSCust
                        ENDIF
                      case             3
                      endswitch

                    UNTIL             (Returnfl = 1)

                    BREAK              IF (AllVendorFlag = 0 AND SortedBy = 2 AND Cust.CustomerID > ToCustomer)
                    CONTINUE           IF (AllVendorFlag = 0 and (Cust.CustomerID < FromCustomer or Cust.CustomerID > ToCustomer))
                    continue           if (IncludeInactive = 0 and Cust.Inactive = 1)

                    MOVE               "N",CustomerPrinted
                    MOVE               "N",FirstFlag

                    CALL              PrintLine
                    ADD               "1",ItemCount
                    REPEAT

                    call               PrintTotals
                    setmode            *MCursor=*Arrow

                    CALL              PrintClose
                    GOTO                 ExitProgram
;==========================================================================================================
PrintLine
                        EndOfPage

                        PrtPage           P;*font=DetailFont:
                                          *alignment=*left:
..                                          *boldon:
                                          *P=020:PrintLineCnt,Cust.CustomerID:
                                          *p=070:PrintLineCnt,Cust.Name:
                                          *p=320:PrintLineCnt,Cust.Addr1:
.                                          *p=520:PrintLineCnt,Cust.Add2:
                                          *p=530:PrintLineCnt,Cust.City:
                                          *p=710:PrintLineCnt,Cust.St:
                                          *p=750:PrintLineCnt,Cust.Zip
.                                          *p=970:PrintLineCnt,Cust.Telefone



                        ADD               SingleLine,PrintLineCnt

                      MOVE              "Y",CustomerPrinted

                    RETURN
.=============================================================================
PrintCustomerTotals
.=============================================================================
PrintTotals
           PRTPAGE           P;*font=DetailFont,*boldon:
                             "Total Customers printed :":
                             *alignment=*left:
                             ItemCount:
                             *boldoff
                    RETURN

ExitProgram
              close                    CustFLST
              destroy            WPrint
              winshow
              CHAIN                FROMPGM
                    stop

.=============================================================================
EnableSelections
              GETITEM           RAllVendors,0,result
..              SETPROP           AllCollection,Enabled=result

              IF                (result = 1)
                SETPROP           EVendorFrom,BGCOLOR=$Btnface,static=1
                SETPROP           EVendorTo,BGCOLOR=$BtnFace,static=1
              ELSE
                SETPROP           EVendorFrom,BGCOLOR=$Window,static=0
                SETPROP           EVendorTo,BGCOLOR=$Window,static=0
                setfocus          EVendorFrom
              ENDIF
              RETURN
.=============================================================================
PrintCustomHeader
              PRTPAGE           P;*alignment=*left:
                                *font=SubLineFont:
                                *p=018:PrintLineCnt,"Acct No":
                                *P=070:PrintLineCnt,"Name":
                                *p=320:PrintLineCnt,"Address 1":
.                                *p=520:PrintLineCnt,"Address 2":
                                *p=520:PrintLineCnt,"City":
                                *p=710:PrintLineCnt,"State":
                                *p=750:PrintLineCnt,"Zip"
.                                *p=970:PrintLineCnt,"Telephone"
              ADD               SingleLine,PrintLineCnt
              RETURN
.=============================================================================

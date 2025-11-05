;=============================================================================;
;       created by:  chiron software & services, inc.                         ;
;                    4 norfolk lane                                           ;
;                    bethpage, ny  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  program:    PrtVendor.PLS                                                  ;
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

SortedBy            FORM               1
AtleastOne          DIM                1
VendorPrinted     DIM                1


AllVendorFlag         FORM               1
FromVendor        DIM                6
ToVendor          DIM                6

AllCollection       COLLECTION

.
                    GOTO               #S
                    include            Sequence.FD

                    INCLUDE            Vendor.FD
                    INCLUDE            PrintRtn.INC

PrtVendor          PLFORM            PrtVendor
#S
STARTPGM            routine
                    winhide
                    LISTINS           AllCollection,EVendorFrom,EVendorTo,BVendorFrom,BVendorTo

                    FORMLOAD          PrtVendor
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
                    MOVE               "Vendor Listing Report",ReportTitle

                    CLOCK              timestamp to DATE8
                    CALL               ConvDateToDays using DATE8,TodayDays

                    open               VendorFLST,READ

                    CALL               PrintPreviewInit
                    RETURN             IF (printInitFailed = "N")
                    CALL               PrintLandScapeMode

                    GETITEM            CBSortedBy,0,SortedBy

                    GETITEM            RAllVendors,0,AllVendorFlag
                    IF                 (AllVendorFlag = 0)
                      GETITEM           EVendorFrom,0,FromVendor
                      GETITEM           EVendorTo,0,ToVendor

                    ENDIF
                    MOVE              " ",VendorKY

                    IF                  (AllVendorFlag = 0)
                      MOVE                 FromVendor,VendorKY
                    ENDIF

                    switch             SortedBy
                    case               1
                      MOVE              "        ",VendorKY2     //By Vendor Name
                      CALL              RDVendor2
                    case               2
                      CALL              RDVendor
                    case               3
                    endswitch

                    CALL              PrintHeader

                    LOOP
                      IF                (SortedBy = 2)           //Vendor ID
                        IF               (ReturnFL = 1 or FirstFlag = "N")
                          CALL              KSVendor
                        ENDIF
                      ELSE
                        CALL              KSVendor2
                      ENDIF
                    UNTIL             (Returnfl = 1)

                    BREAK              IF (AllVendorFlag = 0 AND SortedBy = 2 AND Vendor.AccountNumber > ToVendor)
                    CONTINUE           IF (AllVendorFlag = 0 and SortedBy = 1 and Vendor.AccountNumber > ToVendor)

                    MOVE               "N",VendorPrinted
                    MOVE               "N",FirstFlag

                    continue           if (Vendor.AccountNumber = "000000" or Vendor.AccountNumber = "0000  ")


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
                                          *P=020:PrintLineCnt,Vendor.AccountNumber:
                                          *p=080:PrintLineCnt,Vendor.Name:
                                          *p=330:PrintLineCnt,Vendor.Address1:
                                          *p=520:PrintLineCnt,Vendor.Address2:
                                          *p=710:PrintLineCnt,Vendor.City:
                                          *p=860:PrintLineCnt,Vendor.State:
                                          *p=900:PrintLineCnt,Vendor.Zip:
                                          *p=970:PrintLineCnt,Vendor.Telephone
                        ADD               SingleLine,PrintLineCnt

                      MOVE              "Y",VendorPrinted

                    RETURN
.=============================================================================
PrintVendorTotals
.=============================================================================
PrintTotals
           PRTPAGE           P;*font=DetailFont,*boldon:
                             "Total Vendors printed :":
                             *alignment=*left:
                             ItemCount:
                             *boldoff
                    RETURN

ExitProgram
              close                    VendorFLST
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
                                *P=080:PrintLineCnt,"Name":
                                *p=330:PrintLineCnt,"Address 1":
                                *p=520:PrintLineCnt,"Address 2":
                                *p=710:PrintLineCnt,"City":
                                *p=860:PrintLineCnt,"State":
                                *p=900:PrintLineCnt,"Zip":
                                *p=970:PrintLineCnt,"Telephone"
              ADD               SingleLine,PrintLineCnt
              RETURN
.=============================================================================

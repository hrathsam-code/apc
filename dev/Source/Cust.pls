; Speed violation 9/15/2014  South Oyster Bay Road    Collection Agency                    4351401503308 PIN 3286
; Red Light Violation  8/30/2016  Merrick Road, Wantagh Ave     1 Meade Ave                1691604011473 PIN 9011
; Red Light Violation  11/13/2014 Milburn & Merrick Rd          Mother's Address           1691403905727 PIN 7265
; Nassau County Traffic Violation (516) 572-1786              866-8977-5349  Alliance 1
; Stephanie    Pay first Bring it on Thursday 9-11
; $ 780.99  Sheyla (Jessica)    59768#
;
;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    4 NORFOLK LANE                                           ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    Cust                                                           ;
;                                                                             ;
;   AUTHOR:    HARRY RATHSAM                                                  ;
;                                                                             ;
;     DATE:    05/07/2015 AT 2:54AM                                           ;
;                                                                             ;
;  PURPOSE:                                                                   ;
;                                                                             ;
; REVISION:    VER     DATE     INIT       DETAILS                            ;
;                                                                             ;
;              1.0   05/07/2015   HOR     INITIAL VERSION                     ;
;                                                                             ;
;                                                                             ;
;=============================================================================;
;
                    INCLUDE           NCOMMON.TXT
                    INCLUDE            WORKVAR.INC

#RESULT             FORM               1
#RES1               FORM               1
#DIM1               DIM                1
#DIM2               DIM                2
#RES2               FORM               2
#LEN1               FORM               3
#MenuItem           DIM                25


PhoneTypes          FORM               1(9)
PhoneTypesD         DIM                1(9)
PhoneNumbers        DIM                10(9)
Extensions          DIM                7(9)
X                   FORM               2
ContactID           FORM               ^
EndDateFlag         form               2

StartDate           dim                10
EndDate             dim                10
DiscountType        dim                15
.RowSelected         form               9
ShipToNum           form               4
ShipToFlag          form               1



                    GOTO              STARTPGM
                    INCLUDE           Sequence.FD
                    INCLUDE           Cust.FD
                    include            ShipTo.FD
                    include            CustD.FD

                    include            Parts.FD
                    include            TaxCode.FD
                    INCLUDE            ARTRM.FD
.                    include            Slsmn.FD
                    INCLUDE            GLMast.FD
.                    INCLUDE            Source.FD
.                    INCLUDE            CLASS.FD
                    include            Contact.FD
                    INCLUDE            TYPE.FD
                    INCLUDE            CHST.FD
                    INCLUDE            CNTRY.FD
                    INCLUDE            STATE.FD
                    include            Phone.FD
                    include            PhoneType.FD
...                    include            CustomerSearch.inc

.                                                             Diana Bonacassa
MAIN                PLFORM             CustAll.PLF
DataMenu            PLFORM             DataMenu.PLF
ShipToCustomer     dim               6

.
STARTPGM            ROUTINE
                    MOVE              "11",SortHeader             //HR 4.20.2016

                    MOVE              "3",SortHeader(4)
                    MOVE              "3",SortHeader(5)
                    MOVE              "5",SortHeader(6)

ShippingAcct        like               Cust.ShippingAcct
                    INCLUDE           SECURITY.INC
                    MOVE              "1",ProgLoaded
.
. If we're unable to find the Help file, then we're going to simply just not make
. the F1 Function key available to the Users
.
                   MOVE              "AppDir;HELPDIR",EnvData
                   CLOCK             INI,EnvData
                   IF                NOT OVER
                     PACK              EnvData,EnvData,CustHelp
                     TRAP              NOHELP IF OBJECT
                     SETMODE           *HELPLIB=EnvData
                     SETMODE           *F1HELP=ON
                     TRAPCLR           OBJECT
                     GOTO              OPENFILES
NOHELP
                     NORETURN
                   ENDIF
.
OPENFILES
                    TRAP               NOFILE NORESET IF IO
                    CALL               OPENCust
                    TRAPCLR            IO

                    CALL               OPENCustD
                    call               OpenShipTo

                    call               OpenPhone
                    call               OpenPhoneType
                    CALL               OPENARTRM
                    CALL               OPENGLMast
                    CALL               OpenSequence
.                    call               OpenSlsmn
                    call               OpenContact
..                    OPEN               CustAuditFLST
..                    CALL               OPENCLASS
                    CALL               OPENCNTRY



CustCOLL            COLLECTION
CustEDT             COLLECTION
CustActive          COLLECTION
ContactCOLL         COLLECTION
CustBoxes           collection

ShipToEDT           collection
ShipToBut           collection

;
; Includes ALL fields
;

              LISTINS           ShipToBut,BAddShipTo,BUpdateShipTo,BDeleteShipTo         //HR 10/10/2006

              LISTINS           ShipToEdt,STShipName,STShipAddress1:
                                          STShipAddress2,STShipAddress3:
                                          STShipCity,STShipSt,STShipZip:
                                          STShipCountry

           LISTINS           CustCOLL,ECustCode,ECustName,ECustAddr1,ECustAddr2,ECustAddr3:
                                     ECustCity,ECustSt,ECustZip,ECustCountry:
                                     ECustMemo:
                                     ECustTerm,ECustCrLimit:
                                     EGroupCust:
                                     ECustEMail:
                                     EContFName,EContMName,EContLName:
                                     EContAddr1A,EContAddr2A,EContAddr3A:
                                     EContCityA,EContStA,EContZipA:
                                     EContCountryA,EContPhone,EContExt:
                                     EContEMailA,EContMemoA,EShippingAcct,ECustPhone,ECustFax

           LISTINS           CustEDT,ECustName,ECustAddr1,ECustAddr2,ECustAddr3:
                                    ECustCity,ECustSt,ECustZip,ECustCountry:
                                    ECustMemo:
                                    ECustTerm,ECustCrLimit:
                                    EGroupCust:
                                    ECustEMail:
                                     EContFName,EContMName,EContLName:
                                     EContAddr1A,EContAddr2A,EContAddr3A:
                                     EContCityA,EContStA,EContZipA:
                                     EContCountryA,EContPhone,EContExt:
                                     EContEMailA,EContMemoA,EShippingAcct,ECustPhone,ECustFax

.
           LISTINS           CustBOXES,CBCustActive,ECustInvType:
                                       BSearchARTerm,BSearchCountry,BSearchGroupCust,BContCountry:
                                       BContState:
                                       ECustInvType:
                                       CAddrFlagA,CPhoneFlagA,BCreditCards

                   LISTINS           ContactCOLL,EContAddr1A,EContAddr2A:
                                                 EContAddr3A,EContCityA,EContStA,EContZipA:
                                                 EContCountryA

                   LISTINS           CustActive

.                  winhide
                   FORMLOAD          MAIN
                   FORMLOAD          DataMenu,WMain

                   call              MainReset
                   call              LoadPhoneTypes
                   setfocus          ECustCode

                   LOOP
                     WAITEVENT
                   REPEAT
.
. We never get here!!   Just in case though.... :-)
.
                   RETURN
.                  STOP
;==========================================================================================================
BROWSEFILE          ROUTINE
                    MOVE              "1",SortHeader             //HR 4.20.2016
                    MOVE              "5",SortHeader(5)

SEARCH              PLFORM            SEARCH3.PLF
                    CALL               OpenCust

                    FORMLOAD          SEARCH
                    RETURN
;==========================================================================================================
OnKeyPressCustCode
                    F2Search           ECustCode
                    return
;==========================================================================================================
OnKeyPressARTRM
                    F2Search           ECustTerm,ARTrm
                    return
;==========================================================================================================
OnClickARTRM
                    BTSearch           ECustTerm,ARTrm
                    return


;==========================================================================================================
INITSRCH
           PACK              SearchTitle,CustTitle," Search Window"
           SETPROP           WSearch,Title=SearchTitle

           CTADDCOL          "Acct No.",55,"Name",125:
                             "Address",100:
                             "City",100:
                             "State",40:
                             "Zip",60

           RETURN
;==========================================================================================================
LoadSearchWindow
              GETITEM           ESearchName,0,CustKY2

              SETMODE           *mcursor=*wait

              COUNT             result,CustKY2
              IF                (result = 0)
                SETMODE           *mcursor=*Arrow
                setprop                BSearchSearch,default=1
                setfocus                 ESearchName

                RETURN
              ENDIF

              clear             SearchCounter
              Uppercase         CustKY2
              LVSearchPLB.DeleteAllItems
              CALL              RDCust2
              LOOP
                CALL              KSCust2
              UNTIL             (ReturnFl = 1)
                uppercase         Cust.Name
                MATCH             CustKY2,Cust.Name
                IF                not equal
                  SETMODE           *mcursor=*Arrow
                  BREAK
                ENDIF
                incr              SearchCounter
                CTLoadRecord2     Cust2,Cust,Cust.CustomerID,Cust.CustomerID,Cust.Name:
                                  Cust.Addr1,Cust.City,Cust.St


              REPEAT
              SETMODE           *mcursor=*Arrow
              if                (SearchCounter = 0)
                beep
                alert                    stop,"No Custs Found that match the Search Criteria",result,"NO CustS FOUND"
                ESearchName.SelectAll
                ESearchName.Clear
                setprop                BSearchSearch,default=1
                setfocus                 ESearchName
              else
                LVSearchPLB.SetItemState using *Index=0,*State=03,*StateMask=03
                setprop                BSearchSelect,default=1
                setfocus               LVSearchPLB
              endif
              RETURN
;==========================================================================================================
ItemSelected
                      LVSearchPLB.GetNextItem giving RowSelected using *Flags=02,*Start=FirstRow
                    if                 (RowSelected != -1)
                      LVSearchPLB.GetItemText giving $SearchKey using *Index=RowSelected,*SubItem=0
                      MOVE               "Y",PassedVar
                      DESTROY            WSearch
                    endif

                    RETURN




;==========================================================================================================
PrintPreviewReport
                   return

.X READOPT         DIM               12
.X PAGED           DIM               4
.X NEXTLINE        INIT              127
.X PRTFILE         PFILE
.X PRTCOUNT        FORM              6
.X PRTCOUNTD       FORM              6
.X PRGTITLE        INIT              "A/P Terms MAster Listing"
.X PAGETITLE       DIM               60
.X DIM500          DIM               500
.X PRTWIDTH        FORM              8
.X PRTHEIGHT       FORM              8
.X DIM8            DIM               8
.X COL             FORM              3
.X ROW             FORM              3
.X MAXROWS         FORM              3
.X ACCT            DIM               9
.X TODAY8          DIM               8
.X TIME8           DIM               8
.X NUM1            FORM              3
.X NUM2            FORM              3
.X ToCode          DIM               8
.X .
;==========================================================================================================
PrintReport

.X PRTREPORT
.X CustRPT        PLFORM            CustRPT.PLF
.X .               WINHIDE
.X
.X                 CLOCK             DATE,TODAY8
.X                 CLOCK             TIME,TIME8
.X
.X                 MOVE              "60",MAXROWS
.X                 MOVE              "0",PAGE
.X                 MOVE              "90",LINE
.X
.X                 FORMLOAD          CustRPT
.X                 LOOP
.X                   WAITEVENT
.X                 REPEAT
.X
.X                 RETURN
.X
.X .               alert             note,"how???",returnfl
.X .               LOOP                                              .Wait...and Wait...
.X .                 WAITEVENT                                       .
.X .               REPEAT                                            .and wait
.X
.X START
.X .
.X .
.X . Since we're dealing with a sorted file, we're going to read it in
.X . Sequential order vs. Key Sequential.  Also, we must make sure that
.X . we don't read any records that we're not supposed to based on the
.X . code that was in the other program. (AP42.DBS)
.X .
.X
.X                 CLOCK             DATE,TODAY8
.X                 CLOCK             TIME,TIME8
.X
.X                 MOVE              "60",MAXROWS
.X                 MOVE              "0",PAGE
.X                 MOVE              "90",LINE
.X                 MOVE              "0",PRTCOUNT
.X .
.X . Process all Vendors in Sorted Order
.X .
.X                 MOVE              " ",CustKY
.X
.X                 GETITEM           RAll,0,RETURNFL
.X                 BRANCH            RETURNFL OF ALL
.X
.X                 GETITEM           EFromRange,0,CustKY
.X                 GETITEM           EToRange,0,ToCode
.X
.X                 IF                (ToCode < CustKY)
.X                   BEEP
.X                   ALERT             STOP,"From Code cannot be less than the To Code",RETURNFL,"Range Error"
.X                   SETFOCUS          ETORANGE
.X                   RETURN
.X                 ENDIF
.X
.X ALL
.X                 TRAP              NOPRINT IF SPOOL
.X                 PRTOPEN           PRTFILE,"@?","A/P Term Code Listing"
.X                 TRAPCLR           IO
.X
.X                 CALL              PRTHEADER2
.X
.X
.X                 CALL              RDCust
.X                 LOOP
.X                   CALL              KSCust
.X                 UNTIL             (RETURNFL = 1 OR Cust.Code > ToCode)
.X                   CALL              PRTLINE
.X                 REPEAT
.X .
.X . Print Totals line
.X .
.X                 IF                (LINE + 4 > MAXROWS)
.X                   CALL              PRTHEADER
.X                 ENDIF
.X                 PRTPAGE           PRTFILE;*N=3,PRTCOUNT," A/P Term Records Printed"
.X                 PRTCLOSE          PRTFILE
.X                 RETURN
.X .
.X . Print Each Detailed line
.X .
.X PRTLINE
.X                 ADD               "1",PRTCOUNT
.X                 MOVE              PRTCOUNT,PRTCOUNTD
.X
.X                 IF                (LINE > MAXROWS)
.X                   CALL              PRTHEADER
.X                 ENDIF
.X                 CHOP              Cust.NETDAYS,Cust.NETDAYS
.X                 CHOP              Cust.DISCDAYS,Cust.DISCDAYS
.X
.X                 MOVE              Cust.NETDAYS,NUM1
.X                 MOVE              Cust.DISCDAYS,NUM2
.X
.X                 PRTPAGE           PRTFILE;*1,Cust.Code:
.X                                           *16,Cust.Desc:
.X                                           *Alignment=*Right:
.X                                           *38,Num1:
.X                                           *50,Num2:
.X                                           *Alignment=*Decimal:
.X                                           *61,Cust.DiscPerc:
.X                                           *Alignment=*Left
.X
.X                 ADD       "2" TO LINE
                 RETURN
;==========================================================================================================
.X
.X PRTHEADER
.X                 PRTPAGE           PRTFILE;*NEWPAGE;
.X PRTHEADER2
.X                 CALC              COL=PRTWIDTH-15
.X                 ADD               "1",PAGE
.X                 MOVE              PAGE,PAGED
.X .               SETITEM           EPage,0,PAGED
.X
.X                 PRTPAGE           PRTFILE;*P1:63,*LINE=85:63:
.X                                           *N:
.X                                           *40,"Page :",*alignment=*left,PAGE:
.X                                           *P1:1:
.X                                           *P1:1,"Date : ",TODAY8:
.X                                           *BOLDON:
.X                                           *H=27,"Chiron Software & Services, Inc.",*BOLDOFF:
.X                                           *72,"APTERM":
.X                                           *N:
.X                                           *H=1,"Time : ",TIME8:
.X                                           *H=29,"A/P Term Code Master Listing":
.X                                           *72,"Accounts Payable":
.X                                           *N=2:
.X                                           *ULON:
.X                                           *H=1,"Term Code",*H=16,"Description":
.X                                           *H=33,"Net Days",*H=44,"Disc. Days":
.X                                           *H=57,"Disc. %":
.X                                           *ULOFF:
.X                                           *N
.X
.X                 MOVE              "5",LINE
.X                 RETURN

EXITASK
                   ALERT             PLAIN,"Are you sure you wish to exit this report?",#RESULT
                   IF                (#RESULT=1)
                     STOP
                   ENDIF
                   RETURN
;==========================================================================================================
NOPRINT
                   TRAPCLR           SPOOL
                   NORETURN
                   RETURN
;==========================================================================================================
MaintMenuOption
                   CALL                 GetMenuName
                   RETURN
;==========================================================================================================
MainValid
                   IF                (Status = 0)
                     GETCOUNT          ECustCODE
                     IF                (CharCount > 0)
                       getprop           ECustCODE,text=CustKY
                       CALL              RDCust
                       IF               (RETURNFL = 1)
                         PARAMTEXT        CustTITLE,CustKY,"",""
                         ALERT            CAUTION,"^0: ^1 Not Found",#RES2,"Record does not exist"
                         CALL             MAINRESET
                         RETURN
                       ENDIF
.
. OK, we've been able to read the record and now let's show it on the screen.
.
                       CALL              SETMAIN
                       CALL              LoadShipToCustomers                     //HR 9/20/2005
                       call              OnClickShipTo
                       MOVE              "3",Status                   .We've found a record
                       ENABLEITEM        BMainCHANGE
                       ENABLETOOL        ID_Change
                       EnableDBMenu      MModifyRecord

                       ENABLEITEM        BMainDELETE
                       ENABLETOOL        ID_Delete
                       EnableDBMenu        MDeleteRecord

....                       DISABLEITEM       ECustCODE
                       setprop           ECustCODE,Static=1,BGColor=$BtnFace
                       DISABLEITEM       Fill1
                       SETFOCUS          BMainChange
                     ENDIF
                   ENDIF
                   RETURN
;==========================================================================================================
LoadShipToCustomers
LoadShipToInfo
                    CBShipTo.ResetContent
                    move               "0",ShipToNum
                   move              Cust.CustomerID,ShipToCustomer
                    packkey            ShipToKY from ShipToCustomer,"      "
                    call               RDShipTo
                    loop
                      call               KSShipTo
                    until (ReturnFl = 1 or ShipTo.CustomerID != ShipToCustomer)
                      chop             ShipTo.Addr1,ShipTo.Addr1
                      chop             ShipTo.City,ShipTo.City

                      pack               DataLine from ShipToNum," - ",ShipTo.Addr1,", ",ShipTo.City
                      CBShipTo.InsertString using *String=DataLine,*Index=ShipToNum
                      CBShipTo.SetItemData using *Index=ShipToNum,*Data=ShipTo.SeqNo
                      incr               ShipToNum
                    repeat
                    if               (ShipToNum != 0)      //We've loaded up a single Customer
                      CBShipTo.SetCurSel using *Index=0
                    endif
                    return
;==========================================================================================================
OnClickShipTo
                    CBShipTo.GetCurSel giving result
                    if               (result != -1)      //We've loaded up a single Customer
                      CBShipTo.GetItemData giving ShipToNum using *Index=result
                      move               Cust.CustomerID,ShipToCustomer

                      pack               ShipToKY from ShipToCustomer,ShipTonum
                      call               RDShipTo
                    else
                      clear            ShipTo
                    endif

                    setprop            STShipName,text=Cust.Name,static=1,BGColor=$BtnFace

                    setprop            STShipAddress1,text=ShipTo.Addr1,static=1,BGColor=$BtnFace
                    setprop            STShipAddress2,text=ShipTo.Addr2,static=1,BGColor=$BtnFace
                    setprop            STShipAddress3,text=ShipTo.Addr3,static=1,BGColor=$BtnFace

                    setprop            STShipCity,text=ShipTo.City,static=1,BGColor=$BtnFace
                    setprop            STShipSt,text=ShipTo.St,static=1,BGColor=$BtnFace
                    setprop            STShipZip,text=ShipTo.Zip,static=1,BGColor=$BtnFace
                    setprop            STShipCountry,text=ShipTo.Country,static=1,BGColor=$BtnFace
                    return
;==========================================================================================================
OnClickAddShipTo
SaveShipTo          form               4
              IF                (ShipToFlag = 0)
                clear             ShipTo
                DISABLEITEM       BUpdateShipTo
                DISABLEITEM       CBShipTo
                DELETEITEM        ShipToEDT,0                              //Clear all of the fields.

                   move              Cust.CustomerID,ShipToCustomer
                PACKKEY           ShipToKY from ShipToCustomer,"9999"
                call                   RDShipTo
                call                   KPShipTo
                IF                (ReturnFl = 0 and ShipTo.CustomerID = ShipToCustomer)
                  add                  "1",ShipTo.SeqNo
                  move                 ShipTo.SeqNo,SaveShipTo
                  CLEAR             ShipTo
                  MOVE              SaveShipTo,ShipTo.SeqNo
                ELSE
                  CLEAR             ShipTo
                  MOVE              "0",ShipTo.SeqNo
                ENDIF

                setprop                STShipName,text=Cust.Name
                setprop                STShipAddress1,text=Cust.Addr1
                setprop                STShipAddress2,text=Cust.Addr2
                setprop                STShipAddress3,text=Cust.Addr3
                setprop                STShipCity,text=Cust.City
                setprop                STShipSt,text=Cust.St
                setprop                STShipZip,text=Cust.Zip
                setprop                STShipCountry,text=Cust.Country


                CALL              EnableShipToFields
                MOVE              "1",ShipToFlag                                                 2400
                SETITEM           BAddShipTo,0,"Save"                                              33
                MOVE              "1",Status                             //HR 10/11/2006           41.25
              ELSE
                move              Cust.CustomerID,ShipTo.CustomerID      //HR2019.8.28
                CALL              GetShipToInfo
                call                   WrtShipTo
                MOVE              "0",ShipToFlag
                SETITEM           BAddShipTo,0,"Add"
                ENABLEITEM        BUpdateShipTo
                pack               DataLine from ShipToNum," - ",ShipTo.Addr1,", ",ShipTo.City
                CBShipTo.InsertString using *String=DataLine,*Index=ShipToNum
                CBShipTo.SetItemData using *Index=ShipToNum,*Data=ShipTo.SeqNo

                CALL              DisableShipToFields
                MOVE              "0",Status
                call                   OnClickShipTo
              ENDIF
              RETURN
;=============================================================================
OnClickUpdateShipTo
              IF                (ShipToFlag = 0)
                CBShipTo.GetCurSel giving result
                RETURN            if (result = -1)
                  CBShipTo.GetItemData giving ShipToNum using *Index=result
                move                   Cust.CustomerID,ShipToCustomer
                packkey                ShipToKY from ShipToCustomer,ShipToNum      //HR 2019.8.28
                call                   RDShipTo
                return                 if (ReturnFl = 1)

                DISABLEITEM       BAddShipTo
                DISABLEITEM       CBShipTo

                MOVE              "1",ShipToFlag
                SETITEM           BUpdateShipTo,0,"Save"
                CALL              EnableShipToFields
                MOVE              "1",Status                  //We've selected the Modify/Change Button   //HR 10/11/2006

              ELSE
                CALL              GetShipToInfo
                call              UPDShipTo
                MOVE              "0",ShipToFlag
                SETITEM           BUpdateShipTo,0,"Update"
                ENABLEITEM        BAddShipTo
                CALL              DisableShipToFields
                MOVE              "0",Status                  //We've selected the Modify/Change Button   //HR 10/11/2006
              ENDIF
              RETURN
;=============================================================================
OnClickDeleteShipTo
                CBShipTo.GetCurSel giving result
                IF                (result = -1)                 //Nothing selected
                  BEEP
                  ALERT           stop,"No Ship To entry has been selected.  Please select one before trying to delete":
                                       result,"Unable to Delete"
                  RETURN
                ENDIF

                   move              Cust.CustomerID,ShipToCustomer
                CBShipTo.GetItemData giving ShipToNum using *Index=result
                packkey                ShipToKY from ShipToCustomer,ShipToNum     //HR 2019.8.28
                call                   RDShipTo
                return                 if (ReturnFl = 1)

                BEEP
                ALERT             plain,"Are you sure you wish to delete this Ship To entry?",result,"Confirm Deletion"
                RETURN            if (result != 1)

                call              DelShipTo
                CBShipTo.DeleteString using *Index=result
                CBShipTo.SetCurSel using *Index=0
                call                   OnClickShipTo
              RETURN
;==========================================================================================================
EnableShipToFields
              SETPROP               ShipToEdt,Static=0,BGCOLOR=$WINDOW
              RETURN
;=============================================================================
DisableShipToFields
              SETPROP               ShipToEdt,Static=1,BGCOLOR=$BTNFACE
              ENABLEITEM            CBShipTo
              RETURN

;==========================================================================================================
GetShipToInfo
                    getprop            STShipName,text=Cust.Name
                    getprop            STShipAddress1,text=ShipTo.Addr1
                    getprop            STShipAddress2,text=ShipTo.Addr2
                    getprop            STShipAddress3,text=ShipTo.Addr3
                    getprop            STShipCity,text=ShipTo.City
                    getprop            STShipSt,text=ShipTo.St
                    getprop            STShipZip,text=ShipTo.Zip
                    getprop            STShipCountry,text=ShipTo.Country
                    return
;==========================================================================================================



; Initialize MAIN Form and setup the Menu's, Fields, Objects, Buttons, etc

MAININIT
; Set the SELECTALL property for the COLLECTION and then take care of
; any ActiveX controls.
;
                   SETPROP           CustEDT,SELECTALL=$SelectAll
.
                   CALL              MAINRESET
                   RETURN
;==========================================================================================================
; New Button is pressed
;
MAINNEW
                   IF                (Status = 2)      //Let's 'Save' this NEW Record
                     CALL              VALIDATE1     //Validate the data first
.
. Something's not right...Let's just return and wait until all the fields
. have been validated
.
                     IF                (ValidFlag = 1)
                       RETURN
                     ENDIF
.
. Get all of the fields from the Form into the proper RECORD
.
                     CALL              GETMAIN
.
. Let's see if SOMEBODY else has entered/used this code before or let's just
. see if this Code already exists in the system
.
                      loop
                        GetNextSeq                Cust
                        squeeze                   Sequence.SeqNo,CustKY
                        CALL                      TSTCust
                      until                     (ReturnFl = 1)
                      repeat
                      move                      CustKY,Cust.CustomerID
                      setprop                   ECustCode,text=Cust.CustomerID

                      CLOCK            TimeStamp,Cust.Rec_Added

                      CALL              WRTCust
                      call              WritePhoneNumbers
                      pack              DataLine from "Customer: ",Cust.CustomerID," has been created for ",Cust.Name
                      alert                   note,DataLine,result,"CUSTOMER ADDED"

                      CALL              MAINRESET
                      RETURN
                   ELSE
                     CALL              MainReset
                     MOVE              "2",Status
                     CALL              DisableRecordButtons
                     setprop           EContact,text="Accounts Payable"
                     setprop           ECustTerm,text="2%15NT30"

.
. Enable all of the EditText fields and set the EditText fields
. to Non Read-Only
.
....                     ENABLEITEM        CustEDT
                     setprop           CustEDT,static=0,bgcolor=$Window
                     setprop           CustBoxes,enabled=1
                     DISABLEITEM       Fill1
                     %IFDEF            CBCustInactive
                     setprop           CBCustInactive,enabled=1
                     %ENDIF

....                 SETPROP           CustEDT,READONLY=0
....                 SETPROP           CustEDT,BGCOLOR=$WINDOW
.
. We also need to set any ActiveX controls to the same properties
.
.                    SETPROP           ECustDiscPerc,*Enabled=1
.                    SETPROP           ECustDiscPerc,*BackColor=$Window
.
. Setup any DEFAULT values
.
.                    SETPROP          ECustDISCDAYS,value=0
.
. Disable & Enable the proper Buttons along with changing
. the description of the Button's (i.e. Exit --> Change)
.
                     DISABLEITEM       BMainCHANGE
                     DISABLETOOL       ID_Change
                     DisableDBMenu     MModifyRecord

                     DISABLEITEM       BMainDELETE
                     DISABLETOOL       ID_Delete
                     DisableDBMenu     MDeleteRecord

                     setprop           BMainNEW,title=SaveTitle
                     ENABLETOOL        ID_Save
                     EnableDBMenu      MSaveRecord

                     setprop           BMainCancel,title=CancelTitle
                     ENABLETOOL        ID_Cancel

                     DISABLETOOL       ID_New
                     DisableDBMenu     MNewRecord

.
. Set the Focus to the first field that we're going to be Entering
.
                     setprop           ECustCode,static=1,bgcolor=$BtnFace
                     SETFOCUS          ECustName
                   ENDIF
                   RETURN
;==========================================================================================================
. Change/Save Button has been pressed
.
MAINCHANGE
.
. I'm only getting here if the Change Button has been selected.  Soooooo....Either the
. Change Button has been pressed, or this button now reads 'Save'.  If it reads Save,
. the Status flag will have been set to 1 the first time that this routine has been
. reached.
                   IF                (Status = 1)                //'Save' button has been pressed
                     CALL              VALIDATE1
                     IF                (ValidFlag = 0)           //Great..All fields ARE valid!!!
                       CALL              GETMAIN                 //Get all of the fields
                       CALL              UPDCust                //Update the record
                       call              WritePhoneNumbers

                       CALL              MAINRESET               //Reset the objects & fields
                       setprop           ShipToBut,enabled=0
                     ENDIF
                     RETURN                                      //Voila...Either way, we're RETURNING
                   ENDIF
                   GETCOUNT          ECustCODE
                   IF                (Charcount > 0)
                     getprop           ECustCODE,text=CustKY   //Read the Primary field ito the Key

                     CALL              RDCustLK               //Lock the record so that nobody uses it
.
. Just for arguments sake, let's just make sure that the record hasn't been deleted
. by another user, AND...Let's make sure that it's not being used by another user
. as well!!
.
                     IF                (RETURNFL = 1)          //WHAT!!! Somebody deleted this record
                       BEEP
                       ALERT             STOP,"Record deleted by another User!!",RESULT
                       CALL              MAINRESET
                       RETURN
                     ENDIF
.
. Record is locked...Try again later
.
                     IF                (RETURNFL = 2)          //WHAT!!! Somebody's locked the record
                       BEEP
                       ALERT             NOTE,"Record locked by another User..."::
                                               "Try again later",RESULT,LOCKTITLE
                       RETURN
                     ENDIF
.
. OK, OK...We've gotten this far...The record is now locked and we
. can safely change the Status to "Modify"
.
                     MOVE              "1",Status                  //We've selected the Modify/Change Button
                     CALL              DisableRecordButtons
.
. Not only do we have a good record, but we've been able to 'Lock' the record
. and now we're ready to proceed
.
. Enable the Entire Collection of EditText fields as well as setting the
. background colors and making them Non Read-Only
.
....                     ENABLEITEM        CustCOLL
                     DISABLEITEM       Fill1
                     %IFDEF            CBCustInactive
....                     ENABLEITEM        CBCustInactive
                     setprop           CBCustInactive,enabled=1
                     %ENDIF

                     setprop           ShipToBut,enabled=1

                     SETPROP           CustCOLL,static=0,bgcolor=$Window
                     setprop           CustBoxes,enabled=1
.
. OK, OK...What do we do with any ActiveX components. We've got to handle
. them as well.  Let's change these to Non Read-Only and change the
. Background colors as well
.
.                    SETPROP           ECustDiscPerc,*Enabled=1
.                    SETPROP           ECustDiscPerc,*BackColor=$Window
.
. Change the Cancel button button to 'Save' and the 'Exit' button to Cancel
.
                     setprop           BMainCancel,title=CancelTitle
                     ENABLETOOL        ID_Cancel

                     setprop           BMainCHANGE,title=SaveTitle
                     ENABLETOOL        ID_Save
                     EnableDBMenu      MSaveRecord

                     ENABLETOOL        ID_Undo
                     DISABLETOOL       ID_Change
                     DisableDBMenu     MModifyRecord

                     DISABLETOOL       ID_New
                     DISABLEITEM       BMainNew
                     DisableDBMenu     MDeleteRecord

                     SETFOCUS          ECustName               //Set the cursor to the next field
....                     DISABLEITEM       ECustCODE               //and Disable the Primary Code
                     setprop           ECustCODE,Static=1,BGColor=$BtnFace
                   ENDIF
                   RETURN
;==========================================================================================================
. Routine to read the First record and display it
.
MainUndo
. If I've click on the Undo/Reset button, I've already got the 'Key' based on
. the fact that I'm changing a record that already exists and I loaded the
. key the first time.  Soooooo....Simply 'Re-read' the record, Calll the
. SetMain routine and Voila!!!!
.
                   BEEP
                   ALERT             PLAIN,"Revert back to the 'Original' record",RESULT:
                                           SureTitle
                   IF                (RESULT = 1)
                     CALL              RDCustLK
                     CALL              SetMain
                   ENDIF
                   RETURN
;==========================================================================================================
MainFind
                   FindSearch        ECustCode
                   IF                (PassedVar = "Y")
                     getprop           ECustCODE,text=CustKY
                     MOVE              $SearchKey,CustKY
                     CALL              RDCust
.
. We've got a record thanks to our Trusy Search/Browse window. Let's
. continue now by setting up the proper Code field and calling the
. MainValid subroutine, that will take care of it for us.
.
                     MOVE              "0",Status
                     setprop           ECustCode,text=Cust.CustomerID
                     CALL              MainValid
                   else
                     setfocus          ECustCode
                   ENDIF
                   RETURN
;==========================================================================================================
. Routine to read the First record and display it
.
MainFirst
                   CLEAR             CustKY
                   FILL              FirstASCII,CustKY
                   CALL              RDCust
                   IF                (RETURNFL = 1)  . We didn't find a 'Blank' record
                     CALL              KSCust         . Try the 'next' record
                     IF                (RETURNFL = 1)  . There are no records in the file
                       BEEP
                       ALERT             STOP,"No records exist in the system...",RESULT:
                                              FirstTitle
                       RETURN
                     ENDIF
                   ENDIF
.
. We've got a record (either on the READ or the READKS.  Let's now continue
. processing as if we just lost the Focus of the main field.  By calling the
. MainValid subroutine, that will take care of it for us.
                   MOVE              "0",Status
                   setprop           ECustCode,text=Cust.CustomerID
                   CALL              MainValid
                   RETURN
;==========================================================================================================
. Routine to read the Last record and display it
.
MainLast
                   CLEAR             CustKY
                   FILL              LastASCII,CustKY
                   CALL              RDCust
                   IF                (RETURNFL = 1)  . We didn't find a 'Blank' record
                     CALL              KPCust         . Try the 'Previous' record
                     IF                (RETURNFL = 1)  . There are no records in the file
                       BEEP
                       ALERT             STOP,"No records exist in the system...",RESULT:
                                              LastTitle
                       RETURN
                     ENDIF
                   ENDIF
.
. We've got a record (either on the READ or the READKP.  Let's now continue
. processing as if we just lost the Focus of the main field.  By calling the
. MainValid subroutine, that will take care of it for us.

                   MOVE              "0",Status
                   setprop           ECustCode,text=Cust.CustomerID
                   CALL              MainValid
                   RETURN
;==========================================================================================================
. Routine to read the Next record and display it
.
MainNext
. We can't just do a simple READKS/READKP because of certain conditions including
. 'Attempting' to read past the last record (Next --> EOF) and the reverse
. condition.  Due to this fact, we need to get the current code, and THEN
. do a READKS/READKP
.
                   GETCOUNT          ECustCode
                   IF                (CharCount <> 0)
                     getprop           ECustCODE,text=CustKY
                     CALL              RDCust
                   ENDIF

                   CALL              KSCust         . Try the 'next' record
                   IF                (RETURNFL = 1)  . There are no records in the file
                     BEEP
                     ALERT             STOP,"End of file has been reached.",RESULT:
                                            NextTitle
                     RETURN
                   ENDIF
.
. We've got a record (either on the READ or the READKS.  Let's now continue
. processing as if we just lost the Focus of the main field.  By calling the
. MainValid subroutine, that will take care of it for us.
                   MOVE              "0",Status
                   setprop           ECustCode,text=Cust.CustomerID
                   CALL              MainValid
                   RETURN
;==========================================================================================================
. Routine to read the Previous record and display it
.
MainPrevious
. We can't just do a simple 'READKS' because of certain conditions including
. 'Attempting' to read past the last record (Next --> EOF) and the reverse
. condition.  Due to this fact, we need to get the current code, and THEN
. do a READKS/READKP
.
                   GETCOUNT          ECustCode
                   IF                (CharCount <> 0)
                     getprop           ECustCODE,text=CustKY
                     CALL              RDCust
                   ENDIF

                   CALL              KPCust         . Try the 'Previous' record
                   IF                (RETURNFL = 1)  . There are no records in the file
                     BEEP
                     ALERT             STOP,"Beginning of file has been reached...",RESULT:
                                            PrevTitle
                     RETURN
                   ENDIF

. We've got a record (either on the READ or the READKS.  Let's now continue
. processing as if we just lost the Focus of the main field.  By calling the
. MainValid subroutine, that will take care of it for us.

                   MOVE              "0",Status
                   setprop           ECustCode,text=Cust.CustomerID
                   CALL              MainValid
                   RETURN
;==========================================================================================================
. Save has been selected from the MENU vs. the Button
.
SAVEMODE
.
. OK...The 'Save' has been selected from the Menu rather than from the Save Button.
. What to do, What to do??  Is this a Save to a 'NEW' record or is it a Save to a
. 'CHANGED' record....
. Let's check the 'Status' flag...1 is a Change record, 2 is a New Record
.
                   BRANCH            Status,MainChange,MainNew
                   RETURN
;==========================================================================================================
; Routine to Validate the data from the Form
;  If we find an error below, set the ValidFlag = 1 and return

VALIDATE1
                   MOVE              "0",ValidFlag

.
. Everything's OK...Let's just return because the ValidFlag will be set to
. Zero from the top of this routine.
.
                   MOVE              "0",ValidFlag
                   RETURN
;==========================================================================================================
. Routine to 'Reset' everything which includes the Button's, Objects,
. fields, etc.
.
MAINRESET
                   move              "0",status     //reset the status to not updating
                   move              "0",ShipToFlag
                   unlock            Custfl
.
. Reset the fields to 'Blank' and DISABLE all of those fields as well
...                   DELETEITEM        CustCOLL,0
                   clear             Cust
                   call              setmain

....                   DISABLEITEM       CustCOLL
                   SETPROP           CustCOLL,static=1,bgcolor=$BtnFace
                   setprop           CustBoxes,enabled=0

                   CLEAR             PhoneNumbers
                   CLEAR             Extensions               //HR 11/1/2006

                   ENABLEITEM        Fill1
.
. Reset the Buttons for the Next record
.
                   DISABLEITEM       BMainChange
                   DISABLETOOL       ID_Change
                   DisableDBMenu     MModifyRecord

                   DISABLEITEM       BMainDELETE
                   DISABLETOOL       ID_Delete
                   DisableDBMenu     MDeleteRecord

                   setprop           BMainCHANGE,title=ChangeTitle

                   setprop           BMainNEW,title=NewTitle
                   ENABLETOOL        ID_New
                   EnableDBMenu      MNewRecord

                   ENABLEITEM        BMainNEW
                   setprop           BMainCancel,title=ExitTitle

                   DISABLETOOL       ID_Save
                   DISABLETOOL       ID_Undo
                   DISABLETOOL       ID_Cancel

                   DisableDBMenu     MSaveRecord

                    setprop            ECustPhone,text=""
                    setprop            ECustFax,text=""

...                   setprop            ECustName,visible=0
...                   setprop            SCustName,visible=0

                   CALL              EnableRecordButtons
.
. Setup any ActiveX control fields to what they should be
.
.                  SETPROP           ECustDiscPerc,*Text="0"
.                  SETPROP           ECustDiscPerc,*Enabled=0
.                  SETPROP           ECustDiscPerc,*BackColor=$BTNFACE
.
. Setup the Primary field that is used for Entry purposes
.
                   %IFDEF            CBCustInactive
....                   SETITEM           CBCustInactive,0,0
....                   DISABLEITEM       CBCustInactive
                   setprop           CBCustInactive,enabled=0,value=0
                   %ENDIF

....                   SETPROP           ECustCODE,READONLY=0
....                   SETPROP           ECustCode,BGCOLOR=$WINDOW
                   SETPROP           ECustCode,static=0,bgcolor=$Window

                    setprop            ShipToEdt,text="",static=1,BGColor=$BtnFace
                    CBShipping.SetCurSel using *Index=1

              setprop                  ShipToBut,enabled=0
                    CBShipTo.ResetContent
                    clear              ShippingAcct
....                   ENABLEITEM        ECustCODE
                   SETFOCUS          ECustCODE
                   RETURN
;==========================================================================================================

; Cancel Button has been Clicked
;
MAINCLOSE
.
. Only display this message if I'm in either the Modify or New mode.  If not,
. simply exit the program and proceed as normal
.
           IF                (Status <> 0)
             BEEP
             ALERT              PLAIN,"By Exiting the program now, your operation will be Cancelled?",RESULT:
                                      "Are you sure?"
             IF                 (RESULT = 1)
               DESTROY         WMAIN      . Get rid of the Bank Window
              winshow
              CHAIN             FROMPGM
             ELSE
               RETURN                     . Contine with standard operations
             ENDIF
           ENDIF
           DESTROY         WMAIN          . Get rid of the Bank Window
              winshow
              CHAIN             FROMPGM

.=============================================================================
. Cancel button has been pressed
.
MainCancel
           IF                (Status = 0)      . They want to exit the program
             DESTROY         WMAIN             . Get rid of the Main Window
..FUCKUP             NORETURN
...FUCKUP             RETURN
              winshow
              CHAIN             FROMPGM

           ELSE
             IF                (Status = 1 OR Status = 2)  . Change/New Mode
               BEEP
               ALERT              PLAIN,"Do you wish to cancel this operation?",RETURNFL:
                                        "Are you sure?"
               IF                 (RETURNFL = 1)
                 CALL               MAINRESET
                 RETURN
               ELSE
                 RETURN
               ENDIF
             ELSE
               CALL              MAINRESET
             ENDIF
             RETURN
           ENDIF
;==========================================================================================================
. Delete Button has been Pressed
.
MainDelete
                   PARAMTEXT        Cust.CustomerID,CustTitle,"",""
                   BEEP
                   ALERT            PLAIN,"Do you wish to Delete the ^1: ^0 ?",#RES1,DelTitle
                   IF               (#RES1 = 1)
                     CALL             DELCust
                     ALERT            NOTE,"A/P Term Code ^0 has been deleted",#RES1,DelOKTitle
                     CALL             MAINRESET
                   ENDIF
                   RETURN
;==========================================================================================================
.
. Setup all of the fields in the Form based upon the data record
SETMAIN
                   %IFDEF            CBCustInactive
                   setprop           CBCustInactive,value=Cust.Inactive
                   %ENDIF
           SETITEM           ECustCode,0,Cust.CustomerID
SETMAIN2
           setprop           ECustName,text=Cust.NAME
           setprop           ECustAddr1,text=Cust.Addr1
           setprop           ECustAddr2,text=Cust.Addr2
           setprop           ECustAddr3,text=Cust.Addr3
           setprop           ECustCity,text=Cust.City
           setprop           ECustSt,text=Cust.St
           setprop           ECustZip,text=Cust.Zip
           setprop           ECustCountry,text=Cust.Country
           CANDISP          ECustCountry,CNTRY,STCustCountry,Name

           setprop           ECustCrLimit,value=Cust.CreditLimit

                    setprop           ECustMemo,text=Cust.Memo
                    setprop           ECustTerm,text=Cust.TermCode
                    setprop           CBCustActive,value=Cust.InActive
                    CANDISP           ECustCountry,CNTRY,STCustCountry,Name
                    setprop           EGroupCust,text=Cust.GroupCust
                    setprop           ECustEMail,text=Cust.EMail                    //HR 7/25/2003
                    setprop           EContact,text=Cust.Contact

                    SETPROP           ECustPhone,Text=Cust.Telephone
                    SETPROP           ECustFax,Text=Cust.Fax

                    move              Cust.ShippingAcct(1),ShippingAcct(1)
                    move              Cust.ShippingAcct(2),ShippingAcct(2)

                    ECustInvType.SetCurSel using *Index=Cust.InvMethod

                    CANDISP            EGroupCust,Cust,STGroupCust,Name
                    call               SetPhoneNumbers
                    getitem            CBShipping,0,result
                    setprop            EShippingAcct,text=ShippingAcct(result)
                    RETURN

;==========================================================================================================
. Retrieve all of the fields in the Form based upon the data record
.
GETMAIN
                   %IFDEF            CBCustInactive
                   getprop           CBCustInactive,value=Cust.Inactive
                   %ENDIF
                    getprop           ECustCode,text=Cust.CustomerID

                    getprop           ECustName,text=Cust.Name
                    move              Cust.Name,Cust.LookupName

                    getprop           ECustAddr1,text=Cust.Addr1
                    getprop           ECustAddr2,text=Cust.Addr2
                    getprop           ECustAddr3,text=Cust.Addr3

                    getprop           ECustCity,text=Cust.City
                    getprop           ECustSt,text=Cust.St
                    getprop           ECustZip,text=Cust.Zip
                    getprop           ECustCountry,text=Cust.Country
                    getprop           ECustCrLimit,value=Cust.CreditLimit

                    getprop           ECustMemo,text=Cust.Memo
                    getprop           ECustTerm,text=Cust.TermCode
                    getprop           EGroupCust,text=Cust.GroupCust

                    ECustInvType.GetCurSel giving Cust.InvMethod

                    getprop           ECustEMail,text=Cust.EMail                     C NO STAMP

                    getprop           CBCustActive,value=Cust.Inactive            //HR 7/25/2003
                    getprop           EContact,text=Cust.Contact

                    gETPROP           ECustPhone,Text=Cust.Telephone
                    gETPROP           ECustFax,Text=Cust.Fax

                    move              ShippingAcct(1),Cust.ShippingAcct(1)
                    move              ShippingAcct(2),Cust.ShippingAcct(2)

                    RETURN
;==========================================================================================================
UseStudentAddress
              RETURN            if (Status = 0)

              IfChecked         CAddrFlagA
                SETITEM           CAddrFlagA,0,0
                SETPROP           ContactColl,BGColor=$Window,ReadOnly=0
                setprop           EContAddr1A,text=ContactREC.Addr1
                setprop           EContAddr2A,text=ContactREC.Addr2
                setprop           EContAddr3A,text=ContactREC.Addr3
                setprop           EContCityA,text=ContactREC.City
                setprop           EContStA,text=ContactREC.St
                setprop           EContZipA,text=ContactREC.Zip
                setprop           EContCountryA,text=ContactREC.Country
              ELSE
                SETITEM           CAddrFlagA,0,1
                SETPROP           ContactColl,BGColor=$BtnFace,ReadOnly=1
              EndIfClicked
              RETURN
;=============================================================================
UseCompanyPhone
              IfChecked         CPhoneFlagA
                SETITEM           CPhoneFlagA,0,0
              ELSE
                SETITEM           CPhoneFlagA,0,1
              EndIfChecked
              RETURN
;==========================================================================================================
OnClickChangePhoneType
.             GETITEM           CBContactPhoneType,0,result
.             SETPROP           ETContactPhone,Text=PhoneNumbers(result)
.             SETPROP           EContExt,Text=Extensions(result)
              RETURN
;==========================================================================================================
OnClickChangeShippingType
              GETITEM           CBShipping,0,result
              SETPROP           EShippingAcct,Text=ShippingAcct(result)
              RETURN
;==========================================================================================================
UpdateShippingAccts
                    GETITEM           CBShipping,0,result
                    IF                (result != 0)
                      GETPROP           EShippingAcct,Text=ShippingAcct(result)
                    ENDIF
                    RETURN
;==========================================================================================================
SetPhoneNumbers
.             CLEAR             PhoneNumbers
.             CLEAR             Extensions                                //HR 11/24/2006
.             FOR                x FROM "1" TO "9" USING "1"
.               BREAK           if (PhoneTypes(x) = 0)
.               move              Cust.CustomerID,PhoneREC.ContactID        //HR 2019.8.27
.               PACKKEY           PhoneKY FROM PhoneREC.ContactID,PhoneTypes(X)
.               CALL              RDPhone
.               CONTINUE          IF (ReturnFL = 1)
.               MOVE              PhoneREC.Number,PhoneNumbers(X)
.               MOVE              PhoneREC.Extension,Extensions(X)         //HR 11/1/2006
.               SETITEM           CBContactPhoneType,0,X

.             REPEAT
              RETURN
.=============================================================================
LoadPhoneTypes
.             MOVE              " ",PhoneTypeKY
.             MOVE              "0",result
.             CALL              RDPhoneType
.             LOOP
.               CALL            KSPhoneType
.             UNTIL             (ReturnFL = 1)
.               ADD               "1",result
.               MOVE              PhoneType.Type,PhoneTypes(result)
.               MOVE              PhoneType.Type,PhoneTypesD(result)
.               INSERTITEM        CBContactPhoneType,result,PhoneType.Description
.             REPEAT
              RETURN
.=============================================================================
UpdatePhoneNumbers
.             GETITEM           CBContactPhoneType,0,result
.             IF                (result != 0)
.               GETPROP           ETContactPhone,Text=PhoneNumbers(result)
.               GETPROP           EContExt,Text=Extensions(result)
.             ENDIF
              RETURN
;==========================================================================================================
UpdateContactPhoneNumbers
                    return
.=============================================================================
WritePhoneNumbers
.              MOVE              Cust.CustomerID,PhoneREC.ContactID
.              FOR                x FROM "1" TO "9" USING "1"
.                CONTINUE        if (PhoneTypes(x) = 0)
.                PACKKEY         PhoneKY FROM Cust.CustomerID,PhoneTypes(X)
.                CALL            RDPhone
.                MOVE            PhoneNumbers(x),PhoneREC.Number
.                MOVE            Extensions(x),PhoneREC.Extension            //HR 11/1/2006
.                MOVE            PhoneTypes(x),PhoneREC.PhoneType
.                IF              (ReturnFl = 0)          //Record aready exists
.                  IF              (PhoneNumbers(x) = "          " and PhoneNumbers(x) != "")
.                    CALL            DelPhone
.                  ELSE
.                    CALL            UpdPhone
.                  ENDIF
.                ELSE                                   //Record doesn't exist
.                  IF              (PhoneNumbers(x) != "          " and PhoneNumbers(x) != "")
.                    CALL            WrtPhone
.                  ENDIF
.                ENDIF
.              REPEAT
               RETURN
;==========================================================================================================
.Help Menu selection if required
.
MAINHELP
                   RETURN
;==========================================================================================================
.Help Menu to bring up the Contents of the help file
.
mainHelpContents
                   RETURN
;==========================================================================================================
;.Help Menu to Search the help file
;
MainHelpSearch
                   RETURN
;==========================================================================================================
onClickMainWinChangeMenu
                   PERFORM           RESULT OF  MAINNEW,MAINCHANGE,MainDelete,SAVEMODE
                   RETURN
;==========================================================================================================
onClickMainWinExitButton
.
. check to see if this is masquerading as a CANCEL button
.
                   CALL              MainCancel
                   RETURN
;==========================================================================================================
onClickMainWinFileMenu
.
. process a click on the file menu
.
                   PERFORM           result of MainPrint,,MAINCLOSE
                   RETURN
;==========================================================================================================
onClickMainWinHelpMenu
                   PERFORM           result of MAINHELP,MAINHELP,MAINAbout
                   RETURN
;==========================================================================================================
. Display the Standard "About Box"
.
MAINAbout
.
. display an alert box describing the program
.
                   getmode           *ProgName=ProgramName
                   getmode           *ProgStamp=ProgramStamp
                   getmode           *ProgVer=ProgramVer

                   CALL              About using ProgramName,ProgramStamp,ProgramVer
                   SETFOCUS          WMain
                   RETURN
;==========================================================================================================
. Display the Standard "About Chiron"
.
MainAboutChiron
.
. display an alert box describing the program
.
                   CALL              AboutChiron
                   SETFOCUS          WMain
                   RETURN
;==========================================================================================================
. Print Report option
.
MainPrint
                   CALL              PrintReport
                   RETURN
;==========================================================================================================
MainPrintPreview
                   call              PrintPreviewReport
                   RETURN
;==========================================================================================================
MainToolBar
                   RETURN
;==========================================================================================================
. Disable the 'Record' Buttons because we're in the middle of Updating or
. Creating a New record.
.
DisableRecordButtons
                   DISABLETOOL       ID_First
                   DISABLETOOL       ID_Next
                   DISABLETOOL       ID_Previous
                   DISABLETOOL       ID_Last
                   DISABLETOOL       ID_Find

                   DisableGoToMenu   MFirst
                   DisableGoToMenu   MNext
                   DisableGoToMenu   MPrevious
                   DisableGoToMenu   MLast
                   DisableGoToMenu   MSearch
                    return
;==========================================================================================================
. Enable the 'Record' Buttons because we're in the middle of Updating or
. Creating a New record.
.
EnableRecordButtons
                   ENABLETOOL        ID_First
                   ENABLETOOL        ID_Next
                   ENABLETOOL        ID_Previous
                   ENABLETOOL        ID_Last
                   ENABLETOOL        ID_Find

                   EnableGoToMenu    MFirst
                   EnableGoToMenu    MNext
                   EnableGoToMenu    MPrevious
                   EnableGoToMenu    MLast
                   EnableGoToMenu    MSearch
                   RETURN
;==========================================================================================================
NOFILE
                   NORETURN
                   ALERT             PLAIN,"Customer Master file does not exist. Do you wish to create it?",#RESULT
                   IF                (#RESULT = 1)
                     GOTO              OPENFILES
                   ENDIF
                   STOP
;==========================================================================================================
SortColumn

              EventInfo         0,Result=SortColumn
                    display            "SortCol : ",sortcolumn
              MOVE              FirstRow,StartingRow

              LVSearchPLB.GetNextItem giving SelectedRow using *Flags=2,*Start=StartingRow
              LVSearchPLB.GetItemParam giving ItemParam using *Index=SelectedRow

              IF                (((SortHeader(SortColumn) / 2) * 2) = SortHeader(SortColumn))
                SUBTRACT        "1",SortHeader(SortColumn)
              ELSE
                ADD             "1",SortHeader(SortColumn)
              ENDIF

              SWITCH            SortHeader(SortColumn)

              CASE              5
                MOVE              "mm-dd-yyyy",SortMask
              CASE              6
                MOVE              "mm-dd-yyyy",SortMask
              DEFAULT
                MOVE              "",SortMask
              ENDSWITCH

              LVSearchPLB.SortColumn using *Column=SortColumn,*Type=SortHeader(SortColumn),*Mask=SortMask
              LVSearchPLB.FindItem giving SelectedRow using *Start=StartingRow,*Param=ItemParam
              LVSearchPLB.EnsureVisible using *Index=SelectedRow,*Partial=0
              LVSearchPLB.SetItemState using *Index=SelectedRow,*State=03,*StateMask=03

              RETURN
;==========================================================================================================
OnClickCreditCards
                    call               ViewCreditCards using Cust.CustomerID
                    setfocus           WMain
                    return
;==========================================================================================================
OnKeyPressCountry
                   F2Search          ECustCountry,Cntry

;==========================================================================================================
                   include           MenuDefs.INC


;=============================================================================;
;       created by:  chiron software & services, inc.                         ;
;                    4 norfolk lane                                           ;
;                    bethpage, ny  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  program:    customersearch                                                 ;
;                                                                             ;
;   author:    harry rathsam                                                  ;
;                                                                             ;
;     date:    12/03/2018 at 9:08am                                           ;
;                                                                             ;
;  purpose:    Include file that is used to search for Customers              ;
;                                                                             ;
; revision:    ver     date     init       details                            ;
;                                                                             ;
;              1.0   12/03/2018   hor     initial version                     ;
;                                                                             ;
;                                                                             ;
;=============================================================================;

DisplayLoaded       form               1


FCustomerSearch     plform             SearchCustomer
FCustSearchResults  plform             SearchCust2

SearchName          like               Cust.Name
SearchState         like               Cust.St
SearchCity          like               Cust.City
SearchAddress       like               Cust.Addr1
SearchZip           like               Cust.Zip
SearchTelephone     like               Cust.Telephone

AAmdexKey           dim                255
IncludeCancelled    form               1

AddressColl         collection         AddressColl,ESearchAddress,ESearchCity,ESearchState,ESearchZip
                    goto               #S
;==========================================================================================================
LoadCustomerSearch
                    formload           FCustomerSearch
                    formload           FCustSearchResults
                    LISTINS           AddressColl,ESearchName,ESearchAddress,ESearchCity,ESearchState,ESearchZip
                    call               ResetCustomerSearch

                    return
;==========================================================================================================
ResetCustomerSearch
                    setprop            AddressColl,text=""
                    ESearchTelephone.Clear
                    ESearchName.Clear
                    SETFOCUS          ESearchName
                    LVSearchCustPLB.DeleteAllItems
                    return
;==========================================================================================================
SearchCustomers
                    clear              DisplayLoaded
                    SETPROP            WSearch,visible=1
                    return             if (CancelFlag)
                    return
;==========================================================================================================
LoadCustomerSearchWindowAgain
                    clear              DisplayLoaded
                    call               ResetCustomerSearch
                    call               LoadCustomerSearchWindow
                    return
;==========================================================================================================
LoadCustomerSearchWindow
                    if                 (DisplayLoaded = 0)
                      setfocus           ESearchName
                      setprop            WCustomerSearch,visible=1
                    else
                      set                DisplayLoaded
                    endif
                    return
;==========================================================================================================
SearchItems

                    LVSearchCustPLB.DeleteAllItems
                    CLEAR             CustKY2
                    getprop                ESearchName,text=SearchName
                    getprop                ESearchTelephone,text=SearchTelephone
                    getprop                ESearchAddress,text=SearchAddress
                    getprop                ESearchCity,text=SearchCity
                    getprop                ESearchState,text=SearchState
                    getprop                ESearchZip,text=SearchZip
                    getprop                CBIncludeCancelled,value=IncludeCancelled

                    pack               CustAAMKY1 from "01L",SearchName
                    pack               CustAAMKY2 from "02L",SearchAddress
                    pack               CustAAMKY3 from "03L",SearchCity
                    pack               CustAAMKY4 from "04L",SearchState
                    pack               CustAAMKY5 from "05L",SearchZip
                    pack               CustAAMKY6 from "06L",SearchTelephone

                    read                 CustA1,CustAAMKY1,CustAAMKY2,CustAAMKY3,CustAAMKY4,CustAAMKY5,CustAAMKY6;Cust
                    if                   (not over)
                      CALL              InsertDataIntoListView

                      LOOP
                        readkg               CustA1;Cust
                      UNTIL             (over)
                        continue          if (IncludeCancelled = 0 and Cust.InActive = 1)
                        CALL              InsertDataIntoListView
                      REPEAT
                      LVSearchCustPLB.SortColumn using *Column=1,*Type=11     //HR 10/13/2011
                      setfocus          LVSearchCustPLB
                      LVSearchCustPLB.SetItemState using *Index=0,*State=03,*StateMask=03
                      SETPROP           WCustomerSearch,visible=0
                    else
                    alert              note,"No Records found.  Please try your search again",result,"NO RECORDS FOUND"
                    setfocus           ESearchName

                    endif

                    return

;              ENDIF
;
; By Address Search
;
;              CLEAR             CustKY2
;              GETITEM           RAddress,0,result
;
;              IF                (result = 1)                   //Search by Name
;                getprop                ESearchName,text=CustKY2
;                getprop                ESearchAddress,text=SearchAddress
;                getprop                ESearchCity,text=SearchCity
;                getprop                ESearchState,text=SearchState
;                getprop                ESearchZip,text=SearchZip
;
;                chop                   CustKY2,CustKY2
;                chop                   SearchAddress,SearchAddress
;                chop                   SearchCity,SearchCity
;                chop                   SearchState,SearchState
;                chop                   SearchZip,SearchZip
;
;                call                   RDCust2
;                LOOP
;                  CALL              KSCust2
;                UNTIL             (ReturnFl = 1)
;                  MATCH             CustKY2,Cust.Name
;                  BREAK             if (Not Equal)
;
;                  IF                (SearchAddress != "")
;                    SCAN              SearchAddress,Cust.Addr1
;                    CONTINUE          if (NOT EQUAL)
;                  ENDIF
;
;                  IF                (SearchCity != "")                      //HR 12.15.2011
;                    SCAN              SearchCity,Cust.City                     //HR 12.15.2011
;                    CONTINUE          if (NOT EQUAL)                    //HR 12.15.2011
;                  ENDIF
;
;                  IF                (SearchState != "")                        //HR 12.15.2011
;                    SCAN              SearchState,Cust.St                      //HR 12.15.2011
;                    CONTINUE          if (NOT EQUAL)                    //HR 12.15.2011
;                  ENDIF
;
;                  CALL              InsertDataIntoListView
;                REPEAT
;                 LVSearchCustPLB.SortColumn using *Column=1,*Type=11     //HR 10/13/2011
;              ENDIF

;
; By Telephone Number Search
;
;              GETITEM           RTelephone,0,result
;              IF                (result = 1)                   //Search by Name
;                CLEAR             CustKY4
;                getprop                ESearchTelephone,text=CustKY4
;                CALL              RDCust4
;
;                LOOP
;                  CALL              KSCust4
;                UNTIL             (ReturnFl = 1)
;                  MATCH             CustKY4,Cust.Telephone
;                  BREAK             if (Not Equal)
;
;                  CALL              InsertDataIntoListView
;                REPEAT
;                LVSearchCustPLB.SortColumn using *Column=1,*Type=11     //HR 10/13/2011
;              ENDIF
;
;                    SETPROP           WCustomerSearch,visible=0
;.                    RETURN            IF (result = 1)
;                    return
;;==========================================================================================================
CloseResultsWindow
                    display            "Clsoing Results Window"

                    setprop            WSearch,visible=0
                    return
;==========================================================================================================
CloseSearchWindow
                    display            "Clsoing Search Window"
                    setprop            WCustomerSearch,visible=0
                    return
;==========================================================================================================
InsertDataIntoListView
LastDeliveryDate    dim                10
                    chop               Cust.LastDeliveryDate,Cust.LastDeliveryDate
                    if                 (Cust.LastDeliveryDate != "")
                      unpack             Cust.LastDeliveryDate into cc,yy,mm,dd
                      pack               LastDeliveryDate from mm,"-",dd,"-",yy
                    else
                      clear              LastDeliveryDate
                    endif

                    chop               Cust.City,Cust.City
                    chop               Cust.St,Cust.St
                    chop               Cust.Name,Cust.Name

                    LVSearchCustPLB.InsertItemEx using *Text=Cust.CustomerID:
                                                       *SubItem1=Cust.Name:
                                                       *SubItem2=Cust.City:
                                                       *SubItem3=Cust.St:
                                                       *SubItem4=Cust.Zip:
                                                       *SubItem5=LastDeliveryDate

                    return
;=============================================================================
ItemSelected
              LVSearchCustPLB.GetNextItem giving result using *Start=FirstRow:
                                                       *Flags=02
              IF                (result != -1)                    //We have an item
                LVSearchCustPLB.GetItemText giving $SearchKey using *Index=result,*SubItem=0
                MOVE            "Y",PassedVar
              ELSE
                MOVE              "N",PassedVar
              ENDIF
              setprop                  WSearch,visible=0
              RETURN
;==========================================================================================================
#S

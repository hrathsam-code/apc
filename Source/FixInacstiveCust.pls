;=============================================================================;
;       created by:  chiron software & services, inc.                         ;
;                    4 norfolk lane                                           ;
;                    bethpage, ny  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  program:    fixinacstivecust                                                   ;
;                                                                             ;
;   author:    harry rathsam                                                  ;
;                                                                             ;
;     date:    07/19/2019 at 1:48pm                                             ;
;                                                                             ;
;  purpose:                                                                   ;
;                                                                             ;
; revision:    ver     date     init       details                            ;
;                                                                             ;
;              1.0   07/19/2019   hor     initial version                     ;
;                                                                             ;
;                                                                             ;
;=============================================================================;

                    include            WorkVar.inc

                    include            Cust.FD
                    include            CHST.FD

InputCounter        form               4

                    call               OpenCust
                    call               OpenCHST

                    move               " ",CustKY
                    call               RDCust

                    loop
                    call               KSCust

                    until (ReturnFl = 1)
                    incr               InputCounter
                    display            *P10:10,"Input Counter : ",InputCounter
                    packkey            ChstKY from $Entity,Cust.CustomerID,"2008"
                    call               RDChst
                    call               KSCHST
                    continue           if (ReturnFl = 0 and CHST.CustomerID = Cust.CustomerID )  //We have a record, ignore this
                    if                 (ReturnFl = 1 or (ReturnFl = 0 and CHST.CustomerID != Cust.CustomerID))
                      move               "0",Cust.Inactive
                    call               UPDCust
                    endif


;
; We've got an old record
;

UPDCounter          form               6
                    add                "1",UpdCounter

                    move               "1",Cust.InActive
                    call               UPDCust
                    display            *P10:12,"Customer : ",Cust.CustomerID,"   Update Counter : ",UpdCounter
..                    debug
                    repeat


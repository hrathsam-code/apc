;=============================================================================;
;       created by:  chiron software & services, inc.                         ;
;                    4 norfolk lane                                           ;
;                    bethpage, ny  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  program:    convshipto                                                   ;
;                                                                             ;
;   author:    harry rathsam                                                  ;
;                                                                             ;
;     date:    05/23/2019 at 2:35pm                                             ;
;                                                                             ;
;  purpose:                                                                   ;
;                                                                             ;
; revision:    ver     date     init       details                            ;
;                                                                             ;
;              1.0   05/23/2019   hor     initial version                     ;
;                                                                             ;
;                                                                             ;
;=============================================================================;

                    include            WorkVar.INC
                    include            Sequence.FD
                    include            Cust.FD
                    include            ShipTo.FD

                    call               OpenCust
                    call               OpenShipTo

                    move               " ",CustKY
                    call               RDCust

                    loop
                    call               KSCust
                    until              (ReturnFl = 1)
                      move               Cust.Name,ShipTo.Name
                      move               Cust.CustomerID,ShipTo.CustomerID
                      move               Cust.Addr1,ShipTo.Addr1
                      move               Cust.Addr2,ShipTo.Addr2
                      move               Cust.Addr3,ShipTo.Addr3
                      move               Cust.City,ShipTo.City
                      move               Cust.St,ShipTo.St
                      move               Cust.Zip,ShipTo.Zip
                      move               Cust.Country,ShipTo.Country
                      move               Cust.Telephone,ShipTo.Telephone
                      move               Cust.Fax,ShipTo.Fax
                      move               Cust.Telephone,ShipTo.Telephone
                      move               "1",ShipTo.SeqNo
                      call               WrtShipTo
                    repeat

;=============================================================================;
;       created by:  chiron software & services, inc.                         ;
;                    4 norfolk lane                                           ;
;                    bethpage, ny  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  program:    custtrack                                                      ;
;                                                                             ;
;   author:    harry rathsam                                                  ;
;                                                                             ;
;     date:    09/06/2019 at 2:57pm                                           ;
;                                                                             ;
;  purpose:    Allow Entry of Purchase Order Number                           ;
;                                                                             ;
; revision:    ver     date     init       details                            ;
;                                                                             ;
;              1.0   09/06/2019   hor     initial version                     ;
;                                                                             ;
;                                                                             ;
;=============================================================================;

                   include           WorkVar.inc
PurchaseOrder      dim               20


Main               plform            CustTrack.plf

                   formload          Main
                   setfocus          ECustomerPO

                   winhide
                   loop
                     waitevent
                   repeat
;==========================================================================================================
GetPO
                   getprop           ECustomerPO,text=PurchaseOrder
                   call              ViewUPS using PurchaseOrder
                   setprop           ECustomerPO,text=""
                   setfocus          ECustomerPO
                   return
;==========================================================================================================
ExitProgram
                   stop


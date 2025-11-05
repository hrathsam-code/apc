;=============================================================================;
;       created by:  chiron software & services, inc.                         ;
;                    4 norfolk lane                                           ;
;                    bethpage, ny  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  program:    fixcustphones                                                   ;
;                                                                             ;
;   author:    harry rathsam                                                  ;
;                                                                             ;
;     date:    08/27/2019 at 2:13pm                                             ;
;                                                                             ;
;  purpose:                                                                   ;
;                                                                             ;
; revision:    ver     date     init       details                            ;
;                                                                             ;
;              1.0   08/27/2019   hor     initial version                     ;
;                                                                             ;
;                                                                             ;
;=============================================================================;

                   include           WorkVar.inc
                   include           Phone.FD
                   include           Cust.Fd

                   call              OpenCust
                   call              OpenPhone

                   move              " ",PhoneKY
                   call              RDPhone

                   loop
                     call              KSPhone
                   until (ReturnFl =1)
                   move              PhoneREC.ContactID,CustKY
                     call              RDCust
                     continue          if (ReturnFl = 1)

                     switch            PhoneREC.PhoneType
                     case              "1"
                       move              PhoneREC.Number,Cust.Telephone
                     case              "2"
                       move              PhoneREC.Number,Cust.Fax
                     endswitch
                     call              UPDCust
                   repeat

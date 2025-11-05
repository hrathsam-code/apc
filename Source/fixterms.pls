;=============================================================================;
;       created by:  chiron software & services, inc.                         ;
;                    4 norfolk lane                                           ;
;                    bethpage, ny  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  program:    fixTerms                                                       ;
;                                                                             ;
;   author:    harry rathsam                                                  ;
;                                                                             ;
;     date:    02/27/2019 at 3:25pm                                           ;
;                                                                             ;
;  purpose:                                                                   ;
;                                                                             ;
; revision:    ver     date     init       details                            ;
;                                                                             ;
;              1.0   02/27/2019   hor     initial version                     ;
;                                                                             ;
;                                                                             ;
;=============================================================================;

                    include            workvar.inc
                    include            Vendor.FD

                    call               OpenVendor
                    move               " ",VendorKY
                    call               RDVendor

                    loop
                      call               KSVendor
                    until              (ReturnFl = 1)
                      move               "NET30",Vendor.TermCode
                      call               UPDVendor
                    repeat

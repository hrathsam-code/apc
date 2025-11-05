;=============================================================================;
;       created by:  chiron software & services, inc.                         ;
;                    4 norfolk lane                                           ;
;                    bethpage, ny  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  program:    fixvendgl                                                   ;
;                                                                             ;
;   author:    harry rathsam                                                  ;
;                                                                             ;
;     date:    02/27/2019 at 3:25pm                                             ;
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

                    call               OpenVendorGL
                    move               " ",VendorGLKY
                    call               RDVendorGL

                    loop
                    call               KSVendorGL
                    until (ReturnFl = 1)
                    move               "4101",VendorGL.GLCode
                    call               UPDVendorGL
                    repeat

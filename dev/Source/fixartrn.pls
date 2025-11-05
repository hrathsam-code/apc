;=============================================================================;
;       created by:  chiron software & services, inc.                         ;
;                    4 norfolk lane                                           ;
;                    bethpage, ny  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  program:    fixartrn                                                   ;
;                                                                             ;
;   author:    harry rathsam                                                  ;
;                                                                             ;
;     date:    07/30/2019 at 9:18pm                                             ;
;                                                                             ;
;  purpose:                                                                   ;
;                                                                             ;
; revision:    ver     date     init       details                            ;
;                                                                             ;
;              1.0   07/30/2019   hor     initial version                     ;
;                                                                             ;
;                                                                             ;
;=============================================================================;

                    include            workvar.inc
                    include            ARTRN.FD
                    include            ARDet.FD

InputCounter        form               7
InputFile           file

                    call               OpenARTRN
                    call               OpenARDet

                    open               InputFile,"ARTRNFL.TXTBeforeConversion"
                    loop
                      read               InputFile,seq;ARTRN
                    until (over )
                    add                "1",InputCounter
                    display            *P10:10,"Input Counter : ",InputCounter
                    continue           if (ARTRN.EntryDate <= "20190708" or ARTRN.CustomerID = "1016  ")

                      call               WRTARTrn
                    repeat

;=============================================================================;
;       created by:  chiron software & services, inc.                         ;
;                    4 norfolk lane                                           ;
;                    bethpage, ny  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  program:    testhttp2                                                   ;
;                                                                             ;
;   author:    harry rathsam                                                  ;
;                                                                             ;
;     date:    08/15/2019 at 3:35pm                                             ;
;                                                                             ;
;  purpose:                                                                   ;
;                                                                             ;
; revision:    ver     date     init       details                            ;
;                                                                             ;
;              1.0   08/15/2019   hor     initial version                     ;
;                                                                             ;
;                                                                             ;
;=============================================================================;

                    include            WorkVar.inc

Response             DIM               100

HostName             INIT               "tycho.usno.navy.mil"

ResourcePath         INIT              "GET /cgi-bin/timer.pl HTTP/1.0",0x0D,0x0A,0x0D,0x0A

                    HTTP               HostName,ResourcePath,*Flags=1,*Result=Response




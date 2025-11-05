;=============================================================================;
;       created by:  chiron software & services, inc.                         ;
;                    4 norfolk lane                                           ;
;                    bethpage, ny  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  program:    prtlabel                                                   ;
;                                                                             ;
;   author:    harry rathsam                                                  ;
;                                                                             ;
;     date:    05/19/2020 at 12:39pm                                             ;
;                                                                             ;
;  purpose:                                                                   ;
;                                                                             ;
; revision:    ver     date     init       details                            ;
;                                                                             ;
;              1.0   05/19/2020   hor     initial version                     ;
;                                                                             ;
;                                                                             ;
;=============================================================================;


                   include           WorkVar.inc



GraphicImage       dim               30000

LabelFile          file
                   open              LabelFile,"Harry.EPL",read


                   read              LabelFile,seq;*ABSON,*LL,GraphicImage

                   splopen           P,"","R"
                   print             P;*LL,GraphicImage

                   splclose

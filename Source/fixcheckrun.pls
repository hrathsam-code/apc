;==========================================================================================================
;                       created by:  chiron software & services, inc.                                     ;
;                                    4 norfolk lane                                                       ;
;                                   (516) 532-6266                                                        ;
;==========================================================================================================
;                                                                                                         ;
;     $filename::                                                                                        $;
;                                                                                                         ;
;    $developer::                                                                                        $;
;                                                                                                         ;
;     created on:                                                                                         ;
;                                                                                                         ;
;        purpose:                                                                                         ;
;                                                                                                         ;
;     $revision::                                                                                        $;
;                                                                                                         ;
;         $date::                                                                                        $;
;                                                                                                         ;
;                                                                                                         ;
; revision notes:    ver      date       user                details                                      ;
;                   -----   ----------    ----    ---------------------------------                       ;
;                    1.0    2020.07.10    hor       initial version                                       ;
;                                                                                                         ;
;                                                                                                         ;
;                                                                                                         ;
;                                                                                                         ;
;==========================================================================================================
;
                   include           workvar.inc

              INCLUDE           Checkrun.FD
CheckFile     FILE
InpCount      FORM              7
UpdCount      FORM              7

..              CALL              OpenCheck
..              CALL              OpenCheckDetail
                    call               OpenCheckRun

              LOOP
                call                   KSCheckRun
              UNTIL             (ReturnFl = 1)
                    continue           if (CheckRun.CheckNo > 100)

                DISPLAY           *P10:10,"Input Count : ",InpCount
                add               "23183",CheckRun.CheckNo
                call                   UPDCheckRun
                ADD               "1",UpdCount
                DISPLAY           *P10:12,"Update Count : ",UpdCount
                MOVE              " ",CheckRunKY
                call                   RDCheckRun
              REPEAT

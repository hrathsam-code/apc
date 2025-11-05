;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    4 NORFOLK LANE                                           ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    CNVDIST.PLS                                                 ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    07/13/2005 AT 3:29AM                                           ;
;                                                                             ;
;  PURPOSE:    Convert older A/P GL Distribution Records                      ;
;                                                                             ;
; REVISION:    VER     DATE     INIT       DETAILS                            ;
;                                                                             ;
;              1.0   07/12/2005   HOR     INITIAL VERSION                     ;
;                                                                             ;
;=============================================================================;

              INCLUDE           Workvar.INC

              INCLUDE           Sequence.FD

              INCLUDE           APDIST.FD

OldGLMSTFL    FILE
APPaidFL      FILE

OldDist       RECORD
CODE          DIM               6
DESCription   DIM               20
              RECORDEND



              CALL              OpenAPDist

                move                   " ",APDistKY3

                CALL              RDAPDist3

                LOOP
                  CALL              KSAPDist3
                UNTIL             (ReturnFL = 1)
                  CONTINUE             if (APDist.TransDate < "20190229")
                  continue             if (APDist.CreditAmount >= 0 and APDist.DebitAmount >= 0)

Harry1
                  if                   (APDist.CreditAmount < 0)
                  mult                 "-1",APDist.CreditAmount
                  endif

                  if                   (APDist.DebitAmount < 0)
                  mult                 "-1",APDist.DebitAmount
                  endif

                  CALL              UPDAPDist
                  MOVE              "Y",FirstFlag
                REPEAT
              KEYIN             *P1:24,*EL,"Finished",result

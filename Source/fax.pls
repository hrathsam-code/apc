;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    4 NORFOLK LANE                                           ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    FAX.PLS                                                        ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    07/21/2004 AT 2:11PM                                           ;
;                                                                             ;
;  PURPOSE:    Fax Software module                                            ;
;                                                                             ;
; REVISION:    VER     DATE     INIT       DETAILS                            ;
;                                                                             ;
;              1.0   09/21/2004   HOR     INITIAL VERSION                     ;
;                                                                             ;
;=============================================================================;

              INCLUDE           WorkVar.INC

FaxPort       INIT              "4559"
ServerAddr    INIT              "192.168.10.187"
Mode          INIT              "R"
UserName      INIT              "Harry"
Commsg        DIM               256
tmout         FORM              "20"
crlf          INIT              0x0d,0x0a ; use init because order is important
lf            INIT              0x0a
response      DIM               4
FaxCmdStatus  DIM               3
FaxJob        DIM               3
FaxNumber     INIT              "2738088"
#FaxNumber    DIM               10
MaxDials      FORM              "5"                 //HR 9/28/04 Changed from 03
MaxAttempts   FORM              "5"                 //HR 9/28/04 Changed from 03
Quote         INIT              34
#FaxTimeToSend DIM              ^
Dim30         DIM               28
FaxJobID      DIM               3
LocalIP       INIT              "192.168.10.27"
FTPServer     INIT              "192.168.10.187"
user          INIT              "harry"
pass          INIT              "tim1156"
#FTPFileName  DIM               40
..SEQEof        FORM              "-3"
StatusTime    DIM               20
#FaxSubject   DIM               ^
FaxAuditFL    FILE
ComCloseMode  FORM              "1"
FaxFile       FILE              ^
FaxCommand    DIM               250
#SubmitFaxNo  DIM               12
InvalidChars  INIT              39,32                      //HR 1/29/2007
FaxShortTitle DIM               39                         //HR 3/20/2013

CreateFax     ROUTINE           #FTPFileName,#FaxNumber,#FaxTimeToSend,#FaxSubject,FaxFile
;
; Connect into the Fax Server using specified Port
;
                    OPEN               FaxAuditFL,"Faxaudit.txt"
                    write              FaxAuditFL,SEQEof;"FileName :",#FTPFileName:
                                                         "   Fax Number :",#FaxNumber:
                                                         "   Fax Time :",#FaxTimeToSend:
                                                         "   Fax Subject :",#FaxSubject

                    PACK               #SubmitFaxNo FROM "1",#FaxNumber

                    REPLACE            InvalidChars,#FaxSubject             //HR 1/29/2007
                    MOVE               "1",MaxAttempts
                    MOVE               #FaxSubject,FaxShortTitle

                    PACK               FaxCommand FROM "sendfax -a ",#FaxTimeToSend," ":
                                                       "-E ":                              //Error Correction Mode
                                                       "-m ":                              //Vres =196
                                                       "-n ":                              //No Cover Page
                                                       "-P 127 ":                          //Scheduled Priority
                                                       "-i '",FaxShortTitle,"' ":            //Fax Subject
                                                       "-t ",MaxAttempts," ":              //Maximum Attempts
                                                       "-T ",MaxDials," ":                 //Maximum # of dials
                                                       "-k now+48hours ":                  //Maximum
                                                       "-d ",#SubmitFaxNo," ":             //Fax Number
                                                       "/var/spool/hylafax/tmp/",#FTPFileName

                    WRITE              FaxFile,SeqEOF;*LL,FaxCommand,lf;
                    RETURN

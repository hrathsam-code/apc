;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    4 NORFOLK LANE                                           ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    SENDMAIL.PLS                                                   ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    07/13/2004 AT 2:20AM                                           ;
;                                                                             ;
;  PURPOSE:                                                                   ;
;                                                                             ;
; REVISION:    VER     DATE     INIT       DETAILS                            ;
;                                                                             ;
;              1.0   07/13/2004   HOR     INITIAL VERSION                     ;
;              1.2   04/19/2014   HOR     Modified to use external SMTP Server;
;                                                                             ;
;=============================================================================;
                Include Smtp.PRI  (PRI - Profile Routine Interface)

Mess    Dim     250
F1      Form    1
NewLine Init    0x7F

EmailAddress  DIM               ^
EmailName       DIM               ^
EmailDirectory  INIT            "F:\DATA"
EmailAttachment DIM             ^
FullBodyText       DIM               4096             //HR 11.13.2014

StartSendingEMail
              move              "american1953",SmtpPassword
              Move              "mail.apccomponents.com",SmtpEmailServer
              Move              "accounting@apccomponents.com",SmtpEmailAddress
              Move              "accounting@apccomponents.com",SmtpUserName
              Move              "APC Components",SmtpUserFullName

.   Set the subject that will be applied to the email message

              Move              "APC Components Inc. Invoicing",SmtpSubject

.   Set the text message that is send with the attachments


CRLF          INIT              13,10

              Move              "0",SmtpDispMode                                       Display log file
              Move              "F:\DATA\email.log",SmtpLogFile        Path/filename to Log all socket read/writes  //HR 9.2.2014

              pack              FullBodyText FROM "Please find enclosed Invoice sent from APC Components, Inc. ":
                                                  CRLF,CRLF:
                                                  "APC Components, Inc."

              Move              "0",SmtpProgress                                       Enable progress bars

.   Send the above eMail to the destination which happens to be myself
.   If any errors detected the error code and human readable text is given

OutboundFile  DIM                    125
ErrorData     dim                    300
InvalidAddress DIM                   300

Harry1
                    DEBUG
                    MAILSEND          SmtpEmailServer,EmailAddress,SmtpEmailAddress:
                                      SmtpSubject,FullBodyText:
                                      *Attachment=OutboundFile:
                                      *ERROR=ErrorData:
                                      *port=465:
                                      *openSSL:
                                      *user="sales@apccomponents.com":
                                      *password="american1953"

                    call                     SendEMailError if (not ZERO)
                    RETURN
;==========================================================================================================
SendEMailError
                    pack               SmtpSubject from "An error has occured trying to send an E-mail to :",EmailAddress
                    pack               FullBodyText from "An error has occured sending an E-mail to the above address.":
                                       "Please reference the Invoice contained and report the error : ",ErrorData

                    MAILSEND           SmtpEmailServer,"sales@apccomponents.com",SmtpEmailAddress:
                                       SmtpSubject,FullBodyText:
                                       *Attachment=OutboundFile:
                                       *port=465:
                                       *openSSL:
                                       *user="sales@apccomponents.com":
                                       *password="american1953"
                    return

.=============================================================================
SendMail      ROUTINE           EMailAddress,EmailName,EMailAttachment
              Move              EMailAddress,SmtpDestinations(1,1)      Destination e-mail addr
              Move              EMailName,SmtpDestinations(1,2)         Destination UserName

              MOVE              EMailDirectory,SmtpAttachments(1,2)
              MOVE              EMailAttachment,SmtpAttachments(1,1)
              move              EMailAttachment,OutBoundFile

              Move              "1",SmtpAttIndexLast         Index to last entry - Only 1 entry

              CALL              StartSendingEmail
              RETURN



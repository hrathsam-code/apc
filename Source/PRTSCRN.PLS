              INCLUDE           WORKVAR.INC

#Window       WINDOW            ^
PrinterHandle INTEGER           4
Pict1         PICT
#PrintDate    DIM               10
.              INCLUDE           StateTbl.TXT
.              INCLUDE           Cust.FD

StartProgram  ROUTINE           #Window

                   include           Sequence.FD
              INCLUDE           PrintRtn.inc

                   call              OpenSequence

              CALL              PrintPreviewInit
              RETURN            IF (PrintInitFailed = "N")

..              GETFILE           P,HDC=PrinterHandle
              CLOCK             Date,#PrintDate

              #Window.FormToPict giving Pict1
              PRTPAGE           P;*P=20:10,*BoldOn,"Print Date : ",#PrintDate,*BoldOff
              PRTPAGE           P;*PICT=30:580:10:770:Pict1         //HR Was 770

              CALL              PrintClose
              RETURN

PrintCustomHeader
              RETURN

*******************************************************************************
*                                                                             *
*     Program Name         : WinSock.Rtn Version 1.1                          *
*                                                                             *
*     For ROUTINE .PLC     : WinSock.PLC ( Source is WinSock.Rtn )            *
*                                                                             *
*     Type of program      : Windows socket driver for Plb                    *
*                                                                             *
*     Use                  : To interface to Winsock.Plc                      *
*                                                                             *
*     Author               : Festus Redelinghuys - plbsa@icon.co.za           *
*                                                                             *
*     Date                 : 01 November 1998                                 *
*                                                                             *
*     Copyright            : Freeware                                         *
*                                                                             *
*******************************************************************************
                           SetFlag Equal                  ( Remove warning from compiler)
                           Goto    JumpWinSock If Equal   ( Avoid invalid entry)

.   Variable types and sizes used by CALLS
.   All variables initialized with values("xx") are the defaults for that variable
.   If the default for the variable is acceptable then you don't have to change it
.   Values that are not quoted (" ") need not to be changed at all exept where
.   indicated by an "*" which MUST be changed/set.
.   There are two sockets available: Socket 1 is a Telnet type   - Smtp & Ftp
.                                  : Socket 2 is a Ftp Data type - Ftp
.   The default socket is selected by SocketCurrent and is 1

SocketStatus           Form           2                          ROUTINE return status
SocketStatusText       Dim            80                         Human readable text for above code
SocketHostIP           Dim            60(2)                      *Host IP number OR Name
SocketPort             Form           5(2)                       *'LISTEN' Port number
SocketMethod           Dim            1(2),("O"),("O")           O=Open,C=Create
SocketPacketType       Dim            1(2),("R"),("R")           R=Raw,C=Cooked
SocketReadRetry        Form           6(2),("000150"),("000150") 150 Loops * 200 Millisecond delays = 30 sec
SocketWriteRetry       Form           6(2),("000150"),("000150") 150 Loops * 200 Millisecond delays = 30 sec
SocketszRxBuffer       Form           4(2),("1024"),("1024")     Rx buffer size(Change size here)
SocketszTxBuffer       Form           4(2),("1024"),("1024")     Tx buffer size(Change size here)
SocketRxBuffer         Dim            4096(2)                    Receive buffer(do not change size)
SocketTxBuffer         Dim            4096(2)                    Transmit buffer(do not change size)
SocketLogFile          Dim            260                        Valid path/filename of log
SocketDispMode         Form           1                          Display Logfile entries as they are made
SocketETX              Dim            2(2),(0x0D),(0x0A)         Read End of TeX characters - CRLF
SocketFilter           Dim            2(2),(0x0D),(0x0A)         Read filter out characters - CRLF
SocketTime             Form           2(2),("09"),("09")         Read timeout between characters(3)
s                      Form           "1"                        Current selected socket-default
SocketEventCheck       Form           "0"                        Do EventCheck in loop,0=No(Default),1=yes
KeepListen             Form           10(2)                      On ComClose, 0=Close completely,1=Close but keep listen open

.   Notes:
.   1. If the comport is not ready or is busy read/writes can be put in a loop
.      to wait for the port to become ready. A delay timer of 100 Milliseconds
.      has been build in. The delay component is a WinApi routine which uses
.      the SleepEx routine from kernel32.Dll. The properties of SleepEx is
.      very low system overhead achieved by SleepEx giving up multi tasking
.      time slicing for the duration of the delay( 100 Milliseconds)
.      Comport activity would activate SleepEx whether the 100
.      millisecond timeout has elapsed or not.This method is far more effective
.      than using any loops to create a delay.
.   2. Port - Ports 0-4999 has already been allocated or has been reserved
.           - Use port number 5000+ for custom servers
.           - Use port 25 for e-mail servers
.   3. RxBuffer and TxBuffer. Keep the variable declararion of these two
.      variables at 4096 (Max buff size) and change szRxBuffer and szTxBuffer
.      if you need smaller buffer sizes.

.   Until SocketConnect has not been called, which also initializes the variable
.   pointers of the Winsock.Rtn, can NO other entry point that uses the variables
.   that is initialized by SocketConnect, be used.

SocketVariables Form            1(2)            0=Variables not initialized
.                                               1=Variables initialized ok

.   Error codes returned from winsock
.   Values returned in SocketStatus

.   "00 - Error Unknown                                                              ":
.   "01 - Successfull, NO errors                                                     ":
.   "02 - Reserved - For use by other application ( Eq. Smtp )                       ":
.   "03 - Reserved                                                                   ":
.   "04 - Host IP is invalid. ( LP=0)                                                ":
.   "05 - Server 'Listen' port number invalid ( port = 0)                            ":
.   "06 - Server 'Listen' port number invalid ( port = EOS)                          ":
.   "07 - Invalid port open method. Must be 'O' or 'C'                               ":
.   "08 - Invalid data packet type. Must be 'R' or 'C'                               ":
.   "09 - Invalid buffer sizes. Buffer sizes must be equal or less than 4096         ":
.   "10 - Invalid communication port parameters                                      ":
.   "11 - Connection error during connection - Socket error                          ":
.   "12 - Socket not open when it should have been                                   ":
.   "13 - Socket not open when it should have been                                   ":
.   "14 - Not connected when connection should have been                             ":
.   "15 - Socket error during last read                                              ":
.   "16 - Socket error during last read                                              ":
.   "17 - Socket/line was dropped during last reception                              ":
.   "30 - Socket not open during write                                               ":
.   "31 - Connection lost during transmission                                        ":
.   "32 - Socket error during write                                                  ":
.   "33 - Error during last write                                                    ":
.   "34 - Socket/line was dropped during last transmission                           ":
.   "35 - WinSock.Rtn variable pointers NOT initialized,Call SocketConnect first.    "

...............................................................................
.   Connect - Connect to the TCP/IP server
SocketConnect

.   Format to our required buffer size

               Sformat         SocketRxBuffer(s),SocketszRxBuffer(s)
               Sformat         SocketTxBuffer(s),SocketszTxBuffer(s)

.   Connect the Winsock
               If               ( s = 1 )
                CALLS           "Winsock.PLC;Connect1" Using SocketStatus:
                                SocketStatusText:         Human readable text for above code
                                SocketHostIP(1):          Host IP number
                                SocketPort(1):            'LISTEN' Port number
                                SocketMethod(1):          O=Open,C=Create
                                SocketPacketType(1):      R=Raw,C=Cooked
                                SocketReadRetry(1):       Loop counter
                                SocketWriteRetry(1):      Loop counter
                                SocketRxBuffer(1):        Receive buffer
                                SocketTxBuffer(1):        Transmit buffer
                                SocketszRxBuffer(1):      RxBuffer size
                                SocketszTxBuffer(1):      TxBuffer size
                                SocketLogFile:            Log all IO
                                SocketDispMode:           Display Logfile entries as they are made
                                SocketETX(1):             Read End of TeX characters
                                SocketFilter(1):          Read filter out characters
                                SocketTime(1):            Read timeout between characters(3)
                                s:                        Current selected socket
                                SocketEventCheck:         Do EventCheck in loop,0=No(Default),1=yes
                                KeepListen(1)             On ComClose, 0=Close completely,1=Close but keep listen open
               Else
                CALLS           "Winsock.PLC;Connect2" Using SocketStatus:
                                SocketStatusText:         Human readable text for above code
                                SocketHostIP(2):          Host IP number
                                SocketPort(2):            'LISTEN' Port number
                                SocketMethod(2):          O=Open,C=Create
                                SocketPacketType(2):      R=Raw,C=Cooked
                                SocketReadRetry(2):       Loop counter
                                SocketWriteRetry(2):      Loop counter
                                SocketRxBuffer(2):        Receive buffer
                                SocketTxBuffer(2):        Transmit buffer
                                SocketszRxBuffer(2):      RxBuffer size
                                SocketszTxBuffer(2):      TxBuffer size
                                SocketLogFile:            Log all IO
                                SocketDispMode:           Display Logfile entries as they are made
                                SocketETX(2):             Read End of TeX characters
                                SocketFilter(2):          Read filter out characters
                                SocketTime(2):            Read timeout between characters(3)
                                s:                        Current selected socket
                                SocketEventCheck:         Do EventCheck in loop,0=No(Default),1=yes
                                KeepListen(2)             On ComClose, 0=Close completely,1=Close but keep listen open
               Endif

                Move            "1",SocketVariables(s)    Variable pointers NOW initialized

                If              ( SocketStatus != "1" )
                 SetFlag        Not Equal
                 RETURN                                   Return with flag
                Else
                 SetFlag        Equal
                 RETURN                                   Return with flag
                Endif
...............................................................................
.   Read a buffer of data from the server
.
SocketRead
                If              ( SocketVariables(s) = 0 ) Variables initialized?
                 Move           "35",SocketStatus          Set error code
                 Setflag        Not Equal                  This routine call failed
                 RETURN
                Endif

                CALLS           "Winsock.PLC;Read"
                If              ( SocketStatus != "1" )
                 SetFlag        Not Equal
                 RETURN                                    Return with flag
                Else
                 SetFlag        Equal
                 RETURN                                    Return with flag
                Endif
...............................................................................
.   Write a buffer of data to the server
SocketWrite
                If              ( SocketVariables(s) = 0 )  Variables initialized?
                 Move           "35",SocketStatus           Set error code
                 Setflag        Not Equal                   This routine call failed
                 RETURN
                Endif

                CALLS           "Winsock.PLC;Write"
                If              ( SocketStatus != "1" )
                 SetFlag        Not Equal
                 RETURN                                     Return with flag
                Else
                 SetFlag        Equal
                 RETURN                                     Return with flag
                Endif
...............................................................................
.   Close the Windows socket.
SocketClose
                If              ( SocketVariables(s) = 0 )  Variables initialized?
                 Move           "35",SocketStatus           Set error code
                 Setflag        Not Equal                   This routine call failed
                 RETURN
                Endif

                CALLS           "Winsock.PLC;CloseSocket"
                If              ( SocketStatus != "1" )
                 SetFlag        Not Equal
                 RETURN                                     Return with flag
                Else
                 SetFlag        Equal
                 RETURN                                     Return with flag
                Endif
...............................................................................
.   Clear the Windows socket.
SocketClear
                If              ( SocketVariables(s) = 0 )  Variables initialized?
                 Move           "35",SocketStatus           Set error code
                 Setflag        Not Equal                   This routine call failed
                 RETURN
                Endif

                CALLS           "Winsock.PLC;ClearSocket"
                If              ( SocketStatus != "1" )
                 SetFlag        Not Equal
                 RETURN                                     Return with flag
                Else
                 SetFlag        Equal
                 RETURN                                     Return with flag
                Endif

...............................................................................
JumpWinSock
.                            End of WinSock.Pri
...............................................................................


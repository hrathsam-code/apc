.
. Sample CGI program to	be invoked from	plbcgi.exe
.
HdrData	Init	"HTTP/1.0 200 OK",0xD,0xA,"Content-Type: text/html":
		0xD,0xA,0xD,0xA:
		"Hello From PL/B", 0xD,	0xA, "REQUEST_METHOD: "
QryStr	Init	0xA, 0xD," QUERY_STRING: ", 0xA, 0xD
StdIn	Init	0xA, 0xD," StdIn Data: ", 0xA, 0xD
Data	Dim	200
Data1	Dim	40
GotData	Form	"0"
 
. Event	1 contains stdin data broken into 200 byte chunks.
 
	EventReg	*Client,1,GetStdData
 
. Event	2 indicates that all stdin data	has been sent
 
	EventReg	*Client,2,DoneStdData
 
. Event	3 is used to return environment	variable data
 
	EventReg	*Client,3,GetEnvData
 
	Loop
	  EventWait
	Repeat		While (GotData = 0 )
 
.
. Get an environment variable by sending an event 2 to plbcgi
.
	EventSend	*Client,2,ARG1="REQUEST_METHOD"
	EventWait
 
.
. Put data into	stdout by sending an event 1 to	plbcgi
.
	EventSend	*Client,1,ARG1=HdrData
	EventSend	*Client,1,ARG1=Data1
 
	EventSend	*Client,2,ARG1="QUERY_STRING"
	EventWait
 
	EventSend	*Client,1,ARG1=QryStr
	EventSend	*Client,1,ARG1=Data1
 
	EventSend	*Client,1,ARG1=StdIn
	EventSend	*Client,1,ARG1=Data
	Stop
 
GetStdData
	EventInfo	0, ARG1=Data
	Return
 
DoneStdData
	Move		"1" To GotData
	Return
 
GetEnvData
	EventInfo	0, ARG1=Data1
	Return

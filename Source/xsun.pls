Response	DIM	2048
 
HostName	INIT	"www.sunbelt-plb.com"
 
ResourcePath	INIT	"/index.php"
 
RichEdit	RICHEDITTEXT
 
	CREATE	RichEdit=1:25:5:75,BdrStyle=2,Scrollbar=1
 
	ACTIVATE	RichEdit
 
	HTTP	HostName:		 ;Cook mode used as default!
		ResourcePath:
		*TRACE="sun_trace.log":	 ;Requires 9.6C
		*Result=Response
 
	SETPROP	RichEdit,Text=Response
 
	LOOP
	 EVENTWAIT
	REPEAT
 

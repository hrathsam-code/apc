.
. Html Control Tester
.
	INCLUDE plbequ.inc
	INCLUDE plbmeth.inc
. 
HtmlCtl		HtmlControl
.
EditForm 		Plform	"hctldesignsun1.pwf"
HtmlForm 		Plform	"hctldesignsun2.pwf"

Client			Client
CliInfo			Dim	1024
.
FullHtml		Dim	64000
DataUni			Dim	64000
JsonData		Dim	200
JsonEvent		XDATA
.
Result		Form	5
CurIndex	Form	5
Info		Dim	30
.
SnipData	Dim	32000
SnipFileName    Dim     270
SnipFile	File
MinusOne	Form	"-1"
Seq		Form	"-1"
Zero            Form	"0"
Rep7F		Init	     "|",0x7F
.
FileName	Dim     270
D1		Dim	1
PrtPict		Pict
PrtFile		PFile
Right		Form	5
Bottom		Form	5
IsWin		Form	"0"
IsUtf8		Form	"0"
PathChar	INIT	"\"
.
NULL		DIM	1
.
...............................................................................
.
HtmlPageBlank		Init   "<html><head>",0xD,0xA:
				"<meta http-equiv='X-UA-Compatible' content='IE=edge' />",0xD,0xA:
				"<style>",0xD,0xA:
				"</style>",0xD,0xA:
				"</head><body>",0xD,0xA:
				"</body></html>",0xD,0xA

snipNames	DIM	32000
.
...............................................................................
.
	WinHide
...
. Check runtime OS type!
. 
	CLOCK	Version, S$CMDLIN
	SCAN	" 10 ", S$CMDLIN		//Unix/Linux?
	IF EQUAL
	 MOVE	"/", PathChar			//Set Unix/Linux path character!
	ENDIF	
.
	Formload	HtmlForm
	Create		Panel1;HtmlCtl=0:0:100:100,DOCK=6,Visible=1,TABID=1
	EventReg	HtmlCtl,200,HtmlEvCtl,ARG1=JsonData

	FormLoad	EditForm
	ListView1.DeleteAllContents
	ListView1.InsertColumnEx Using "type", 100, 0
	ListView1.InsertColumnEX Using "id",	160, 1
	ListView1.InsertColumn Using "pageX", 80, 2
	ListView1.InsertColumn Using "pageY", 80, 3
	ListView1.InsertColumn Using "metaKey", 80, 4
	ListView1.InsertColumn Using "which", 80, 5
	ListView1.InsertColumn Using "targetId", 160, 6

	Call		TemplateReset 

	Client.GetInfo	Giving CliInfo
	Type		CliInfo
	If		Eos
	 SetProp	PrtBtn,Visible=1
	 SetProp	Button3, ENABLED=1		//Enabled under PLBWIN!
	 Move		"1" To IsWin
	Else
	 SetProp	Form2,Visible=0
	Endif

	SETFOCUS	ComboBox1			//ERB
	Loop
		EventWait
	Repeat
	Stop

SaveIt
	Clear		SnipData
	GetProp		EditText2,Text=SnipFileName
	Scan		".snip" Into SnipFileName
	If		Equal
	   Lenset         SnipFileName
	Else 
	   Endset	  SnipFileName
	    Append	  "." To SnipFileName
	Endif
	GetProp		CheckBox1, Value=IsUtf8
	If (IsUtf8 == 0 )
	  GetProp		EditText1,Text=SnipData
	  Append		"snip" To SnipFileName
	Else
	  Append		"snip8" To SnipFileName
	  If (IsWin == 0 )
	    Client.SetUTF8Convert Using 0
	    GetProp		EditText1,Text=SnipData
	    Client.SetUTF8Convert Using 1
	  Else
	    EditText1.GetUnicode Giving DataUni
  	    ConvertUtf DataUni, SnipData, "8"	;Convert Unicode to UTF8
	  EndIf
	Endif
	
	Reset		SnipFileName
	SetProp		EditText2,Text=SnipFileName
	Prep		SnipFile,SnipFileName
	Weof		SnipFile,Zero
	Write		SnipFile,Seq;*LL,*ABSON, SnipData;
	Close		SnipFile
	Return

ResetIt
	SetProp EditText1,Text=HtmlPageBlank
	ListView1.DeleteAllItems

TemplateReset
	FindDir	"htmlsnippets\*.snip*", snipNames, MODE=3
	ComboBox1.ResetContent 
	SetProp EditText1,Text=HtmlPageBlank
	Pack snipNames, snipNames, "|F"
	Loop
		Explode	snipNames, "|", FileName
		Break If Zero
		Unpack FileName Into D1,SnipFileName
		Type SnipFileName
		Break if EOS
		ComboBox1.AddString Using SnipFileName
	Repeat
.
	SETPROP	FORM2, TITLE="HtmlControl Test"		//ERB
	SETPROP	HtmlCtl, InnerHtml=""			//ERB
	SETPROP	EditText2, TEXT=""			//ERB
.
	SETITEM	 ComboBox1, MinusOne, NULL		//ERB
	SETFOCUS ComboBox1				//ERB
.
	Return

LoadTemplate
	ListView1.DeleteAllItems
	EventInfo 0,result=Result
	Sub	"1" From Result
	ComboBox1.GetText Giving FileName Using Result
	pack		SnipFileName Using "htmlsnippets", PathChar, FileName
	Chop		SnipFileName
	SetProp		EditText2,Text=SnipFileName
	Open		SnipFile,SnipFileName
	Read		SnipFile,Seq;*LL,*ABSON, SnipData;
	Close		SnipFile

	Scan		".snip8" Into SnipFileName
	If		Equal
	 Move		"1" To IsUtf8
	Else
	 Move		"0" To IsUtf8
	Endif

	SetProp		CheckBox1, Value=IsUtf8

	If (IsUtf8 == 0 )
	  SetProp		EditText1,Text=SnipData
	Else
	  If (IsWin == 0 )
	    Client.SetUTF8Convert Using 0
	    SetProp		EditText1,Text=SnipData
	    Client.SetUTF8Convert Using 1
	  Else
	    ConvertUtf  SnipData, DataUni, "6"	;Convert input UTF8 to UTF16
	    EditText1.SetUnicode Using DataUni
	  EndIf
	Endif
	
.
	PACK	S$CMDLIN, "HtmlControl Template '",SnipFileName,"'"	//ERB
	SETPROP	FORM2, TITLE=S$CMDLIN					//ERB
.
	Return

EnableIt
	SetProp	HtmlCtl,Enabled=1
	return

DisableIt
	SetProp	HtmlCtl,Enabled=0
	return

Test
	GetProp CheckBox1, Value=IsUtf8
	If (IsUtf8 == 0 )
	  SetProp 		HtmlCtl,CodePage=1
	  GetProp		EditText1,Text=FullHtml
	Else
	  SetProp 		HtmlCtl,CodePage=0
	  If (IsWin == 0 )
	    Client.SetUTF8Convert Using 0
	    GetProp		EditText1,Text=FullHtml
	    Client.SetUTF8Convert Using 1
	  Else
	    EditText1.GetUnicode Giving DataUni
  	    ConvertUtf DataUni, FullHtml, "8"	;Convert Unicode to UTF8
	  EndIf
	Endif

.	HtmlCtl.InnerHtml Using FullHtml		
	SetProp	HtmlCtl,InnerHtml=FullHtml
	SetProp		Form2,Visible=1
.
.....
. Determine if this snippet has any PLB events:
. 
	SCAN "data-plbevent=", fullHtml						//ERB
	IF EQUAL								//ERB
	 RESET fullHtml								//ERB
	 SetProp StatText1, TEXT="Snippet uses 'data-plbevent'!"		//ERB
	ELSE									//ERB
	 SetProp StatText1, TEXT="Snippet does not use 'data-plbevent'!"	//ERB
	ENDIF									//ERB
.	
	Return

HideTestWin
	SetProp		Form2,Visible=0
	 SetProp StatText1, TEXT=""						//ERB	
	Return

FocusTesting
.	SetFocus	HtmlCtl	
	Return

PrintIt
	GetProp		EditText2,Text=SnipFileName
	HtmlCtl.MakePict Giving PrtPict
	SetProp  Form2,Units=$LOENGLISH
	GetProp HtmlCtl, Width=Right,Height=Bottom
	Add	"30" To Bottom
	Add	"10" TO Right
	SetProp  Form2,Units=$PIXELS
	PrtOpen PrtFile,"@pdf:",""
	PrtPage PrtFile;*Orient=*landscape, "File Name: ", SnipFileName:
		 *Units=*LOENGLISH,*PictRect=*Off,*Pict=30:Bottom:10:Right:PrtPict
	PrtClose PrtFile
	Return
.
DX	DIM	150							  //ERB
.
HtmlEvCtl
	JsonEvent.LoadJson Using JsonData
.
	UNPACK	"", Info
	Call	FetchJsonStringValue Using JsonEvent,"type",Info
	ListView1.InsertItemEx  Giving CurIndex Using Info
	PACK	DX, "type: ",Info
.
	UNPACK	"", Info
	Call	FetchJsonStringValue Using JsonEvent,"id",Info
	ListView1.SetItemText Using CurIndex, Info, 1
	PACK	DX, DX, ";   id: ",Info
.
	UNPACK	"", Info
	Call	FetchJsonStringValue Using JsonEvent,"pageX",Info
	ListView1.SetItemText Using CurIndex, Info, 2
	PACK	DX, DX, ";   pageX: ",Info
.
	UNPACK	"", Info
	Call	FetchJsonStringValue Using JsonEvent,"pageY",Info
	ListView1.SetItemText Using CurIndex, Info, 3
	PACK	DX, DX, ";   pageY: ",Info
.
	UNPACK	"", Info
	Call	FetchJsonStringValue Using JsonEvent,"metaKey",Info
	ListView1.SetItemText Using CurIndex, Info, 4
	PACK	DX, DX, ";   metaKey: ",Info
.
	UNPACK	"", Info
	Call	FetchJsonStringValue Using JsonEvent,"which",Info
	ListView1.SetItemText Using CurIndex, Info, 5
	PACK	DX, DX, ";   which: ",Info
.
	UNPACK	"", Info
	Call	FetchJsonStringValue Using JsonEvent,"target",Info
	ListView1.SetItemText Using CurIndex, Info, 6
	PACK	DX, DX, ";   target: ",Info
.
	UNPACK	"", Info
	SETPROP	StatText1, TEXT=DX
.
	Return

....
. Fetch string data for String 'label'
. Only update the result if the label is found
. 
FetchJsonStringValue	FUNCTION
pXData			XDATA	^
xLabel			DIM	50
dReturn			DIM	^
			ENTRY
.
xString	DIM	200
x200	DIM	200
xError	DIM	100
nvar	FORM	2
....................

.....
. Find the specified JSON label node
. 
	PACK s$cmdlin, "label='",xLabel,"'"
	pXData.FindNode	GIVING	nvar:
			USING	*FILTER=S$cmdlin:		//Locate specified JSON label!
				*POSITION=START_DOCUMENT_NODE	//Start at the beginning of the document!
	IF ( nvar == 0 )
...
. Move to the child node of the 'orient' JSON label.
. 
	 pXData.MoveToNode GIVING nvar USING *POSITION=MOVE_FIRST_CHILD
.
	 IF ( nvar == 0 )
...
. Fetch the data for the JSON  label.
. 
	  pXData.GetText GIVING xString
	  PACK s$cmdlin, xLabel,"= '",xString,"'"
	 ELSE
	  MOVE "Error Move Node:", s$cmdlin
	 ENDIF
	ELSE
	 PACK s$cmdlin, "Error Find Node:",nvar
	ENDIF

	TYPE xString	
	IF NOT EOS
	 MOVE xString, dReturn
	ENDIF
.	
	FUNCTIONEND	

.

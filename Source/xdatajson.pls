................................................................................
. Sample program using XDATA to read XML data
.
	INCLUDE plbmeth.inc
.
X	PLFORM xdatajsonf.plf 
.
JsonOptToDisk		FORM	"6" // JSON_SAVE_USE_INDENT+JSON_SAVE_USE_EOR
XmlOptToDisk		FORM	"6" // XML_SAVE_USE_INDENT+XML_SAVE_USE_EOR
XmlOptToDiskNoHdr	FORM	"7" // XML_SAVE_NO_DECLARATION+XML_SAVE_USE_INDENT+XML_SAVE_USE_EOR
.
nVar		FORM	2
.
XmlData		XDATA
Name		DIM	100
OutData		DIM	1000
Result		FORM	8
MoveRes         FORM    8
Level           FORM    2
Count           FORM    2
Value		FORM    5
Label		DIM     40
Text		DIM     40
SysId		DIM     40
PubId		DIM     40
Target		DIM     40
LineCount	FORM    2
.
pXml		DIM	^8192
pXmlSize	FORM	"    8192"
xSize		FORM	8
iHandle		INTEGER	4
.
dJsonType	DIM	10(0..7):	
			("NONE"):
			("OBJECT"):
			("ARRAY"):
			("INTEGER"):
			("DOUBLE"):
			("STRING"):
			("BOOLEAN"):
			("NULL")
.
JsonData  INIT "{#"value#": 1, #"FirstName#": #"Bill#", #"actions#":  [ {#"action#": true}, { #"action#": false} ]}"
JsonData1 INIT "{#"suggestions#":[{#"text#":#"8471 Compass Dr, Boynton Beach FL#", #"street_line#":#"8471 Compass Dr#",#"city#":#"Boynton Beach#",#"state#":#"FL#"}]}"
.....
.
	WINHIDE
.
	FORMLOAD	X
.
	LOOP
	 WAITEVENT
	REPEAT
.....
.
LoadFile FUNCTION
         ENTRY
.
DX	DIM	8192
xName	DIM	300
xPath	DIM	300
.
	DataList1.ResetContent
	TreeView1.DeleteAll
.
	GETPROP	EditText2, TEXT=Name	//Get File Name.
	CHOP Name, Name
	TYPE Name
	IF EOS
	 CLEAR	xName, xPath
	 GETFNAME OPEN, "Json File", XName, xPath, "Json"
	 TYPE xName
	 IF EOS
	  ALERT NOTE, "Json File Required!", nVar
	  RETURN
	 ENDIF
	 PACK Name, xPath, xName
	 SETPROP EditText2, TEXT=Name
	ENDIF
.
.....
.
. Load the data
.
	XmlData.LoadJson Giving Result Using Name, JSON_LOAD_FROM_FILE
	IF (Result <> 0 )
	    IF (Result = 14 )
		   XmlData.GetExtendedError Giving Name
		   DataList1.AddString USING Name
		ENDIF
.
           PACK S$CMDLIN, "Invalid file name or type: '", Name, "'"
	   ALERT NOTE,  S$CMDLIN, nVar
	   RETURN
	ENDIF
.....
. Move the file Json into EditText1
. 
	XmlData.StoreJson Giving DX
	SETPROP EditText1, TEXT=DX
.
.....
. Load the TreeView1
.
	XmlData.StoreXmlSize GIVING xSize
	IF ( xSize > pXmlSize )
	 DMAKE pXml, ( xSize + 1024 )
	 MOVEPTR pXml, pXml
	 IF OVER
	  ALERT NOTE, "DMAKE failed!", nVar
	  STOP
	 ENDIF
	 MOVE ( xSize + 1024 ), pXmlSize
	ENDIF
.
	XmlData.StoreXml GIVING pXml
.
	TreeView1.LoadXMLFile USING pXml	//Load the Treeview with the JSON data.
	TreeView1.GetNextItem GIVING iHandle USING 0, TVGN_ROOT
	TreeView1.Expand USING iHandle, TVE_EXPAND
.
.....
.
. Show the tree
.
	MOVE "1" TO Level
	MOVE "0" TO LineCount
	CALL ShowChild
	XmlData.SaveJson  Using "tmp1.json", JsonOptToDisk
.
	PACK	S$CMDLIN, "Done: '",Name,"'"
	DataList1.AddString USING S$CMDLIN
.
	FUNCTIONEND
.
.....
.
LoadString FUNCTION
           ENTRY
.
dJson	DIM	8192
.
	DataList1.ResetContent
.
	GETPROP	EditText1, TEXT=dJson
	CHOP dJson, dJson
	TYPE dJson
	IF EOS
	 MOVE	  JsonData1, dJson
	 SETPROP  EditText1, TEXT=dJson
	ENDIF
.....
.
. Load the data
.
	XmlData.LoadJson Giving Result Using dJson
	IF (Result <> 0 )
	    IF (Result = 14 )
		   XmlData.GetExtendedError Giving Name
		   DataList1.AddString USING Name
		ENDIF
.
           PACK S$CMDLIN, "Error: '", Name, "'"
	   ALERT NOTE,  S$CMDLIN, nVar
	   RETURN
	ENDIF
.....
. Load the TreeView1
.
	XmlData.StoreXmlSize GIVING xSize
	IF ( xSize > pXmlSize )
	 DMAKE pXml, ( xSize + 1024 )
	 MOVEPTR pXml, pXml
	 IF OVER
	  ALERT NOTE, "DMAKE failed!", nVar
	  STOP
	 ENDIF
	 MOVE ( xSize + 1024 ), pXmlSize
	ENDIF
.
	XmlData.StoreXml GIVING pXml
.
	TreeView1.LoadXMLFile USING pXml	//Load the Treeview with the JSON data.
	TreeView1.GetNextItem GIVING iHandle USING 0, TVGN_ROOT
	TreeView1.Expand USING iHandle, TVE_EXPAND
.
.....
.
. Show the tree in the DataList
.
	MOVE "1" TO Level
	MOVE "0" TO LineCount
	CALL ShowChild
	XmlData.SaveJson  Using "tmp1string.json", JsonOptToDisk
.
	PACK	S$CMDLIN, "Done: *******************"
	DataList1.AddString USING S$CMDLIN
.
	FUNCTIONEND
.
.....
. Clear the DataList and TreeView
. 
Clear	FUNCTION
     	ENTRY
.
	SETPROP	EditText1, TEXT=""
	SETPROP	EditText2, TEXT=""
	SETPROP StatText1, TEXT=""
.
	DataList1.ResetContent
.
	TreeView1.DeleteAll
.
	FUNCTIONEND
.
.....
.
. Show One Child
.
ShowChild	FUNCTION
         	ENTRY
.
  XmlData.MoveToNode Giving MoveRes Using MOVE_FIRST_CHILD 
  RETURN IF ( MoveRes <> 0 )
  Add "1" TO Level
  Call DisplayOne
  Call ShowChild
  LOOP
   XmlData.MoveToNode Giving MoveRes Using MOVE_NEXT_SIBLING
   WHILE ( MoveRes = 0 )
   Call DisplayOne
   Call ShowChild
  REPEAT
  XmlData.MoveToNode Using MOVE_PARENT_NODE
  SUB "1" From Level
.
  FUNCTIONEND
.....
.
. Display One Node
.
DisplayOne FUNCTION
           ENTRY
.
DX	DIM	200
jType	FORM	2
nPos	FORM	5
.
    CLEAR	DX
    IF (LineCount = 20)
	   MOVE "0" TO LineCount
	ELSE
	   ADD "1" TO LineCount
	ENDIF
	Move Level To Count
	Loop
	 PACK DX, DX, " "
	
	 SUB "1" From Count
	 BREAK IF ( Count = 0 ) 
	Repeat
.
	XmlData.GetType Giving Value

	SWITCH Value
	
	 CASE DOM_ELEMENT_NODE
.
	  XmlData.GetJsonType GIVING jType
.
	  XmlData.GetLabel Giving Label
	  PACK	DX, DX, "Element   ", Label
	  DataList1.AddString GIVING nPos USING DX
	  IF ( ( nPos >= 0 ) and ( jType > 0 ) )
	   DataList1.SetItemData USING jType, nPos
	  ENDIF

	 CASE DOM_ATTRIBUTE_NODE
.
	  XmlData.GetJsonType GIVING jType
.
	  XmlData.GetLabel Giving Label
	  XmlData.GetText Giving Text
	  PACK	DX, DX, "Attribute ", Label, "=", Text
	  DataList1.AddString GIVING nPos USING DX
	  IF ( ( nPos >= 0 ) and ( jType > 0 ) )
	   DataList1.SetItemData USING jType, nPos
	  ENDIF
   
     CASE DOM_TEXT_NODE	
.
	  XmlData.GetJsonType GIVING jType
.
	  XmlData.GetText Giving Text
	  PACK	DX, DX, "Text      ", Text
	  DataList1.AddString GIVING nPos USING DX
	  IF ( ( nPos >= 0 ) and ( jType > 0 ) )
	   DataList1.SetItemData USING jType, nPos
	  ENDIF

	 CASE DOM_PROCESSING_INSTRUCTION_NODE 
.
	   XmlData.GetTarget Giving Target
	   XmlData.GetData Giving Text

     CASE DOM_COMMENT_NODE
.
	  XmlData.GetComment Giving Text
	  PACK	DX, DX, "Comment   ", Text
	  DataList1.AddString USING DX

     CASE DOM_DOCUMENT_TYPE_NODE
.	 
	 XmlData.GetComment Giving Text
	  XmlData.GetName Giving Name
	  XmlData.GetSysId Giving SysId
	  XmlData.GetPubId Giving PubId
	  PACK	DX, DX, "DOCTYPE     ", Name, " - ", SysId, " - ", PubId
	  DataList1.AddString USING DX
	  
	ENDSWITCH

	FUNCTIONEND
.
.....
.
ClickDL	FUNCTION
nRes	FORM	5
       	ENTRY
.
jType	FORM	2
D2	DIM	2
.
	DEBUG
	DataList1.GetItemData GIVING jType USING ( nRes - 1 )
	IF ( jType <= 0 )
	 SETPROP StatText1, TEXT=""
	 RETURN
	ENDIF
.
	MOVE	jType, D2
	SQUEEZE D2, D2
.
	PACK S$CMDLIN, "JSON Type: (", D2, ") '", dJsonType(jType), "'"
	SETPROP	StatText1, TEXT=S$CMDLIN
.
	FUNCTIONEND
.

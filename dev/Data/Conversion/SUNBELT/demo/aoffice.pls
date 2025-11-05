*==============================================================================
. Example Program: AOFFICE.PLS by BILL KEECH
.
. This file contains small samples of using Automation with
. Office95 or Office97
.
. Copyright @ 1998, Sunbelt Computer Systems, Inc.
. All Rights Reserved.
.
True	   Integer 4,"1"
False	   Integer 4,"0"
AutoTrue   Integer 4,"0xffffffff"
AutoFalse  Integer 4,"0"
Ans	   Dim	   1
Count	   Form	   4
.
TestBasic  Form	   "0"	     Set these to "1" and compile to test
TestWord   Form	   "1"	     each interface.
TestProj   Form	   "0"
TestAccess Form	   "0"
TestMsg	   Form	   "0"
.------------------------------------------------------------------------------
. This section contains	code for using the Word.Basic interface	to WORD
.
Word	Automation
 
	If (TestBasic =	1)
	  Create Word,Class="Word.Basic"
	  Word.AppMaximize
	  Word.FileNewDefault
	  Word.Formatfont Using	*Points=22:
				*Bold=True:
				*Italic=True
	  Word.Insert Using "Using Word	can be easy"
	  Word.InsertPara
	  Word.Formatfont Using	*Points=10:
				*Bold=AutoFalse:
				*Italic=AutoFalse
	  Word.Insert Using "Using Word	can be easy"
	  Word.FileSaveAs Using	"C:\TestDoc.doc"
	  Pause	"2"
	  Word.FileClose
	  Word.FileExit
	Endif
 
.------------------------------------------------------------------------------
. This section contains	code for using the Word.Application interface to WORD
.
WordObj	  Automation
DocsObj	  Automation
DocObj	  Automation
RangeObj  Automation
 
	If (TestWord = 1)
.		.
. Start	with the Word Application object
.
	  Create WordObj,Class="Word.Application"
	  SetProp WordObj,*Visible=AutoTrue
.
. Now get the documents	object and create a new	document
.
	  GetProp WordObj,*Documents=DocsObj
	  DocsObj.Add Giving DocObj
.
. To open instead enable the following code
.
.	  DocsObj.Open Giving DocObj Using "C:\WrdTest1.Doc"
.
. Now get the actual word document and close the documents object
.
	  DocObj.Activate
	  GetProp DocObj,*Content=RangeObj
	  SetProp RangeObj,*Text="Hi there",*Bold=AutoTrue
	  DocObj.SaveAs	Using "C:\WrdTest1.Doc"
	  Pause	"3"
	  WordObj.Quit
	Endif
.------------------------------------------------------------------------------
. This code is for Project
.
ProjApp	  Automation
ProjDoc	  Automation
 
	If	(TestProj = 1)
 
	  Create ProjApp,Class="MSProject.Application"
	  SetProp ProjApp,*Visible=True
	  ProjApp.FileNew Using	*SummaryInfo=AutoFalse
 
	  GetProp ProjApp,*ActiveProject=ProjDoc
 
	  ProjDoc.tasks.Add Using *Name="Task001"
	  ProjDoc.tasks.Add Using *Name="Task002"
	  ProjDoc.tasks.Add Using *Name="Task003"
	  ProjDoc.tasks.Add Using *Name="Task004"
 
	  ProjApp.FileSave
	  ProjApp.Quit
 
	Endif
.------------------------------------------------------------------------------
. This code is for Access
.
AccessApp    Automation
DataBaseName Init   "C:\program	files\microsoft	office\office\samples\Northwind.mdb"
acPreview    Form    "2"
 
	If ( TestAccess	= 1 )
 
	  Create AccessApp,Class="Access.Application"
	  SetProp AccessApp,*Visible=True
 
	  AccessApp.OpenCurrentDatabase	Using DataBaseName
	  AccessApp.DoCmd.OpenReport Using "Products by	Category":
					   acPreview
 
	  Pause	"3"
	  AccessApp.Quit
 
	Endif
.------------------------------------------------------------------------------
. This code is for Messaging
.
Session	Automation
Message	Automation
Recip	Automation
mapiTo	Integer	4,"1"
 
	If (TestMsg = 1)
 
	  Create Session,Class="MAPI.SESSION"
	  Session.Logon
	  Session.Outbox.Messages.Add Giving Message
 
	  Setprop Message,*Subject="Test message from PL/B"
	  Message.Recipients.Add Giving	Recip
 
	  Setprop Recip,*Name="Ed B",*Type=mapiTo
	  Message.Update
 
	  Trap SkipIt If Object
	  Message.Send Using *ShowDialog=True
	  Trapclr Object
	  Session.Logoff
 
	Endif
.
	Keyin	"All examples finished.	Press enter: ",Ans
	Stop
SkipIt
	Return

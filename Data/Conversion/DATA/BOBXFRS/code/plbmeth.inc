*==============================================================================
. PLB METHOD support definitions
.
. Last Revision	Date:  16 Apr 2002
.
. Revision History:
.
	 %IFDEF	   $PLBMETH_HISTORY					 :8.3A
.:: 12 Oct 98 -	Create PLB method parameter definitions.		 :8.3
.:: 09 Nov 98 -	Added methods for PICT object.				 :8.3a
.:: 11 Dec 98 -	Updated	for 83b	changes.				 :8.3b
.:: 19 Feb 99 -	Added TabStops method reference	for DATALIST.		 :8.3
.:: 19 Feb 99 -	Modified to add	internal runtime methods for CONTAINER.	 :8.3
.:: 26 Mar 99 -	Added GetExtendedStyle and SetExtendedStyle methods for	 :8.3A
.::		LISTVIEW object.					 :8.3A
.:: 07 May 99 -	Added LVIS_OVERLAYMASK & LVIS_STATEIMAGEMASK.		 :8.3C
.:: 23 Aug 99 -	Added LVS_EX_CHECKBOXES.				 :8.3F
.:: 16 May 00 -	Modified to reflect that SORTED	is not supported for a	 :8.4B
.::		DATALIST in a SETPROP instruction.			 :8.4B
.:: 16 May 00 -	Added IMAGECOLORS object for IMAGELIST object.		 :8.4B
.:: 25 Sep 00 -	Added Change and Double	Click events for a TREEVIEW.	 :8.4E
.:: 11 Mar 02 -	Added new property and method references for LISTVIEW	 :8.6B
.::		and TREEVIEW objects.					 :8.6B
.:: 16 Apr 02 -	Added WINDOW object methods for	MDI support.		 :8.6C
.::
	 %ENDIF								 :8.3A
*------------------------------------------------------------------------------
.
. Note1:  Sections added to this include file are for user information
.	  for an application.  This file can be	modfiied and used to meet
.	  the requirements for any user	application.
.
*------------------------------------------------------------------------------
.
	 %IFNDEF   $PLBMETH
$PLBMETH  EQU	   1		       ;Flag that PLBMETH is used.
.
*==============================================================================
. Syntax
.
. {obj}.{method} [GIVING {res}]	[USING [*{KEY}=]{parm}[,[*{KEY}=]{parm}..]]
.
.    Where:
.
.	   {obj}    - Object variable PLB label	reference which	has
.		      supported	methods.
.	   {method} - Method is	an identifier for the operation	to be
.		      performed	for the	{object} variable.  The	syntax for
.		      the {method} can be one of the following:
.
.		      {method}	-  1. Method keyword name.
.				   2. @{svar} variable which contains the
.				      method keyword name.
.	   {res}    - Dim, Form, Integer, or an	object ( AUTOMATION, COLOR,
.		      FONT, IMAGELIST, or VARIANT ) to receive the result for
.		      the specified {method}.  The specific type(s) allowed
.		      depends on the {method} requirements.
.	   {parm}   - Dim, Form, Integer, immediate numeric value, 
.		      literal, or an object ( AUTOMATION, COLOR, FONT,
.		      IMAGELIST, or VARIANT ) specifying an output
.		      parameter	value.	The specific type(s) allowed depends
.		      on the {method} requirements.
.	   {KEY}   -  This is a	keyword	text name which	can be used with the
.		      specified	{method} parameters.  The use of {KEY} is
.		      optional.	 It is possible	that some {methods} may	not
.		      have named text keywords which means the parameters
.		      must be in the proper parameter position.	 If a {method}
.		      has any parameters without a {KEY} name, then those
.		      parameters must be specified in the parameter list
.		      before parameters	where {KEY} is used.
.		      The {KEY}	input can be one of the	following:
.
.		      {KEY}  - 1. *{Keyword Name}
.			       2. @{svar} variable which contains the
.				  Keyword Name.
.    Examples:
.
.	MYLIST	   LISTVIEW
.	$10$	   FORM	      "10"
.	RESULT	   INTEGER    4
.	USERNUM	   INTEGER    4,"12345"
.	INDEXVAR   INIT	      "INDEX"
.
.		   CREATE     MYLIST...
.	;.OK.......MYLIST.SetItemParam GIVING RESULT USING 10, 12345
.	;.OK.......MYLIST.SetItemParam USING *INDEX=10,	*PARAM=USERNUM
.	;.OK.......MYLIST.SetItemParam USING *PARAM=USERNUM, *INDEX=$10$
.	;.OK.......MYLIST.SetItemParam USING @INDEXVAR=10, *PARAM=12345
.	;.ERROR....MYLIST.SetItemParam USING *INDEX=10,	12345
.
*------------------------------------------------------------------------------
. Method Runtime Errors
.
.   O123 - Specified property does not exist for object.
.   O124 - Too many parameters have been specified for an object method.
.   O125 - Method specified does not exist for object.
.   O126 - Invalid parameter type specified for	a method.
.   O127 - Method does not provide a result yet	a result is being requested.
.   O128 - Required parameter is missing from method parameter list.
.   O129 - Duplicate method parameter specified.
.   O130 - Invalid parameter name specified.
. 
*------------------------------------------------------------------------------
. Object Characteristics
*------------------------------------------------------------------------------
.   AUTOMATION
.
. Events:
.
.   Reference Automation Server	vendor documentation for supported events.
.
. Properties:
.
.   CLASS=svarslit			     CREATE  SETPROP  GETPROP
.   CLASSID=svarslit			     CREATE  SETPROP  GETPROP
.   LIC=svarslit			     CREATE	      GETPROP
.   OBJECTID=dnumnvar			     CREATE  SETPROP  GETPROP
.
.   Reference Automation Server	vendor documentation for additional 
.   properties which are supported.
.
. Methods:
.
.   Reference Automation Server	vendor documentation for methods.
.
. Method Constants:
.
.   Reference Automation Server	vendor documentation for method	parameter
.   values.
.
*------------------------------------------------------------------------------
.   CONTAINER
.
.   PLBDSIGN browse capability can help	provide	information for	insertable
.   objects to be placed into a	container.
.
. Events:
.
.   $CLICK	  EQU	 4
.   $DBLCLICK	  EQU	 6
.   $DRAGDROP	  EQU	 7
.   $DRAGOVER	  EQU	 8
.   $GOTFOCUS	  EQU	 9
.   $KEYPRESS	  EQU	 10
.   $LOSTFOCUS	  EQU	 11
.   $MOVE	  EQU	 12
.   $MOUSEDOWN	  EQU	 13
.   $MOUSEUP	  EQU	 14
.   $MOUSEMOVE	  EQU	 15
.   $RESIZE	  EQU	 17
.   $OBJMOVE	  EQU	 21
.   $UPDATED	  EQU	 22    
.
. Properties:
.
.   AUTOACT=dnumnvar			     CREATE  SETPROP  GETPROP
.   AUTOVERB=dnumnvar			     CREATE  SETPROP  GETPROP
.   BACKSTYLE=dnumnvar			     CREATE  SETPROP  GETPROP
.   BDRCOLOR=dnumnvar|color object	     CREATE  SETPROP  GETPROP
.   BGCOLOR=dnumnvar|color object	     CREATE  SETPROP  GETPROP
.   BORDER[=dnumnvar]			     CREATE  SETPROP  GETPROP
.   CLASS=svarslit			     CREATE  SETPROP  GETPROP
.   CLASSID=svarslit			     CREATE  SETPROP  GETPROP
.   DISPLAYTYPE=dnumnvar		     CREATE  SETPROP  GETPROP
.   HEIGHT=dnumnvar				     SETPROP  GETPROP
.   HELPID=dnumnvar			     CREATE  SETPROP  GETPROP
.   HOSTNAME=svarslit			     CREATE  SETPROP  GETPROP
.   LEFT=dnumnvar				     SETPROP  GETPROP
.   OBJECTID=dnumnvar			     CREATE  SETPROP  GETPROP
.   OLEDROP=dnumnvar			     CREATE  SETPROP  GETPROP
.   OLETYPE=dnumnvar			     GETPROP
.   OLETYPEA=dnumnvar			     CREATE  SETPROP  GETPROP
.   SIZEMODE=dnumnvar			     CREATE  SETPROP  GETPROP
.   SOURCEDOC=svarslit			     CREATE  SETPROP  GETPROP
.   STYLE=dnumnvar|3DON|3DOFF|3DFLAT|3DOUT   CREATE  SETPROP  GETPROP
.   TABID=dnumnvar			     CREATE  SETPROP  GETPROP
.   TOOLTIP=svarslit			     CREATE  SETPROP  GETPROP
.   TOP=dnumnvar				     SETPROP  GETPROP
.   UPDATEOPT=dnumnvar			     CREATE  SETPROP  GETPROP
.   VISIBLE=dnumnvar			     CREATE  SETPROP  GETPROP
.   WIDTH=dnumnvar				     SETPROP  GETPROP
.   ZORDER=dnumnvar			     CREATE  SETPROP  GETPROP
.
. Methods:
.
.   $Delete		 GIVING	{nvar}
.   $DoVerb		 GIVING	{nvar} USING *Verb={dnumnvar}
.   $Update		 GIVING	{nvar}
.
. Method Constants:
....
. $DoVerb *Verb	Constants
.
OLEPrimary	    CONST "0"	;The default action for	the object.
OLEShow		    CONST "-1"	;Activates the object for editing. 
OLEOpen		    CONST "-2"	;Opens the object in a separate	application 
				;window. 
OLEHide		    CONST "-3"	;For embedded objects, hides the application 
				;that created the object. 
OLEUIActivate	    CONST "-4"	;If the	object supports	in-place activation, 
				;activates the object for in-place activation
				;and shows any user interface tools.
OLEInPlaceActivate  CONST "-5"	;If the	user moves the focus to	the OLE	
				;container control, creates a window for 
				;the object and	prepares the object to be 
				;the object to be edited. 
OLEDiscardUndoState CONST "-6"	;Used when the object is activated for 
				;editing to discard all	record of changes
				;that the object's application can undo.
.
*------------------------------------------------------------------------------
.   CONTROL
.
.   PLBDSIGN browse capability can help	provide	information for	ActiveX
.   controls available on a workstation.
.
. Events:
.
.   Reference vendor documentation for ActiveX control for supported events.
.
. Properties:
.
.   CLASS=svarslit			     CREATE  SETPROP  GETPROP
.   CLASSID=svarslit			     CREATE  SETPROP  GETPROP
.   HEIGHT=dnumnvar				     SETPROP  GETPROP
.   HELPID=dnumnvar			     CREATE  SETPROP  GETPROP
.   HWND=nvar						      GETPROP
.   LEFT=dnumnvar				     SETPROP  GETPROP
.   LIC=svarslit			     CREATE	      GETPROP
.   OBJECTID=dnumnvar			     CREATE  SETPROP  GETPROP
.   TABID=dnumnvar			     CREATE  SETPROP  GETPROP
.   TOOLTIP=svarslit			     CREATE  SETPROP  GETPROP
.   TOP=dnumnvar				     SETPROP  GETPROP
.   VISIBLE=dnumnvar			     CREATE  SETPROP  GETPROP
.   WIDTH=dnumnvar				     SETPROP  GETPROP
.   ZORDER=dnumnvar			     CREATE  SETPROP  GETPROP
.
.   Reference vendor documentation for ActiveX control for additional
.   properties which are supported.
.
. Methods:
.
.   Reference vendor documentation for ActiveX control for supported methods.
.
. Method Constants:
.
.   Reference vendor documentation for ActiveX control for method parameter
.   values.
.
*------------------------------------------------------------------------------
.   DATALIST
.
. Events:
.
.   $CLICK	  EQU	 4
.   $DBLCLICK	  EQU	 6
.   $DRAGDROP	  EQU	 7
.   $DRAGOVER	  EQU	 8
.   $GOTFOCUS	  EQU	 9
.   $KEYPRESS	  EQU	 10
.   $LOSTFOCUS	  EQU	 11
.   $MOVE	  EQU	 12
.   $MOUSEDOWN	  EQU	 13
.   $MOUSEUP	  EQU	 14
.   $MOUSEMOVE	  EQU	 15
.
. Properties:
.
.   APPEARANCE=dnumnvar			     CREATE  SETPROP  GETPROP
.   AUTOREDRAW=dnumnvar			     CREATE  SETPROP  GETPROP
.   BGCOLOR=dnumnvar|color object	     CREATE  SETPROP  GETPROP
.   DATA=svarslit			     CREATE  SETPROP  GETPROP
.   DROPID=dnumnvar			     CREATE  SETPROP  GETPROP
.   ENABLED=dnumnvar			     CREATE  SETPROP  GETPROP
.   FGCOLOR=dnumnvar|color object	     CREATE  SETPROP  GETPROP
.   FONT=svarslit|font object		     CREATE  SETPROP  GETPROP
.   HEIGHT=dnumnvar				     SETPROP  GETPROP
.   HELPID=dnumnvar			     CREATE  SETPROP  GETPROP
.   HWND=nvar						      GETPROP
.   INTEGRAL=dnumnvar			     CREATE  SETPROP  GETPROP
.   LEFT=dnumnvar				     SETPROP  GETPROP
.   MULTISELECT[=dnumnvar]		     CREATE  SETPROP  GETPROP
.   NOINTEGRAL	(OBSELETE)		     CREATE
.   OBJECTID=dnumnvar			     CREATE  SETPROP  GETPROP
.   PRINTER[=dnumnvar]			     CREATE  SETPROP  GETPROP
.   SORTED[=dnumnvar]			     CREATE	      GETPROP
.   STYLE=dnumnvar|3DON|3DOFF|3DFLAT|3DOUT   CREATE  SETPROP  GETPROP
.   TABID=dnumnvar			     CREATE  SETPROP  GETPROP
.   TABSTOPS=svarslit			     CREATE  SETPROP  GETPROP
.   TOP=dnumnvar				     SETPROP  GETPROP
.   VISIBLE=dnumnvar			     CREATE  SETPROP  GETPROP
.   WIDTH=dnumnvar				     SETPROP  GETPROP
.   ZORDER=dnumnvar			     CREATE  SETPROP  GETPROP
.
. Methods:
.
.   AddString		 GIVING	{nvar} USING *String={svarlit}
.   DeleteString	 GIVING	{nvar} USING *Index={dnumnvar}
.   Dir			 GIVING	{nvar} USING *FileSpec={svarlit}:
.					     *Flags={dnumnvar}
.   FindString		 GIVING	{nvar} USING *String={svarlit}:
.					     *Index={dnumnvar}
.   FindStringExact	 GIVING	{nvar} USING *String={svarlit}:
.					     *Index={dnumnvar}	  
.   GetCaretIndex	 GIVING	{nvar}
.   GetCount		 GIVING	{nvar}
.   GetFirstSel		 GIVING	{nvar}
.   GetNextSel		 GIVING	{nvar}
.   GetItemData		 GIVING	{nvar} USING *Index={dnumnvar}	   
.   GetSel		 GIVING	{nvar} USING *Index={dnumnvar}
.   GetSelCount		 GIVING	{nvar}
.   GetText		 GIVING	{svar} USING *Index={dnumnvar}
.   GetTextLen		 GIVING	{nvar} USING *Index={dnumnvar}
.   GetTopIndex		 GIVING	{nvar}
.   InsertString	 GIVING	{nvar} USING *String={svarlit}:
.					     *Index={dnumnvar}
.   ResetContent
.   SelectString	 GIVING	{nvar} USING *String={svarlit}:
.					     *Index={dnumnvar}
.   SelItemRange	 GIVING	{nvar} USING *Select={dnumnvar}:
.					     *First={dnumnvar}:
.					     *Last={dnumnvar}
.   SetCaretIndex	 GIVING	{nvar} USING *Index={dnumnvar}
.   SetCurSel		 GIVING	{nvar} USING *Index={dnumnvar}
.   SetItemData		 GIVING	{nvar} USING *Data={dnumnvar}:
.					     *Index={dnumnvar}	   
.   SetSel		 GIVING	{nvar} USING *Select={dnumnvar}:
.					     *Index={dnumnvar}
.   SetTopIndex		 GIVING	{nvar} USING *Index={dnumnvar}
.   TabStops		 GIVING	{nvar} USING *String={svarlit}
.
. Method Constants:
.
DDL_READWRITE	 Integer 4,"0x0000"	    ;Dir Flags
DDL_READONLY	 Integer 4,"0x0001"
DDL_HIDDEN	 Integer 4,"0x0002"
DDL_SYSTEM	 Integer 4,"0x0004"
DDL_DIRECTORY	 Integer 4,"0x0010"
DDL_ARCHIVE	 Integer 4,"0x0020"
DDL_DRIVES	 Integer 4,"0x4000"
DDL_EXCLUSIVE	 Integer 4,"0x8000"
.
*------------------------------------------------------------------------------
.   IMAGELIST
.
. Events:
.
.   None
.
. Properties:
.
.   BGCOLOR=dnumnvar|color object	     CREATE  SETPROP  GETPROP
.   IMAGECOLORS=dnumnvar		     CREATE	      GETPROP
.   IMAGESIZEH=dnumnvar			     CREATE	      GETPROP
.   IMAGESIZEV=dnumnvar			     CREATE	      GETPROP
.   MASKCOLOR=dnumnvar|color object	     CREATE  SETPROP  GETPROP
.   USEMASK=dnumnvar			     CREATE	      GETPROP
.
. Methods:
.
.   AddBmp		 GIVING	{nvar} USING *Bmp={varlit}:
.					     *Mask={varlit}	   Optional
.   AddBmpMasked	 GIVING	{nvar} USING *Bmp={varlit}
.   AddIcon		 GIVING	{nvar} USING *Icon={varlit}
.   GetImageCount	 GIVING	{nvar}
.   Remove		 GIVING	{nvar} USING *Index={dnumnvar}
.   RemoveAll		 GIVING	{nvar}
.   ReplaceBmp		 GIVING	{nvar} USING *Index=(dnumnvar}:
.					     *Bmp={varlit}: 
.					     *Mask={varlit}	   Optional
.   ReplaceIcon		 GIVING	{nvar} USING *Index={dnumnvar}:
.					     *Icon={varlit}
.
. Method Constants:
.
.   None
.
*------------------------------------------------------------------------------
.   LISTVIEW
.
. Events:
.
.   $CHANGE	  EQU	 3
.   $CLICK	  EQU	 4						  8.3b
.   $DBLCLICK	  EQU	 6						  8.3b
.   $DRAGOVER	  EQU	 8
.   $GOTFOCUS	  EQU	 9
.   $KEYPRESS	  EQU	 10
.   $LOSTFOCUS	  EQU	 11
.   $MOUSEDOWN	  EQU	 13
.   $MOUSEUP	  EQU	 14
.   $MOUSEMOVE	  EQU	 15
.   $COLCLICK	  EQU	 23
.   $ITEMACTIVATE EQU	 25						  8.6B
.
. Properties:
.
.   ACTIVATE=dnumnvar			     CREATE  SETPROP  GETPROP	  ;86B
.   APPEARANCE=dnumnvar			     CREATE  SETPROP  GETPROP
.   ARRANGE=dnumnvar			     CREATE  SETPROP  GETPROP
.   AUTOREDRAW=dnumnvar			     CREATE  SETPROP  GETPROP
.   BGCOLOR=dnumnvar|color object	     CREATE  SETPROP  GETPROP
.   BORDER[=dnumnvar]			     CREATE  SETPROP  GETPROP
.   CHECKBOX=dnumnvar			     CREATE  SETPROP  GETPROP	  ;86B
.   DROPID=dnumnvar			     CREATE  SETPROP  GETPROP
.   ENABLED=dnumnvar			     CREATE  SETPROP  GETPROP
.   FGCOLOR=dnumnvar|color object	     CREATE  SETPROP  GETPROP
.   FONT=svarslit|font object		     CREATE  SETPROP  GETPROP
.   FULLROW=dnumnvar			     CREATE  SETPROP  GETPROP	  ;83A
.   GRIDLINE=dnumnvar			     CREATE  SETPROP  GETPROP	  ;86B
.   HEIGHT=dnumnvar				     SETPROP  GETPROP
.   HELPID=dnumnvar			     CREATE  SETPROP  GETPROP
.   HIDECOLHDR=dnumnvar			     CREATE  SETPROP  GETPROP
.   HIDESEL=dnumnvar			     CREATE  SETPROP  GETPROP
.   HOTTRACK=dnumnvar			     CREATE  SETPROP  GETPROP	  ;86B
.   HOVERSEL=dnumnvar			     CREATE  SETPROP  GETPROP	  ;86B
.   HOVERTIME=dnumnvar			     CREATE  SETPROP  GETPROP	  ;86B
.   HWND=nvar						      GETPROP
.   LABELWRAP=dnumnvar			     CREATE  SETPROP  GETPROP
.   LEFT=dnumnvar				     SETPROP  GETPROP
.   MULTISELECT[=dnumnvar]		     CREATE  SETPROP  GETPROP
.   OBJECTID=dnumnvar			     CREATE  SETPROP  GETPROP
.   SORTHEADER=dnumnvar			     CREATE	      GETPROP
.   SORTORDER=dnumnvar			     CREATE	      GETPROP
.   TABID=dnumnvar			     CREATE  SETPROP  GETPROP
.   TOP=dnumnvar				     SETPROP  GETPROP
.   VIEWSTYLE=dnumnvar			     CREATE  SETPROP  GETPROP
.   VISIBLE=dnumnvar			     CREATE  SETPROP  GETPROP
.   WIDTH=dnumnvar				     SETPROP  GETPROP
.   ZORDER=dnumnvar			     CREATE  SETPROP  GETPROP
.
. Methods:
.
.   Arrange		 GIVING	{nvar} USING *Code={dnumnvar}
.   DeleteAllItems	 GIVING	{nvar}
.   DeleteColumn	 GIVING	{nvar} USING *Index={dnumnvar}
.   DeleteItem		 GIVING	{nvar} USING *Index={dnumnvar}
.   EnableScrollBar	 GIVING	{nvar} USING *Enable={dnumnvar}
.   EnsureVisible	 GIVING	{nvar} USING *Index={dnumnvar}:
.					     *Partial={dnumnvar}
.   FindItem		 GIVING	{nvar} USING *Start={dnumnvar}:	   Optional
.					     *Text={svarlit}:	   Optional
.					     *Param={dnumnvar}:	   Optional
.					     *Flags={dnumnvar}	   Optional
.   FindItemCheck	 GIVING	{nvar} USING *Start={dnumnvar}
.   GetColumnFormat	 GIVING	{nvar} USING *Index={dnumnvar}
.   GetColumnText	 GIVING	{svar} USING *Index={dnumnvar}
.   GetColumnWidth	 GIVING	{nvar} USING *Index={dnumnvar}
.   GetCountPerPage	 GIVING	{nvar}
.   GetExtendedStyle	 GIVING	{nvar}
.   GetItemCheck	 GIVING	{nvar} USING *Index={dnumnvar}
.   GetItemCount	 GIVING	{nvar}
.   GetItemImage	 GIVING	{nvar} USING *Index={dnumnvar}
.   GetItemParam	 GIVING	{nvar} USING *Index={dnumnvar}
.   GetItemRect		 GIVING	{nvar} USING *Index={dnumnvar}:
.					     *Subitem={dnumnvar}
.   GetItemState	 GIVING	{nvar} USING *Index={dnumnvar}:
.					     *StateMask={dnumnvar}
.   GetItemText		 GIVING	{svar} USING *Index={dnumnvar}:
.					     *SubItem={dnumnvar}   Optional
.   GetNextItem		 GIVING	{nvar} USING *Flags={dnumnvar}:
.					     *Start={dnumnvar}	   Optional
.   GetStringWidth	 GIVING	{nvar} USING *String={svarlit}
.   InsertColumn	 GIVING	{nvar} USING *Text={svarlit}:
.					     *Width={dnumnvar}:
.					     *Index={dnumnvar}:
.					     *Format={dnumnvar}	   Optional
.   InsertColumnEx	 GIVING	{nvar} USING *Text={svarlit}:
.					     *Width={dnumnvar},
.					     *Index={dnumnvar}:
.					     *Format={dnumnvar}:   Optional
.					     *Image={dnumnvar}:	   Optional
.					     *Order={dnumnvar}	   Optional
.   InsertItem		 GIVING	{nvar} USING *Text={svarlit}:
.					     *Index={dnumnvar}:	   Optional
.					     *Image={dnumnvar}:	   Optional
.					     *Param={dnumnvar}:	   Optional
.					     *State={dnumnvar}:	   Optional
.					     *StateMask={dnumnvar} Optional
.   InsertItemEx	 GIVING	{nvar} USING *Text={svarlit}:
.					     *Index={dnumnvar}	   Optional
.					     *Image={dnumnvar}:	   Optional
.					     *Param={dnumnvar}:	   Optional
.					     *State={dnumnvar}:	   Optional
.					     *Statemask={dnumnvar}:Optional
.					     *SubItem1={svarlit}:  Optional
.					     *SubItem2={svarlit}:  Optional
.					     *SubItem3={svarlit}:  Optional
.					     *SubItem4={svarlit}:  Optional
.					     *SubItem5={svarlit},  Optional
.					     *SubItem6={svarlit}:  Optional
.					     *SubItem7={svarlit}:  Optional
.					     *SubItem8={svarlit}:  Optional
.					     *SubItem9={svarlit}:  Optional
.					     *SubItem10={svarlit}  Optional
.   SetColumnFormat	 GIVING	{nvar} USING *Index={dnumnvar}:
.					     *Format={dnumnvar}
.   SetColumnImage	 GIVING	{nvar} USING *Index={dnumnvar}:
.					     *Image={dnumnvar}
.   SetColumnOrder	 GIVING	{nvar} USING *Index={dnumnvar}:
.					     *Order={dnumnvar}
.   SetColumnText	 GIVING	{nvar} USING *Index={dnumnvar}:
.					     *Text={svarlit}
.   SetColumnWidth	 GIVING	{nvar} USING *Index={dnumnvar}:
.					     *Width={dnumnvar}
.   SetExtendedStyle	 GIVING	{nvar} USING *MASK={dnumnvar}:
.					     *STYLE={dnumnvar}
.   SetImageList	 GIVING	{nvar} USING *ImageList={ImageList Obj}
.   SetImageListSmall	 GIVING	{nvar} USING *ImageList={ImageList Obj}
.   SetImageListState	 GIVING	{nvar} USING *ImageList={imagelist Obj}
.   SetItemCheck	 GIVING	{nvar} USING *Index={dnumnvar}:
.					     *Value={dnumnvar}
.   SubItemHitTest	 GIVING	{nvar} USING *Horz={dnumnvar}:
.					     *Vert={dnumnvar}
.   SetItemImage	 GIVING	{nvar} USING *Index={dnumnvar}:
.					     *Image={dnumnvar}
.   SetItemParam	 GIVING	{nvar} USING *Index={dnumnvar}:
.					     *Param={dnumnvar}
.   SetItemState	 GIVING	{nvar} USING *Index={dnumnvar}:
.					     *State={dnumnvar}:
.					     *StateMask={dnumnvar}
.   SetItemText		 GIVING	{nvar} USING *Index={dnumnvar}:
.					     *Text={svarlit}:
.					     *SubItem={dnumnvar}   Optional
.   SortColumn		 GIVING	{nvar} USING *Column={dnumnvar}:
.					     *Type={dnumnvar}:
.					     *Mask={svarlit}:
.					     *Column1={col1}:	   Optional
.					     *Type1={type1}:	   Optional
.					     *Mask1={mask1}:	   Optional
.					     *Column2={col2}:	   Optional
.					     *Type2={type2}:	   Optional
.					     *Mask2={mask2}:	   Optional
.					     *Column3={col3}:	   Optional
.					     *Type3={type3}:	   Optional
.					     *Mask3={mask3}	   Optional
.
. Method Constants:
.
LVA_DEFAULT	 Integer 4,"0x0000"	    ;Arrange Code
LVA_ALIGNLEFT	 Integer 4,"0x0001"
LVA_ALIGNTOP	 Integer 4,"0x0002"
LVA_SNAPTOGRID	 Integer 4,"0x0005"
 
LVFI_PARTIAL	 Integer 4,"0x0008"	    ;FindItem Flags
 
LVNI_ALL	 Integer 4,"0x0000"	    ;GetNextItem Flags
LVNI_FOCUSED	 Integer 4,"0x0001"
LVNI_SELECTED	 Integer 4,"0x0002"
LVNI_CUT	 Integer 4,"0x0004"
LVNI_DROPHILITED Integer 4,"0x0008"
LVNI_ABOVE	 Integer 4,"0x0100"
LVNI_BELOW	 Integer 4,"0x0200"
LVNI_TOLEFT	 Integer 4,"0x0400"
LVNI_TORIGHT	 Integer 4,"0x0800"
 
LVCFMT_LEFT	       Integer 4,"0x0000"   ;InsertColumn Format
LVCFMT_RIGHT	       Integer 4,"0x0001"
LVCFMT_CENTER	       Integer 4,"0x0002"
LVCFMT_IMAGE	       Integer 4,"0x0800"   ;Column has	image		;8.6B
LVCFMT_BITMAP_ON_RIGHT Integer 4,"0x1000"   ;Image displayed on	right	;8.6B
LVCFMT_COL_HAS_IMAGES  Integer 4,"0x8000"				;8.6B
.
					    ;InsertItem	  State/StateMask
					    ;GetItemState	StateMask
LVIS_FOCUSED	    Integer 4,"0x0001"	    ;SetItemState State/StateMask
LVIS_SELECTED	    Integer 4,"0x0002"
LVIS_CUT	    Integer 4,"0x0004"
LVIS_DROPHILITED    Integer 4,"0x0008"
LVIS_OVERLAYMASK    Integer 4,"0x0F00"
LVIS_STATEIMAGEMASK Integer 4,"0xF000"
 
LVS_EX_GRIDLINES	Integer	4,"0x00000001" ;SetExtendedStyle MASK/STYLE
LVS_EX_CHECKBOXES	Integer	4,"0x00000004" ;& GetExtendedStyle return value
LVS_EX_TRACKSELECT	Integer	4,"0x00000008" ;
LVS_EX_HEADERDRAGDROP	Integer	4,"0x00000010"
LVS_EX_FULLROWSELECT	Integer	4,"0x00000020" ;applies	to report mode only
LVS_EX_ONECLICKACTIVATE	Integer	4,"0x00000040"
LVS_EX_UNDERLINEHOT	Integer	4,"0x00000800"
LVS_EX_UNDERLINECOLD	Integer	4,"0x00001000"
.
*------------------------------------------------------------------------------
.   PICT
.
. Events:
.
.   $DRAGDROP	  EQU	 7
.   $DRAGOVER	  EQU	 8
.   $MOVE	  EQU	 12
.   $MOUSEDOWN	  EQU	 13
.   $MOUSEUP	  EQU	 14
.   $MOUSEMOVE	  EQU	 15
.
. Properties:
.
.   AUTOSCALE=dnumnvar			     CREATE  SETPROP  GETPROP
.   AUTOZOOM[=dnumnvar]			     CREATE  SETPROP  GETPROP
.   BDRCOLOR=dnumnvar|color object	     CREATE  SETPROP  GETPROP
.   BGCOLOR=dnumnvar|color object	     CREATE  SETPROP  GETPROP
.   BORDER[=dnumnvar]			     CREATE  SETPROP  GETPROP
.   DROPID=dnumnvar			     CREATE  SETPROP  GETPROP
.   ENABLED=dnumnvar			     CREATE  SETPROP  GETPROP
.   HEIGHT=dnumnvar				     SETPROP  GETPROP
.   LEFT=dnumnvar				     SETPROP  GETPROP
.   LINKHSCROLL=<hscrollbar>		     CREATE	      GETPROP
.   LINKVSCROLL=<vscrollbar>		     CREATE	      GETPROP
.   NOAUTOZOOM	(OBSELETE)		     CREATE
.   NORESIZE	(OBSELETE)		     CREATE
.   NOSCROLL	(OBSELETE)		     CREATE
.   OBJECTID=dnumnvar			     CREATE  SETPROP  GETPROP
.   PAGE=dnumnvar			     CREATE
.   PICTSIZEH=nvar					      GETPROP
.   PICTSIZEV=nvar					      GETPROP
.   POS=dnumnvarH:dnumnvarV			     SETPROP  GETPROP
.   RESIZE=dnumnvar			     CREATE  SETPROP  GETPROP
.   RESOURCE=dnumnvar				     SETPROP  GETPROP
.   SCALE=dnumnvar			     CREATE  SETPROP  GETPROP
.   SCROLLBAR[=dnumnvar]		     CREATE  SETPROP  GETPROP
.   STYLE=dnumnvar|3DON|3DOFF|3DFLAT|3DOUT   CREATE  SETPROP  GETPROP
.   TOP=dnumnvar				     SETPROP  GETPROP
.   VISIBLE=dnumnvar			     CREATE  SETPROP  GETPROP
.   WIDTH=dnumnvar				     SETPROP  GETPROP
.   ZORDER=dnumnvar			     CREATE  SETPROP  GETPROP
.
. Methods:
.
.   GetPageCount	 GIVING	{nvar}
.   Rotate		 GIVING	{nvar} USING *Degree={dnumnvar}
.
. Method Constants:
.
DEG_90	 Integer 4,"90"		       ;Rotate Degree
DEG_180	 Integer 4,"180"
DEG_270	 Integer 4,"270"
.
*------------------------------------------------------------------------------
.   TREEVIEW
.
. Events:
.
.   $CHANGE	  EQU	 3						  8.4E
.   $CLICK	  EQU	 4
.   $DBLCLICK	  EQU	 6						  8.4E
.   $DRAGOVER	  EQU	 8
.   $GOTFOCUS	  EQU	 9
.   $KEYPRESS	  EQU	 10
.   $LOSTFOCUS	  EQU	 11
.   $MOUSEDOWN	  EQU	 13
.   $MOUSEUP	  EQU	 14
.   $MOUSEMOVE	  EQU	 15
.
. Properties:
.
.   APPEARANCE=dnumnvar			     CREATE  SETPROP  GETPROP
.   BORDER[=dnumnvar]			     CREATE  SETPROP  GETPROP
.   BUTTONS=dnumnvar			     CREATE  SETPROP  GETPROP
.   CHECKBOX=dnumnvar			     CREATE	      GETPROP	 ;8.6B
.   DROPID=dnumnvar			     CREATE  SETPROP  GETPROP
.   ENABLED=dnumnvar			     CREATE  SETPROP  GETPROP
.   FONT=svarslit|font object		     CREATE  SETPROP  GETPROP
.   FULLROW=dnumnvar			     CREATE  SETPROP  GETPROP	 ;8.6B
.   HEIGHT=dnumnvar				     SETPROP  GETPROP
.   HELPID=dnumnvar			     CREATE  SETPROP  GETPROP
.   HIDESEL=dnumnvar			     CREATE  SETPROP  GETPROP
.   HOTTRACK=dnumnvar			     CREATE  SETPROP  GETPROP	 ;8.6B
.   HWND=nvar						      GETPROP
.   INDENT=dnumnvar			     CREATE  SETPROP  GETPROP
.   LEFT=dnumnvar				     SETPROP  GETPROP
.   OBJECTID=dnumnvar			     CREATE  SETPROP  GETPROP
.   TABID=dnumnvar			     CREATE  SETPROP  GETPROP
.   TOP=dnumnvar				     SETPROP  GETPROP
.   TREELNSTYLE=dnumnvar		     CREATE  SETPROP  GETPROP
.   VISIBLE=dnumnvar			     CREATE  SETPROP  GETPROP
.   WIDTH=dnumnvar				     SETPROP  GETPROP
.   ZORDER=dnumnvar			     CREATE  SETPROP  GETPROP
.
. Methods:
.
.   DeleteAll		 GIVING	{nvar}
.   DeleteItem		 GIVING	{nvar} USING *Item={dnumnvar}
.   EnsureVisible	 GIVING	{nvar} USING *Item={dnumnvar}
.   Expand		 GIVING	{nvar} USING *Item={dnumnvar}:
.					     *Code={dnumnvar}
.   GetCount		 GIVING	{nvar}
.   GetItemCheck	 GIVING	{nvar} USING *Index={dnumnar}
.   GetItemImage	 GIVING	{nvar} USING *Item={dnumnvar}
.   GetItemParam	 GIVING	{nvar} USING *Item={dnumnvar}
.   GetItemSelImage	 GIVING	{nvar} USING *Item={dnumnvar}
.   GetItemText		 GIVING	{svar} USING *Item={dnumnvar}
.   GetNextItem		 GIVING	{nvar} USING *Item={dnumnvar}:
.					     *Code={dnumnvar}
.   GetVisibleCount	 GIVING	{nvar}
.   InsertItem		 GIVING	{nvar} USING *Text={svarlit}:
.					     *Parent={dnumnvar}:
.					     *After={dnumnvar}:
.					     *Image={dnumnvar}:	   Optional
.					     *SelImage={dnumnvar}: Optional
.					     *Param={dnumnvar}	   Optional
.   SelectItem		 GIVING	{nvar} USING *Item={dnumnvar}:
.					     *Code={dnumnvar}
.   SetImageList	 GIVING	{nvar} USING *ImageList={ImageList Obj}
.   SetItemCheck	 GIVING	{nvar} USING *Index={dnumnvar}:
.					     *Value={dnumnvar}
.   SetItem		 GIVING	{nvar} USING *Item={dnumnvar}:
.					     *Text={svarlit}:	   Optional 
.					     *Image={dnumnvar} :   Optional
.					     *SelImage={dnumnvar}: Optional
.					     *Param={dnumnvar}	   Optional
.   SortChildren	 GIVING	{nvar} USING *Item={dnumnvar}:
.					     *Recurse={dnumnvar}
.   SubItemHitText	 GIVING	{nvar} USING *Horz={dnumnvar}:
.					     *Vert={dnumnvar}
.
. Method Constants:
.
TVI_ROOT	     Integer 4,"0xFFFF0000"  ;DeleteItem Item
					     ;InsertItem Parent
TVI_FIRST	     Integer 4,"0xFFFF0001"  ;InsertItem After
TVI_LAST	     Integer 4,"0xFFFF0002"
TVI_SORT	     Integer 4,"0xFFFF0003"
 
TVE_COLLAPSE	     Integer 4,"0x0001"	     ;Expand Code
TVE_EXPAND	     Integer 4,"0x0002"
TVE_TOGGLE	     Integer 4,"0x0003"
TVE_COLLAPSERESET    Integer 4,"0x8000"
 
TVGN_ROOT	     Integer 4,"0x0000"	     ;GetNextItem Code
TVGN_NEXT	     Integer 4,"0x0001"
TVGN_PREVIOUS	     Integer 4,"0x0002"
TVGN_PARENT	     Integer 4,"0x0003"
TVGN_CHILD	     Integer 4,"0x0004"
TVGN_FIRSTVISIBLE    Integer 4,"0x0005"
TVGN_NEXTVISIBLE     Integer 4,"0x0006"
TVGN_PREVIOUSVISIBLE Integer 4,"0x0007"
TVGN_DROPHILITE	     Integer 4,"0x0008"
TVGN_CARET	     Integer 4,"0x0009"
 
.Note: A TreeView item number is an Integer 4 or a FORM	10
.
*------------------------------------------------------------------------------
.   WINDOW
.
. Events:
.
.   $LOAD	  EQU	 0
.   $ACTIVATE	  EQU	 1
.   $DEACTIVATE	  EQU	 2
.   $CLOSE	  EQU	 5
.   $DRAGOVER	  EQU	 8
.   $GOTFOCUS	  EQU	 9
.   $KEYPRESS	  EQU	 10
.   $LOSTFOCUS	  EQU	 11
.   $MOVE	  EQU	 12
.   $MOUSEDOWN	  EQU	 13
.   $MOUSEUP	  EQU	 14
.   $MOUSEMOVE	  EQU	 15
.   $PAINT	  EQU	 16
.   $RESIZE	  EQU	 17
.   $FORMINIT	  EQU	 20
.
. Properties:
.
.   APPEARANCE=dnumnvar			     CREATE  SETPROP  GETPROP
.   AUTOREDRAW=dnumnvar			     CREATE  SETPROP  GETPROP
.   AUTOSCROLL=dnumnvar			     CREATE  SETPROP  GETPROP	  8.6C
.   BGCOLOR=dnumnvar|color object	     CREATE  SETPROP  GETPROP
.   BORDER[=dnumnvar]			     CREATE  SETPROP  GETPROP
.   CAPTION=dnumnvar			     CREATE  SETPROP  GETPROP
.   CLIPCTRL=dnumnvar			     CREATE  SETPROP  GETPROP
.   ENABLED=dnumnvar			     CREATE  SETPROP  GETPROP
.   FGCOLOR=dnumnvar|color object	     CREATE  SETPROP  GETPROP
.   FONT=svarslit|font object		     CREATE  SETPROP  GETPROP
.   GRIDALIGN=dnumnvar			     CREATE  SETPROP  GETPROP
.   GRIDSIZEH=dnumnvar			     CREATE  SETPROP  GETPROP
.   GRIDSIZEV=dnumnvar			     CREATE  SETPROP  GETPROP
.   HEIGHT=dnumnvar				     SETPROP  GETPROP
.   HWND=nvar					      GETPROP
.   INTASKBAR=dnumnvar			     CREATE	      GETPROP	  8.6C
.   LEFT=dnumnvar				     SETPROP  GETPROP
.   LINKHSCROLL=<hscrollbar>		     CREATE	      GETPROP
.   LINKVSCROLL=<vscrollbar>		     CREATE	      GETPROP
.   MAXBOX=dnumnvar			     CREATE  SETPROP  GETPROP
.   MDIBORDER=dnumnvar			     CREATE  SETPROP  GETPROP	  8.6C
.   MDIHEIGHT=dnumnvar			     CREATE  SETPROP  GETPROP	  8.6C
.   MDILEFT=dnumnvar			     CREATE  SETPROP  GETPROP	  8.6C
.   MDISCROLL=dnumnvar			     CREATE	      GETPROP	  8.6C
.   MDITOP=dnumnvar			     CREATE  SETPROP  GETPROP	  8.6C
.   MDIWIDTH=dnumnvar			     CREATE  SETPROP  GETPROP	  8.6C
.   MINBOX=dnumnvar			     CREATE  SETPROP  GETPROP
.   MINSCROLLH=dnumnvar			     CREATE  SETPROP  GETPROP	  8.6C
.   MINSCROLLV=dnumnvar			     CREATE  SETPROP  GETPROP	  8.6C
.   NEGBORDERS=dnumnvar			     CREATE  SETPROP  GETPROP
.   NEGMENUS=dnumnvar			     CREATE  SETPROP  GETPROP
.   NOMENURESIZE=dnumnvar		     CREATE  SETPROP  GETPROP
.   OBJECTID=dnumnvar			     CREATE  SETPROP  GETPROP
.   PARENTWIN=<WINDOW> object		     CREATE  SETPROP
.   PARENTWIN=<nvar>					     GETPROP
.   SCROLLBAR[=dnumnvar]		     CREATE  SETPROP  GETPROP
.   STYLE=dnumnvar|3DON|3DOFF|3DFLAT|3DOUT   CREATE  SETPROP  GETPROP
.   SYSMENU=dnumnvar			     CREATE  SETPROP  GETPROP
.   TABID=dnumnvar			     CREATE  SETPROP  GETPROP
.   TITLE=svarslit			     CREATE  SETPROP  GETPROP
.   TOP=dnumnvar				     SETPROP  GETPROP
.   TOPMOST=dnumnvar			     CREATE  SETPROP  GETPROP
.   UNITS=dnumnvar			     CREATE  SETPROP  GETPROP
.   VISIBLE=dnumnvar			     CREATE  SETPROP  GETPROP
.   WIDTH=dnumnvar				     SETPROP  GETPROP
.   WINBORDER=dnumnvar			     CREATE  SETPROP  GETPROP	  8.6C
.   WINOFFSETH=dnumnvar				     SETPROP  GETPROP
.   WINOFFSETV=dnumnvar				     SETPROP  GETPROP
.   WINPOS=dnumnvar			     CREATE  SETPROP  GETPROP
.   WINTYPE=dnumnvar			     CREATE	      GETPROP
.   ZORDER=dnumnvar			     CREATE  SETPROP  GETPROP
.
. Methods:
.
.   Activate		 GIVING	{nvar}
.   Close		 GIVING	{nvar}
.   Erase		 GIVING	{nvar}
.   GetActiveMdiChild	 GIVING	{nvar}
.   MDILayout		 GIVING	{nvar} USING *Layout={dnumnvar}
.   MDIShow		 GIVING	{nvar} USING *Show={dnumnvar}
.   Refresh		 GIVING	{nvar}
.   Show    		 GIVING	{nvar} USING *Mode={dnumnvar}
.
. WINDOW Method	Constants:
.
$ArrangeIcons		EQU	1	    ;MDILayout Method
$Cascade		EQU	2
$TileHorizontal		EQU	3
$TileVertical		EQU	4
.
$SW_HIDE		EQU	0	    ;Show Method
$SW_SHOWNORMAL		EQU	1
$SW_NORMAL		EQU	1
$SW_SHOWMINIMIZED	EQU	2
$SW_SHOWMAXIMIZED	EQU	3
$SW_MAXIMIZE		EQU	3
$SW_SHOWNOACTIVATE	EQU	4
$SW_SHOW		EQU	5
$SW_MINIMIZE		EQU	6
$SW_SHOWMINNOACTIVE	EQU	7
$SW_SHOWNA		EQU	8
$SW_RESTORE		EQU	9
.
*------------------------------------------------------------------------------
	 %ENDIF			       ;End $PLBMETH

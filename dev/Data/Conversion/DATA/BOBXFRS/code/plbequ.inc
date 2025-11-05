*==============================================================================
. GUI designer support equates
.
. Last Revision Date:  16 Apr 2002
.
. Revision History:
.
         %IFDEF    $PLBEQU_HISTORY                                       :8.3A
.:: 15 Jan 97 - Create PLB equate include definitions.                   :8.1
.:: 06 Feb 97 - Added ICON to APPEARANCE property.                       :8.1
.::           - Added GROUPID to DROPID property.                        :8.1
.::           - Added SHAPE to BGCOLOR and BDRCOLOR properties.          :8.1
.:: 25 Feb 97 - Added LINKHSCROLL and LINKVSCROLL.                       :8.1
.:: 05 Mar 97 - Added AUTOSCALE, PICTSIZEH, PICTSIZEV, and WINPOS.       :8.1
.:: 02 Apr 97 - Changed EDITTYPE to use DECIMAL and INTEGER              :8.1
.:: 22 Apr 97 - Added LINE object.                                       :8.1
.::           - Added X1, X2, Y1, and Y2 properties for LINE object.     :8.1
.:: 04 Jun 97 - Added MREGION to DROPID property.                        :8.1C
.::           - Added MREGION to VISIBLE property.                       :8.1C
.:: 12 Jun 97 - Reversed DECIMAL and INTEGER equate values for EDITTYPE  :8.1C
.::             object.                                                  :8.1C
.::           - Added GRIDALIGN, GRIDSIZEH, GRIDSIZEV, and UNITS for the :8.1C
.::             WINDOW object.                                           :8.1C
.:: 16 Jun 97 - Updated that the READONLY property can only be applied to:8.1C
.::             an EDITTEXT object through the CREATE statement.         :8.1C
.:: 01 Jul 97 - Added conditional compile detection equate which can     :8.1E
.::             allow PLBEQU.INC to exist multiple times in the source   :8.1E
.::             without causing errors.                                  :8.1E
.:: 15 Jul 97 - Added option to AUTOREDRAW property.                     :8.1F
.:: 23 Jul 97 - Added OVERTYPE and SELECTALL properties for EDITTEXT.    :8.1F
.:: 09 Dec 97 - Updated MULTISELECT to document EXTENDED.  Also removed  :8.2
.::             MULTISELECT from being a SETPROP control.                :8.2
.::           - Removed ALIGNMENT from being a SETPROP control for an    :8.2
.::             EDITTEXT.                                                :8.2
.:: 11 Dec 97 - Added KEYPRESS DEFINES and CONST declarations.           :8.2
.::             See $PLBDEF and $PLBCONST below.                         :8.2
.:: 02 Jan 98 - Added SHAPE object to HEIGHT, LEFT, TOP, and WIDTH       :8.2A
.::             properties.                                              :8.2A
.:: 11 Aug 98 - Corrected default for PERCENT property.                  :8.2K
.:: 12 Aug 98 - Added PICTURE and ICON properties for BUTTON object.     :8.2K
.:: 21 Aug 98 - Added VALUE property for PROGRESS object.                :8.2K
.:: 17 Sep 98 - Added PARENTWIN property for WINDOW object.              :8.2K
.:: 22 Sep 98 - Added TREEVIEW object to property descriptions.  Also,   :8.2M
.::             descriptions for new TREEVIEW properties BUTTONS,        :8.2M
.::             HIDESEL, INDENT, and TREELNSTYLE.                        :8.2M
.:: 12 Oct 98 - Added LISTVIEW object to property descriptions.  Added   :8.2M
.::             descriptions for new LISTVIEW propertites ARRANGE,       :8.2M
.::             HIDECOLHDR, LABELWRAP, and VIEWSTYLE.                    :8.2M
.:: 13 Oct 98 - Added IMAGELIST object property descriptions for         :8.2M
.::             IMAGESIZEH, IMAGESIZEV, MASKCOLOR, and USEMASK.          :8.2M
.:: 11 Dec 98 - Updated to reflect properties for AUTOMATION, CONTAINER, :8.3b
.::             CONTROL, and VARIANT objects.                            :8.3b
.:: 10 Feb 99 - Added TOOLTIP property.                                  :8.3f
.:: 11 Feb 99 - Added ALERT TYPE={dnumnvar} pre-defined values.          :8.3f
.:: 19 Feb 99 - Added NEGBORDERS and NEGMENUS properties for a WINDOW    :8.3
.::             object.                                                  :8.3
.:: 09 Mar 99 - Updated description of the NEGMENUS property.            :8.3A
.:: 26 Mar 99 - Added FULLROW property for LISTVIEW.                     :8.3A
.:: 28 Apr 99 - Added $ENTER definition.                                 :8.3B
.:: 29 Apr 99 - Added $TRUE and $FALSE equates.                          :8.3C
.:: 19 Jul 99 - Added ALIGNTEXT property for RADIO, CHECKBOX, RADIOGRP,  :8.3E
.::             and CHECKGRP object support.                             :8.3E
.:: 19 Jul 00 - Added TOOLTIPHWND property available to any object which :8.3E
.::             supports the TOOLTIP property.                           :8.3E
.:: 09 May 00 - Added IMAGECOLORS property for the IMAGELIST object.     :8.4A
.:: 16 May 00 - Modified to reflect that SORTED is not supported property:8.4B
.::             for a DATALIST in a SETPROP operation.                   :8.4B
.:: 29 Jun 00 - Added VARABSVALUE property for the VARIANT object.       :8.4B
.:: 07 Jul 00 - Added SELGROUPID property for RADIO object.              :8.4B
.:: 25 Sep 00 - Modified SCROLLBAR property to support EDITTEXT object.  :8.4E
.:: 16 Oct 00 - Added $VALIDATE event number.                            :8.4E
.:: 07 Dec 00 - Added equates to support DTYPE, DTYPEBASE, and DTYPESUB  :8.5A
.::             psuedo command operator type values.                     :8.5A
.:: 01 Feb 01 - Added NOMENURESIZE property for a WINDOW object.         :8.5C
.:: 11 Mar 02 - Added LISTVIEW properties ACTIVATE, CHECKBOX, GRIDLINE,  :8.6B
.::             HOTTRACK, HOVERSEL, and HOVERTIME.                       :8.6B
.:: 11 Mar 02 - Added TREEVIEW properties CHECKBOX, FULLROW, & HOTTRACK. :8.6B
.:: 11 Mar 02 - Added $ITEMACTIVATE event number for LISTVIEW object.    :8.6B
.:: 16 Apr 02 - Modified WINTYPE property to support MDI windows.        :8.6C
.:: 16 Apr 02 - Added new properties for Window object as follows:       :8.6C
.::             AUTOSCROLL, MINSCROLLH, MINSCROLLV, INTASKBAR, MDIBORDER,:8.6C
.::             MDIHEIGHT, MDILEFT, MDISCROLL, MDITOP, MDIWIDTH, TOPMOST,:8.6C
.::             and WINBORDER.                                           :8.6C
.::
         %ENDIF                                                          :8.3A
.
*------------------------------------------------------------------------------
.
. Note:  Sections added to this include file are for user information
.        for an application.  This file can be modfiied and used to meet
.        the requirements for any user application.
.
*------------------------------------------------------------------------------
.
         %IFNDEF   $PLBDEF                                                8.2
$PLBDEF   EQU      0                   ;1 ==> include KEYPRESS defines    8.2
         %ENDIF                                                           8.2
.
         %IFNDEF   $PLBCONST                                              8.2
$PLBCONST EQU      0                   ;1 ==> include KEYPRESS CONST      8.2
         %ENDIF                                                           8.2
.
         %IFNDEF   $PLBALERT                                              8.3f
$PLBALERT EQU      0                   ;1 ==> include ALERT TYPE INTEGERs 8.3f
         %ENDIF                                                           8.3f
.
         %IFNDEF   $PLBDTYPE                                              8.5A
$PLBDTYPE EQU      0                   ;1 ==> include DTYPE equates       8.5A
         %ENDIF                                                           8.5A
.
         %IFNDEF   $PLBEQU                                                8.1E
$PLBEQU   EQU      1                   ;Flag that PLBEQU is used.         8.1E
*------------------------------------------------------------------------------
. General Usage Equates
.
$ON     EQU        1
$OFF    EQU        0
$NONE   EQU        0
$TRUE   EQU        1                                                      8.3C
$FALSE  EQU        0                                                      8.3C
.
*------------------------------------------------------------------------------
. Event Type Indicators
.
$LOAD         EQU    0
$ACTIVATE     EQU    1
$DEACTIVATE   EQU    2
$CHANGE       EQU    3
$CLICK        EQU    4
$CLOSE        EQU    5
$DBLCLICK     EQU    6
$DRAGDROP     EQU    7
$DRAGOVER     EQU    8
$GOTFOCUS     EQU    9
$KEYPRESS     EQU    10
$LOSTFOCUS    EQU    11
$MOVE         EQU    12
$MOUSEDOWN    EQU    13
$MOUSEUP      EQU    14
$MOUSEMOVE    EQU    15
$PAINT        EQU    16
$RESIZE       EQU    17
$TIMER        EQU    18
$OLDEVENT     EQU    19
$FORMINIT     EQU    20
$OBJMOVE      EQU    21
$UPDATED      EQU    22                ;AUTOMATION object
$COLCLICK     EQU    23                ;ONLY allowed with LISTVIEW object
.                                      ;when SORTHEADER property set to $ON.
$VALIDATE     EQU    24                ;8.5
$ITEMACTIVATE EQU    25                ;8.6B LISTVIEW event.
.
*==============================================================================
. Object Properties
.
*------------------------------------------------------------------------------
.   ACTIVATE=dnumnvar                        CREATE  SETPROP  GETPROP
.
. Description:
.       When this property is set to $ONECLICK, the LISTVIEW object sends an
.       ACTIVATE event when the user clicks an item. This property also
.       enables hot tracking in the LISTVIEW object. Hot tracking means that
.       when the cursor moves over an item, it is highlighted but not
.       selected.
.
.       When this property is set to $TWOCLICK, the LISTVIEW object sends an
.       ACTIVATE event when the user double-clicks an item. This property
.       also enables hot tracking in the LISTVIEW object. Hot tracking means
.       that when the cursor moves over an item, it is highlighted but not
.       selected.
.
.       Note:
.
.         1. This property will not take affect unless a Microsoft file
.            version of 4.70 or later of 'comctl32.dll' is installed on
.            a given workstation.
.
.         2. This property will only affect the operation of the LISTVIEW
.            object when the VIEWSTYLE property is set to $VIEWREPORT style.
.
. Objects:
.       LISTVIEW
.
. dnumnvar values:
.
$STANDARD     EQU       1       // Default
$ONECLICK     EQU       2
$TWOCLICK     EQU       3
.
*------------------------------------------------------------------------------
.   ALIGNMENT=dnumnvar                       CREATE  SETPROP  GETPROP
.
. Description:
.       The ALIGNMENT property defines how the text is to be output
.       horizontally for the object.
.
.       Note1: The EDITTEXT object doesn't support changing of this property
.              using the SETPROP statement. 
.
. Objects:
.       EDITTEXT
.       STATTEXT
.
. dnumnvar values:
.
.$NONE        EQU       0              // Default
$CENTER       EQU       1
$LEFT         EQU       2
$RIGHT        EQU       3
.
*------------------------------------------------------------------------------
.   ALIGNTEXT=dnumnvar                       CREATE  SETPROP  GETPROP
.
. Description:
.       The ALIGNTEXT property specifies whether the text is to be aligned
.       to the left or right of a control indicator.
.
. Objects:
.       CHECKBOX
.       CHECKGRP
.       RADIO
.       RADIOGRP
.
. dnumnvar values:
.
.$NONE        EQU       0              // Default
$ALIGNLEFT    EQU       1
$ALIGNRIGHT   EQU       2
.
*------------------------------------------------------------------------------
.   APPEARANCE=dnumnvar                      CREATE  SETPROP  GETPROP
.
. Description:
.       The APPEARANCE property specifies when an object should
.       have a 3D look or a non-3D look.  This property should replace
.       the STYLE property for these objects.  If this property is
.       not specified, the default appearance is determined by the
.       current SETMODE *3D state.  If the SETMODE *3D state has not
.       been specified, then the appearance defaults to be the same
.       as defined for the window.
.
. Note: Under Windows95 these objects always have a 3D presentation 
.       regardless of the control value provided.
.
. Objects:
.       CHECKBOX
.       CHECKGRP
.       COMBOBOX
.       DATALIST
.       ICON
.       LISTVIEW
.       POPUPMENU  (OBSELETE)
.       RADIO
.       RADIOGRP
.       TREEVIEW
.       WINDOW
.
. dnumnvar values:
.
$3D           EQU       1
$FLAT         EQU       2
.
*------------------------------------------------------------------------------
.   ARRANGE=dnumnvar                         CREATE  SETPROP  GETPROP
.
. Description:
.       This property sets the arrangement of icons in large and small icon 
.       view mode. It may be one of:
.
.       $ARRANGELEFT - Arrange the icons along the left of the ListView.
.       $ARRANGETOP  - Arrange the icons along the top of the ListView.
.       $ARRANGENONE - Do not arrange the icons in any special order.
.
. Objects:
.       LISTVIEW
.
. dnumnvar values:
.
$ARRANGELEFT  EQU       1
$ARRANGETOP   EQU       2
$ARRANGENONE  EQU       3              // Default
.
*------------------------------------------------------------------------------
.   AUTOACT=dnumnvar                         CREATE  SETPROP  GETPROP
.
. Description:
.       This property is the property indicating when an OLE container 
.       object should be activated. It may be one of:
.
.       $AUTOACTDBLCLICK  - The object is automatically activated when the 
.                           container object is double-clicked or the ENTER 
.                           key is pressed when the container object has 
.                           the focus. 
.       $AUTOACTGETFOCUS  - The object is automatically activated when the 
.                           container object gets keyboard focus.
.       $AUTOACTMANUAL    - The object is not automatically activated. It 
.                           can be activated by using the $DoVerb method. 
.
. Objects:
.       CONTAINER
.
. dnumnvar values:
.
$AUTOACTDBLCLICK EQU       1            // Default
$AUTOACTGETFOCUS EQU       2
$AUTOACTMANUAL   EQU       3
.
*------------------------------------------------------------------------------
.   AUTOREDRAW=dnumnvar                      CREATE  SETPROP  GETPROP
.
. Description:
.       When this property is set to zero, then the repainting of the
.       object is disabled.  When this property is set to one, then the
.       repainting of the objects takes place as normal. If this property
.       is set to two the object is erased before it is refreshed. 
.
. Objects:
.       COMBOBOX
.       DATALIST
.       LISTVIEW
.       POPUPMENU  (OBSELETE)
.       WINDOW
.
. dnumnvar values:
.
.$OFF         EQU       0
.$ON          EQU       1              // Default
$WITHERASE    EQU       2
.
*------------------------------------------------------------------------------
.   AUTOSCALE=dnumnvar                       CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies how a picture should be scaled to fit
.       pict object rectangle coordinates. This property is overridden
.       by the RESIZE property.
.
. Objects:
.       PICT
.
. dnumnvar values:
.
.$NONE        EQU       0
$SCALEBEST    EQU       1               // Default 
$SCALEHORZ    EQU       2               
$SCALENONE    EQU       3               // Same as RESIZE=$OFF
$SCALEVERT    EQU       4       
.
*------------------------------------------------------------------------------
.   AUTOSCROLL=dnumnvar                      CREATE  SETPROP  GETPROP
.
. Description:
.       This property provides automatic scrollbar handling for a 
.       window. This property is used in conjuction with the MINSCROLLH,
.       MINSCROLLV, and SCROLLBAR properties of a WINDOW object.
.
.       If a window object is sized less than either the MINSCROLLH,
.       or MINSCROLLV properties, a scrollbar is shown and scrolling
.       is automatically handled.
.
.       Additionally, when autoscrolling is on, the client area of the
.       window object automatically scrolls to make the control with
.       input focus visible.
.
.
. Objects:
.       WINDOW
.
. dnumnvar values:
.
.$OFF         EQU       0       // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   AUTOSIZE[=dnumnvar]                      CREATE  SETPROP  GETPROP
.
. Description:
.       This property defines if the bottom border is to be adjusted
.       automatically to fit the number of items specified.  If the
.       AUTOSIZE property is not specified the default action is to
.       not resize the bottom border.  If the AUTOSIZE property is
.       specified without an assignment, the action is the same as
.       if AUTOSIZE=1 where given.
.
. Objects:
.       CHECKGRP
.       RADIOGRP
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   AUTOVERB=dnumnvar                        CREATE  SETPROP  GETPROP
.
. Description:
.       This property enables or disables the automatic context menu for
.       an OLE insertable object. It contains any verbs that the OLE
.       insertable object provides.
.
. Objects:
.       CONTAINER
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   AUTOZOOM[=dnumnvar]                      CREATE  SETPROP  GETPROP
.
. Description:
.       This property enables or disables the zooming capabilty for
.       a pict object.
.
. Objects:
.       PICT
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   BACKSTYLE=dnumnvar                       CREATE  SETPROP  GETPROP
.
. Description:
.       This property defines the type of background to be used for
.       supported objects.  The BACKSTYLE can be OPAQUE which prevents
.       underlying objects from showing through this object.  The
.       BACKSTYLE can also be TRANSPARENT which allows underlying
.       objects to show through the supported objects.
.
. Objects:
.       CONTAINER
.       GROUPBOX
.       SHAPE
.       STATTEXT
.
. dnumnvar values:
.
.$NONE        EQU       0              // Default
$OPAQUE       EQU       1
$TRANSPARENT  EQU       2
.
*------------------------------------------------------------------------------
.   BDRCOLOR=dnumnvar|color object           CREATE  SETPROP  GETPROP
.
. Description:
.       This property allows the color of the BORDER to be specified by
.       the user program.  If the BDRCOLOR parameter is a <color object>,
.       then the <color object> must be created before it is used.  The
.       <dnumnvar> value can also be used to specify the color as a
.       RGB value or a Windows system color index.  The <dnumnvar> value
.       can be thought of as 4 byte values.  When the high order byte
.       contains a value of 0x00, then the next 3 bytes (24 bits) get
.       interpreted as a RGB value.  When the high order byte has a value
.       of 0x80, then the lower order byte is used as an index value into
.       the Windows System colors.  The Windows system colors can be
.       defined by the user under Windows 95 and Windows NT.
.
.       Index           Value           Meaning
.
.       COLOR_ACTIVEBORDER              Active window border.
.       COLOR_ACTIVECAPTION             Active window caption.
.       COLOR_APPWORKSPACE              Background color of multiple
.                                       document interface (MDI) applications.
.       COLOR_BACKGROUND                Desktop.
.       COLOR_BTNFACE                   Face shading on push buttons.
.       COLOR_BTNSHADOW                 Edge shading on push buttons.
.       COLOR_BTNTEXT                   Text on push buttons.
.       COLOR_CAPTIONTEXT               Text in caption, size box,
.                                       and scroll bar arrow box.
.       COLOR_GRAYTEXT                  Grayed (disabled) text.
.                                       This color is set to 0 if the
.                                       current display driver does not
.                                       support a solid gray color.
.       COLOR_HIGHLIGHT                 Item(s) selected in a control.
.       COLOR_HIGHLIGHTTEXT             Text of item(s) selected in a control.
.       COLOR_INACTIVEBORDER            Inactive window border.
.       COLOR_INACTIVECAPTION           Inactive window caption.
.       COLOR_INACTIVECAPTIONTEXT       Color of text in an inactive
.                                           caption.
.       COLOR_MENU                      Menu background.
.       COLOR_MENUTEXT                  Text in menus.
.       COLOR_SCROLLBAR                 Scroll bar gray area.
.       COLOR_SHADOW                    Color of automatic window shadows.
.       COLOR_WINDOW                    Window background.
.       COLOR_WINDOWFRAME               Window frame.
.       COLOR_WINDOWTEXT                Text in windows.
.
.
. Objects:
.       CHECKGRP
.       CONTAINER
.       EDITTEXT
.       GROUPBOX
.       LINE
.       MOVIE
.       PICT
.       PROGRESS
.       RADIOGRP
.       SHAPE
.       STATTEXT
.
. dnumnvar values:
.
$SCROLLBAR            CONST   "2147483648"    ;Hex value 0x80000000
$BACKGROUND           CONST   "2147483649"    ;Hex value 0x80000001
$ACTIVECAPTION        CONST   "2147483650"    ;Hex value 0x80000002
$INACTIVECAPTION      CONST   "2147483651"    ;Hex value 0x80000003
$MENU                 CONST   "2147483652"    ;Hex value 0x80000004
$WINDOW               CONST   "2147483653"    ;Hex value 0x80000005
$WINDOWFRAME          CONST   "2147483654"    ;Hex value 0x80000006
$MENUTEXT             CONST   "2147483655"    ;Hex value 0x80000007
$WINDOWTEXT           CONST   "2147483656"    ;Hex value 0x80000008
$CAPTIONTEXT          CONST   "2147483657"    ;Hex value 0x80000009
$ACTIVEBORDER         CONST   "2147483658"    ;Hex value 0x8000000A
$INACTIVEBORDER       CONST   "2147483659"    ;Hex value 0x8000000B
$APPWORKSPACE         CONST   "2147483660"    ;Hex value 0x8000000C
$HIGHLIGHT            CONST   "2147483661"    ;Hex value 0x8000000D
$HIGHLIGHTTEXT        CONST   "2147483662"    ;Hex value 0x8000000E
$BTNFACE              CONST   "2147483663"    ;Hex value 0x8000000F
$BTNSHADOW            CONST   "2147483664"    ;Hex value 0x80000010
$GRAYTEXT             CONST   "2147483665"    ;Hex value 0x80000011
$BTNTEXT              CONST   "2147483666"    ;Hex value 0x80000012
$INACTIVECAPTIONTEXT  CONST   "2147483667"    ;Hex value 0x80000013
$BTNHIGHLIGHT         CONST   "2147483668"    ;Hex value 0x80000014
.
*------------------------------------------------------------------------------
.   BDRPATTERN=dnumnvar                      CREATE  SETPROP  GETPROP
.
. Description:
.       This property allows the user to specify the type of border
.       pattern is to be used for the object.  The possible border
.       patterns are as follows:
.
.       Dash            - Pen is dashed.
.       DashDot         - Pen has alternating dashes and dots.
.       DashDot2        - Pen has dashes and double dots.
.       Dot             - Pen is dotted.
.       InsideFrame     - Pen is solid.  The figure and border is created
.                         inside the frame defined by the user specified
.                         rectangle.
.       Solid           - Pen is solid.
.       None            - Pen defaults to solid.
.
.       Note1: The border pattern only takes affect when the BDRWIDTH
.              property has a value of 1.
.
. Objects:
.       LINE
.       SHAPE
.
. dnumnvar values:
.
.$NONE        EQU       0              // Default
$DASH         EQU       1
$DASHDOT      EQU       2
$DASHDOT2     EQU       3
$DOT          EQU       4
$INSIDEFRAME  EQU       5
$SOLID        EQU       6
.
*------------------------------------------------------------------------------
.   BDRWIDTH=dnumnvar                        CREATE  SETPROP  GETPROP
.
. Description:
.       This property defines the width of the pen used to draw the
.       object.
.
.       Note1: The border pattern only takes affect when the BDRWIDTH
.              property has a value of 1.
.
. Objects:
.       LINE
.       SHAPE
.
. dnumnvar values:
.
.       The <dnumnvar> value specifies number of pixels for width.
.
*------------------------------------------------------------------------------
.   BGCOLOR=dnumnvar|color object            CREATE  SETPROP  GETPROP
.
. Description:
.       This property allows the user program to specify the color to
.       be used for the background color.  The parameter description
.       is the same as for the BDRCOLOR property.
.
. Objects:
.       CHECKBOX
.       CHECKGRP
.       CONTAINER
.       COMBOBOX
.       DATALIST
.       EDITTEXT
.       GROUPBOX
.       HSCROLLBAR
.       IMAGELIST
.       LISTVIEW
.       PICT
.       POPUPMENU ( OBSELETE )
.       PROGRESS
.       RADIOGRP
.       RADIO
.       SHAPE
.       STATTEXT
.       VSCROLLBAR
.       WINDOW
.
. dnumnvar values:
.
.       See the BDRCOLOR property for the color equate values.
.
*------------------------------------------------------------------------------
.   BOLD[=dnumnvar]                          CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies that the font should be bolded.  When
.       the <dnumnvar> value is not provided, this indicates that the
.       BOLD is turned on.
.
. Objects:
.       FONT
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   BORDER[=dnumnvar]                        CREATE  SETPROP  GETPROP
.
. Description:
.       This property defines when an object is to have a border.
.       If the <dnumnvar> parameter is not provided, this indicates that
.       the border is to be used.
.
. Objects:
.       CHECKGRP
.       CONTAINER
.       EDITTEXT
.       LISTVIEW
.       MOVIE
.       PICT
.       RADIOGRP
.       SLIDER
.       STATTEXT
.       TREEVIEW
.       WINDOW
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   BUTTONS=dnumnvar                         CREATE  SETPROP  GETPROP
.
. Description:
.       This property causes plus (+) and minus (-) button boxs to appear
.       next to a parent's list of child items when the TREELNSTYLE is set
.       for $LINESATROOT.  When the +/- box is present , then clicking this
.       box will open or close the selected parent list.
.
. Objects:
.       TREEVIEW
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   CANCEL[=dnumnvar]                        CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies that the BUTTON object activation routine
.       is to gain program control when the escape key is entered.
.
. Objects:
.       BUTTON
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   CAPTION=dnumnvar                         CREATE  SETPROP  GETPROP
.
. Description:
.       This property allows a user to specify if a Window is to be
.       created with or without a title bar.  This property is
.       provided to the OS to eliminate/retain the caption bar as
.       appropriate.
.
.       NOTE1: Under Windows95 and Win32s, the CAPTION property will
.              have an effect on a MODAL or MODELESS window.  The
.              CAPTION property does not have an affect on the PRIMARY
.              window types.
.
. Objects:
.       WINDOW
.
. dnumnvar values:
.
.$OFF         EQU       0
.$ON          EQU       1              // Default
.
*------------------------------------------------------------------------------
.   CENTER[=dnumnvar]                        CREATE
.
. Description:
.       The CENTER property specifies that the text is to be centered
.       horizontally for the object.  The property is replaced with
.       the ALIGNMENT property.  The ALIGNMENT property is to be used
.       for performing SETPROP and GETPROP operations.
.
.       If the syntax form is used where the <dnumnvar> value is not
.       specified, this indicates that the CENTER property is to be
.       turned on.
.
.       Also note that if the CENTER property is turned off, this causes
.       the text output to be justified to the left.
.
. Objects:
.       EDITTEXT
.       STATTEXT
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   CENTERPOS=dnumnvar                       CREATE
.
. Description:
.       When the user defined rectangle is larger than the EDITTEXT
.       object, this property controls whether the EDITTEXT object is to
.       be centered TOP/BOTTOM or not.  The default action is to
.       have the EDITTEXT object centered TOP/BOTTOM within the user
.       defined rectangle parameters.  If the CENTERPOS property is
.       set to $TOPLEFTPOS, then the CREATE action is to have the
.       EDITTEXT object rectangle be located at the TOP/LEFT coordinates.
.
. Objects:A
.       EDITTEXT
.
. dnumnvar values:
.
$CENTERPOS    EQU       0              // Default
$TOPLEFTPOS   EQU       1
.
*------------------------------------------------------------------------------
.   CHECKBOX=dnumnvar                             See Objects:
.
. Description:        
.       When this property is set to $ON, it enables check boxes for 
.       items in a TREEVIEW/LISTVIEW object. The object creates and sets a
.       state image list with two images. State image 1 is the unchecked 
.       box, and state image 2 is the checked box. Setting the state image 
.       to zero removes the check box altogether. The GetItemCheck and 
.       SetItemCheck methods can be used when this property is set for
.       either a TREEVIEW or LISTVIEW.  The FindItemCheck can be used
.       for a LISTVIEW object. 
.
.       Note:
.
.         1. This property will not take affect unless a Microsoft file
.            version of 4.70 or later of 'comctl32.dll' is installed on
.            a given workstation.
.
.         2. This property will only affect the operation of the LISTVIEW
.            object when the VIEWSTYLE property is set to $VIEWREPORT style.
.
.         3. The CHECKBOX property can only be used for CREATE and GETPROP
.            in a TREEVIEW object.
.
. Objects:
.       LISTVIEW                             CREATE  SETPROP  GETPROP
.       TREEVIEW                             CREATE           GETPROP
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   CLASS=svarslit                           CREATE  SETPROP  GETPROP
.   CLASSID=svarslit                         CREATE  SETPROP  GETPROP
.
. Description:
.       This property is the associated text name for the CLSID for the
.       OLE insertable object. If set, the current OLE insertable object in a
.       OLE container object will be replaced by a new OLE insertable object
.       created using the given text name.
.
. Objects:
.       AUTOMATION
.       CONTAINER
.       CONTROL
.
. svarslit values:
.
.       The <svarslit> is a text programatic identifier associated with a
.       CLSID.  If the <svarslit> is a single '?' character, then an OLE
.       Insertable Object Dialog is presented so that a user can select
.       the OLE object to be used.
.
*------------------------------------------------------------------------------
.   CLIPCTRL=dnumnvar                        CREATE  SETPROP  GETPROP
.
. Description:
.       Excludes the area occupied by child windows/objects when 
.       drawing within the parent window.  If the property is turned
.       on, this can slow the performance of drawing objects due to
.       OS overhead in determining valid clipping regions.
.
. Objects:
.       WINDOW
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   COMBOSTYLE=dnumnvar                      CREATE           GETPROP
.
. Description:
.       The COMBOSTYLE property specifies the type of COMBOBOX window
.       object to be generated.  A default combobox list object is a
.       combox with a drop down list where the combox does not have
.       an editable capability.  The $EDIT <dnumnvar> value
.       defines a combobox list like the default except the combobox
.       does allow editing capability.  Only the current selection field
.       can be edited.  The $SIMPLE <dnumnvar> value is the
.       same as the $EDIT except the list is always present.
.
. Objects:
.       COMBOBOX
.       POPUPMENU ( OBSELETE )
.
. dnumnvar values:
.
.$NONE        EQU       0              // Same as $LIST
$EDIT         EQU       1
$LIST         EQU       2              // Default
$SIMPLE       EQU       3
.
*------------------------------------------------------------------------------
.   DATA=svarslit                            CREATE  SETPROP  GETPROP
.
. Description:
.       This property allows the items in a DATALIST to be initialized using
.       a string composed of a list of items with each item separated with
.       semi-colon.
.
. Objects:
.       DATALIST
.
. svarslit value:
.
.       String of semicolon separated list items.
.
*------------------------------------------------------------------------------
.   DEFAULT[=dnumnvar]                       CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies that the BUTTON object activation routine
.       is to gain program control when the enter key is entered and 
.       a non-button object has the focus.  However, if a button object
.       other than the DEFAULT button object has the focus when the enter
.       key is entered, then the activation routine of the button object
.       with the focus gains the program control.
.
.       Note1:  The operation when a button object other than the DEFAULT
.               button object has the focus is different from prior releases
.               to release 8.1.
.
. Objects:
.       BUTTON
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   DIGITS[=dnumnvar]                        CREATE
.
. Description:
.       This property is a CREATE only property.
.       The property specifies that the EDITTEXT object is to only
.       allow numeric digits 0 through 9.  When this property is set to
.       indicate off state, then this indicates that all characters are
.       allowed.
.
.       Note1: Use of the property should be replaced through use of 
.              the EDITTYPE property.
.
. Objects:
.       EDITTEXT
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   DISPLAYTYPE=dnumnvar                     CREATE  SETPROP  GETPROP
.
. Description:
.       This property is used to control how the OLE insertable object is 
.       drawn within an OLE container object. It may be one of:
.
.       $DISPTYPECONTENT - The content of a OLE insertable object is shown. 
.
.       $DISPTYPEICON   - The OLE insertable object is shown as an icon.
.
. Objects:
.       CONTAINER
.
. dnumnvar values:
.
$DISPTYPECONTENT EQU       1            // Default
$DISPTYPEICON    EQU       2            
*------------------------------------------------------------------------------
.   DRAWMODE=dnumnvar                        CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies the current foreground mix mode.
.       The foreground mix mode defines how colors from the object
.       and the colors in the existing presentation image are to be
.       combined.
.
.       The following is a Windows summary of the drawmodes.
.
.       Mix mode        Description
.
.       BLACKNESS       Pixel is always 0.
.
.       COPYPEN         Pixel is the pen color.
.
.       INVERT          Pixel is the inverse of the screen color.
.
.       MASKNOTPEN      Pixel is a combination of the colors common
.                       to both the screen and the inverse of the pen.
.
.       MASKPEN         Pixel is a combination of the colors common
.                       to both the pen and the screen.
.
.       MASKPENNOT      Pixel is a combination of the colors common
.                       to both the pen and the inverse of the screen.
.
.       MERGENOTPEN     Pixel is a combination of the screen color and
.                       the inverse of the pen color.
.
.       MERGEPEN        Pixel is a combination of the pen color and
.                       the screen color.
.
.       MERGEPENNOT     Pixel is a combination of the pen color and
.                       the inverse of the screen color.
.
.       NOP             Pixel remains unchanged.
.
.       NOTCOPYPEN      Pixel is the inverse of the pen color.
.
.       NOTMASKPEN      Pixel is the inverse of the MASKPEN color.
.
.       NOTMERGEPEN     Pixel is the inverse of the MERGEPEN color.
.
.       NOTXORPEN       Pixel is the inverse of the XORPEN color.
.
.       WHITENESS       Pixel is always 1.
.
.       XORPEN          Pixel is a combination of the pen color and
.                       the screen color, but not in both.
.
. Objects:
.       LINE
.       SHAPE
.
. dnumnvar values:
.
.$NONE        EQU       0       //Same as default
$BLACKNESS    EQU       1
$COPYPEN      EQU       2       //Default
$INVERT       EQU       3
$MASKNOTPEN   EQU       4
$MASKPEN      EQU       5
$MASKPENNOT   EQU       6
$MERGENOTPEN  EQU       7
$MERGEPEN     EQU       8
$MERGEPENNOT  EQU       9
$NOP          EQU       10
$NOTCOPYPEN   EQU       11
$NOTMASKPEN   EQU       12
$NOTMERGEPEN  EQU       13
$NOTXORPEN    EQU       14
$WHITENESS    EQU       15
$XORPEN       EQU       16
.
*------------------------------------------------------------------------------
.   DROPID=dnumnvar                          CREATE  SETPROP  GETPROP
.
. Description:
.       When this property is specified, then the object which has the
.       DROPID property can receive an item drop action.  The value of
.       the DROPID is sent to the activation routine of the object which
.       is being dragged.
.
. Objects:
.       BUTTON
.       CHECKBOX
.       CHECKGRP
.       COMBOBOX
.       DATALIST
.       EDITTEXT
.       GROUPBOX
.       HSCROLLBAR
.       ICON
.       LISTVIEW
.       MOVIE
.       MREGION
.       PICT
.       POPUPMENU ( OBSELETE )
.       PROGRESS
.       RADIOGRP
.       RADIO
.       SHAPE
.       SLIDER
.       STATTEXT
.       TABCONTROL
.       TREEVIEW
.       VSCROLLBAR
.
. dnumnvar values:
.
*------------------------------------------------------------------------------
.   EDITHIDESEL=dnumnvar                     CREATE  SETPROP  GETPROP
.
. Description:
.       This property negates the default behavior for EDITTEXT object.
.       The default behavior hides the selection when the edittext 
.       loses the input focus and inverts the selection when the 
.       edittext receives the input focus.  If this property is turned
.       on, the selected text is inverted, even if the edittext does
.       not have the focus.
.
. Objects:
.       EDITTEXT
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   EDITTYPE=dnumnvar                        CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies the type of edittext object as follows:
.
.       ALL             -       Allow data entry of any keyed characters.
.
.       DECIMAL         -       Only allow data entry into the edittext
.                               of numeric digits ( 0 through 9 ), '-',
.                               and '.'.
.       INTEGER         -       Only allow data entry into the edittext
.                               of numeric digits only. ( 0 through 9 ).
.       LOWERCASE       -       Convert all characters to lowercase as they
.                               are entered into the edittext.
.       UPPERCASE       -       Convert all characters to uppercase as they
.                               are entered into the edittext.
.
.       Note1:  This property should be used in place of older properties
.               which provide the same functions.
.
. Objects:
.       EDITTEXT
.
. dnumnvar values:
.
.$NONE        EQU       0              // Default
$ALL          EQU       1
$INTEGER      EQU       2
$DECIMAL      EQU       3
$LOWERCASE    EQU       4
$UPPERCASE    EQU       5
.
*------------------------------------------------------------------------------
.   ENABLED=dnumnvar                         CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies when an object is to be DISABLED/ENABLED.
.       If the ENABLED property is set to $OFF for the CREATE/SETPROP
.       statements, this is the same as if a DISABLEITEM with an ITEMNO
.       value of zero was executed for the object.  If the ENABLED
.       property is set to $ON for the SETPROP, this is the same as if
.       an ENABLEITEM with an ITEMNO valueo of zero was executed for the
.       object.  The GETPROP statement returns the current DISABLED/ENABLED
.       state for the object.
.
.       Note1: If the ENABLED property is set to $OFF for the objects
.              ICON, MREGION, MOVIE, GROUPBOX, or PROGRESS there is
.              no visible graying which identifies that the object is
.              disabled.  However, there are no events processed for
.              these object when the ENABLED property is set to $OFF.
.
. Objects:
.       BUTTON
.       CHECKBOX
.       CHECKGRP
.       COMBOBOX
.       DATALIST
.       EDITTEXT
.       GROUPBOX
.       HSCROLLBAR
.       ICON
.       LISTVIEW
.       MREGION
.       MOVIE
.       PICT
.       POPUPMENU
.       PROGRESS
.       RADIO
.       RADIOGRP
.       SHAPE
.       SLIDER
.       STATTEXT
.       TABCONTROL
.       TREEVIEW
.       VSCROLLBAR
.       WINDOW
.
. dnumnvar values:
.
.$OFF         EQU       0
.$ON          EQU       1              // Default
.
*------------------------------------------------------------------------------
.   EVENTFILTER=svarslit                     CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies a string control structure which allows
.       events for the edittext object to be controlled.  See manual
.       discussion under create for specific details.
.
. Objects:
.       EDITTEXT
.
. svarslit values:
.
.       The <svarslit> string is composed of 'Y' and 'N'
.       characters which relate to a given edittext object
.       event type by position in the string.
.
*------------------------------------------------------------------------------
.   FGCOLOR=dnumnvar|color object            CREATE  SETPROP  GETPROP
.
. Description:
.       This property allows the user program to specify the color to
.       be used for the foreground color of the object.  The parameter 
.       description is the same as for the BDRCOLOR property.
.
. Objects:
.       CHECKBOX
.       CHECKGRP
.       COMBOBOX
.       DATALIST
.       EDITTEXT
.       GROUPBOX
.       LISTVIEW
.       POPUPMENU ( OBSELETE )
.       PROGRESS
.       RADIOGRP
.       RADIO
.       STATTEXT
.       WINDOW
.
. dnumnvar values:
.
.       See BDRCOLOR property for details.
.
*------------------------------------------------------------------------------
.   FILLCOLOR=dnumnvar|color object          CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies the color to be used when filling the
.       shape object.  Please see the description under BDRCOLOR for
.       a detailed discussion of colors.
.
. Objects:
.       SHAPE
.
. dnumnvar values:
.
.       See BDRCOLOR property for details.
.
*------------------------------------------------------------------------------
.   FILLSTYLE=dnumnvar                       CREATE  SETPROP  GETPROP
.
. Description:
.       This property defines the type of hatch used to fill a shape 
.       object.  The following is a summary of the types of hatches
.       available under Windows.
.
.               Value           Meaning
.
.               DOWNDIAG        45-degree downward left-to-right hatch
.               CROSS           Horizontal and vertical crosshatch
.               DIAGCROSS       45-degree crosshatch
.               UPDIAG          45-degree upward left-to-right hatch
.               HORIZLINE       Horizontal hatch
.               VERTLINE        Vertical hatch
.               NOHATCH         SHAPE object filled with solid color as
.                               specified by FILLCOLOR.
.               CLEARHATCH      SHAPE object fill area becomes transparent
.                               such that underlying colors show through
.                               the object.
.
. Objects:
.       SHAPE
.
. dnumnvar values:
.
.$NONE        EQU       0              // Same as $NOHATCH
$CROSS        EQU       1
$DIAGCROSS    EQU       2
$DOWNDIAG     EQU       3
$HORZLINE     EQU       4
$NOHATCH      EQU       5              // Default
$CLEARHATCH   EQU       6
$UPDIAG       EQU       7
$VERTLINE     EQU       8
.
*------------------------------------------------------------------------------
.   FONT=svarslit|font object                CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies the font to be used for the supported
.       objects.
.
. Objects:
.       BUTTON
.       CHECKBOX
.       CHECKGRP
.       COMBOBOX
.       DATALIST
.       EDITTEXT
.       GROUPBOX
.       LISTVIEW
.       POPUPMENU ( OBSELETE )
.       PROGRESS
.       RADIOGRP
.       RADIO
.       STATTEXT
.       TABCONTROL
.       TREEVIEW
.       WINDOW
.
. svarslit|font:
.
*------------------------------------------------------------------------------
.   FULLROW=dnumnvar                         CREATE  SETPROP  GETPROP
.
. Description:        
.       When this property is set to zero, then the LISTVIEW extended style
.       is set to the default for FULLROW selection which means that a
.       a row can only be selected by clicking on the first column items.
.       Also, only the first column items are highlighted for a row selection.
.       When this property is set to a nonzero value, then the LISTVIEW
.       extended style is set to allow a row item to be selected by clicking
.       anywhere in a row item view area.  In this case, the full row is
.       highlighted for a given selection.
.
.       This property can also be used for a TREEVIEW object.  If it
.       is set to $ON for a TREEVIEW, then it enables full-row selection.
.
.       Note:
.
.         1. This property will not take affect unless a Microsoft file
.            version of 4.71 or later of 'comctl32.dll' is installed on
.            a given workstation.
.
.         2. This property will only affect the operation of the LISTVIEW
.            object when the VIEWSTYLE property is set to $VIEWREPORT style.
.
.         3. For a TREEVIEW object, this property will not take affect
.            unless a Microsoft file version of 4.70 or later of 
.            'comctl32.dll' is installed on a given workstation.
.
.         2. This option cannot be used if the TREELNSTYLE is not set to 
.            $NOLINES for a TREEVIEW object.
.
. Objects:
.       LISTVIEW
.       TREEVIEW
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   GRIDALIGN=dnumnvar                       CREATE  SETPROP  GETPROP
.
. Description:
.       When this property is set to zero, then the alignment to grid
.       coordinates are disabled.  When this property is set to one,
.       then objects which are created for the specified window are
.       automatically aligned to the grid coordinates for the window.
.
. Objects:
.       WINDOW
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   GRIDLINE=dnumnvar                        CREATE  SETPROP  GETPROP
.
. Description:
.       When this property is set to $ON, then gridlines are displayed
.       around items and subitems.
.
.       Note:
.
.         1. This property will not take affect unless a Microsoft file
.            version of 4.70 or later of 'comctl32.dll' is installed on
.            a given workstation.
.
.         2. This property will only affect the operation of the LISTVIEW
.            object when the VIEWSTYLE property is set to $VIEWREPORT style.
.
. Objects:
.       LISTVIEW
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   GRIDSIZEH=dnumnvar                       CREATE  SETPROP  GETPROP
.
. Description:
.       This property allows the horizontal grid size to be specified.  The
.       dnumnvar value specifies the horizontal grid size based on the UNITS
.       scale currently in use for the WINDOW object.
.
.       Note1: The GETPROP statement also returns the current horizontal 
.              grid size as a value determined by the current UNITS scale
.              specified for the WINDOW object.
.
. Objects:
.       WINDOW
.
. dnumnvar values:
.
.       The <dnumnvar> value is provided in the same units as currently used
.       for the WINDOW object.  This means that if the UNITS property for the
.       WINDOW object is currenty set to 'TWIPS', then the <dnumnvar> value
.       specifies the number of 'TWIPS' for the horizontal size.
.
*------------------------------------------------------------------------------
.   GRIDSIZEV=dnumnvar                       CREATE  SETPROP  GETPROP
.
. Description:
.       This property allows the vertical grid size to be specified.  The
.       dnumnvar value specifies the vertical grid size based on the UNITS
.       scale currently in use for the WINDOW object.
.
.       Note1: The GETPROP statement also returns the current vertical
.              grid size as a value determined by the current UNITS scale
.              specified for the WINDOW object.
.
. Objects:
.       WINDOW
.
. dnumnvar values:
.
.       The <dnumnvar> value is provided in the same units as currently used
.       for the WINDOW object.  This means that if the UNITS property for the
.       WINDOW object is currenty set to 'TWIPS', then the <dnumnvar> value
.       specifies the number of 'TWIPS' for the vertical size.
.
*------------------------------------------------------------------------------
.   GROUPID=dnumnvar                         CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies the group identifier for a radio button or
.       checkbox object. All objects with the same group identifier are
.       treated as one group for purposes of moving focus using the TAB or
.       arrow keys. For radio buttons, this property is also used to
.       determine which radio button to turn off when one is turned on.
.
. Objects:
.       CHECKBOX
.       RADIO
.
. dnumnvar values:
.
*------------------------------------------------------------------------------
.   HEIGHT=dnumnvar                                  SETPROP  GETPROP
.
. Description:
.       This property is a GETPROP/SETPROP only property.  The height
.       of the object can be retrieved using the GETPROP statement.
.       The height is determined by subtracting the top object rectangle
.       coordinate from the bottom object rectangle coordinate.  The
.       SETPROP statement can be used to change the current height of
.       an object.
.
. Objects:
.       BUTTON
.       CHECKBOX
.       CHECKGRP
.       COMBOBOX
.       CONTAINER
.       CONTROL
.       DATALIST
.       DIALOG
.       EDITTEXT
.       GROUPBOX
.       HSCROLLBAR
.       ICON
.       LISTVIEW
.       MREGION
.       MOVIE
.       PICT
.       POPUPMENU ( OBSELETE )
.       PROGRESS
.       RADIOGRP
.       RADIO
.       SHAPE
.       SLIDER
.       STATTEXT
.       TABCONTROL
.       TREEVIEW
.       VSCROLLBAR
.       WINDOW
.
. dnumnvar values:
.
.       The <dnumnvar> value is provided in the same units as used for
.       the creation of an object.  This means that if an object was
.       created using pixels, then the height expects to use pixels.
.
*------------------------------------------------------------------------------
.   HELPID=dnumnvar                          CREATE  SETPROP  GETPROP
.
. Description:
.       This property is used in conjunction with a Windows Help file
.       provided by the user.  If a program is executing with the F1HELP
.       set to ON using a SETMODE statement, then this HELPID value is
.       used as the help index context value for finding a given subject
.       in the help file when an object has the focus and the F1 function
.       key is entered.
.
. Objects:
.       BUTTON
.       CHECKBOX
.       CHECKGRP
.       COMBOBOX
.       CONTAINER
.       CONTROL
.       DATALIST
.       EDITTEXT
.       HSCROLLBAR
.       LISTVIEW
.       ICON
.       POPUPMENU ( OBSELETE )
.       PROGRESS
.       RADIOGRP
.       RADIO
.       SLIDER
.       TABCONTROL
.       TREEVIEW
.       VSCROLLBAR
.
. dnumnvar values:
.
.       The <dnumnvar> value defines a help file context index value.
.
*------------------------------------------------------------------------------
.   HIDECOLHDR=dnumnvar                      CREATE  SETPROP  GETPROP
.
. Description:
.       This property indicates if the column headers should be displayed 
.       or hidden when the ListView is in report view. 
.
. Objects:
.       LISTVIEW
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   HIDESEL=dnumnvar                         CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies whether a currently selected LISTVIEW/TREEVIEW
.       entry should remain highlighted or not when the focus is removed
.       from the LISTVIEW/TREEVIEW object.  The default is to have a selected
.       LISTVIEW/TREEVIEW entry remain highlighted.
.
. Objects:
.       LISTVIEW
.       TREEVIEW
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   HOSTNAME=svarslit                        CREATE  SETPROP  GETPROP
.
. Description:
.       This property is used by the OLE insertable object's server 
.       application when the server application is open to provide editing 
.       of the OLE insertable object.
.
. Objects:
.       CONTAINER
.
. svarslit values:
.
.       The <svarslit> is a user defined string.
.
*------------------------------------------------------------------------------
.   HOTTRACK=dnumnvar                        CREATE  SETPROP  GETPROP
.
. Description:        
.       When this property is set to $ON, it enables hot-track selection 
.       in a LISTVIEW/TREEVIEW object. Hot-track selection will cause 
.       the text of any item that may be selected to be underlined
.
.       Note:
.
.         1. This property will not take affect unless a Microsoft file
.            version of 4.71 or later of 'comctl32.dll' is installed on
.            a given workstation.
.
.         2. For a LISTVIEW object this property requires that the 
.            ACTIVATE property be set to $ONECLICK or $TWOCLICK.
.
.         3. This property will only affect the operation of the LISTVIEW
.            object when the VIEWSTYLE property is set to $VIEWREPORT style.
.
. Objects:
.       LISTVIEW
.       TREEVIEW
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
. 
*------------------------------------------------------------------------------
.   HOVERSEL=dnumnvar                        CREATE  SETPROP  GETPROP
.
. Description:
.       When this property is set to $ON, it enables hot-track selection
.       in a LISTVIEW object. Hot track selection means that an item is
.       automatically selected when the cursor remains over the item
.       for a certain period of time.
.
.       Note:
.
.         1. This property will not take affect unless a Microsoft file
.            version of 4.70 or later of 'comctl32.dll' is installed on
.            a given workstation.
.
.         2. This property will only affect the operation of the LISTVIEW
.            object when the VIEWSTYLE property is set to $VIEWREPORT style.
.
. Objects:
.       LISTVIEW
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   HOVERTIME=dnumnvar                       CREATE  SETPROP  GETPROP
.
. Description:
.       When this property is sets the time for automatic hot-track
.       selection. (See the HOVERSEL property) The time value is in
.       milliseconds. A value of 0 indicates the default time is
.       used.
.
.       Note:
.
.         1. This property will not take affect unless a Microsoft file
.            version of 4.70 or later of 'comctl32.dll' is installed on
.            a given workstation.
.
.         2. This property will only affect the operation of the LISTVIEW
.            object when the VIEWSTYLE property is set to $VIEWREPORT style.
.
. Objects:
.       LISTVIEW
.
*------------------------------------------------------------------------------
.   HWND=nvar                                         GETPROP
.
. Description:
.       This property is a GETPROP only property.  The HWND property
.       value is a Windows window handle for the supported object.
.       This HWND value could be used in WINAPI functions where
.       a window handle is required for the function.
.
. Objects:
.       BUTTON
.       CHECKBOX
.       COMBOBOX
.       CONTROL
.       DATALIST
.       DIALOG
.       EDITTEXT
.       HSCROLLBAR
.       LISTVIEW
.       MOVIE
.       POPUPMENU ( OBSELETE )
.       RADIO
.       SLIDER
.       TABCONTROL
.       TREEVIEW
.       VSCROLLBAR
.       WINDOW
.
. nvar values:
.
.       The <nvar> value retrieve is a Windows window handle for
.       the supported object.
.
*------------------------------------------------------------------------------
.   ICON=dnumnvar|svarslit|icon object       CREATE  SETPROP
.
. Description:
.       This property is supported only for CREATE and SETPROP statements.
.       The property specifies when an icon is to replace the text for a
.       BUTTON object.  This property is supported only for Windows95/98/NT.
.
. Objects:
.       BUTTON
.
. operand values:
.
.       The <dnumnvar> value is used to identify a 'resource id' to be used
.       when retrieving the icon.   The 'resource id' value can be any internal
.       runtime supported values ( 10,000 to 11,500 ).  This value can also
.       be any user defined resource identication values as provided in a
.       resource library.  If the 'resource id' value is zero, then the
.       ICON property is removed from the BUTTON object and the text name
.       for the BUTTON will be used.
.
.       The <svarslit> string specifies an icon file name which is to be used
.       for the BUTTON object.  The icon file name will default to an
.       extension of '.ico'.  This name supports the $MACRO and generic
.       PLBVOL_ file name formats.  The runtime will use the 'PLB_PATH'
.       directories to initially locate the file.  If the file is not found
.       using the 'PLB_PATH' directories, then the file is passed to Windows to
.       be located in the Windows directories.  If the <svarslit> string
.       is NULL, then the ICON property is removed from the BUTTON object
.       and the text name for the BUTTON will be used.
.
.       The <icon> object can be specified where the <icon> object must have
.       been previously created.  The data for the <icon> object is used
.       for the button.
.
*------------------------------------------------------------------------------
.   IMAGECOLORS=dnumnvar                     CREATE           GETPROP
.
. Description:
.       This property can only be used in a CREATE or GETPROP operation,
.       and it specifies the number of bits supported for colors
.       in an IMAGELIST object.  When this property is not specified,
.       the default is 32 bit colors.
.
. Objects:
.       IMAGELIST
.
. dnumnvar values:
.
.       The <dnumnvar> value is the number of bits supported for colors.
.       Acceptable <dnumnvar> values are 4, 8, 16, or 32.  Any other
.       values specified are implemented as a value of 32.
.
*------------------------------------------------------------------------------
.   IMAGESIZEH=dnumnvar                      CREATE           GETPROP
.
. Description:
.       This property specifies the width in pixels for the images to be 
.       stored in the IMAGELIST object.
.
. Objects:
.       IMAGELIST
.
. dnumnvar values:
.
.       The <dnumnvar> value is the number of pixels for image width.
.
*------------------------------------------------------------------------------
.   IMAGESIZEV=dnumnvar                      CREATE           GETPROP
.
. Description:
.       This property specifies the height in pixels for the images to be
.       stored in the IMAGELIST object.
.
. Objects:
.       IMAGELIST
.
. dnumnvar values:
.
.       The <dnumnvar> value is the number of pixels for image height.
.
*------------------------------------------------------------------------------
.   INDENT=dnumnvar                          CREATE  SETPROP  GETPROP
.
. Description:
.       This property defines the width of the indentation between parent
.       items and childern items.  A value of zero causes a Windows default
.       to be used.
.
. Objects:
.       TREEVIEW
.
. dnumnvar values:
.
.       The <dnumnvar> value specifies the number of pixels for indentation.
.
*------------------------------------------------------------------------------
.   INTASKBAR=dnumnvar                       CREATE           GETPROP
.
. Description:
.       This property forces a top-level window onto the taskbar when
.       the window is visible and the WINBORDER type for the window is
.       'FIXEDTOOL' or 'SIZABLETOOL'.  This property is ignored when
.       the WINBORDER type is any other setting.
.
. Objects:
.       WINDOW
.
. dnumnvar values:
.
.$OFF         EQU       0       // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   INTEGRAL=dnumnvar                        CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies when a DATALIST is to resize for the
.       number of items in a list versus leaving the size of the DATALIST
.       to be as defined by the user rectangle coordinates.  When the
.       INTEGRAL property is set to OFF, then the size of the list box
.       is the size specified by the user coordinate values.  When the
.       INTEGRAL property is set to ON, then the normal action of Windows
.       is to resize a list box so that the list box does not display
.       partial items.
.
. Objects:
.       DATALIST
.
. dnumnvar values:
.
.$OFF         EQU       0
.$ON          EQU       1              // Default
.
*------------------------------------------------------------------------------
.   ITALIC[=dnumnvar]                        CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies that the font should be italic.  When
.       the <dnumnvar> value is not provided, this indicates that the
.       ITALIC property is turned on.
.
. Objects:
.       FONT
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   LABELWRAP=dnumnvar                       CREATE  SETPROP  GETPROP
.
. Description:
.       This property indicates if the text labels may wrap in icon view. 
.       If set to $OFF, text labels will be displayed on a single line in
.       icon view. 
.
. Objects:
.       LISTVIEW
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   LEFT=dnumnvar                                    SETPROP  GETPROP
.
. Description:
.       This property is a GETPROP/SETPROP only property.  The LEFT
.       property returns the left coordinate of a created objected.
.
. Objects:
.       BUTTON
.       CHECKBOX
.       CHECKGRP
.       COMBOBOX
.       CONTAINER
.       CONTROL
.       DATALIST
.       DIALOG
.       EDITTEXT
.       FLOATMENU
.       GROUPBOX
.       HSCROLLBAR
.       ICON
.       LISTVIEW
.       MREGION
.       MOVIE
.       PICT
.       POPUPMENU ( OBSELETE )
.       PROGRESS
.       RADIOGRP
.       RADIO
.       SHAPE
.       SLIDER
.       STATTEXT
.       TABCONTROL
.       TREEVIEW
.       VSCROLLBAR
.       WINDOW
.
. dnumnvar values:
.
.       The <dnumnvar> value is provided in the same units as used when
.       the object was created.
.
*------------------------------------------------------------------------------
.   LIC=svarslit                             CREATE           GETPROP
.
. Description:
.       This property allows a PLB program to retrieve or 
.       specify a valid LICENSE identifier for the CONTROL
.       or AUTOMATION object.
.
. Objects:
.       AUTOMATION
.       CONTROL
.
. svarslit values:
.
.       The <svarslit> variable is a license string for the object.
.
*------------------------------------------------------------------------------
.   LINKHSCROLL=<hscrollbar>                 CREATE           GETPROP
.
. Description:
.       This property is to allow a horizontal scrollbar object to be 
.       linked to the scrollbar which may be generated for a PICT or a
.       WINDOW object.  After the logical linkage is established, then
.       operations on the linked scrollbar can be executed.  This means
.       that a GETITEM for the <hscrollbar> object can be executed to
.       determine the current settings of the scrollbar which has be
.       generated for another object.
.
.       Note1: It is not possible to change the MIN, MAX, or SHIFT values
.              for a picture linked scrollbar using either the SETPROP or 
.              SETITEM. A picture linked scrollbar can change the thumb 
.              position and tab id. These restrictions do not apply to
.              a window linked scrollbar.
.
. Objects:
.       PICT
.       WINDOW
.
*------------------------------------------------------------------------------
.   LINKVSCROLL=<vscrollbar>                 CREATE           GETPROP
.
. Description:
.       This property is to allow a vertical scrollbar object to be
.       linked to the scrollbar which may be generated for a PICT or a
.       WINDOW object.  After the logical linkage is established, then
.       operations on the linked scrollbar can be executed.  This means
.       that a GETITEM for the <vscrollbar> object can be executed to
.       determine the current settings of the scrollbar which has be
.       generated for another object.
.
.       Note1: It is not possible to change the MIN, MAX, or SHIFT values
.              for a linked scrollbar using either the SETPROP or SETITEM.
.              It is possible to change the thumb position however.
.
. Objects:
.       PICT
.       WINDOW
.
*------------------------------------------------------------------------------
.   LOWERCASE[=dnumnvar]                     CREATE
.
. Description:
.       This property is a CREATE only property.
.       The property specifies that the EDITTEXT object is to convert
.       all entered data to lowercase.  When this property is set to
.       be OFF, then this indicates that no data conversion occurs.
.
.       Note1: Use of the property should be replaced through use of 
.              the EDITTYPE property.
.
. Objects:
.       EDITTEXT
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   MASKCOLOR=dnumnvar|color object          CREATE  SETPROP  GETPROP
.
. Description:
.       This property allows the user program to specify the color to
.       be used as the mask color in the AddBmpMasked method.  The parameter 
.       description is the same as for the BDRCOLOR property.
.
. Objects:
.       IMAGELIST
.
. dnumnvar values:
.
.       See the BDRCOLOR property for the color equate values.
.
*------------------------------------------------------------------------------
.   MAX=dnumnvar                             See Objects:
.
. Description:
.       This property defines the maximum value when the slider thumb is at
.       the bottom or right most position of the supported object.
.
. Objects:
.       HSCROLLBAR                                   SETPROP  GETPROP
.       SLIDER                               CREATE  SETPROP  GETPROP
.       VSCROLLBAR                                   SETPROP  GETPROP
.
. dnumnvar values:
.
.       The value is a logical unit as specified by the user.
.
*------------------------------------------------------------------------------
.   MAXBOX=dnumnvar                          CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies when a MAXIMIZE box for the window
.       object should be allowed or not.
.
.       Note1: The MAXBOX property does not have an effect if the 
.              CAPTION property is set to $OFF for a MODAL or MODELESS
.              window type.
.
. Objects:
.       WINDOW
.
. dnumnvar values:
.
.$OFF         EQU       0
.$ON          EQU       1              // Default
.
*------------------------------------------------------------------------------
.   MAXCHARS=dnumnvar                        CREATE  SETPROP  GETPROP
.
. Description:
.       Specifies the maximum number of characters allowed to
.       be entered into edittext object. This applies whether
.       edittext is single line or multiline.
.
. Objects:
.       EDITTEXT
.
. dnumnvar values:
.
.       The <dnumnvar> value defines number of characters.
.
*------------------------------------------------------------------------------
.   MAXCOLS=dnumnvar                         CREATE  SETPROP  GETPROP
.
. Description:
.       The property is the maximum number of characters allowed for
.       an individual line in a multiline edittext object.  This property
.       is ignored if the MULTILINE is not used.
.
. Objects:
.       EDITTEXT
.
. dnumnvar values:
.
.       The <dnumnvar> value defines number of characters.
.
*------------------------------------------------------------------------------
.   MDIBORDER=dnumnvar                       CREATE  SETPROP  GETPROP
.
. Description:
.       This property defines when a MDI client window in a window object
.       is to have a border.
.
. Objects:
.       WINDOW
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   MDIHEIGHT=dnumnvar                       CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies the height in pixels for the MDI client
.       window. If this property is zero, the bottom of the MDI client
.       is pinned to the bottom of the WINDOW object.
.
. Objects:
.       WINDOW
.
*------------------------------------------------------------------------------
.   MDILEFT=dnumnvar                         CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies the left position in pixels for the MDI client
.       window.
.
. Objects:
.       WINDOW
.
*------------------------------------------------------------------------------
.   MDISCROLL=dnumnvar                       CREATE           GETPROP
.
. Description:
.       This property specifies what type of scrollbars are to be provided
.       for the MDI client window in a window object. Actual scrollbar
.       handling is automatically performed.
.
. Objects:
.       WINDOW
.
. dnumnvar values:
.
.$NONE        EQU       0              // Default
.$SCRBOTH      EQU      1
.$SCRHORZ      EQU      2
.$SCRNONE      EQU      3
.$SCRVERT      EQU      4
*------------------------------------------------------------------------------
.   MDITOP=dnumnvar                          CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies the top position in pixels for the MDI client
.       window.
.
. Objects:
.       WINDOW
.
*------------------------------------------------------------------------------
.   MDIWIDTH=dnumnvar                        CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies the width in pixels for the MDI client
.       window. If this property is zero, the right of the MDI client
.       is pinned to the right of the WINDOW object.
.
. Objects:
.       WINDOW
.
*------------------------------------------------------------------------------
.   MIN=dnumnvar                             See Objects:
.
. Description:
.       This property defines the minimum value when the slider thumb is at
.       the top or left most position of the supported object.
.
. Objects:
.       HSCROLLBAR                                   SETPROP  GETPROP
.       SLIDER                               CREATE  SETPROP  GETPROP
.       VSCROLLBAR                                   SETPROP  GETPROP
.
. dnumnvar values:
.
.       The value is a logical unit as specified by the user.
.
*------------------------------------------------------------------------------
.   MINBOX=dnumnvar                          CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies when a MINIMIZE box for the window
.       object should be allowed or not.
.
.       Note1: The MINBOX property does not have an effect if the 
.              CAPTION property is set to $OFF for a MODAL or MODELESS
.              window type.
.
. Objects:
.       WINDOW
.
. dnumnvar values:
.
.$OFF         EQU       0
.$ON          EQU       1              // Default
.
*------------------------------------------------------------------------------
.   MINSCROLLH=dnumnvar                      CREATE  SETPROP  GETPROP
.
. Description:
.       This property is used in conjunction with the AUTOSCROLL property
.       to specify the minimum horizontal size the window can shrink to
.       before scrollbars appear.
.
. Objects:
.       WINDOW
.
*------------------------------------------------------------------------------
.   MINSCROLLV=dnumnvar                      CREATE  SETPROP  GETPROP
.
. Description:
.       This property is used in conjunction with the AUTOSCROLL property
.       to specify the minimum vertical size the window can shrink to
.       before scrollbars appear.
.
. Objects:
.       WINDOW
.
*------------------------------------------------------------------------------
.   MULTILINE[=dnumnvar]                     CREATE  SETPROP  GETPROP
.
. Description:
.       This property defines the number of lines to be allowed
.       for an edittext object.  If a user <dnumnvar> value
.       is not specified, then the number of lines allowed is
.       set to 32000.  If the number of lines specified can
.       fit into the user specified rectangle coordinates, then
.       scrollbars are not provided.  Otherwise, scrollbars will
.       exist for the edittext object.
.
. Objects:
.       EDITTEXT
.
. dnumnvar values:
.
.       The <dnumnvar> value specifies number of lines.
.
*------------------------------------------------------------------------------
.   MULTIROW=dnumnvar                        CREATE  SETPROP  GETPROP
.
. Description:
.       This property is used to indicate if labels are allowed to be 
.       shown in multiple rows. If multiple rows are not allowed, and
.       the labels are too large to fit in one row, left and right 
.       arrow buttons are drawn to allow access to the other labels.
.
. Objects:
.       TABCONTROL
.
. dnumnvar values:
.
.$OFF         EQU       0            // Default
.$ON          EQU       1              
.
*------------------------------------------------------------------------------
.   MULTISELECT[=dnumnvar]                   CREATE  SETPROP  GETPROP
.
. Description:
.       This property allows a multiple items to be selected from an
.       object.  If the <dnumnvar> parameter is not provided, the
.       MULTISELECT is set to ON.  
.
.       Note1:  The SETPROP statement does not support this property for
.               the DATALIST object.
.
.       Note2:  The $EXTENDED value is only valid for a DATALIST object.
.               When $EXTENDED is used for MULTISELECT type, then the
.               DATALIST allows a range of items to be selected by using
.               the SHIFT key or the MOUSE.
.
.       Note3:  When this property is turned ON for the LISTVIEW object,
.               then multiple entries can be selected by using the SHIFT
.               key and the MOUSE.  This action is controlled by Windows.
.
. Objects:
.       DATALIST
.       LISTVIEW
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
$EXTENDED     EQU       2              // DATALIST only
.
*------------------------------------------------------------------------------
.   NEGBORDERS=dnumnvar                      CREATE  SETPROP  GETPROP
.
. Description:
.       This property is available for a WINDOW object to identify
.       whether the runtime should negotiate border usage for a
.       CONTAINER object create on the WINDOW.
.       
. Objects:
.       WINDOW
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   NEGMENUS=dnumnvar                        CREATE  SETPROP  GETPROP
.
. Description:
.       This property is available for a WINDOW object to identify
.       whether the runtime should negotiate menu usage for a
.       CONTAINER object create on the WINDOW.
.
.       Note:
.            1. When the NEGMENUS property is set to $ON, then user
.               PL/B MENU string controls named '<l', '<L', '<m', '<M',
.               '<r', and '<R' can be used to identify the positioning of
.               a form's top level menu items as melded/integrated with the
.               menu items for a CONTAINER object.  If none of these
.               controls are specified, then the PL/B window menu items
.               will be replaced by the menu items for a CONTAINER object
.               when the CONTAINER has the focus; and the PL/B window menu
.               items will be available when the CONTAINER does not have
.               the focus.  These menu string controls are defined as follows:
.
.                   -l or -L    -  A top level PL/B menu item is to be placed
.                                  to the left of the menu items for a
.                                  CONTAINER object.
.
.                   -r or -R    -  A top level PL/B menu item is to be placed
.                                  to the right of the menu items for a
.                                  CONTAINER object.
.
.                   -m or -M    -  A top level PL/B menu item is to be placed
.                                  into the middle of the menu items for a
.                                  CONTAINER object.  The actual placement
.                                  of the top level PL/B menu item in this
.                                  case is actually controlled by the current
.                                  CONTAINER object being executed.
.       
. Objects:
.       WINDOW
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   NOAUTOZOOM  (OBSELETE)                   CREATE
.
. Description:
.       This is an obselete property maintained only for backward
.       source compatibility.  The NOAUTOZOOM property is the same
.       as AUTOZOOM=0.
.
.       Note1:  The AUTOZOOM property must be used if SETPROP/GETPROP
.               operations are required.
.
. Objects:
.       PICT
.
. dnumnvar values:
.
.       None
.
*------------------------------------------------------------------------------
.   NOINTEGRAL  (OBSELETE)                   CREATE
.
. Description:
.       This property is a CREATE only property and is obselete.
.       This property maintained only for backward source compatibility.
.       The NOINTEGRAL property is the same as INTEGRAL=0.
.
.       Note1:  The INTEGRAL property must be used if SETPROP/GETPROP
.               operations are required.
.
. Objects:
.       DATALIST
.
. dnumnvar values:
.
.       None
.
*------------------------------------------------------------------------------
.   NOMENURESIZE=dnumnvar                    CREATE  SETPROP  GETPROP
.
. Description:
.       This property is available for a WINDOW object to specify when
.       the overall WINDOW object height should be changed or not
.       should a MENU object be created and added to the WINDOW object.
.       When the NOMENURESIZE property value is set to zero, this
.       will cause the overall WINDOW object height to be increased when
.       a MENU object is added such that the client height is unchanged
.       for the WINDOW object.  However, if the NOMENURESIZE property
.       value is set to a non-zero value, this will cause the overall
.       WINDOW object height to remain unchanged when a MENU object
.       is added such that the client height for the WINDOW object
.       is changed.
.
. Objects:
.       WINDOW
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   NOPERCENT   (OBSELETE)                   CREATE
.
. Description:
.       This property is a CREATE only property and is obselete.
.       This property maintained only for backward source compatibility.
.       The NOPERCENT property is the same as PERCENT=0.
.
.       Note1:  The PERCENT property must be used if SETPROP/GETPROP
.               operations are required.
.
. Objects:
.       PROGRESS
.
. dnumnvar values:
.
.       None
.
*------------------------------------------------------------------------------
.   NORESIZE    (OBSELETE)                   CREATE
.
. Description:
.       This property is a CREATE only property and is obselete.
.       This property maintained only for backward source compatibility.
.       The NORESIZE property is the same as RESIZE=0.
.
.       Note1:  The RESIZE property must be used if SETPROP/GETPROP
.               operations are required.
.
. Objects:
.       PICT
.
. dnumnvar values:
.
.       None
.
*------------------------------------------------------------------------------
.   NOSCROLL    (OBSELETE)                   CREATE
.
. Description:
.       This property is a CREATE only property and is obselete.
.       This property maintained only for backward source compatibility.
.       The NOSCROLL property is the same as SCROLLBAR=0.
.
.       Note1:  The SCROLLBAR property must be used if SETPROP/GETPROP
.               operations are required.
.
. Objects:
.       PICT
.
. dnumnvar values:
.
.       None
.
*------------------------------------------------------------------------------
.   NUMERIC[=dnumnvar]                       CREATE
.
. Description:
.       This property is a CREATE only property.
.       The property specifies that the EDITTEXT object is to allow 
.       numeric digits 0 through 9, '-' character, and '.' character.
.       When this property is set to the OFF state, this indicates that
.       all characters are allowed.  If the <dnumnvar> value is not
.       provided, the NUMERIC property is set to ON.
.
.       Note1: Use of the property should be replaced through use of 
.              the EDITTYPE property.
.
. Objects:
.       EDITTEXT
.
. dnumnvar values:
.
.$OFF         EQU       1              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   OBJECTID=dnumnvar                        CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies a identification number for an object.
.       The OBJECTID value is available through the use of the EVENTINFO
.       or EVENTREG statements to identify the object which caused
.       an event to occur.
.
. Objects:
.       AUTOMATION
.       BUTTON
.       CHECKBOX
.       CHECKGRP
.       COMBOBOX
.       CONTAINER
.       CONTROL
.       DATALIST
.       DIALOG
.       EDITTEXT
.       FLOATMENU
.       GROUPBOX
.       HSCROLLBAR
.       ICON
.       LINE
.       LISTVIEW
.       MENU
.       MREGION
.       MOVIE
.       PICT
.       POPUPMENU ( OBSELETE )
.       PROGRESS
.       RADIOGRP
.       RADIO
.       SHAPE
.       SLIDER
.       STATTEXT
.       SUBMENU
.       TABCONTROL
.       TIMER
.       TREEVIEW
.       VSCROLLBAR
.       WINDOW
.
. dnumnvar values:
.
.       The <dnumvar> is a user specified number to identify an object.
.
*------------------------------------------------------------------------------
.   OLEDROP=dnumnvar                         CREATE  SETPROP  GETPROP
.
. Description:
.       This property enables or disables the capability of dropping an 
.       OLE insertable object on an empty OLE container object.
.
. Objects:
.       CONTAINER
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   OLETYPE=dnumnvar                         GETPROP
.
. Description:
.       This property returns the type of OLE insertable object in the
.       OLE container object. This property is only valid for a GETPROP
.       statement.  Also, see the property OLETYPEA as a related property.
.       The OLETYPE property will return one of:
.
.       $OLETYPEEMPTY   - The OLE container object is empty.           
.       $OLETYPEEMBED   - The OLE container object contains a embedded
.                         OLE insertable object.
.       $OLETYPELINK    - The OLE container object contains a linked
.                         OLE insertable object.
.
. Objects:
.       CONTAINER
.
. dnumnvar values:
.
$OLETYPEEMPTY   EQU     1              
.$OLETYPEEMBED  EQU     2
.$OLETYPELINK   EQU     3
.
*------------------------------------------------------------------------------
.   OLETYPEA=dnumnvar                        CREATE  SETPROP  GETPROP
.
. Description:
.       This property is used to control the type of OLE insertable object
.       allowed in an OLE container object. This property affects any
.       method used to place a OLE insertable object into a OLE container 
.       object. See the property OLETYPE as a related property. It must 
.       be one of:
.
.       $OLETYPEBOTH    - The OLE container object can contain either an
.                         embedded or linked OLE insertable object.            
.       $OLETYPEEMBED   - The OLE container object must contain a embedded
.                         OLE insertable object.
.       $OLETYPELINK    - The OLE container object must contain a linked
.                         OLE insertable object.
.
. Objects:
.       CONTAINER
.
. dnumnvar values:
.
$OLETYPEBOTH    EQU     1              
$OLETYPEEMBED   EQU     2
$OLETYPELINK    EQU     3
.
*------------------------------------------------------------------------------
.   ORIENTATION=dnumnvar                     CREATE  SETPROP  GETPROP
.
. Description:
.       The property controls the whether a slider object is to be
.       horizontal or vertical.
.
. Objects:
.       SLIDER
.
. dnumnvar values:
.
.$NONE        EQU       0              // Same as $VERT
$HORZ         EQU       1
$VERT         EQU       2              // Default
.
*------------------------------------------------------------------------------
.   OVERTYPE=dnumnvar                        CREATE  SETPROP  GETPROP
.
. Description:
.       The property controls whether an EDITTEXT object is allow data
.       entry to overtype current data for the object.
.
. Objects:
.       EDITTEXT
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   PAGE=dnumnvar                            CREATE 
.
. Description:
.       This is a CREATE only property.
.       This property specifies the page to be used for the pict object
.       when a DCX picture is used.
.
. Objects:
.       PICT
.
. dnumnvar values:
.
.       The <dnumnvar> specifies a page value.
.
*------------------------------------------------------------------------------
.   PARENTWIN=<WINDOW> object                CREATE  SETPROP
.   PARENTWIN=<nvar>                                         GETPROP
.
. Description:
.       This property identifies a WINDOW object which is to be the parent
.       window for a WINDOW being created or changed.  This property can
.       be used in a CREATE or SETPROP statement for the operation.  The
.       PARENTWIN property can also be used in a GETPROP statement to
.       retrieve the parent window handle for a WINDOW object.  Please
.       the following about the PARENTWIN property:
.       Note1: The SYSMENU property does not have an effect if the 
.
.       Note1: If a WINDOW object specified for the PARENTWIN property
.              has not been created, then an O121 error will occur.
.
.       Note2: A WINDOW object which has been created as a MODAL or
.              MODELESS type cannot be used as the parent for another
.              window.  An O134 error will occur if a MODAL or MODELESS
.              window is specified as a parent window.
.
.       Note3: An O134 error will occur if a PARENTWIN property is used
.              for a MODAL WINDOW object.  A parent window cannot be
.              specified for a MODAL WINDOW object.
.
.       Note4: The PARENTWIN property can be used for any window created
.              as a PRIMARY or MODELESS type.
.
.       Note5: If a parent window is DESTROYed, then any windows that
.              the parent has ownership of will also be destroyed.
.
. Objects:
.       WINDOW
.
. <Window> object operand:
.
.       The <Window> object must be a reference to a window which has
.       previously been created.
.
. nvar values:
.
.       The <nvar> value retrieved by GETPROP is the window handle for a
.       parent window.
.
*------------------------------------------------------------------------------
.   PASSWORD[=dnumnvar]                      CREATE
.
. Description:
.       This is a CREATE only property.
.       This property specifies that the edittext is to have each
.       character echoed as a '*' character.  If the <dnumnvar> value
.       is not specified, the PASSWORD property is set to ON.
.
. Objects:
.       EDITTEXT
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   PERCENT=dnumnvar                         CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies if a percentage value is to be displayed
.       for the progress object or not.
.
. Objects:
.       PROGRESS
.
. dnumnvar values:
.
.$OFF         EQU       0
.$ON          EQU       1              // Default
.
*------------------------------------------------------------------------------
.   PICTSIZEH=nvar                                          GETPROP
.
. Description:
.       This property is a GETPROP only property. This retrieves the
.       horizontal size of a picture. The value is expressed in pixels.
.
. Objects:
.       PICT
.
. nvar values:
.
.       The <nvar> value retrieved is the horizontal pixel size of the picture.
.
*------------------------------------------------------------------------------
.   PICTSIZEV=nvar                                          GETPROP
.
. Description:
.       This property is a GETPROP only property. This retrieves the
.       vertical size of a picture. The value is expressed in pixels.
.
. Objects:
.       PICT
.
. nvar values:
.
.       The <nvar> value retrieved is the vertical pixel size of the picture.
.
*------------------------------------------------------------------------------
.   PICTURE=dnumnvar|svarslit|pict object    CREATE  SETPROP
.
. Description:
.       This property is supported only for CREATE and SETPROP statements.
.       The property specifies when a picture is to replace the text for a
.       BUTTON object.  This property is supported only for Windows95/98/NT.
.       The allowed picture type can be any of the normally supported PICT
.       object formats.  This property is under the control of the Windows
.       API and there is no operations to resize the picture.
.
. Objects:
.       BUTTON
.
. operand values:
.
.       The <dnumnvar> value is used to identify a 'resource id' to be used
.       when retrieving the picture.  This value can be any user defined
.       resource identication values as provided in a resource library.
.       If the 'resource id' value is zero, then the PICTURE property is
.       removed from the BUTTON object and the text name fo rthe BUTTON
.       will be used.
.
.       The <svarslit> string specifies a picture file name which is to be used
.       for the BUTTON object.  The picture file name will default to an
.       extension of '.bmp'.  This name supports the $MACRO and generic
.       PLBVOL_ file name formats.  The runtime will use the 'PLB_PATH'
.       directories to initially locate the file. If the file is not found
.       using the 'PLB_PATH' directories, then the file is passed to Windows
.       to be located in the Windows directories.  If the <svarslit> string
.       is NULL, then the PICTURE property is removed from the BUTTON object
.       and the text name for the BUTTON will be used.
.
.       The <pict> object can be specified where the <pict> object must have
.       been previously created.  The data for the <pict> object is used
.       for the button.
.
*------------------------------------------------------------------------------
.   POS=dnumnvarH:dnumnvarV                          SETPROP  GETPROP
.
. Description:
.       This property is a SETPROP/GETPROP only property.
.       The POS property specifies the starting horizontal and vertical
.       pixel coordinate in a pict object where the picture is to be
.       displayed.
.
. Objects:
.       PICT
.
. dnumnvar values:
.
.       The <dnumnvarH> value is the horizontal pixel coordinate in the pict.
.       The <dnumnvarV> value is the vertical pixel coordinate in the pict.
.
*------------------------------------------------------------------------------
.   PRINTER[=dnumnvar]                       CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies that the datalist object is to be filled
.       with the current Windows printer names.  If the <dnumnvar> value
.       is not provided, the PRINTER property is set to ON.
.
. Objects:
.       DATALIST
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   READONLY[=dnumnvar]                      CREATE           GETPROP
.
. Description:
.       This property specifies that the edittext object is a read only
.       object.  The user can place the caret into the edittext object
.       to cut/copy data, however, the current edittext data can not
.       be changed by the user.  If the <dnumnvar> value is not specified,
.       the READONLY property is turned on.
.
.       Note1: The CREATE statement is required to envoke the READONLY
.              property.  It is not possible to envoke the READONLY property
.              by a SETPROP statement.
.
. Objects:
.       EDITTEXT
.
. dnumnvar values:
.
.$OFF         EQU       0              Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   RESIZE=dnumnvar                          CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies if a picture is to be resized to fit
.       pict object rectangle coordinates.
.
. Objects:
.       PICT
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   RESOURCE=dnumnvar                                SETPROP  GETPROP
.
. Description:
.       This property is a SETPROP/GETPROP only property.
.       The RESOURCE property allows a resource id to be retreived/changed
.       for supported objects.
.
. Objects:
.       ICON
.       PICT
.
. dnumnvar values:
.
.       The <dnumnvar> value is valid resource id which can be found
.       in a resource DLL or resources loaded for a PLFORM.
.
*------------------------------------------------------------------------------
.   RIGHT[=dnumnvar]                         CREATE
.
. Description:
.       The RIGHT property specifies that the text is to be right justified 
.       horizontally for the object.  The property is replaced by 
.       the ALIGNMENT property.  The ALIGNMENT property is to be used
.       for performing SETPROP and GETPROP operations.
.
.       If the syntax form is used where the <dnumnvar> value is not
.       specified, this indicates that the RIGHT property is to be
.       turned on.
.
.       Also note that if the RIGHT property is turned off, this causes
.       the text output to be justified to the left.
.
. Objects:
.       EDITTEXT
.       STATTEXT
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   RIGHTBUTTON[=dnumnvar]                   CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies whether the right mouse button can be
.       used to cause an event or not.  If the <dnumnvar> value
.       is not provided, the RIGHTBUTTON property is turned on.
.
. Objects:
.       FLOATMENU
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   SCALE=dnumnvar                           CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies a percentage by which a picture object
.       is scaled.
.
. Objects:
.       PICT
.
. dnumnvar values:
.
.       The <dnumnvar> value is percentage value.
.
*------------------------------------------------------------------------------
.   SCROLLBAR[=dnumnvar]                     CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies what type of scrollbars are to be provided
.       for a edittext, picture, or window object.  If the <dnumnvar> value
.       is not provided, the SCROLLBAR property is set to $SCRBOTH.
.
. Objects:
.       EDITTEXT
.       PICT
.       WINDOW
.
. dnumnvar values:
.
.$NONE        EQU       0              // Default
$SCRBOTH      EQU       1
$SCRHORZ      EQU       2
$SCRNONE      EQU       3
$SCRVERT      EQU       4
.
*------------------------------------------------------------------------------
.   SELECTALL=dnumnvar                       CREATE  SETPROP  GETPROP
.
. Description:
.       The property controls whether all of the data for an EDITTEXT object is
.       be selected or not selected when the object gains the focus.  If this
.       property is set to ON, then all of the data in the object is
.       automatically highlighted when the object gains the focus.
.
. Objects:
.       EDITTEXT
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   SELGROUPID=nvar                                           GETPROP
.
. Description:
.       This property is a GETPROP only property.  This property returns
.       the OBJECTID value for a RADIO object which is currently selected
.       within a radio group identified by a GROUPID value.  If this
.       property is used for a RADIO object which is NOT included in any
.       radio group, then the single RADIO object is processed as a radio
.       group of one and the OBJECTID of the single RADIO object is
.       returned when the RADIO object is selected.  In all cases, a value
.       of zero is returned when no RADIO object is selected for a radio
.       group.
.
. Objects:
.       RADIO
.
. nvar values:
.
.             The OBJECTID is returned in the {nvar} variable for a 
.             selected RADIO object in a radio group.
.
*------------------------------------------------------------------------------
.   SELLENGTH=dnumnvar                       CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies the number of units to highlight in
.       the slider object view when the SELRANGE property is set to ON.
.       It is recommended that the SELLENGTH value be defined in the
.       range specified by the MAX and MIN property values.
.
.       Note1:  The highlighted output does not occur when the SELLENGTH
.               property value plus the SELSTART value is greater than
.               32767.  The highlighted output may not occur if 'nvar'
.               value is negative.
.               
.
. Objects:
.       SLIDER
.
. dnumnvar values:
.
.       The <dnumnvar> value is logical user specified units.
.
*------------------------------------------------------------------------------
.   SELRANGE=dnumnvar                        CREATE  SETPROP  GETPROP
.
. Description:
.       The property specifies if a highlighted selection is to be 
.       applied to the slider object.  When this PROPERTY it turned
.       ON, the slider object uses the SELSTART and SELLENGTH
.       values to define the highlighted selection output.
.
. Objects:
.       SLIDER
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   SELSTART=dnumnvar                        CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies the starting logical unit from which
.       the slider object begins the highlighed output when the SELRANGE
.       property is set to ON.
.
.       Note1:  The highlighted output does not occur when the SELLENGTH
.               property value plus the SELSTART value is greater than
.               32767.  The highlighted output may not occur if 'nvar'
.               value is negative.
.
. Objects:
.       SLIDER
.
. dnumnvar values:
.
.       The <dnumnvar> value is logical user specified unit.
.
*------------------------------------------------------------------------------
.   SHAPE=dnumnvar                           CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies the type of shape to be output for the
.       shape object.  If the SHAPE property is invalid, the shape
.       object defaults to a rectangle output.
.
. Objects:
.       SHAPE
.
. dnumnvar values:
.
.$NONE        EQU       0              // Same as $RECTANGLE
$OVAL         EQU       1
$RECTANGLE    EQU       2              // Default
$RNDRECT      EQU       3
.
*------------------------------------------------------------------------------
.   SHIFT=dnumnvar                           See Objects:
.
. Description:
.       This property defines the number of units to move the slider
.       thumb when the mouse is clicked in the object slide area.
.       This also occurs when the page up or page down keys are entered.
.
. Objects:
.       HSCROLLBAR                                   SETPROP  GETPROP
.       SLIDER                               CREATE  SETPROP  GETPROP
.       VSCROLLBAR                                   SETPROP  GETPROP
.
. dnumnvar values:
.
.       The value is a logical unit as specified by the user.
.
*------------------------------------------------------------------------------
.   SIZE=dnumnvar                            CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies the point size for a font object.
.
. Objects:
.       FONT
.
. dnumnvar values:
.
.       The <dnumnvar> value is a point size for a font.
.
*------------------------------------------------------------------------------
.   SIZEMODE=dnumnvar                        CREATE  SETPROP  GETPROP
.
. Description:
.       This property is used to control how the OLE insertable object is 
.       displayed within an OLE container object. It may be one of:
.
.       $SIZEMODEAUTO   - The OLE container object window is re-sized to 
.                         the size of the OLE insertable object. 
.       $SIZEMODECLIP   - The OLE insertable object is clipped to the size of
.                         the OLE container object window. 
.       $SIZEMODESCALE  - The OLE insertable object is evenly scaled for 
.                         a best fit in the OLE container object window. 
.       $SIZEMODESTRETCH - The OLE insertable object is scaled to fully fit
.                         in the OLE container object window. 
.
. Objects:
.       CONTAINER
.
. dnumnvar values:
.
$SIZEMODEAUTO    EQU       1            
$SIZEMODECLIP    EQU       2            // Default
$SIZEMODESCALE   EQU       3
$SIZEMODESTRETCH EQU       4
.
*------------------------------------------------------------------------------
.   SORTED[=dnumnvar]                        CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies that the items in the datalist object
.       are to be sorted.  If the <dnumnvar> value is not provided,
.       the SORTED property is turned ON.
.
.       Note1:  When the SORTED property is used, Windows controls the
.               sorting method.  The Windows method is to sort the
.               item name field alphabetically starting with the first
.               character.  Windows does not support any alternate sorting
.               methods.
.
.       Note2:  For a DATALIST, the SORTED property can only be used in
.               a CREATE or GETPROP operation.
.
. Objects:
.       COMBOBOX
.       DATALIST
.       POPUPMENU ( OBSELETE )
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   SORTHEADER=dnumnvar                      CREATE           GETPROP
.
. Description:
.       This property indicates that column headers will act like buttons.
.       If set to $ON, then the user can click on a column header and the
.       program will receive a $COLCLICK event.  This provides a means
.       where a user application can determine which column has been
.       selected by a user with the intended action being that the
.       application can sort the data using the column data.
.
.       Note1:  Neither Windows nor the runtime automatically sorts the
.               data for a selected column.  This is the responsibility
.               of the user application program.
.
. Objects:
.       LISTVIEW
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   SORTORDER=dnumnvar                       CREATE          GETPROP
.
. Description:
.       This property indicates the default sort order of items in the
.       first/left most column. This property can be set to one of the
.       following:
.
.       $SORTACS  - Sort item text labels in a ascending fashion.
.       $SORTDCS  - Sort item text labels in a descending fashion.
.       $SORTNONE - No default sort order.
.
. Objects:
.       LISTVIEW
.
. dnumnvar values:
.
$SORTACS      EQU       1
$SORTDCS      EQU       2
$SORTNONE     EQU       3              // Default
.
*-----------------------------------------------------------------------------
.   SOURCEDOC=svarslit                       CREATE  SETPROP  GETPROP
.
. Description:
.       This property is the filename name used as data for the OLE insertable
.       object. If set, the current OLE insertable object in a OLE container 
.       object will be replaced by a OLE insertable object created from the
.       data in the file.
.
. Objects:
.       CONTAINER
.
. svarslit values:
.
.       The <svarslit> is a filename.
.
*-----------------------------------------------------------------------------
.   STATIC[=dnumnvar]                        CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies that the edittext object is used for
.       output only purposes.  An edittext object with this property
.       can not get the focus and not cut/copy operations can be perform.
.
. Objects:
.       EDITTEXT
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   STYLE=dnumnvar|3DON|3DOFF|3DFLAT|3DOUT   CREATE  SETPROP  GETPROP
.
. Description:
.       The STYLE property specifies when an object should
.       have a 3D look or a non-3D look.  The various forms of STYLE
.       defines that an object can have presentations as follows:
.
.         3DOFF - Object does not have a 3D look.
.         3DON  - Ojbect has a 3D sunken look.
.         3DFLAT- Object has a 3D flat look.
.         3DOUT - Object has a 3D outward look.
.
.       Note1: Some objects are limited to presentations described as
.              3DON or 3DOFF only.  For these objects the user should
.              use the APPEARANCE property and not the STYLE property.
.
. Objects:
.       CHECKBOX                (See Note1:)
.       CHECKGRP                (See Note1:)
.       COMBOBOX                (See Note1:)
.       CONTAINER
.       DATALIST                (See Note1:)
.       EDITTEXT
.       GROUPBOX
.       MOVIE
.       PICT
.       POPUPMENU ( OBSELETE )  (See Note1:)
.       PROGRESS
.       RADIOGRP                (See Note1:)
.       RADIO                   (See Note1:)
.       STATTEXT
.       WINDOW                  (See Note1:)
.
. dnumnvar values:
.
$DEFAULT      EQU       0              // Default
$3DON         EQU       1
$3DOFF        EQU       2
$3DFLAT       EQU       3
$3DOUT        EQU       4
.
*------------------------------------------------------------------------------
.   SYSMENU=dnumnvar                         CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies whether a window object should output
.       a sysmenu or not.
.
.       Note1: The SYSMENU property does not have an effect if the 
.              CAPTION property is set to $OFF for a MODAL or MODELESS
.              window type.
.
. Objects:
.       WINDOW
.
. dnumnvar values:
.
.$OFF         EQU       0
.$ON          EQU       1              // Default
.
*------------------------------------------------------------------------------
.   TABFIXHTH=dnumnvar                       CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies the height in pixels for the 
.       TABCONTROL labels.  This property only takes affect when the
.       TABWTHSTYLE property is set to FIXED.
.
. Objects:
.       TABCONTROL
.
. dnumnvar values:
.
.       The <dnumnvar> value is the number of pixels for label height.
.
*------------------------------------------------------------------------------
.   TABFIXWTH=dnumnvar                       CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies the width in pixels for the 
.       TABCONTROL labels.  This property only takes affect when the
.       TABWTHSTYLE property is set to FIXED.
.
. Objects:
.       TABCONTROL
.
. dnumnvar values:
.
.       The <dnumnvar> value is the number of pixels for label width.
.
*------------------------------------------------------------------------------
.   TABID=dnumnvar                           CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies the location of this object in the
.       tabbing order sequence.  If the TABID property is not used, the
.       object is assigned an internal tabbing order value which is 
.       determined by the order that objects are created and an 
.       intial TABID value specified for the window of the object.  If the
.       TABID property id is specified, then the value of the TABID
.       determines the location of the object in the tabbing sequence.
.       The tabbing sequence processes from lower TABID valued objects
.       to higher TABID valued objects as the TAB key is entered.
.
.       Note1:  The *NODEFTABID=OFF in the SETMODE statement can be
.               used to exclude any object with an internally assigned
.               tabid from the tabbing sequence.
.
. Objects:
.       BUTTON
.       CHECKBOX
.       CHECKGRP
.       COMBOBOX
.       CONTAINER
.       CONTROL
.       DATALIST
.       EDITTEXT
.       HSCROLLBAR
.       LISTVIEW
.       POPUPMENU ( OBSELETE )
.       RADIOGRP
.       RADIO
.       SLIDER
.       TABCONTROL
.       TREEVIEW
.       VSCROLLBAR
.       WINDOW
.
. dnumnvar values:
.
.       The <dnumnvar> value is a user specified value to tabbing order.
.
*------------------------------------------------------------------------------
.   TABLABEL=svarslit                        CREATE  SETPROP  GETPROP
.
. Description:
.       This property provides the data items used to generate the
.       TABCONTROL labels.  The data provided in the <svarslit> is
.       set of items separated by semicolon characters.  If the TABLABEL 
.       is not specified or the <svarslit> is NULL, then the TABCONTROL
.       will not have any tab labels.
.
. Objects:
.       TABCONTROL
.
. svarslit values:
.
.       The <svarslit> is a list of items separated by a semicolon.
.
*------------------------------------------------------------------------------
.   TABSTOPS=svarslit                        CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies a data string which is composed of tabstop
.       location values separated by semicolon characters.  See the manual
.       for detailed description.
.
. Objects:
.       DATALIST
.
. svarslit values:
.
.       The <svarslit> data string is tabstop location values separated
.       by semicolons.
.
*------------------------------------------------------------------------------
.   TABWTHSTYLE=dnumnvar                     CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies the look of the labels. If the $FIXED 
.       value is used, the TABFIXHTH and TABFIXWTH properties determine
.       the height and width of the labels. The $JUST value causes any
.       multiple row TABCONTROL to size the labels evenly to fill each row.
.
. Objects:
.       TABCONTROL
.
. dnumnvar values:
.
.$NONE        EQU       0
$FIXED        EQU       1
$JUST         EQU       2
$NOJUST       EQU       3
.
*------------------------------------------------------------------------------
.   TICKFREQ=dnumnvar                        CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies the frequency at which tick marks are
.       applied to the slider object output.  The <dnumnvar> value for
.       this property should be in the range of the MIN and MAX values.
.
. Objects:
.       SLIDER
.
. dnumnvar values:
.
.       The <dnumnvar> is a user logical unit value.
.
*------------------------------------------------------------------------------
.   TICKSTYLE=dnumnvar                       CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies the type of look that a slider object
.       takes on.  This property causes tick unit marks 
.       to be placed on either side of the slide thumb control;
.       on both sides of the slide thumb control; or no tick
.       mark output at all.  The number of tick units to be applied
.       depend on the MAX, MIN, and TICKFREQ property values.
.
.       Note1: Values other than those shown for <dnumnvar> result in
.              no tick mark output.
.
. Objects:
.       SLIDER
.
. dnumnvar values:
.
.$NONE        EQU       0
$TICKBOTH     EQU       1
$TICKBOTTOM   EQU       2
$TICKRIGHT    EQU       2
$TICKTOP      EQU       4
$TICKLEFT     EQU       4
.
*------------------------------------------------------------------------------
.   TITLE=svarslit                           CREATE  SETPROP  GETPROP
.
. Description:
.       This property allows a title to be specified for the supported
.       objects.
.
. Objects:
.       CHECKGRP
.       GROUPBOX
.       RADIOGRP
.       WINDOW
.
. svarslit values:
.
.       The <svarslit> variable is a title string.
.
*------------------------------------------------------------------------------
.   TOOLTIP=svarslit                         CREATE  SETPROP  GETPROP
.
. Description:      
.       This property allows a user specified string to be provided in a
.       tooltip window for an object.
.
. Objects:
.       BUTTON
.       CHECKBOX
.       COMBOBOX
.       CONTAINER
.       CONTROL
.       DATALIST
.       EDITTEXT
.       GROUPBOX
.       HSCROLLBAR
.       ICON
.       LISTVIEW
.       MREGION
.       MOVIE
.       PICT
.       STATTEXT
.       PROGRESS
.       RADIO
.       SHAPE
.       SLIDER
.       TABCONTROL
.       TREEVIEW
.       VSCROLLBAR
.
. svarslit values:
.
.       The <svarslit> variable is a tooltip string.
.
*------------------------------------------------------------------------------
.   TOOLTIPHWND=nvar                                          GETPROP
.
. Description:      
.       This property is a GETPROP only property.  The TOOLTIPHWND property
.       value is a Windows window handle for the supported object TOOLTIP
.       window.  This TOOLTIPHWND value can be used in WINAPI functions
.       where a window handle is required for the function.
.
. Objects:
.       BUTTON
.       CHECKBOX
.       COMBOBOX
.       CONTAINER
.       CONTROL
.       DATALIST
.       EDITTEXT
.       GROUPBOX
.       HSCROLLBAR
.       ICON
.       LISTVIEW
.       MREGION
.       MOVIE
.       PICT
.       STATTEXT
.       PROGRESS
.       RADIO
.       SHAPE
.       SLIDER
.       TABCONTROL
.       TREEVIEW
.       VSCROLLBAR
.
. nvar values:
.     
.       The <nvar> value returned is the Windows handle for the TOOLTIP
.       window used for a specified object.
.
*------------------------------------------------------------------------------
.   TOP=dnumnvar                                     SETPROP  GETPROP
.
. Description:
.       This property is a SETPROP/GETPROP only property.  The property
.       is the current top coordinate for an object.
.
. Objects:
.       BUTTON
.       CHECKBOX
.       CHECKGRP
.       COMBOBOX
.       CONTAINER
.       CONTROL
.       DATALIST
.       DIALOG
.       EDITTEXT
.       FLOATMENU
.       GROUPBOX
.       HSCROLLBAR
.       ICON
.       LISTVIEW
.       MREGION
.       MOVIE
.       PICT
.       POPUPMENU ( OBSELETE )
.       PROGRESS
.       RADIOGRP
.       RADIO
.       SHAPE
.       SLIDER
.       STATTEXT
.       TABCONTROL
.       TREEVIEW
.       VSCROLLBAR
.       WINDOW
.
. dnumnvar values:
.
.       The <dnumnvar> value is provided in the same units as used when
.       the object was created. 
.
*------------------------------------------------------------------------------
.   TOPMOST=dnumnvar                         CREATE  SETPROP  GETPROP
.
. Description:
.       This property applies only to top-level windows and is ignored for
.       child windows. This property specifies that a window should be placed
.       above all non-topmost windows and should stay above them, even 
.       when the window is deactivated
.
. Objects:
.       WINDOW
.
. dnumnvar values:
.
.$OFF         EQU       0       // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   TREELNSTYLE=dnumnvar                     CREATE  SETPROP  GETPROP
.
. Description:
.       This property indicates the type of lines drawn between parent
.       and children items.
.
.       Note1: When the value of <dnumnvar> is $DEFAULT or greater than
.              the $NOLINES value, then the $LINES is used as the default
.              TREEVIEW line style.
.
. Objects:
.       TREEVIEW
.
. dnumnvar values:
.
.$DEFAULT     EQU       0         //Use Default
$LINES        EQU       1         //Entries are viewed with intersecting lines
$LINESATROOT  EQU       2         //Entries are viewed with intersecting lines
                                  // to a common root entry point
$NOLINES      EQU       3         //Entries do not have intersecting lines
.
*------------------------------------------------------------------------------
.   TRISTATE[=dnumnvar]                      CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies that a checkbox object is to have the
.       capability of a third state or not.  When the TRISTATE property
.       is turned ON, this allows the checkbox object to be checked
.       and grayed as a third state.  When the TRISATE property is turned
.       OFF, the checkbox object only has two states where the checkbox
.       is either blanked or checked.
.
.       Note1:  Under program control the SETITEM statement can be used
.               to set the current state of the checkbox object.
.
. Objects:
.       CHECKBOX
.       CHECKGRP
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   UNITS=dnumnvar                           CREATE  SETPROP  GETPROP
.
. Description:
.       This property specfies the units scale to be used when positioning
.       or sizing objects/grid for a specific WINDOW object.  The allowable
.       units are defined as follows:
.
.       HIENGLISH   - Units specified as .001 inches.
.
.       HIMETRIC    - Units used is .01 centimeters.
.
.       LOENGLISH   - Units specified as .01 inches.
.
.       LOMETRIC    - Units specified as .1 centimeters.
.
.       PIXELS      - Units specified in pixels.
.
.       TWIPS       - Units specified as .05 of a point [1/1440 of an inch].
.
.       Note1: This property affects the following properties:
.              TOP, LEFT, WIDTH, HEIGHT, GRIDSIZEH, GRIDSIZEV,
.              X1, X2, Y1, and Y2. It doesn't affect event results.
.
. Objects:
.       WINDOW
.
. dnumnvar values:
.
$HIENGLISH    EQU       1
$HIMETRIC     EQU       2
$LOENGLISH    EQU       3
$LOMETRIC     EQU       4
$PIXELS       EQU       5              // Default
$TWIPS        EQU       6
.
*------------------------------------------------------------------------------
.   UPDATEOPT=dnumnvar                       CREATE  SETPROP  GETPROP
.
. Description:
.       This property is used to control when the content of an OLE  
.       insertable object is updated within an OLE container object. It 
.       may be one of:
.
.       $UPDATEOPTAUTO   - The content of the OLE insertable object is 
.                          updated any time the data is changed. 
.       $UPDATEOPTFROZEN - The content of the OLE insertable object is 
.                          updated whenever the linked data is saved from 
.                          within the application in which it was created.
.       $UPDATEOPTMANUAL - The content of the OLE insertable object is only 
.                          updated when the Update method is called. 
.
. Objects:
.       CONTAINER
.
. dnumnvar values:
.
$UPDATEOPTAUTO   EQU       1            // Default
$UPDATEOPTFROZEN EQU       2            
$UPDATEOPTMANUAL EQU       3
.
*------------------------------------------------------------------------------
.   UPPERCASE[=dnumnvar]                     CREATE
.
. Description:
.       This property is a CREATE only property.
.       This property specifies that the edittext object is to convert
.       all entered data to uppercase.  When this property is set to
.       be OFF, then this indicates that no data conversion occurs.
.
.       Note1: Use of the property should be replaced by using the EDITTYPE
.              property.
.
. Objects:
.       EDITTEXT
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   USEALTKEY=dnumnvar                       CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies if the Windows ALT+KEY is to be allowed
.       for the stattext object.  If the USEALTKEY property is set to ON,
.       then using an '&' character in the name of the stattext object
.       will allow the ALT+KEY feature to work.  If the USEALTKEY property
.       is set to OFF, then any '&' character in the name of the
.       stattext object is output as part of the name and the ALT+KEY
.       feature does not generate any events for the object.
.
. Objects:
.       STATTEXT
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   USEMASK=dnumnvar                         CREATE           GETPROP
.
. Description:
.       This property is used on CREATE to indicate that the IMAGELIST should 
.       be masked or non-masked. 
.
. Objects:
.       IMAGELIST
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   VALUE=dnumnvar                           CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies the percentage value to be used for a
.       PROGRESS object.  The VALUE property can be used to retrieve and set
.       values for the PROGRESS object as an option to using SETITEM and
.       GETITEM statements.
.
. Objects:
.       PROGRESS
.
. dnumnvar values:
.
.       The <dnumnvar> value can be from 0 to 100.  If a value greater 
.       than 100 is specified, then the value is truncated to be 100.
.
*------------------------------------------------------------------------------
.   VARABSVALUE=svar                                         GETPROP
.
. Description:
.       The VARABSVALUE property can only be used with a GETPROP instruction.
.       This property retrieves the current ABSOLUTE/RAW data for a VARIANT
.       object.  This data can only be retrieved into a DIM variable.  The
.       actual number of bytes retrieved depends on the type of the VARIANT
.       object.  The following table identifies the expected number of 
.       bytes to be retreived for the raw data.  The format of the raw
.       depends on the VARIANT type and is the same as described by Windows
.       documentation.
.
.          VARIANT TYPE         BYTE SIZE
.
.            $VT_EMPTY             0                // nothing
.            $VT_NULL              0                // SQL style Null
.            $VT_I2                2                // 2 byte signed int
.            $VT_I4                4                // 4 byte signed int
.            $VT_R4                4                // 4 byte real
.            $VT_R8                8                // 8 byte real
.            $VT_CY                8                // currency
.            $VT_DATE              8                // date
.            $VT_BSTR              nnn              // Unicode string
.            $VT_DISPATCH          4                // IDispatch FAR*
.            $VT_ERROR             4                // SCODE
.            $VT_BOOL              2                // True=-1, False=0
.            $VT_VARIANT           4                // VARIANT FAR*
.            $VT_UNKNOWN           4                // IUnknown FAR*
.            $VT_UI1               1                // unsigned char
.
. Objects:
.       VARIANT
.
. values:
.
.       The VARIANT absolute/raw data.
.
*------------------------------------------------------------------------------
.   VARPTR=dnumnvar                          CREATE  SETPROP  GETPROP
.
. Description:
.       The VARPTR property identifies when a VARIANT is to be passed to
.       an OLE application for a property/method parameter as a VT_VARIANT.
.       This property causes the runtime to pass a VT_VARIANT to the
.       interface where the VT_VARIANT contains the address of the variant
.       data itself. The requirement for passing a VT_VARIANT is controlled
.       by the OLE application being used by the PLB program.  The
.       {dnumnvar} can be set to zero ( $OFF ) which indicates the VARIANT
.       object is to be processed as a VARIANT, which is the default. If
.       the {dnumnvar} value is set to a non-zero value ( $ON ), then
.       this indicates that the VARIANT object is to be passed to the OLE
.       interface as a VT_VARIANT.
.
. Objects:
.       VARIANT
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   VARTYPE=dnumnvar                         CREATE  SETPROP  GETPROP
.
. Description:
.       The VARTYPE property identifies the VARIANT data type as allowed
.       for conversion between PLB data types and applicable Windows
.       variant types.
.
. Objects:
.       VARIANT
.
. dnumnvar values:
.
$VT_EMPTY     EQU       0              // nothing
$VT_NULL      EQU       1              // SQL style Null
$VT_I2        EQU       2              // 2 byte signed int
$VT_I4        EQU       3              // 4 byte signed int
$VT_R4        EQU       4              // 4 byte real
$VT_R8        EQU       5              // 8 byte real
$VT_CY        EQU       6              // currency
$VT_DATE      EQU       7              // date
$VT_BSTR      EQU       8              // OLE Automation string
$VT_DISPATCH  EQU       9              // IDispatch FAR*
$VT_ERROR     EQU       10             // SCODE
$VT_BOOL      EQU       11             // True=-1, False=0
$VT_VARIANT   EQU       12             // VARIANT FAR*
$VT_UNKNOWN   EQU       13             // IUnknown FAR*
$VT_UI1       EQU       17             // unsigned char
.
*------------------------------------------------------------------------------
.   VARVALUE=dnumnvar                        CREATE  SETPROP GETPROP
.   VARVALUE=svarslit
.   VARVALUE=AUTOMATION object
.   VARVALUE=VARIANT object
.
. Description:
.       The VARVALUE property allows the value of the VARIANT to be
.       assigned in accordance with the VARTYPE of the object.
.
. Objects:
.       VARIANT
.
. values:
.
.       The VARIANT value is processed as per the VARTYPE of the object.
.
*------------------------------------------------------------------------------
.   VIEWSTYLE=dnumnvar                       CREATE  SETPROP  GETPROP
.
. Description:
.       This property indicates what view should be displayed by the  
.       LISTVIEW object. The views are:
.
.       $VIEWICON     - Large Icon
.       $VIEWLIST     - List
.       $VIEWREPORT   - Report
.       $VIEWSICON    - Small Icon
.
. Objects:
.       LISTVIEW
.
. dnumnvar values:
.
$VIEWICON     EQU       1
$VIEWLIST     EQU       2
$VIEWREPORT   EQU       3              // Default
$VIEWSICON    EQU       4
.
*------------------------------------------------------------------------------
.   VISIBLE=dnumnvar                         CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies if an object is to be made visible or
.       invisible.  If the VISIBLE property is set to $ON and the current
.       state of the object is invisible, then this is the same as if
.       if an ACTIVATE statement without any activation routine was 
.       executed for the object.  However, if the VISIBLE property is set 
.       $ON and the object is already visible, then the object remains
.       visible and no change occurs.  If the VISIBLE property is set to
.       $OFF, this is the same as if a DEACTIVATE statement was executed
.       for the object.  The GETPROP retrieves the current VISIBLE state
.       for the object.
.
.       Note1: The VISIBLE property is ignored for a WINDOW object when
.              the WINTYPE is set for MODAL.  This can not be allowed 
.              since the program execution remains at the ACTIVATE
.              statement while the MODAL dialog is processed.  If the
.              VISIBLE property were allowed, then this would cause
.              program execution to remain at the CREATE statement
.              causing a program to hang since no events could be 
.              registered for use.
.
.       Note2: The VISIBLE property for the MREGION object causes the
.              mouse region to be activated or deactivated as per the
.              property value provided.
.              
. Objects:
.       BUTTON
.       CHECKBOX
.       CHECKGRP
.       COMBOBOX
.       CONTAINER
.       CONTROL
.       DATALIST
.       EDITTEXT
.       GROUPBOX
.       HSCROLLBAR
.       ICON
.       LISTVIEW
.       MOVIE
.       MREGION
.       PICT
.       POPUPMENU
.       PROGRESS
.       RADIO
.       RADIOGRP
.       SHAPE
.       SLIDER
.       STATTEXT
.       TABCONTROL
.       TREEVIEW
.       VSCROLLBAR
.       WINDOW
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   WIDTH=dnumnvar                                   SETPROP  GETPROP
.
. Description:
.       This property is a GETPROP/SETPROP only property.  The width
.       of the object can be retrieved using the GETPROP statement.
.       The width is determined by subtracting the left object rectangle
.       coordinate from the right object rectangle coordinate.  The
.       SETPROP statement can be used to change the current width of
.       an object.
.
. Objects:
.       BUTTON
.       CHECKBOX
.       CHECKGRP
.       COMBOBOX
.       CONTAINER
.       CONTROL
.       DATALIST
.       DIALOG
.       EDITTEXT
.       GROUPBOX
.       HSCROLLBAR
.       ICON
.       LISTVIEW
.       MREGION
.       MOVIE
.       PICT
.       POPUPMENU ( OBSELETE )
.       PROGRESS
.       RADIOGRP
.       RADIO
.       SHAPE
.       SLIDER
.       STATTEXT
.       TABCONTROL
.       TREEVIEW
.       VSCROLLBAR
.       WINDOW
.
. dnumnvar values:
.
.       The <dnumnvar> value is provided in the same units as used for
.       the creation of an object.  This means that if an object was
.       created using pixels, then the width expects to use pixels.
.
*------------------------------------------------------------------------------
.   WINBORDER=dnumnvar                       CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies the type of window border for the
.       window object.
.
.       The allowed window borders are as follows:
.
.       NOBORDER      - This style creates a window with no border and
.                       no caption.
.
.       FIXEDSINGLE   - This style creates a window with a single border
.                       that can't be sized.
.
.       FIXED3D       - This style creates a window with a 3D border
.                       that can't be sized.
.
.       SIZABLE3D     - This style is the same as FIXED3D, but allows the
.                       window to be sized.
.
.       FIXEDDIALOG   - Creates a window that has a double border and
.                       can't be sized.
.
.       SIZABLE       - This style is the same as FIXEDSINGLE, but allows the
.                       window to be sized.
.
.       FIXEDTOOL     - This style creates a tool window. This type is a 
.                       window intended to be used as a floating toolbar. A
.                       tool window has a title bar that is shorter than a 
.                       normal title bar, and the window title is drawn 
.                       using a smaller font. A tool window does not appear
.                       in the taskbar or in the dialog that appears when
.                       the user presses ALT+TAB.  If a tool window has a
.                       system menu, its icon is not displayed on the 
.                       title bar. However, you can display the system 
.                       menu by right-clicking or by typing ALT+SPACE.
.
.       SIZABLETOOL   - This style is the same as FIXEDTOOL, but allows the
.                       window to be sized.
.
. Objects:
.       WINDOW
.
. dnumnvar values:
.
.$NONE        EQU       0       // Use a default based on WINTYPE
$NOBORDER       EQU     1
$FIXEDSINGLE    EQU     2
$FIXED3D        EQU     3
$SIZABLE3D      EQU     4
$FIXEDDIALOG    EQU     5
$SIZABLE        EQU     6
$FIXEDTOOL      EQU     7
$SIZABLETOOL    EQU     8
.
*------------------------------------------------------------------------------
.   WINOFFSETH=dnumnvar                              SETPROP  GETPROP
.
. Description:
.       This property is a GETPROP/SETPROP only property.  The WINOFFSETH
.       property identifies a relative horizontal offset for the
.       visible viewing area of a WINDOW.  By default the visible
.       viewing offset starts with a zero value.
.
.       Note1: It is possible to create objects outside the normal
.              viewing area for a Window.  If this is done, then the
.              WINOFFSETH and WINOFFSETV properties can be used to
.              bring these objects into the viewing area.
.
. Objects:
.       WINDOW
.
. dnumnvar values:
.
.       The <dnumnvar> value is a pixel value which defines a horizontal
.       offset for the visible area of a Window.
.
*------------------------------------------------------------------------------
.   WINOFFSETV=dnumnvar                              SETPROP  GETPROP
.
. Description:
.       This property is a GETPROP/SETPROP only property.  The WINOFFSETV
.       property identifies a relative vertical offset for the
.       visible viewing area of a WINDOW.  By default the
.       visible viewing offset starts with a zero value.
.
.       Note1: It is possible to create objects outside the normal
.              viewing area for a Window.  If this is done, then the
.              WINOFFSETH and WINOFFSETV properties can be used to
.              bring these objects into the viewing area.
.
. Objects:
.       WINDOW
.
. dnumnvar values:
.
.       The <dnumnvar> value is a pixel value which defines a vertical
.       offset for the visible area of a Window.
.
*------------------------------------------------------------------------------
.   WINPOS=dnumnvar                          CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies the positioning of a window when a
.       window object is activated.
.
.       The allowed window positioning types are as follows:
.
.       ABSOLUTE   -    This causes a window object to be positioned to
.                       the top/left co-ordinates of the window object.
.                    
.       DESKCENTER   -  This causes a window object to be centered on the 
.                       desktop.
.                     
.       PARENTCENTER -  This centers a MODAL or MODELESS window object over the 
.                       parent window. If the window object is not a MODAL or 
.                       MODELESS window object, it is treated as if DESKCENTER
.                       was used.
.
. Objects:
.       WINDOW
.
. dnumnvar values:
.
.$NONE        EQU       0               // Same as Default
$ABSOLUTE     EQU       1               // Default
$DESKCENTER   EQU       2
$PARENTCENTER EQU       3              
.
*------------------------------------------------------------------------------
.   WINTYPE=dnumnvar                         CREATE           GETPROP
.
. Description:
.       This property specifies the type of window applied for the
.       window object.
.
.       The allowed window types are as follows:
.
.       MODAL      -  This causes a MODAL dialog window to be created.
.                     When this window is activated using the ACTIVATE
.                     statement, the program execution remains
.                     at the ACTIVATE statement until the window is
.                     destroyed or deactivated.  While a MODAL window
.                     is active, no events other than events for the MODAL
.                     window are processed until the MODAL window is
.                     terminated.
.
.       MODELESS   -  This causes a MODELESS dialog window to be created.
.                     This window is a Window's popup window which will
.                     always remain on top of any primary window.  Another
.                     feature is that this window acts as a child window
.                     to a primary window.  If the primary window gets
.                     minimized, then the MODELESS dialog window is also
.                     minimized.  However, the MODELESS dialog window
.                     does not affect the minimized task bar selections.
.                     The MODELESS dialog window can not be minimized.
.                     The MODELESS dialog window does not lock out event
.                     processing for other windows while the MODELESS
.                     window is active.
 
.       OBJONLY    -  The use for the objects only window type is reserved
.                     for use by the PLB designer.  If this type is used
.                     in a program, then it is implemented as a
.                     PRIMARYSIZE window type.
.
.     PRIMARYFIXED -  This type creates a Window's Primary window which
.                     can not be sized.  A primary window can be minimized
.                     and maximized.  A primary window will always be
.                     presented under a MODAL/MODELESS dialog window.
.                     If a primary window is active when a MODELESS window
.                     is created, then the primary window acts as the
.                     parent window for the MODELESS window.
.
.     PRIMARYSIZE  -  The primary sized window type is a Windows' Primary
.                     window which can be sized.  All other features are
.                     the same as PRIMARYFIXED.
.
.     MDICLIENT    -  This type creates a window that contains a MDI client
.                     window to support MIDCHILD type windows. The
.                     properties: MDIBORDER, MDISCROLL, MDITOP, MDILEFT,
.                     MDIHEIGHT and MDIWIDTH can be used to manipulate
.                     the MDI client window. Also the MDILayout and MDIShow
.                     methods also affect the MDI client window.
.
.     MDICHILD     -  This type creates a MDI child window for use with a
.                     host MDICLIENT style window.
.
. Objects:
.       WINDOW
.
. dnumnvar values:
.
.$NONE        EQU       0              // Same as Default
$MODAL        EQU       1
$MODELESS     EQU       2
$OBJONLY      EQU       3              // PLFORM use only
$PRIMARYFIXED EQU       4
$PRIMARYSIZE  EQU       5              // Default
$MDICLIENT    EQU       6
$MDICHILD     EQU       7
.
*------------------------------------------------------------------------------
.   WORDWRAP[=dnumnvar]                      CREATE  SETPROP  GETPROP
.
. Description:
.       For a MULTILINE edittext object this property causes 
.       the data entry to continue at the beginning of the
.       next line when the right most boundary of the edittext
.       object is encountered.  If the <dnumnvar> value is not
.       specified, the WORDWRAP property is set to ON.
.
. Objects:
.       EDITTEXT
.
. dnumnvar values:
.
.$OFF         EQU       0              // Default
.$ON          EQU       1
.
*------------------------------------------------------------------------------
.   X1=dnumnvar                                      SETPROP  GETPROP
.
. Description:
.       This property is a GETPROP/SETPROP only property.  The X1 property
.       specifies the X coordinate for the starting point of the LINE
.       object.
.
. Objects:
.       LINE
.
. dnumnvar values:
.
.       The <dnumnvar> value is provided in the same units as used for
.       the creation of an object.  This means that if an object was
.       created using pixels, then the X1 value expects to use pixels.
*------------------------------------------------------------------------------
.   X2=dnumnvar                                      SETPROP  GETPROP
.
. Description:
.       This property is a GETPROP/SETPROP only property.  The X2 property
.       specifies the X coordinate for the ending point of the LINE
.       object.
.
. Objects:
.       LINE
.
. dnumnvar values:
.
.       The <dnumnvar> value is provided in the same units as used for
.       the creation of an object.  This means that if an object was
.       created using pixels, then the X2 value expects to use pixels.
*------------------------------------------------------------------------------
.   Y1=dnumnvar                                      SETPROP  GETPROP
.
. Description:
.       This property is a GETPROP/SETPROP only property.  The Y1 property
.       specifies the Y coordinate for the starting point of the LINE
.       object.
.
. Objects:
.       LINE
.
. dnumnvar values:
.
.       The <dnumnvar> value is provided in the same units as used for
.       the creation of an object.  This means that if an object was
.       created using pixels, then the Y1 value expects to use pixels.
*------------------------------------------------------------------------------
.   Y2=dnumnvar                                      SETPROP  GETPROP
.
. Description:
.       This property is a GETPROP/SETPROP only property.  The Y2 property
.       specifies the Y coordinate for the ending point of the LINE
.       object.
.
. Objects:
.       LINE
.
. dnumnvar values:
.
.       The <dnumnvar> value is provided in the same units as used for
.       the creation of an object.  This means that if an object was
.       created using pixels, then the Y2 value expects to use pixels.
*------------------------------------------------------------------------------
.   ZORDER=dnumnvar                          CREATE  SETPROP  GETPROP
.
. Description:
.       This property specifies which object should be displayed
.       on top when more than one object exists in the same space
.       and in the same plane.
.
.       Note1:  Any objects in 'Plane 1' will always be on top of
.               any object in 'Plane 0' with the exception of the
.               TABCONTROL object.  Although, the TABCONTROL object
.               exists in 'Plane 1', the 'Plane 0' objects can be
.               placed on top of the TABCONTROL by having a higher
.               ZORDER value than the TABCONTROL.
.
.       Note2:  When the ZORDER value for any object is higher than
.               any other object in the same plane, then the object 
.               with the higher value exists on top. 
.
.       Note3:  The ZORDER exists for a window object only to define
.               a default zorder starting value for objects created
.               for that window object without an explicit ZORDER.
.
. Objects:
.       BUTTON                  ;Plane  1
.       CHECKBOX                ;Plane  1
.       CHECKGRP                ;Plane  1
.       COMBOBOX                ;Plane  1
.       CONTAINER               ;Depends on object usage
.       CONTROL                 ;Plane  1
.       DATALIST                ;Plane  1
.       EDITTEXT                ;Plane  1
.       GROUPBOX                ;Plane  0
.       HSCROLLBAR              ;Plane  1
.       ICON                    ;Plane  0
.       LINE                    ;Plane  0
.       LISTVIEW                ;Plane  1
.       MREGION                 ;Plane  0
.       MOVIE                   ;Plane  1
.       PICT                    ;Plane  0
.       POPUPMENU ( OBSELETE )  ;Plane  1
.       PROGRESS                ;Plane  0
.       RADIOGRP                ;Plane  1
.       RADIO                   ;Plane  1
.       SHAPE                   ;Plane  0
.       SLIDER                  ;Plane  1
.       STATTEXT                ;Plane  0
.       TABCONTROL              ;Plane  1
.       TREEVIEW                ;Plane  1
.       VSCROLLBAR              ;Plane  1
.       WINDOW                  ;No Plane
.
. dnumnvar values:
.
.       The <dnumnvar> value is a user defined value.
.
*---End PLBEQU Definitions-----------------------------------------------------
.
         %ENDIF                        ;PLBEQU                            8.1E
.
         %IF $PLBDEF = 1               ;1 ==> Include these DEFINITIONS   8.2
.
*===Begin PLBDEF Definitions=================================================
;
;   Function key DEFINE's
;          These expressions are used with the KeyPress event to determine if a
;          function key has been pressed. They provide an expression to be a
;          part of an IF statement. They will function as a stand-a-lone
;          expression ie: [IF $F1] or in combination within a compound
;          expression ie: [IF ($F1 & $SHIFT)] within a .PLF form file. These
;          work only within the object which has focus and WILL NOT function in
;          the KeyPress event for the FORM.
;
$ENTER     DEFINE     (#EventResult=13)
;
$F1        DEFINE     (#EventResult=112)
$F2        DEFINE     (#EventResult=113)
$F3        DEFINE     (#EventResult=114)
$F4        DEFINE     (#EventResult=115)
$F5        DEFINE     (#EventResult=116)
$F6        DEFINE     (#EventResult=117)
$F7        DEFINE     (#EventResult=118)
$F8        DEFINE     (#EventResult=119)
$F9        DEFINE     (#EventResult=120)
$F10       DEFINE     (#EventResult=121)
$F11       DEFINE     (#EventResult=122)
$F12       DEFINE     (#EventResult=123)
;
$PGUP      DEFINE     (#EventResult=33)
$PGDN      DEFINE     (#EventResult=34)
$END       DEFINE     (#EventResult=35)
$HOME      DEFINE     (#EventResult=36)
$FLEFT     DEFINE     (#EventResult=37)
$UP        DEFINE     (#EventResult=38)
$FRIGHT    DEFINE     (#EventResult=39)
$DOWN      DEFINE     (#EventResult=40)
;
$INS       DEFINE     (#EventResult=45)
 
$DEL       DEFINE     (#EventResult=46)
;
$PAUSE     DEFINE     (#EventResult=19)
$SCRL_LCK  DEFINE     (#EventResult=145)
;
; These are found as part of the Numeric pad NOT found in the Qwerty key area
;
$NUM_STAR  DEFINE     (#EventResult=106)    ; Displays Character "*"
$NUM_PLUS  DEFINE     (#EventResult=107)    ; Displays Character "+"
$NUM_MINUS DEFINE     (#EventResult=109)    ; Displays Character "-"
$NUM_SLASH DEFINE     (#EventResult=111)    ; Displays Character "/"
;
; Modifiers... These code are used in conjunction with the EventResult values
;
$NO_MOD          DEFINE    (#EventMod=0)    ; No modifier key used
$ALT             DEFINE    (#EventMod=1)    ; Alt key used
$CTL             DEFINE    (#EventMod=2)    ; Ctrl key used
$CTL_$ALT        DEFINE    (#EventMod=3)    ; Ctrl & Alt keys used togeather
$SHIFT           DEFINE    (#EventMod=4)    ; Shift key used
;$ALT_$SHIFT     DEFINE    NOP              ; No code generated. Not supported
$CTL_$SHIFT      DEFINE    (#EventMod=6)    ; Ctrl & Shift keys used together
$CTL_$ALT_$SHIFT DEFINE    (#EventMod=7)    ; Ctrl, Alt & Shift keys together
;
*---End PLBDEF Definitions-----------------------------------------------------
.
         %ENDIF                        ;PLBDEF                            8.2
.
         %IF $PLBCONST = 1             ;1 ==> Include these CONST         8.2
.
*===Begin KEYPRESS CONST values================================================
.
.   Definitions of Windows Virtual Key Result Values for $KEYPRESS Events
.------------------------------------------------------------------------------
.
$vkyBreak  const   "3"                 . ctrl/Break key (only with Ctrl: mod=2)
$vkyBksp   const   "8"                 . Backspace          (can shift)
.   ctrl/bksp appears as char='I', mod=2 (ctrl)
$vkyEnter  const   "13"                . Enter key     (can shift and/or ctrl)
$vkyPause  const   "19"                . Pause key          (can shift)
$vkyCaps   const   "20"                . Caps lock toggle   (can shift)
$vkyNumLk  const   "144"               . Num lock toggle    (can shift)
$vkyScroll const   "145"               . Scroll lock toggle (can shift)
$vkyEsc    const   "27"                . Escape key         (can shift)
$vkyPgUp   const   "33"                . shift and ctrl are possible
$vkyPgDn   const   "34"                .     (ditto)
$vkyEnd    const   "35"                .     (ditto)
$vkyHome   const   "36"                .     (ditto)
$vkyLFA    const   "37"                . arrow keys    (ditto)
$vkyUPA    const   "38"                .     (ditto)
$vkyRTA    const   "39"                .     (ditto)
$vkyDNA    const   "40"                .     (ditto)
$vkyIns    const   "45"                .     (ditto)
$vkyDel    const   "46"                .     (ditto)
$vkyStar   const   "106"               . Ctrl Gray * key (only with Ctrl)
$vkyPlus   const   "107"               . Ctrl Gray + key (only with Ctrl)
$vkyMinus  const   "109"               . Ctrl Gray - key (only with Ctrl)
$vkySlash  const   "111"               . Ctrl Gray / key (only with Ctrl)
$vkyF1     const   "112"               . shift and ctrl are possible
$vkyF2     const   "113"               .     (ditto)
$vkyF3     const   "114"               .     (ditto)
$vkyF4     const   "115"               .     (ditto)
$vkyF5     const   "116"               .     (ditto)
$vkyF6     const   "117"               .     (ditto)
$vkyF7     const   "118"               .     (ditto)
$vkyF8     const   "119"               .     (ditto)
$vkyF9     const   "120"               .     (ditto)
$vkyF10    const   "121"               .     (ditto)
$vkyF11    const   "122"               .     (ditto)
$vkyF12    const   "123"               .     (ditto)
.
*---End KEYPRESS CONST values-------------------------------------------------
.
         %ENDIF                        ;PLBCONST                          8.2
.
         %IF $PLBALERT = 1             ;1 ==> Include ALERT integers      8.3f
.
*===Begin ALERT TYPE Integer values===========================================
.
.   Definitions of Windows MessageBox type values and result values.
.-----------------------------------------------------------------------------
.
.
$MB_OK               INTEGER 4,"0x000000"   - OK Button
$MB_OKCANCEL         INTEGER 4,"0x000001"   - OK/CANCEL buttons
$MB_ABORTRETRYIGNORE INTEGER 4,"0x000002"   - ABORT/RETRY/IGNORE
$MB_YESNOCANCEL      INTEGER 4,"0x000003"   - YES/NO/CANCEL
$MB_YESNO            INTEGER 4,"0x000004"   - YES/NO
$MB_RETRYCANCEL      INTEGER 4,"0x000005"   - RETRY/CANCEL
.
$MB_ICONSTOP         INTEGER 4,"0x000010"   - Stop-sign icon
$MB_QUESTION         INTEGER 4,"0x000020"   - Question-mark icon
$MB_ICONEXCLAMATION  INTEGER 4,"0x000030"   - Exclamation-point ico
$MB_ICONINFORMATION  INTEGER 4,"0x000040"   - Information 'i' icon
.
$MB_DEFBUTTON1       INTEGER 4,"0x000000"   - Default button one
$MB_DEFBUTTON2       INTEGER 4,"0x000100"   - Default button two
$MB_DEFBUTTON3       INTEGER 4,"0x000200"   - Default button three
$MB_DEFBUTTON4       INTEGER 4,"0x000400"   - Default button four
.
$MB_SETFOREGROUND    INTEGER 4,"0x010000"   - Set foreground window
$MB_RIGHT            INTEGER 4,"0x080000"   - Text right justified
.
$MB_RTLREADING       INTEGER 4,"0x100000"   - Right to left reading
.
$IDOK      CONST   "1"         - OK button was selected.
$IDCANCEL  CONST   "2"         - CANCEL button was selected.
$IDABORT   CONST   "3"         - ABORT button was selected.
$IDRETRY   CONST   "4"         - RETRY button was selected.
$IDGNORE   CONST   "5"         - IGNORE button was selected.
$IDYES     CONST   "6"         - YES button was selected.
$IDNO      CONST   "7"         - NO button was selected.
.
*---End ALERT TYPE values------------------------------------------------------
.
         %ENDIF                        ;PLBALERT                          8.3f
.
         %IF $PLBDTYPE = 1             ;1 ==> Include DTYPE equates       8.5A
.
*===Begin DTYPE Equate values=================================================
.
.   Definitions of DTYPE, DTYPEBASE, and DTYPESUB operator values.
.-----------------------------------------------------------------------------
. Language reference TRUE types reflected by psuedo command DTYPE(label)
. operator.
.
$T_VARLIST      EQU  0x0004            ;True type for variable
$T_INTEGER      EQU  0x0008            ;True type for variable
$T_FORM         EQU  0x0010            ;True type for variable
$T_FILELIST     EQU  0x0014            ;True type for variable
$T_DIM          EQU  0x0020            ;True type for variable
$T_FILE         EQU  0x0040            ;True type for variable
$T_IFILE        EQU  0x0041            ;True type for variable
$T_AFILE        EQU  0x0042            ;True type for variable
$T_PFILE        EQU  0x0043            ;True type for variable
$T_DBFILE       EQU  0x0045            ;True type for variable
$T_BFILE        EQU  0x0046            ;True type for variable
$T_COMFILE      EQU  0x0047            ;True type for variable
$T_PROFILE      EQU  0x007B            ;True type for variable
$T_EQUCMDLIN    EQU  0x007C            ;True type for variable
$T_EQU          EQU  0x007D            ;True type for variable
$T_RECORD       EQU  0x0104            ;True type for variable
$T_RECORDEF     EQU  0x0204            ;True type for variable
.
$T_BUTTON       EQU  0x0130            ;True type for object
$T_CHECKBOX     EQU  0x0230            ;True type for object
$T_CHECKGRP     EQU  0x0330            ;True type for object
$T_DATALIST     EQU  0x0430            ;True type for object
$T_DIALOG       EQU  0x0530            ;True type for object
$T_EDITTEXT     EQU  0x0630            ;True type for object
$T_ICON         EQU  0x0730            ;True type for object
$T_MENU         EQU  0x0830            ;True type for object
$T_MREGION      EQU  0x0930            ;True type for object
$T_MOVIE        EQU  0x0A30            ;True type for object
$T_PICT         EQU  0x0B30            ;True type for object
$T_POPUPMENU    EQU  0x0C30            ;True type for object
$T_RADIO        EQU  0x0D30            ;True type for object
$T_RADIOGRP     EQU  0x0E30            ;True type for object
$T_SUBMENU      EQU  0x0F30            ;True type for object
$T_STATTEXT     EQU  0x1030            ;True type for object
$T_TIMER        EQU  0x1130            ;True type for object
$T_COLOR        EQU  0x1230            ;True type for object
$T_FLOATMENU    EQU  0x1330            ;True type for object
$T_FONT         EQU  0x1430            ;True type for object
$T_GROUPBOX     EQU  0x1530            ;True type for object
$T_IMAGELIST    EQU  0x1630            ;True type for object
$T_LISTVIEW     EQU  0x1730            ;True type for object
$T_PROGRESS     EQU  0x1830            ;True type for object
$T_HSCROLLBAR   EQU  0x1930            ;True type for object
$T_VSCROLLBAR   EQU  0x1A30            ;True type for object
$T_TREEVIEW     EQU  0x1C30            ;True type for object
$T_WINDOW       EQU  0x1E30            ;True type for object
$T_COMBOBOX     EQU  0x1F30            ;True type for object
$T_SHAPE        EQU  0x2030            ;True type for object
$T_SLIDER       EQU  0x2130            ;True type for object
$T_TABCONTROL   EQU  0x2230            ;True type for object
$T_COLLECTION   EQU  0x2330            ;True type for object
$T_PLBFORM      EQU  0x2430            ;True type for object
$T_LINE         EQU  0x2530            ;True type for object
$T_AUTOMATION   EQU  0x2630            ;True type for object
$T_CONTAINER    EQU  0x2730            ;True type for object
$T_CONTROL      EQU  0x2830            ;True type for object
$T_VARIANT      EQU  0x2930            ;True type for object
.
.-----------------------------------------------------------------------------
. Language reference BASE types reflected by psuedo command DTYPEBASE(label)
. operator.
.
$BT_RECORD      EQU  0x0004            ;Base type for variable
$BT_RECORDEF    EQU  0x0004            ;Base type for variable
$BT_VARLIST     EQU  0x0004            ;Base type for variable
$BT_INTEGER     EQU  0x0008            ;Base type for variable
$BT_FORM        EQU  0x0010            ;Base type for variable
$BT_FILELIST    EQU  0x0014            ;Base type for variable
$BT_DIM         EQU  0x0020            ;Base type for variable
$BT_FILE        EQU  0x0040            ;Base type for variable
$BT_IFILE       EQU  0x0041            ;Base type for variable
$BT_AFILE       EQU  0x0042            ;Base type for variable
$BT_PFILE       EQU  0x0043            ;Base type for variable
$BT_DBFILE      EQU  0x0045            ;Base type for variable
$BT_BFILE       EQU  0x0046            ;Base type for variable
$BT_COMFILE     EQU  0x0047            ;Base type for variable
$BT_PROFILE     EQU  0x007B            ;Base type for variable
$BT_EQUCMDLIN   EQU  0x007C            ;Base type for variable
$BT_EQU         EQU  0x007D            ;Base type for variable
.
$BT_BUTTON      EQU  0x0030            ;Base type for object
$BT_CHECKBOX    EQU  0x0030            ;Base type for object
$BT_CHECKGRP    EQU  0x0030            ;Base type for object
$BT_DATALIST    EQU  0x0030            ;Base type for object
$BT_DIALOG      EQU  0x0030            ;Base type for object
$BT_EDITTEXT    EQU  0x0030            ;Base type for object
$BT_ICON        EQU  0x0030            ;Base type for object
$BT_MENU        EQU  0x0030            ;Base type for object
$BT_MREGION     EQU  0x0030            ;Base type for object
$BT_MOVIE       EQU  0x0030            ;Base type for object
$BT_PICT        EQU  0x0030            ;Base type for object
$BT_POPUPMENU   EQU  0x0030            ;Base type for object
$BT_RADIO       EQU  0x0030            ;Base type for object
$BT_RADIOGRP    EQU  0x0030            ;Base type for object
$BT_SUBMENU     EQU  0x0030            ;Base type for object
$BT_STATTEXT    EQU  0x0030            ;Base type for object
$BT_TIMER       EQU  0x0030            ;Base type for object
$BT_COLOR       EQU  0x0030            ;Base type for object
$BT_FLOATMENU   EQU  0x0030            ;Base type for object
$BT_FONT        EQU  0x0030            ;Base type for object
$BT_GROUPBOX    EQU  0x0030            ;Base type for object
$BT_IMAGELIST   EQU  0x0030            ;Base type for object
$BT_LISTVIEW    EQU  0x0030            ;Base type for object
$BT_PROGRESS    EQU  0x0030            ;Base type for object
$BT_HSCROLLBAR  EQU  0x0030            ;Base type for object
$BT_VSCROLLBAR  EQU  0x0030            ;Base type for object
$BT_TREEVIEW    EQU  0x0030            ;Base type for object
$BT_WINDOW      EQU  0x0030            ;Base type for object
$BT_COMBOBOX    EQU  0x0030            ;Base type for object
$BT_SHAPE       EQU  0x0030            ;Base type for object
$BT_SLIDER      EQU  0x0030            ;Base type for object
$BT_TABCONTROL  EQU  0x0030            ;Base type for object
$BT_COLLECTION  EQU  0x0030            ;Base type for object
$BT_PLBFORM     EQU  0x0030            ;Base type for object
$BT_LINE        EQU  0x0030            ;Base type for object
$BT_AUTOMATION  EQU  0x0030            ;Base type for object
$BT_CONTAINER   EQU  0x0030            ;Base type for object
$BT_CONTROL     EQU  0x0030            ;Base type for object
$BT_VARIANT     EQU  0x0030            ;Base type for object
.
.-----------------------------------------------------------------------------
. Language reference SUB types reflected by psuedo command DTYPESUB(label)
. operator.
.
$ST_DIM         EQU  0x00              ;Sub type for variable
$ST_FORM        EQU  0x00              ;Sub type for variable
$ST_INTEGER     EQU  0x00              ;Sub type for variable
$ST_FILE        EQU  0x00              ;Sub type for variable
$ST_FILELIST    EQU  0x00              ;Sub type for variable
$ST_IFILE       EQU  0x00              ;Sub type for variable
$ST_AFILE       EQU  0x00              ;Sub type for variable
$ST_VARLIST     EQU  0x00              ;Sub type for variable
$ST_EQU         EQU  0x00              ;Sub type for variable
$ST_EQUCMDLIN   EQU  0x00              ;Sub type for variable
$ST_DBFILE      EQU  0x00              ;Sub type for variable
$ST_PFILE       EQU  0x00              ;Sub type for variable
$ST_BFILE       EQU  0x00              ;Sub type for variable
$ST_COMFILE     EQU  0x00              ;Sub type for variable
$ST_PROFILE     EQU  0x00              ;Sub type for variable
$ST_RECORD      EQU  0x01              ;Sub type for variable
$ST_RECORDEF    EQU  0x02              ;Sub type for variable
.
$ST_BUTTON      EQU  0x01              ;Sub type for object
$ST_CHECKBOX    EQU  0x02              ;Sub type for object
$ST_CHECKGRP    EQU  0x03              ;Sub type for object
$ST_DATALIST    EQU  0x04              ;Sub type for object
$ST_DIALOG      EQU  0x05              ;Sub type for object
$ST_EDITTEXT    EQU  0x06              ;Sub type for object
$ST_ICON        EQU  0x07              ;Sub type for object
$ST_MENU        EQU  0x08              ;Sub type for object
$ST_MREGION     EQU  0x09              ;Sub type for object
$ST_MOVIE       EQU  0x0A              ;Sub type for object
$ST_PICT        EQU  0x0B              ;Sub type for object
$ST_POPUPMENU   EQU  0x0C              ;Sub type for object
$ST_RADIO       EQU  0x0D              ;Sub type for object
$ST_RADIOGRP    EQU  0x0E              ;Sub type for object
$ST_SUBMENU     EQU  0x0F              ;Sub type for object
$ST_STATTEXT    EQU  0x10              ;Sub type for object
$ST_TIMER       EQU  0x11              ;Sub type for object
$ST_COLOR       EQU  0x12              ;Sub type for object
$ST_FLOATMENU   EQU  0x13              ;Sub type for object
$ST_FONT        EQU  0x14              ;Sub type for object
$ST_GROUPBOX    EQU  0x15              ;Sub type for object
$ST_IMAGELIST   EQU  0x16              ;Sub type for object
$ST_LISTVIEW    EQU  0x17              ;Sub type for object
$ST_PROGRESS    EQU  0x18              ;Sub type for object
$ST_HSCROLLBAR  EQU  0x19              ;Sub type for object
$ST_VSCROLLBAR  EQU  0x1A              ;Sub type for object
$ST_TREEVIEW    EQU  0x1C              ;Sub type for object
$ST_WINDOW      EQU  0x1E              ;Sub type for object
$ST_COMBOBOX    EQU  0x1F              ;Sub type for object
$ST_SHAPE       EQU  0x20              ;Sub type for object
$ST_SLIDE       EQU  0x21              ;Sub type for object
$ST_TABCONTROL  EQU  0x22              ;Sub type for object
$ST_COLLECTION  EQU  0x23              ;Sub type for object
$ST_PLBFORM     EQU  0x24              ;Sub type for object
$ST_LINE        EQU  0x25              ;Sub type for object
$ST_AUTOMATION  EQU  0x26              ;Sub type for object
$ST_CONTAINER   EQU  0x27              ;Sub type for object
$ST_CONTROL     EQU  0x28              ;Sub type for object
$ST_VARIANT     EQU  0x29              ;Sub type for object
.
*---End DTYPE Equate values----------------------------------------------------
.
         %ENDIF                        ;PLBDTYPE                          8.5A

.
.  CALLERR1  ERROR RETURN MODULE:  PLACE AT BEGINNING OF ALL PROGRAMS
.
.  3-10-2004 R. BACHARACH
.
.  PLACE THIS CODE AS LAST DATA AREA STATEMENTS

.
TITLTEXT DIM       35

RESULT   FORM      4
D        DIALOG
DDATA    INIT      "FONTSIZE=8,POS=5:5,SIZE=45:9,":
                   "TYPE=MODELESS,":
                   "TEXT=3:5:5:40:'IF YOU HAVE COME HERE ERRONEOUSLY ":
                   "FROM THE SYSTEM MENUS":
                   " AND DO NOT WANT TO RUN THIS PROGRAM, ":
                   "YOU MAY EXIT BY":
                   " CLICKING THE Quit BUTTON... ":
                   "OTHERWISE, CLICK Continue',":
                   "BUTTON=7:8:14:20:'&Continue',": 
                   "BUTTON=7:8:26:32:'&Quit'" 
.
.......................................................................
.
  
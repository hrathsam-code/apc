. SPLOPNFX.TXT ----> DATA DEFINITIONS FOR SPLOPEN PRINTER SELECTION ROUTINE
.                    SPLOPNPX.TXT
.
. LAST REVISION - 13 JUNE '97
.
ANSWP    DIM       1
PRTNAME  DIM       35
DEVNAME  DIM       35
NWK2     FORM      2
.
.
PRESULT  INTEGER   1
DBOX     DIALOG
DBDATA   INIT      "FONTSIZE=8,POS=2:2,SIZE=35:11,":
                   "TYPE=MODELESS,TITLE='Printer Selections',":
                   "PRINTLIST=3:5:4:31,":
                   "TEXT=6:8:4:31:'Using the MOUSE, point to your ":
                   "selection, click once to select, then click ":
                   "on OK to continue.',":
                   "EDIT=9:9:4:31:S,":
                   "BUTTON=11:11:25:31:'&OK'"
.
.

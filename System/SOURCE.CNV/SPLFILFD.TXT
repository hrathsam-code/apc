. SPLFILFD.TXT ----> DATA DEFINITIONS FOR SPLOPEN PRINTER SELECTION ROUTINE
.                    SPLFILPR.TXT
.
. LAST REVISION - 25 MARCH '98
.
ANSWP    DIM       1
PRTNAME  DIM       35
DEVNAME  DIM       35
NWK2     FORM      2
LOCPRT   FORM      1
FILPRT   FORM      1
PRTEXT   INIT      ".PRT"
SPLFILNM DIM       12
.
.
FRESULT  INTEGER   1
PRESULT  INTEGER   1
DBOX     DIALOG
DBDATA   INIT      "FONTSIZE=8,POS=2:2,SIZE=35:14,":
                   "TYPE=MODELESS,TITLE='Printer Selections',":
                   "PRINTLIST=3:5:4:31,":
                   "TEXT=6:8:4:31:'Using the MOUSE, point to your ":
                   "selection, click once to select, then click ":
                   "on OK to continue.',":
                   "CHECKBOX=9:9:4:31:'Print to Local Printer',":
                   "CHECKBOX=10:10:4:31:'Output to Print File',":
                   "EDIT=11:11:4:31:S,":
                   "BUTTON=13:13:25:31:'&OK'"
.
.

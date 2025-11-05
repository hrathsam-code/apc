.
. APMENU1 - ACCOUNTS PAYABLE SYSTEM MASTER MENU
.
. WRITTEN BY R.	BACHARACH
.
.
                     INCLUDE   COMMON.INC
.



PROG	 FORM	   2
PROG1                INIT                 "Vendor"
PROG2                INIT                 "Vinq2"
PROG3                INIT                 "APEntry"
PROG4                INIT                 "PrtCashR"
PROG5                INIT                 "PrtChkRq"
PROG6                INIT                 "PrtCheck"
PROG7                INIT                 "ChkEntry"
PROG8                INIT                 "PrtChkRg"
PROG9                INIT                 "PrtVendor"
PROG10               INIT                 "PrtAgeAP"
PROG11               INIT                 "PrtApDst"
PROG12               INIT                 "PrtApEnt"
PROG13               INIT                 "ARTRM"
PROG14               INIT                 "PrtAPDst3"
PROG15               INIT                 "ChkEntry2"
PROG16               INIT                 "PrtCheck2"
PROG17               INIT                 "GLMast"

.
ROLLNAME INIT	   "C:\DBC\ROLLFILE.SYS"
.
TIME	 INIT	   "HH/MM/SS "
REPLY	 DIM	   1
                    move               "APMenu2",FromPGM
.
	 CLOCK	   TIME	TO TIME
DISP                 DISPLAY   *ES,*P18:2,*HON,"NEW ACCOUNTS PAYABLE SYSTEM    ",TODAY:
		   *HOFF
                     DISPLAY   *P1:4,"1.  Vendor Maintenance Program":
                               *P1:5,"2.  Vendor Inquiry":
                               *P40:4,"13.  Terms Maintenance":
                               *P40:5,"14.  Print A/P CHECK Distribution Report":
                               *P1:6,"                                     ":
                               *P1:7,"3.  Invoice/Credit Entry":
                               *P40:7,"15.  Payroll Check Entry":
                               *P40:8,"16.  Print Payroll Checks":
                               *P40:10,"17.  Modify/Add GL Account":
                               *P1:09,"4.  Create Check Run":
                               *P1:10,"5.  Print Cash Requirements Report":
                               *P1:11,"6.  Print Checks":
                               *P1:12,"7.  Create/Void Manual Check":
                               *P1:13,"8.  Print Check Register":
                               *P1:15,"9.  Print Vendor Listing":
                               *P1:16,"10.  Print A/P Aging Report":
                               *P1:17,"11.  Print A/P Distribution Report":
                               *P1:18,"12.  Print A/P Entry Report":
                               *P1:20,"ESC to exit Menu"
.
.
S1                   KEYIN                *P28:23,*EL,"ENTER SELECTION  ",PROG
                     if                   (ESC)
                     chain                 "NEWMASTR"
                     endif
.
	 TRAP	   CHNFAIL IF CFAIL
.
                     COMPARE   "18"     TO PROG
	 GOTO	   BRANCHIT IF LESS
.
	 BEEP
CHNFAIL	 DISPLAY   *P01:23,"INVALID SELECTION ",*W2,*P1:23,*EL
	 GOTO	   S1
BRANCHIT BRANCH        PROG            OF A1,A2,A3,A4,A5,A6,A7,A8,A9,A10,A11,A12,A13,A14,A15,A16,A17

                     GOTO                 S2
A1	 CHAIN	   PROG1
	 GOTO	   CHNFAIL
A2	 CHAIN	   PROG2
	 GOTO	   CHNFAIL
A3	 CHAIN	   PROG3
	 GOTO	   CHNFAIL
A4	 CHAIN	   PROG4
	 GOTO	   CHNFAIL
A5	 CHAIN	   PROG5
	 GOTO	   CHNFAIL
A6	 CHAIN	   PROG6
	 GOTO	   CHNFAIL
A7	 CHAIN	   PROG7
	 GOTO	   CHNFAIL
A8	 CHAIN	   PROG8
	 GOTO	   CHNFAIL
A9	 CHAIN	   PROG9
	 GOTO	   CHNFAIL
A10	 CHAIN	   PROG10
	 GOTO	   CHNFAIL
A11                  CHAIN                PROG11
                     GOTO                 CHNFAIL
A12                  CHAIN                PROG12
                     GOTO                 CHNFAIL
A13                  CHAIN                PROG13
                     GOTO                 CHNFAIL
A14                  CHAIN                PROG14
                     GOTO                 CHNFAIL
A15                  CHAIN                PROG15
                     GOTO                 CHNFAIL
A16                  CHAIN                PROG16
                     GOTO                 CHNFAIL
A17                  CHAIN                PROG17
                     GOTO                 CHNFAIL
.
A28	 BEEP
         MOVE	   " " TO REPLY
	 KEYIN	   *P01:23,*EL,*HON,"ARE YOU  S	U R E  THAT YOU	WANT TO	":
		   "BACKUP AND INDEX THE A/P FILES? (Y/N) ",REPLY
	 CMATCH	   "Y",REPLY
	 GOTO	   A28A	 IF  EQUAL
	 GOTO	   CHNFAIL
.
A28A	 ROLLOUT   "F:\UTILS.CNV\APINDX2.BAT"
	 GOTO	   DISP
.
.
S2	 BEEP
	 DISPLAY   *P14:23,*EF,"INVALID	SELECTION - PLEASE RETRY",*W,*W
	 GOTO	   S1

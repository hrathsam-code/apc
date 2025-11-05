	 INCLUDE   MSCBRAG.TXT
. 
. APDISACC - THIS VERSION DISPLAYS ON 12 LINE SCREENS -
. MODIFIED BY R. BACHARACH - MICRO SYSTEMS CONSULTANTS
. 9/6/82 - WORKING ON LABOR DAY!
. 
	 INCLUDE   COMMON
. 
. 
	 INC	   APMASTFD
.
APMASTER IFILE	   KEYL=6,UNCOMPRESSED
REPLY	 DIM	   1

         INCLUDE   CALLERR1.INC
 
         MOVE      "A/P VENDOR REVIEW" TO TITLTEXT
 
         INCLUDE   CALLERR2.INC

	 OPEN	   APMASTER,"APMASTER.ISI"

. SCREEN DISPLAY SEQUENCE
A1	 DISPLAY   *ES,*HON,*P25:1,"A /	P   V E	N D O R	  R E V	I E W",*HOFF

	 DISPLAY   *P4:3,"VENDOR NUMBER	 ______":
		   *P36:3,"	_________________________":
		   *P36:4,"	____________________":
		   *P65:4,"...-...-....":
		   *P04:05,"CONTACT  ___":
		   *P36:5,"	____________________":
		   *P36:6,"	______________	  __	 _____":
		   *P16:9,"OVER	90 = __________":
		   *P16:10,"OVER 60 = __________":
		   *P41:10,"MTD	DEBS = __________":
		   *P16:11,"OVER 30 = __________":
		   *P41:11,"MTD	CRDS = __________":
		   *P16:12,"CURRENT = __________":
		   *P16:13,"TOTAL =   __________"
	 KEYIN	   *P19:3,ACCKEY
 
         GOTO      EOJ IF F5

	 CMATCH	   "*",ACCKEY
	 GOTO	   EOJ IF EQUAL
	 INC	   APMASTRD
	 GOTO	   A1 IF OVER
	 DISPLAY   *P41:3,NAME,*P41:4,ADD1,*P41:5,ADD2,*P41:6:
		   CITY,*P59:6,STATE,*P66:6,ZIP:
		   *P65:4,TELEFONE:
		   *P13:05,CONT:
		   *P26:9,OVR90:
		   *P26:10,OVR60,*P52:10,MTDD:
		   *P26:11,OVR30,*P52:11,MTDC:
		   *P26:12,CURR:
		   *P26:13,TOTDUE
A2	 KEYIN	   *P1:24,"DISPLAY ANOTHER VENDOR (Y/N)	?",REPLY
	 MATCH	   "Y",REPLY
	 GOTO	   A1 IF EQUAL
	 MATCH	   "N",REPLY
	 GOTO	   EOJ IF EQUAL
	 BEEP
	 GOTO	   A2
EOJ	 CLOSE	   APMASTER
	 CHAIN	   FROMPGM


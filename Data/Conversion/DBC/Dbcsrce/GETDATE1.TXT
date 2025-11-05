+ ----------------------------------------------------------------
.  SUBROUTINE TO GET AND VERIFY DATE IN MM/DD/YY FORMAT
.  INCLUDE THE FOLLOWING IN THE CALLING PROGRAM
. 
.  MM     DIM   2          FM    FORM  2         DATEDESC   DIM   15
.  DD     DIM   2          FD    FORM  2         DATERROR   DIM   1
.  YY     DIM   2          FY    FORM  2         DATFLG     DIM   1
.                                                BKUPFLG    DIM   1
.  THIS VERSION OF THE ORIGINAL GETDATE SUBROUTINE IS TO ALLOW THE
.  OPERATOR TO BACKUP A FIELD WHEN ENTERING DATA BY ENTERING A
.  QUESTION MARK IN THE MONTH FIELD.
.  THE FLAG CALLED BKUPFLG SHOULD BE SET BEFORE CALLING THIS SUBROUTINE.
.  AN 'X' IN BKUPFLG SIGNIFIES THAT THE OPERATOR SHOULD NOT BE ALLOWED
.  TO BACKUP FROM THIS DATE. A BLANK IN BKUPFLG SIGNIFIES THAT THE 
.  OPERATOR SHOULD BE ALLOWED TO BACKUP FROM THIS DATE.
.  IF THE OPERATOR IS ALLOWED TO BACKUP FROM THIS DATE AND ENTERS A 
.  QUESTION MARK IN MONTH, THE FLAG CALLED DATFLG WILL BE SET WITH AN 'X'
.  INDICATING BACKUP. IF THE OPERATOR DOES NOT ENTER A QUESTION MARK,
.  DATFLG WILL BE SET WITH A BLANK.
.  IF THE OPERATOR IS ALLOWED TO BACKUP FROM THIS DATE, THE FLAG CALLED
.  DATFLG SHOULD BE CHECKED IMMEDIATELY UPON RETURN FROM THIS SUBROUTINE.
. ---------------------------------------------------------------
. 
GETDATE  MOVE      " " TO DATERROR
         MOVE      " " TO DATFLG
         DISPLAY   *P1:22,*EL,"ENTER ",DATEDESC
         KEYIN     *P23:22,*+,*JR,*ZF,MM
.
         MATCH     "0?",MM
         GOTO      GD10 IF EQUAL
         KEYIN     *P25:22,*+,"/",*JR,*ZF,DD,"/",*JR,*ZF,*-,YY
         TYPE      MM                            TEST FOR NUMERIC MONTH
         GOTO      GD1 IF EQUAL
         MOVE      "E" TO DATERROR
GD1      TYPE      DD                            TEST FOR NUMERIC DAY
         GOTO      GD2 IF EQUAL
         MOVE      "E" TO DATERROR
GD2      TYPE      YY                            TEST FOR NUMERIC YEAR
         GOTO      GD3 IF EQUAL
         MOVE      "E" TO DATERROR
GD3      MATCH     " " TO DATERROR               RE-ENTER DATE IF NOT NUMERIC
         GOTO      GD3A IF EQUAL
         BEEP
         DISPLAY   *P1:22,*EL,"***INVALID DATE***   RE-ENTER",*W,*W
         GOTO      GETDATE
GD3A     MOVE      MM TO FM
         MOVE      DD TO FD                     MOVE DATE TO NUMERIC FIELDS
         MOVE      YY TO FY
         COMPARE   "01" TO FM                   RANGE TEST MONTH
         GOTO      GD4 IF NOT LESS
         MOVE      "E" TO DATERROR
GD4      COMPARE   "13" TO FM
         GOTO      GD5 IF LESS
         MOVE      "E" TO DATERROR
GD5      COMPARE   "01" TO FD                  RANGE TEST DAY
         GOTO      GD6 IF NOT LESS
         MOVE      "E" TO DATERROR
GD6      COMPARE   "32" TO FD
         GOTO      GD7 IF LESS
         MOVE      "E" TO DATERROR
GD7      GOTO      GD9
...GD7      COMPARE   "90" TO FY                 RANGE TEST YEAR
...         GOTO      GD8 IF NOT LESS
...         MOVE      "E" TO DATERROR
...GD8      COMPARE   "99" TO FY
...         GOTO      GD9 IF LESS
...         MOVE      "E" TO DATERROR
GD9      MATCH     " " TO DATERROR
         RETURN    IF EQUAL
         BEEP                                RE-ENTER DATE IF INVALID
         DISPLAY   *P1:22,*EL,"***INVALID DATE  RE-ENTER***"
         GOTO      GETDATE
GD10     CMATCH    "X",BKUPFLG
         GOTO      GETDATE IF EQUAL
         MOVE      "X",DATFLG
         RETURN

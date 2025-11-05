+ ----------------------------------------------------------------
.  SUBROUTINE TO  VERIFY DATE IN MM/DD/YY FORMAT
.  INCLUDE THE FOLLOWING IN THE CALLING PROGRAM
. 
.  MM     DIM   2          FM    FORM  2         DATEDESC   DIM   15
.  DD     DIM   2          FD    FORM  2         DATERROR   DIM   1
.  YY     DIM   2          FY    FORM  2       
. ---------------------------------------------------------------
. 
CHECKDAT TYPE      MM                            TEST FOR NUMERIC MONTH
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
         RETURN
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
GD7      COMPARE   "78" TO FY                 RANGE TEST YEAR
         GOTO      GD8 IF NOT LESS
         MOVE      "E" TO DATERROR
GD8      COMPARE   "90" TO FY
         GOTO      GD9 IF LESS
         MOVE      "E" TO DATERROR
GD9      MATCH     " " TO DATERROR
         RETURN    IF EQUAL
         BEEP                                RE-ENTER DATE IF INVALID
         RETURN

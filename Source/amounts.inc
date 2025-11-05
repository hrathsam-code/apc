Numbers       DIM               12(0..19),(" "),("One "),("Two "),("Three "),("Four "):
                                       ("Five "),("Six "),("Seven "),("Eight "),("Nine "),("Ten "):
                                       ("Eleven "),("Twelve "),("Thirteen "),("Fourteen "):
                                       ("Fifteen "),("Sixteen "),("Seventeen "),("Eighteen "),("Nineteen ")

Tens          DIM               12(9),(" "),("Twenty "),("Thirty "),("Forty "),("Fifty "):
                                       ("Sixty "),("Seventy "),("Eighty "),("Ninety ")

Grouped_Words DIM               12(1..4),("Billion "),("Million "),("Thousand "),("Hundred ")

Groupings     DIM               3(4)
WordString    DIM               200
.Number        FORM              "4199.34"
Integer       FORM              12
Decimal       DIM               2
LeftDigit     FORM              1
MiddleDigit   FORM              1
RightDigit    FORM              1
Number        FORM              12.2

              GOTO              #S
ConverAmtToString
              EXPLODE           Number,".",Integer,Decimal
              REPLACE           " 0",Decimal
              UNPACK            INTEGER into Groupings

              FOR                X FROM "1" TO "4" USING "1"
              UNPACK            Groupings(X) into LeftDigit,MiddleDigit,RightDigit
              CONTINUE          IF (LeftDigit + RightDigit + MiddleDigit = 0)

              IF                (LeftDigit != 0)
                PACK              WordString FROM WordString,Numbers(LeftDigit),"Hundred "
              ENDIF

              IF                (MiddleDigit = 0)                       //We only have a "single" value (i.e. 6...7...8...9)
                IF                (RightDigit != 0)
                  PACK              WordString FROM WordString,Numbers(RightDigit)
                ENDIF                              //HR 8/17/2005
              ELSE
                IF                (MiddleDigit = 1)
                  PACK           WordString FROM WordString,Numbers(10 + RightDigit)
                ELSE
                  IF                (RightDigit = 0)
                    PACK              WordString FROM WordString,Tens(MiddleDigit)
                  ELSE
                    PACK              WordString FROM WordString,Tens(MiddleDigit),Numbers(RightDigit)
                  ENDIF
                ENDIF
              ENDIF

              IF                (X != 4)
                IF                (LeftDigit = 0)     //We ONLY need to add 'Hundreds' if we have a Left Digit >= 1
                  PACK              WordString FROM WordString,Grouped_Words(X)
                ELSE
                  PACK              WordString FROM WordString,Grouped_Words(X)
                ENDIF
              ENDIF
              REPEAT

              PACK              WordString FROM WordString,"and ",Decimal,"/100"
              RETURN
#s

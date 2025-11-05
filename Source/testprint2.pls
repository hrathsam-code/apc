CheckAmount        form              10.2
DCheckAmount       dim               17
mask               init              "$Z,ZZZ,ZZZ,ZZZ.99"


                   move              "100.45",CheckAmount
                   edit              CheckAmount,DCheckAmount,mask=mask,ALIGN=1




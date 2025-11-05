;=============================================================================;
;       CREATED BY:  CHIRON SOFTWARE & SERVICES, INC.                         ;
;                    4 NORFOLK LANE                                           ;
;                    BETHPAGE, NY  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  PROGRAM:    CNVVEND.PLS                                                    ;
;                                                                             ;
;   AUTHOR:    Harry Rathsam                                                  ;
;                                                                             ;
;     DATE:    07/21/2005 AT 3:54AM                                           ;
;                                                                             ;
;  PURPOSE:    Convert A/P Vendor Master                                      ;
;                                                                             ;
; REVISION:    VER     DATE     INIT       DETAILS                            ;
;                                                                             ;
;              1.0   07/21/2005   HOR     INITIAL VERSION                     ;
;                                                                             ;
;=============================================================================;
              INCLUDE           workvar.inc
              INCLUDE           Vendor.FD

OldVendor     FILE
              CALL              PrepVendor
              CALL              PrepVendorGL

              OPEN              OldVendor,"APMASTER.TXT",READ
              MOVE              "41110",VendorGL.GLCode
              MOVE              "1",VendorGL.Line

              LOOP
                READ              OldVendor,SEQ;VendorHeader
              UNTIL             (over)

                MOVE              VendorHeader.AccountNumber,Vendor.AccountNumber
                MOVE              VendorHeader.Name,Vendor.Name
                MOVE              VendorHeader.Address1,Vendor.Address1
                MOVE              VendorHeader.Address2,Vendor.Address2
                MOVE              VendorHeader.City,Vendor.City
                MOVE              VendorHeader.State,Vendor.State
                MOVE              VendorHeader.Zip,Vendor.Zip
                MOVE              "USA",Vendor.Country

                MOVE              VendorHeader.Name,Vendor.RemitName
                MOVE              VendorHeader.Address1,Vendor.RemitAddress1
                MOVE              VendorHeader.Address2,Vendor.RemitAddress2
                MOVE              VendorHeader.City,Vendor.RemitCity
                MOVE              VendorHeader.State,Vendor.RemitState
                MOVE              VendorHeader.Zip,Vendor.RemitZip
                MOVE              "USA",Vendor.RemitCountry
                MOVE              "20050721",Vendor.Rec_Added
                MOVE              "1",Vendor.UseMain
                MOVE              "1",Vendor.AutoDisburse
                MOVE              Vendor.AccountNumber,VendorKY
.                SQUEEZE           VendorHeader.Telephone,VendorHeader.Telephone,"-"
.                SQUEEZE           VendorHeader.Telephone,VendorHeader.Telephone,"."

.                MOVE              VendorHeader.Telephone,Vendor.APPhone
                MOVE              "3",Vendor.OutputMethod
                MOVE              "NET30",Vendor.TermCode

                if                (VendorHeader.AutoPay = "X")
                  move                   "1",Vendor.AutoDisburse
                else
                  clear                  Vendor.AutoDisburse
                endif

                CALL              TSTVendor
                CONTINUE          IF (ReturnFL = 0)

                MOVE              Vendor.AccountNumber,VendorGL.AccountNumber
                CALL              WrtVendor
                CALL              WrtVendorGL
              REPEAT

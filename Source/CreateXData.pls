;=============================================================================;
;       created by:  chiron software & services, inc.                         ;
;                    4 norfolk lane                                           ;
;                    bethpage, ny  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  program:    createxdata                                                   ;
;                                                                             ;
;   author:    harry rathsam                                                  ;
;                                                                             ;
;     date:    09/20/2019 at 11:02am                                             ;
;                                                                             ;
;  purpose:                                                                   ;
;                                                                             ;
; revision:    ver     date     init       details                            ;
;                                                                             ;
;              1.0   09/20/2019   hor     initial version                     ;
;                                                                             ;
;                                                                             ;
;=============================================================================;

                   include           WorkVar.inc
                   include           Cust.FD

Outputfile         file
XMLData1            XDATA
XMLData2            XDATA
RequestPosition    form              9


TraceFileName       init               "\apc\source\TraceAddr.txt"
OutputFileName      init               "\apc\source\UPSAddress.xml"

InputStream         dim                2000
InputStream1       dim               2000
InputStream2       dim               2000

..HostName            init               "wwwcie.ups.com"
HostName            init               "onlinetools.ups.com"
ResourcePath        init               "/ups.app/xml/XAV"
OutputResults       dim                10000
OutputResults2      dim                10000
Quote              init              34
CR                 init              13
LF                 init              10
.XmlType            init              "<?xml version=",Quote,"1.0",Quote,"?>",LF

.<?xml version="1.0"?>
                   open              CustFLST,READ
                   move              " ",CustKY
                   call              RDCust
                   loop
                   call              KSCust
                   until (ReturnFl = 1)
                   continue          if (Cust.InActive = 1)
                   if                (Cust.Country = "USA")
                     move              "US",Cust.Country
                   endif

                   call              CreateHttp
                   debug
                   repeat




CreateHttp
                   XMLData1.Reset
                   XMLData2.Reset
                   XMLData1.CreateElement giving result using *Position=2,*Label="AccessRequest",*Options=1

                   XMLData1.CreateElement giving result using *Position=3,*Label="AccessLicenseNumber",*Text="1D6901A8E67FA1D5"
                   XMLData1.CreateElement giving result using *Position=3,*Label="UserId",*Text="HarryStar56"
                   XMLData1.CreateElement giving result using *Position=3,*Label="Password",*Text="Taylor1156"

                   XMLData1.SaveXML     using *FileName="c:\apc\source\Validate1.xml",*Options=7
                   XMLData1.StoreXML    giving InputStream1


..                   XMLData2.CreateElement giving result using *Position=5,*Label="AddressValidationRequest",*Options=1
                   XMLData2.CreateElement giving result using *Position=2,*Label="AddressValidationRequest",*Options=1
                   XMLData2.CreateElement giving result using *Position=2,*Label="Request",*Options=1

.                   debug
                   XMLData2.GetPosition giving RequestPosition


                   XMLData2.CreateElement giving result using *Position=2,*Label="RequestAction",*Text="XAV"
                   XMLData2.CreateElement giving result using *Position=3,*Label="RequestOption",*Text="3"
                   XMLData2.CreateElement giving result using *Position=2,*Label="TransactionReference",*Options=1
                   XMLData2.CreateElement giving result using *Position=2,*Label="CustomerContext",*Text="Your Test Case Summary Description"
                   XMLData2.CreateElement giving result using *Position=3,*Label="XpciVersion",*Text="1.0"
;
; PERFECT TO THIS POINT
;
.                   move              "2357 MELVIN PL",Cust.Addr1
.                   move              "AddressLine 2",Cust.Addr2
.                   move              "Address Line 3",Cust.Addr3
.                   move              "SEAFORD",Cust.City
.                   move              "NY",Cust.St
.                   move              "US",Cust.Country
.                   move              "11783",Cust.Zip

                   XMLData2.MoveToNode    giving result using *Position=RequestPosition
                   XMLData2.CreateElement giving result using *Position=5,*Label="AddressKeyFormat",*Options=1
                   XMLData2.CreateElement giving result using *Position=2,*Label="AddressLine",*text=Cust.Addr1
                   XMLData2.CreateElement giving result using *Position=3,*Label="AddressLine",*text=Cust.Addr2
                   XMLData2.CreateElement giving result using *Position=3,*Label="AddressLine",*text=Cust.Addr3
                   XMLData2.CreateElement giving result using *Position=3,*Label="PoliticalDivision2",*text=Cust.City
                   XMLData2.CreateElement giving result using *Position=3,*Label="PoliticalDivision1",*text=Cust.St
                   XMLData2.CreateElement giving result using *Position=3,*Label="PostcodePrimaryLow",*text=Cust.Zip
                   XMLData2.CreateElement giving result using *Position=3,*Label="CountryCode",*text=Cust.Country



.    <AddressLine>2357 MELVIN PL</AddressLine>
.    <PoliticalDivision2>SEAFORD</PoliticalDivision2>
.                   <PoliticalDivision1>NY</PoliticalDivision1>
.    <PostcodePrimaryLow>11783</PostcodePrimaryLow>
.    <CountryCode>US</CountryCode>
.  </AddressKeyFormat

.  <AddressValidationRequest>
.    <Request>
.      <TransactionReference>
.        <CustomerContext>Your Test Case Summary Description</CustomerContext>
.        <XpciVersion>1.0</XpciVersion>
.      </TransactionReference>
.      <RequestAction>XAV</RequestAction>
.      <RequestOption>3</RequestOption>
.    </Request>
.    <AddressKeyFormat>
.      <ADRESSVALRequest/>
.    </AddressKeyFormat>
.  </AddressValidationRequest>
.</Root>


.<AddressValidationRequest xml:lang="en-US">
.  <Request>
.    <TransactionReference>
.      <CustomerContext>Your Test Case Summary Description</CustomerContext>
.      <XpciVersion>1.0</XpciVersion>
.    </TransactionReference>
.    <RequestAction>XAV</RequestAction>
.    <RequestOption>3</RequestOption>
.  </Request>
.
.  <AddressKeyFormat>
.    <AddressLine>2357 MELVIN PL</AddressLine>
.    <PoliticalDivision2>SEAFORD</PoliticalDivision2>
.                   <PoliticalDivision1>NY</PoliticalDivision1>
.    <PostcodePrimaryLow>11783</PostcodePrimaryLow>
.    <CountryCode>US</CountryCode>
.  </AddressKeyFormat>
.</AddressValidationRequest>


.  <AddressKeyFormat>
.    <AddressLine>2357 MELVIN PL</AddressLine>
.    <PoliticalDivision2>SEAFORD</PoliticalDivision2>
.                   <PoliticalDivision1>NY</PoliticalDivision1>
.    <PostcodePrimaryLow>11783</PostcodePrimaryLow>
.    <CountryCode>US</CountryCode>
.  </AddressKeyFormat>
.</AddressValidationRequest>


.<Root>
.  <Request>
.    <TransactionReference>
.      <CustomerContext>Your Test Case Summary Description</CustomerContext>
.      <XpciVersion>1.0</XpciVersion>
.    </TransactionReference>
.    <RequestAction>XAV</RequestAction>
.    <RequestOption>3</RequestOption>
.  </Request>
.</Root>


.                   XMLData.CreatePI  giving result using *Position=3,*Target="xml",*Data="version='1.0'"  //,*Options=1


..7450
...3611 discount
...8365

.                   debug
                   XMLData2.SaveXML     using *FileName="c:\apc\source\Validate1.xml",*Options=7
                   XMLData2.StoreXML    giving InputStream2

.                   pack              InputStream from XmlType,CR,LF:
.                                                      InputStream1,CR,LF:
.                                                      XmlType,CR,LF:
.                                                      InputStream2
                   pack              InputStream from "<?xml version=",Quote,"1.0",Quote,"?>",CR,LF:
                                                      InputStream1,CR,LF:
                                                      "<?xml version=",Quote,"1.0",Quote,"?>",CR,LF:
                                                      InputStream2

                    http               HostName,ResourcePath,*Flags=26,*Port=443,*HTTPResult=OutputResults,*result=OutputResults2:
                                                *Trace=TraceFileName,*PostMessage=InputStream,*FileName=OutputFileName
                   return




.<?xml version="1.0"?>
.<AccessRequest xml:lang="en-US">
.  <AccessLicenseNumber>1D6901A8E67FA1D5</AccessLicenseNumber>
.  <UserId>HarryStar56</UserId>
.  <Password>Taylor1156!</Password>
.</AccessRequest>
.<?xml version="1.0"?>
.<AddressValidationRequest xml:lang="en-US">
.  <Request>
.    <TransactionReference>
.      <CustomerContext>Your Test Case Summary Description</CustomerContext>
.      <XpciVersion>1.0</XpciVersion>
.    </TransactionReference>
.    <RequestAction>XAV</RequestAction>
.    <RequestOption>3</RequestOption>
.  </Request>
.
.  <AddressKeyFormat>
.    <AddressLine>2357 MELVIN PL</AddressLine>
.    <PoliticalDivision2>SEAFORD</PoliticalDivision2>
.                   <PoliticalDivision1>NY</PoliticalDivision1>
.    <PostcodePrimaryLow>11783</PostcodePrimaryLow>
.    <CountryCode>US</CountryCode>
.  </AddressKeyFormat>
.</AddressValidationRequest>


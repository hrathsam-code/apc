;=============================================================================;
;       created by:  chiron software & services, inc.                         ;
;                    4 norfolk lane                                           ;
;                    bethpage, ny  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  program:    validateaddress                                                ;
;                                                                             ;
;   author:    harry rathsam                                                  ;
;                                                                             ;
;     date:    08/12/2019 at 4:54pm                                           ;
;                                                                             ;
;  purpose:                                                                   ;
;                                                                             ;
; revision:    ver     date     init       details                            ;
;                                                                             ;
;              1.0   08/12/2019   hor     initial version                     ;
;                                                                             ;
;                                                                             ;
;=============================================================================;

                    include            Workvar.inc

Quote1              init               34
CR                  init               10
LF                  init               13

..HostName            init               "wwwcie.ups.com"
HostName            init               "wwwcie.ups.com"
.HostName            init               "onlinetools.ups.com"
ResourcePath        init               "/ups.app/xml/Track"            //,13,10,13,10
.ResourcePath        init               "/webservices/XAV"
..ResourcePath        init               "/ups.app/xml/XAV"
PostMessage         dim                10000

OutputFile          XFile
OutputString        XDATA


AccessKey           init               "1D6901A8E67FA1D5"
UserName            init               "HarryStar56"
Password            init               "Taylor1156!"

Address             record
                    recordend
OutputFile2         xfile

InputStream         dim                2000
InputStream2        dim                2000
OutputResults       dim                10000
OutputResults2      dim                10000

Flags               form               "24"

InputFile           file
InvoiceNumber      dim               10

STARTPGM           routine           InvoiceNumber
                    open               Inputfile,"TrackRequest2.xml",READ
..                    open               Inputfile,"Track_SampleRequest.xml",READ
                    read               InputFile,seq;*ABSON,InputStream2
                    pack               InputStream from InputStream2:
                                                        "<Code>01</Code>":
                                                        "<Value>",InvoiceNumber,"</Value>":
                                                        "<ReferenceNumber> </TrackRequest>"

OutputResult3       dim                1000

null                init               " "
ChangeStream        init               10," ",13," "
TraceFileName       init               "\apc\source\TrackAPC.txt"
OutputFileName      init               "\apc\source\UPSTrack.xml"

                    http               HostName,ResourcePath,*Flags=24,*Port=443,*HTTPResult=OutputResults,*result=OutputResults2,*Trace=TraceFileName,*PostMessage=InputStream,*FileName=OutputFileName
                    close              Outputfile


































































; UserName  HarryStar56
; Access Key: 1D6901A8E67FA1D5
;
;
; https://wwwcie.ups.com/addressvalidation/v1/1

.{"XAVRequest":{"AddressKeyFormat":{"ConsigneeName": "RITZ CAMERA CENTERS-1749","BuildingName":"Innoplex","AddressLine":["26601 ALISO CREEK ROAD","STE D","ALISO VIEJO TOWN CENTER"],"Region":"ROSWELL,GA,30076-1521","PoliticalDivision2":"ALISO
.VIEJO","PoliticalDivision1":"CA","PostcodePrimaryLow":"92656","PostcodeExtendedLow":"1521","Urbanization":"porto arundal","CountryCode":"US"}}}
.https://onlinetools.ups.com/addressvalidation/v1/1?regionalrequestIndicator=true&maximumcandidatelistsize=1&{"XAVRequest":{"AddressKeyFormat":{"ConsigneeName": "RITZ CAMERA CENTERS-1749","BuildingName":"Innoplex","AddressLine":["26601 ALISO CREEK
.ROAD","STE D","ALISO VIEJO TOWN CENTER"],"Region":"ROSWELL,GA,30076-1521","PoliticalDivision2":"ALISO VIEJO","PoliticalDivision1":"CA","PostcodePrimaryLow":"92656","PostcodeExtendedLow":"1521","Urbanization":"porto arundal","CountryCode":"US"}}}
.{"XAVRequest":{"AddressKeyFormat":{"ConsigneeName": "RITZ CAMERA CENTERS-1749","BuildingName":"Innoplex","AddressLine":["26601 ALISO CREEK ROAD","STE D","ALISO VIEJO TOWN CENTER"],"Region":"ROSWELL,GA,30076-1521","PoliticalDivision2":"ALISO
.VIEJO","PoliticalDivision1":"CA","PostcodePrimaryLow":"92656","PostcodeExtendedLow":"1521","Urbanization":"porto arundal","CountryCode":"US"}}} ;
.https://wwwcie.ups.com/addressvalidation/v1/1?regionalrequestIndicator=true&maximumcandidatelistsize=1&{"XAVRequest":{"AddressKeyFormat":{"ConsigneeName": "RITZ CAMERA CENTERS-1749","BuildingName":"Innoplex","AddressLine":["26601 ALISO CREEK ROAD","STE
.D","ALISO VIEJO TOWN CENTER"],"Region":"ROSWELL,GA,30076-1521","PoliticalDivision2":"ALISO VIEJO","PoliticalDivision1":"CA","PostcodePrimaryLow":"92656","PostcodeExtendedLow":"1521","Urbanization":"porto arundal","CountryCode":"US"}}} ; .<?xml
.version="1.0" ?><AddressValidationRequest xml:lang='en-US'><Request><TransactionReference><CustomerContext> Customer Context </CustomerContext></TransactionReference><RequestAction>AV</RequestAction></Request><Address>1
.Meade<City>Bethpage</City><StateProvinceCode>NY</StateProvinceCode><PostalCode>11714</PostalCode></Address></AddressValidationRequest> ;<?xml version="1.0" ?> <AccessRequest xml:lang='en-US'>
.<AccessLicenseNumber>YOURACCESSLICENSENUMBER</AccessLicenseNumber> <UserId>YOURUSERID</UserId> <Password>YOURPASSWORD</Password> </AccessRequest> <?xml version="1.0" ?> <AddressValidationRequest xml:lang='en-US'> <Request> <TransactionReference>
.<CustomerContext>Your Customer Context</CustomerContext> </TransactionReference> <RequestAction>XAV</RequestAction> <RequestOption>1</RequestOption> </Request> <AddressKeyFormat> <AddressLine>12380 MORRIS RD</AddressLine> <Region>ALPHARETTA GA
.30005-4177</Region> <PoliticalDivision2>ALPHARETTA</PoliticalDivision2> <PoliticalDivision1>GA</PoliticalDivision1> <PostcodePrimaryLow>30005</PostcodePrimaryLow> <PostcodeExtendedLow>4177</PostcodeExtendedLow> <CountryCode>US</CountryCode>
.</AddressKeyFormat> </AddressValidationRequest> .https://wwwcie.ups.com/addressvalidation/v1/1?regionalrequestIndicator=true&maximumcandidatelistsize=1&;<?xml version="1.0" ?> <AccessRequest xml:lang='en-US'>
.<AccessLicenseNumber>1D6901A8E67FA1D5</AccessLicenseNumber> <UserId>HarryStar56</UserId>. .<Password>Taylor1156!</Password> </AccessRequest> <?xml version="1.0" ?> <AddressValidationRequest xml:lang='en-US'> <Request> <TransactionReference>
.<CustomerContext>Your Customer Context</CustomerContext> </TransactionReference> .<RequestAction>XAV</RequestAction> <RequestOption>1</RequestOption> </Request> <AddressKeyFormat> <AddressLine>12380 MORRIS RD</AddressLine> <Region>ALPHARETTA GA
.30005-4177</Region> <PoliticalDivision2>ALPHARETTA</PoliticalDivision2> .<PoliticalDivision1>GA</PoliticalDivision1> <PostcodePrimaryLow>30005</PostcodePrimaryLow> <PostcodeExtendedLow>4177</PostcodeExtendedLow> <CountryCode>US</CountryCode>
.</AddressKeyFormat> </AddressValidationRequest>

.https://wwwcie.ups.com/addressvalidation/v1/1?regionalrequestIndicator=true&maximumcandidatelistsize=1&<?xml version=\"1.0\"?>
.<AccessRequest   xml:lang=\"en-US\"><AccessLicenseNumber>1D6901A8E67FA1D5</AccessLicenseNumber><UserId>HarryStar56</UserId><Password>Taylor1156!</Password></AccessRequest>
.<?xml version=\"1.0\"?>
.<AddressValidationRequest xml:lang=\"en-US\">
.  <Request><TransactionReference><CustomerContext>Your Test Case Summary Description</CustomerContext><XpciVersion>1.0</XpciVersion></TransactionReference><RequestAction>XAV</RequestAction><RequestOption>3</RequestOption>
.  </Request>
.  <AddressKeyFormat><AddressLine>608 E. Evergreen Rd</AddressLine><PoliticalDivision2>LEBANON</PoliticalDivision2>    <PoliticalDivision1>PA</PoliticalDivision1><PostcodePrimaryLow>17042</PostcodePrimaryLow><CountryCode>US</CountryCode>
.</AddressKeyFormat> .</AddressValidationRequest>

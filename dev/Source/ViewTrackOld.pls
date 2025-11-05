;=============================================================================;
;       created by:  chiron software & services, inc.                         ;
;                    4 norfolk lane                                           ;
;                    bethpage, ny  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  program:    viewtrack                                                   ;
;                                                                             ;
;   author:    harry rathsam                                                  ;
;                                                                             ;
;     date:    08/29/2019 at 1:21pm                                             ;
;                                                                             ;
;  purpose:                                                                   ;
;                                                                             ;
; revision:    ver     date     init       details                            ;
;                                                                             ;
;              1.0   08/29/2019   hor     initial version                     ;
;                                                                             ;
;                                                                             ;
;=============================================================================;

                   include           WorkVar.inc

                   include           Cust.FD
XFile1             xfile
Activity           xfile
SchemaData         dim               20000
..OutputFile         file

BigData            dim               20000
BigData2           dim               20000

XFileKey           dim               100
RecordSetXML       xfile
TrackResponseXML   xfile
ResponseXML        xfile
ShipmentXML          xfile
ShipperXML         xfile
AddressXML         xfile
PackageXML         xfile
ActivityXML        xfile
ActivityLocationXML xfile
StatusXML          xfile
StatusTypeXML      xfile
ErrorXML           xfile

null               dim               1
ShipmentCode       dim               20
ShipmentDescription dim              50
ShipmentSigned     dim               50
TransitCode        dim               5
TransitDescription dim               50
DeliveryDate       dim               8
DeliveryTime       dim               6
TrackingNumber     dim               30
.<TrackResponse>
.  <Response>

.    <TransactionReference>
.      <CustomerContext>Your Test Case SummaryDescription</CustomerContext>
.      <XpciVersion>1.0</XpciVersion>
.    </TransactionReference>
.    <ResponseStatusCode>1</ResponseStatusCode>
.    <ResponseStatusDescription>Success</ResponseStatusDescription>
.  </Response>
TransXML           xfile
Dim6               dim               6


ShippingDetails    plform            ShippingDetails

;==========================================================================================================
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

..OutputFile          XFile
HttpOutputXML        XDATA


AccessKey           init               "1D6901A8E67FA1D5"
UserName            init               "HarryStar56"
Password            init               "Taylor1156!"

Address             record
                    recordend
OutputFile2         xfile

InputStream         dim                2000
InputStream2        dim                2000
OutputResults       dim                20000
OutputResults2      dim                20000

Flags               form               "24"

InputFile           file
InvoiceNumber      dim               10
ResponseStatusCode dim               2
ErrorCode          dim               8
ErrorDescription   dim               50
HttpOutput         dim               20000

STARTPGM           routine           InvoiceNumber
                   formload          ShippingDetails

                   move              "1460312",InvoiceNumber
.                  move              "1460314",InvoiceNumber

                    open               Inputfile,"TrackRequest2.xml",READ
..                    open               Inputfile,"Track_SampleRequest.xml",READ
                    read               InputFile,seq;*ABSON,InputStream2
                    close              InputFile
                    pack               InputStream from InputStream2:
                                                        "<Code>01</Code> ":
                                                        "<Value>",InvoiceNumber,"</Value>":
                                                        "</ReferenceNumber> </TrackRequest>"

OutputResult3       dim                1000

Position           form              9
SavePosition       form              9


ChangeStream        init               10," ",13," "
TraceFileName       init               "\apc\source\TrackAPC.txt"
OutputFileName      init               "\apc\UPSTrack.xml"
OutputResults3      XDATA
                                                                   //24  + 32
..                    http               HostName,ResourcePath,*Flags=26,*Port=443,*HTTPResult=OutputResults,*result=OutputResults2,*Trace=TraceFileName,*PostMessage=InputStream   //,*FileName=OutputFileName
                    http               HostName,ResourcePath,*Flags=26,*Port=443,*HTTPResult=OutputResults,*result=HttpOutput,*Trace=TraceFileName,*PostMessage=InputStream   //,*FileName=OutputFileName
                    if                 (not zero or OutputResults != "200 200")
                      alert              stop,"Error accessing UPS system",result,"ERROR:"
.                     return
                    endif
DimData            dim               500

                   move              "TrackResponse",XFileKey

                   open              XFile1,OutputFileName   //"UPSTrack.xml"
                   getfile           XFile1,SchemaData=SchemaData
                   read              XFile1,seq;Response=ResponseXML,Shipment=ShipmentXML
                   read              ResponseXML,seq;ResponseStatusCode=ResponseStatusCode
                   if                (ResponseStatusCode != "1")
                     read              ResponseXML,null;Error=ErrorXML
                     read              ErrorXML,seq;ErrorCode=ErrorCode,ErrorDescription=ErrorDescription
                     pack              DataLine with ErrorDescription," for Invoice : ",InvoiceNumber,". Error Code : ",ErrorCode
                     alert             stop,DataLine,result,"ERROR,"
                     return
                   endif

;
; Get the Shipment Recordset
;
..                   read              XFile1,seq;Shipment=ShipmentXML
                   read              ShipmentXML,seq;Shipper=ShipperXML,Package=PackageXML

                   read              ShipperXML,null;ShipperNumber=BigData
..                   read              ShipmentXML,seq;Package=PackageXML

                   read              PackageXML,seq;DeliveryDate=DeliveryDate,TrackingNumber=TrackingNumber,Activity=ActivityXML

                   setprop           ETrackingNumber,text=TrackingNumber
                   unpack            DeliveryDate into yyyy,mm,dd
                   packkey           Date10 from mm,"-",dd,"-",yyyy
                   setprop           EDeliveryDate,text=Date10

                   loop
                   read              ActivityXML,seq;ActivityLocation=ActivityLocationXML:
                                                     Status=StatusXML,Date=DeliveryDate,Time=DeliveryTime
                   until (over)


                   read              StatusXML,seq;StatusType=StatusTypeXML
                   read              StatusTypeXML,seq;Code=TransitCode,Description=TransitDescription

                   read              ActivityLocationXML,seq;Address=AddressXML,Code=ShipmentCode:
                                                              Description=ShipmentDescription:
                                                              SignedForByName=ShipmentSigned

                   read              AddressXML,seq;AddressLine1=Cust.Addr1:
                                                    City=Cust.City:
                                                    StateProvinceCode=Cust.St:
                                                    PostalCode=Cust.Zip:
                                                    CountryCode=Cust.Country
                   call              LoadIntoListView
                   repeat
                   setprop           WShippingDetails,visible=1
                   return
;==========================================================================================================
LoadIntoListView
                   unpack            DeliveryDate into yyyy,mm,dd
                   packkey           date10 from mm,"-",dd,"-",yyyy

                   setprop           EDeliveryDate,text=Date10
                   unpack            DeliveryTime into Hours,Minutes,Seconds

                    PACK              DATALINE FROM Date10," ",";":
                                                    Hours,":",Minutes,";":
                                                    TransitDescription,";":
                                                    Cust.City,",",Cust.St,"  ",Cust.Zip

                    LVShipDetails.SetItemTextAll using *Index=9999,*Text=DataLine,*Delimiter=";"
                   return
;==========================================================================================================
OnClickClose
                   setprop           WShippingDetails,visible=0
                   return






















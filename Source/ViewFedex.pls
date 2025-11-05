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

SchemaData         dim               20000
PackagePosition    form              9

ShipmentPosition   form              9
CompletedTrackDetailsPosition form            9
TrackDetails       form              9
TrackDetailsPosition form            9
TrackReplyPosition form              8
null               dim               1
ShipmentCode       dim               20
ShipmentDescription dim              50
ShipmentSigned     dim               50
TransitCode        dim               5
TransitDescription dim               50
DeliveryDate       dim               8
DeliveryTime       dim               6
TrackingNumber     dim               30
ShipmentWeight     dim               8
ShipmentUOM        dim               8
ShippingInfo       dim               18
ShippingDescription dim              35
EstDeliveryDate    dim               8
EstDeliveryTime    dim               6
PickupDate         dim               8
DeliveryDateTime   dim               30
DeliveryType       dim               4

.                     <ShipmentWeight>
.                       <UnitOfMeasurement>
.                         <Code>LBS</Code>
.                     </UnitOfMeasurement>
.                   <Weight>4.00</Weight>
.                     </ShipmentWeight>

.               <Value>776124403942</Value>


ShippingDetails    plform            ShippingDetails
;==========================================================================================================
;
;
;
;Supported Web Services:              FedEx Web Services for Shipping
;Authentication Key:                   orYgHNFt52Kz7xgd
;Meter Number:                         250371034

;Required for All Web Services
;Developer Test Key:                   1pkwpby93pIwGVLz
;Required for FedEx Web Services for Intra Country Shipping in US and Global
;Test Account Number:                  510087160
;Test Meter Number:                    114001979
;Required for FedEx Web Services for Office and Print
;Test FedEx Office Integrator ID:      123
;Test Client Product ID:               TEST
;Test Client Product Version:          9999





;Developer Test Key:                   Mfq7FTz5bloObhRj
;Required for FedEx Web Services for Intra Country Shipping in US and Global
;Test Account Number:                  510087720
;Test Meter Number:                    114001328
;Required for FedEx Web Services for Office and Print
;Test FedEx Office Integrator ID:      123
;Test Client Product ID:               TEST
;Test Client Product Version:          9999
;
; Denton
;
;    https://wsbeta.fedex.com/web-services



..HostName            init               "wwwcie.ups.com"
;HostName            init               "wsbeta.fedex.com"                //Beta Testing
HostName            init               "ws.fedex.com"                //Beta Testing
.HostName            init               "onlinetools.ups.com"          //Live
ResourcePath        init               "/web-services"            //,13,10,13,10
.ResourcePath        init               "/webservices/XAV"
..ResourcePath        init               "/ups.app/xml/XAV"
PostMessage         dim                10000

HttpOutputXML        XDATA

TraceFileName       init               "\apc\source\FedExAPC.txt"
OutputFileName      init               "\apc\FedExTrack2.xml"

AccessKey           init               "orYgHNFt52Kz7xgd"
UserName            init               "HarryRat56"
Password            init               "Taylor1156!"

InputStream         dim                20000
InputStream2        dim                2000
OutputResults       dim                20000
OutputResults2      dim                20000

dim1               dim               1
Meridian           dim               2

Flags               form               "26"

InputFile           file
InvoiceNumber      dim               10
ResponseStatusCode dim               2
ErrorCode          dim               15
ErrorDescription   dim               50
HttpOutput         dim               20000
EventCode          dim               6

STARTPGM           routine           InvoiceNumber
                   formload          ShippingDetails

.                   move              "1460347",InvoiceNumber
.                  move              "1460314",InvoiceNumber

.               <Value>122816215025810</Value>
.            <AccountNumber>510087720</AccountNumber>



                    open               Inputfile,"FedExTrack.txt",READ
..                    open               Inputfile,"Track_SampleRequest.xml",READ
                    read               InputFile,seq;*ABSON,InputStream
                    close              InputFile
.                    pack               InputStream from InputStream2:
.                                                        "<Code>01</Code> ":
.                                                        "<Value>",InvoiceNumber,"</Value>":
.                                                        "</ReferenceNumber> </TrackRequest>"

OutputResult3       dim                1000

Position           form              9
SavePosition       form              9

                   http               HostName,ResourcePath,*Flags=Flags,*Port=443,*HTTPResult=OutputResults,*result=HttpOutput,*PostMessage=InputStream     //,*FileName=OutputFileName
                   if                 (not zero or OutputResults != "200 OK")
                     alert              stop,"Error accessing UPS system",result,"ERROR:"
                     return
                   endif
;
; Save the Http output to the XML XDATA record
;

                   HttpOutputXML.LoadXML using *Data=HttpOutput
                   debug
...                   HttpOutputXML.LoadXML using *Data="C:\APC\UPSTrack3.xml",*Options=1
;
; Get the appropriate labels and validate that they all exist
;

                   HttpOutputXML.FindNode giving result9 using *Filter="label='SOAP-ENV:Envelope'",*Position=6     //,*Positon=6
                   HttpOutputXML.FindNode giving result9 using *Filter="label='SOAP-ENV:Body'",*Position=0
                   HttpOutputXML.FindNode giving result9 using *Filter="Label='TrackReply'",*Position=0          ///Fuckup
                   HttpOutputXML.GetPosition giving TrackReplyPosition

                   HttpOutputXML.FindNode giving result9 using *Filter="Label='Notifications'",*Position=0          ///Fuckup
                   HttpOutputXML.FindNode giving result9 using *Filter="ParentLabel='Code'",*Position=0          ///Fuckup

;
; Check the Response status and see if it succeeded correctly.
;

                   HttpOutputXML.GetText giving ResponseStatusCode
                   squeeze           ResponseStatusCode,ResponseStatusCode
;
; If the Status isn't a "1", then something wrong happened.
; Get the error message and display it to the user
;
                   if                (ResponseStatusCode != "0")
                     HttpOutputXML.FindNode giving result9 using *Filter="Parentlabel='Message'",*Position=0          ///Fuckup
                     HttpOutputXML.GetText giving ErrorDescription

                     pack              DataLine with ErrorDescription," for Invoice : ",InvoiceNumber     //,". Error Code : ",ErrorCode
                     alert             stop,DataLine,result,"ERROR: TRACKING INFO NOT FOUND"
                     return
                   endif
;
; Get the appropriate Nodes
;
                   HttpOutputXML.FindNode giving result9 using *Filter="Label='CompletedTrackDetails'",*Position=TrackReplyPosition          //Parent Node
                   HttpOutputXML.GetPosition giving CompletedTrackDetailsPosition

                   HttpOutputXML.FindNode giving result9 using *Filter="Label='TrackDetails'",*Position=TrackReplyPosition          //Parent Node
                   HttpOutputXML.GetPosition giving TrackDetailsPosition

.                   debug
                   HttpOutputXML.FindNode giving result9 using *Filter="Label='Notification'",*Position=0          //Parent Node
                   HttpOutputXML.FindNode giving result9 using *Filter="ParentLabel='TrackingNumber'",*Position=0
                   HttpOutputXML.GetText giving TrackingNumber
;
; Get Shipment Info including weight
;
.                   debug
                   HttpOutputXML.FindNode giving result9 using *Filter="Label='ShipmentWeight'",*Position=TrackDetailsPosition
                   HttpOutputXML.GetPosition giving PackagePosition

                   HttpOutputXML.FindNode giving result9 using *Filter="ParentLabel='Value'",*Position=PackagePosition
                   HttpOutputXML.GetText giving ShipmentWeight

                   HttpOutputXML.FindNode giving result9 using *Filter="ParentLabel='Units'",*Position=PackagePosition
                   HttpOutputXML.GetText giving ShipmentUOM
                   Pack              ShippingInfo from ShipmentWeight," ",ShipmentUOM
;
; Get the Shipment Method (i.e. Fedex Ground)
;
                   HttpOutputXML.FindNode giving result9 using *Filter="Label='Service'",*Position=TrackDetailsPosition

                   HttpOutputXML.FindNode giving result9 using *Filter="ParentLabel='Description'",*Position=0
                   HttpOutputXML.GetText giving ShippingDescription

.                   debug
.                   HttpOutputXML.FindNode giving result9 using *Filter="Label='PickupDate'",*Position=ShipmentPosition
.                   if                (equal)
.                     HttpOutputXML.GetText giving PickupDate
.                   else
.                     clear             PickupDate
.                   endif

.                   HttpOutputXML.FindNode giving result9 using *Filter="ParentLabel='ScheduledDeliveryTime'",*Position=ShipmentPosition
.                   if                (equal)
.                     HttpOutputXML.GetText giving EstDeliveryTime
.                   else
.                     clear             EstDeliveryTime
.                   endif

.                   debug
.                   HttpOutputXML.FindNode giving result9 using *Filter="ParentLabel='ScheduledDeliveryDate'",*Position=ShipmentPosition
.                   if                (equal)
.                     HttpOutputXML.GetText giving EstDeliveryDate
.                   else
.                     clear             EstDeliveryDate
.                   endif

                   HttpOutputXML.MoveToNode giving result9 using *Position=TrackDetailsPosition
;
; Get the Delivery Date & Time
;
                   HttpOutputXML.FindNode giving result9 using *Filter="Label='DatesOrTimes'",*Position=TrackDetailsPosition
                   HttpOutputXML.FindNode giving result9 using *Filter="ParentLabel='Type'",*Position=0
                   HttpOutputXML.GetText giving DeliveryType
                   if                (DeliveryType = "ACTUAL_DELIVERY")
                     HttpOutputXML.FindNode giving result9 using *Filter="ParentLabel='DateOrTimestamp'",*Position=0
                     HttpOutputXML.GetText giving DeliveryDateTime
                     unpack          DeliveryDateTime into yyyy,dim1,mm,dim1,dd,dim1,HoursF,Minutes
                     packkey         DeliveryDate into yyyy,mm,dd
                     packkey         DeliveryTime into HoursF,Minutes,Seconds
                     replace         " 0",DeliveryTime
                   endif




;
; Display the Tracking Number and Delivery Info
;
                   setprop           ETrackingNumber,text=TrackingNumber
                   setprop           EDeliveryDate,text=Date10
                   setprop           EShippingWeight,text=ShippingInfo
                   setprop           EShipVia,text=ShippingDescription

                   squeeze           PickupDate,PickupDate
                   if                (PickupDate !="")
                     unpack            PickupDate into yyyy,mm,dd
                     packkey           Date10 from mm,"-",dd,"-",yyyy
                   else
                     move              " ",Date10
                   endif
                   setprop           EPickupDate,text=Date10

                   squeeze           DeliveryDate,DeliveryDate
                   if                (DeliveryDate !="")
                     unpack            DeliveryDate into yyyy,mm,dd
                     packkey           Date10 from mm,"-",dd,"-",yyyy
                   else
                     move              " ",Date10
                   endif
                   setprop           EDeliveryDate,text=Date10

                   squeeze           EstDeliveryDate,EstDeliveryDate
                   if                (EstDeliveryDate !="")
                     unpack            EstDeliveryDate into yyyy,mm,dd
                     packkey           Date10 from mm,"-",dd,"-",yyyy
                   else
                     move              " ",Date10
                   endif
                   setprop           EEstDeliveryDate,text=Date10

                   squeeze           EstDeliveryTime,EstDeliveryTime
                   if                (EstDeliveryTime !="")
                     unpack            EstDeliveryTime into HoursF,Minutes,Seconds
                     if                (HoursF > 12)
                       subtract          "12",HoursF
                       move              "PM",Meridian
                     else
                       move              "AM",Meridian
                     endif
                     pack              Time from HoursF,":",Minutes
                     squeeze           Time,Time
                     pack           TimeDisplayed,Time," ",Meridian
                   else
                     move              " ",TimeDisplayed
                   endif
                   setprop           EEstDeliveryTime,text=TimeDisplayed

;
; Let's go through all the Activity records to display it to the user
;
                   HttpOutputXML.FindNode giving result9 using *Filter="Label='Events'",*Position=TrackDetailsPosition

                   loop
;
; Save this position, we'll need it later
;
                     HttpOutputXML.GetPosition giving SavePosition
                     HttpOutputXML.GetPosition giving Position
;
; Get the Transaction Date & Time
;
                     HttpOutputXML.FindNode giving result9 using *Filter="ParentLabel='Timestamp'",*Position=0
                     HttpOutputXML.GetText giving DeliveryDateTime
                     unpack          DeliveryDateTime into yyyy,dim1,mm,dim1,dd,dim1,HoursF,Minutes
                     packkey         DeliveryDate into yyyy,mm,dd
                     packkey         DeliveryTime into HoursF,Minutes,Seconds
                     replace         " 0",DeliveryDate
                     replace         " 0",DeliveryTime

                   debug
                     HttpOutputXML.FindNode giving result9 using *Filter="ParentLabel='EventType'",*Position=Position
                     HttpOutputXML.GetText giving EventCode
                     if              (EventCode = "PU")
                       unpack            DeliveryDate into yyyy,mm,dd
                       packkey           Date10 from mm,"-",dd,"-",yyyy
                       setprop           EPickupDate,text=Date10
                     endif

.                     if              (EventCode = "DL")
.                       unpack            DeliveryDate into yyyy,mm,dd
.                       packkey           Date10 from mm,"-",dd,"-",yyyy
.                       setprop           EPickupDate,text=Date10
.                     endif

;
; Get the Transit Description
;
..                   debug
                     HttpOutputXML.FindNode giving result9 using *Filter="ParentLabel='EventDescription'",*Position=Position
                     HttpOutputXML.GetText giving TransitDescription
;
; Get the address info for each transaction
;
                     HttpOutputXML.MoveToNode giving result9 using *Position=Position
                     HttpOutputXML.FindNode giving result9 using *Filter="Label='Address'",*Position=0

                     HttpOutputXML.FindNode giving result9 using *Filter="ParentLabel='City'",*Position=1
                     HttpOutputXML.GetText giving Cust.City

                     HttpOutputXML.FindNode giving result9 using *Filter="ParentLabel='StateOrProvinceCode'",*Position=1
                     HttpOutputXML.GetText giving Cust.St

                     HttpOutputXML.FindNode giving result9 using *Filter="ParentLabel='PostalCode'",*Position=1
                     HttpOutputXML.GetText giving Cust.Zip

                     HttpOutputXML.FindNode giving result9 using *Filter="ParentLabel='CountryCode'",*Position=1
                     HttpOutputXML.GetText giving Cust.Country
;
; Get the Status & StatusType nodes so we can get the Transit Info
;
;
; Load each transaction into the Listview
;
                     call              LoadIntoListView
;
; Reset the Position in the XML data stream so that we can get the next Activity node
;
                     HttpOutputXML.MoveToNode giving result using *Position=SavePosition
                     HttpOutputXML.FindNode giving result9 using *Filter="Label='Events'",*Position=5

                   until             (not zero)
                   repeat
                   setprop           WShippingDetails,visible=1
                   return
;==========================================================================================================
LoadIntoListView

                   unpack            DeliveryDate into yyyy,mm,dd
                   packkey           date10 from mm,"-",dd,"-",yyyy

                   unpack            DeliveryTime into HoursF,Minutes,Seconds
                   if                (HoursF > 12)
                     subtract          "12",HoursF
                     move              "PM",Meridian
                   else
                     move              "AM",Meridian
                   endif
                   pack              Time from HoursF,":",Minutes
                   squeeze           Time,Time

                   pack              TimeDisplayed,Time," ",Meridian

                   PACK              DATALINE FROM Date10," ",";":
                                                   Time," ",Meridian,";":
                                                   TransitDescription,";":
                                                   Cust.City,",",Cust.St,"  ",Cust.Zip

                   LVShipDetails.SetItemTextAll using *Index=9999,*Text=DataLine,*Delimiter=";"
                   return
;==========================================================================================================
OnClickCopyTrackingNumber
                   ETrackingNumber.Copy
                   return
;==========================================================================================================
OnClickClose
                   setprop           WShippingDetails,visible=0
                   return






















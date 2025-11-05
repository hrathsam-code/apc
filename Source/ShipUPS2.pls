;=============================================================================;
;       created by:  chiron software & services, inc.                         ;
;                    4 norfolk lane                                           ;
;                    bethpage, ny  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  program:    viewtrack                                                      ;
;                                                                             ;
;   author:    harry rathsam                                                  ;
;                                                                             ;
;     date:    08/29/2019 at 1:21pm                                           ;
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

ShipmentPosition   form              9
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
TrackingNumber2    dim               28

.                     <ShipmentWeight>                    12 Lillian Place,Farmingdale    Martha
.                       <UnitOfMeasurement>
.                         <Code>LBS</Code>
.                     </UnitOfMeasurement>
.                   <Weight>4.00</Weight>
.                     </ShipmentWeight>


ShippingDetails    plform            ShippingDetails
;==========================================================================================================

..HostName            init               "wwwcie.ups.com"
HostName            init               "wwwcie.ups.com"                //Beta Testing
.HostName            init               "onlinetools.ups.com"          //Live
ResourcePathConfirm init               "/ups.app/xml/ShipConfirm"
ResourcePathAccept  init               "/ups.app/xml/ShipAccept"
ResourcePathLabel   init               "ups.app/xml/LabelRecovery"

...wwwcie.ups.com/ups.app/xml/ShipConfirm

.ResourcePath        init               "/webservices/XAV"
..ResourcePath        init               "/ups.app/xml/XAV"
PostMessage         dim                10000

HttpOutputXML        XDATA

TraceFileName       init               "\apc\source\ShipAPC.txt"
OutputFileName      init               "s.xml"
InputFileName      init                "C:\APC\upsshipacceptrespons.xml"

AccessKey           init               "1D6901A8E67FA1D5"
UserName            init               "HarryStar56"
Password            init               "Taylor1156!"

InputStream         dim                40000
InputStream2        dim                40000
OutputResults       dim                20000
OutputResults2      dim                20000
ErrorResults        dim                20000

Meridian           dim               2

Flags               form              "26"      //"154"    //"60"       // "26"

InputFile           file
OutputFile         file
PurchaseOrder      dim               20
ResponseStatusCode dim               2
ErrorCode          dim               15
ErrorDescription   dim               50
HttpOutput         dim               60000
ShippingDigest     dim               30000

STARTPGM           routine           PurchaseOrder
                   formload          ShippingDetails

.                   move              "1460347",PurchaseOrder
.                  move              "1460314",PurchaseOrder

                    open               Inputfile,"ShipConfirm4.xml",READ
..                    open               Inputfile,"Track_SampleRequest.xml",READ
                    read               InputFile,seq;*ABSON,InputStream
.                    squeeze          InputStream,InputStream
;
; Save the Http output to the XML XDATA record
;

                   HttpOutputXML.LoadXML using *Data=HttpOutput,*Options=3
                   debug

....Not Required                   HttpOutputXML.FindNode giving result9 using *Filter="label='ShipmentConfirmResponse'",*Position=6     //,*Positon=6
                   HttpOutputXML.FindNode giving result9 using *Filter="Parentlabel='ShipmentDigest'",*Position=6     //,*Positon=6
                   HttpOutputXML.GetText giving ShippingDigest

                    open               Inputfile,"ShipAccept3.xml",READ
                    read               InputFile,seq;*ABSON,InputStream2
                    close              InputFile

                    pack               InputStream from InputStream2:
                                                        ShippingDigest:
                                                        "</ShipmentDigest>":
                                                        "</ShipmentAcceptRequest>"


                   debug
                   http               HostName,ResourcePathAccept,*Flags=Flags,*Port=443,*HTTPResult=OutputResults:
                                                                   *result=HttpOutput:
                                                                   *PostMessage=InputStream:
                                                                   *HttpLength=HttpLength:
                                                                   *HttpType=HttpType:
                                                                   *Error=ErrorResults:
                                                                   *Trace=TraceFileName:
                                                                   *MaxDataSize=20000:
                                                                   *TimeOut=5000:
                                                                   *ResultLength=ResultLength
                                                                   //*FileName=OutputFileName //,*Trace=TraceFileName,  *Trace=TraceFileName,

                   prep              OutputFile,"\apc\UPSShipAcceptRespons.xml",exclusive
                   write             OutputFile,seq;*ABSON,HttpOutput
                   weof              OutputFile,seq
                   close             OutputFile


...                   HttpOutputXML.LoadXML using *Data="C:\APC\UPSTrack3.xml",*Options=1
;
; Get the appropriate labels and validate that they all exist
;
                   HttpOutputXML.FindNode giving result9 using *Filter="label='TrackResponse'",*Position=6     //,*Positon=6
                   HttpOutputXML.FindNode giving result9 using *Filter="label='Response'",*Position=0
                   HttpOutputXML.FindNode giving result9 using *Filter="Parentlabel='ResponseStatusCode'",*Position=0          ///Fuckup
;
; Check the Response status and see if it succeeded correctly.
;
                   HttpOutputXML.GetText giving ResponseStatusCode
                   squeeze           ResponseStatusCode,ResponseStatusCode
;
; If the Status isn't a "1", then something wrong happened.
; Get the error message and display it to the user
;
                   if                (ResponseStatusCode != "1")
                     HttpOutputXML.FindNode giving result9 using *Filter="label='Error'",*Position=1          ///Fuckup
                     HttpOutputXML.FindNode giving result9 using *Filter="Parentlabel='ErrorCode'",*Position=0          ///Fuckup
                     HttpOutputXML.GetText giving ErrorCode

                     HttpOutputXML.FindNode giving result9 using *Filter="Parentlabel='ErrorDescription'",*Position=1          ///Fuckup
                     HttpOutputXML.GetText giving ErrorDescription

                     pack              DataLine with ErrorDescription," for Purchase Order : ",PurchaseOrder     //,". Error Code : ",ErrorCode
                     alert             stop,DataLine,result,"ERROR: TRACKING INFO NOT FOUND"
                     return
                   endif
;
; Get the appropriate Nodes
;
                   HttpOutputXML.FindNode giving result9 using *Filter="Label='Shipment'",*Position=6          //Parent Node
                   HttpOutputXML.GetPosition giving ShipmentPosition
;
; Get Shipment Info including weight
;

                   debug
                   HttpOutputXML.FindNode giving result9 using *Filter="ParentLabel='PickupDate'",*Position=ShipmentPosition
                   if                (equal)
                     HttpOutputXML.GetText giving PickupDate
                   else
                     clear             PickupDate
                   endif

                   HttpOutputXML.FindNode giving result9 using *Filter="ParentLabel='ScheduledDeliveryTime'",*Position=ShipmentPosition
                   if                (equal)
                     HttpOutputXML.GetText giving EstDeliveryTime
                   else
                     clear             EstDeliveryTime
                   endif

                   debug
                   HttpOutputXML.FindNode giving result9 using *Filter="ParentLabel='ScheduledDeliveryDate'",*Position=ShipmentPosition
                   if                (equal)
                     HttpOutputXML.GetText giving EstDeliveryDate
                   else
                     clear             EstDeliveryDate
                   endif


                   HttpOutputXML.FindNode giving result9 using *Filter="Label='Service'",*Position=ShipmentPosition
                   HttpOutputXML.FindNode giving result9 using *Filter="ParentLabel='Description'",*Position=0
                   HttpOutputXML.GetText giving ShippingDescription

                   HttpOutputXML.MoveToNode giving result9 using *Position=Position

                   debug
                   HttpOutputXML.FindNode giving result9 using *Filter="Label='ShipmentWeight'",*Position=ShipmentPosition
                   HttpOutputXML.FindNode giving result9 using *Filter="ParentLabel='Weight'",*Position=0
                   HttpOutputXML.GetText giving ShipmentWeight

                   HttpOutputXML.FindNode giving result9 using *Filter="Label='UnitOfMeasurement'",*Position=6
                   HttpOutputXML.FindNode giving result9 using *Filter="ParentLabel='Code'",*Position=0
                   HttpOutputXML.GetText giving ShipmentUOM
                   Pack              ShippingInfo from ShipmentWeight," ",ShipmentUOM

                   HttpOutputXML.FindNode giving result9 using *Filter="Label='Shipper'",*Position=6
                   HttpOutputXML.FindNode giving result9 using *Filter="Label='Package'",*Position=0
;
; Get the Delivery Date & Time
;
                   HttpOutputXML.FindNode giving result9 using *Filter="ParentLabel='DeliveryDate'",*Position=0
                   HttpOutputXML.GetText giving DeliveryDate

                   HttpOutputXML.FindNode giving result9 using *Filter="ParentLabel='TrackingNumber'",*Position=6
                   HttpOutputXML.GetText giving TrackingNumber
;
; Display the Tracking Number and Delivery Info
;

                   edit              TrackingNumber into TrackingNumber2 with Mask=UPSMask
                   setprop           ETrackingNumber,text=TrackingNumber2
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
                   HttpOutputXML.FindNode giving result9 using *Filter="Label='Activity'",*Position=6

                   loop
;
; Save this position, we'll need it later
;
                     HttpOutputXML.GetPosition giving SavePosition
                     HttpOutputXML.GetPosition giving Position
;
; Get the Transaction Date & Time
;
                     HttpOutputXML.FindNode giving result9 using *Filter="ParentLabel='Date'",*Position=0
                     HttpOutputXML.GetText giving DeliveryDate

                     HttpOutputXML.FindNode giving result9 using *Filter="ParentLabel='Time'",*Position=1
                     HttpOutputXML.GetText giving DeliveryTime
;
; Get the address info for each transaction
;
                     HttpOutputXML.MoveToNode giving result9 using *Position=Position
                     HttpOutputXML.FindNode giving result9 using *Filter="Label='ActivityLocation'",*Position=0

                     HttpOutputXML.FindNode giving result9 using *Filter="Label='Address'",*Position=1

                     HttpOutputXML.FindNode giving result9 using *Filter="ParentLabel='City'",*Position=1
                     HttpOutputXML.GetText giving Cust.City

                     HttpOutputXML.FindNode giving result9 using *Filter="ParentLabel='StateProvinceCode'",*Position=1
                     HttpOutputXML.GetText giving Cust.St

                     HttpOutputXML.FindNode giving result9 using *Filter="ParentLabel='PostalCode'",*Position=1
                     HttpOutputXML.GetText giving Cust.Zip

                     HttpOutputXML.FindNode giving result9 using *Filter="ParentLabel='CountryCode'",*Position=1
                     HttpOutputXML.GetText giving Cust.Country
;
; Get the Status & StatusType nodes so we can get the Transit Info
;
.                   debug
                     HttpOutputXML.MoveToNode giving result9 using *Position=Position

                     HttpOutputXML.FindNode giving result9 using *Filter="Label='Status'",*Position=0          //Parent Node
                     HttpOutputXML.FindNode giving result9 using *Filter="Label='StatusType'",*Position=0

                     HttpOutputXML.FindNode giving result9 using *Filter="ParentLabel='Code'",*Position=0
                     HttpOutputXML.GetText giving TransitCode

.                     debug
                     HttpOutputXML.FindNode giving result9 using *Filter="ParentLabel='Description'",*Position=1
                     HttpOutputXML.GetText giving TransitDescription
;
; Load each transaction into the Listview
;
                     call              LoadIntoListView
;
; Reset the Position in the XML data stream so that we can get the next Activity node
;
                     HttpOutputXML.MoveToNode giving result using *Position=SavePosition
                     HttpOutputXML.FindNode giving result9 using *Filter="Label='Activity'",*Position=5

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
OnClickClose
                   setprop           WShippingDetails,visible=0
                   return






















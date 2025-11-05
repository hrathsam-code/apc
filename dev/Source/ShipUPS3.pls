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
                   include           Sequence.fd
                   include           Cust.FD
                   include           PrintRtn.inc
                   include           CNTRY.fd


SchemaData         dim               20000

RequestPosition    form              9
PaymentFlag        form              "1"

UPSRecord          record
ShipToName         dim               30
ShipToAddress1     dim               30
ShipToAddress2     dim               30
ShipToAddress3     dim               30
ShipToCity         dim               30
ShipToState        dim               2
ShipToCountry      dim               2
ShipVia            dim               25
Weight             form              3.2
Cartons            form              2
InvoiceAmount      form              7.2
ShipToAcctNo       dim               6
                   recordend

.ShipViaUPSF        plform            ShipViaUPS

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

ConfirmStream      dim               60000
AcceptStream       dim               60000
LoginStream        dim               60000

InputStream        dim               60000
;==========================================================================================================
..HostName            init               "wwwcie.ups.com"
HostName            init               "wwwcie.ups.com"                //Beta Testing
.HostName            init               "onlinetools.ups.com"          //Live
ResourcePathConfirm init               "/ups.app/xml/ShipConfirm"
ResourcePathAccept  init               "/ups.app/xml/ShipAccept"
ResourcePathLabel   init               "ups.app/xml/LabelRecovery"

PostMessage         dim                10000

HttpOutputXML        XDATA

TraceFileName       init               "\apc\source\ShipAPC.txt"
OutputFileName      init               "\apc\UPSShipConfirmResponse.xml"

AccessKey           init               "1D6901A8E67FA1D5"
UserName            init               "HarryStar56"
Password            init               "Taylor1156!"

OutputResults       dim                20000
OutputResults2      dim                20000
ErrorResults        dim                20000
GraphicImage       dim               65000
GraphicImage2      dim               65000
GraphicImage3      dim               65000

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
OutputResult3      dim               1000

XMLDataLogin       XDATA
XMLConfirm         XDATA
XMLAccept          XDATA

ShipperPosition    form              9
LabelPosition      form              9
PackagePosition    form              9
Position           form              9
SavePosition       form              9
HttpLength         form              7
HttpType           dim               20000
ResultLength       form              7
Quote              init              34
CR                 init              13
LF                 init              10

IEObject           automation

.                   debug
.                   create            IEObject,Class="InternetExplorer.Application"
.                   IEObject.navigate using "\apc\data\Harry.gif"
.                   setprop           IEObject,*Visible=1
.                   IEObject.ExecWB   using *cmdID=6,*cmdexecopt=1


.                   call              OpenCntry
.                   call              GetFields

                   call              CreateHttpLogin
                   call              CreateHttpShipConfirm

                   pack              InputStream from "<?xml version=",Quote,"1.0",Quote,"?>",CR,LF:
                                                      LoginStream,CR,LF:
                                                      "<?xml version=",Quote,"1.0",Quote,"?>",CR,LF:
                                                      ConfirmStream

                   http               HostName,ResourcePathConfirm,*Flags=Flags,*Port=443,*HTTPResult=OutputResults:
                                                                   *result=HttpOutput:
                                                                   *PostMessage=InputStream:
                                                                   *HttpType=HttpType:
                                                                   *Error=ErrorResults:
                                                                   *Trace=TraceFileName:
                                                                   *ResultLength=ResultLength

                   prep              OutputFile,OutputFileName,exclusive
                   write             OutputFile,seq;*ABSON,HttpOutput
                   weof              OutputFile,seq
                   close             OutputFile

                   if                 (not zero or OutputResults != "200 OK")
                     pack               DataLine from "Error accessing UPS System. ERROR MESSAGE: ",s$error$,"."
                     alert              stop,DataLine,result,"ERROR:"
                     return
                   endif
;
; Save the Http output to the XML XDATA record
;
                   HttpOutputXML.LoadXML using *Data=HttpOutput
.                   debug

                   HttpOutputXML.FindNode giving result9 using *Filter="Parentlabel='ShipmentDigest'",*Position=6     //,*Positon=6
                   HttpOutputXML.GetText giving ShippingDigest

                   call              CreateHttpShipAccept
                   pack              InputStream from "<?xml version=",Quote,"1.0",Quote,"?>",CR,LF:
                                                      LoginStream,CR,LF:
                                                      "<?xml version=",Quote,"1.0",Quote,"?>",CR,LF:
                                                      AcceptStream

                   http               HostName,ResourcePathAccept:
                                               *Flags=Flags:
                                               *Port=443:
                                               *HTTPResult=OutputResults:
                                               *result=HttpOutput:
                                               *PostMessage=InputStream:
                                               *Trace=TraceFileName

                   prep              OutputFile,"\apc\UPSShipAcceptResponse.xml",exclusive
                   write             OutputFile,seq;*ABSON,HttpOutput
                   weof              OutputFile,seq
                   close             OutputFile

                   HttpOutputXML.LoadXML using *Data=HttpOutput
;
; Get the appropriate labels and validate that they all exist
;
                   HttpOutputXML.FindNode giving result9 using *Filter="label='ShipmentAcceptResponse'",*Position=6     //,*Positon=6
                   HttpOutputXML.GetPosition giving ShipmentPosition

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
                   HttpOutputXML.FindNode giving result9 using *Filter="Label='ShipmentResults'",*Position=6    //Parent Node
                   HttpOutputXML.GetPosition giving ShipmentPosition
;
; Get Package Tracking Number and Image
;
                   HttpOutputXML.FindNode giving result9 using *Filter="Label='PackageResults'",*Position=0
                   HttpOutputXML.GetPosition giving PackagePosition
;
; Get the Tracking Number first
;
                   HttpOutputXML.FindNode giving result9 using *Filter="ParentLabel='TrackingNumber'",*Position=0
                   HttpOutputXML.GetText giving TrackingNumber
;
; Get the Graphic Image
;
                   HttpOutputXML.MoveToNode giving result9 using *Position=PackagePosition
                   HttpOutputXML.FindNode giving result9 using *Filter="ParentLabel='GraphicImage'",*Position=0
                   HttpOutputXML.GetText giving GraphicImage

                   debug
                   decode64          GraphicImage,GraphicImage2

                   debug
OutputImageName    dim               100
                   chop              TrackingNumber,TrackingNumber
                   pack              OutputImageName from "\apc\data\label",TrackingNumber,".EPL"
                   prep              OutputFile,OutputImageName,exclusive
                   write             OutputFile,seq;*ABSON,*LL,GraphicImage2
..HR 2019.11.13                   weof              OutputFile,seq
                   close             OutputFile

                   HttpOutputXML.FindNode giving result9 using *Filter="ParentLabel='HTMLImage'",*Position=PackagePosition
                   HttpOutputXML.GetText giving GraphicImage
                   decode64          GraphicImage,GraphicImage3
                   prep              OutputFile,"\APC\Data\harryHTML.html",exclusive
                   write             OutputFile,seq;*ABSON,GraphicImage3
                   weof              Outputfile,seq
                   close             OutputFile                                           1039
.                                                                                    similar name, different address

                   debug
.                   HttpOutputXML.MoveToNode    giving result using *Position=ShipmentPosition
.                   HttpOutputXML.FindNode giving result9 using *Filter="Label='ControlLogReceipt'",*Position=6    //Parent Node
.                   HttpOutputXML.FindNode giving result9 using *Filter="ParentLabel='GraphicImage'",*Position=0

.                   HttpOutputXML.GetText giving GraphicImage
.                   decode64          GraphicImage,GraphicImage2
.                   pack              OutputImageName from "\apc\data\label",TrackingNumber,".html"
.                   prep              OutputFile,OutputImageName,exclusive
.                   write             OutputFile,seq;*ABSON,*LL,GraphicImage2
.                   close             OutputFile


Pic1               picture                                                          Austin HW
Image              dim               65000
pictchar           init              4,3

                   splopen           P,"","R"

                   print             P;*LL,GraphicImage2

.                   call              PrintClose
                   splclose
                   stop
;==========================================================================================================
CreateHttpLogin

                   XMLDataLogin.Reset
                   XMLDataLogin.Reset
                   XMLDataLogin.CreateElement giving result using *Position=2,*Label="AccessRequest",*Options=1

                   XMLDataLogin.CreateElement giving result using *Position=3,*Label="AccessLicenseNumber",*Text=AccessKey
                   XMLDataLogin.CreateElement giving result using *Position=3,*Label="UserId",*Text=UserName
                   XMLDataLogin.CreateElement giving result using *Position=3,*Label="Password",*Text=Password
                   XMLDataLogin.StoreXML    giving LoginStream
                   return
;==========================================================================================================
CreateHttpShipConfirm
                   XMLConfirm.Reset
                   XMLConfirm.CreateElement giving result using *Position=2,*Label="ShipmentConfirmRequest",*Options=1
..                   XMLConfirm.CreateElement giving result using *Position=2,*Label="ShipConfirmRequest",*Options=1
                   XMLConfirm.CreateElement giving result using *Position=2,*Label="Request",*Options=1

                   XMLConfirm.GetPosition giving RequestPosition
                   XMLConfirm.CreateElement giving result using *Position=2,*Label="TransactionReference",*Options=1
                   XMLConfirm.CreateElement giving result using *Position=2,*Label="CustomerContext",*Text="Your Test Case Summary Description"
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="XpciVersion"

                   XMLConfirm.CreateElement giving result using *Position=5,*Label="RequestOption",*Text="validate"
                   XMLConfirm.CreateElement giving result using *Position=5,*Label="RequestAction",*Text="ShipConfirm"

                   XMLConfirm.MoveToNode    giving result using *Position=RequestPosition
                   XMLConfirm.CreateElement giving result using *Position=5,*Label="LabelSpecification",*Options=1
                   XMLConfirm.GetPosition giving LabelPosition

                   XMLConfirm.CreateElement giving result using *Position=2,*Label="HTTPUserAgent",*text="Mozilla/5.0"
;
; Moved above
;

                   XMLConfirm.CreateElement giving result using *Position=2,*Label="LabelPrintMethod",*Options=1
                   XMLConfirm.CreateElement giving result using *Position=2,*Label="Code",*text="EPL"    //STARPL"            //GIF
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="Description",*text="ZPL"

                   XMLConfirm.MoveToNode    giving result using *Position=LabelPosition
.                   XMLConfirm.CreateElement giving result using *Position=2,*Label="LabelImageFormat",*Options=1
.                   XMLConfirm.CreateElement giving result using *Position=2,*Label="Code",*text="ZPL"    //STARPL"            //GIF
.                   XMLConfirm.CreateElement giving result using *Position=3,*Label="Description",*text="GIF Description"

                   XMLConfirm.CreateElement giving result using *Position=2,*Label="LabelStockSize",*Options=1

                   XMLConfirm.CreateElement giving result using *Position=2,*Label="Height",*text="4"   //LabelHeight    //STARPL"            //GIF
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="Width",*text="6"   //LabelWidth



..HR 2019.11.14                   XMLConfirm.CreateElement giving result using *Position=2,*Label="Code",*text="ZPL"    //STARPL"            //GIF
..HR 2019.11.14                   XMLConfirm.CreateElement giving result using *Position=3,*Label="Description",*text="ZPL"


...HR 20191114 test                   XMLConfirm.CreateElement giving result using *Position=5,*Label="LabelImageFormat",*Options=1
;
; PERFECT TO THIS POINT
;
                   move              "75 TOLEDO ST",Cust.Addr1
                   move              "FARMINGDALE",Cust.City
                   move              "NY",Cust.St
                   move              "US",Cust.Country
                   move              "11735",Cust.Zip

                   XMLConfirm.MoveToNode    giving result using *Position=LabelPosition

                   XMLConfirm.CreateElement giving result using *Position=5,*Label="Shipment",*Options=1
                   XMLConfirm.GetPosition giving ShipmentPosition

                   XMLConfirm.CreateElement giving result using *Position=2,*Label="RateInformation",*Options=1
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="NegotiatedRatesIndicator"
                   XMLConfirm.GetPosition giving ShipmentPosition

                   XMLConfirm.CreateElement giving result using *Position=5,*Label="Shipper",*Options=1
                   XMLConfirm.GetPosition giving ShipperPosition

                   XMLConfirm.CreateElement giving result using *Position=3,*Label="Name",*Text="APC Components"
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="PhoneNumber",*Text="6312494079"
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="ShipperNumber",*Text="156620"    //936095"
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="TaxIdentificationNumber",*Text="1234567890"

                   XMLConfirm.CreateElement giving result using *Position=3,*Label="Address",*Options=1
                   XMLConfirm.CreateElement giving result using *Position=2,*Label="AddressLine1",*text=Cust.Addr1
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="City",*text=Cust.City
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="StateProvinceCode",*text=Cust.St
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="PostalCode",*text=Cust.Zip
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="PostcodeExtendedLow",*text="H"
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="CountryCode",*text="US"

                   XMLConfirm.MoveToNode    giving result using *Position=ShipperPosition

                   move              "7 FRANKFORD AVE",Cust.Addr1
                   move              "ANNISTON",Cust.City
                   move              "AL",Cust.St
                   move              "US",Cust.Country
                   move              "36201-4199",Cust.Zip
                   move              "",Cust.telephone
                   move              "936095",Cust.ShippingAcct(1)

                   XMLConfirm.CreateElement giving result using *Position=5,*Label="ShipTo",*Options=1
                   XMLConfirm.CreateElement giving result using *Position=2,*Label="CompanyName",*text="BISCO IND."
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="AttentionName",*text="Eileen"
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="PhoneNumber",*text=Cust.telePhone

                   XMLConfirm.CreateElement giving result using *Position=3,*Label="Address",*Options=1
                   XMLConfirm.CreateElement giving result using *Position=2,*Label="AddressLine1",*text=Cust.Addr1
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="City",*text=Cust.City
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="StateProvinceCode",*text=Cust.St
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="PostalCode",*text=Cust.Zip
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="CountryCode",*text="US"

                   XMLConfirm.MoveToNode    giving result using *Position=ShipperPosition
                   XMLConfirm.MoveToNode    giving result using *Position=5

                   XMLConfirm.CreateElement giving result using *Position=5,*Label="ShipFrom",*Options=1
                   XMLConfirm.CreateElement giving result using *Position=2,*Label="CompanyName",*text="APC COMPONENTS"
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="AttentionName",*Text="Ship From Attn Name"
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="PhoneNumber",*Text="6312494079"
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="TaxIdentificationNumber",*Text="1234567890"

                   XMLConfirm.CreateElement giving result using *Position=3,*Label="Address",*Options=1
                   XMLConfirm.CreateElement giving result using *Position=2,*Label="AddressLine1",*text="75 TOLEDO ST"
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="City",*text="FARMINGDALE"
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="StateProvinceCode",*text="NY"
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="PostalCode",*text="11735-6620"
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="CountryCode",*text="US"

                   XMLConfirm.MoveToNode    giving result using *Position=ShipperPosition
                   XMLConfirm.MoveToNode    giving result using *Position=5
                   XMLConfirm.MoveToNode    giving result using *Position=5

                   XMLConfirm.CreateElement giving result using *Position=5,*Label="PaymentInformation",*Options=1

                   switch            PaymentFlag
                   case              1                            //Prepaid
                     XMLConfirm.CreateElement giving result using *Position=2,*Label="Prepaid",*Options=1
                     XMLConfirm.CreateElement giving result using *Position=2,*Label="BillShipper",*Options=1
                     XMLConfirm.CreateElement giving result using *Position=2,*Label="AccountNumber",*text="156620"      //156620
                   case              2                            //Paid by 3rd Party
                     XMLConfirm.CreateElement giving result using *Position=2,*Label="BillThirdParty",*Options=1
                     XMLConfirm.CreateElement giving result using *Position=2,*Label="BillThirdPartyShipper",*Options=1
                     XMLConfirm.CreateElement giving result using *Position=2,*Label="AccountNumber",*text="156620"
                     XMLConfirm.CreateElement giving result using *Position=2,*Label="ThirdParty",*Options=1
                     XMLConfirm.CreateElement giving result using *Position=3,*Label="Address",*Options=1
                     XMLConfirm.CreateElement giving result using *Position=3,*Label="PostalCode",*text=Cust.Zip
                     XMLConfirm.CreateElement giving result using *Position=3,*Label="CountryCode",*text="US"
                   case              3                            //Freight Collect
                     chop            Cust.ShippingAcct(1),Cust.ShippingAcct(1)
                     XMLConfirm.CreateElement giving result using *Position=2,*Label="FreightCollect",*Options=1
                     XMLConfirm.CreateElement giving result using *Position=2,*Label="BillReceiver",*Options=1
                     XMLConfirm.CreateElement giving result using *Position=2,*Label="AccountNumber",*text=Cust.ShippingAcct(1)  //"936095"
                     XMLConfirm.CreateElement giving result using *Position=3,*Label="Address",*Options=1
                     XMLConfirm.CreateElement giving result using *Position=3,*Label="PostalCode",*text=Cust.Zip    //Cust.Zip
;                   case              3                            //Cosignee Billed
;                     XMLConfirm.CreateElement giving result using *Position=2,*Label="ConsigneeBilled",*Options=1
;                     XMLConfirm.CreateElement giving result using *Position=2,*Label="BillReceiver",*Options=1
;                     XMLConfirm.CreateElement giving result using *Position=2,*Label="AccountNumber",*text="156620"
;                     XMLConfirm.CreateElement giving result using *Position=3,*Label="Address",*Options=1
;                     XMLConfirm.CreateElement giving result using *Position=3,*Label="PostalCode",*text=Cust.Zip
;                     XMLConfirm.CreateElement giving result using *Position=3,*Label="CountryCode",*text="US"
                   endswitch

                   XMLConfirm.MoveToNode    giving result using *Position=ShipperPosition
                   XMLConfirm.MoveToNode    giving result using *Position=5
                   XMLConfirm.MoveToNode    giving result using *Position=5
                   XMLConfirm.MoveToNode    giving result using *Position=5

                   XMLConfirm.CreateElement giving result using *Position=5,*Label="Service",*Options=1
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="Code",*text="03"
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="Description",*text="UPS GROUND"

                   XMLConfirm.MoveToNode    giving result using *Position=ShipperPosition
                   XMLConfirm.MoveToNode    giving result using *Position=5
                   XMLConfirm.MoveToNode    giving result using *Position=5
                   XMLConfirm.MoveToNode    giving result using *Position=5
                   XMLConfirm.MoveToNode    giving result using *Position=5

                   XMLConfirm.CreateElement giving result using *Position=5,*Label="Package",*Options=1
                   XMLConfirm.GetPosition giving PackagePosition

                   XMLConfirm.CreateElement giving result using *Position=2,*Label="PackagingType",*Options=1
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="Code",*text="02"
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="Description",*text="Customer Supplied"

                   XMLConfirm.MoveToNode    giving result using *Position=PackagePosition

                   XMLConfirm.CreateElement giving result using *Position=3,*Label="Description",*text="Package Description"
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="ReferenceNumber",*Options=1
                   XMLConfirm.CreateElement giving result using *Position=2,*Label="Code",*text="00"
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="Value",*text="Invoice No12345"

                   XMLConfirm.MoveToNode    giving result using *Position=PackagePosition

                   XMLConfirm.CreateElement giving result using *Position=3,*Label="PackageWeight",*Options=1
                   XMLConfirm.CreateElement giving result using *Position=2,*Label="Weight",*text="1.0"

                   XMLConfirm.MoveToNode    giving result using *Position=PackagePosition

                   XMLConfirm.CreateElement giving result using *Position=3,*Label="AdditionalHandling",*text="0"

                   XMLConfirm.MoveToNode    giving result using *Position=PackagePosition

                   debug
                   XMLConfirm.CreateElement giving result using *Position=2,*Label="PackageServiceOptions",*Options=1
                   XMLConfirm.CreateElement giving result using *Position=2,*Label="InsuredValue",*Options=1
                   XMLConfirm.CreateElement giving result using *Position=2,*Label="Type",*Options=1
                   XMLConfirm.CreateElement giving result using *Position=2,*Label="Code",*text="01"
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="Description",*text="Insurance"
                   XMLConfirm.CreateElement giving result using *Position=5,*Label="CurrencyCode",*text="USD"
                   XMLConfirm.CreateElement giving result using *Position=5,*Label="MonetaryValue",*text="1500"


                   XMLConfirm.SaveXML     using *FileName="\apc\source\ShipConfirmTest.xml",*Options=7
                   XMLConfirm.StoreXML    giving ConfirmStream
                   return
;==========================================================================================================
CreateHttpShipAccept
                   XMLAccept.Reset

                   XMLAccept.CreateElement giving result using *Position=2,*Label="ShipmentAcceptRequest",*Options=1
                   XMLAccept.GetPosition giving ShipmentPosition

                   XMLAccept.CreateElement giving result using *Position=2,*Label="Request",*Options=1

                   XMLAccept.GetPosition giving RequestPosition
                   XMLAccept.CreateElement giving result using *Position=2,*Label="TransactionReference",*Options=1
                   XMLAccept.CreateElement giving result using *Position=2,*Label="CustomerContext",*Text="Your Test Case Summary Description"
.
                   XMLAccept.CreateElement giving result using *Position=5,*Label="RequestOption",*Text="1"
                   XMLAccept.CreateElement giving result using *Position=5,*Label="RequestAction",*Text="ShipAccept"

                   XMLAccept.MoveToNode    giving result using *Position=ShipmentPosition

                   XMLAccept.CreateElement giving result using *Position=3,*Label="ShipmentDigest",*Text=ShippingDigest
                   XMLAccept.SaveXML     using *FileName="\apc\source\ShipAcceptTest.xml",*Options=7
                   XMLAccept.StoreXML    giving AcceptStream
                   return
;==========================================================================================================
PrintCustomHeader
                   return
;==========================================================================================================
GetFields
.                   getprop           EUPSName,text=UPSRecord.ShipToName
.                   getprop           EUPSAddress1,text=UPSRecord.ShipToAddress1
.                   getprop           EUPSAddress2,text=UPSRecord.ShipToAddress2
.                   getprop           EUPSAddress3,text=UPSRecord.ShipToAddress3
.                   getprop           EUPSCity,text=UPSRecord.ShipToCity
.                   getprop           EUPSState,text=UPSRecord.ShipToState
.                   getprop           EUPSCountry,text=UPSRecord.ShipToCountry
.                   getprop           NUPSWeight,value=UPSRecord.Weight
.                   getprop           NUPSCartons,value=UPSRecord.Cartons





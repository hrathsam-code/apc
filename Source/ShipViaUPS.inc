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
;   COD is on page 75    Look at CODFundsCode
;
.                   include           WorkVar.inc
.                   include           Sequence.fd
.                   include           Cust.FD
.                   include           PrintRtn.inc
.                   include           CNTRY.fd


SchemaData         dim               20000

RequestPosition    form              9
PaymentFlag        form              2
InsuranceFlag      form              1

UPSRecord          record
ShipToName         dim               30
ShipToAddress1     dim               30
ShipToAddress2     dim               30
ShipToAddress3     dim               30
ShipToCity         dim               30
ShipToState        dim               2
ShipToZip          dim               10
ShipToCountry      dim               2
ShipVia            dim               25
Weight             dim               7
Cartons            dim               3
InvoiceAmount      dim               10
ShipToAcctNo       dim               6
Telephone          dim               10
                   recordend

ShipViaUPSF        plform            ShipViaUPS

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

HttpPostMessage         dim                10000

HttpOutputXML        XDATA

TraceFileName       init               "\apc\source\ShipAPC.txt"
OutputFileName      init               "\apc\UPSShipConfirmResponse.xml"

AccessKey           init               "1D6901A8E67FA1D5"
UPSUserName            init               "HarryStar56"
Password            init               "Taylor1156!"

OutputResults       dim                20000
OutputResults2      dim                20000
ErrorResults        dim                20000
GraphicImage       dim               30000
GraphicImage2      dim               30000

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

ShipViaUPS

//1460403
                   debug
                   call              OpenCntry
                   formload          ShipViaUPSF
                   call              SetFields
                   setprop           WUPS,visible=1

                   return
;==========================================================================================================
OnClickCancelShipTo
                   setprop           WUPS,visible=0
                   return
;==========================================================================================================
OnClickCreateUPS
                   IFChecked         CKInsurance
                     set               InsuranceFlag
                   else
                     clear             InsuranceFlag
                   EndIfChecked

                   CBUPSBillType.GetCurSel giving PaymentFlag

                   if                (PaymentFlag = -1)
                     alert             note,"A Bill To type must be entered",result,"ERROR: SELECT BILL TYPE"
                     setfocus          CBUPSBillType
                     return
                   endif

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
                   decode64          GraphicImage,GraphicImage2

OutputImageName    dim               100
                   chop              TrackingNumber,TrackingNumber
                   pack              OutputImageName from "\apc\data\label",TrackingNumber,".EPL"
                   prep              OutputFile,OutputImageName,exclusive
                   write             OutputFile,seq;*ABSON,*LL,GraphicImage2
                   close             OutputFile

                   HttpOutputXML.FindNode giving result9 using *Filter="ParentLabel='HTMLImage'",*Position=PackagePosition
                   HttpOutputXML.GetText giving GraphicImage
                   decode64          GraphicImage,GraphicImage2
                   prep              OutputFile,"\APC\Data\harryHTML.html",exclusive
                   write             OutputFile,seq;*ABSON,GraphicImage2
                   close             OutputFile                                           1039

                   HttpOutputXML.MoveToNode    giving result using *Position=ShipmentPosition
                   HttpOutputXML.FindNode giving result9 using *Filter="Label='ControlLogReceipt'",*Position=6    //Parent Node
                   HttpOutputXML.FindNode giving result9 using *Filter="ParentLabel='GraphicImage'",*Position=0

                   HttpOutputXML.GetText giving GraphicImage
                   decode64          GraphicImage,GraphicImage2
                   pack              OutputImageName from "\apc\data\label",TrackingNumber,".html"
                   prep              OutputFile,OutputImageName,exclusive
                   write             OutputFile,seq;*ABSON,*LL,GraphicImage2
                   close             OutputFile

.                                                                                    similar name, different address
Pic1               picture                                                          Austin HW
Image              dim               100
pictchar           init              4,3

                   splopen           P,"","R"
                   print             P;*LL,GraphicImage2

                   splclose
                   setprop           WUPS,visible=0
                   return
;==========================================================================================================
CreateHttpLogin

                   XMLDataLogin.Reset
                   XMLDataLogin.Reset
                   XMLDataLogin.CreateElement giving result using *Position=2,*Label="AccessRequest",*Options=1

                   XMLDataLogin.CreateElement giving result using *Position=3,*Label="AccessLicenseNumber",*Text=AccessKey
                   XMLDataLogin.CreateElement giving result using *Position=3,*Label="UserId",*Text=UPSUserName
                   XMLDataLogin.CreateElement giving result using *Position=3,*Label="Password",*Text=Password
                   XMLDataLogin.StoreXML    giving LoginStream
                   return
;==========================================================================================================
CreateHttpShipConfirm
                   XMLConfirm.Reset
                   XMLConfirm.CreateElement giving result using *Position=2,*Label="ShipmentConfirmRequest",*Options=1
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

                   XMLConfirm.CreateElement giving result using *Position=2,*Label="LabelPrintMethod",*Options=1
                   XMLConfirm.CreateElement giving result using *Position=2,*Label="Code",*text="EPL"    //STARPL"            //GIF
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="Description",*text="ZPL"

                   XMLConfirm.MoveToNode    giving result using *Position=LabelPosition

                   XMLConfirm.CreateElement giving result using *Position=2,*Label="LabelStockSize",*Options=1

                   XMLConfirm.CreateElement giving result using *Position=2,*Label="Height",*text="4"   //LabelHeight    //STARPL"            //GIF
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="Width",*text="6"   //LabelWidth




..HR 2020.05.19                   XMLConfirm.CreateElement giving result using *Position=2,*Label="LabelStockSize",*Options=1
..HR 2020.05.19
..HR 2020.05.19                   XMLConfirm.CreateElement giving result using *Position=2,*Label="LabelPrintMethod",*Options=1
..HR 2020.05.19                   XMLConfirm.CreateElement giving result using *Position=2,*Label="Height",*text="6"    //STARPL"            //GIF
..HR 2020.05.19                   XMLConfirm.CreateElement giving result using *Position=3,*Label="Width",*text="4"

..HR 2020.05.19                   XMLConfirm.MoveToNode    giving result using *Position=LabelPosition

..HR 2020.05.19                   XMLConfirm.CreateElement giving result using *Position=2,*Label="Code",*text="STAR"    //STARPL"            //GIF   //ZPL
..HR 2020.05.19                   XMLConfirm.CreateElement giving result using *Position=3,*Label="Description",*text="ZPL"                  //gif file
..HR 2020.05.19
..HR 2020.05.19                   XMLConfirm.CreateElement giving result using *Position=5,*Label="HTTPUserAgent",*text="Mozilla/5.0",*Options=1

..HR 20200519                   XMLConfirm.CreateElement giving result using *Position=5,*Label="LabelImageFormat",*Options=1
..HR 20200519                   XMLConfirm.CreateElement giving result using *Position=2,*Label="Code",*text="GIF"
..HR 20200519                   XMLConfirm.CreateElement giving result using *Position=3,*Label="Description",*text="gif"
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
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="ShipperNumber",*Text=" 156620"    //936095"
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="TaxIdentificationNumber",*Text="1234567890"

                   XMLConfirm.CreateElement giving result using *Position=3,*Label="Address",*Options=1
                   XMLConfirm.CreateElement giving result using *Position=2,*Label="AddressLine1",*text=Cust.Addr1
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="City",*text=Cust.City
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="StateProvinceCode",*text=Cust.St
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="PostalCode",*text=Cust.Zip
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="PostcodeExtendedLow",*text="H"
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="CountryCode",*text="US"

                   XMLConfirm.MoveToNode    giving result using *Position=ShipperPosition

                   move              "1500 LAKEVIEW LOOP",Cust.Addr1
                   move              "ANAHEIM",Cust.City
                   move              "CA",Cust.St
                   move              "US",Cust.Country
                   move              "92807-1819",Cust.Zip
                   move              "7146932901",Cust.telephone
                   move              "936095",Cust.ShippingAcct(1)

                   XMLConfirm.CreateElement giving result using *Position=5,*Label="ShipTo",*Options=1
                   XMLConfirm.CreateElement giving result using *Position=2,*Label="CompanyName",*text=UPSRecord.ShipToName   //"BISCO IND."
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="AttentionName",*text="Eileen"
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="PhoneNumber",*text=UPSRecord.Telephone   //Cust.telePhone


.UPSRecord          record
.ShipToAddress1     dim               30
.ShipToAddress2     dim               30
.ShipToAddress3     dim               30
.ShipVia            dim               25
.Weight             form              3.2
.Cartons            form              2
.InvoiceAmount      form              7.2
.ShipToAcctNo       dim               6
.                   recordend


                   XMLConfirm.CreateElement giving result using *Position=3,*Label="Address",*Options=1
                   XMLConfirm.CreateElement giving result using *Position=2,*Label="AddressLine1",*text=UPSRecord.ShipToAddress1
                   XMLConfirm.CreateElement giving result using *Position=2,*Label="AddressLine2",*text=UPSRecord.ShipToAddress2
                   XMLConfirm.CreateElement giving result using *Position=2,*Label="AddressLine3",*text=UPSRecord.ShipToAddress3
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="City",*text=UPSRecord.ShiptoCity
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="StateProvinceCode",*text=UPSRecord.ShipToState
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="PostalCode",*text=UPSRecord.ShipToZip
                   XMLConfirm.CreateElement giving result using *Position=3,*Label="CountryCode",*text=UPSRecord.ShipToCountry

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
                   case              0                            //Prepaid
                     XMLConfirm.CreateElement giving result using *Position=2,*Label="Prepaid",*Options=1
                     XMLConfirm.CreateElement giving result using *Position=2,*Label="BillShipper",*Options=1
                     XMLConfirm.CreateElement giving result using *Position=2,*Label="AccountNumber",*text="156620"      //156620
                   case              1                            //Freight Collect
                     chop            Cust.ShippingAcct(2),Cust.ShippingAcct(2)
                     XMLConfirm.CreateElement giving result using *Position=2,*Label="FreightCollect",*Options=1
                     XMLConfirm.CreateElement giving result using *Position=2,*Label="BillReceiver",*Options=1
                     XMLConfirm.CreateElement giving result using *Position=2,*Label="AccountNumber",*text=UPSRecord.ShipToAcctNo  //"936095"
                     XMLConfirm.CreateElement giving result using *Position=3,*Label="Address",*Options=1
                     XMLConfirm.CreateElement giving result using *Position=3,*Label="PostalCode",*text=UPSRecord.ShipToZip    //Cust.Zip
                   case              2                            //Paid by 3rd Party
                     XMLConfirm.CreateElement giving result using *Position=2,*Label="BillThirdParty",*Options=1
                     XMLConfirm.CreateElement giving result using *Position=2,*Label="BillThirdPartyShipper",*Options=1
                     XMLConfirm.CreateElement giving result using *Position=2,*Label="AccountNumber",*text="156620"
                     XMLConfirm.CreateElement giving result using *Position=2,*Label="ThirdParty",*Options=1
                     XMLConfirm.CreateElement giving result using *Position=3,*Label="Address",*Options=1
                     XMLConfirm.CreateElement giving result using *Position=3,*Label="PostalCode",*text=UPSRecord.ShipToZip
                     XMLConfirm.CreateElement giving result using *Position=3,*Label="CountryCode",*text="US"
;                   case              3                            //Cosignee Billed
                     XMLConfirm.CreateElement giving result using *Position=2,*Label="ConsigneeBilled",*Options=1
                     XMLConfirm.CreateElement giving result using *Position=2,*Label="BillReceiver",*Options=1
                     XMLConfirm.CreateElement giving result using *Position=2,*Label="AccountNumber",*text="156620"
                     XMLConfirm.CreateElement giving result using *Position=3,*Label="Address",*Options=1
                     XMLConfirm.CreateElement giving result using *Position=3,*Label="PostalCode",*text=Cust.Zip
                     XMLConfirm.CreateElement giving result using *Position=3,*Label="CountryCode",*text="US"
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
                   XMLConfirm.CreateElement giving result using *Position=2,*Label="Weight",*text=UPSRecord.Weight

                   XMLConfirm.MoveToNode    giving result using *Position=PackagePosition

                   XMLConfirm.CreateElement giving result using *Position=3,*Label="AdditionalHandling",*text="0"

                   XMLConfirm.MoveToNode    giving result using *Position=PackagePosition

                   debug

                   if                (InsuranceFlag = 1)
                     XMLConfirm.CreateElement giving result using *Position=2,*Label="PackageServiceOptions",*Options=1
                     XMLConfirm.CreateElement giving result using *Position=2,*Label="InsuredValue",*Options=1
                     XMLConfirm.CreateElement giving result using *Position=2,*Label="Type",*Options=1
                     XMLConfirm.CreateElement giving result using *Position=2,*Label="Code",*text="01"
                     XMLConfirm.CreateElement giving result using *Position=3,*Label="Description",*text="Insurance"
                     XMLConfirm.CreateElement giving result using *Position=5,*Label="CurrencyCode",*text="USD"
                     XMLConfirm.CreateElement giving result using *Position=5,*Label="MonetaryValue",*text=UPSRecord.InvoiceAmount
                   endif

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

                   XMLAccept.CreateElement giving result using *Position=5,*Label="RequestOption",*Text="1"
                   XMLAccept.CreateElement giving result using *Position=5,*Label="RequestAction",*Text="ShipAccept"

                   XMLAccept.MoveToNode    giving result using *Position=ShipmentPosition

                   XMLAccept.CreateElement giving result using *Position=3,*Label="ShipmentDigest",*Text=ShippingDigest
                   XMLAccept.SaveXML     using *FileName="\apc\source\ShipAcceptTest.xml",*Options=7
                   XMLAccept.StoreXML    giving AcceptStream
                   return
;==========================================================================================================
GetFields
                   getprop           EUPSName,text=UPSRecord.ShipToName
                   getprop           EUPSAddress1,text=UPSRecord.ShipToAddress1
                   getprop           EUPSAddress2,text=UPSRecord.ShipToAddress2
                   getprop           EUPSAddress3,text=UPSRecord.ShipToAddress3
                   getprop           EUPSCity,text=UPSRecord.ShipToCity
                   getprop           EUPSState,text=UPSRecord.ShipToState
                   getprop           EUPSCountry,text=UPSRecord.ShipToCountry
                   getprop           NUPSWeight,text=UPSRecord.Weight
                   getprop           NUPSCartons,text=UPSRecord.Cartons
                   return
;==========================================================================================================
SetFields
                   setprop           EUPSName,text=UPSRecord.ShipToName
                   setprop           EUPSAddress1,text=UPSRecord.ShipToAddress1
                   setprop           EUPSAddress2,text=UPSRecord.ShipToAddress2
                   setprop           EUPSAddress3,text=UPSRecord.ShipToAddress3
                   setprop           EUPSCity,text=UPSRecord.ShipToCity
                   setprop           EUPSState,text=UPSRecord.ShipToState
                   setprop           EUPSCountry,text=UPSRecord.ShipToCountry
                   setprop           NUPSWeight,text=UPSRecord.Weight
                   setprop           NUPSCartons,text=UPSRecord.Cartons
                   setprop           UUPSShipVia,text=UPSRecord.ShipVia
                   setprop           NDeclaredValue,text=UPSRecord.InvoiceAmount
                   squeeze           UPSRecord.ShipToAcctNo,UPSRecord.ShipToAcctNo
                   if                (UPSRecord.ShipToAcctNo != "")
                   setprop           EUPSAcctNo,text=UPSRecord.ShipToAcctNo
                     CBUPSBillType.SetCurSel using 1
                   else
                     CBUPSBillType.SetCurSel using 0
                   endif
                   return

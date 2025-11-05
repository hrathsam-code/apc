;=============================================================================;
;       created by:  chiron software & services, inc.                         ;
;                    4 norfolk lane                                           ;
;                    bethpage, ny  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  program:    scandocument                                                   ;
;                                                                             ;
;   author:    harry rathsam                                                  ;
;                                                                             ;
;     date:    05/10/2019 at 1:36pm                                             ;
;                                                                             ;
;  purpose:                                                                   ;
;                                                                             ;
; revision:    ver     date     init       details                            ;
;                                                                             ;
;              1.0   05/10/2019   hor     initial version                     ;
;                                                                             ;
;                                                                             ;
;=============================================================================;

                    include            WorkVar.inc

InputFileName       init                "c:\harry\Harry2.jpg"

OCRObject           automation
LoadImgX_SimpleOCR  integer            4
SetLanguageX_SimpleOCR automation
SetOutputModeX_SimpleOCR integer       4
ObjectID1           integer            4




                    create             OCRObject,Class="SimpleOCX.SimpleOCR"
                    OCRObject.OCRSetOutputHandlerX GIVING ObjectID1 USING *handler=0



                    OCRObject.LoadImgX  GIVING LoadImgX_SimpleOCR USING *FileName=InputFileName

                    OCRObject.SetLanguageX GIVING SetOutputModeX_SimpleOCR USING *language=1,*dictDir="C:\chiron\"                                    //giving SetLanguageX_SimpleOCR
                    OCRObject.SetOutputModeX USING *mode=0


                    stop
ERROR1
                    getinfo            EXCEPTION,dataline

.                                                                     *dictDir=dictDir_SimpleOCR

.
.
.Sub DoOCR (filename as String)
.Basic function to perform OCR on a multi-page TIFF image file.
.Dim objOCR as SimpleOCR 'SimpleOCR object
.Dim ret, img, imgSet, i as Long 'Function return value, single image pointer, multiple image pointer, page counter
.Dim strOCRResult as String 'String variable to hold OCR result
.
.Set objOCR = New SimpleOCR
.
.ret = objOCR.OCRSetOutputHandlerX(AddressOf myOutputHandler)
.if isnull(ret) then
.'Error occurred.
.end if

.imgSet = objOCR.LoadMultipleImgX(filename)
.if isnull(imgSet) then
.'Error occurred
.end if

.objOCR.SetLanguageX(ENGLISH,".") 'Set language to English
.objOCR.SetOutputModeX(OM_TEXT) 'Set output mode to Text
.
.For i = 1 to objOCR.GetNBImagesX(imgSet)
.img = objOCR.GetImage(imgSet,i) 'Get the current page
.ret = objOCR.OCRX(img,0) 'Perform OCR on page
.if ret > 0 then
.'Error occurred
.end if
.Next
.
.MsgBox strOCRResult
.
.objOCR.FreeMultipleImgX img
.End Sub
.
.Sub myoutputhandler(ByVal infotype As Integer, ByVal param As Integer)
.'This simple output handler sets the strOCRResult string to the OCR result.
.'Return Value
.'None
.
.'Parameters
.'infotype - Contant indicating type of information contained in param.
.'param - data from OCR engine. See SetOCROutputHandler declaration for details.
.
.'Comments
.'Output handler must be declared in BAS modules and not form code
.'since the AddressOf method requires it for passing as a pointer
.
.On Error Resume Next 'required to avoid propagating DLL errors to VB
.
.Select Case infotype
.Case OT_TEXT
.strOCRResult = strOCRResult + CStr(Chr(param))
.Case OT_ENDL
.strOCRResult = strOCRResult + "\\n"
.End Select
.End Sub

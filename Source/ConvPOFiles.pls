;=============================================================================;
;       created by:  chiron software & services, inc.                         ;
;                    4 norfolk lane                                           ;
;                    bethpage, ny  11714                                      ;
;                    (516) 935-0196                                           ;
;=============================================================================;
;                                                                             ;
;  program:    convpofiles                                                    ;
;                                                                             ;
;   author:    harry rathsam                                                  ;
;                                                                             ;
;     date:    11/22/2019 at 11:33am                                          ;
;                                                                             ;
;  purpose:                                                                   ;
;                                                                             ;
; revision:    ver     date     init       details                            ;
;                                                                             ;
;              1.0   11/22/2019   hor     initial version                     ;
;                                                                             ;
;                                                                             ;
;=============================================================================;

                   include           WorkVar.inc

                    INCLUDE   CUSTMAST.TXT

ADDKEY              FORM                8
NEXTPO              DIM                 8
APP                 INIT                "APP     "
DIM8                DIM                 8
PONAME              dim                 20

POUser             dim               9
NewPOFLST          filelist
NewPOFile          ifile             name="NewPO.isi",NODUP
                   filelistend

InputFile          file

                   trap              NoFile if io
                   open              NewPOFLST,Exclusive

                   open              InputFile,POName,READ

                   loop
                     keyin             "Enter PO Name : ",*+,POUser
                   until             esc
                     open              InputFile,POName,READ
                     keyin             "Enter User Name : ",POUser
                     loop
                       read              InputFile,seq;Dim8,NEXTPO,CUSTNAME
                     until (over)
                       write             NewPOFLST;POUser,Dim8,NextPO,CustName
                     repeat
                   repeat
                   stop

NoFile
                   trapclr           io
                   PREPARE           NewPOFile,"NewPOFiletxt","NewPOFile.isi","-n,z,y,1-9,10-17","100",EXCLUSIVE
                   open              NewPOFLST,Exclusive
                   return

.................................................................
. CUSTRDKS/TEXT:W - MODULE TO READ CUSTOMER FILE KEY SEQUENTIALLY
.................................................................
. 
READCUST  TRAPCLR   IO
. 
         READKS   CUSTFILE;CUSTKEY,CUSTSTTS,CUSTNAME,CUSTADDR:
                                    CUSTCITY,CUSTSTAT,CUSTZIP,CUSTCRED:
                                                              CUSTCATG:
                                    LSTSALDT,LSTPAYDT,LSTSALPR,LSTPAYPR:
                                    COMMCODE:
                                    CURNTDUE,PD01TO30,PD31TO60,PD61TO90:
                                    PDOVR90,MTDCASH,MTDCRED
.
. 
. ..........................................

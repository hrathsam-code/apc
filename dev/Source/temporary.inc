.           MOVE              "CHIRON",APCTLKY
.           CALL              RDAPCTL
.           MOVE              APCTLREC.Code,$Entity
.
.           MOVE              "CHIRON",CmpnyKY
.           CALL              RDCMPNY
           MOVE              "APC Components Inc.",$CompanyName
.           RESET             $CompanyName
.           MOVE              "MMMMMMMMMMXXXXXXXXXXMMMMMMMMMMXXXXXXXXXX",$CompanyName
.           MOVE              "Chiron Software & Services, Inc.",$CompanyName

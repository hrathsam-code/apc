CMPLR=
OPTIONS=-ZG,ZT,S,ZH,E,X,P "IDE"
.SUFFIXES: .PLC .DBS .INC .PLF .PLS .PWF                                                                            


OBJS=	XDATAJSON.PLC 

.DBS.PLC:
	$(CMPLR) "$<","$@" $(OPTIONS)

.PLS.PLC:
	$(CMPLR) "$<","$@" $(OPTIONS)

XDataJson_Example:	$(OBJS)

XDATAJSON.PLC:	XDATAJSON.PLS\
		C:\SUNBELT\PLBWIN.100A\CODE\PLBMETH.INC \
		XDATAJSONF.PLF 

clean:
	del *.plc
	del *.sdb
	del *.lst

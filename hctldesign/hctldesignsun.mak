CMPLR=
OPTIONS=-ZG,ZT,S,ZH,E,X,P "IDE"
.SUFFIXES: .PLC .DBS .INC .PLF .PLS .PWF                                                                            


OBJS=	HCTLDESIGNSUN.PLC 

.DBS.PLC:
	$(CMPLR) "$<","$@" $(OPTIONS)

.PLS.PLC:
	$(CMPLR) "$<","$@" $(OPTIONS)

HctlDesignSun:	$(OBJS)

HCTLDESIGNSUN.PLC:	HCTLDESIGNSUN.PLS\
		C:\SUNBELT\PLBWIN.100A\CODE\PLBEQU.INC \
		C:\SUNBELT\PLBWIN.100A\CODE\PLBMETH.INC \
		HCTLDESIGNSUN1.PWF \
		HCTLDESIGNSUN2.PWF 

clean:
	del *.plc
	del *.sdb
	del *.lst

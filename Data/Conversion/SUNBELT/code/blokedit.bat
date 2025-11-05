@ECHO OFF
rem --------------------------------------------------------------
rem If PLB_BGFG is set, then save it prior to changing it
rem
if not N%PLB_BGFG% == N set SAV_BGFG=%PLB_BGFG%
set PLB_BGFG=07
rem --------------------------------------------------------------
plbcon blokedit.plc %1 %2 %3 %4 %5 %6 %7 %8 %9
rem --------------------------------------------------------------
rem Now reset the environment back to what it was at the beginning
rem
set PLB_BGFG=
if not N%SAV_BGFG% == N set PLB_BGFG=%SAV_BGFG%
if not N%SAV_BGFG% == N set SAV_BGFG=

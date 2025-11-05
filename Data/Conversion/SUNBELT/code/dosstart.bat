@echo off
IF N%PLB_PATHSAVE% == N set PLB_PATHSAVE=%PATH%
set PLB_TERM=ansi
set PLB_SYSTEM=f:\SUNBELT\code
set PLB_PATH=F:\SUNBELT\code;F:\SUNBELT\\demo
set PATH=%PLB_PATHSAVE%;%PLB_SYSTEM%
%comspec%

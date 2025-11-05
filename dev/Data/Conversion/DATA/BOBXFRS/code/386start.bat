@echo off
IF N%PLB_PATHSAVE% == N set PLB_PATHSAVE=%PATH%
set DOS4G=quiet
set PLB_TERM=ansi
set PLB_SYSTEM=C:\Sunbelt\\code
set PLB_PATH=C:\Sunbelt\\code;C:\Sunbelt\\demo
set PATH=%PLB_PATHSAVE%;%PLB_SYSTEM%
%comspec%

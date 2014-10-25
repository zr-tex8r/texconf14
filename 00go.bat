@echo off
setlocal
pushd .
cd %~dp0
set SRC=yato-texconf14
set PACK=C:\tmp\2nd\texconf14.7z

:start
if exist %SRC%.pdf del %SRC%.pdf
if exist %SRC%.pdf goto error
xelatex -no-pdf -halt-on-error %SRC% || goto error
xelatex %SRC% || goto error

:archive
if exist %PACK% del %PACK%
7z a %PACK%

:success
echo Build succeeded.
for %%x in ( aux log ) do (
  if exist %SRC%.%%x del %SRC%.%%x
)
goto clean

:error
echo Build failed.
goto clean

:clean
for %%x in ( nav out snm toc vrb xdv) do (
  if exist %SRC%.%%x del %SRC%.%%x
)
popd
:exit

@echo off

cd /d "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build"
call vcvarsall.bat amd64
call "C:\Users\Ad_maiorem\scoop\shims\nu.exe"

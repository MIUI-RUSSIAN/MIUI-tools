@echo off
Set /P ver= Version a compiler : 
Set home=%CD%
set workdir=%home%\workdir
set base=%home%\Base_ROM
set out=%home%\Output_ROM
set tools=%home%\Tools
set apktools=%tools%\apktool
set sign=%tools%\sign
set common=%tools%\Common
set zip=%tools%\7zip
set mod=I9505
set PATH=%tools%\apktool;%PATH%


:menu
cls
cd %home%
@echo **********************MENU**********************
@echo *1. Decompiler                                 *
@echo *2. Copier la trad FR                          *
@echo *3. Compiler                                   *
@echo *4. Finaliser les fichiers                     *
@echo *5. Creer Update.zip                           *
@echo *6. Suppimer les fichier temporaire            *
@echo *7. Quitter                                    *
@echo ************************************************
Set /P choix= Que voulez-vous faire?  
if "%choix%"=="1" GOTO Decompile
if "%choix%"=="2" GOTO Copy
if "%choix%"=="3" GOTO Compile
if "%choix%"=="4" GOTO Final
if "%choix%"=="5" GOTO menu2
if "%choix%"=="6" GOTO Clean
if "%choix%"=="7" GOTO Finish 
if "%choix%"=="" GOTO menu
if not "%choix%"=="89" GOTO menu


:Decompile
cls
rmdir /S /Q %workdir%\Decompile\%ver%
del %home%\etat_decompil.txt
type nul >%home%\etat_decompil.txt
cmd /c %apktools%\apktool if %workdir%\origin\%ver%\framework-res.apk
cmd /c %apktools%\apktool if %workdir%\origin\%ver%\framework-miui-res.apk
cmd /c %apktools%\apktool if %workdir%\origin\%ver%\twframework-res.apk
FOR /r %workdir%\origin\%ver%\ %%i IN (*.apk) DO ( 
echo.
echo.
echo ######  %%~ni  ######
echo ######  %%~ni  ###### >>%home%\etat_decompil.txt
cmd /c %apktools%\apktool d %%i %workdir%/decompile/%ver%/%%~ni >%home%\erreur_decompil.txt 2>&1
find /I "androlib" %home%\erreur_decompil.txt >nul
if not errorlevel 1 ( 
cmd /c %tools%\Notepad2\notepad2 %home%\erreur_decompil.txt
echo -- erreur sur la decompilation --
pause)
for /f "tokens=* delims=:" %%i in ('findstr .* %home%\erreur_decompil.txt') do echo %%i >> %home%\etat_decompil.txt )
FOR /r %workdir%\origin\ %%i IN (*.jar) DO (
echo ## %%~ni ##
echo ## %%~ni ## >>%home%\etat_decompil.txt
cmd /c %tools%\apktool\apktool d %%i %workdir%\decoded\%%~nxi >%home%\erreur_decompil.txt 2>&1
find /I "androlib" %home%\erreur_decompil.txt >nul
if not errorlevel 1 ( 
cmd /c %tools%\Notepad2\notepad2 %home%\erreur_decompil.txt
echo -- erreur sur la decompilation --
pause)
for /f "tokens=* delims=:" %%i in ('findstr .* %home%\erreur_decompil.txt') do echo %%i >> %home%\etat_decompil.txt )
pause
GOTO menu


:Compile
cls
rmdir /S /Q %workdir%\out\%ver%
del %home%\etat_compil.txt
type nul >%home%\etat_compil.txt
FOR /r %workdir%\origin\%ver%\ %%i IN (*.apk) DO (
echo.
echo ## %%~ni ##
echo ## %%~ni ## >>%home%\etat_compil.txt
cmd /c apktool b %workdir%\decompile\%ver%\%%~ni %workdir%\out\%ver%\%%~nxi >%home%\erreur_compil.txt 2>&1
find /I "androlib" %home%\erreur_compil.txt >nul
if not errorlevel 1 pause 
for /f "tokens=* delims=:" %%i in ('findstr .* %home%\erreur_compil.txt') do echo %%i >> %home%\etat_compil.txt
 )

pause
GOTO menu


:Copy
cls
FOR /r %workdir%\origin\%ver%\ %%i IN (*.apk) DO (
xcopy  /SY ..\Fr\%%~ni.apk %workdir%\Decompile\%ver%\%%~ni)
pause
GOTO menu


:Final
cls
rmdir /S /Q %workdir%\final\%ver%
rmdir /S /Q %workdir%\temp\%ver%
mkdir %workdir%\Temp\%ver%
mkdir %workdir%\Final\%ver%
FOR /r %workdir%\Out\%ver%\ %%i IN (*.apk) DO (
echo.
echo.
echo ######  %%~nxi  ######
mkdir %workdir%\temp\%ver%\%%~ni
cd %workdir%\temp\%ver%\%%~ni
cmd /c "%zip%\7z.exe x %%i"
cd %tools%
copy listfile.txt %workdir%\temp\%ver%\%%~ni\listfile.txt
copy  %workdir%\origin\%ver%\%%~nxi %workdir%\final\%ver%\%%~ni.zip
cd %workdir%\temp\%ver%\%%~ni\
cmd /c "%zip%\7z.exe u  %workdir%\final\%ver%\%%~ni.zip @listfile.txt"
ren %workdir%\final\%ver%\%%~ni.zip %%~nxi 
cd %home%)
pause
rmdir /S /Q %workdir%\temp
GOTO menu


:Clean
cls
rmdir /S /Q %workdir%\decompile
rmdir /S /Q %workdir%\out
rmdir /S /Q %workdir%\temp
rmdir /S /Q %workdir%\final
pause
GOTO menu


:menu2
cd %workdir%
cls
@echo ******************MENU %mod%********************
@echo *1. Creer zip                                  *
@echo *2. Suppimer les fichier temporaire            *
@echo *3. Retour choix modele   	             *
@echo *4. Retour Precedent menu                      *
@echo *5. Quitter 		                     *
@echo ************************************************
Set /P choix2= Que voulez-vous faire?  
if "%choix2%"=="1" GOTO aio
if "%choix2%"=="2" GOTO clean2
if "%choix2%"=="3" GOTO model
if "%choix2%"=="4" GOTO menu
if "%choix2%"=="5" GOTO Finish
if "%choix%"=="" GOTO menu2
if not "%choix%"=="7890" GOTO menu2


:AIO
@echo off
cls
rmdir /S /Q %workdir%\Temp
rmdir /S /Q %workdir%\Temp
mkdir Temp\%mod%
cd Temp\%mod%
cmd /c "%zip%\7z.exe x %base%\%mod%\miui-%mod%-%ver%_deodexed-signed.zip"
cd %workdir%\
xcopy  /SQY %workdir%\Temp\%mod%\META-INF\com\android\ %workdir%\AIO\META-INF\com\android\
xcopy  /SQY %workdir%\Temp\%mod%\system\ %workdir%\AIO\system\
xcopy  /SQY %workdir%\Temp\%mod%\data\ %workdir%\AIO\data\
xcopy  /SQY %workdir%\Temp\%mod%\boot.img %workdir%\AIO\
xcopy  /SQY %workdir%\final\%ver%\*.apk %workdir%\AIO\system\app\ 
xcopy  /SQY %workdir%\final\%ver%\framework-res.apk %workdir%\AIO\system\framework\
xcopy  /SQY %workdir%\final\%ver%\framework-miui-res.apk %workdir%\AIO\system\framework\
xcopy  /SQY %workdir%\final\%ver%\twframework-res.apk %workdir%\AIO\system\framework\
xcopy  /SQY %common%\%mod%\build.prop %workdir%\AIO\system\
xcopy  /SQY %common%\META-INF %workdir%\AIO\META-INF\
xcopy  /SQY %common%\%mod%\updater-script %workdir%\AIO\META-INF\com\google\android\
del /Q %workdir%\AIO\system\app\framework-res.apk
del /Q %workdir%\AIO\system\app\Provision.apk
ren %workdir%\AIO\META-INF\com\google\android\updater-script.aio updater-script
cmd /c "%zip%\7z.exe a miui-%mod%-%ver%-French-AIO.zip %workdir%\AIO\*"
@echo ########## Signe Update ##########
java -jar %sign%\signapk.jar -w %sign%\testkey.x509.pem %sign%\testkey.pk8 miui-%mod%-%ver%-French-AIO.zip miui-%mod%-%ver%-French-AIO-signed.zip
del /Q %workdir%\miui-%mod%-%ver%-French-AIO.zip
move %workdir%\miui-%mod%-%ver%-French-AIO-signed.zip %out%\
pause
rmdir /S /Q %workdir%\AIO
rmdir /S /Q %workdir%\Temp
GOTO menu2


:clean2
cls
rmdir /S /Q %workdir%\AIO
rmdir /S /Q %workdir%\Hotfix
rmdir /S /Q %workdir%\Temp
del /Q *.zip
pause
GOTO menu2


:Finish
exit
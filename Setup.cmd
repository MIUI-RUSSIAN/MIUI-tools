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
if "%choix%"=="5" GOTO model
if "%choix%"=="6" GOTO Clean
if "%choix%"=="7" GOTO Finish 
if "%choix%"=="" GOTO menu
if not "%choix%"=="89" GOTO menu


:Decompile
cls
rmdir /S /Q %workdir%\Decompile\%ver%
cmd /c %apktools%\apktool if %workdir%\origin\%ver%\framework-res.apk
FOR /r %workdir%\origin\%ver%\ %%i IN (*.apk) DO (
echo.
echo.
echo ######  %%~ni  ######
cmd /c %apktools%\apktool d %%i %workdir%/decompile/%ver%/%%~ni)
pause
GOTO menu


:Compile
cls
rmdir /S /Q %workdir%\out\%ver%
FOR /r %workdir%\origin\%ver%\ %%i IN (*.apk) DO (
echo.
echo.
echo ######  %%~ni  ######
cmd /c %apktools%\apktool b %workdir%\decompile\%ver%\%%~ni %workdir%/out/%ver%/%%~nxi)
pause
GOTO menu


:Copy
cls
FOR /r %workdir%\origin\%ver%\ %%i IN (*.apk) DO (
xcopy  /SY ..\Fr\%%~ni %workdir%\Decompile\%ver%\%%~ni)
%tools%\smali.vbs %ver% %CD%
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


:model
cls
@echo *********************Model**********************
@echo *1. Nexus One                                  *
@echo *2. Desire                                     *
@echo ************************************************
Set /P mod1= Model : 
if "%mod1%"=="1" ( Set mod=N1
GOTO menu2 )
if "%mod1%"=="2" ( Set mod=bravo
GOTO menu2 )
if "%mod1%"=="" set mod=autre
if not "%mod1%"=="3456789" set mod=autre
if "%mod%"=="autre" GOTO model

:menu2
cd %workdir%
cls
@echo ******************MENU %mod%********************
@echo *1. Patch FR                                   *
@echo *2. AIO FR                                     *
@echo *3. Hotfix                                     *
@echo *4. Suppimer les fichier temporaire            *
@echo *5. Retour choix modele                        *
@echo *6. Retour Precedent menu                      *
@echo *7. Quitter                                    *
@echo ************************************************
Set /P choix2= Que voulez-vous faire?  
if "%choix2%"=="1" GOTO patch
if "%choix2%"=="2" GOTO aio
if "%choix2%"=="3" GOTO hotfix
if "%choix2%"=="4" GOTO clean2
if "%choix2%"=="5" GOTO model
if "%choix2%"=="6" GOTO menu
if "%choix2%"=="7" GOTO Finish 
if "%choix%"=="" GOTO menu2
if not "%choix%"=="89" GOTO menu2


:patch
cls
rmdir /S /Q %workdir%\PatchFr
xcopy  /SQY %workdir%\final\%ver%\*.apk %workdir%\PatchFr\system\app\ 
xcopy  /SQY %workdir%\final\%ver%\framework-res.apk %workdir%\PatchFr\system\framework\ 
xcopy  /SQY %common%\system\*.* %workdir%\PatchFr\system\app\
xcopy  /SQY %common%\%mod%\build.prop %workdir%\PatchFr\system\
xcopy  /SQY %common%\META-INF %workdir%\PatchFr\META-INF\
xcopy  /SQY %common%\%mod%\updater-script.patch %workdir%\PatchFr\META-INF\com\google\android\
del /Q %workdir%\PatchFr\system\app\framework-res.apk
ren %workdir%\PatchFr\META-INF\com\google\android\updater-script.patch updater-script
cmd /c "%zip%\7z.exe a miui-%mod%-%ver%-patch_fr.zip %workdir%\PatchFr\*"
@echo ########## Signe Update ##########
java -jar %sign%\signapk.jar -w %sign%\testkey.x509.pem %sign%\testkey.pk8 miui-%mod%-%ver%-patch_fr.zip miui-%mod%-%ver%-patch_fr-signed.zip
del /Q %workdir%\miui-%mod%-%ver%-patch_fr.zip
move %workdir%\miui-%mod%-%ver%-patch_fr-signed.zip %out%\
pause
rmdir /S /Q %workdir%\PatchFr
GOTO menu2


:AIO
cls
rmdir /S /Q %workdir%\Temp
rmdir /S /Q %workdir%\Temp
mkdir Temp\%mod%
cd Temp\%mod%
cmd /c "%zip%\7z.exe x %base%\%mod%\miui-%mod%-%ver%_deodexed-signed.zip"
cd %workdir%\
xcopy  /SQY %workdir%\Temp\%mod%\system %workdir%\AIO\system\
xcopy  /SQY %workdir%\Temp\%mod%\boot.img %workdir%\AIO\
xcopy  /SQY %workdir%\final\%ver%\*.apk %workdir%\AIO\system\app\ 
xcopy  /SQY %workdir%\final\%ver%\framework-res.apk %workdir%\AIO\system\framework\ 
xcopy  /SQY %common%\system\*.* %workdir%\AIO\system\
xcopy  /SQY %common%\%mod%\build.prop %workdir%\AIO\system\
xcopy  /SQY %common%\META-INF %workdir%\AIO\META-INF\
xcopy  /SQY %common%\%mod%\updater-script.aio %workdir%\AIO\META-INF\com\google\android\
del /Q %workdir%\AIO\system\app\framework-res.apk
del /Q %workdir%\AIO\system\app\AppShare.apk
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


:hotfix
cls
rmdir /S /Q %workdir%\Hotfix
xcopy  /SQY %workdir%\final\%ver%\*.apk %workdir%\Hotfix\system\app\ 
xcopy  /SQY %workdir%\final\%ver%\framework-res.apk %workdir%\Hotfix\system\framework\ 
xcopy  /SQY %common%\system\bin\clear_dalvik.sh %workdir%\Hotfix\system\bin\
xcopy  /SQY %common%\%mod%\build.prop %workdir%\Hotfix\system\
xcopy  /SQY %common%\META-INF %workdir%\Hotfix\META-INF\
xcopy  /SQY %common%\%mod%\updater-script.hotfix %workdir%\Hotfix\META-INF\com\google\android\
del /Q %workdir%\Hotfix\system\app\framework-res.apk
ren %workdir%\Hotfix\META-INF\com\google\android\updater-script.hotfix updater-script
cls
echo %ver%
Set /P Nver= Nouvelle Version : 
cmd /c "%zip%\7z.exe a miui-%mod%-%ver%-to-%Nver%.zip %workdir%\Hotfix\*"
@echo ########## Signe Update ##########
java -jar %sign%\signapk.jar -w %sign%\testkey.x509.pem %sign%\testkey.pk8 miui-%mod%-%ver%-to-%Nver%.zip miui-%mod%-%ver%-to-%Nver%-signed.zip
del /Q %workdir%\miui-%mod%-%ver%-to-%Nver%.zip
move %workdir%\miui-%mod%-%ver%-to-%Nver%-signed.zip %out%\
pause
rmdir /S /Q %workdir%\Hotfix
GOTO menu2


:clean2
cls
rmdir /S /Q %workdir%\AIO
rmdir /S /Q %workdir%\PatchFr
rmdir /S /Q %workdir%\Hotfix
rmdir /S /Q %workdir%\Temp
del /Q *.zip
pause
GOTO menu2


:Finish
exit
@echo off
setlocal

echo Changement de mot de passe de l'archive private.7z

:: Demande de l'ancien mot de passe
set /p "oldpass=Ancien mot de passe: "

:: Verifie si l'ancien mot de passe est correct en essayant de tester l'archive
"%~dp0\7za.exe" t "%~dp0\private.7z" -p%oldpass% >nul 2>&1
if %errorlevel% neq 0 (
    echo Mot de passe incorrect.
    exit /b
)

:: Demande du nouveau mot de passe
set /p "newpass=Nouveau mot de passe: "
set /p "confirmpass=Confirmez le nouveau mot de passe: "

if not "%newpass%"=="%confirmpass%" (
    echo Les mots de passe ne correspondent pas.
    exit /b
)

echo Extraction temporaire des fichiers avec l'ancien mot de passe
"%~dp0\7za.exe" x "%~dp0\private.7z" -p%oldpass% -o"%~dp0\temp_folder"
if %errorlevel% neq 0 (
    echo echec de l'extraction. Verifiez l'ancien mot de passe.
    rmdir /s /q "%~dp0\temp_folder"
    exit /b
)

echo Creation d'une nouvelle archive avec le nouveau mot de passe
"%~dp0\7za.exe" a -t7z -p%newpass% -mhe=on -m0=lzma2 -mx=9 -ms=on "%~dp0\private_temp.7z" "%~dp0\temp_folder\*"
if %errorlevel% neq 0 (
    echo echec de la creation de la nouvelle archive.
    rmdir /s /q "%~dp0\temp_folder"
    exit /b
)

echo Suppression des fichiers extraits, de l'ancienne archive et renommage de la nouvelle archive
rmdir /s /q "%~dp0\temp_folder"
del "%~dp0\private.7z"
rename "%~dp0\private_temp.7z" "private.7z"

echo Le mot de passe a ete change avec succes!

pause
endlocal
exit /b


@echo off
setlocal
set /p "pass=Mot de passe pour l'archive: "
rmdir /s /q "private"
"%~dp0\7zip_win\7za.exe" x "%~dp0\private.7z" -p%pass%
if %errorlevel% == 0 (
    echo Extraction reussie!
    pause
    "%~dp0\7zip_win\7za.exe" a -t7z -p%pass% -mhe=on -m0=lzma2 -mx=9 -ms=on "%~dp0\private.7z" "private"
    if %errorlevel% neq 0 (
        echo echec du chiffrement!
        pause
        exit /b
    )
    rmdir /s /q "private"
) else (
    echo echec de l'extraction!
    pause
)
endlocal
exit /b

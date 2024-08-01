@echo off
setlocal

:: Definir le chemin source et de destination
set "sourcePath=%~dp0\private.7z"
set "destinationPath=C:\Users\%username%\Documents\private.7z"

:: Copier le fichier
copy "%sourcePath%" "%destinationPath%"

if %errorlevel% == 0 (
    echo La sauvegarde a ete realisee avec succes!
) else (
    echo echec de la sauvegarde.
)

endlocal
exit /b

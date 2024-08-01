# Masquer le mot de passe lors de la saisie
$securePass = Read-Host "Mot de passe pour l'archive" -AsSecureString

$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($securePass)
$pass = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)
[System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($BSTR)

# Supprimer le dossier 'private' s'il existe
if (Test-Path "private") {
    Remove-Item -Path "private" -Recurse -Force
}

# Extraction de l'archive
& "$PSScriptRoot\7zip_win\7za.exe" x "$PSScriptRoot\private.7z" -p"$pass"

# Vérifier si la dernière commande a réussi
if ($LASTEXITCODE -eq 0) {
    Write-Host "Extraction reussie!"
    Read-Host "Appuyez sur une touche pour continuer..."

    # Créer l'archive
    & "$PSScriptRoot\7zip_win\7za.exe" a -t7z -p"$pass" -mhe=on -m0=lzma2 -mx=9 -ms=on "$PSScriptRoot\private.7z" "private"

    # Vérifier si la création de l'archive a réussi
    if ($LASTEXITCODE -ne 0) {
        Write-Host "echec du chiffrement!"
        exit
    }

    # Supprimer le dossier 'private' s'il existe après le chiffrement
    if (Test-Path "private") {
        Remove-Item -Path "private" -Recurse -Force
    }
} else {
    Write-Host "echec de l'extraction!"
    Read-Host "Appuyez sur une touche pour continuer..."
}


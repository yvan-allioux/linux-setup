#!/bin/bash
#chmod +x nom_du_script.sh
#sudo apt-get install p7zip-full
#fedora sudo dnf install p7zip p7zip-plugins
#arch sudo pacman -S p7zip
#win choco install 7zip

#!/bin/bash

# Demande le mot de passe pour l'archive
read -s -p "Mot de passe pour l'archive: " pass
echo

# Supprime le dossier "private" s'il existe
rm -rf private

# Extrait "private.7z" en utilisant le mot de passe donne
7z x "$(dirname "$0")/private.7z" -p$pass

# Verifie si l'extraction est reussie
if [ $? -eq 0 ]; then
    echo "Extraction reussie!"
    read -p "Appuyez sur une touche pour continuer..." -n1 -s
    echo

    # Archive a nouveau le dossier "private"
    7z a -t7z -p$pass -mhe=on -m0=lzma2 -mx=9 -ms=on "$(dirname "$0")/private.7z" private

    # Verifie si l'archivage est reussi
    if [ $? -ne 0 ]; then
        echo "echec du chiffrement!"
        read -p "Appuyez sur une touche pour continuer..." -n1 -s
        exit 1
    fi

    # Supprime le dossier "private"
    rm -rf private
else
    echo "echec de l'extraction!"
    read -p "Appuyez sur une touche pour continuer..." -n1 -s
fi


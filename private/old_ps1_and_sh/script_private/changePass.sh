#!/bin/bash

echo "Changement de mot de passe de l'archive private.7z"

# Demande de l'ancien mot de passe
read -s -p "Ancien mot de passe: " oldpass
echo

# Verifie si l'ancien mot de passe est correct en essayant d'extraire l'archive
7z t "$(dirname "$0")/private.7z" -p$oldpass >/dev/null 2>&1

if [ $? -ne 0 ]; then
    echo "Mot de passe incorrect."
    exit 1
fi

# Demande du nouveau mot de passe
read -s -p "Nouveau mot de passe: " newpass
echo
read -s -p "Confirmez le nouveau mot de passe: " confirmpass
echo

if [ "$newpass" != "$confirmpass" ]; then
    echo "Les mots de passe ne correspondent pas."
    exit 1
fi

# Extraction temporaire des fichiers avec l'ancien mot de passe
7z x "$(dirname "$0")/private.7z" -p$oldpass -otemp_folder

if [ $? -ne 0 ]; then
    echo "echec de l'extraction. Verifiez l'ancien mot de passe."
    rm -rf temp_folder
    exit 1
fi

# Creation d'une nouvelle archive avec le nouveau mot de passe
7z a -t7z -p$newpass -mhe=on -m0=lzma2 -mx=9 -ms=on "$(dirname "$0")/private_temp.7z" temp_folder/*

if [ $? -ne 0 ]; then
    echo "echec de la creation de la nouvelle archive."
    rm -rf temp_folder
    exit 1
fi

# Suppression des fichiers extraits, de l'ancienne archive et renommage de la nouvelle archive
rm -rf temp_folder
rm "$(dirname "$0")/private.7z"
mv "$(dirname "$0")/private_temp.7z" "$(dirname "$0")/private.7z"

echo "Le mot de passe a ete change avec succes!"

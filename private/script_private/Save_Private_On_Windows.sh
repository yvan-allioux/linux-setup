#!/bin/bash

# Chemins source et de destination
sourcePath="$(dirname "$0")/private.7z"
destinationPath="$HOME/Documents/private.7z"

# Copier le fichier
cp "$sourcePath" "$destinationPath"

if [ $? -eq 0 ]; then
    echo "La sauvegarde a ete realisee avec succes!"
else
    echo "echec de la sauvegarde."
fi

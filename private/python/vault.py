import os
import shutil
from getpass import getpass
import py7zr

# Masquer le mot de passe lors de la saisie
password = getpass("Mot de passe pour l'archive: ")

# Supprimer le dossier 'vault' s'il existe
if os.path.exists("vault"):
    shutil.rmtree("vault")

# Extraction de l'archive
try:
    with py7zr.SevenZipFile('vault.7z', mode='r', password=password) as archive:
        archive.extractall(path=".")
    print("Extraction réussie!")
    # Copier le fichier vault.7z en vault_old.7z
    if os.path.exists("vault.7z"):
        shutil.copy("vault.7z", "vault_old.7z")
    input("Appuyez sur une touche pour continuer...")

    # Créer l'archive
    with py7zr.SevenZipFile('vault.7z', mode='w', password=password, header_encryption=True) as archive:
        archive.writeall('vault', 'vault')
    print("Chiffrement réussi!")

    # Supprimer le dossier 'vault' s'il existe après le chiffrement
    if os.path.exists("vault"):
        shutil.rmtree("vault")

except Exception as e:
    print(f"Échec de l'opération: {e}")
    input("Appuyez sur une touche pour continuer...")

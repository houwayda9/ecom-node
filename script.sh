#!/bin/bash

set -x  # Activer le mode débogage

current_branch=$(git rev-parse --abbrev-ref HEAD)
echo "Branche actuelle : $current_branch"

# Déterminer l'environnement à partir du nom de la branche
if [[ $current_branch == "dev" ]]; then
  environment="development"
elif [[ $current_branch == "staging" ]]; then
  environment="staging"
elif [[ $current_branch == "prod" ]]; then
  environment="prod"
else
  echo "Branche non prise en charge. Sortie."
  exit 1
fi

echo "Environnement : $environment"

# Convertir le préfixe d'environnement en majuscules
prefix=$(echo "$environment" | tr '[:lower:]' '[:upper:]')_

# Créer le fichier .env et injecter les variables et secrets
# env_file=".env.$environment"

# Parcourir les variables d'environnement et les secrets avec le préfixe spécifié
while IFS= read -r var; do
    clean_var_name=$(echo "$var" | sed "s/^$prefix//")
    value=$(env | grep "^$var=" | sed 's/^[^=]*=//')
    echo "$clean_var_name=$value" >> .env.$environment
done < <(cat .env.$environment | grep "^$prefix" | sed 's/=.*//')

# Afficher le contenu final du fichier .env.$environment
echo "Contenu du fichier $env_file :"
cat .env.$environment

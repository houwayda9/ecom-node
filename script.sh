#!/bin/bash

set -x  # Enable debug mode

current_branch=$(git rev-parse --abbrev-ref HEAD)
echo "Current Branch: $current_branch"

# Determine the environment from the branch name
if [[ $current_branch == "dev" ]]; then
  environment="development"
elif [[ $current_branch == "staging" ]]; then
  environment="staging"
elif [[ $current_branch == "prod" ]]; then
  environment="prod"
else
  echo "Unsupported branch. Exiting."
  exit 1
fi

echo "Environment: $environment"

# Convert environment prefix to uppercase
prefix=$(echo "$environment" | tr '[:lower:]' '[:upper:]')_

# Create .env file and inject variables and secrets
env_file=".env.$environment"
echo "# Environment: $environment" > "$env_file"

# Loop through environment variables and secrets with the specified prefix
for var in $(env | grep "^$prefix" | cut -d= -f1); do
    clean_var_name=$(echo $var | sed "s/$prefix//")
    # If the variable is a secret, access it using GitHub Actions syntax
    if [[ $var =~ ^$prefix ]]; then
        value=$(echo "${{ secrets.${var#"$prefix"} }}")
    else
        value=$(printenv | grep "^$var=" | sed 's/^[^=]*=//')
    fi
    # Append the variable and its value to

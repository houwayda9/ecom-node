#!/bin/bash

echo "Generating environment file..."

# Determine the environment based on the branch name
environment=$(echo "$GITHUB_REF_NAME" | tr '[:lower:]' '[:upper:]')

echo "Environment: $environment"

# Create an environment file
echo "# Environment: $environment" > .env

# List all variables specific to the environment
prefix="${environment}_"
for var in $(env | grep "^$PREFIX" | sed 's/=.*//'); do
    clean_var_name=$(echo $var | sed "s/$PREFIX//")
    echo "$clean_var_name=$(env | grep "^$var=" | sed 's/^[^=]*=//')" >> .env
done

echo "Environment file generated."

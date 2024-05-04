#!/bin/bash

# Extract the branch name from GITHUB_REF
BRANCH=$(echo "$GITHUB_REF" | sed 's|refs/heads/||')
# Convert the branch name to uppercase and append an underscore
PREFIX=$(echo "$BRANCH" | awk '{print toupper($0)}')_

# Create or overwrite the .env file with a header
echo "# Exported environment variables for ${BRANCH}" > .env

# Loop through all environment variables that start with the PREFIX
for var in $(env | grep "^$PREFIX" | sed 's/=.*//'); do
    # Strip the prefix to get the original variable name
    clean_var_name=$(echo "$var" | sed "s/^$PREFIX//")
    # Retrieve the value of the environment variable
    value=$(printenv "$var")
    # Write the key-value pair to the .env file
    echo "${clean_var_name}=${value}" >> .env
done

echo "Environment variables exported to .env"

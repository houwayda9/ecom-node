#!/bin/bash

# Assuming GITHUB_REF is something like refs/heads/feature-branch
branch_name=$(echo "$GITHUB_REF" | awk -F'/' '{print tolower($3)}')
prefix=$(echo "$branch_name" | tr '[:lower:]' '[:upper:]')
env_file=".env_${branch_name}"


# Read environment variables and separate them based on the pattern
printenv | grep -iE "^${prefix}_" | while IFS='=' read -r key value; do
    stripped_key="${key#${prefix}_}"
    # Check if the key matches the secrets pattern
    if [[ "$stripped_key" =~ $secrets_pattern ]]; then
        echo "${stripped_key}=${value}" >> "$env_file"
    else
        echo "${stripped_key}=${value}" >> "$env_file"
    fi
done

# Display the generated files for verification
echo "Generated .env file:"
cat "$env_file"


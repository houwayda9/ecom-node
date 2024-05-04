#!/bin/bash

# Extract branch name from GITHUB_REF and convert to lowercase
if [ -z "$GITHUB_REF" ]; then
    echo "Error: GITHUB_REF is not set. This script should be run in a CI environment."
    exit 1
fi

branch_name=$(echo "$GITHUB_REF" | awk -F'/' '{print tolower($3)}')
prefix=$(echo "$branch_name" | tr '[:lower:]' '[:upper:]')
env_file=".env.${prefix}"

echo "Creating $env_file for branch $branch_name"

# Initialize the .env file with header information
echo "# Environment variables for branch $branch_name (prefix '${prefix}_' removed)" > "$env_file"

# Extract variables prefixed with the branch name and write to the .env file without the prefix
printenv | grep -iE "^${prefix}_" | while IFS='=' read -r key value; do
    stripped_key="${key#${prefix}_}"
    echo "${stripped_key}=${value}" >> "$env_file"
done

# Display the generated .env file for verification
echo "Generated .env file:"
cat "$env_file"

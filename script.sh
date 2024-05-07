#!/bin/bash



branch_name=$(echo "$GITHUB_REF" | awk -F'/' '{print tolower($3)}')
prefix=$(echo "$branch_name" | tr '[:lower:]' '[:upper:]')
env_file=".env"




printenv | grep -iE "^${prefix}_" | while IFS='=' read -r key value; do
    stripped_key="${key#${prefix}_}"
    echo "${stripped_key}=${value}" >> "$env_file"
done

# Display the generated .env file for verification
echo "Generated .env file:"
cat "$env_file"



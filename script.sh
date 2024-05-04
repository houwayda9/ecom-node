#!/bin/bash

# Function to save environment variables to a .env file, stripping a prefix
create_env_file_without_prefix() {
    local prefix=$1
    local branch_name=$2
    local env_file=".env.${branch_name^^}"


    # Initialize the .env file
    echo "# Environment variables for branch $branch_name (prefix '${prefix}_' removed)" > "$env_file"

    # Extract variables with the prefix and remove the prefix
    while IFS='=' read -r key value; do
        stripped_key="${key#${prefix}_}"  # Remove the prefix
        echo "${stripped_key}=${value}" >> "$env_file"
    done < <(printenv | grep -iE "^${prefix}_")

   
    cat "$env_file"
}



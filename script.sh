#!/bin/bash

# Create a header for the list of environment variables
echo "# Listing All Environment Variables"

# Use `printenv` to list all environment variables and loop through each one
while IFS='=' read -r key value; do
    # Optionally filter out any specific variables you don't want to list
    if [[ "$key" != GITHUB_* && "$key" != RUNNER_* ]]; then
        echo "$key=$value"
    fi
done < <(printenv)

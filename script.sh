#!/bin/bash

echo "Generating environment file..."

# Determine the environment based on the branch name
environment=$(echo "$GITHUB_REF_NAME" | tr '[:lower:]' '[:upper:]')

echo "Environment: $environment"

# Create an environment file
echo "# Environment: $environment" > .env

# List all variables specific to the environment
prefix="${environment}_"
for var in $(compgen -e); do
    # Check if the variable starts with the environment prefix
    if [[ "$var" == "${environment}_"* ]]; then
        # Remove the environment prefix
        var_name="${var#${environment}_}"
        # Get the value of the variable
        var_value="${!var}"
        # Write variable to .env file
        echo "$var_name=$var_value" >> .env
    fi
done

echo "Environment file generated."

#!/bin/bash

echo "Generating environment file..."

# Determine the environment based on the branch name
environment=$(echo "$GITHUB_REF_NAME" | tr '[:lower:]' '[:upper:]')

echo "Environment: $environment"

# Create an environment file
echo "# Environment: $environment" > .env

# List all variables specific to the environment
prefix="${environment}_"
for var in $(compgen -e | grep "^$prefix"); do
    # Remove the prefix from the variable name
    var_name="${var#$prefix}"
    # Get the value of the variable
    var_value="${!var}"
    # Write variable to .env file
    echo "$var_name=$var_value" >> .env
done

echo "Environment file generated."

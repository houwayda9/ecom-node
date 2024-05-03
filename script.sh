#!/bin/bash

echo "Generating environment file..."

# Check the branch name to determine the environment
if [ "$GITHUB_REF" == "refs/heads/prod" ]; then
    environment="prod"
elif [ "$GITHUB_REF" == "refs/heads/dev" ]; then
    environment="dev"
elif [ "$GITHUB_REF" == "refs/heads/staging" ]; then
    environment="staging"
else
    echo "Unknown environment. Exiting..."
    exit 1
fi

echo "Environment: $environment"

# Create an environment file
echo "# Environment: $environment" > .env

# List all variables specific to the environment
# Assuming you have variables named like "PROD_VARIABLE_NAME", "DEV_VARIABLE_NAME", "STAGING_VARIABLE_NAME"
prefix="${environment^^}_"
for var in $(compgen -v | grep "^$prefix"); do
    # Remove the prefix from the variable name
    var_name="${var#$prefix}"
    # Get the value of the variable
    var_value="${!var}"
    # Write variable to .env file
    echo "$var_name=$var_value" >> .env
done

echo "Environment file generated."

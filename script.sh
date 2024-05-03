#!/bin/bash

set -x  # Enable debug mode

current_branch=$(git rev-parse --abbrev-ref HEAD)
echo "Current Branch: $current_branch"

# Determine the environment from the branch name
if [[ $current_branch == "dev" ]]; then
  environment="development"
elif [[ $current_branch == "staging" ]]; then
  environment="staging"
elif [[ $current_branch == "prod" ]]; then
  environment="prod"
else
  echo "Unsupported branch. Exiting."
  exit 1
fi

echo "Environment: $environment"

# Convert environment prefix to uppercase
prefix=$(echo "$environment" | tr '[:lower:]' '[:upper:]')_

# Filter and process environment variables based on prefix
filtered_variables=$(env | grep "^$prefix")

# Environment file
environment_file=".env.${environment}"

# Check if environment file exists
if [ ! -f "$environment_file" ]; then
  echo "Environment file not found. Creating..."

  # Write filtered environment variables to environment file
  echo "$filtered_variables" > "$environment_file"
 
 
  echo "Environment file created: $environment_file"
fi
echo " $environment_file"

# Now read the variables from the environment file
while IFS= read -r line; do
  echo "Variable: $line"
  # You can process each variable here
done < "$environment_file"

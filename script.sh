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

# Environment file
environment_file=".env.${environment}"

# Check if environment file exists
if [ ! -f "$environment_file" ]; then
  echo "Environment file not found. Creating..."

  # Create environment file based on the environment
  if [[ $environment == "development" ]]; then
    # Create .env.dev with default values
    echo "VAR1=value1" > "$environment_file"
    echo "VAR2=value2" >> "$environment_file"
    # Add more variables as needed
  elif [[ $environment == "staging" ]]; then
    # Create .env.staging with default values
    echo "VAR1=value1" > "$environment_file"
    echo "VAR2=value2" >> "$environment_file"
    # Add more variables as needed
  elif [[ $environment == "prod" ]]; then
    # Create .env.prod with default values
    echo "VAR1=value1" > "$environment_file"
    echo "VAR2=value2" >> "$environment_file"
    # Add more variables as needed
  fi

  echo "Environment file created: $environment_file"
fi

# Now read the variables from the environment file
while IFS= read -r line; do
  echo "Variable: $line"
  # You can process each variable here
done < "$environment_file"

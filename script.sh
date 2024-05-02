current_branch=$(git rev-parse --abbrev-ref HEAD)

# Determine the environment from the branch name
if [[ $current_branch == "dev" ]]; then
  environment="development"
elif [[ $current_branch == "staging" ]]; then
  environment="staging"
elif [[ $current_branch == "master" ]]; then
  environment="production"
else
  echo "Unsupported branch. Exiting."
  exit 1
fi

# Collect variables from the environment file
environment_file=".env.${environment}"
if [ -f "$environment_file" ]; then
  while IFS= read -r line; do
    echo "Variable: $line"
    # You can process each variable here
  done < "$environment_file"
else
  echo "Environment file not found: $environment_file"
  exit 1
fi



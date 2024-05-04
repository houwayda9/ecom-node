

# list_variables.sh
# Create a header
echo "# Listing Selected Environment Variables"

# Filter and loop through variables starting with specific prefixes
printenv | grep -E '^(PROD_|DOCKER_)' | while IFS='=' read -r key value; do
    echo "${key}=${value}"
done

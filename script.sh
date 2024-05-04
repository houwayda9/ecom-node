# list_variables.sh
# Create a header for the .env file
echo "# Exported Environment Variables" > ".env"

# Filter environment variables by prefix using `grep`
printenv | grep -E '^(PROD_|DOCKER_)' | while IFS='=' read -r key value; do
    echo "$key=$value" >> ".env"
done

echo "Selected environment variables exported to .env"

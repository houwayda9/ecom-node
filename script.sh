
echo "Creating .env file..."
{
    echo "# Exported Environment Variables"
    printenv | grep -v "GITHUB_" | grep -v "RUNNER_" | while IFS= read -r line; do
        key=$(echo "$line" | cut -d= -f1)
        value=$(echo "$line" | cut -d= -f2-)
        echo "$key=$value"
    done
} > .env

echo "Completed creating .env file."

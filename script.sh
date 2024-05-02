env_file=""

# Loop through all environment variables
env | while IFS='=' read -r var value; do
    # Skip empty lines or lines without '='
    [[ -z $var || -z $value ]] && continue

    # Get the first word of the value
    first_word=$(echo "$value" | awk '{print $1}')
    # Set the environment file based on the first word
    case $first_word in
        "prod")
            env_file="prod.env"
            ;;
        "dev")
            env_file="dev.env"
            ;;
        "staging")
            env_file="staging.env"
            ;;
        *)
            echo "Unknown environment for variable $var"
            continue
            ;;
    esac
    # Save the variable to the environment file
    echo "$var=$value" >> "$env_file"
done


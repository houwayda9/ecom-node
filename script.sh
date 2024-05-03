#!/bin/bash

# Extract branch name from GITHUB_REF
BRANCH=$(echo $GITHUB_REF | sed 's|refs/heads/||')
PREFIX=$(echo $BRANCH | awk '{print toupper($0)}')_

echo "Secrets:"
for secret_name in $(env | grep "^$PREFIX" | sed 's/=.*//'); do
    secret_value=${{ secrets.${secret_name#"$PREFIX"} }}
    echo "$secret_name=$secret_value"
done

# Loop through environment variables
echo "Variables:"
for var_name in $(env | grep "^$PREFIX" | sed 's/=.*//'); do
    var_value=${{ env.$var_name }}
    echo "$var_name=$var_value"
done

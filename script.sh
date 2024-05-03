#!/bin/bash

# Extract branch name from GITHUB_REF
BRANCH=$(echo $GITHUB_REF | sed 's|refs/heads/||')
PREFIX=$(echo $BRANCH | awk '{print toupper($0)}')_

# Loop through secrets
          echo "Secrets:"
          for secret_name in $(env | grep "^$PREFIX" | sed 's/=.*//'); do
            secret_value=$(echo "${{ secrets.$secret_name }}")
            echo "$secret_name=$secret_value"
          done

          # Loop through environment variables
          echo "Variables:"
          for var_name in $(env | grep "^$PREFIX" | sed 's/=.*//'); do
            var_value=$(echo "${{ env.$var_name }}")
            echo "$var_name=$var_value"
          done

#!/bin/bash

# Extract branch name from GITHUB_REF
BRANCH=$(echo $GITHUB_REF | sed 's|refs/heads/||')
PREFIX=$(echo $BRANCH | awk '{print toupper($0)}')_

# Export all environment-specific secrets dynamically
for var in $(env | grep "^$PREFIX" | sed 's/=.*//'); do
    clean_var_name=$(echo $var | sed "s/$PREFIX//")
    echo "$clean_var_name=$(env | grep "^$var=" | sed 's/^[^=]*=//')" >> .env
done

#!/bin/bash

# Extract branch name from GITHUB_REF
BRANCH=$(echo $GITHUB_REF | sed 's|refs/heads/||')
PREFIX=$(echo $BRANCH | awk '{print toupper($0)}')_

# Export all environment-specific secrets dynamically
> env  # Clear or create the env file
for var in $(env | grep "^$PREFIX"); do
    clean_var_name=$(echo $var | cut -d= -f1 | sed "s/$PREFIX//")
    value=$(echo $var | cut -d= -f2-)
    echo "$clean_var_name=$value" >> env
done
cat env

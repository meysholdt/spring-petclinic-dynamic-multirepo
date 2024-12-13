#!/usr/bin/env bash

# Example
# ADDITIONAL_REPOSITORIES="https://github.com/ben-manes/caffeine https://github.com/spring-projects/spring-boot https://github.com/pgjdbc/pgjdbc https://github.com/testcontainers/testcontainers-java"

# Check if the ADDITIONAL_REPOSITORIES environment variable is set and non-empty
if [ -z "$ADDITIONAL_REPOSITORIES" ]; then
    echo "No additional repositories specified. Please set ADDITIONAL_REPOSITORIES to add additional repos"
    exit 0
fi

# Split the ADDITIONAL_REPOSITORIES variable by spaces and clone each repository
for REPO_URL in $ADDITIONAL_REPOSITORIES; do
    echo "Cloning repository: $REPO_URL"
    git clone "$REPO_URL"
    if [ $? -ne 0 ]; then
        echo "Failed to clone $REPO_URL"
    fi
done

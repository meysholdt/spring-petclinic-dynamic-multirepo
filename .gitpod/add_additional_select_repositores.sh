#!/usr/bin/env bash

# Declare an array of git repository URLs
repositories=(
  "https://github.com/ben-manes/caffeine"
  "https://github.com/spring-projects/spring-boot"
  "https://github.com/pgjdbc/pgjdbc"
  "https://github.com/testcontainers/testcontainers-java"
)

# The environment variable REPOS should contain a space-separated list of repository names
# For example:
# export REPOS="caffeine spring-boot"

# If REPOS is empty or unset, exit with an error message.
if [ -z "${REPOS}" ]; then
  echo "Please set the REPOS environment variable to the repository names you want to clone."
  echo "Example: export REPOS=\"caffeine spring-boot\""
  exit 1
fi

# Convert REPOS environment variable into an array
IFS=' ' read -r -a selected_names <<< "${REPOS}"

# Filter repositories based on the selected names
selected_repositories=()
for repo in "${repositories[@]}"; do
  # Extract the repository name from the URL by taking the last segment after '/'
  repo_name="$(basename "$repo")"
  # Check if repo_name is in the selected_names array
  for name in "${selected_names[@]}"; do
    if [ "$repo_name" = "$name" ]; then
      selected_repositories+=("$repo")
      break
    fi
  done
done

# Check if we have any repositories to clone
if [ ${#selected_repositories[@]} -eq 0 ]; then
  echo "No repositories matched your selection."
  exit 0
fi

# Create the workspace directory if it doesn't exist
mkdir -p /workspace

# Clone the selected repositories into /workspace
for repo in "${selected_repositories[@]}"; do
  echo "Cloning $repo into /workspace/repositories..."
  git clone "$repo" /workspace/repositories/$(basename "$repo")
done

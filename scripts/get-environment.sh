#!/bin/bash

# This script determines the current environment and outputs it as a JSON object

# You can customize this logic to determine the environment as needed.
# For this example, we'll assume an environment variable `API_ENV` is set.

if [ -z "$API_ENV" ]; then
  echo '{"env": "dev"}'  # Default to 'dev' if no environment is set
else
  echo '{"env": "'$API_ENV'"}'
fi

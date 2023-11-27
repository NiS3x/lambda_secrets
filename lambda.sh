#!/bin/bash

# Check if jq is installed
if ! command -v jq &> /dev/null; then
    echo "jq is not installed. Please install jq to run this script."
    exit 1
fi

# Check if at least one profile is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 profile1 [profile2 profile3 ...]"
    exit 1
fi

# Loop through each AWS profile provided as arguments
for profile in "$@"
do
    echo "Using AWS profile: $profile"

    # Get a list of all AWS regions for the current profile
    regions=$(aws ec2 describe-regions --output json --profile $profile --region us-east-1 | jq -r '.Regions[].RegionName')

    # Loop through each region
    for region in $regions
    do
        echo "  Checking region: $region"

        # Get a list of all Lambda functions in the region
        functions=$(aws lambda list-functions --region $region --output json --profile $profile | jq -r '.Functions[].FunctionName')

        # Loop through each Lambda function
        for function in $functions
        do
            echo "    Getting environment variables for function: $function"

            # Get the environment variables for the Lambda function
            env_variables=$(aws lambda get-function-configuration --region $region --function-name $function --output json --profile $profile | jq -r '.Environment.Variables')

            # Display the results
            echo "      Environment variables for $function in $region:"
            echo "$env_variables"
            echo
        done
    done
done


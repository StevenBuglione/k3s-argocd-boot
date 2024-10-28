#!/bin/bash

# Define your parameters
SECRET_NAME=cloudflare-token-secret
NAMESPACE=cert-manager
UNSEALED_SECRET_OUTPUT=$SECRET_NAME.json
SEALED_SECRET_OUTPUT=sealed-$SECRET_NAME.yaml

# Define your secret data as an associative array
declare -A SECRET_DATA=(
    ["cloudflare-token"]=""
    # Add more key-value pairs as needed
)

# Create the secret
secret_literal=""
for key in "${!SECRET_DATA[@]}"; do
  secret_literal+=" --from-literal=$key=${SECRET_DATA[$key]}"
done

kubectl create secret generic $SECRET_NAME --namespace=$NAMESPACE --dry-run=client $secret_literal -o json > $UNSEALED_SECRET_OUTPUT

# Seal the secret
kubeseal --format=yaml --cert="$PUBLIC_CRT" --scope cluster-wide < $UNSEALED_SECRET_OUTPUT > $SEALED_SECRET_OUTPUT
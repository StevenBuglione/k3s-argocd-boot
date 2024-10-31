# Secret Generation and Decoding Guide

This guide will walk you through the process of generating secrets using the `secret-gen.sh` script and decoding them once they are applied to your Kubernetes cluster.

## Prerequisites

- You need to have `kubectl` and `kubeseal` installed on your local machine.
- You need to have access to your Kubernetes cluster's public certificate.
- You need to have $PUBLIC_CRT set in your environment variables. Which is the path to your Kubernetes cluster's public certificate.
## Generating Secrets

1. Open the `secret-gen.sh` script in a text editor.

2. At the top of the script, you'll see several parameters. Modify these parameters to fit your needs:

    - `SECRET_NAME`: The name of your secret.
    - `NAMESPACE`: The namespace where the secret will be created.
    - `UNSEALED_SECRET_OUTPUT`: The output file for the unsealed secret.
    - `SEALED_SECRET_OUTPUT`: The output file for the sealed secret.

3. Below these parameters, you'll see an associative array named `SECRET_DATA`. This array contains the key-value pairs for your secret. Modify this array to fit your needs:

    ```bash
    declare -A SECRET_DATA=(
        ["key1"]="value1"
        ["key2"]="value2"
        # Add more key-value pairs as needed
    )
    ```

4. Save your changes and close the text editor.

5. Run the script in a terminal:

    ```bash
    bash secret-gen.sh
    ```

6. The script will generate two files: one for the unsealed secret and one for the sealed secret. The names of these files are determined by the `UNSEALED_SECRET_OUTPUT` and `SEALED_SECRET_OUTPUT` parameters, respectively.

## Decoding Secrets

To decode a secret that is already applied to your Kubernetes cluster, you can use the `kubectl get secret` command with the `-o jsonpath` option. This command retrieves the secret data and outputs it in a specific format.

1. Run the following command in a terminal:

    ```bash
    kubectl get secret test-secret -o jsonpath='{.data.key1}' | base64 --decode
    ```

Replace `test-secret` with the name of your secret and `key1` with the key of the data you want to decode.

2. The command will output the decoded value of the secret data.

**Note:** Be careful with your secrets. Anyone with access to your Kubernetes cluster can potentially retrieve and decode your secrets.


1 Password config:
kubectl create secret generic op-credentials \
--from-file=1password-credentials.json=1password-credentials.json \
-n default

kubectl create secret generic <token-name> --from-literal=token=<OP_CONNECT_TOKEN> --namespace=<namespace>
[]()
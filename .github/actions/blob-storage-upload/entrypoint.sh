#!/usr/bin/env bash

set -e

if [[ -z "$INPUT_SOURCE_FILE" ]]; then
  echo "source directory is not set. Quitting."
  exit 1
fi

if [[ -z "$INPUT_CONTAINER_NAME" ]]; then
  echo "storage account container name is not set. Quitting."
  exit 1
fi

CONNECTION_METHOD=""

if [[ -n "$INPUT_CONNECTION_STRING" ]]; then
  CONNECTION_METHOD="--connection-string $INPUT_CONNECTION_STRING"
elif [[ -n "$INPUT_SAS_TOKEN" ]]; then
  if [[ -n "$INPUT_ACCOUNT_NAME" ]]; then
    CONNECTION_METHOD="--sas-token $INPUT_SAS_TOKEN --account-name $INPUT_ACCOUNT_NAME"
  else
    echo "account_name is required if using a sas_token. account_name is not set. Quitting."
    exit 1
  fi
else
  echo "either connection_string or sas_token are required and neither is set. Quitting."
  exit 1
fi

ARG_OVERWRITE=""
if [[ -n ${INPUT_OVERWRITE} ]]; then
  ARG_OVERWRITE="--overwrite true"
fi

az storage blob upload $CONNECTION_METHOD --file $INPUT_SOURCE_FILE --container-name $INPUT_CONTAINER_NAME $ARG_OVERWRITE

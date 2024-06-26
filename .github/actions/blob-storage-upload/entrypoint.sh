#!/usr/bin/env bash

set -e

if [[ -z "$INPUT_SOURCE_FILES" ]]; then
  echo "source directory(s) is not set. Quitting."
  exit 1
fi

if [[ -z "$INPUT_CONTAINER_NAMES" ]]; then
  echo "storage account container name(s) is not set. Quitting."
  exit 1
fi

SOURCE_FILE_ARR=($INPUT_SOURCE_FILES)
CONTAINER_ARR=($INPUT_CONTAINER_NAMES)

if [[ "${#SOURCE_FILE_ARR[@]}" -ne "${#CONTAINER_ARR[@]}" ]]; then
  echo "number of source files is not equal to number of container names. Quitting."
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

for i in "${!SOURCE_FILE_ARR[@]}"; do
  az storage blob upload $CONNECTION_METHOD --file ${SOURCE_FILE_ARR[$i]} --container-name ${CONTAINER_ARR[$i]} $ARG_OVERWRITE
done

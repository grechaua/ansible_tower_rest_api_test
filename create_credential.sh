#!/usr/bin/env bash

PROJECT_ID=$(cat project.txt)

PROJECT_SUBS="project\": \"${PROJECT_ID}\","
sed -i "s/project.*/${PROJECT_SUBS}/" create_credential.json

AUTHTOKEN=$(cat authtoken.txt)
curl \
    -H "${AUTHTOKEN}" \
    -H "Content-Type: application/json" \
    -X POST \
    -d @create_credential.json \
    "http://localhost/api/v1/credentials/" \
    -o credential.json

PROJECT_SUBS="project\": \"<PROJECT_ID>\","
sed -i "s/project.*/${PROJECT_SUBS}/" create_credential.json

CREDENTIAL_ID=$(cat credential.json | cut -d\, -f1 | cut -d\: -f2 | tr -d " ")
echo ${CREDENTIAL_ID} > credential.txt
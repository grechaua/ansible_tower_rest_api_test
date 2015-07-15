#!/usr/bin/env bash
AUTHTOKEN=$(cat authtoken.txt)
curl \
    -H "${AUTHTOKEN}" \
    -H "Content-Type: application/json" \
    -X POST \
    -d @create_organization.json \
    "http://localhost/api/v1/organizations/" \
    -o organization.json

ORGANIZATION_ID=$(cat organization.json | cut -d\, -f1 | cut -d\: -f2 | tr -d " ")
echo ${ORGANIZATION_ID} > organization.txt
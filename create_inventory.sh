#!/usr/bin/env bash

ORGANIZATION_ID=$(cat organization.txt)

ORGANIZATION_SUBS="organization\": \"${ORGANIZATION_ID}\","
sed -i "s/organization.*/${ORGANIZATION_SUBS}/" create_inventory.json

AUTHTOKEN=$(cat authtoken.txt)
curl \
    -H "${AUTHTOKEN}" \
    -H "Content-Type: application/json" \
    -X POST \
    -d @create_inventory.json \
    "http://localhost/api/v1/inventories/" \
    -o inventory.json

ORGANIZATION_SUBS="organization\": \"<ORGANIZATION_ID>\","
sed -i "s/organization.*/${ORGANIZATION_SUBS}/" create_inventory.json

INVENTORY_ID=$(cat inventory.json | cut -d\, -f1 | cut -d\: -f2 | tr -d " ")
echo ${INVENTORY_ID} > inventory.txt
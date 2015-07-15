#!/usr/bin/env bash
AUTHTOKEN=$(cat authtoken.txt)
curl \
    -H "${AUTHTOKEN}" \
    -H "Content-Type: application/json" \
    -X POST \
    -d @create_project.json \
    "http://localhost/api/v1/projects/" \
    -o project.json

PROJECT_ID=$(cat project.json | cut -d\, -f1 | cut -d\: -f2 | tr -d " ")
echo ${PROJECT_ID} > project.txt
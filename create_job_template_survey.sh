#!/usr/bin/env bash

INVENTORY_ID=$(cat inventory.txt)

INVENTORY_SUBS="inventory\": \"${INVENTORY_ID}\","
sed -i "s/inventory.*/${INVENTORY_SUBS}/" create_job_template_survey.json

PROJECT_ID=$(cat project.txt)

PROJECT_SUBS="project\": \"${PROJECT_ID}\","
sed -i "s/project.*/${PROJECT_SUBS}/" create_job_template_survey.json

CREDENTIAL_ID=$(cat credential.txt)

CREDENTIAL_SUBS="\"credential\": \"${CREDENTIAL_ID}\","
sed -i "s/\"credential.*/${CREDENTIAL_SUBS}/" create_job_template_survey.json

AUTHTOKEN=$(cat authtoken.txt)
curl \
    -H "${AUTHTOKEN}" \
    -H "Content-Type: application/json" \
    -X POST \
    -d @create_job_template_survey.json \
    "http://localhost/api/v1/job_templates/" \
    -o job_template_survey.json

INVENTORY_SUBS="inventory\": \"<INVENTORY_ID>\","
sed -i "s/inventory.*/${INVENTORY_SUBS}/" create_job_template_survey.json

PROJECT_SUBS="project\": \"<PROJECT_ID>\","
sed -i "s/project.*/${PROJECT_SUBS}/" create_job_template_survey.json

CREDENTIAL_SUBS="\"credential\": \"<CREDENTIAL_ID>\","
sed -i "s/\"credential.*/${CREDENTIAL_SUBS}/" create_job_template_survey.json

JOB_TEMPLATE_ID=$(cat job_template_survey.json | cut -d\, -f1 | cut -d\: -f2 | tr -d " ")
echo ${JOB_TEMPLATE_ID} > job_template_survey.txt

curl \
    -H "${AUTHTOKEN}" \
    -H "Content-Type: application/json" \
    -X POST \
    -d @create_survey.json \
    "http://localhost/api/v1/job_templates/${JOB_TEMPLATE_ID}/survey_spec/"

curl \
    -H "${AUTHTOKEN}" \
    -H "Content-Type: application/json" \
    -X GET \
    "http://localhost/api/v1/job_templates/${JOB_TEMPLATE_ID}/survey_spec/" \
    -o survey.json


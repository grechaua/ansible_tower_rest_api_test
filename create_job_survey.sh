#!/usr/bin/env bash

CREDENTIAL_ID=$(cat credential.txt)

CREDENTIAL_SUBS="\"credential\": \"${CREDENTIAL_ID}\","
sed -i "s/\"credential.*/${CREDENTIAL_SUBS}/" create_job_survey.json

JOB_TEMPLATE_ID=$(cat job_template_survey.txt)

JOB_TEMPLATE_SUBS="job_template\": \"${JOB_TEMPLATE_ID}\","
sed -i "s/job_template.*/${JOB_TEMPLATE_SUBS}/" create_job_survey.json

PROJECT_ID=$(cat project.txt)

PROJECT_SUBS="project\": \"${PROJECT_ID}\","
sed -i "s/project.*/${PROJECT_SUBS}/" create_job_survey.json

AUTHTOKEN=$(cat authtoken.txt)
curl \
    -H "${AUTHTOKEN}" \
    -H "Content-Type: application/json" \
    -X POST \
    -d @create_job_survey.json \
    "http://localhost/api/v1/jobs/" \
    -o job_survey.json

PROJECT_SUBS="project\": \"<PROJECT_ID>\","
sed -i "s/project.*/${PROJECT_SUBS}/" create_job_survey.json

JOB_TEMPLATE_SUBS="job_template\": \"<JOB_TEMPLATE_ID>\","
sed -i "s/job_template.*/${JOB_TEMPLATE_SUBS}/" create_job_survey.json

CREDENTIAL_SUBS="\"credential\": \"<CREDENTIAL_ID>\","
sed -i "s/\"credential.*/${CREDENTIAL_SUBS}/" create_job_survey.json

JOB_ID=$(cat job_survey.json | cut -d\, -f1 | cut -d\: -f2 | tr -d " ")
echo ${JOB_ID} > job_survey.txt

curl \
    -H "${AUTHTOKEN}" \
    -H "Content-Type: application/json" \
    -X POST \
    "http://localhost/api/v1/jobs/${JOB_ID}/start/" \
    -o job_survey_start.json


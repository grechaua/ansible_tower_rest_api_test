#!/usr/bin/env bash
USER=$(cat /etc/profile.d/ansible-tower.sh | grep Username | cut -d\: -f2 | cut -d \" -f1 | tr -d " ")
PASSWORD=$(cat /etc/profile.d/ansible-tower.sh | grep Password | cut -d\: -f2 | cut -d \" -f1 | tr -d " ")
#echo "{ \"username\": \"${USER}\", \"password\": \"${PASSWORD}\"}" > create_authtoken.json

USER_SUBS="\"username\": \"${USER}\","
sed -i "s/\"username.*/${USER_SUBS}/" create_authtoken.json

PASSWORD_SUBS="\"password\": \"${PASSWORD}\""
sed -i "s/\"password.*/${PASSWORD_SUBS}/" create_authtoken.json

curl \
    -H "Content-Type: application/json" \
    -X POST \
    -d @create_authtoken.json \
    "http://localhost/api/v1/authtoken/" \
    -o authtoken.json
chmod 600 authtoken.json

USER_SUBS="username\": \"<USER>\","
sed -i "s/username.*/${USER_SUBS}/" create_authtoken.json

PASSWORD_SUBS="\"password\": \"<PASSWORD>\""
sed -i "s/\"password.*/${PASSWORD_SUBS}/" create_authtoken.json

AUTHTOKEN=$(cat authtoken.json | cut -d\, -f1 | cut -d\" -f4)
echo "Authorization: token ${AUTHTOKEN}" > authtoken.txt
chmod 600 authtoken.txt

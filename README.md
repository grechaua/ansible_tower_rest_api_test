# ansible_tower_rest_api_test
Testing API of Ansible Tower

git clone git@github.com:grechaua/ansible_tower_rest_api_test.git

vagrant init tower http://vms.ansible.com/ansible-tower-2.1.6-virtualbox.box

vagrant up

vagrant ssh

get login/password from motd/welcome banner inside vm

obtain 10 nodes endless license and put it into https://localhost:8443/

inside vm run:
cd /vagrant/

./create_authtoken.sh

./create_organization.sh

./create_project.sh

./create_credential.sh

./create_inventory.sh

./create_job_template.sh

./create_job_template_survey.sh

./create_job_survey.sh



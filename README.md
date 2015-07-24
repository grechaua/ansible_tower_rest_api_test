# ansible_tower_rest_api_test
Testing API of Ansible Tower

1. Download sources to some folder:

```
git clone git@github.com:grechaua/ansible_tower_rest_api_test.git
```

2. Start vm:

```
vagrant up

vagrant ssh
```

3. Get login/password from motd/welcome banner inside vm.

4. Obtain 10 nodes endless license and put it into https://localhost:8443/

5. Play with scripts inside vm:

```
cd /vagrant/

./create_authtoken.sh

./create_organization.sh

./create_project.sh

wait until tower connected to github and check repository

./create_credential.sh

./create_inventory.sh

./create_job_template.sh

./create_job_template_survey.sh

./create_job_survey.sh
```


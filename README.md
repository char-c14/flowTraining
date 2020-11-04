# FlowTraining
Repo for testing Ansible 2.10 (w/ Python3.9.0)
> Docker was attempted for trying the Ansible scripts, but after WSL2 intergration problems, all tests have been done on a GCP Server

Included subtree from [pyenv-installer](https://github.com/pyenv/pyenv-installer)

All playbooks in folder to run use 
`ansible-playbook playbooks/install-pyenv-ubuntu.yml -i inventory_test`

Added playbook for installing [weatherScript](https://github.com/char-c14/weatherScript) in pyenv for data fetching from HK Obsevatory API, with cron for automated fetching
`ansible-playbook playbooks/load_weather_script.yml -i inventory_test -v`
`ansible-playbook playbooks/deploy_cron_weather.yml -i inventory_test -v`

Folder weather_app contains 
- clean.sh for Data management on server (Cron job used for deployment)
- config.ini for weatherScript used (Check weatherScript repo for more info)
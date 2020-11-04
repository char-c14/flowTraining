# FlowTraining
Repo for testing Ansible 2.10 (w/ Python3.9.0)
> Docker was attempted for trying the Ansible scripts, but after WSL2 intergration problems, all tests have been done on a GCP Server

Included subtree from [pyenv-installer](https://github.com/pyenv/pyenv-installer)

All playbooks in folder named so. To run use  
`ansible-playbook playbooks/<playbook_name>.yml -i inventory_test`

Added playbooks for installing [weatherScript](https://github.com/char-c14/weatherScript/tree/entryPoint) in pyenv for data fetching from HK Obsevatory API, with cron for automated fetching  
Requirements: pyenv installed in remote server  
`ansible-playbook playbooks/load_weather_script.yml -i inventory_test -v`
- Creates folder weather_app at HOME, where a virtualenv (weatherSetup) is created
- Copies required files from Subtree of [weatherScript](https://github.com/char-c14/weatherScript/tree/entryPoint) repo
- Installs poetry into virtualenv and installs weatherScript (along with dependencies from `pyproject.toml` and `poetry.lock`)  
`ansible-playbook playbooks/deploy_cron_weather.yml -i inventory_test -v`
- Copies `config.ini` and `clean.sh` from local dir. Folder weather_app contains 
  - `clean.sh` for Data management on server (Cron job used for deployment)
  - `config.ini` for weatherScript used (Check weatherScript repo for more info)
- Sets up cron job at server for 
  - Entry point of pre-existing weatherScript package `weather_get`
    - Logs stored at weather_app/data_logs
  - Clean old log files using `clean.sh`

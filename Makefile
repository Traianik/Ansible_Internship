#ENVIRONMENT = /dev # make dynamic
#ANSIBLE_LIMIT_HOST = postgresql-group
VARS_FILE = ./env/$(ENVIRONMENT)/$(ANSIBLE_LIMIT_HOST).yml # make dynamic
VAULT_VARS_FILE = ./env/$(ENVIRONMENT)/vault_secrets.yml
VAULT_GEN_PASS_FILE = ./env/$(ENVIRONMENT)/vault_pass.sh
PLAYBOOK_DIR = ./playbooks

venv: hello create_venv activate 


hello:
	echo "Hello, World"

create_venv:
	python3 -m venv p_env1 \

activate:
	. p_env1/bin/activate; \
	python3 -m pip install --upgrade pip;  \
	pip3 install ansible; \
 	python3 -m pip install --upgrade ansible; \

validate:
ifeq ($(ENVIRONMENT),)
	@echo "No evniroment var!"
	@exit 1
endif
ifeq ($(VARS_FILE),)
	@echo "No var_file var!"
	@exit 1
endif


deploy_postgresql: validate
	ansible-playbook -i env/$(ENVIRONMENT)/hosts  -l $(ANSIBLE_LIMIT_HOST) --extra-vars=@$(VAULT_VARS_FILE) --extra-vars=@$(VARS_FILE) --vault-password-file="$(VAULT_GEN_PASS_FILE)" $(PLAYBOOK_DIR)/deploy_postgresql.yml -vvvv --tags "deploy"
install_postgresql: validate
	ansible-playbook -i env/$(ENVIRONMENT)/hosts  -l $(ANSIBLE_LIMIT_HOST) --extra-vars=@$(VAULT_VARS_FILE) --extra-vars=@$(VARS_FILE) --vault-password-file="$(VAULT_GEN_PASS_FILE)" $(PLAYBOOK_DIR)/deploy_postgresql.yml  --tags "install"
configure_postgresql: validate
	ansible-playbook -i env/$(ENVIRONMENT)/hosts  -l $(ANSIBLE_LIMIT_HOST) --extra-vars=@$(VAULT_VARS_FILE) --extra-vars=@$(VARS_FILE) --vault-password-file="$(VAULT_GEN_PASS_FILE)" $(PLAYBOOK_DIR)/deploy_postgresql.yml  --tags "configure"


deploy_mongodb: validate
	ansible-playbook -i env/$(ENVIRONMENT)/hosts  -l $(ANSIBLE_LIMIT_HOST) --extra-vars=@$(VAULT_VARS_FILE) --extra-vars=@$(VARS_FILE) --vault-password-file="$(VAULT_GEN_PASS_FILE)"  $(PLAYBOOK_DIR)/deploy_mongodb.yml
install_mongodb: validate
	ansible-playbook -i env/$(ENVIRONMENT)/hosts  -l $(ANSIBLE_LIMIT_HOST) --extra-vars=@$(VAULT_VARS_FILE) --extra-vars=@$(VARS_FILE) --vault-password-file="$(VAULT_GEN_PASS_FILE)"  $(PLAYBOOK_DIR)/deploy_mongodb.yml  --tags "install"
configure_mongodb: validate 
	ansible-playbook -i env/$(ENVIRONMENT)/hosts  -l $(ANSIBLE_LIMIT_HOST) --extra-vars=@$(VAULT_VARS_FILE) --extra-vars=@$(VARS_FILE) --vault-password-file="$(VAULT_GEN_PASS_FILE)"  $(PLAYBOOK_DIR)/deploy_mongodb.yml  --tags "configure" 


deploy_es: validate
	ansible-playbook -i env/$(ENVIRONMENT)/hosts  -l $(ANSIBLE_LIMIT_HOST) --extra-vars=@$(VAULT_VARS_FILE) --extra-vars=@$(VARS_FILE) --vault-password-file="$(VAULT_GEN_PASS_FILE)"  $(PLAYBOOK_DIR)/deploy_elasticsearch.yml
install_es: validate
	ansible-playbook -i env/$(ENVIRONMENT)/hosts  -l $(ANSIBLE_LIMIT_HOST) --extra-vars=@$(VAULT_VARS_FILE) --extra-vars=@$(VARS_FILE) --vault-password-file="$(VAULT_GEN_PASS_FILE)"  $(PLAYBOOK_DIR)/deploy_elasticsearch.yml  --tags "install"
configure_es: validate 
	ansible-playbook -i env/$(ENVIRONMENT)/hosts  -l $(ANSIBLE_LIMIT_HOST) --extra-vars=@$(VAULT_VARS_FILE) --extra-vars=@$(VARS_FILE) --vault-password-file="$(VAULT_GEN_PASS_FILE)"  $(PLAYBOOK_DIR)/deploy_elasticsearch.yml  --tags "configure"  


	
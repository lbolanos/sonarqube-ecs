include ../../../defybots/Common.mk

ifndef ENV
ENV=dev
endif
include .env.${ENV}
export

.PHONY: init_eb
init_ecs: ## initialize the ecs environment and ecr repository.  Just for new projects STAGE=dev REGION=us-west-1 VERBOSE=-v
	@if [ "${STAGE}" = "" ]; then \
	  prj_stage="$$(echo dev)"; \
	else \
	  prj_stage="$$(echo ${STAGE})"; \
	fi; \
	if [ "${REGION}" != "" ]; then \
	  opt_region=$$(echo "-e ${REGION}"); \
	else \
	  opt_region=$$(echo ""); \
	fi; \
	echo ./init.sh ${ACTION} -s $$prj_stage $$opt_region ${VERBOSE}; \
	./init.sh -s $$prj_stage $$opt_region


.PHONY: di
di: deploy-images ## deploy the images to ecr STAGE=dev

.PHONY: deploy-images
deploy-images: ## deploy the images to ecr STAGE=dev
	@if [ "${STAGE}" = "" ]; then \
	  prj_stage="$$(echo dev)"; \
	else \
	  prj_stage="$$(echo ${STAGE})"; \
	fi; \
	if [ "${REGION}" != "" ]; then \
	  opt_region=$$(echo "-e ${REGION}"); \
	else \
	  opt_region=$$(echo ""); \
	fi; \
	echo ./deploy-images.sh ${ACTION} -s $$prj_stage $$opt_region ${VERBOSE}; \
	./deploy-images.sh -s $$prj_stage $$opt_region

.PHONY: create
create: ## create all the environment STAGE=dev REGION=us-west-1 VERBOSE=-v
	@make ebex ACTION="-c"

.PHONY: deploy
deploy: ## deploy the environment STAGE=dev REGION=us-west-1 VERBOSE=-v
	@make ebex

.PHONY: terminate
terminate: ## terminate elastic beanstalk
	@make ebex ACTION="-r"

.PHONY: ebex
ebex: ## execute sls ACTION=-idlmv STAGE=dev REGION=us-west-1 VERBOSE=-v
	@if [ "${STAGE}" = "" ]; then \
	  prj_stage="$$(echo dev)"; \
	else \
	  prj_stage="$$(echo ${STAGE})"; \
	fi; \
	if [ "${REGION}" != "" ]; then \
	  opt_region=$$(echo "-e ${REGION}"); \
	else \
	  opt_region=$$(echo ""); \
	fi; \
	echo ./sls.sh ${ACTION} -s $$prj_stage $$opt_region ${VERBOSE}; \
	./sls.sh ${ACTION} -s $$prj_stage $$opt_region ${VERBOSE}

.PHONY: convert
convert: ## destroy all the infrastructure
	sudo docker compose convert > cf.yml


.PHONY: destroy
destroy_eb: ## destroy all the infrastructure
	./destroy.sh




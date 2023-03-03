#!/bin/bash
set -eo pipefail #xu
CURR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
cd $CURR_DIR

source "$CURR_DIR"/common.env

#aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ACCOUNT.dkr.ecr.$REGION.amazonaws.com
#sudo docker context create ecs myecs
sudo docker context ls
sudo docker context use myecs
#sudo docker compose up
#sudo docker context create myecs --local-simulation ecsLocal
#docker --context your_ecs_context compose convert

ACTION=
if ! aws cloudformation describe-stacks --region ${REGION} --stack-name "${PRJ}" ; then\
  ACTION="create-stack --on-failure DELETE";\
else \
  ACTION=update-stack;\
fi

aws cloudformation $ACTION \
		--region $REGION --stack-name ${PRJ} --template-body file:///$CURR_DIR/cf.yml \
		--capabilities CAPABILITY_NAMED_IAM


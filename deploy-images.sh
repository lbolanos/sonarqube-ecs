#!/bin/bash
set -eo pipefail #xu
CURR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "$CURR_DIR"/common.env


# https://rsalveti.wordpress.com/2007/04/03/bash-parsing-arguments-with-getopts/
usage()
{
cat << EOF
usage: $0 options
This packages & deploy the chalice app to aws labmda
OPTIONS:
   -h      Show this message
   -e      region
   -s      stage to deploy to, can be dev (default) or prod
EOF
}

STAGE=dev
while getopts "hs:e:" OPTION
do
  case $OPTION in
    h)
      usage
      exit 1
      ;;
    s)
      STAGE=$OPTARG
      ;;
    e)
      REGION="$OPTARG"
      ;;
    ?)
      usage
      exit
      ;;
  esac
done
echo "deploy images STAGE=$STAGE REGION=$REGION "

#docker compose up -d
#docker build --tag $PRJ:latest .

#docker tag $PRJ:latest $ACCOUNT.dkr.ecr.$REGION.amazonaws.com/$PRJ-$STAGE:latest
#aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $ACCOUNT.dkr.ecr.$REGION.amazonaws.com
#docker push $ACCOUNT.dkr.ecr.$REGION.amazonaws.com/$PRJ-$STAGE:latest

sudo docker context use default
DOCKER_ACC=lbolanos
IMG_TAG=v11
sudo docker login
#DOCKER_BUILDKIT=0 sudo docker build --progress=plain --no-cache -t $DOCKER_ACC/$PRJ:$IMG_TAG .
sudo docker build -t $DOCKER_ACC/$PRJ:$IMG_TAG .
sudo docker push $DOCKER_ACC/$PRJ:$IMG_TAG



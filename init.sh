#!/bin/bash
set -eo pipefail #xu
CURR_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "$CURR_DIR"/common.env
#export $(grep -v '^#' "$CURR_DIR"/common.env | xargs -d '\n')

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
      REGION="-e $OPTARG"
      REGION_CMD="--region $OPTARG"
      ;;
    ?)
      usage
      exit
      ;;
  esac
done
echo "init PRJ=$PRJ STAGE=$STAGE REGION=$REGION_CMD "

aws ecr create-repository --repository-name $REGION_CMD $PRJ-$STAGE
aws ecr describe-repositories | grep repositoryUri

./deploy-images.sh -s $STAGE $REGION


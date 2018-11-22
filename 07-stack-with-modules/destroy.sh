#!/bin/bash

USAGE() {
  echo -e "Usage: $0 ENV MODULE-NAME "
  exit 1
}

MODULE=$2
ENV=$1
[ -z "$MODULE" ] && MODULE=all
if [ -z "$ENV" ]; then 
  USAGE
fi

if [ ! -d env/$ENV ]; then 
  echo -e "\e[31mEnvironment does not exist"
  USAGE
fi

cat provider.txt  | sed -e "s/ENVIRONMENT/$ENV/"  >provider.tf
source /home/centos/terraform/07-stack-with-modules/module-list.txt
terraform init
if [ "$MODULE" = all ]; then 
  for module in ${CREATE_ORDER[*]} ; do 
     echo "Running module :: $module"
     terraform destroy -target=module.$module -auto-approve -var-file=env/$ENV/$ENV.tf
  done
else
  terraform destroy -target=module.$MODULE -auto-approve -var-file=env/$ENV/$ENV.tf
fi

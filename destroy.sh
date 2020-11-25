#!/bin/bash

if [ "$1" == "sandbox" ]; then
  run_env="sandbox"
elif [ "$1" == "prod" ]; then
  run_env="prod"
else
    echo "Parameter 1 should be sandbox or prod"
    exit
fi

export AWS_PROFILE=jgularte
export AWS_DEFAULT_REGION=us-west-2

cd source; chalice package --stage $run_env --pkg-format terraform ../terraform/$run_env
cd ../terraform/$run_env; terraform init; terraform plan -destroy -out destroy-tfplan; terraform apply destroy-tfplan
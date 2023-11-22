#!/bin/bash

terraform init

# Prompt for necessary informations
echo "Enter information for the database:"
read -p "Database username: " database_username
read -p "Database password: " database_password
read -p "Database name: " database_name
read -p "Keypair name: " key_pair_name

# Pass the user inputs to Terraform using terraform plan -var option
terraform plan -var="database_username=$database_username" -var="database_password=$database_password" -var="key_pair_name=$key_pair_name" -var="database_name=$database_name"

echo "Do you want to perform terraform apply? Aproximate time: 5 min (yes/no)"
read confirmation

if [ "$confirmation" == "yes" ]; then
    echo "Proceeding with the action..."
    echo "Don't press CTRL-C or CTRL-Z!"
    sleep 3
    terraform apply -var="database_username=$database_username" -var="database_password=$database_password" -var="key_pair_name=$key_pair_name" -var="database_name=$database_name"
else
    echo "Action aborted."
fi

echo "Application ready to go. Just enter the alb dns on your navigator. May take a few seconds to be deployed"
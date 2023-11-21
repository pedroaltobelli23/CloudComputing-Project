#!/bin/bash

# Prompt the user for additional inputs
echo "Enter information for the database:"
read -p "Database username: " database_username
read -p "Database password: " database_password
read -p "Database name: " database_name
read -p "Keypair name: " key_pair_name

# Pass the user inputs to Terraform using terraform apply -var option
terraform plan -var="database_username=$database_username" -var="database_password=$database_password" -var="key_pair_name=$key_pair_name" -var="database_name=$database_name"

echo "Do you want to perform terraform apply? (yes/no)"
read confirmation

if [ "$confirmation" == "yes" ]; then
    echo "Proceeding with the action..."
    echo "Don't press CTRL-C or CTRL-Z!"
    sleep 3
    terraform apply -var="database_username=$database_username" -var="database_password=$database_password" -var="key_pair_name=$key_pair_name" -var="database_name=$database_name"
else
    echo "Action aborted."
fi
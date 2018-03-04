#!/bin/sh
# TODO: needs to use remote (shared per env) state
terraform init
terraform apply -auto-approve

cluster_ca_certificate=$(terraform output -json | jq -r .cluster_ca_certificate.value)
client_certificate=$(terraform output -json | jq -r .client_certificate.value)
client_key=$(terraform output -json | jq -r .client_key.value)
cluster_api_url=$(terraform output -json | jq -r .cluster_api_url.value)
username=$(terraform output -json | jq -r .username.value)
password=$(terraform output -json | jq -r .password.value)
cluster_name=$(terraform output -json | jq -r .cluster_name.value)
cluster_zone=$(terraform output -json | jq -r .cluster_zone.value)


echo "{\"cluster_ca_certificate\":\"${cluster_ca_certificate}\",\"client_certificate\":\"${client_certificate}\",\"client_key\":\"${client_key}\",\"cluster_api_url\":\"${cluster_api_url}\",\"username\":\"${username}\",\"password\":\"${password}\",\"cluster_name\":\"${cluster_name}\",\"cluster_zone\":\"${cluster_zone}\"}" > $1

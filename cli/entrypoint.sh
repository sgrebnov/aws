#!/bin/sh

set -e

# Respect AWS_DEFAULT_REGION if specified
[ -n "$AWS_DEFAULT_REGION" ] || export AWS_DEFAULT_REGION=us-east-1

# Respect AWS_DEFAULT_OUTPUT if specified
[ -n "$AWS_DEFAULT_OUTPUT" ] || export AWS_DEFAULT_OUTPUT=json

# Capture output
#output=$( sh -c "aws $*" )
aws --profile default configure set aws_access_key_id "$AWS_ACCESS_KEY_ID"
aws --profile default configure set aws_secret_access_key "$AWS_SECRET_ACCESS_KEY"
aws --profile default configure set region "$AWS_DEFAULT_REGION"

# Preserve output for consumption by downstream actions
#echo "$output" > "${HOME}/${GITHUB_ACTION}.${AWS_DEFAULT_OUTPUT}"

# Write output to STDOUT
#echo "$output"

#echo "$KUBE_CONFIG_DATA" | base64 --decode > /tmp/config
#export KUBECONFIG=/tmp/config

k8sversion=v1.16.0
curl -LO https://storage.googleapis.com/kubernetes-release/release/$k8sversion/bin/linux/amd64/kubectl
chmod +x ./kubectl

#output=$( sh -c "aws eks --region '$AWS_DEFAULT_REGION' update-kubeconfig --name projects" )
output=$( sh -c "aws sts get-caller-identity" )
echo "$output"
                      
sh -c "$*"

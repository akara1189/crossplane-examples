#!/bin/bash

source ./shell_functions.sh

kind create cluster --config ${KIND_CONFIG}; report_error kind

helm repo add ${LOCALSTACK_REPO_NAME} ${LOCALSTACK_REPO_URL}
helm upgrade --install ${LOCALSTACK_RELEASE} ${LOCALSTACK_REPO}

helm repo add ${CROSSPLANE_REPO_NAME} ${CROSSPLANE_REPO_URL} #Installs Crossplane from public Helm
helm repo update
helm install  --wait --create-namespace --namespace crossplane-system ${CROSSPLANE_RELEASE} ${CROSSPLANE_REPO}; report_error crossplane

kubectl create -f providers/aws.yaml #Needs to happen before ProviderConfig
sleep 60 #Cheap way to wait for Provider to become available. There are better ways to do this. 

kubectl create -f providers/config.yaml

kubectl create -f XRDs/build_server.yaml
sleep 60

kubectl create -f compositions/function.yaml #Before the Composition is installed
sleep 60

kubectl create -f compositions/build_server.yaml

kubectl create -f claims/build_server.yaml
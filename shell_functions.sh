#This file is built to be sourced by another script.

KIND_CONFIG="./kind-config.yaml"

CROSSPLANE_RELEASE="crossplane"

CROSSPLANE_REPO="crossplane-stable/crossplane"

CROSSPLANE_REPO_NAME="crossplane-stable"

CROSSPLANE_REPO_URL="https://charts.crossplane.io/stable"

LOCALSTACK_REPO_NAME="localstack-repo"

LOCALSTACK_REPO_URL="https://helm.localstack.cloud"

LOCALSTACK_RELEASE="localstack"

LOCALSTACK_REPO="localstack-repo/localstack"

report_error () {
    previous_return_code=${?} # Grabbing last return code since BASH doesn't really use stacks/scoping for functions...

    if [ ${#} -ne 1 ]
    then
      echo "report_error shell function takes 1 argument. Received ${#}"
    fi

    if [ ${previous_return_code} != "0" ]
    then
      echo "Something went wrong trying to create or delete ${1}!"
      exit 1337
    fi
}
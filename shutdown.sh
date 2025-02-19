source ./shell_functions.sh

kind delete cluster # Always returns 0 return code. No need to delete Crossplane components separately.

helm repo remove ${CROSSPLANE_REPO_NAME} ${LOCALSTACK_REPO_NAME}
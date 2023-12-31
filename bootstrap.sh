OC_COMMAND="oc <command>"

# Check if the operator is installed
oc apply -k ./bootstrap/argocd/
OPERATOR_NAME="openshift-gitops-operator"
OPERATOR_STATUS=$(oc get subscriptions -n openshift-operators | grep openshift-gitops)
# Wait until the operator is installed
if [[ ! "$OPERATOR_STATUS"]]; then
  echo "Waiting for operator '$OPERATOR_NAME' to be installed..."
  while [[ ! "$OPERATOR_STATUS" ]]; do
    sleep 5
    OPERATOR_STATUS=$(oc get subscriptions -n openshift-operators | grep openshift-gitops)
  done
fi

# Execute the oc command
echo "Operator '$OPERATOR_NAME' is installed."
oc apply -f ./bootstrap/01_operators-v2.yaml

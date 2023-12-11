OC_COMMAND="oc <command>"

# Check if the operator is installed
oc apply -k ./bootstrap/argo/
OPERATOR_NAME="openshift-gitops-operator"
OPERATOR_STATUS=$(oc get clusteroperators | grep "$OPERATOR_NAME" | awk '{print $2}')

# Wait until the operator is installed
if [[ "$OPERATOR_STATUS" != "Installed" ]]; then
  echo "Waiting for operator '$OPERATOR_NAME' to be installed..."
  while [[ "$OPERATOR_STATUS" != "Installed" ]]; do
    sleep 5
    OPERATOR_STATUS=$(oc get clusteroperators | grep "$OPERATOR_NAME" | awk '{print $2}')
  done
fi

# Execute the oc command
echo "Operator '$OPERATOR_NAME' is installed."
oc apply -f ./bootstrap/01_operators-v2.yaml

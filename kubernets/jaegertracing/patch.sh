for n in $(kubectl get deploy -n "$NAMESPACE" -o custom-columns=NAME:.metadata.name|grep -v NAME)
do
  kubectl patch deploy -n "$NAMESPACE" $n -p='{"spec":{"template":{"spec":{"containers":[{"name":"'$n'","env":[{"name":"CLUSTER_PODIP","valueFrom":{"fieldRef":{"apiVersion":"v1","fieldPath":"status.podIP"}}},{"name":"CLUSTER_NODEIP","valueFrom":{"fieldRef":{"apiVersion":"v1","fieldPath":"status.hostIP"}}}]}]}}}}';
done
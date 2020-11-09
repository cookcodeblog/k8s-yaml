# https://kubernetes.io/docs/concepts/workloads/controllers/replicaset/


# create replicaset
kubectl apply -f kuard-rs.yaml

kubectl get rs
kubectl get rs -o wide

# <pod-name>-<hash>
kubectl get pods

kubectl describe rs/kuard

# find owner references of pod, if created by replicaset ?
kubectl get pods kuard-hgpws -o jsonpath="{ .metadata.ownerReferences }"
kubectl get pods kuard-hgpws -o jsonpath="{ .metadata.ownerReferences[0].kind }"

# find pods by replicaset selectors
kubectl get pods --selector="app=kuard,version=2"
kubectl get pods -l "app=kuard,version=2"


# hpa, auto scale for replicaset
# https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale/

yum install stress -y
stress --cpu 2

htop


kubectl describe hpa kuard

# the HPA controller was unable to get the target's current scale: no matches for kind "ReplicaSet" in group ""

kubectl top nodes
kubectl top pods

kubectl autoscale rs kuard --cpu-percent=50 --min=3 --max=5

# error: Metrics API not available
# https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/
# https://github.com/kubernetes-sigs/metrics-server/issues/300
# https://github.com/kubernetes/community/blob/master/contributors/design-proposals/instrumentation/custom-metrics-api.md
# https://kubernetes.io/docs/tasks/debug-application-cluster/resource-metrics-pipeline/#metrics-server
# https://github.com/kubernetes-sigs/metrics-server/releases
# https://computingforgeeks.com/how-to-deploy-metrics-server-to-kubernetes-cluster/
# https://stackoverflow.com/questions/54248617/horizontal-pod-autoscale-unable-to-read-metrics
# https://stackoverflow.com/questions/53725248/how-to-enable-kubeapi-server-for-hpa-autoscaling-metrics/53727101#53727101
# https://stackoverflow.com/questions/49836681/kubernetes-autoscaler-not-scaling-hpa-shows-target-unknown


kubectl run -i --tty load-generator --rm --image=busybox --restart=Never -- /bin/sh -c "while sleep 0.01; do echo 'do again'; done"
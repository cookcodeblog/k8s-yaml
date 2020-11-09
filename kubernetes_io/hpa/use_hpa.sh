

kubectl apply -f php-apache.yaml

kubectl get deployment

kubectl get pods

kubectl get service


# autoscale

kubectl autoscale deployment php-apache --cpu-percent=50 --min=1 --max=5

kubectl get hpa

kubectl run -i --tty load-generator --rm --image=busybox --restart=Never -- /bin/sh -c "while sleep 0.01; do wget -q -O- http://php-apache; done"


kubectl run -i --tty load-generator --image=busybox /bin/sh

wget -q -O- http://php-apache

wget -q -O- http://php-apache.default.svc.cluster.local

# curl, dig, nc

kubectl run -it curl-util --image=webwurst/curl-utils -- /bin/sh

#  <cluster_ip>:<port>
curl -s http://10.105.77.184:80
curl -s http://php-apache
dig http://php-apache +short
dig http://php-apache | less
dig kubernetes.default.svc.cluster.local
nc


kubectl run -it busybox --image=busybox -- /bin/sh

kubectl run -it busybox --image=busybox -- nslookup kubernetes.default

# https://kubernetes.io/docs/tasks/access-application-cluster/service-access-application-cluster/
# https://v1-16.docs.kubernetes.io/docs/tasks/administer-cluster/dns-debugging-resolution/
# https://www.jeffgeerling.com/blog/2019/debugging-networking-issues-multi-node-kubernetes-on-virtualbox


kubectl get pods --namespace=kube-system -l k8s-app=kube-dns
kubectl get svc --namespace=kube-system
kubectl get ep kube-dns --namespace=kube-system
kubectl get ds --namespace=kube-system

less /etc/resolv.conf

#nameserver 10.96.0.10
#search default.svc.cluster.local svc.cluster.local cluster.local
#options ndots:5


kubectl -n kube-system edit configmap coredns
# add "log"
kubectl logs -f -n kube-system -l k8s-app=kube-dns

# calico not ready
kubectl get pods -n kube-system -l k8s-app=calico-node
kubectl logs -f  -n kube-system -l k8s-app=calico-node


# calico/node is not ready: BIRD is not ready: BGP not established


# https://kubernetes.io/docs/tasks/run-application/horizontal-pod-autoscale-walkthrough/




# https://kubernetes.io/docs/concepts/services-networking/service/

kubectl run alpaca-prod \
  --image=registry.cn-shenzhen.aliyuncs.com/cookcodeblog/kuard-amd64:1 \
  --replicas=3 \
  --port=8080 \
  --labels="ver=1,app=alpaca,env=prod"

# create a service
kubectl expose pod alpaca-prod

kubectl run bandicoot-prod \
  --image=registry.cn-shenzhen.aliyuncs.com/cookcodeblog/kuard-amd64:2 \
  --replicas=3 \
  --port=8080 \
  --labels="ver=2,app=bandicoot,env=prod"

kubectl expose pod bandicoot-prod

kubectl get service -o wide

#NAME             TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE     SELECTOR
#alpaca-prod      ClusterIP   10.108.208.184   <none>        8080/TCP   36s     app=alpaca,env=prod,ver=1
#bandicoot-prod   ClusterIP   10.104.14.246    <none>        8080/TCP   19s     app=bandicoot,env=prod,ver=2
#kubernetes       ClusterIP   10.96.0.1        <none>        443/TCP    6d17h   <none>

# kubernetes service is crated by lsb_release

# serivie use Cluster IP

# pod use pod IP
kubectl get pods -o wide

#NAME             READY   STATUS    RESTARTS   AGE     IP               NODE            NOMINATED NODE   READINESS GATES
#alpaca-prod      1/1     Running   0          2m27s   192.168.36.194   k8s-worker-01   <none>           <none>
#bandicoot-prod   1/1     Running   0          101s    192.168.36.195   k8s-worker-01   <none>           <none>


# Node IP, Pod IP, Cluster IP (服务发现，动态路由，负载均衡）

kubectl port-forward alpaca-prod 48858:8080

# can't access 48858 except http://localhost:48858


kubectl describe svc/alpaca-prod
kubectl describe svc/kube-dns -n kube-system


#Name:              alpaca-prod
#Namespace:         default
#Labels:            app=alpaca
#                   env=prod
#                   ver=1
#Annotations:       <none>
#Selector:          app=alpaca,env=prod,ver=1
#Type:              ClusterIP
#IP:                10.108.208.184
#Port:              <unset>  8080/TCP
#TargetPort:        8080/TCP
#Endpoints:         192.168.36.194:8080
#Session Affinity:  None
#Events:            <none>


# Endpoint
kubectl get endpoints

kubectl describe endpoints alpaca-prod

# Publishing a service (从集群外访问服务）








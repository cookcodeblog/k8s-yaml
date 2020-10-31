# https://kubernetes.io/docs/concepts/overview/working-with-objects/labels/
# https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels/


# alpaca-prod
# Flag --replicas has been deprecated, has no effect and will be removed in the future.
kubectl run alpaca-prod \
  --image=registry.cn-shenzhen.aliyuncs.com/cookcodeblog/kuard-amd64:1 \
  --replicas=2 \
  --labels="ver=1,app=alpaca,env=prod"


# alpaca-test
kubectl run alpaca-test \
  --image=registry.cn-shenzhen.aliyuncs.com/cookcodeblog/kuard-amd64:1 \
  --replicas=2 \
  --labels="ver=1,app=alpaca,env=test"


# bandicoot-prod
kubectl run bandicoot-prod \
  --image=registry.cn-shenzhen.aliyuncs.com/cookcodeblog/kuard-amd64:2 \
  --replicas=2 \
  --labels="ver=2,app=bandicoot,env=prod"

# bandicoot-test
kubectl run bandicoot-test \
  --image=registry.cn-shenzhen.aliyuncs.com/cookcodeblog/kuard-amd64:2 \
  --replicas=2 \
  --labels="ver=2,app=bandicoot,env=test"


# show deployment labels
# no deployments in kubernetes v1.19
kubectl get deployments --show-labels

# show pod labels
kubectl get pods --show-labels
kubectl describe pod/alpaca-prod

# add pod label
kubectl label pod alpaca-test "canary=true"
kubectl label pod alpaca-prod "canary=false"

# show label as column
kubectl get pods -L "app,env,ver"

# select pods with ver=2
kubectl get pods --selector="ver=2"

# select pods with app=bandicot and ver=2, and show their labels
kubectl get pods --selector="app=bandicoot,ver=2" --show-labels

# select pods with in condition
kubectl get pods --selector="app in (alpaca,bandicoot)"
kubectl get pods --selector="app notin (alpaca,bandicoot)"

# select pods with canary is any
kubectl get pods --selector="canary"
kubectl get pods --selector="canary" -L canary
kubectl get pods --selector="canary!=true"
kubectl get pods --selector="! canary" --show-labels

# selector operators
#key=value
#key!=value
#key in (value1, value2)
#key notin (value1, value2)
#key
#! key # a space followed by !


# use yaml selector syntax
# Example 1: app=alpaca,ver in (1,2)
selector:
  matchLabel:
    app: alpaca
  matchExpressions:
    - {key: ver, operator: In, value: [1, 2]}

# Example 2: app=alpaca,ver=1
selector:
  app: alpaca
  ver: 1


# 注释 annoations

#1. 如果想通过标签选择器来选择，则使用标签。
#2. 如果标签装不下的复杂信息，使用注释记录。
#3. 注释常用来跟踪滚动部署的rollout状态，方便应用部署的快速回滚。

# delete pods via selector
kubectl get pods --show-labels
kubectl delete pods --selector="app in(alpaca, bandicoot)"



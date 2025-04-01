# create rbac for spark operator
kubectl apply -f sparkapplication-clusterrole.yaml
kubectl apply -f sparkapplication-clusterrolebinding.yaml

# create dockerhub registry secret
kubectl delete secret dockerhub  -n spark-operator
kubectl create secret docker-registry dockerhub \
	--docker-server=dockerhub.dsc.com.vn \
	--docker-username=sync_dwh \
	--docker-password=Admin@123 \
--docker-email=sync_dwh@dsc.com.vn -n spark-operator
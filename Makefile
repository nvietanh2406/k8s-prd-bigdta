sync:
	git add -A 
	git commit -m "update"
	git pull origin master
	git push origin master

deploy-ingress-nginx:
	helm upgrade --install --create-namespace argocd ./helm-charts/ingress-nginx -n ingress-nginx

deploy-argocd:
	helm upgrade --install --create-namespace argocd ./helm-charts/argocd -n argocd

deploy-flannel:
	helm upgrade --install --create-namespace flannel ./helm-charts/flannel -n flannel

deploy-longhorn:
	helm upgrade --install --create-namespace longhorn ./helm-charts/longhorn -n longhorn

argocd-port-forward:
	kubectl port-forward service/argocd-argo-cd-server 3000:80 -n argocd --address='0.0.0.0'

argocd-apps:
	argocd login localhost:3000 --username admin --password 0fyQVm7sC7 --insecure
	argocd app create argocd-apps \
		--name argocd-apps \
		--path ./helm-charts/argocd-apps \
		--dest-namespace argocd-apps \
		--values values.yaml \
		--revision master \
		--self-heal \
		--auto-prune \
		--sync-policy auto \
		--repo https://git.datx.com.vn/datx-k8s/k8s-prod01.git \
		--dest-server https://kubernetes.default.svc \
		--upsert



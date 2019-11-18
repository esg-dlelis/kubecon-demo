create-cluster:
	eksctl create cluster -f exp-cluster.yaml
set-cluster:
	aws eks --region us-west-2 update-kubeconfig --name kubecon-cluster
set-logging:
	kubectl apply -f hepers/cloudwatch/cloudwatch-namespace.yaml
	kubectl apply -f hepers/cloudwatch/cwagent-daemonset.yaml
	kubectl apply -f hepers/cloudwatch/cwagent-serviceaccount.yaml
	kubectl apply -f hepers/cloudwatch/fluentd.yaml

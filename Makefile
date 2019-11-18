create-cluster:
	eksctl create cluster -f exp-cluster.yaml
set-cluster:
	aws eks --region us-west-2 update-kubeconfig --name kubecon-cluster
kb-update-logging:
	kubectl apply -f helpers/cloudwatch/cloudwatch-namespace.yaml
	kubectl apply -f helpers/cloudwatch/cwagent-daemonset.yaml
	kubectl apply -f helpers/cloudwatch/cwagent-serviceaccount.yaml
	kubectl apply -f helpers/cloudwatch/fluentd.yaml
	# Check https://console.aws.amazon.com/support/cases?region=us-west-2#/6565912521/en to modify lambda
	kubectl create configmap cluster-info \
	--from-literal=cluster.name=kubecon-cluster \
	--from-literal=logs.region=us-west-2 -n amazon-cloudwatch
	kubectl apply -f ../../helpers/cloudwatch/fluentd.yaml
install-metrics-server:
	cd helpers/metrics-server/install-metrics-server.sh
kb-create-cluster-autoscaler:
	kubectl apply -f autoscaling/cluster-autoscaler-autodiscover.yaml
kb-create-alb:
	kubectl apply -f alb/alb-ingress-controller.yaml

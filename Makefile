create-cluster:
	eksctl create cluster -f exp-cluster.yaml
set-cluster:
	aws eks --region us-west-2 update-kubeconfig --name eks-exp
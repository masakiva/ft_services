#!/bin/bash

install_minikube()
{
	curl -LO https://github.com/kubernetes/minikube/releases/download/v1.17.1/minikube-linux-amd64
	sudo install minikube-linux-amd64 /usr/local/bin/minikube
	rm minikube-linux-amd64
}

install_kubectl()
{
	curl -LO https://dl.k8s.io/release/v1.20.2/bin/linux/amd64/kubectl
	sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
	rm kubectl
}

docker version > /dev/null
if ! command -v minikube &> /dev/null
then
	echo 'Minikube not found'
	echo 'Installing Minikube...'
	install_minikube
elif [[ `minikube version | grep -Po '(?<=minikube version: v)[\d.]+'` != '1.17.1' ]]
then
	echo 'Minikube version is not 1.17.1'
	echo 'Updating Minikube...'
	minikube delete
	install_minikube
fi

echo
echo 'Starting Minikube...'
minikube start --driver=docker

if command -v service && [[ `service nginx status | grep -Po '(?<=Active: )[[:lower:]]+'` == 'active' ]]
then
	echo
	echo 'Stopping currently running nginx server...'
	sudo service nginx stop
fi

if [[ `kubectl version --client --short | grep -Po '(?<=Client Version: v)[\d.]+'` != '1.20.2' ]]
then
	echo
	echo 'kubectl version is not 1.20.2'
	echo 'Updating kubectl...'
	install_kubectl
fi

echo
echo 'Installing MetalLB load-balancer...'
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
if [[ `kubectl -n metallb-system get secrets | grep -qP 'memberlist\s+Opaque' ; echo $?` == '1' ]]
then
	kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
fi

eval $(minikube -p minikube docker-env)

MINIKUBE_IP=`kubectl get node -o=custom-columns='DATA:status.addresses[0].address' | sed -n 2p`
sed -i.backup "s/MINIKUBE_EXTERNAL_IP/$MINIKUBE_IP/g" srcs/metallb-config.yaml

kubectl apply -f srcs/metallb-config.yaml

docker build -t nginx-image:1.0 srcs/nginx
kubectl apply -f srcs/nginx.yaml

mv -f srcs/{metallb-config.yaml.backup,metallb-config.yaml}

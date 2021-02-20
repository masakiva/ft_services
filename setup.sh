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

if [[ `minikube &> /dev/null ; echo $?` == '127' ]]
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
echo
echo 'Enabling MetalLB Minikube addon...'
minikube addons enable metallb

if [[ `service nginx status | grep -Po '(?<=Active: )[[:lower:]]+'` == 'active' ]]
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

eval $(minikube docker-env)

#docker build -t nginx-image:1.0 nginx

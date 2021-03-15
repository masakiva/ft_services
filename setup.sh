#!/bin/bash

MINIKUBE_VERSION=1.18.1
KUBECTL_VERSION=1.20.2

install_minikube()
{
	curl -LO https://github.com/kubernetes/minikube/releases/download/v$MINIKUBE_VERSION/minikube-linux-amd64
	sudo install minikube-linux-amd64 /usr/local/bin/minikube
	rm minikube-linux-amd64
}

install_kubectl()
{
	curl -LO https://dl.k8s.io/release/v$KUBECTL_VERSION/bin/linux/amd64/kubectl
	sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
	rm kubectl
}

### WAKE UP DOCKER DAEMON
docker version > /dev/null

### UPDATE MINIKUBE
if ! command -v minikube &> /dev/null
then
	echo 'Minikube not found'
	echo 'Installing Minikube...'
	install_minikube
elif [[ `minikube version | grep -Po '(?<=minikube version: v)[\d.]+'` != "$MINIKUBE_VERSION" ]]
then
	echo "Minikube version is not $MINIKUBE_VERSION"
	echo 'Updating Minikube...'
	minikube delete
	install_minikube
fi

### START MINIKUBE CLUSTER
echo
echo 'Starting Minikube...'
minikube start --driver=docker

### WE'LL NEED TO USE 80 AND 443 PORTS
if command -v service &> /dev/null && [[ `service nginx status | grep -Po '(?<=Active: )[[:lower:]]+'` == 'active' ]]
then
	echo
	echo 'Stopping currently running nginx server...'
	sudo service nginx stop
fi

### KUBECTL VERSION
if [[ `kubectl version --client --short | grep -Po '(?<=Client Version: v)[\d.]+'` != "$KUBECTL_VERSION" ]]
then
	echo
	echo "kubectl version is not $KUBECTL_VERSION"
	echo 'Updating kubectl...'
	install_kubectl
fi

### METALLB ADDON
echo
echo 'Installing MetalLB load-balancer...'
if [[ `minikube addons list | grep metallb | grep -oP '(enabled|disabled)'` == 'enabled' ]]
then
	minikube addons disable metallb
fi
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.5/manifests/metallb.yaml
if [[ `kubectl -n metallb-system get secrets | grep -qP 'memberlist\s+Opaque' ; echo $?` == '1' ]]
then
	kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
fi

### SWITCH DOCKER ENVIRONMENT TO MINIKUBE'S
eval $(minikube -p minikube docker-env)

### GET EXTERNAL IP GIVEN BY MINIKUBE
MINIKUBE_IP=`kubectl get node -o=custom-columns='DATA:status.addresses[0].address' | sed -n 2p`
sed -i.backup "s/MINIKUBE_EXTERNAL_IP/$MINIKUBE_IP/g" srcs/metallb-config.yaml

kubectl apply -f srcs/metallb-config.yaml
mv -f srcs/{metallb-config.yaml.backup,metallb-config.yaml}

docker build -t nginx-image:1.0 srcs/nginx
kubectl apply -f srcs/nginx.yaml

docker build -t mysql-image:1.0 srcs/mysql
kubectl apply -f srcs/mysql.yaml

docker build -t phpmyadmin-image:1.0 srcs/phpmyadmin
kubectl apply -f srcs/phpmyadmin.yaml

docker build -t wordpress-image:1.0 srcs/wordpress
kubectl apply -f srcs/wordpress.yaml

docker build -t influxdb-image:1.0 srcs/influxdb
kubectl apply -f srcs/influxdb.yaml

docker build -t grafana-image:1.0 srcs/grafana
kubectl apply -f srcs/grafana.yaml

sed -i.backup "s/MINIKUBE_EXTERNAL_IP/$MINIKUBE_IP/g" srcs/ftps/vsftpd.conf
docker build -t ftps-image:1.0 srcs/ftps
kubectl apply -f srcs/ftps.yaml
mv -f srcs/ftps/{vsftpd.conf.backup,vsftpd.conf}

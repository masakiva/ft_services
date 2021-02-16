#!/bin/bash

minikube addons list |;
https://stackoverflow.com/questions/57821066/how-to-update-minikube-latest-version

eval $(minikube docker-env)

docker build -t nginx-image nginx

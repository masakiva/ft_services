# ft_services

`ft_services` is a system administration project that involves deploying a cluster of containerized services using Kubernetes. The goal of the project is to gain a deeper understanding of how containerization and orchestration work, as well as to become familiar with Kubernetes.

The services that are deployed in the cluster include Nginx, Wordpress, PhpMyAdmin, Grafana, MySQL, and FTPS. Each service is deployed as a separate container and is configured to work together to form a functional web application.

## Project Structure

The `ft_services` project is divided into several sub-projects, each of which focuses on a specific aspect of Kubernetes and containerization. Here are the sub-projects that are included:

- `srcs`: This directory contains the source code for the various services that are deployed in the cluster, including Nginx, Wordpress, PhpMyAdmin, Grafana, InfluxDB, MySQL, and FTPS.

- `setup.sh`: This script is used to set up the Kubernetes cluster and deploy the various services. It uses the `minikube` tool to create a local Kubernetes cluster and then deploys the services using a series of YAML files.

### Getting Started

To get started with the project, you can clone this repository and navigate to the project directory:

```
git clone https://github.com/masakiva/ft_services.git
cd ft_services
```

You can then run the `setup.sh` script to set up the Kubernetes cluster and deploy the services:

```
sh setup.sh
```

This will create a local Kubernetes cluster using `minikube` and deploy the various services using the YAML files in the `srcs` directory.

### Resources

Here are some resources that you may find useful when working on this project:

- [Kubernetes Documentation](https://kubernetes.io/docs/home/)
- [Docker Documentation](https://docs.docker.com/)
- [minikube Documentation](https://minikube.sigs.k8s.io/docs/start/)
- [nginx Documentation](https://nginx.org/en/docs/)
- [WordPress Documentation](https://wordpress.org/support/)
- [PhpMyAdmin Documentation](https://docs.phpmyadmin.net/en/latest/)
- [Grafana Documentation](https://grafana.com/docs/)
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [vsftpd Documentation](https://security.appspot.com/vsftpd.html)

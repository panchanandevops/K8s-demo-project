# My Kubernetes Project 🚀

Welcome to the documentation for My Kubernetes Project. This project deploys MongoDB and Mongo Express on Kubernetes using various deployment methods.

## Prerequisites ⚙️

Before you begin, ensure you have the following tools installed:

- [Docker](https://docs.docker.com/get-docker/) 
  ```bash
  sudo apt update
  sudo apt install docker.io
  ```

- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) 
  ```bash
  sudo apt install kubectl
  ```

- [Helm](https://helm.sh/docs/intro/install/) 
  ```bash
  sudo snap install helm --classic
  ```

- [curl](https://curl.se/download.html) 
  ```bash
  sudo apt install curl
  ```

- [k3d](https://k3d.io/#installation) 
  ```bash
  curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
  ```

- [nginx-ingress-controller](https://kubernetes.github.io/ingress-nginx/deploy/) 
  ```bash
  kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml
  ```

## Usage and Further Instructions 📘

For detailed usage instructions and additional information, refer to the README files in the respective directories:

### Helm Charts 📈

Navigate to the [Helm Chart README](helm-chart/README.md) in the `helm-chart` directory for comprehensive guidance on deploying MongoDB and Mongo Express using Helm charts.

### Kustomize 🛠️

Explore the [Kustomize README](kustomize/README.md) in the `kustomize` directory for details on customization and deployment using Kustomize.

Make sure to check these directories for more comprehensive guidance on deploying and customizing MongoDB and Mongo Express using Helm charts and Kustomize.

## Acknowledgment 🙏

Special thanks to **Nana Janashia** for her valuable guidance and teachings. You can find her on [Techworld with Nana](https://www.youtube.com/c/techworldwithnana).


# Helm Charts for MongoDB and Mongo Express

Welcome to the Helm charts directory for deploying MongoDB and Mongo Express on Kubernetes. These Helm charts are designed to simplify the deployment and management of MongoDB, a robust NoSQL database, and Mongo Express, a web-based MongoDB admin interface.

## MongoDB Helm Chart

### `values.yaml`

- **replicaCount:** Specifies the desired number of MongoDB replicas. Default is set to 1.
- **image:** Defines the Docker image details for MongoDB, including repository, tag, and pull policy.
- **mongodbUsername, mongodbPassword, mongodbDatabase:** Credentials and database details.
- **service:** Configuration for the MongoDB service, including port settings.
- **configmap:** Configuration for the MongoDB ConfigMap, specifying the database URL.
- **secrets:** Configuration for the MongoDB Secrets, storing sensitive information.

### `Chart.yaml`

- Metadata about the Helm chart, such as its name, version, and description.

### `configmap.yaml`

- Kubernetes ConfigMap definition for MongoDB, taking values from `values.yaml`.

### `deployment.yaml`

- Kubernetes Deployment definition for MongoDB, specifying replicas, containers, and environment variables.

### `secrets.yaml`

- Kubernetes Secret definition for MongoDB, securely storing sensitive information.

### `service.yaml`

- Kubernetes Service definition for MongoDB, exposing the MongoDB deployment within the cluster.

## Mongo Express Helm Chart

### `values.yaml`

- **replicaCount:** Specifies the desired number of Mongo Express replicas. Default is set to 1.
- **image:** Defines the Docker image details for Mongo Express, including repository, tag, and pull policy.
- **service:** Configuration for the Mongo Express service, including type and port settings.
- **ingress:** Configuration for Ingress, specifying the host, path, and class.

### `Chart.yaml`

- Metadata about the Helm chart, such as its name, version, and description.

### `deployment.yaml`

- Kubernetes Deployment definition for Mongo Express, specifying replicas, containers, and environment variables.

### `ingress.yaml`

- Kubernetes Ingress definition for Mongo Express, exposing the service to external traffic.

### `service.yaml`

- Kubernetes Service definition for Mongo Express, defining type, ports, and selector.

## Deploying to prod namespace

To deploy the Helm charts in the **prod namespace**, execute the following commands:

1. Install MongoDB Helm chart:

```bash
helm install mongo-release ./MongoDB-helm --namespace prod
```

2. Install Mongo Express Helm chart:

```bash
helm install mongo-express-release ./Mongo-Express-helm --namespace prod
```

Make sure Helm is installed and properly configured on your system before running these commands. Adjust the release names or paths as needed for your environment.



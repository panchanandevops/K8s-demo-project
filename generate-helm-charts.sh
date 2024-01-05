#!/bin/bash

# Function to create the MongoDB Helm chart
generate_mongodb_chart() {
  mkdir -p MongoDB-helm
  cat > MongoDB-helm/Chart.yaml <<EOL
apiVersion: v2
name: mongodb
description: A Helm chart for MongoDB
version: 0.1.0
EOL

  cat > MongoDB-helm/values.yaml <<EOL
replicaCount: 1

image:
  repository: mongo
  tag: latest
  pullPolicy: IfNotPresent

mongodbUsername: admin
mongodbPassword: adminpassword
mongodbDatabase: mydatabase

service:
  name: mongodb-service
  ports:
    - protocol: TCP
      port: 27017
      targetPort: 27017

configmap:
  name: mongodb-configmap
  databaseUrl: mongodb-service

secrets:
  name: mongodb-secret
  username: admin
  password: adminpassword
EOL

  mkdir -p MongoDB-helm/templates
  cat > MongoDB-helm/templates/deployment.yaml <<EOL
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Values.deployment.name }}
  labels:
    app: {{ .Values.deployment.app }}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      app: {{ .Values.deployment.app }}
  template:
    metadata:
      labels:
        app: {{ .Values.deployment.app }}
    spec:
      containers:
      - name: {{ .Values.container.name }}
        image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
        ports:
          - containerPort: {{ .Values.container.port }}
        env:
          - name: {{ .Values.env.username }}
            valueFrom:
              secretKeyRef:
                name: {{ .Values.secrets.name }}
                key: {{ .Values.env.username }}
          - name: {{ .Values.env.password }}
            valueFrom:
              secretKeyRef:
                name: {{ .Values.secrets.name }}
                key: {{ .Values.env.password }}
EOL

  cat > MongoDB-helm/templates/service.yaml <<EOL
apiVersion: v1
kind: Service
metadata:
  name: {{ .Values.service.name }}
spec:
  selector:
    app: {{ .Values.deployment.app }}
  ports:
    - protocol: TCP
      port: {{ .Values.service.ports.port }}
      targetPort: {{ .Values.service.ports.targetPort }}
EOL

  cat > MongoDB-helm/templates/configmap.yaml <<EOL
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .Values.configmap.name }}
data:
  database_url: {{ .Values.configmap.databaseUrl }}
EOL

  cat > MongoDB-helm/templates/secrets.yaml <<EOL
apiVersion: v1
kind: Secret
metadata:
  name: {{ .Values.secrets.name }}
  type: Opaque
data:
  mongo-root-username: {{ .Values.secrets.username | b64enc | quote }}
  mongo-root-password: {{ .Values.secrets.password | b64enc | quote }}
EOL

  echo "MongoDB Helm chart created successfully in MongoDB-helm directory."
}

# Function to create the Mongo Express Helm chart
generate_mongoexpress_chart() {
  mkdir -p Mongo-Express-helm
  cat > Mongo-Express-helm/Chart.yaml <<EOL
apiVersion: v2
name: mongoexpress
description: A Helm chart for Mongo Express
version: 0.1.0
EOL

  cat > Mongo-Express-helm/values.yaml <<EOL
replicaCount: 1

image:
  repository: mongo-express
  tag: latest
  pullPolicy: IfNotPresent

service:
  name: mongo-express-service
  type: LoadBalancer
  ports:
    - protocol: TCP
      port: 8081
      targetPort: 8081

ingress:
  enabled: true
  host: app.com
  path: /
  ingressClassName: nginx
  name: mongoexpress-ingress
EOL

  mkdir -p Mongo-Express-helm/templates
  cat > Mongo-Express-helm/templates/deployment.yaml <<EOL
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Values.deployment.name }}
  labels:
    app: {{ .Values.deployment.app }}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      app: {{ .Values.deployment.app }}
  template:
    metadata:
      labels:
        app: {{ .Values.deployment.app }}
    spec:
      containers:
      - name: {{ .Values.container.name }}
        image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
        ports:
          - containerPort: {{ .Values.container.port }}
        env:
          - name: {{ .Values.env.username }}
            valueFrom:
              secretKeyRef:
                name: {{ .Values.secrets.name }}
                key: {{ .Values.env.username }}
          - name: {{ .Values.env.password }}
            valueFrom:
              secretKeyRef:
                name: {{ .Values.secrets.name }}
                key: {{ .Values.env.password }}
          - name: {{ .Values.env.server }}
            valueFrom:
              configMapKeyRef:
                name: {{ .Values.configmap.name }}
                key: {{ .Values.env.server }}
EOL

  cat > Mongo-Express-helm/templates/service.yaml <<EOL
apiVersion: v1
kind: Service
metadata:
  name: {{ .Values.service.name }}
spec:
  selector:
    app: {{ .Values.deployment.app }}
  type: {{ .Values.service.type }}
  ports:
    - protocol: TCP
      port: {{ .Values.service.ports.port }}
      targetPort: {{ .Values.service.ports.targetPort }}
  {{- if eq .Values.service.type "LoadBalancer" }}
  nodePort: {{ .Values.service.ports.nodePort }}
  {{- end }}
EOL

  cat > Mongo-Express-helm/templates/ingress.yaml <<EOL
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ .Values.ingress.name }}
  annotations:
    kubernetes.io/ingress.class: {{ .Values.ingress.ingressClassName | quote }}
spec:
  rules:
    - host: {{ .Values.ingress.host }}
      http:
        paths:
          - path: {{ .Values.ingress.path }}
            pathType: Prefix
            backend:
              serviceName: {{ .Values.service.name }}
              servicePort: {{ .Values.service.ports.port }}
EOL

  echo "Mongo Express Helm chart created successfully in Mongo-Express-helm directory."
}

# Run functions to generate Helm charts
generate_mongodb_chart
generate_mongoexpress_chart

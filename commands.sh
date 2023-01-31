#!/bin/bash

env="$1"

# creating users
docker run --rm --entrypoint htpasswd registry:2.6.2 -Bbn myuser mypasswd > registry/auth/htpasswd

# certificate generation
openssl req -x509 -newkey rsa:4096 -days 365 -nodes -sha256 -keyout registry/certs/tls.key -out registry/certs/tls.crt -subj "/CN=private-registry" -addext "subjectAltName = DNS:private-registry"

kubectl create secret tls certs-secret --cert=registry/certs/tls.crt --key=registry/certs/tls.key
# secret for users
kubectl create secret generic auth-secret --from-file=registry/auth/htpasswd

#pvc creation
kubectl apply -f registry/pvc.yaml

# create registry pod
kubectl apply -f registry/registry.yaml

# ingress traffic
kubectl apply -f registry/ingress.yaml

# docker build image and push to local registry
cd app && docker build -t private-registry/python-web .

echo "environment: $env"
# running the app using helm
cd ../web && helm install -f values-"$1".yaml --generate-name .

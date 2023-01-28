#!/bin/bash

# creating users
docker run --rm --entrypoint htpasswd registry:2.6.2 -Bbn myuser mypasswd > registry/auth/htpasswd

# certificate generation
openssl req -x509 -newkey rsa:4096 -days 365 -nodes -sha256 -keyout registry/certs/tls.key -out registry/certs/tls.crt -subj "/CN=docker-registry" -addext "subjectAltName = DNS:docker-registry"


kubectl create secret tls certs-secret --cert=registry/certs/tls.crt --key=registry/certs/tls.key
# secret for users
kubectl create secret generic auth-secret --from-file=registry/auth/htpasswd

#pvc creation
kubectl apply -f registry/pvc.yaml

# create registry pod
kubectl apply -f registry/registry.yaml
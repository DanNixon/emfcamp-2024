#!/bin/sh

{
  echo "#"
  echo "# This is a generated file!"
  echo "#"
  echo

  curl https://raw.githubusercontent.com/traefik/traefik/v3.0/docs/content/reference/dynamic-configuration/kubernetes-crd-definition-v1.yml

  helm template \
    traefik \
    traefik \
    --repo https://helm.traefik.io/traefik \
    --version "28.0.0" \
    --namespace traefik \
    --values src/values.yml \
    --kube-version "v1.29"

  cat src/k8s/*.yml
} > rendered.yml

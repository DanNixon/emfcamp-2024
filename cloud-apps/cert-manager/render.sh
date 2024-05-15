#!/bin/sh

{
  echo "#"
  echo "# This is a generated file!"
  echo "#"
  echo

  helm template \
    cert-manager \
    cert-manager \
    --repo https://charts.jetstack.io \
    --version "1.14.5" \
    --namespace cert-manager \
    --values src/values.yml \
    --kube-version "v1.29"

  cat src/k8s/*.yml
} > rendered.yml

#!/bin/sh

{
  echo "#"
  echo "# This is a generated file!"
  echo "#"
  echo

  helm template \
    prometheus \
    prometheus \
    --repo https://prometheus-community.github.io/helm-charts \
    --version "25.21.0" \
    --namespace monitoring-metrics \
    --values src/values.yml \
  | vals ksdecode -f -

  cat src/k8s/*.yml
} > rendered.yml

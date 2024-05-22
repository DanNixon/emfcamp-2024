#!/bin/sh

{
  echo "#"
  echo "# This is a generated file!"
  echo "#"
  echo

  helm template \
    loki \
    loki \
    --repo https://grafana.github.io/helm-charts \
    --version "6.6.1" \
    --namespace monitoring-logs \
    --values src/values/loki.yml \
    --kube-version "1.29"

  helm template \
    promtail \
    promtail \
    --repo https://grafana.github.io/helm-charts \
    --version "6.15.5" \
    --namespace monitoring-logs \
    --values src/values/promtail.yml

  cat src/k8s/*.yml
} > rendered.yml

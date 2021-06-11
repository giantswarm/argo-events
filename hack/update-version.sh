#! /bin/bash

echo "Updating templates using latest stable argo-events version..."
USED_VER="${VERSION:-stable}"

sed -i "s/stable/$USED_VER/" manifests/bases/kustomization.yaml
kubectl kustomize manifests/namespaced > helm/argo-events/templates/resources.yaml
git checkout -- manifests/bases/kustomization.yaml


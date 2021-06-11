#! /bin/bash

USED_VER="${VERSION:-stable}"
echo "Updating templates using argo-events version $USED_VER..."

sed -i "s/stable/$USED_VER/" manifests/bases/kustomization.yaml
kubectl kustomize manifests/namespaced > helm/argo-events/templates/resources.yaml
git checkout -- manifests/bases/kustomization.yaml


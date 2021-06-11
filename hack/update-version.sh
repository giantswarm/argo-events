#! /bin/bash

USED_VER="${VERSION:-stable}"
echo "Updating templates using argo-events version $USED_VER..."

sed -i "s/stable/$USED_VER/" manifests/bases/kustomization.yaml
echo "# This is an auto-generated file. DO NOT EDIT" > helm/argo-events/templates/resources.yaml
echo "# VERSION=$USED_VER" >> helm/argo-events/templates/resources.yaml
kubectl kustomize manifests/namespaced >> helm/argo-events/templates/resources.yaml
git checkout -- manifests/bases/kustomization.yaml


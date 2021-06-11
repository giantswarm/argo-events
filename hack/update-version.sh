#! /bin/bash

USED_VER="${VERSION:-stable}"
CRD_FILE=helm/argo-events/crds/crds.yaml
RESOURCE_FILE=helm/argo-events/templates/resources.yaml
TMP_FILE=/tmp/argo-events-$USED_VER.yaml

echo "Updating templates using argo-events version $USED_VER..."

sed -i "s/stable/$USED_VER/" manifests/bases/kustomization.yaml
kubectl kustomize manifests/namespaced > $TMP_FILE

echo "# This is an auto-generated file. DO NOT EDIT" > $CRD_FILE
echo "# VERSION=$USED_VER" >> $CRD_FILE
cat $TMP_FILE | yq -y 'select(.kind == "CustomResourceDefinition")' >> $CRD_FILE

echo "# This is an auto-generated file. DO NOT EDIT" > $RESOURCE_FILE
echo "# VERSION=$USED_VER" >> $RESOURCE_FILE
cat $TMP_FILE | yq -y 'select(.kind != "CustomResourceDefinition")' >> $RESOURCE_FILE

git checkout -- manifests/bases/kustomization.yaml

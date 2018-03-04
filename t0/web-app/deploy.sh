#!/bin/sh

gcloud container clusters get-credentials "${INPUT_cluster_name}" --zone "${INPUT_cluster_zone}"

# setup namespace
# NB in reality we would consume a namespace for deploying an app
kubectl get namespaces

# TODO deploy app here

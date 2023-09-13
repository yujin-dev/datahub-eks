set dotenv-load

default:
  just --list

kind-up:
  ./kind.sh create

kind-down:
  ./kind.sh delete

kind-config:
  kind get kubeconfig --name datahub > .kubeconfig

create-secret:
  kubectl create secret generic postgresql-secrets --from-literal=postgres-password=datahub

add-helm:
  helm repo add datahub https://helm.datahubproject.io/

prep-install:
  helm install prerequisites datahub/datahub-prerequisites --values ./prerequisites/values.yaml

prep-update:
  helm upgrade prerequisites datahub/datahub-prerequisites --values ./prerequisites/values.yaml

prep-delete:
  helm delete prerequisites

datahub-deps:
  helm dependency build ./datahub

datahub-install:
  helm install datahub ./datahub --values ./datahub/values.yaml

datahub-update:
	helm upgrade datahub ./datahub -f ./datahub/values.yaml

datahub-delete:
  helm delete datahub
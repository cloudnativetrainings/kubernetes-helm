# Helmfile

In this lab you will learn how to make use of the tool helmfile which allows you to do releases in a declarative way.

Helmfile does to helm what docker-compose did to docker.

## Release a monitoring stack

```bash
# release the first training application
helmfile sync --file /workspaces/kubernetes-helm/13_helmfile/helm/helmfile.yaml --selector id=training-application-1

# release the second training application
helmfile sync --file /workspaces/kubernetes-helm/13_helmfile/helm/helmfile.yaml --selector id=training-application-2
```

## Verify

```bash
# via helm
helm ls --all-namespaces

# via kubectl
kubectl -n training-application-1 get all
kubectl -n training-application-2 get all
```

## Teardown

```bash
helmfile destroy --file /workspaces/kubernetes-helm/13_helmfile/helm/helmfile.yaml 
```

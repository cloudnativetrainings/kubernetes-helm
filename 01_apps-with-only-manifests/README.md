# Create the applications

## Manifests

Check the manifests:

```bash
cd /workspaces/kubernetes-helm/01_apps-with-only-manifests

tree .
```

## Create the blue app on Development environment

```bash
kubectl create ns dev
kubectl create -f dev/blue
```

Check the status of the pods and see the blue pod running:

```bash
kubectl get pods -n dev
```

Afterwards, you can visit the app via curl:

```bash
curl http://${INGRESS_IP}/dev/blue
```

Or, reach via below URLs:

> Note port-forwarding still has to happen for this to work.

```bash
echo "https://${CODESPACE_NAME}-8080.app.github.dev/dev/blue"
```

## Create the red app on Development environment

```bash
kubectl create -f dev/red
```

Check the status of the pods and see the red and blue pods running:

```bash
kubectl get pods -n dev
```

Afterwards, you can visit the app via curl:

```bash
curl http://${INGRESS_IP}/dev/red
```

Or, reach via below URLs:

> Note port-forwarding still has to happen for this to work.

```bash
echo "https://${CODESPACE_NAME}-8080.app.github.dev/dev/red"
```

## Create the blue app on Production

```bash
kubectl create ns prod
kubectl create -f prod/blue
```

Check the status of the pods and see 3 blue pods running:

```bash
kubectl get pods -n prod
```

Afterwards, you can visit the app via curl:

```bash
curl http://${INGRESS_IP}/prod/blue
```

Or, reach via below URLs:

> Note port-forwarding still has to happen for this to work.

```bash
echo "https://${CODESPACE_NAME}-8080.app.github.dev/prod/blue"
```

## Create the red app on Production

```bash
kubectl create -f prod/red
```

Check the status of the pods and see 3 red and 3 blue pods running:

```bash
kubectl get pods -n prod
```

Afterwards, you can visit the app via curl:

```bash
curl http://${INGRESS_IP}/prod/red
```

Or, reach via below URLs:

> Note port-forwarding still has to happen for this to work.

```bash
echo "https://${CODESPACE_NAME}-8080.app.github.dev/prod/red"
```

## How long will it take to make a green app on both environments?

## Cleanup

```bash
# delete the created resources
kubectl delete -f dev/**,prod/**
```

# Create the applications

## Manifests

> `INGRESS_IP` environment variable is supposed to be set during the setup. You can always set it this way:
>
> ```bash
> export INGRESS_IP=$(kubectl get svc ingress-nginx-controller -n ingress-nginx -o jsonpath='{.status.loadBalancer.ingress[].ip}')
> ```

Check the manifests:

```bash
cd /workspaces/helm/01_apps-with-only-manifests

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

If you want to reach it via browser, you first need to port-forward ingress-nginx-controller service:

```bash
kubectl port-forward svc/ingress-nginx-controller -n ingress-nginx 80
```

Then, reach via below URLs:

```bash
echo "https://${CODESPACE_NAME}-80.app.github.dev/dev/blue"
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

If you want to reach it via browser, you first need to port-forward ingress-nginx-controller service:

```bash
kubectl port-forward svc/ingress-nginx-controller -n ingress-nginx 80
```

Then, reach via below URLs:

```bash
echo "https://${CODESPACE_NAME}-80.app.github.dev/dev/red"
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

If you want to reach it via browser, you first need to port-forward ingress-nginx-controller service:

```bash
kubectl port-forward svc/ingress-nginx-controller -n ingress-nginx 80
```

Then, reach via below URLs:

```bash
echo "https://${CODESPACE_NAME}-80.app.github.dev/prod/blue"
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

If you want to reach it via browser, you first need to port-forward ingress-nginx-controller service:

```bash
kubectl port-forward svc/ingress-nginx-controller -n ingress-nginx 80
```

Then, reach via below URLs:

```bash
echo "https://${CODESPACE_NAME}-80.app.github.dev/prod/red"
```

## How long will it take to make a green app on both environments?

## Cleanup

```bash
# delete the created resources
kubectl delete -f dev/**,prod/**
```

# Apps with Helm

In this task, we will use Helm for installing the app.

> `INGRESS_IP` environment variable is supposed to be set during the setup. You can always set it this way:
>
> ```bash
> export INGRESS_IP=$(kubectl get svc ingress-nginx-controller -n ingress-nginx -o jsonpath='{.status.loadBalancer.ingress[].ip}')
> ```

## Using a Helm Chart without customization

### Inspect the Helm Chart

```bash
cd /workspaces/helm/03_apps-with-helm
tree color-viewer
```

You will see 2 important files and a directory with manifests.

- Chart.yaml: Contains information about the chart
- values.yaml: Contains customizable values to be used in templates
- templates/\*.yaml: Manifest files with some go templating to be customized

Check the default values of the chart:

```bash
cat color-viewer/values.yaml
```

### Show all installed Helm Releases

```bash
helm ls
```

## Check the templating result

This command will show which manifest files will be deployed with default values:

```bash
helm template ./color-viewer
```

Change a value and check again:

```bash
helm template ./color-viewer --set replicas=3
```

## Deploy dev

Deploy your application with Helm:

```bash
helm install demo-app ./color-viewer --namespace=dev --create-namespace
```

Checkout the status of the installation:

```bash
helm ls -A
```

Checkout the pods and verify that the application is running:

```bash
# Wait until the pod is ready:
kubectl get pods -n dev

curl http://${INGRESS_IP}/dev
```

If you want to reach it via browser, you first need to port-forward ingress-nginx-controller service:

```bash
kubectl port-forward svc/ingress-nginx-controller -n ingress-nginx 80
```

Then, reach via below URLs:

```bash
echo "https://${CODESPACE_NAME}-80.app.github.dev/dev"
```

## Deploy prod

Checkout the values for production:

```bash
cat prod-values.yaml
```

Deploy your application with Helm:

```bash
helm install demo-app ./color-viewer --namespace=prod --create-namespace -f prod-values.yaml
```

Checkout the status of the installation:

```bash
helm ls -A
```

Checkout the pods and verify that the application is running. There must be 3 pods running.

```bash
# Wait until the pod is ready:
kubectl get pods -n prod

curl http://${INGRESS_IP}/prod
```

If you want to reach it via browser, you first need to port-forward ingress-nginx-controller service:

```bash
kubectl port-forward svc/ingress-nginx-controller -n ingress-nginx 80
```

Then, reach via below URLs:

```bash
echo "https://${CODESPACE_NAME}-80.app.github.dev/prod"
```

### Cleanup

```bash
# delete the releases
helm uninstall demo-app -n dev
helm uninstall demo-app -n prod
```

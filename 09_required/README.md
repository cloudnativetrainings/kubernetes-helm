# Using the 'required' Function

In this task, you will learn how to use the 'required' function.

> `INGRESS_IP` environment variable is supposed to be set during the setup. You can always set it this way:
>
> ```bash
> export INGRESS_IP=$(kubectl get svc ingress-nginx-controller -n ingress-nginx -o jsonpath='{.status.loadBalancer.ingress[].ip}')
> ```

## Inspect the Helm Chart

```bash
cd /workspaces/helm/09_required
tree .
```

## Adapt the Deployment to the following

Edit `./my-chart/templates/deployment.yaml` file:
```yaml
...
containers:
   - name: my-nginx
     image: nginx:{{ required "A nginx version is required!" .Values.tag }}
...
```

## Release the application

> Note that you will get an error message.
```bash
helm install required ./my-chart 
```

Try again with the tag provided.
```bash
helm install required ./my-chart --set tag=1.19.2
```

Wait until the pods are ready

```bash
kubectl wait pod -l app.kubernetes.io/instance=required --for=condition=ready --timeout=120s
```

Access the endpoint via 
```bash
curl ${INGRESS_IP}
```

If you want to reach it via browser, you first need to port-forward ingress-nginx-controller service:

```bash
kubectl port-forward svc/ingress-nginx-controller -n ingress-nginx 80
```

Then, reach via below URLs:

```bash
echo "https://${CODESPACE_NAME}-80.app.github.dev/"
```

## Cleanup

```bash
# delete the resources
helm uninstall required
```

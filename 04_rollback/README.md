# Rolling back a release

In this task, we will rollback a release.

## Inspect the Helm Chart

```bash
cd /workspaces/kubernetes-helm/04_rollback

tree color-viewer

cat color-viewer/values.yaml
```

## Release the red app

```bash
helm install my-app ./color-viewer
```

Access the page via curl:

```bash
curl http://${INGRESS_IP}/red
```

If you want to reach it via browser, you first need to port-forward ingress-nginx-controller service:

```bash
# TODO kubectl port-forward svc/ingress-nginx-controller -n ingress-nginx 8080:80
```

Then, reach via below URLs:

```bash
echo "https://${CODESPACE_NAME}-8080.app.github.dev/red"
```

## Upgrade the red app

```bash
helm upgrade my-app --set color=blue ./color-viewer
```

You can visit the app on `http://${INGRESS_IP}/blue`

Take a look at the Helm releases

```bash
helm ls
```

## History and changes

Take a look at the history of my-app

```bash
helm history my-app
```

Check the values on this current release:

```bash
helm get values my-app --all
```

Previous release:

```bash
helm get values my-app --all --revision 1
```

## Rollback

Rollback to the first revision

```bash
helm rollback my-app 1
```

Check the history again

```bash
helm history my-app
```

Access the page via curl:

```bash
curl http://${INGRESS_IP}/red
```

If you want to reach it via browser, you first need to port-forward ingress-nginx-controller service:

```bash
# TODO kubectl port-forward svc/ingress-nginx-controller -n ingress-nginx 8080:80
```

Then, reach via below URLs:

```bash
echo "https://${CODESPACE_NAME}-8080.app.github.dev/red"
```

## Cleanup

```bash
# delete the resources
helm uninstall my-app
```

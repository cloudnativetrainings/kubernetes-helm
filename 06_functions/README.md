# Functions

In this task, you will learn how to implement helper functions.

> `INGRESS_IP` environment variable is supposed to be set during the setup. You can always set it this way:
>
> ```bash
> export INGRESS_IP=$(kubectl get svc ingress-nginx-controller -n ingress-nginx -o jsonpath='{.status.loadBalancer.ingress[].ip}')
> ```

## Run the Helm Chart

```bash
cd /workspaces/helm/06_functions
helm install my-app ./my-chart
```

Wait until the pods are ready

```bash
kubectl wait pod -l app=my-chart-my-app --for=condition=ready --timeout=120s
```

Access the endpoint via

```bash
curl http://${INGRESS_IP}
```

If you want to reach it via browser, you first need to port-forward ingress-nginx-controller service:

```bash
kubectl port-forward svc/ingress-nginx-controller -n ingress-nginx 80
```

Then, reach via below URLs:

```bash
echo "https://${CODESPACE_NAME}-80.app.github.dev/"
```

### Cleanup

```bash
# delete the release
helm uninstall my-app
```

## Add the function called `id`

### Implement the function

Create a file with the name `_helpers.tpl` in the folder `my-chart/templates`:

```bash
/bin/cat <<EOF > my-chart/templates/_helpers.tpl
{{- define "id" }}
{{- printf "%s-%s" .Chart.Name .Release.Name }}
{{- end }}
EOF
```

### Make use of the `id` function

Replace all occurancies in the directory `my-chart/templates` of `{{ .Chart.Name }}-{{ .Release.Name }}` with `{{ template "id" . }}`

```bash
sed -i 's/{{ .Chart.Name }}-{{ .Release.Name }}/{{ template "id" . }}/g' ./my-chart/templates/*
```

### Release the application

```bash
helm install helper-functions ./my-chart
```

Wait until the pods are ready

```bash
kubectl wait pod -l app=my-chart-helper-functions --for=condition=ready --timeout=120s
```

Access the endpoint via

```bash
curl http://${INGRESS_IP}
```

> Note the output now gets calculated via the `id` function defined in the file `_helpers.tpl`. The expected output is `my-chart-helper-functions`

If you want to reach it via browser, you first need to port-forward ingress-nginx-controller service:

```bash
kubectl port-forward svc/ingress-nginx-controller -n ingress-nginx 80
```

Then, reach via below URLs:

```bash
echo "https://${CODESPACE_NAME}-80.app.github.dev/"
```

## Cleanup again

```bash
# delete the resources
helm uninstall helper-functions
```

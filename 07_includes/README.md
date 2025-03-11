# Using the 'include' Function

In this task, you will make use of include' function.

> `INGRESS_IP` environment variable is supposed to be set during the setup. You can always set it this way:
>
> ```bash
> export INGRESS_IP=$(kubectl get svc ingress-nginx-controller -n ingress-nginx -o jsonpath='{.status.loadBalancer.ingress[].ip}')
> ```

## Inspect the Helm Chart

```bash
cd /workspaces/helm/07_includes
tree .
```

## Implement the labels function

Add the following function called `labels` into the file `_helpers.tpl` in the folder `my-chart/templates`

```bash
/bin/cat <<EOF >> my-chart/templates/_helpers.tpl

{{- define "labels" -}}
helm.sh/chart: {{ .Chart.Name | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service | quote }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/name: {{ .Chart.Name | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
{{- end }}
EOF
```

## Make use of the `labels` function in your template files

Take care of the right indent, eg `{{- include "labels" . | nindent 2 }}`.

For example, edit `my-chart/templates/deployment.yaml` and add labels to the metadata:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: { { template "id" . } }
  labels: { { - include "labels" . | nindent 2 } }
spec:
  replicas: 1
```

You can dry-run the installation:

```bash
helm install includes ./my-chart --dry-run
```

You can check how the manifests look and verify if the indentation is correct with `helm template` command:

```bash
helm template ./my-chart
```

## Release the application

```bash
helm install includes --set id=includes ./my-chart
```

Wait until the pods are ready

```bash
kubectl wait pod -l app=includes --for=condition=ready --timeout=120s
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

## Cleanup

```bash
# delete the resources
helm uninstall includes
```

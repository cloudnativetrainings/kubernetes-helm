# Helm Test

In this task, you will learn how to test your Chart.

## Inspect the application

See the chart files. This one includes a test directory:

```bash
cd /workspaces/kubernetes-helm/10_tests
tree .
```

## Inspect the test

A Kubernetes Job to check if the App responds successfully:

```bash
cat ./my-app/templates/tests/test-my-app.yaml
```

## Release the app

```bash
# [Terminal-2] watch pods in a second bash
watch -n 1 kubectl get pods

# release the helm chart
helm install my-app ./my-app
```

### Wait until the pods are ready

```bash
kubectl wait pod -l app=my-app --for=condition=ready --timeout=120s
```

### Run the test

```bash
helm test my-app
```

## Verify failing test

### Add a bug in the templates

```yaml
apiVersion: v1
kind: Service
metadata:
  name: wrong-service-name
```

### Release the chart again

```bash
helm upgrade my-app ./my-app/
```

### Test the release

```bash
helm test my-app
```

> Note that the test is failing because the service is not reachable from the curl command of the test.

### Check the logfile of the test

```bash
kubectl logs -l job-name=my-app-test
```

## Cleanup

```bash
# delete the resources
helm uninstall my-app
kubectl delete job my-app-test
```

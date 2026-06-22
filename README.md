# Kubernetes Helm

## Setup the training environment

1. Open [Github Codespaces](https://github.com/codespaces) and create your new `cloudnativetrainings/kubernetes-helm` codespace.
1. Run `source /root/.trainingrc`
1. Verify your environment via `make verify`.
1. Open a new bash and ensure port-forwarding to the ingress controller is running via `kubectl port-forward svc/ingress-nginx-controller -n ingress-nginx 8080:80`. Keep this bash running all the time.
1. Start with the [01_apps-with-only-manifests](./01_apps-with-only-manifests/README.md) lab.

## Teardown the training environment

1. Delete your `cloudnativetrainings/kubernetes-helm` codespace via [Github Codespaces](https://github.com/codespaces).

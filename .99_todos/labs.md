# labs

## atomic releases

helm upgrade --install cilium cilium \
 --atomic --wait --debug \

## idempotent

helm upgrade --install

## helm chart verification

https://www.douglashellinger.com/how-to/proxy-public-chart-repositories-as-oci-artefacts/
https://kodekloud.com/blog/package-sign-and-verify-charts/
https://helm.sh/docs/topics/provenance/

## Input from Archana for new labs

Create and package helm charts. Use OCI registry
Helm Templates
Chart security - sign and verify charts.

## {{ vs { {

verify no whitespaces are in there

## test lab

use job instead of pod for testing

## setup

move $INGRESS_IP into ~/.trainingrc

.PHONY: verify
verify:
	docker --version
	kind --version
	kubectl version --client
	helm version
	kustomize version
	echo "Training Environment successfully verified"

.PHONY: verify-cluster
verify-cluster: 
	./pre-checks.sh

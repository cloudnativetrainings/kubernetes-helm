.PHONY: verify
verify:
	test -f /root/.trainingrc
	grep "source /root/.trainingrc" /root/.bashrc
	docker --version
	kind --version
	kubectl version --client
	kubectx
	kubens
	helm version
	kustomize version
	echo "Training Environment successfully verified"

.PHONY: verify-cluster
verify-cluster: 
	./pre-checks.sh
